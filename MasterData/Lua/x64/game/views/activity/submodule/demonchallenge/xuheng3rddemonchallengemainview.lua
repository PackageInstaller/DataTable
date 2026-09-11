local XuHeng3rdDemonChallengeMainView = class("XuHeng3rdDemonChallengeMainView", (import("game.views.activity.Submodule.DemonChallenge.Dream.DreamDemonChallengeMainView")))

function XuHeng3rdDemonChallengeMainView:InitUI()
	XuHeng3rdDemonChallengeMainView.super.InitUI(self)

	self.glowController = ControllerUtil.GetController(self.glow_, "name")
end

function XuHeng3rdDemonChallengeMainView:OnLevelSelect(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if self.curLevelIndex_ ~= arg_2_1 then
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_xinmo_turn", "")
		self:ResetAnimator(self.roleAni_, "XuHeng3rdDemonLevelUI_shuimo")

		self.roleAni_.enabled = true

		self.glowController:SetSelectedIndex(arg_2_1 - 1)
	end

	saveData("DemonChallenge" .. "_" .. USER_ID, tostring(arg_2_2), manager.time:GetServerTime())
	XuHeng3rdDemonChallengeMainView.super.OnLevelSelect(self, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
end

function XuHeng3rdDemonChallengeMainView:LevelRenderer(arg_3_1, arg_3_2)
	if self.levelControllerS_[arg_3_1] == nil then
		self.levelControllerS_[arg_3_1] = ControllerUtil.GetController(arg_3_2.transform, "lock")
	end

	self.levelControllerS_[arg_3_1]:SetSelectedState("false")

	self.lockTextS_[arg_3_1] = self:FindCom(typeof(Text), "title/lock/text", arg_3_2.transform)

	self:AddBtnListener(self:FindCom(typeof(Button), "title/lock", arg_3_2.transform), nil, function()
		local var_4_0 = ActivityData:GetActivityData(arg_3_1)

		if var_4_0.stopTime <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")
		else
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(var_4_0.startTime)))
		end
	end)
end

function XuHeng3rdDemonChallengeMainView:OnEnter()
	XuHeng3rdDemonChallengeMainView.super.OnEnter(self)
	manager.windowBar:SetGameHelpKey("ACTIVITY_DEMON_CHALLENGE_DESCRIPE_2_2")
end

function XuHeng3rdDemonChallengeMainView:ResetAnimator(arg_6_1, arg_6_2)
	arg_6_1:Play(arg_6_2, 0, 0)
	arg_6_1:Update(0)

	arg_6_1.enabled = false
end

return XuHeng3rdDemonChallengeMainView
