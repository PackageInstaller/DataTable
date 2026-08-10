local var_0_0 = {}

local function var_0_1(arg_1_0)
	JumpTools.OpenPageByJump("/SpShootGameSelectView", {
		activityID = arg_1_0
	})
end

local var_0_2 = ActivityConst.ACTIVITY_3_6_KALI_SHOOTGAME

function var_0_0.Enter(arg_2_0, arg_2_1, arg_2_2)
	manager.ui:SetMainCamera("shoot_game")

	var_0_2 = arg_2_2.activityID_

	var_0_1(arg_2_2.activityID_)

	arg_2_0.palyer = GameObject.Find("ShootManager/player")
	arg_2_0.skilleffect = GameObject.Find("BigSkill")

	if arg_2_0.skilleffect then
		arg_2_0.skillPlay = arg_2_0.skilleffect:GetComponent("PlayableDirector")

		arg_2_0:SetActiveSkillEffect(false)
	end

	arg_2_0.playAnimator = arg_2_0.palyer.gameObject:GetComponent(typeof(Animator))
	arg_2_0.effect = GameObject.Find("NormalSkill")

	if arg_2_0.effect then
		local var_2_0 = 1.7777777777777777
		local var_2_1 = manager.ui.mainCameraCom_

		if var_2_0 < var_2_1.aspect then
			local var_2_2 = var_2_1.aspect / var_2_0

			arg_2_0.effect.transform.localScale = Vector3.New(var_2_2, var_2_2, 1)
		end
	end

	arg_2_0:SetHitEffect(false)
end

function var_0_0.Exit(arg_3_0)
	AnimatorTools.Stop()
	PushShootGameGoToMain()
end

function var_0_0.Show(arg_4_0, arg_4_1)
	return
end

function var_0_0.PlayAni(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.playAnimator then
		arg_5_0.playAnimator:SetBool("IsEnter", true)
	end
end

function var_0_0.SetBool(arg_6_0, arg_6_1)
	if arg_6_0.playAnimator then
		arg_6_0.playAnimator:SetBool("IsEnter", arg_6_1)
	end
end

function var_0_0.CheckEffectEnd(arg_7_0)
	if arg_7_0.skilleffect then
		local var_7_0 = arg_7_0.skillPlay.duration
		local var_7_1 = arg_7_0.skillPlay.time

		if var_7_0 <= var_7_1 or var_7_1 == 0 then
			arg_7_0:SetActiveSkillEffect(false)
		end
	end
end

function var_0_0.StartGameUI()
	JumpTools.OpenPageByJump("/SpShootGameInfoView", {
		activityID = var_0_2
	})
end

function var_0_0.SetActiveSkillEffect(arg_9_0, arg_9_1)
	if arg_9_0.skilleffect and not isNil(arg_9_0.skilleffect) then
		SetActive(arg_9_0.skilleffect, arg_9_1)
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

function var_0_0.SetHitEffect(arg_15_0, arg_15_1)
	if arg_15_0.effect and not isNil(arg_15_0.effect) then
		SetActive(arg_15_0.effect, arg_15_1)
	end
end

function var_0_0.SetSkillEffect(arg_16_0)
	if arg_16_0.skillPlay and not isNil(arg_16_0.skillPlay) then
		arg_16_0.skillPlay.time = 0.01

		arg_16_0.skillPlay:Evaluate()
		arg_16_0:SetActiveSkillEffect(true)
		arg_16_0.skillPlay:Play()
	end
end

function var_0_0.StopPlayable(arg_17_0)
	SetActive(arg_17_0.skilleffect, false)
	arg_17_0.skillPlay:Stop()

	arg_17_0.skillPlay.time = 0

	arg_17_0.skillPlay:Evaluate()
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

		local var_20_1 = string.format("[[enemy_hit_num,%s],[friend_hit_num,%s]]", arg_19_1, arg_19_2)

		SDKTools.SendMessageToSDK("activity_combat_over", {
			stage_id = 0,
			result = 1,
			activity_id = var_0_2,
			score = arg_19_0,
			other_data = var_20_1,
			reward_list = var_20_0,
			use_seconds = ShootGameToLuaBridge.GetMaxTime()
		})
	end)
end

return var_0_0
