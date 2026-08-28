-------------------------------------------------------------------------------
-- 海外图鉴 - 名词百科（组织势力、专有名词）
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-08-20 21:42:20
-------------------------------------------------------------------------------

---@type IllustratedHandbookComponent
local illustratedHandbookComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.IllustratedHandbookComponent)

local ENCY_TAG_NAME = {
    [Constants.HandbookEncyclopediaTag.CAMP] = localize('组织势力'),
    [Constants.HandbookEncyclopediaTag.WORD] = localize('专有名词'),
}

local RelationCellPath = 'Game.UI.IllustratedHandbook.IllustratedHandbookProperNounWordCell'
local NameListCellPath = 'Game.UI.IllustratedHandbook.IllustratedHandbookProperNounNameCell'
local NameListCellName = 'Cell'

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/IllustratedHandbook/IllustbookProperNounDialog.prefab
---@class IllustratedHandbookProperNounDialog
---@field Env                           	IllustratedHandbookProperNounDialog     
---@field controller                    	Engine.UI.UILuaDialog                   
---@field relatedWordNode               	UnityEngine.RectTransform               @ 关联词节点
---@field relatedScrollContent          	UnityEngine.RectTransform               @ 关联词滚动容器
---@field relatedScrollView             	UnityEngine.RectTransform               @ 关联词滚动节点
---@field relatedWordsNode              	UnityEngine.RectTransform               @ 关联词根节点
---@field descrNodeDescrTxt             	UnityEngine.RectTransform               @ 描述节点描述文本
---@field descrNodeTitleTxt             	UnityEngine.RectTransform               @ 描述节点标题文本
---@field descrScrollNode               	UnityEngine.RectTransform               @ 描述内容节点
---@field descrScrollContent            	UnityEngine.RectTransform               @ 描述滚动容器
---@field descrScrollView               	UnityEngine.RectTransform               @ 描述滚动节点
---@field titleNameTxt                  	UnityEngine.RectTransform               @ 标题名字文本
---@field titleIconImg                  	UnityEngine.RectTransform               @ 标题图标节点
---@field titleIconNode                 	UnityEngine.RectTransform               @ 标题图标容器
---@field nameListView                  	SuperScrollView.LoopListView2           @ 百科名列表节点
local IllustratedHandbookProperNounDialog = Class('IllustratedHandbookProperNounDialog')


function IllustratedHandbookProperNounDialog:__init()
    ---@type table<integer, IllustratedHandbookKeywordEncyDojo[]>
    self.encyIdListMap_ = {}
    ---@type table<integer, integer[]>
    self.encyIdIndexMap_ = {}
end


function IllustratedHandbookProperNounDialog:__delete()
    self.encyIdListMap_  = nil
    self.encyIdIndexMap_ = nil
end


function IllustratedHandbookProperNounDialog:Awake()
    SetListViewAction(self.nameListView, Bind(self, self.OnUpdateNameListCellHandler_))
end


function IllustratedHandbookProperNounDialog:OnFocus()
    CfUtils.SetNavigatorBarCustomTitle(ENCY_TAG_NAME[self:GetEncyTag()])
end


function IllustratedHandbookProperNounDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}

        -- init encyIdList
        for _, encyDojo in pairs(illustratedHandbookComp:GetKeywordsEncyDojoMap()) do
            local encyTag = checkInt(encyDojo.encyVo.encyTag)
            if not self.encyIdListMap_[encyTag] then
                self.encyIdListMap_[encyTag] = {}
            end
            table.insert(self.encyIdListMap_[encyTag], encyDojo)
        end

        for _, encyDojoList in pairs(self.encyIdListMap_) do
            -- sort encyIdList
            ---@param aEncyDojo IllustratedHandbookKeywordEncyDojo
            ---@param bEncyDojo IllustratedHandbookKeywordEncyDojo
            table.sort(encyDojoList, function(aEncyDojo, bEncyDojo)
                return aEncyDojo.encyVo.encyId < bEncyDojo.encyVo.encyId
            end)

            -- init encyIndexMap
            for encyIndex, encyDojo in ipairs(encyDojoList) do
                local encyId  = checkInt(encyDojo.encyVo.encyId)
                local encyTag = checkInt(encyDojo.encyVo.encyTag)
                if not self.encyIdIndexMap_[encyTag] then
                    self.encyIdIndexMap_[encyTag] = {}
                end
                self.encyIdIndexMap_[encyTag][tostring(encyId)] = encyIndex
            end
        end

        -- default encyTag
        self:SetEncyTag(initParams.encyTag)
        self:OnClickNameListCellNameCellCallback_(1)
    end)
end


function IllustratedHandbookProperNounDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return Constants.HandbookEncyclopediaTag
function IllustratedHandbookProperNounDialog:GetEncyTag()
    return checkInt(self.encyTag_)
end
function IllustratedHandbookProperNounDialog:SetEncyTag(encyTag)
    self.encyTag_ = checkInt(encyTag)
    self:SetEncyDojoList(self.encyIdListMap_[self:GetEncyTag()])
    CfUtils.SetNavigatorBarCustomTitle(ENCY_TAG_NAME[self:GetEncyTag()])
end


---@return IllustratedHandbookKeywordEncyDojo[]
function IllustratedHandbookProperNounDialog:GetEncyDojoList()
    return checkTable(self.encyDojoList_)
end
function IllustratedHandbookProperNounDialog:SetEncyDojoList(dataList)
    self.encyDojoList_ = checkTable(dataList)
    self:UpdateEncyNameListView_()
end


---@return integer
function IllustratedHandbookProperNounDialog:GetNameSelectIndex()
    return checkInt(self.nameSelectIndex_)
end
function IllustratedHandbookProperNounDialog:SetNameSelectIndex(index)
    local oldSelectIndex = self:GetNameSelectIndex()
    local newSelectIndex = checkInt(index)
    self.nameSelectIndex_ = newSelectIndex
    self:UpdateEncyNameListSelected_(oldSelectIndex, newSelectIndex)
end


-------------------------------------------------
-- private

function IllustratedHandbookProperNounDialog:UpdateEncyNameListView_()
    local listDataLegnth = #self:GetEncyDojoList()
    GameUtils.ReloadData(self.nameListView, listDataLegnth)
end


---@param oldSelectIndex integer
---@param newSelectIndex integer
function IllustratedHandbookProperNounDialog:UpdateEncyNameListSelected_(oldSelectIndex, newSelectIndex)
    local oldCellNode = self.nameListView:GetShownItemByItemIndex(oldSelectIndex - 1)
    local newCellNode = self.nameListView:GetShownItemByItemIndex(newSelectIndex - 1)
    if isNotNull(oldCellNode) then
        ---@type IllustratedHandbookProperNounNameCell
        local oldCellEnv = CfUtils.GetLuaScr(oldCellNode, NameListCellPath)
        oldCellEnv:SetSelected(false)
    end
    if isNotNull(newCellNode) then
        ---@type IllustratedHandbookProperNounNameCell
        local oldCellEnv = CfUtils.GetLuaScr(newCellNode, NameListCellPath)
        oldCellEnv:SetSelected(true)
        oldCellEnv:SetNewMark(false)
    end
end


---@param encyDojo IllustratedHandbookKeywordEncyDojo
function IllustratedHandbookProperNounDialog:UpdateEncyContentInfo_(encyDojo)
    ---@type IllustratedEncyKeywordVo
    local encyVo = checkTable(encyDojo).encyVo

    -- update icon
    if encyVo and not string.isEmpty(encyVo.icon) then
        CfUtils.SetActive(self.titleIconNode, true)
        CfUtils.FillImage(self.titleIconImg, encyVo.icon)
    else
        CfUtils.SetActive(self.titleIconNode, false)
    end

    -- update title
    CfUtils.FillText(self.titleNameTxt, encyVo and encyVo.name or '')
    
    -- update descr
    CfUtils.FillText(self.descrNodeDescrTxt, encyVo and encyVo.descr or '')

    -- update relations
    local relations = checkTable(encyVo.relations)
    ---@param luaIndex integer
    ---@param childNode UnityEngine.RectTransform
    GameUtils.ResizeContent(self.relatedScrollContent, self.relatedWordNode, #relations, function(luaIndex, childNode)
        local encyId   = checkInt(relations[luaIndex])
        local encyDojo = illustratedHandbookComp:GetKeywordsEncyDojoMap()[tostring(encyId)]
        ---@type IllustratedHandbookProperNounWordCell
        local cellEnv  = CfUtils.GetLuaScr(childNode, RelationCellPath)
        if isNotNull(cellEnv) then
            cellEnv:SetLuaIndex(luaIndex)
            cellEnv:SetCellData(encyDojo)
            cellEnv:SetClickCellCB(Bind(self, self.OnClickEncyRelationCellCallback_))
        end
    end)

    -- clear newMark
    if encyVo and encyDojo.isNewMark then
        illustratedHandbookComp:ClearKeywordEncyNewMark(encyVo.encyId)
    end
end


-------------------------------------------------
-- handler

---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer
---@return SuperScrollView.LoopListViewItem2
function IllustratedHandbookProperNounDialog:OnUpdateNameListCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(NameListCellName)
    local cellData = self:GetEncyDojoList()[luaIndex]
    ---@type IllustratedHandbookProperNounNameCell
    local cellEnv = CfUtils.GetLuaScr(cellNode, NameListCellPath)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
        cellEnv:SetClickCellCB(Bind(self, self.OnClickNameListCellNameCellCallback_))
        cellEnv:SetSelected(self:GetNameSelectIndex() == luaIndex)
    end
    return cellNode
end


---@param luaIndex integer
function IllustratedHandbookProperNounDialog:OnClickNameListCellNameCellCallback_(luaIndex)
    local encyDojo = self:GetEncyDojoList()[luaIndex]
    if not encyDojo.isUnlock then return end

    if self:GetNameSelectIndex() == luaIndex then
        return
    end

    -- 更新选择的位置
    self:SetNameSelectIndex(luaIndex)

    -- 刷新内容面板
    self:UpdateEncyContentInfo_(encyDojo)
end


---@param luaIndex integer
---@param encyDojo IllustratedHandbookKeywordEncyDojo
function IllustratedHandbookProperNounDialog:OnClickEncyRelationCellCallback_(luaIndex, encyDojo)
    if not encyDojo.isUnlock then return end

    local encyId  = encyDojo.encyVo.encyId
    local encyTag = encyDojo.encyVo.encyTag
    if encyTag ~= self:GetEncyTag() then
        self:SetEncyTag(encyTag)
    end
    
    -- 更新选择的位置
    local encyIdIndexMap = checkTable(self.encyIdIndexMap_[encyTag])
    self:SetNameSelectIndex(encyIdIndexMap[tostring(encyId)])

    -- 刷新内容面板
    self:UpdateEncyContentInfo_(encyDojo)

    -- 名字列表滚动到指定位置
    self.nameListView:MovePanelToItemIndex(self:GetNameSelectIndex() - 1)
end


return IllustratedHandbookProperNounDialog
