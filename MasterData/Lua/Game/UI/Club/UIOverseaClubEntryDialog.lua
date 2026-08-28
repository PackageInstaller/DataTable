-------------------------------------------------------------------------------
-- 社团 - 社团主界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-20 20:13:13
-------------------------------------------------------------------------------

local CREATE_BLOCK_KEY = 'UIOverseaClubEntryDialog.CREATE_BLOCK_KEY'
local TabGridCellPath  = 'Game.UI.Club.UIOverseaClubEntryTabGridCell'
local TabGridCellName  = 'ToggleCellNode1'

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubEntryDialog.prefab
---@class UIOverseaClubEntryDialog
---@field Env                           	UIOverseaClubEntryDialog                
---@field controller                    	Engine.UI.UILuaDialog                   
---@field tabGridView                   	SuperScrollView.LoopGridView            @ 切换页网格列表
---@field containerNode                 	UnityEngine.RectTransform               @ 内容页容器
local UIOverseaClubEntryDialog = Class('UIOverseaClubEntryDialog')


function UIOverseaClubEntryDialog:__init()
    ---@type UnityEngine.Coroutine
    self.createNodeCo_ = nil
    ---@type table<integer, UnityEngine.GameObject>
    self.tabPanelMap_ = {}
end


function UIOverseaClubEntryDialog:__delete()
    self.createNodeCo_ = nil
    self.tabPanelMap_  = nil
end


function UIOverseaClubEntryDialog:Awake()
    SetGridViewAction(self.tabGridView, Bind(self, self.OnUpdateTagGridCellHandler_))
end


function UIOverseaClubEntryDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = CfUtils.DialogSafeParameters(self.controller)

        -- init tabDataList
        local tabDataList = {
            {
                name    = localize('信息'),
                bgPath  = 'UIAtlas/OverClub/Main/club_tab_btn_1.png',
                prefabe = 'Prefabs/OverClub/OverseaClubOverallInformationDialog.prefab',
                srcPath = 'Game.UI.Club.UIOverseaClubEntryInformationPanel',
            },
            {
                name      = localize('成员'),
                bgPath    = 'UIAtlas/OverClub/Main/club_tab_btn_2.png',
                prefabe   = 'Prefabs/OverClub/OverseaClubMemberInformationDialog.prefab',
                srcPath   = 'Game.UI.Club.UIOverseaClubEntryMembersPanel',
                redPoint  = Constants.RedPointConst.ClubMembers,
                redBindCb = function(cellEnv)
                    ---@param redPointDojo RedPointDojo
                    GameUtils.BindRedPoint(Constants.RedPointConst.ClubMembers, true, true, nil, function(redPointDojo)
                        cellEnv:SetShowRedPoint(redPointDojo.pointNum > 0)
                    end)
                end,
            },
        }
        self:SetTabDataList(tabDataList)

        -- default select first
        self:SetTabSelectIndex(initParams.tabSelectIndex or 1)
    end)
end


function UIOverseaClubEntryDialog:OnFinalize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        initParams.tabSelectIndex = self:GetTabSelectIndex()

        for _, tabData in ipairs(self:GetTabDataList()) do
            if tabData.redPoint then
                GameUtils.RemoveRedPointCallBack(tabData.redPoint)
            end
        end

        if self.createNodeCo_ then
            CoStop(self.createNodeCo_)
            self.createNodeCo_ = nil
        end

        CfUtils.ConditionRemove(CREATE_BLOCK_KEY)
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return table[]
function UIOverseaClubEntryDialog:GetTabDataList()
    return checkTable(self.tabDataList_)
end
function UIOverseaClubEntryDialog:SetTabDataList(dataList)
    self.tabDataList_ = checkTable(dataList)
    self:UpdateTabGridView_()
end


---@return integer
function UIOverseaClubEntryDialog:GetTabSelectIndex()
    return checkInt(self.tabSelectIndex_)
end
function UIOverseaClubEntryDialog:SetTabSelectIndex(index)
    local oldTabSelectIndex = self:GetTabSelectIndex()
    local newTabSelectIndex = checkInt(index)
    self.tabSelectIndex_    = newTabSelectIndex
    self:UpdateHeadGridSelected_(oldTabSelectIndex, newTabSelectIndex)
    self:SwitchContainerPanel_(oldTabSelectIndex, newTabSelectIndex)
end


-------------------------------------------------
-- private

function UIOverseaClubEntryDialog:UpdateTabGridView_()
    local gridDataLength = #self:GetTabDataList()
    GameUtils.ReloadData(self.tabGridView, gridDataLength)
end


---@param oldSelectIndex integer
---@param newSelectIndex integer
function UIOverseaClubEntryDialog:UpdateHeadGridSelected_(oldSelectIndex, newSelectIndex)
    local oldCellNode = self.tabGridView:GetShownItemByItemIndex(oldSelectIndex - 1)
    local newCellNode = self.tabGridView:GetShownItemByItemIndex(newSelectIndex - 1)
    -- unselect old
    if isNotNull(oldCellNode) then
        ---@type UIOverseaClubEntryTabGridCell
        local oldCellEnv = CfUtils.GetLuaScr(oldCellNode, TabGridCellPath)
        oldCellEnv:SetSelected(false)
    end
    -- selected new
    if isNotNull(newCellNode) then
        ---@type UIOverseaClubEntryTabGridCell
        local oldCellEnv = CfUtils.GetLuaScr(newCellNode, TabGridCellPath)
        oldCellEnv:SetSelected(true)
    end
end


---@param oldSelectIndex integer
---@param newSelectIndex integer
function UIOverseaClubEntryDialog:SwitchContainerPanel_(oldSelectIndex, newSelectIndex)
    if oldSelectIndex == newSelectIndex then return end
    local oldPanelData = self.tabPanelMap_[oldSelectIndex]
    local newPanelData = self.tabPanelMap_[newSelectIndex]

    -- hide old panel
    if isNotNull(oldPanelData) then
        CfUtils.SetCanvasEnabled(oldPanelData.go, false)
        local tabPanelLuaEnv  = oldPanelData.src
        if not tabPanelLuaEnv then return end
        if tabPanelLuaEnv.OnHide then
            tabPanelLuaEnv:OnHide()
        end
    end

    if isNull(newPanelData) then
        -- create new panel
        self:CreateContainerPanel_(newSelectIndex)

    else
        -- show new panel
        CfUtils.SetCanvasEnabled(newPanelData.go, true)
        
        -- update new panel
        self:UpdateContainerPanel_(newSelectIndex)
    end
end


function UIOverseaClubEntryDialog:CreateContainerPanel_(tabDataIndex)
    self.createNodeCo_ = CoStart(function()
        local tabData     = self:GetTabDataList()[tabDataIndex]
        local createIndex = tabDataIndex
        local prefabePath = tabData.prefabe
        local luaEnvPath  = tabData.srcPath
        
        CfUtils.ConditionAppend(CREATE_BLOCK_KEY)
        local panelNodeGo  = GameUtils.LoadBundleAsync(prefabePath, self.containerNode.gameObject, false)
        local panelNodeEnv = CfUtils.GetLuaScr(panelNodeGo, luaEnvPath)
        self.tabPanelMap_[createIndex] = {go = panelNodeGo, src = panelNodeEnv}
        CfUtils.ConditionRemove(CREATE_BLOCK_KEY)
        self.createNodeCo_ = nil

        local initParams = self.controller.Argument.parameters or {}
        panelNodeEnv:SetInitParams(initParams,self.controller)
        panelNodeEnv:SetOnStartCB(function(initParams)
            self:UpdateContainerPanel_(createIndex)
        end)
    end)
end


function UIOverseaClubEntryDialog:UpdateContainerPanel_(tabDataIndex)
    local tabPanelData = self.tabPanelMap_[tabDataIndex]
    if not tabPanelData then return end
    
    local tabPanelLuaEnv  = tabPanelData.src
    if not tabPanelLuaEnv then return end

    if tabPanelLuaEnv.RefreshPanel then
        tabPanelLuaEnv:RefreshPanel()
    end
end


-------------------------------------------------
-- handler

---@param gridView SuperScrollView.LoopGridView
---@param luaIndex integer
---@return SuperScrollView.LoopGridViewItem
function UIOverseaClubEntryDialog:OnUpdateTagGridCellHandler_(gridView, luaIndex)
    local cellNode = gridView:NewListViewItem(TabGridCellName)
    local cellData = self:GetTabDataList()[luaIndex]
    ---@type UIOverseaClubEntryTabGridCell
    local cellEnv = CfUtils.GetLuaScr(cellNode, TabGridCellPath)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
        cellEnv:SetClickCellCB(Bind(self, self.OnClickHeadGridCellCallback_))
        -- update state
        cellEnv:SetSelected(self:GetTabSelectIndex() == luaIndex)
        -- bind redPoint
        if cellData.redBindCb then
            cellData.redBindCb(cellEnv)
        else
            cellEnv:SetShowRedPoint(false)
        end
    end
    return cellNode
end


function UIOverseaClubEntryDialog:OnClickHeadGridCellCallback_(luaIndex)
    if self:GetTabSelectIndex() ~= luaIndex then
        self:SetTabSelectIndex(luaIndex)
    end
end


return UIOverseaClubEntryDialog
