local MainHomeRandomSettingView = class("MainHomeRandomSettingView", ReduxView)

function MainHomeRandomSettingView:UIName()
	return "Widget/System/Random/RandomTabUI"
end

function MainHomeRandomSettingView:UIParent()
	return manager.ui.uiMain.transform
end

function MainHomeRandomSettingView:Init()
	self:InitUI()
	self:AddUIListener()

	self.pageType_ = {
		RandomHeroView,
		RandomSceneView
	}
	self.pages_ = {}
end

function MainHomeRandomSettingView:InitUI()
	self:BindCfgUI()
end

function MainHomeRandomSettingView:AddUIListener()
	self.toggles_ = {}

	for iter_5_0 = 1, 2 do
		self.toggles_[iter_5_0] = self["toggle_" .. iter_5_0]

		self:AddToggleListener(self.toggles_[iter_5_0], function(arg_6_0)
			if arg_6_0 then
				self:OpenPage(iter_5_0)
			end
		end)
	end
end

function MainHomeRandomSettingView:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		0,
		0
	})
	manager.heroRaiseTrack.raiseModel:Finish()
end

function MainHomeRandomSettingView:OnEnter()
	self.type_ = self.params_.type

	if self.toggles_[self.type_].isOn then
		self:OpenPage(self.type_, true)
	else
		self.toggles_[self.type_].isOn = true
	end
end

function MainHomeRandomSettingView:OnTop()
	self.curPage_:OnTop()
end

function MainHomeRandomSettingView:OnExit()
	self.curPage_:OnExit()
end

function MainHomeRandomSettingView:OpenPage(arg_11_1, arg_11_2)
	local var_11_0 = self.pages_[arg_11_1]

	if not self.pages_[arg_11_1] then
		var_11_0 = self.pageType_[arg_11_1].New()
		self.pages_[arg_11_1] = var_11_0
		var_11_0.gameObject_ = Object.Instantiate(Asset.Load((var_11_0:UIName())), self.gameObject_.transform)
		var_11_0.transform_ = var_11_0.gameObject_.transform

		var_11_0:Init()
	end

	if self.curPage_ == var_11_0 then
		if arg_11_2 then
			var_11_0:OnEnter()
		end

		return
	end

	if self.curPage_ then
		self.curPage_:OnExit()
		SetActive(self.curPage_.gameObject_, false)
	end

	self.curPage_ = var_11_0

	SetActive(var_11_0.gameObject_, true)
	var_11_0:OnEnter()
end

function MainHomeRandomSettingView:Dispose()
	self.params_ = nil

	for iter_12_0, iter_12_1 in pairs(self.pages_) do
		iter_12_1:Dispose()
	end

	self.pages_ = nil

	MainHomeRandomSettingView.super.Dispose(self)
end

return MainHomeRandomSettingView
