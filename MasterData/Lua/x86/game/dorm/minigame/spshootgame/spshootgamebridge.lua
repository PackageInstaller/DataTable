local var_0_0 = {}

local function var_0_1(arg_1_0)
	JumpTools.OpenPageByJump("/SpShootGameSelectView", {
		activityID = arg_1_0
	})
end

local var_0_2 = ActivityConst.ACTIVITY_3_6_KALI_SHOOTGAME

function var_0_0:Enter(arg_2_1, arg_2_2)
	manager.ui:SetMainCamera("shoot_game")

	var_0_2 = arg_2_2.activityID_

	var_0_1(arg_2_2.activityID_)

	self.palyer = GameObject.Find("ShootManager/player")
	self.skilleffect = GameObject.Find("BigSkill")

	if self.skilleffect then
		self.skillPlay = self.skilleffect:GetComponent("PlayableDirector")

		self:SetActiveSkillEffect(false)
	end

	self.playAnimator = self.palyer.gameObject:GetComponent(typeof(Animator))
	self.effect = GameObject.Find("NormalSkill")

	if self.effect then
		if 1.7777777777777777 < manager.ui.mainCameraCom_.aspect then
			self.effect.transform.localScale = Vector3.New(manager.ui.mainCameraCom_.aspect / 1.7777777777777777, manager.ui.mainCameraCom_.aspect / 1.7777777777777777, 1)
		end
	end

	self:SetHitEffect(false)
end

function var_0_0.Exit(arg_3_0)
	AnimatorTools.Stop()
	PushShootGameGoToMain()
end

function var_0_0.Show(arg_4_0, arg_4_1)
	return
end

function var_0_0:PlayAni(arg_5_1, arg_5_2)
	if self.playAnimator then
		self.playAnimator:SetBool("IsEnter", true)
	end
end

function var_0_0:SetBool(arg_6_1)
	if self.playAnimator then
		self.playAnimator:SetBool("IsEnter", arg_6_1)
	end
end

function var_0_0:CheckEffectEnd()
	if self.skilleffect then
		if self.skillPlay.duration <= self.skillPlay.time or self.skillPlay.time == 0 then
			self:SetActiveSkillEffect(false)
		end
	end
end

function var_0_0.StartGameUI()
	JumpTools.OpenPageByJump("/SpShootGameInfoView", {
		activityID = var_0_2
	})
end

function var_0_0:SetActiveSkillEffect(arg_9_1)
	if self.skilleffect and not isNil(self.skilleffect) then
		SetActive(self.skilleffect, arg_9_1)
	end
end

function var_0_0.UpdateScore(arg_10_0, arg_10_1)
	manager.notify:Invoke(ACTIVITY_KALI_UPDATE_SHOOTSCORE, arg_10_0, arg_10_1)
end

function var_0_0.StartGame()
	ShootGameToLuaBridge.StartGame()
end

function PushShootGameGoToMain()
	DestroyLua()
	LuaExchangeHelper.GoToMain()

	self.timer = Timer.New(function()
		self:Update(tickTime)
	end, tickTime, -1)

	self.timer:Start()
end

function var_0_0.Update(arg_14_0, arg_14_1)
	return
end

function var_0_0:SetHitEffect(arg_15_1)
	if self.effect and not isNil(self.effect) then
		SetActive(self.effect, arg_15_1)
	end
end

function var_0_0:SetSkillEffect()
	if self.skillPlay and not isNil(self.skillPlay) then
		self.skillPlay.time = 0.01

		self.skillPlay:Evaluate()
		self:SetActiveSkillEffect(true)
		self.skillPlay:Play()
	end
end

function var_0_0:StopPlayable()
	SetActive(self.skilleffect, false)
	self.skillPlay:Stop()

	self.skillPlay.time = 0

	self.skillPlay:Evaluate()
end

function PushShootGameGoToMain()
	DestroyLua()
	LuaExchangeHelper.GoToMain()
end

function var_0_0.OpenResultUI(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	SpShootGameBridge:SetBool(false)
	SPKaliChallengeAction.SendShootGameResult(var_0_2, arg_19_0 or 0, function(arg_20_0)
		JumpTools.OpenPageByJump("/SpShootGameResultView", {
			score = arg_19_0,
			hitNum1 = arg_19_1,
			hitNum2 = arg_19_2,
			hitNum3 = arg_19_3,
			resultData = arg_20_0,
			activityID = var_0_2
		})

		local var_20_0 = {}

		for iter_20_0, iter_20_1 in ipairs(arg_20_0.item_list or {}) do
			table.insert(var_20_0, {
				iter_20_1.id,
				iter_20_1.num
			})
		end

		SDKTools.SendMessageToSDK("activity_combat_over", {
			stage_id = 0,
			result = 1,
			activity_id = var_0_2,
			score = arg_19_0,
			other_data = string.format("[[enemy_hit_num,%s],[friend_hit_num,%s]]", arg_19_1, arg_19_2),
			reward_list = var_20_0,
			use_seconds = ShootGameToLuaBridge.GetMaxTime()
		})
	end)
end

return var_0_0
