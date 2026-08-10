local var_0_0 = class("FishHook", ReduxView)
local var_0_1 = 70
local var_0_2 = 1
local var_0_3 = 540
local var_0_4 = 1200
local var_0_5 = 1200

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.catchingFishIndex_ = 0

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.angleSpeed_ = 60

	arg_2_0:GetTmpCorners()
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.haveBuffController_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "haveBuff")
	arg_3_0.oriHeight_ = arg_3_0.hookTransform_.rect.height

	FishGameManager.GetInstance():AddBuffHandler(handler(arg_3_0, arg_3_0.OnBuffChange))
end

function var_0_0.OnBuffChange(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 == 2 then
		arg_4_0.haveBuffController_:SetSelectedState("true")
	else
		arg_4_0.haveBuffController_:SetSelectedState("false")
	end
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.AddEventListeners(arg_6_0)
	return
end

function var_0_0.OnTop(arg_7_0)
	arg_7_0:UpdateBar()
end

function var_0_0.UpdateBar(arg_8_0)
	return
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:AddEventListeners()
end

function var_0_0.OnExit(arg_10_0)
	arg_10_0:RemoveAllEventListener()
end

function var_0_0.StartHooking(arg_11_0)
	if not arg_11_0.hooking_ then
		arg_11_0.hooking_ = true

		manager.audio:PlayEffect("minigame_fishing", "fishing_hook_swing", "")
	end
end

function var_0_0.Update(arg_12_0, arg_12_1)
	if not arg_12_0.hooking_ then
		FishGameManager.GetInstance():SetStatus("idle")
		arg_12_0:SwitchToAnimatorState("Hook_idle")

		local var_12_0 = arg_12_0.rotaryTransform_.eulerAngles
		local var_12_1 = arg_12_1 * arg_12_0.angleSpeed_ * var_0_2 + var_12_0.z

		var_12_0.z = var_12_1
		arg_12_0.rotaryTransform_.eulerAngles = var_12_0

		if var_12_1 > 0 and var_12_1 <= 180 then
			if var_12_1 > var_0_1 then
				var_0_2 = -1
			end
		elseif var_12_1 > 180 and var_12_1 <= 360 and var_12_1 - 360 < -var_0_1 then
			var_0_2 = 1
		end
	elseif arg_12_0.catchingFishIndex_ >= 1 then
		if arg_12_0.catchingFish_:GetData().fishId == 4 then
			FishGameManager.GetInstance():SetStatus("fail")
		else
			FishGameManager.GetInstance():SetStatus("catch")
		end

		arg_12_0:SwitchToAnimatorState("Hook_catch", function()
			arg_12_0.catching_ = false
			arg_12_0.animator_.speed = 0
		end)

		local var_12_2 = arg_12_0.rotaryTransform_.eulerAngles

		if var_12_2.z >= 0 and var_12_2.z < 90 then
			local var_12_3 = arg_12_0.hitImageTransform_.localScale

			var_12_3.x = 1
			arg_12_0.hitImageTransform_.localScale = var_12_3

			local var_12_4 = arg_12_0.fishContainer.localScale

			var_12_4.x = 1
			arg_12_0.fishContainer.localScale = var_12_4
		else
			local var_12_5 = arg_12_0.hitImageTransform_.localScale

			var_12_5.x = -1
			arg_12_0.hitImageTransform_.localScale = var_12_5

			local var_12_6 = arg_12_0.fishContainer.localScale

			var_12_6.x = -1
			arg_12_0.fishContainer.localScale = var_12_6
		end

		if not arg_12_0.catching_ then
			local var_12_7 = arg_12_0.hookTransform_.sizeDelta
			local var_12_8 = GameFishCfg[arg_12_0.catchingFish_:GetData().fishId]

			if FishGameManager.GetInstance():GetBuff() == 2 then
				var_12_7.y = var_12_7.y - var_0_5 * arg_12_1
			else
				var_12_7.y = var_12_7.y - var_0_4 * arg_12_1 / (var_12_8.weight * 0.5)
			end

			if var_12_7.y <= arg_12_0.oriHeight_ then
				var_12_7.y = arg_12_0.oriHeight_

				FishGameManager.GetInstance():AddScore(var_12_8.score)

				if arg_12_0.catchingFish_:GetData().fishId == 6 then
					FishGameManager.GetInstance():RandomBuff()
				elseif arg_12_0.catchingFish_:GetData().fishId == 5 then
					FishGameManager.GetInstance():AddTreasure()
				end

				FishGameManager.GetInstance():CheckEnd()

				arg_12_0.hooking_ = false

				FishGameManager.GetInstance():PlayFishDisappear(arg_12_0.catchingFish_, function(arg_14_0)
					arg_14_0:Dispose()
				end)

				arg_12_0.catchingFish_ = nil
				arg_12_0.catchingFishIndex_ = 0

				manager.audio:PlayEffect("minigame_fishing", "fishing_hook_swing", "")
			end

			arg_12_0.hookTransform_.sizeDelta = var_12_7
		end
	elseif arg_12_0.catchingEmpty_ then
		FishGameManager.GetInstance():SetStatus("fail")
		arg_12_0:SwitchToAnimatorState("Hook_catchEmpty", function()
			arg_12_0.animator_.speed = 0
		end)

		local var_12_9 = arg_12_0.hookTransform_.sizeDelta

		var_12_9.y = var_12_9.y - var_0_4 * arg_12_1

		if var_12_9.y <= arg_12_0.oriHeight_ then
			var_12_9.y = arg_12_0.oriHeight_
			arg_12_0.catchingEmpty_ = false
			arg_12_0.hooking_ = false

			manager.audio:PlayEffect("minigame_fishing", "fishing_hook_swing", "")
		end

		arg_12_0.hookTransform_.sizeDelta = var_12_9
	else
		FishGameManager.GetInstance():SetStatus("cast")
		arg_12_0:SwitchToAnimatorState("Hook_cast", function()
			arg_12_0.animator_.speed = 0
		end)

		local var_12_10 = arg_12_0.hookTransform_.sizeDelta

		var_12_10.y = var_12_10.y + var_0_3 * arg_12_1
		arg_12_0.hookTransform_.sizeDelta = var_12_10

		local var_12_11, var_12_12 = arg_12_0:GetHitFish()

		if var_12_11 > 0 then
			local var_12_13 = var_12_12:GetData()

			arg_12_0.catchingFishIndex_ = var_12_11
			arg_12_0.catching_ = true

			var_12_12.transform_:SetParent(arg_12_0.fishContainer, false)

			var_12_12.transform_.pivot = Vector2(var_12_13.pivotX / 100, 1 - var_12_13.pivotY / 100)
			var_12_12.transform_.localPosition = Vector2(0, 0)

			FishGameManager.GetInstance():RemoveFish(var_12_12)

			arg_12_0.catchingFish_ = var_12_12
		elseif arg_12_0:IsOutOfGameView() then
			arg_12_0.catchingEmpty_ = true

			manager.audio:PlayEffect("minigame_fishing", "fishing_hook_up_empty", "")
		end
	end

	if arg_12_0.animator_:GetCurrentAnimatorStateInfo(0):IsName(arg_12_0.curState_) and arg_12_0.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 and arg_12_0.handler_ ~= nil then
		arg_12_0.handler_(arg_12_0.curState_)
	end
end

function var_0_0.SwitchToAnimatorState(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_0.curState_ ~= nil and arg_17_1 == arg_17_0.curState_ then
		return
	end

	arg_17_0.handler_ = arg_17_2
	arg_17_0.curState_ = arg_17_1

	arg_17_0.animator_:Play(arg_17_1, -1, 0)

	arg_17_0.animator_.speed = 1
end

function var_0_0.IsOutOfGameView(arg_18_0)
	local var_18_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_18_1 = arg_18_0.hitGo_.transform:TransformPoint(0, 0, 0)
	local var_18_2 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_18_0, var_18_1)
	local var_18_3 = FishGameManager.GetInstance():GetGameRoot():TransformPoint(0, 0, 0)
	local var_18_4 = var_18_2 - UnityEngine.RectTransformUtility.WorldToScreenPoint(var_18_0, var_18_3)
	local var_18_5 = 1080 / Screen.height
	local var_18_6 = (var_18_5 * var_18_4).x

	if -(var_18_5 * var_18_4).y > 1080 or var_18_6 < 0 or var_18_6 > 1920 then
		CustomLog.Log(string.format("out !!!!!!!!!!!!!!!, screenPoint = %s", tostring(var_18_5 * var_18_4)))

		return true
	end

	return false
end

function var_0_0.GetHitFish(arg_19_0)
	local var_19_0, var_19_1, var_19_2, var_19_3 = arg_19_0:GetScreenCorners(arg_19_0.hitGo_.transform)
	local var_19_4 = FishGameManager.GetInstance():GetFishes()

	for iter_19_0, iter_19_1 in ipairs(var_19_4) do
		local var_19_5 = iter_19_1:GetData()
		local var_19_6, var_19_7, var_19_8, var_19_9 = arg_19_0:GetScreenCorners(iter_19_1.hitArea_)

		if arg_19_0:HitCheckObb(var_19_0, var_19_1, var_19_2, var_19_3, var_19_6, var_19_7, var_19_8, var_19_9) then
			return iter_19_0, iter_19_1
		end
	end

	return 0
end

function var_0_0.GetScreenCorners(arg_20_0, arg_20_1)
	local var_20_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	arg_20_1:GetWorldCorners(arg_20_0.corners)

	local var_20_1 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_20_0, arg_20_0.corners[0])
	local var_20_2 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_20_0, arg_20_0.corners[1])
	local var_20_3 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_20_0, arg_20_0.corners[2])
	local var_20_4 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_20_0, arg_20_0.corners[3])

	return var_20_1, var_20_2, var_20_3, var_20_4
end

function var_0_0.HitCheckObb(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5, arg_21_6, arg_21_7, arg_21_8)
	local var_21_0 = {
		Vector2.Normalize(arg_21_2 - arg_21_1),
		Vector2.Normalize(arg_21_3 - arg_21_2),
		Vector2.Normalize(arg_21_6 - arg_21_5),
		Vector2.Normalize(arg_21_7 - arg_21_6)
	}
	local var_21_1 = (arg_21_1 + arg_21_3) / 2
	local var_21_2 = (arg_21_5 + arg_21_7) / 2
	local var_21_3 = Vector2.New(var_21_1.x - var_21_2.x, var_21_1.y - var_21_2.y)
	local var_21_4 = Vector2.New(arg_21_1.x - var_21_1.x, arg_21_1.y - var_21_1.y)
	local var_21_5 = Vector2.New(arg_21_2.x - var_21_1.x, arg_21_2.y - var_21_1.y)
	local var_21_6 = Vector2.New(arg_21_5.x - var_21_2.x, arg_21_5.y - var_21_2.y)
	local var_21_7 = Vector2.New(arg_21_6.x - var_21_2.x, arg_21_6.y - var_21_2.y)
	local var_21_8 = false

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		local var_21_9 = math.abs(iter_21_1.x * var_21_3.x + iter_21_1.y * var_21_3.y)
		local var_21_10 = math.abs(iter_21_1.x * var_21_4.x + iter_21_1.y * var_21_4.y)
		local var_21_11 = math.abs(iter_21_1.x * var_21_5.x + iter_21_1.y * var_21_5.y)
		local var_21_12 = math.max(var_21_10, var_21_11)
		local var_21_13 = math.abs(iter_21_1.x * var_21_6.x + iter_21_1.y * var_21_6.y)
		local var_21_14 = math.abs(iter_21_1.x * var_21_7.x + iter_21_1.y * var_21_7.y)

		if var_21_9 > var_21_12 + math.max(var_21_13, var_21_14) then
			var_21_8 = true

			break
		end
	end

	return not var_21_8
end

function var_0_0.GetTmpCorners(arg_22_0)
	if arg_22_0.corners == nil then
		arg_22_0.corners = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	end
end

function var_0_0.Reset(arg_23_0)
	if arg_23_0.catchingFish_ then
		arg_23_0.catchingFish_:Dispose()

		arg_23_0.catchingFish_ = nil
	end

	local var_23_0 = arg_23_0.hookTransform_.sizeDelta

	if var_23_0.y <= arg_23_0.oriHeight_ then
		var_23_0.y = arg_23_0.oriHeight_
	end

	arg_23_0.hooking_ = false
	arg_23_0.catchingFishIndex_ = 0
	arg_23_0.hookTransform_.sizeDelta = var_23_0

	local var_23_1 = arg_23_0.rotaryTransform_.eulerAngles

	var_23_1.z = 0
	arg_23_0.rotaryTransform_.eulerAngles = var_23_1
end

function var_0_0.Dispose(arg_24_0)
	if arg_24_0.catchingFish_ then
		arg_24_0.catchingFish_:Dispose()

		arg_24_0.catchingFish_ = nil
	end

	local var_24_0 = arg_24_0.hookTransform_.sizeDelta

	if var_24_0.y <= arg_24_0.oriHeight_ then
		var_24_0.y = arg_24_0.oriHeight_
	end

	arg_24_0.hookTransform_.sizeDelta = var_24_0

	var_0_0.super.Dispose(arg_24_0)
end

return var_0_0
