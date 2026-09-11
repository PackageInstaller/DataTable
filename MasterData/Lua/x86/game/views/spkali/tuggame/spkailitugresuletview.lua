local SPKailiTugResuletView = class("SPKailiTugResuletView", ReduxView)

function SPKailiTugResuletView:UIName()
	return "Widget/Version/ShashwatUI_3_6/ShashwatUI_3_6_kaliUI/ShashwatUI_3_6_TugGameresultPopUI"
end

function SPKailiTugResuletView:UIParent()
	return manager.ui.uiPop.transform
end

function SPKailiTugResuletView:OnCtor()
	return
end

function SPKailiTugResuletView:Init()
	self:InitUI()
	self:AddListeners()
end

function SPKailiTugResuletView:InitUI()
	self:BindCfgUI()

	self.stateController_ = self.shashwatui_3_6_tuggameresultpopuiControllerexcollection_:GetController("battleStatede")
end

function SPKailiTugResuletView:AddListeners()
	self:AddBtnListener(self.suminibtn01Btn_, nil, function()
		self:OnOk()
	end)
	self:AddBtnListener(self.suminibtn02Btn_, nil, function()
		self:OnCancel()
	end)
end

function SPKailiTugResuletView:ChangeBar()
	return
end

function SPKailiTugResuletView:OnTop()
	return
end

function SPKailiTugResuletView:OnOk()
	PushTugGameGoToMain()
end

function SPKailiTugResuletView:OnCancel()
	self:Back()
	self.gameManager:RestartGame()
end

function SPKailiTugResuletView:Cacheable()
	return false
end

function SPKailiTugResuletView:OnEnter()
	self.gameManager = TugGame.GetInstance()

	local var_14_0 = self.params_ and self.params_.isWin
	local var_14_1

	if self.params_ then
		var_14_1 = self.params_.stageID or 0
	end

	self.stateController_:SetSelectedState(var_14_0 and "win" or "lose")

	self.textcheckpointText_.text = ActivityKaliGameStageCfg[var_14_1] and ActivityKaliGameStageCfg[var_14_1].name

	if var_14_0 then
		manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_success")
	else
		manager.audio:PlayEffect("minigame_activity_3_6", "minigame_activity_3_6_1156_rope_fail")
	end
end

function SPKailiTugResuletView:OnExit()
	SPKailiTugResuletView.super.OnExit(self)
end

function SPKailiTugResuletView:Dispose()
	SPKailiTugResuletView.super.Dispose(self)
end

return SPKailiTugResuletView
