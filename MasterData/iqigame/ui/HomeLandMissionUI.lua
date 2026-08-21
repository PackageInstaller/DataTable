-- chunkname: @IQIGame\\UI\\HomeLandMissionUI.lua

local CommonReturnBtn = require("IQIGame/UI/Common/CommonReturnBtn")
local HomeLandTaskScrollAreaListItem = require("IQIGame/UI/Home/HomeLandTaskScrollAreaListItem")
local HomeLandTaskRightView = require("IQIGame/UI/Home/HomeLandTaskRightView")
local HomeLandTaskSelectRoleBag = require("IQIGame/UI/Home/HomeLandTaskSelectRoleBag")
local MsgBox = {}

function MsgBox.New(view, cancelHandler, confirmHandler)
	local obj = Clone(MsgBox)

	obj:__Init(view, cancelHandler, confirmHandler)

	return obj
end

function MsgBox:__Init(view, cancelHandler, confirmHandler)
	self.gameObject = view
	self.cancelHandler = cancelHandler
	self.confirmHandler = confirmHandler

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:__OnInitEventDelegateFunc()
	self:__OnAddListeners()
end

function MsgBox:__OnInitEventDelegateFunc()
	function self.__delegateOnCancelBtnClick()
		self:Hide()

		if self.cancelHandler == nil then
			return
		end

		self.cancelHandler()
	end

	function self.__delegateOnConfirmBtnClick()
		self:Hide()

		if self.confirmHandler == nil then
			return
		end

		self.confirmHandler()
	end
end

function MsgBox:__OnAddListeners()
	self.cancelBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnCancelBtnClick)
	self.confirmBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnConfirmBtnClick)
end

function MsgBox:__OnRemoveListeners()
	self.cancelBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnCancelBtnClick)
	self.confirmBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnConfirmBtnClick)
end

function MsgBox:Show(costNum, ownerNum)
	self.gameObject:SetActive(true)

	self.costNum:GetComponent("Text").text = tostring(costNum)
	self.ownerNum:GetComponent("Text").text = tostring(ownerNum)
end

function MsgBox:Hide()
	self.gameObject:SetActive(false)
end

function MsgBox:Dispose()
	self:__OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local HomeLandMissionUI = {
	selectTaskCid = 0,
	taskAreaItemList = {},
	dispTaskList = {}
}

HomeLandMissionUI = Base:Extend("HomeLandMissionUI", "IQIGame.Onigao.UI.HomeLandMissionUI", HomeLandMissionUI)

function HomeLandMissionUI:OnInit()
	self:__OnInitEventDelegateFunc()

	self.moneyCell = CurrencyCell.New(self.moneyTopRoot)
	self.commonReturnBtn = CommonReturnBtn.New(self.commonReturnBtn, self)

	self:__OnInitTaskAreaList()

	self.msgBox = MsgBox.New(self.msgPopup, nil, self.__delegateOnConfirmRefreshTask)

	self.msgBox:Hide()

	self.taskRightView = HomeLandTaskRightView.New(self.rightViewRoot)
	self.taskRightView.OnShowHeroBagEvent = self.__delegateOnShowRoleBag
	self.roleBag = HomeLandTaskSelectRoleBag.New(self.roleWarehouseRoot)
	self.roleBag.ItemSelectEvent = self.__delegateOnRoleBagItemClick
end

function HomeLandMissionUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandMissionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandMissionUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandMissionUI:GetBGM(userData)
	return nil
end

function HomeLandMissionUI:OnOpen(userData)
	self.moneyCell:RefreshItem(Constant.TopMoneyType.HomeLandMissionUI)
	self.roleBag:Hide()
	self.msgBox:Hide()
	self:__OnRefreshTaskListShow()
	self:__RefreshTaskRefreshCount()
	self:__InitTaskRefreshTime()
	self:__InitTimer()
end

function HomeLandMissionUI:OnClose(userData)
	self:__StopTimer()
end

function HomeLandMissionUI:__OnInitEventDelegateFunc()
	function self.__OnRefreshBtnClickEventProxy()
		self:__OnRefreshBtnClickEvent()
	end

	function self.__OnOneKeySendBtnClickEventProxy()
		return
	end

	function self.__OnOneKeyGetBtnClickEventProxy()
		return
	end

	function self.__delegateOnShowRoleBag(_roleCid)
		self:__OnShowRoleBag(_roleCid)
	end

	function self.__delegateOnRoleBagItemClick(_itemData)
		self:__OnRoleBagItemClick(_itemData)
	end

	function self.__delegateOnHomeDispTaskChange()
		self:__OnHomeDispTaskChange()
	end

	function self.__delegateOnHomeDataChange()
		self:__OnHomeDispTaskChange()
	end

	function self.__delegateOnTimeUpdate()
		self:__OnTimeUpdate()
	end

	function self.__delegateOnConfirmRefreshTask()
		self:__OnConfirmRefreshTask()
	end
end

function HomeLandMissionUI:OnAddListeners()
	self.refreshBtn:GetComponent("Button").onClick:AddListener(self.__OnRefreshBtnClickEventProxy)
	self.oneKeySendBtn:GetComponent("Button").onClick:AddListener(self.__OnOneKeySendBtnClickEventProxy)
	self.oneKeyGetBtn:GetComponent("Button").onClick:AddListener(self.__OnOneKeyGetBtnClickEventProxy)
	EventDispatcher.AddEventListener(EventID.HomeDispTaskChange, self.__delegateOnHomeDispTaskChange)
	EventDispatcher.AddEventListener(EventID.HomeDataChange, self.__delegateOnHomeDataChange)
end

function HomeLandMissionUI:OnRemoveListeners()
	self.refreshBtn:GetComponent("Button").onClick:RemoveListener(self.__OnRefreshBtnClickEventProxy)
	self.oneKeySendBtn:GetComponent("Button").onClick:RemoveListener(self.__OnOneKeySendBtnClickEventProxy)
	self.oneKeyGetBtn:GetComponent("Button").onClick:RemoveListener(self.__OnOneKeyGetBtnClickEventProxy)
	EventDispatcher.RemoveEventListener(EventID.HomeDispTaskChange, self.__delegateOnHomeDispTaskChange)
	EventDispatcher.RemoveEventListener(EventID.HomeDataChange, self.__delegateOnHomeDataChange)
end

function HomeLandMissionUI:OnPause()
	return
end

function HomeLandMissionUI:OnResume()
	return
end

function HomeLandMissionUI:OnCover()
	return
end

function HomeLandMissionUI:OnReveal()
	return
end

function HomeLandMissionUI:OnRefocus(userData)
	return
end

function HomeLandMissionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandMissionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandMissionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandMissionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandMissionUI:OnDestroy()
	self.moneyCell:Dispose()
	self.commonReturnBtn:Dispose()
	self.msgBox:Dispose()
	self:__StopTimer()
	self:__OnDisposeTaskAreaList()
	self.taskRightView:Dispose()
end

function HomeLandMissionUI:__OnHomeDispTaskChange()
	self:__OnRefreshTaskListShow()
	self:__OnRefreshSelectTaskShow()
	self:__RefreshTaskRefreshCount()
end

function HomeLandMissionUI:__OnInitTaskAreaList()
	self.taskAreaList = self.taskScrollView:GetComponent("ScrollAreaList")

	function self.taskAreaList.onRenderCell(cell)
		self:__OnRenderTaskListItem(cell)
	end

	function self.taskAreaList.onSelectedCell(cell)
		self:__OnTaskListItemSelect(cell)
	end
end

function HomeLandMissionUI:__OnDisposeTaskAreaList()
	self.taskAreaList = nil

	ForPairs(self.taskAreaItemList, function(_insID, _taskItem)
		_taskItem:Dispose()
	end)
end

function HomeLandMissionUI:__OnRenderTaskListItem(itemCell)
	local insID = itemCell.gameObject:GetInstanceID()
	local taskItem = self.taskAreaItemList[insID]

	if taskItem == nil then
		taskItem = HomeLandTaskScrollAreaListItem.New(itemCell.gameObject)
		self.taskAreaItemList[insID] = taskItem
	end

	local taskCid = self.dispTaskList[itemCell.index + 1]

	if self.selectTaskCid == 0 then
		self.selectTaskCid = taskCid
	end

	taskItem:Show(taskCid)

	local isSelect = self.selectTaskCid == taskCid

	taskItem:RefreshSelectState(isSelect)

	if isSelect then
		self:__OnRefreshSelectTaskShow()
	end
end

function HomeLandMissionUI:__OnTaskListItemSelect(itemCell)
	local insID = itemCell.gameObject:GetInstanceID()
	local taskItem = self.taskAreaItemList[insID]

	if taskItem == nil then
		return
	end

	self:__OnTaskListItemSelectChange(taskItem.taskCid)
end

function HomeLandMissionUI:__OnRefreshTaskListShow()
	self.dispTaskList = HomeModule.GetDispTaskIDList()

	if self.selectTaskCid ~= 0 then
		local taskData = HomeModule.GetDispTask(self.selectTaskCid)

		if taskData == nil then
			self.selectTaskCid = 0
		end
	end

	self.taskAreaList:Refresh(#self.dispTaskList)
end

function HomeLandMissionUI:__OnTaskListItemSelectChange(taskCid)
	if self.selectTaskCid == taskCid then
		return
	end

	self.selectTaskCid = taskCid

	ForPairs(self.taskAreaItemList, function(_insID, _taskItem)
		_taskItem:RefreshSelectState(self.selectTaskCid == _taskItem.taskCid)
	end)
	self:__OnRefreshSelectTaskShow()
end

function HomeLandMissionUI:__OnRefreshSelectTaskShow()
	self.taskRightView:Show(self.selectTaskCid)
end

function HomeLandMissionUI:__OnShowRoleBag(_roleCid)
	self.roleBag:OnShow()
end

function HomeLandMissionUI:__OnRoleBagItemClick(heroData)
	local workRoomCid = HomeModule.GetRoleWorkRoomCid(heroData.cid)

	if workRoomCid ~= nil then
		return
	end

	self.taskRightView:OnHeroSelected(heroData.cid)
	self.roleBag:RefreshSelectHero(self.taskRightView.heroCidList)
end

function HomeLandMissionUI:__OnRefreshBtnClickEvent()
	local lastRefreshCount, curCount, cost = HomeModule.GetDispTaskRefreshData()

	if lastRefreshCount == 0 then
		NoticeModule.ShowNoticeByType(Constant.NoticeType.FloatTips, HomeLandApi:GetTaskRefreshCountLimitText())

		return
	end

	local ownerCount = WarehouseModule.GetPlayerGoldNum()

	if ownerCount < cost then
		NoticeModule.ShowNoticeByType(Constant.NoticeType.FloatTips, HomeLandApi:GetTaskRefreshCostNotEnoughText())

		return
	end

	self.msgBox:Show(cost, ownerCount)
end

function HomeLandMissionUI:__OnConfirmRefreshTask()
	local isAllFinish = HomeModule.IsAllTaskFinish()

	if not isAllFinish then
		HomeModule.RefreshDispTask()

		return
	end

	local noticeCid = HomeLandApi:GetTaskRefreshNoChangeTextID()

	if noticeCid ~= nil and noticeCid ~= 0 then
		NoticeModule.ShowNotice(noticeCid)
	end
end

function HomeLandMissionUI:__InitTaskRefreshTime()
	local serverTime = PlayerModule.GetServerTime()
	local dateTable = {}

	dateTable.year = tonumber(os.date("%Y", serverTime))
	dateTable.month = tonumber(os.date("%m", serverTime))
	dateTable.day = tonumber(os.date("%d", serverTime)) + 1
	dateTable.hour = HomeLandApi:GetTaskRefreshTime_Hour()
	dateTable.min = HomeLandApi:GetTaskRefreshTime_Min()
	dateTable.sec = 0
	self.refreshTime = dateTimeToTimeStamp(dateTable, PlayerModule.TimeZone)

	self:__RefreshTaskRefreshTime()
end

function HomeLandMissionUI:__RefreshTaskRefreshTime()
	local lastTime = self.refreshTime - PlayerModule.GetServerTime()

	if lastTime < 0 then
		lastTime = 0
	end

	local timeStr = DateTimeFormat(lastTime, "hh:mm:ss")

	self.refreshTimeText:GetComponent("Text").text = HomeLandApi:GetTaskRefreshTimeText(timeStr)
end

function HomeLandMissionUI:__RefreshTaskRefreshCount()
	local lastRefreshCount, curCount, cost = HomeModule.GetDispTaskRefreshData()

	self.refreshCountText:GetComponent("Text").text = HomeLandApi:GetTaskRefreshCountText(lastRefreshCount)
end

function HomeLandMissionUI:__InitTimer()
	self.updateTimer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Home, self.__delegateOnTimeUpdate, 1, -1)

	self.updateTimer:Start()
end

function HomeLandMissionUI:__OnTimeUpdate()
	self:__RefreshTaskRefreshTime()
	ForPairs(self.taskAreaItemList, function(_insID, _taskItem)
		_taskItem:OnTimeUpdate()
	end)
	self.taskRightView:OnTimeUpdate()
end

function HomeLandMissionUI:__StopTimer()
	if self.updateTimer == nil then
		return
	end

	self.updateTimer:Stop()

	self.updateTimer = nil
end

function HomeLandMissionUI:__OnCloseButtonClickEventHandler()
	UIModule.Close(Constant.UIControllerName.HomeLandMissionUI)
end

return HomeLandMissionUI
