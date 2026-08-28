-------------------------------------------------------------------------------
-- 社团 - 社团列表界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-20 20:04:39
-------------------------------------------------------------------------------

local ClubListUnitDojo = import('Game.Dojo.Club.ClubListUnitDojo')
local ClubListCellPath = 'Game.UI.Club.UIOverseaClubListClubCell'
local ClubListCellName = 'Cell'

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubListDialog.prefab
---@class UIOverseaClubListDialog
---@field Env                           	UIOverseaClubListDialog                 
---@field controller                    	Engine.UI.UILuaDialog                   
---@field createBtn                     	UnityEngine.RectTransform               @ 创建按钮
---@field searchBtn                     	UnityEngine.RectTransform               @ 搜搜按钮
---@field searchInput                   	UnityEngine.UI.InputField               @ 搜搜输入框
---@field clubList                      	SuperScrollView.LoopListView2           @ 社团列表
---@field clubEmpty                     	UnityEngine.RectTransform               @ 列表空节点
---@field refreshBtn                    	UnityEngine.RectTransform               @ 刷新按钮
local UIOverseaClubListDialog = Class('UIOverseaClubListDialog')


function UIOverseaClubListDialog:__init()
end


function UIOverseaClubListDialog:__delete()
end


function UIOverseaClubListDialog:Awake()
    SetButtonAction(self.refreshBtn, Bind(self, self.OnClickRefreshButtonHandler_))
    SetButtonAction(self.searchBtn, Bind(self, self.OnClickSearchButtonHandler_))
    SetButtonAction(self.createBtn, Bind(self, self.OnClickCreateButtonHandler_))
    SetListViewAction(self.clubList, Bind(self, self.OnUpdateClubListCellHandler_), ClubListCellName)
    self.joinSuccedEventCB_ = Events.AddListener(ClubUtils.EventName.JOIN_SUCCED, Bind(self, self.OnClubJoinSuccedHandler_))
end


function UIOverseaClubListDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
    end)
end


function UIOverseaClubListDialog:OnFinalize()
    return CoWaitDo(function()
        Events.RemoveListener(ClubUtils.EventName.JOIN_SUCCED, self.joinSuccedEventCB_)
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


function UIOverseaClubListDialog:OnShow()
    return CoWaitDo(function()
        self:RequestClubListData_()
    end)
end


-------------------------------------------------
-- get / set

---@return ClubListUnitDojo[]
function UIOverseaClubListDialog:GetClubListData()
    return checkTable(self.clubListData_)
end
function UIOverseaClubListDialog:SetClubListData(listData)
    self.clubListData_ = checkTable(listData)
    self:UpdateClubList_()
end


-------------------------------------------------
-- private

---@param searchWords string | nil
function UIOverseaClubListDialog:RequestClubListData_(searchWords)
    local requestData = {keyword = searchWords}
    GameUtils.Request(Interfaces.OverseaClubListSearch, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            local clubListData = {}
            for dataIndx, clubData in ipairs(responseData.clubs or {}) do
                local unitDojo = ClubListUnitDojo.New()
                unitDojo:Fill(clubData)
                clubListData[dataIndx] = unitDojo
            end
            self:SetClubListData(clubListData)
        end
    end)
end


function UIOverseaClubListDialog:UpdateClubList_()
    local listDataLegnth = #self:GetClubListData()
    CfUtils.SetActive(self.clubEmpty, listDataLegnth <= 0)
    GameUtils.ReloadData(self.clubList, listDataLegnth)
end


-------------------------------------------------
-- handler

function UIOverseaClubListDialog:OnClickRefreshButtonHandler_()
    local refreshSeconds   = ClubUtils.GetParamValue(ClubUtils.ParamsId.REFRESH_CLUB_CD)
    local refreshDataKey   = Constants.PlayerPrefsType.ClubListRefreshTimestamp
    local refreshTimestamp = checkInt(CfUtils.GetLocalData(refreshDataKey))
    local currentTimestamp = os.time()
    local leftClickSeconds = refreshTimestamp + refreshSeconds - currentTimestamp
    if leftClickSeconds > 0 then
        GameUtils.Toast(localize('_num_秒后可以再次刷新', {_num_ = leftClickSeconds}))
    else
        CfUtils.WriteLocalData(refreshDataKey, currentTimestamp)
        self:RequestClubListData_()
    end
end


function UIOverseaClubListDialog:OnClickSearchButtonHandler_()
    local searchText = self.searchInput.text
    if string.isEmpty(searchText) then
        self:RequestClubListData_()
    else
        self:RequestClubListData_(searchText)
    end
end


function UIOverseaClubListDialog:OnClickCreateButtonHandler_()
    CfUtils.DialogOpen(Constants.UITypeIds.UIOverseaClubCreatePopup)
end


---@param listView SuperScrollView.LoopListView2
---@param luaIndex integer
---@return SuperScrollView.LoopListViewItem2
function UIOverseaClubListDialog:OnUpdateClubListCellHandler_(listView, luaIndex)
    local cellNode = listView:NewListViewItem(ClubListCellName)
    local cellData = self:GetClubListData()[luaIndex]
    ---@type UIOverseaClubListClubCell
    local cellEnv = CfUtils.GetLuaScr(cellNode, ClubListCellPath)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
        cellEnv:SetClickApplyCB(Bind(self, self.OnClickClubListCellApplyButtonCallback_))
        cellEnv:SetClickInfoTipsCB(Bind(self, self.OnClickClubListCellInfoTipsAreaCallback_))

        if listView.DisplayItemNumber < listView.DisplayItemCount then
            cellEnv:PlayDelayAnimByShow(listView.DisplayItemNumber)
            listView.DisplayItemNumber = listView.DisplayItemNumber + 1
        else
            cellEnv:PlayAnimByIdle()
        end
    end
    return cellNode
end


function UIOverseaClubListDialog:OnClickClubListCellApplyButtonCallback_(luaIndex)
    ---@type ClubListUnitDojo
    local unitDojo = self:GetClubListData()[luaIndex] or {}
    local clubComp = ClubUtils.GetClubComp()

    if unitDojo.isApplied then
        GameUtils.Toast(localize('已发送申请，请耐心等待'))
        return
    end

    if unitDojo.applyLevel > GameUtils.GetPlayerLevel() then
        GameUtils.Toast(localize('未达到申请要求等级'))
        return
    end

    local leftJoinSeconds = clubComp:GetQuitTimestamp() - os.time()
    if leftJoinSeconds > 0 then
        GameUtils.Toast(localize('还有_time_才能加入社团', {_time_ = CfUtils.GetTimeHMS10(leftJoinSeconds)}))
        return
    end

    local clubLevelVo = ClubUtils.GetLevelVo(unitDojo.level)
    if checkInt(unitDojo.members) >= checkInt(clubLevelVo.members) then
        GameUtils.Toast(localize('社团已经满员'))
        return
    end
    
    local requestData = {clubId = unitDojo.clubId}
    GameUtils.Request(Interfaces.OverseaClubApply, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)

            -- update data cache
            unitDojo.isApplied = true

            -- update cell state
            local cellNode = self.clubList:GetShownItemByItemIndex(luaIndex - 1)
            if isNotNull(cellNode) then
                ---@type UIOverseaClubListClubCell
                local cellEnv = CfUtils.GetLuaScr(cellNode, ClubListCellPath)
                cellEnv:SetApplied(true)
            end

            if unitDojo.applyType == ClubUtils.ApplyType.FREE then
                -- init clubData
                clubComp:InitialClubData({clubId = requestData.clubId})
                -- open clubHome
                self:OnClubJoinSuccedHandler_()
            else
                GameUtils.Toast(localize('已发送申请，请等级审核'))
            end
        end
    end)
end


function UIOverseaClubListDialog:OnClickClubListCellInfoTipsAreaCallback_(luaIndex)
    local cellData = self:GetClubListData()[luaIndex]
    CfUtils.DialogOpen(Constants.UITypeIds.UIOverseaClubOverallInformationAddDialog, {clubListUnitDojo = cellData})
end


function UIOverseaClubListDialog:OnClubJoinSuccedHandler_()
    CfUtils.StartCoroutineWithBlocker(function()
        CoYield(CfUtils.DialogClose(self.controller))
        -- AppService:GetInstance():SendTcpData(Constants.Packets.OverseaClubEnter)
        CoYield(CfUtils.DialogOpen(Constants.UITypeIds.UIOverseaClubHallDialog, nil, {UIArgs(Constants.UITypeIds.UIHomeView)}))
    end)
end


return UIOverseaClubListDialog
