-- chunkname: @IQIGame\\UI\\GhostGameTaskUI.lua

local GhostGameTaskUI = {}

GhostGameTaskUI = Base:Extend("GhostGameTaskUI", "IQIGame.Onigao.UI.GhostGameTaskUI", GhostGameTaskUI)

local taskItemClass = require("IQIGame/UI/ActiveActivityList/GhostActivity/GhostGameTaskUI_taskItem")

function GhostGameTaskUI:OnInit()
	self:InitMembers()
	self:InitDelegate()
	self:InitComponent()
end

function GhostGameTaskUI:InitMembers()
	self.taskScrollCellList = {}
end

function GhostGameTaskUI:InitDelegate()
	function self.delegateOnClickButtonClose()
		UIModule.CloseSelf(self)
	end

	function self.onRefreshFromSeverEvent()
		self:Refresh()
	end

	function self.delegateOnClickGetAllBtn()
		self:OnClickGetAllBtn()
	end
end

function GhostGameTaskUI:InitComponent()
	self.taskScroll = self.taskScroll:GetComponent("OptimizedScrollRect")

	self.taskScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateTaskScroll(OptimizedParams, OptimizedViewsHolder)
	end)
end

function GhostGameTaskUI:OnAddListeners()
	self.buttonClose:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClose)
	self.buttonGetAll:GetComponent("Button").onClick:AddListener(self.delegateOnClickGetAllBtn)
	EventDispatcher.AddEventListener(EventID.TaskNotifyFinish, self.onRefreshFromSeverEvent)
end

function GhostGameTaskUI:OnRemoveListeners()
	self.buttonClose:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClose)
	self.buttonGetAll:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickGetAllBtn)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyFinish, self.onRefreshFromSeverEvent)
end

function GhostGameTaskUI:UpdateTaskScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.taskScrollDataArray[index + 1]

	if not self.taskScrollCellList[instanceID] then
		self.taskScrollCellList[instanceID] = taskItemClass.New(viewGameObject, self)
	end

	self.taskScrollCellList[instanceID]:Refresh(data)
end

function GhostGameTaskUI:OnOpen(userData)
	self.activityID = userData.activityID

	self:Refresh()
end

function GhostGameTaskUI:OnClose(userData)
	return
end

function GhostGameTaskUI:GetPreloadAssetPaths()
	return nil
end

function GhostGameTaskUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GhostGameTaskUI:IsManualShowOnOpen(userData)
	return false
end

function GhostGameTaskUI:GetBGM(userData)
	return nil
end

function GhostGameTaskUI:OnPause()
	return
end

function GhostGameTaskUI:OnResume()
	return
end

function GhostGameTaskUI:OnCover()
	return
end

function GhostGameTaskUI:OnReveal()
	return
end

function GhostGameTaskUI:OnRefocus(userData)
	return
end

function GhostGameTaskUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GhostGameTaskUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GhostGameTaskUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GhostGameTaskUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GhostGameTaskUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function GhostGameTaskUI:Refresh()
	self:RefreshTaskScroll()
end

function GhostGameTaskUI:RefreshTaskScroll()
	local activityCfg = CfgActivityTable[self.activityID]

	self.taskMainType = activityCfg.ExtraParam[2]
	self.taskScrollDataArray = TaskSystemModule.GetSortForTypeDataList(self.taskMainType, nil, TaskSystemModule.sortType.Weight_ID, true, false)

	self.taskScroll:RefreshByItemCount(#self.taskScrollDataArray)

	local SubmitIDs = TaskSystemModule.GetCanReceiveTaskIDList({
		self.taskScrollDataArray
	})

	LuaUtility.SetGameObjectShow(self.buttonGetAll, table.len(SubmitIDs) > 0)
end

function GhostGameTaskUI:OnClickGetAllBtn()
	local SubmitIDs = TaskSystemModule.GetCanReceiveTaskIDList({
		self.taskScrollDataArray
	})

	TaskSystemModule.SubmitTask(SubmitIDs)
end

return GhostGameTaskUI
