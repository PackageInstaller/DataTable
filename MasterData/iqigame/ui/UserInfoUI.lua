-- chunkname: @IQIGame\\UI\\UserInfoUI.lua

local UserInfo_SkinView = require("IQIGame/UI/UserInfo/UserInfo_SkinView")
local UserInfoUI = Base:Extend("UserInfoUI", "IQIGame.Onigao.UI.UserInfoUI", {})
local RoleInfoView = require("IQIGame.UI.UserInfo.RoleInfoView")
local SkillView = require("IQIGame.UI.UserInfo.SkillView")
local TalentView = require("IQIGame.UI.UserInfo.TalentView")
local ReUserNameView = require("IQIGame.UI.UserInfo.ReUserNameView")
local ResetTalentView = require("IQIGame.UI.UserInfo.ResetTalentView")
local UITabList = require("IQIGame.UI.Common.UITabList")
local CommonGlobalBuffView = require("IQIGame/UI/Common/GlobalBuff/CommonGlobalBuffView")

function UserInfoUI:OnInit()
	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateAboutBtn()
		return
	end

	function self.Delegation_OpenReUserNamePanel()
		self:ShowReUserNamePanel()
	end

	self.ReUserNameView = ReUserNameView.New(self.ReUserNamePanel)
	self.ResetTalentView = ResetTalentView.New(self.ResetTalentPanel)
	self.uiTabList = UITabList.Create()
	self.mainView = RoleInfoView.New(self.RoleInfoPanel, {
		function()
			self:ShowReUserNamePanel()
		end
	})

	self.uiTabList:AddTableItem(self.playerTab, function()
		return self.mainView
	end, function(_isOn, _view)
		if not _isOn then
			_view:OnClose()

			return
		end

		_view:SetData(self.PlayerData)
		_view:OnOpen()
		self:PlayRoleInfoViewAnim(true)
	end)

	self.skillView = SkillView.New(self.SkillPanel)

	self.uiTabList:AddTableItem(self.playerSkillTab, function()
		return self.skillView
	end, function(_isOn, _view)
		if not _isOn then
			_view:OnClose()

			self.RoleParent.transform.localPosition = Vector3.zero

			return
		end

		_view:OnOpen()
		_view:SetData()
		self:SetRoleInfoViewState(false)
	end)

	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.buffView = CommonGlobalBuffView.New(self.BuffParent)
	self.skinView = UserInfo_SkinView.New(self.SkinPanelRoot)
end

function UserInfoUI:SetRoleInfoViewState(state)
	LuaUtility.SetGameObjectShow(self.RoleParent, state)
end

function UserInfoUI:PlayRoleInfoViewAnim(isReset)
	self:SetRoleInfoViewState(true)

	if isReset then
		self.RoleParent.transform:DOLocalMove(Vector3.New(0, 0, 0), 0.5):SetEase(DoTweenEase.OutCirc)
	else
		self.RoleParent.transform:DOLocalMove(Vector3.New(500, 0, 0), 0.5):SetEase(DoTweenEase.OutCirc)
	end
end

function UserInfoUI:GetPreloadAssetPaths()
	return nil
end

function UserInfoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function UserInfoUI:IsManualShowOnOpen(userData)
	return false
end

function UserInfoUI:GetBGM(userData)
	return nil
end

function UserInfoUI:OnOpen(userData)
	self.skinView:Hide()

	self.isSelf = userData[2]

	if userData == nil then
		userData = {
			UserInfoModule.GetPlayerInfo(),
			true
		}
		self.isSelf = true
	end

	self.PlayerData = userData

	self.uiTabList:ChangeSelectIndex(1)
	self:InitView()
	LuaUtility.SetGameObjectShow(self.playerSkillTab, isSelf)

	local buffCidList = {}

	if self.isSelf then
		buffCidList = GlobalBuffModule.GetBuffIDList(Constant.GlobalBuffEffectType.All)
	end

	self.buffView:Show(buffCidList)
end

function UserInfoUI:__OnNotifyGlobalBuffChangeEventHandler()
	if not self.isSelf then
		return
	end

	local buffCidList = GlobalBuffModule.GetBuffIDList(Constant.GlobalBuffEffectType.All)

	self.buffView:Show(buffCidList)
end

function UserInfoUI:__OnShowUserInfoSkinViewEventHandler(active, skinCid)
	if active then
		self.skinView:Show(skinCid)
		self.mainView.roleDisplayView:OnCover()
	else
		self.mainView.roleDisplayView:OnReveal()
		self.skinView:Hide()
	end
end

function UserInfoUI:__OnChangeShowCidEventHandler()
	if not self.isSelf then
		return
	end

	self.PlayerData = UserInfoModule.GetPlayerInfo()

	self.mainView:SetData({
		UserInfoModule.GetPlayerInfo(),
		true
	})
end

function UserInfoUI:OnClose(userData)
	self.mainView:OnClose()
end

function UserInfoUI:InitAllDelegate()
	return
end

function UserInfoUI:InitView()
	self.ReUserNameView:Hide()
	self.ResetTalentView:Hide()
end

function UserInfoUI:OnAddListeners()
	EventUtil.AddEventListener(self, EventID.NotifyGlobalBuffChange, self.__OnNotifyGlobalBuffChangeEventHandler)
	EventUtil.AddEventListener(self, EventID.ShowUserInfoSkinView, self.__OnShowUserInfoSkinViewEventHandler)
	EventUtil.AddEventListener(self, EventID.ChangeShowHcid, self.__OnChangeShowCidEventHandler)
end

function UserInfoUI:OnRemoveListeners()
	EventUtil.ClearEventListener(self)
end

function UserInfoUI:ShowBindPhonePanel()
	self.BindPhoneView:Show()
end

function UserInfoUI:ShowReUserNamePanel()
	self.ReUserNameView:Show()
end

function UserInfoUI:OnPause()
	return
end

function UserInfoUI:OnResume()
	return
end

function UserInfoUI:OnCover()
	return
end

function UserInfoUI:OnReveal()
	return
end

function UserInfoUI:OnRefocus(userData)
	return
end

function UserInfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function UserInfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function UserInfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function UserInfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function UserInfoUI:OnDestroy()
	self.skinView:Dispose()
	self.buffView:Dispose()
	self.ReUserNameView:Dispose()
	self.ResetTalentView:Dispose()
	self.commonReturnBtn:Dispose()
	self.uiTabList:Dispose()
	AssetUtil.UnloadAsset(self)
end

return UserInfoUI
