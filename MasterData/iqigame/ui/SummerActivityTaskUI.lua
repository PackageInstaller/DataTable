-- chunkname: @IQIGame\\UI\\SummerActivityTaskUI.lua

local SummerActivityTaskUI = {}

SummerActivityTaskUI = Base:Extend("SummerActivityTaskUI", "IQIGame.Onigao.UI.SummerActivityTaskUI", SummerActivityTaskUI)

local taskItemClass = require("IQIGame/UI/SummerActivity/SummerActivityTaskUI_taskItem")

function SummerActivityTaskUI:OnInit()
	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()

	self.buttonReturn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
end

function SummerActivityTaskUI:InitMembers()
	self.taskDataArray = {}
	self.taskCellList = {}
end

function SummerActivityTaskUI:InitComponent()
	self.taskScroll = self.taskScroll:GetComponent("OptimizedScrollRect")

	self.taskScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateTaskScroll(OptimizedParams, OptimizedViewsHolder)
	end)
end

function SummerActivityTaskUI:InitDelegate()
	function self.taskNotifyEvent()
		self:Refresh()
	end

	function self.delegateOnClickButtonGetAll()
		self:OnClickButtonGetAll()
	end
end

function SummerActivityTaskUI:OnAddListeners()
	self.buttonGetAll:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonGetAll)
	EventDispatcher.AddEventListener(EventID.TaskNotifyTask, self.taskNotifyEvent)
	EventDispatcher.AddEventListener(EventID.TaskNotifyFinish, self.taskNotifyEvent)
	EventDispatcher.AddEventListener(EventID.TaskSubmitSucceed, self.taskNotifyEvent)
end

function SummerActivityTaskUI:OnRemoveListeners()
	self.buttonGetAll:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonGetAll)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyTask, self.taskNotifyEvent)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyFinish, self.taskNotifyEvent)
	EventDispatcher.RemoveEventListener(EventID.TaskSubmitSucceed, self.taskNotifyEvent)
end

function SummerActivityTaskUI:OnClickButtonGetAll()
	local SubmitTypes = {
		TaskSystemModule.CombineContent(Constant.MainTaskType.Recharge, Constant.ExtendTaskType.SummerActivityTask)
	}

	TaskSystemModule.SubmitTaskForType(SubmitTypes)
end

function SummerActivityTaskUI:UpdateTaskScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.taskDataArray[index + 1]

	if not self.taskCellList[instanceID] then
		self.taskCellList[instanceID] = taskItemClass.New(viewGameObject, self)
	end

	self.taskCellList[instanceID]:Refresh(data)
end

function SummerActivityTaskUI:OnOpen(userData)
	self:Refresh()
end

function SummerActivityTaskUI:OnClose(userData)
	return
end

function SummerActivityTaskUI:GetPreloadAssetPaths()
	return nil
end

function SummerActivityTaskUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SummerActivityTaskUI:IsManualShowOnOpen(userData)
	return false
end

function SummerActivityTaskUI:GetBGM(userData)
	return nil
end

function SummerActivityTaskUI:OnPause()
	return
end

function SummerActivityTaskUI:OnResume()
	return
end

function SummerActivityTaskUI:OnCover()
	return
end

function SummerActivityTaskUI:OnReveal()
	return
end

function SummerActivityTaskUI:OnRefocus(userData)
	return
end

function SummerActivityTaskUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SummerActivityTaskUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SummerActivityTaskUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SummerActivityTaskUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SummerActivityTaskUI:Refresh()
	self.taskDataArray = TaskSystemModule.GetSortForTypeDataList(Constant.MainTaskType.Recharge, Constant.ExtendTaskType.SummerActivityTask, TaskSystemModule.sortType.Weight_ID, true, false)

	self.taskScroll:RefreshByItemCount(#self.taskDataArray)
	self:CheckMultipleGet()
end

function SummerActivityTaskUI:CheckMultipleGet()
	local len = #self.taskDataArray
	local canGetNum = 0

	for i = 1, len do
		if self.taskDataArray[i].status == Constant.TaskStatus.hasDone then
			canGetNum = canGetNum + 1
		end

		if canGetNum >= 2 then
			LuaUtility.SetGameObjectShow(self.multipleGetRoot, true)

			return
		end
	end

	LuaUtility.SetGameObjectShow(self.multipleGetRoot, false)
end

function SummerActivityTaskUI:OnDestroy()
	for _, v in pairs(self.taskCellList) do
		v:OnDestroy()
	end

	self.taskCellList = {}

	self.buttonReturn:Dispose()
	AssetUtil.UnloadAsset(self)
end

return SummerActivityTaskUI
