local RandomHeroModePopView = class("RandomHeroModePopView", ReduxView)

function RandomHeroModePopView:UIName()
	return "Widget/System/Random/RandomAssistantPopUI"
end

function RandomHeroModePopView:UIParent()
	return manager.ui.uiPop.transform
end

function RandomHeroModePopView:Init()
	self:InitUI()
	self:AddUIListener()
end

function RandomHeroModePopView:InitUI()
	self:BindCfgUI()

	self.aniToggle_ = RandomSettingToggleItem.New(self.aniToggleGo_)

	self.aniToggle_:SetCallback(function()
		if not PlayerData:IsRandomHero() then
			ShowTips("RANDOM_MODE_SETTING_TIPS2")

			return
		end

		self.aniBool_ = not self.aniBool_

		self:RefreshUI()
	end)
end

function RandomHeroModePopView:AddUIListener()
	for iter_6_0 = 1, 3 do
		self:AddToggleListener(self["connect" .. iter_6_0 .. "Tgl_"], function(arg_7_0)
			if arg_7_0 then
				self.connectType = iter_6_0 - 1
			end
		end)
	end

	self:AddBtnListener(self.yesBtn_, nil, function()
		self:SaveOrExit()
	end)
	self:AddBtnListener(self.noBtn_, nil, function()
		JumpTools.Back()
	end)
end

function RandomHeroModePopView:OnEnter()
	self.connectType = self.params_.type
	self.connectType = math.min(HomeSceneSettingConst.RANDOM_MODE.COUNT - 1, self.connectType)
	self["connect" .. self.connectType + 1 .. "Tgl_"].isOn = true
	self.aniBool_ = PlayerData:IsRandomHeroShowEachDebutAnim()

	self:RefreshUI()
end

function RandomHeroModePopView:RefreshUI()
	self.aniToggle_:SetValue(self.aniBool_)
end

function RandomHeroModePopView:OnExit()
	return
end

function RandomHeroModePopView:SaveOrExit()
	if self.connectType and self.connectType ~= self.params_.type then
		PlayerAction.SetRandomHeroMode(self.connectType, function()
			self.params_.type = self.connectType

			self:SaveOrExit()
		end)

		return
	end

	if self.aniBool_ ~= PlayerData:IsRandomHeroShowEachDebutAnim() then
		PlayerAction.SetIsRandomHeroShowEachDebutAnim(not PlayerData:IsRandomHeroShowEachDebutAnim(), function()
			self.aniBool_ = PlayerData:IsRandomHeroShowEachDebutAnim()

			self:SaveOrExit()
		end)

		return
	end

	JumpTools.Back()
end

function RandomHeroModePopView:Dispose()
	self.params_ = nil

	if self.aniToggle_ then
		self.aniToggle_:Dispose()

		self.aniToggle_ = nil
	end

	RandomHeroModePopView.super.Dispose(self)
end

return RandomHeroModePopView
