-- chunkname: @IQIGame\\UI\\GhostActivityTaskUI.lua

local GhostActivityTaskUI = {}

GhostActivityTaskUI = Base:Extend("GhostActivityTaskUI", "IQIGame.Onigao.UI.GhostActivityTaskUI", GhostActivityTaskUI)

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local tabItemClass = require("IQIGame/UI/ActiveActivityList/GhostActivity/GhostActivityTaskUI_tabItem")
local taskItemClass = require("IQIGame/UI/ActiveActivityList/GhostActivity/GhostActivityTaskUI_taskItem")
local dataName_mark = "mark"

function GhostActivityTaskUI:OnInit()
	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()

	self.buttonReturn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
end

function GhostActivityTaskUI:InitMembers()
	self.taskDataArray = {}
	self.taskCellList = {}
end

function GhostActivityTaskUI:InitComponent()
	self.taskScroll = self.taskScroll:GetComponent("OptimizedScrollRect")

	self.taskScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateTaskScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	self.scoreItemPool = UIViewObjectPool.New(self.tabItem, self.tabContent.transform, function(_view)
		return tabItemClass.New(_view, self)
	end)
end

function GhostActivityTaskUI:InitDelegate()
	function self.taskNotifyEvent()
		self:Refresh()
		self:SelectWithChapterID(self.currentSelectTabItem.data.cid)
	end
end

function GhostActivityTaskUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.OnTaskRedDotEvent, self.taskNotifyEvent)
end

function GhostActivityTaskUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.OnTaskRedDotEvent, self.taskNotifyEvent)
end

function GhostActivityTaskUI:UpdateTaskScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.taskDataArray[index + 1]

	if not self.taskCellList[instanceID] then
		self.taskCellList[instanceID] = taskItemClass.New(viewGameObject, self)
	end

	self.taskCellList[instanceID]:Refresh(data)
end

function GhostActivityTaskUI:OnOpen(userData)
	self.activityPod = ActivityModule.GetActivityPodByActivityType({
		Constant.ActivityType.ActivityType_GhostBoss
	})[1]
	self.cfgActivity = CfgUtil.GetCfgActivityDataWithID(self.activityPod.cid)
	self.taskMainType = self.cfgActivity.ExtraParam[2]

	self:Refresh()

	if userData.selectChapterId then
		self:SelectWithChapterID(userData.selectChapterId)
	else
		self:SelectFirst()
	end
end

function GhostActivityTaskUI:OnClose(userData)
	return
end

function GhostActivityTaskUI:GetPreloadAssetPaths()
	return nil
end

function GhostActivityTaskUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GhostActivityTaskUI:IsManualShowOnOpen(userData)
	return false
end

function GhostActivityTaskUI:GetBGM(userData)
	return nil
end

function GhostActivityTaskUI:OnPause()
	return
end

function GhostActivityTaskUI:OnResume()
	return
end

function GhostActivityTaskUI:OnCover()
	return
end

function GhostActivityTaskUI:OnReveal()
	return
end

function GhostActivityTaskUI:OnRefocus(userData)
	return
end

function GhostActivityTaskUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GhostActivityTaskUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GhostActivityTaskUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GhostActivityTaskUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GhostActivityTaskUI:Refresh()
	self:RefreshTab()
end

function GhostActivityTaskUI:RefreshTab()
	local bossChapterArray = BossChapterModule.GetChapterDataWithType(Constant.ChapterPassType.Type_GhostBoss)

	self.scoreItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	local len = #bossChapterArray

	for i = 1, len do
		local tabItem = self.scoreItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		tabItem:Show()
		tabItem:Refresh(bossChapterArray[i], i)
	end
end

function GhostActivityTaskUI:RefreshScore()
	local cfgBossChapter = CfgUtil.GetCfgBossChapterDataWithID(self.currentSelectTabItem.data.cid)

	LuaUtility.SetStateController(self.gameObject, dataName_mark, BossChapterModule.GetMarkWithScore(cfgBossChapter.Id, self.currentSelectTabItem.data.optimalIntegral and self.currentSelectTabItem.data.optimalIntegral or 0))
	LuaUtility.SetText(self.textSelf, self.currentSelectTabItem.data.totalIntegral and self.currentSelectTabItem.data.totalIntegral or 0)
	LuaUtility.SetText(self.textMax, cfgBossChapter.MaxScore)
end

function GhostActivityTaskUI:RefreshTaskScroll()
	self.taskDataArray = TaskSystemModule.GetSortForTypeDataList(self.taskMainType, {
		self.currentSelectTabItem.data.cid
	}, TaskSystemModule.sortType.Weight_ID, true, false)

	self.taskScroll:RefreshByItemCount(#self.taskDataArray)
end

function GhostActivityTaskUI:OnTabClick(tabItem)
	if self.currentSelectTabItem then
		self.currentSelectTabItem:UnSelected()

		self.currentSelectTabItem = nil
	end

	self.currentSelectTabItem = tabItem

	self.currentSelectTabItem:Selected()
	self:RefreshScore()
	self:RefreshTaskScroll()
end

function GhostActivityTaskUI:SelectFirst()
	self.scoreItemPool:ForItems(function(_item)
		if _item.gameObject.activeSelf and _item.index and _item.index == 1 then
			_item:OnClickButtonClick()

			return true
		end
	end)
end

function GhostActivityTaskUI:SelectWithChapterID(chapterId)
	self.scoreItemPool:ForItems(function(_item)
		if _item.gameObject.activeSelf and _item.data and _item.data.cid == chapterId then
			_item:OnClickButtonClick()

			return true
		end
	end)
end

function GhostActivityTaskUI:OnDestroy()
	self.buttonReturn:Dispose()
	self.scoreItemPool:Dispose(function(item)
		item:OnDestroy()
	end)
	AssetUtil.UnloadAsset(self)
end

return GhostActivityTaskUI
