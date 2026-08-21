local var_0_0 = class("PosterCommonActor", PosterGirlBaseActor)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:InitSceneEffect()
end

function var_0_0.GetModelPath(arg_2_0)
	return HeroUITimelineMgr.GetModelPath(arg_2_0:GetSkinId(), arg_2_0:GetModelId())
end

function var_0_0.LoadModel(arg_3_0)
	var_0_0.super.LoadModel(arg_3_0)

	arg_3_0.animator = arg_3_0.ui_tpose:GetComponent(typeof(Animator))

	arg_3_0:GetHeroTimelineMgr():BindHero(arg_3_0:GetSkinId(), arg_3_0:GetModelId(), arg_3_0.tpose)
end

function var_0_0.GetTag(arg_4_0)
	return PosterGirlConst.PosterGirlTag.common
end

function var_0_0.GetAnimator(arg_5_0)
	return arg_5_0.animator
end

function var_0_0.GetState(arg_6_0, arg_6_1)
	if arg_6_0._states[arg_6_1] then
		return arg_6_0._states[arg_6_1]
	end

	local var_6_0 = PosterGirlTools.ProduceCommonState(arg_6_1, arg_6_0)

	if var_6_0 ~= nil then
		var_6_0:SetStateKey(arg_6_1)

		arg_6_0._states[arg_6_1] = var_6_0

		return var_6_0
	end
end

function var_0_0.GetInteractionCfg(arg_7_0)
	local var_7_0 = arg_7_0.skinId

	if var_7_0 == 108501 then
		local var_7_1 = tonumber("99" .. var_7_0)

		if HeroTools.GetOldInteractionCfg(var_7_1) then
			return arg_7_0:_GetInteractionCfg(var_7_1)
		end
	end

	local var_7_2 = nullable(SkinCfg, var_7_0, "hero") or HeroTools.GetHeroIDFromFormID(var_7_0)

	return arg_7_0:_GetInteractionCfg(var_7_2)
end

function var_0_0.RegisterEvents(arg_8_0)
	arg_8_0:RegisterActorEvents("ON_SCENE_INTERACT", arg_8_0.OnSceneInteract)
end

function var_0_0.PlayTalkVoice(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_1

	return HeroTools.PlayTalkForceUseOriginalSkinID(var_9_0, arg_9_2, arg_9_3, arg_9_0:GetModel().transform)
end

function var_0_0.DoShacking(arg_10_0)
	if not arg_10_0:CheckInitState() then
		return
	end

	arg_10_0:ChangeState(PosterGirlConst.StateKay.shake)
	arg_10_0.super.DoShacking(arg_10_0)
end

function var_0_0.DoTouch(arg_11_0)
	if not arg_11_0:CheckInitState() then
		return
	end

	arg_11_0:ChangeState(PosterGirlConst.StateKay.touch)
	arg_11_0.super.DoTouch(arg_11_0)
end

function var_0_0.DoQuickTouch(arg_12_0)
	if not arg_12_0:CheckInitState() then
		return
	end

	arg_12_0:ChangeState(PosterGirlConst.StateKay.quickclick)
	arg_12_0.super.DoQuickTouch(arg_12_0)
end

function var_0_0.DoShowing(arg_13_0)
	if not arg_13_0:CheckInitState() then
		return
	end

	arg_13_0:ChangeState(PosterGirlConst.StateKay.show)
	arg_13_0.super.DoShowing(arg_13_0)
end

function var_0_0.DoGreeting(arg_14_0)
	if not arg_14_0:CheckInitState() then
		return
	end

	arg_14_0:ChangeState(PosterGirlConst.StateKay.greet)
	arg_14_0.super.DoGreeting(arg_14_0)
end

function var_0_0.DoIdle(arg_15_0)
	if not arg_15_0:CheckInitState() then
		return
	end

	arg_15_0:ChangeState(PosterGirlConst.StateKay.idle)
end

function var_0_0.DoInit(arg_16_0, arg_16_1)
	arg_16_0:ChangeState(PosterGirlConst.StateKay.init)
end

local var_0_1 = 0.4

function var_0_0.DoAction(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == nil then
		arg_17_0:ChangeState(PosterGirlConst.StateKay.init)
	else
		arg_17_0:ChangeState(PosterGirlConst.StateKay.custom)
		arg_17_0:AddInteractionsTimes()

		local var_17_0 = arg_17_0:GetCurrentState()

		var_17_0:PlayAni(arg_17_1, arg_17_2)
		var_17_0:SetCompleteCallback(function()
			arg_17_0:ChangeState(PosterGirlConst.StateKay.init)
		end)
	end
end

function var_0_0.DoActionChain(arg_19_0, arg_19_1, arg_19_2, ...)
	if arg_19_1 == nil then
		arg_19_0:ChangeState(PosterGirlConst.StateKay.init)
	else
		arg_19_0:ChangeState(PosterGirlConst.StateKay.custom)
		arg_19_0:AddInteractionsTimes()

		local var_19_0
		local var_19_1

		if type(arg_19_2) == "number" then
			var_19_1 = arg_19_2
			var_19_0 = {
				...
			}
		else
			var_19_1 = var_0_1
			var_19_0 = {
				arg_19_2,
				...
			}
		end

		local var_19_2 = arg_19_0:GetCurrentState()

		var_19_2:PlayAni(arg_19_1, var_19_1)
		var_19_2:SetCompleteCallback(function()
			arg_19_0:DoActionChain(unpack(var_19_0))
		end)
	end
end

function var_0_0.Dispose(arg_21_0)
	arg_21_0:GetHeroTimelineMgr():Unbind()
	var_0_0.super.Dispose(arg_21_0)
end

local function var_0_2(arg_22_0, arg_22_1, ...)
	if arg_22_0 == nil then
		return {}
	end

	local var_22_0 = var_0_2(...)

	var_22_0[arg_22_0] = arg_22_1

	return var_22_0
end

local var_0_3 = {
	play = function(arg_23_0, ...)
		arg_23_0:DoActionChain(...)
		arg_23_0:RecordDoActionChain({
			...
		})
	end,
	talk = function(arg_24_0, ...)
		arg_24_0:DoSpecialTalk(...)
	end,
	jump = function(arg_25_0, arg_25_1, arg_25_2)
		JumpTools.OpenPageByJump(arg_25_1, arg_25_2)
	end,
	record = function(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
		SDKTools.SendMessageToSDK("activity_combat_over", {
			sys_id = arg_26_1,
			skin_id = arg_26_2,
			scene_id = arg_26_3,
			other_data = arg_26_4
		})
	end,
	recordCustom = function(arg_27_0, arg_27_1, arg_27_2)
		SDKTools.SendMessageToSDK(arg_27_1, arg_27_2)
	end,
	print = function(arg_28_0, ...)
		print(...)
	end
}

function var_0_0.OnSceneInteract(arg_29_0, arg_29_1, ...)
	local var_29_0 = nullable(var_0_3, arg_29_1)

	if manager.posterGirl:GetViewTag() == PosterGirlConst.ViewTag.home and var_29_0 then
		var_29_0(arg_29_0, ...)
	end
end

local var_0_4 = require("cjson")

function var_0_0.RecordDoActionChain(arg_30_0, arg_30_1)
	local var_30_0 = HomeSceneSettingData:GetCurScene()

	SDKTools.SendMessageToSDK("activity_combat_over", {
		sys_id = 101,
		skin_id = arg_30_0.skinId,
		scene_id = var_30_0,
		other_data = var_0_4.encode(arg_30_1)
	})
end

return var_0_0
