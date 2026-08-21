-- chunkname: @IQIGame\\UI\\FavorInviteUI.lua

local FavorInviteUI = {}

FavorInviteUI = Base:Extend("FavorInviteUI", "IQIGame.Onigao.UI.FavorInviteUI", FavorInviteUI)

local roleItemClass = require("IQIGame/UI/FavorInvite/FavorInvite_RoleItem")

function FavorInviteUI:OnInit()
	self:InitMembers()
	self:InitDelegate()
	self:InitComponent()
end

function FavorInviteUI:InitMembers()
	self.roleDataArray = {}
	self.roleViewList = {}
end

function FavorInviteUI:InitComponent()
	self.roleScroll = self.roleScroll:GetComponent("OptimizedGridRect")

	self.roleScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:OnRoleScrollRefresh(OptimizedParams, OptimizedViewsHolder)
	end)

	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
end

function FavorInviteUI:OnOpen(userData)
	self.actionId = userData.actionId

	self:Refresh()
end

function FavorInviteUI:OnClose(userData)
	self.currentRoleItem = nil
	self.crrSelectRoleId = nil
end

function FavorInviteUI:InitDelegate()
	function self.delegateOnClickButtonInvite()
		self:OnClickButtonInvite()
	end

	function self.delegateOnClickButtonSolo()
		self:OnClickButtonSolo()
	end
end

function FavorInviteUI:OnAddListeners()
	self.buttonInvite:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonInvite)
	self.buttonSolo:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonSolo)
end

function FavorInviteUI:OnRemoveListeners()
	self.buttonInvite:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonInvite)
	self.buttonSolo:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonSolo)
end

function FavorInviteUI:OnClickButtonSolo()
	if WorldMapModule.GetSoloInviteCount() >= CfgUtil.GetCfgDiscreteFirstDataWithID(Constant.DiscreteData.MaxSoloInviteCount) then
		NoticeModule.ShowNotice(53008)

		return
	end

	NoticeModule.ShowNotice(53007, function()
		WorldMapModule.TriggerDailyAction(self.actionId)
		UIModule.CloseSelf(self)
	end)
end

function FavorInviteUI:OnClickButtonInvite()
	if not self.currentRoleItem then
		logError("【邀请界面】还没有选择要邀请的英雄")

		return
	end

	local actionData = WorldMapModule.GetComponentActionDataWithId(self.actionId)

	NoticeModule.ShowNoticeByType(Constant.NoticeType.BoxDoubleButton, string.format(actionData:GetCfg().InviteTips, self.currentRoleItem.data.BaseData.Name), function()
		WorldMapModule.TriggerDailyAction(self.actionId, self.currentRoleItem.data.cid)
		UIModule.CloseSelf(self)
	end)
end

function FavorInviteUI:OnRoleScrollRefresh(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.rootGameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.roleDataArray[index + 1]

	if not self.roleViewList[instanceID] then
		self.roleViewList[instanceID] = roleItemClass.New(viewGameObject, self)
	end

	self.roleViewList[instanceID]:Refresh(data)
end

function FavorInviteUI:GetPreloadAssetPaths()
	return nil
end

function FavorInviteUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FavorInviteUI:IsManualShowOnOpen(userData)
	return false
end

function FavorInviteUI:GetBGM(userData)
	return nil
end

function FavorInviteUI:OnPause()
	return
end

function FavorInviteUI:OnResume()
	return
end

function FavorInviteUI:OnCover()
	return
end

function FavorInviteUI:OnReveal()
	return
end

function FavorInviteUI:OnRefocus(userData)
	return
end

function FavorInviteUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FavorInviteUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FavorInviteUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FavorInviteUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FavorInviteUI:Refresh()
	local heroDataArray = WarlockModule.GetWarlockList()

	self.roleDataArray = WarlockModule.SortRoleListByType(heroDataArray, Constant.WarlockSortType.Favor, true)

	self:RefreshRoleScroll()
end

function FavorInviteUI:RefreshRoleScroll()
	self.roleScroll:RefreshByItemCount(#self.roleDataArray)
end

function FavorInviteUI:OnRoleClick(item)
	if self.currentRoleItem then
		self.currentRoleItem:UnSelected()
	end

	self.currentRoleItem = item

	self.currentRoleItem:Selected()

	self.crrSelectRoleId = self.currentRoleItem.data.cid
end

function FavorInviteUI:OnDestroy()
	self.commonReturnBtn:Dispose()
	AssetUtil.UnloadAsset(self)
end

return FavorInviteUI
