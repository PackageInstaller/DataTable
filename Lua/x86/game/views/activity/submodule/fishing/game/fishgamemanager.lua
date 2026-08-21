local var_0_0 = singletonClass("FishGameManager")
local var_0_1 = {}
local var_0_2
local var_0_3
local var_0_4 = 0
local var_0_5 = 0
local var_0_6 = 0
local var_0_7 = 0
local var_0_8 = 0
local var_0_9 = 0
local var_0_10 = 0
local var_0_11 = false
local var_0_12 = 0
local var_0_13 = 0
local var_0_14 = "idle"
local var_0_15 = {}

function var_0_0.Init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameView_ = arg_1_1
	arg_1_0.gameRootContainer_ = arg_1_2

	if not var_0_3 then
		var_0_3 = FrameTimer.New(handler(arg_1_0, arg_1_0.Update), 1, -1)
	end

	var_0_3:Start()
end

function var_0_0.Start(arg_2_0)
	arg_2_0.pausing_ = false
	var_0_11 = false
	var_0_4 = 0
	var_0_5 = 0
	var_0_8 = 60
	var_0_12 = 0
	var_0_13 = 0
	var_0_10 = 0
	var_0_14 = "idle"
	var_0_9 = manager.time:GetServerTime()

	manager.audio:PlayEffect("minigame_fishing", "fishing_hook_swing", "")
end

function var_0_0.RegisterEvents(arg_3_0)
	manager.notify:RegistListener(GAME_FOCUS_CHANGE, handler(arg_3_0, arg_3_0.OnGameFocusChange))
end

function var_0_0.RemoveEvents(arg_4_0)
	manager.notify:RemoveListener(GAME_FOCUS_CHANGE, handler(arg_4_0, arg_4_0.OnGameFocusChange))
end

function var_0_0.OnGameFocusChange(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 then
		arg_5_0:Pause()
	end
end

function var_0_0.GetFishes(arg_6_0)
	return var_0_1
end

function var_0_0.AddFish(arg_7_0, arg_7_1)
	table.insert(var_0_1, arg_7_1)
end

function var_0_0.RemoveFish(arg_8_0, arg_8_1)
	local var_8_0 = table.indexof(var_0_1, arg_8_1)

	if var_8_0 then
		table.remove(var_0_1, var_8_0)
	end
end

function var_0_0.CheckEnd(arg_9_0)
	if #var_0_1 <= 0 then
		var_0_11 = true
	end

	local var_9_0 = false

	for iter_9_0, iter_9_1 in ipairs(var_0_1) do
		if GameFishCfg[iter_9_1:GetData().fishId].score > 0 then
			var_9_0 = true
		end
	end

	if not var_9_0 then
		var_0_11 = true
	end
end

function var_0_0.RemoveAllFishes(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(var_0_1) do
		iter_10_1:Dispose()
	end

	var_0_1 = {}
end

function var_0_0.SetHook(arg_11_0, arg_11_1)
	var_0_2 = arg_11_1
end

function var_0_0.SetScoreAddHandler(arg_12_0, arg_12_1)
	arg_12_0.onScoreAddHandler = arg_12_1
end

function var_0_0.SetPauseHandler(arg_13_0, arg_13_1)
	arg_13_0.pauseHandler_ = arg_13_1
end

function var_0_0.SetContinueHandler(arg_14_0, arg_14_1)
	arg_14_0.continueHandler_ = arg_14_1
end

function var_0_0.SetScoreChangeHandler(arg_15_0, arg_15_1)
	arg_15_0.scoreChangeHandler_ = arg_15_1
end

function var_0_0.AddBuffHandler(arg_16_0, arg_16_1)
	table.insert(var_0_15, arg_16_1)
end

function var_0_0.Pause(arg_17_0)
	arg_17_0.pausing_ = true

	if arg_17_0.pauseHandler_ then
		arg_17_0.pauseHandler_()
	end

	manager.audio:PlayEffect("minigame_fishing", "fishing_pauseall", "")
end

function var_0_0.Continue(arg_18_0)
	arg_18_0.pausing_ = false

	if arg_18_0.continueHandler_ then
		arg_18_0.continueHandler_()
	end

	manager.audio:PlayEffect("minigame_fishing", "fishing_resumeall", "")
end

function var_0_0.Update(arg_19_0)
	if arg_19_0.pausing_ then
		var_0_10 = var_0_10 + Time.deltaTime

		return
	end

	local var_19_0 = Time.deltaTime

	arg_19_0.gameView_:Update(var_19_0)

	if var_0_11 then
		return
	end

	arg_19_0.gameView_:Update(var_19_0)

	for iter_19_0, iter_19_1 in ipairs(var_0_1) do
		iter_19_1:Update(var_19_0)
	end

	if var_0_2 ~= nil then
		var_0_2:Update(var_19_0)
	end

	var_0_8 = var_0_8 - var_19_0

	if var_0_8 <= 0 then
		var_0_11 = true
	end

	if var_0_5 ~= 0 then
		local var_19_1 = manager.time:GetServerTime() - var_0_10 - var_0_7

		if var_0_15 ~= nil and #var_0_15 > 0 then
			for iter_19_2, iter_19_3 in ipairs(var_0_15) do
				local var_19_2 = var_0_6 - var_19_1

				if var_19_2 <= 0 then
					if var_0_5 == 1 then
						manager.audio:PlayEffect("minigame_fishing", "fishing_buff_double_stop", "")
					elseif var_0_5 == 2 then
						manager.audio:PlayEffect("minigame_fishing", "fishing_buff_electric_stop", "")
					end

					var_0_6 = 0
					var_0_5 = 0
					var_0_7 = 0

					iter_19_3(0, 0, 0)
				else
					iter_19_3(var_0_5, 2, var_19_2)
				end
			end
		end
	end

	if arg_19_0.currentDisappearItem_ ~= nil then
		arg_19_0.flySeconds_ = arg_19_0.flySeconds_ + Time.deltaTime

		local var_19_3 = {
			x = arg_19_0.startPos_.x + arg_19_0.flySeconds_ * (arg_19_0.targetPos_.x - arg_19_0.startPos_.x),
			y = arg_19_0.startPos_.y + arg_19_0.flySeconds_ * (arg_19_0.targetPos_.y - arg_19_0.startPos_.y),
			z = arg_19_0.startPos_.z + arg_19_0.flySeconds_ * (arg_19_0.targetPos_.z - arg_19_0.startPos_.z)
		}
		local var_19_4 = arg_19_0.gameView_.gameObject_.transform:InverseTransformPoint(var_19_3)

		arg_19_0.currentDisappearItem_.gameObject_.transform.localPosition = var_19_4

		local var_19_5 = 1 - 0.5 * arg_19_0.flySeconds_

		arg_19_0.currentDisappearItem_.gameObject_.transform.localScale = Vector3(var_19_5, var_19_5, var_19_5)

		if arg_19_0.flySeconds_ > 1 then
			arg_19_0.flySeconds_ = 1

			arg_19_0.gameView_:AppearBubble(arg_19_0:GetTreasureLimitNum())

			if arg_19_0.fishDisappearCallback_ ~= nil then
				arg_19_0.fishDisappearCallback_(arg_19_0.currentDisappearItem_)

				arg_19_0.fishDisappearCallback_ = nil
				arg_19_0.currentDisappearItem_ = nil
			end
		end
	end
end

function var_0_0.GetGameRoot(arg_20_0)
	return arg_20_0.gameRootContainer_
end

function var_0_0.AddScore(arg_21_0, arg_21_1)
	if var_0_5 == 1 then
		arg_21_1 = arg_21_1 * 2
	end

	var_0_4 = var_0_4 + arg_21_1

	if arg_21_0.onScoreAddHandler then
		arg_21_0.onScoreAddHandler(arg_21_1)
	end

	if arg_21_0.scoreChangeHandler_ ~= nil then
		arg_21_0.scoreChangeHandler_()
	end
end

function var_0_0.PlayFishDisappear(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1:GetData().fishId ~= 5 then
		arg_22_2(arg_22_1)
	else
		arg_22_0.currentDisappearItem_ = arg_22_1

		local var_22_0 = arg_22_1.transform_.eulerAngles

		var_22_0.z = 0
		arg_22_1.transform_.eulerAngles = var_22_0
		arg_22_1.transform_.pivot = Vector2(0.5, 0.5)

		arg_22_0.currentDisappearItem_.gameObject_.transform:SetParent(arg_22_0.gameView_.gameObject_.transform)

		arg_22_0.startPos_ = arg_22_0.currentDisappearItem_.gameObject_.transform:TransformPoint(0, 0, 0)
		arg_22_0.targetPos_ = arg_22_0.gameView_:GetBubbleTarget():TransformPoint(0, 0, 0)
		arg_22_0.flySeconds_ = 0
		arg_22_0.fishDisappearCallback_ = arg_22_2
	end
end

function var_0_0.ResetScore(arg_23_0)
	var_0_4 = 0

	if arg_23_0.scoreChangeHandler_ ~= nil then
		arg_23_0.scoreChangeHandler_()
	end
end

function var_0_0.GetScore(arg_24_0)
	return var_0_4
end

function var_0_0.GetBuff(arg_25_0)
	return var_0_5
end

function var_0_0.GetSeconds(arg_26_0)
	return var_0_8
end

function var_0_0.GetIsEnd(arg_27_0)
	return var_0_11
end

function var_0_0.RandomBuff(arg_28_0)
	var_0_5 = math.random(1, 3)

	if var_0_5 == 1 then
		var_0_6 = 20

		manager.audio:PlayEffect("minigame_fishing", "fishing_buff_double", "")
	elseif var_0_5 == 2 then
		var_0_6 = 10

		manager.audio:PlayEffect("minigame_fishing", "fishing_buff_electric", "")
	elseif var_0_5 == 3 then
		var_0_6 = 20

		manager.audio:PlayEffect("minigame_fishing", "fishing_buff_freeze", "")
	end

	var_0_7 = manager.time:GetServerTime()

	for iter_28_0, iter_28_1 in ipairs(var_0_15) do
		if iter_28_1 ~= nil then
			iter_28_1(var_0_5, 1, var_0_6)
		end
	end
end

function var_0_0.AddTreasure(arg_29_0)
	var_0_12 = var_0_12 + 1
	var_0_13 = var_0_13 + 1
	var_0_13 = math.min(var_0_13, GameSetting.activity_fishing_fish_max.value[1])
end

function var_0_0.GetTreasureNum(arg_30_0)
	return var_0_12
end

function var_0_0.GetTreasureLimitNum(arg_31_0)
	return var_0_13
end

function var_0_0.SetStatus(arg_32_0, arg_32_1)
	var_0_14 = arg_32_1
end

function var_0_0.GetStatus(arg_33_0)
	return var_0_14
end

function var_0_0.Reset(arg_34_0)
	if var_0_2 then
		var_0_2:Reset()

		var_0_2 = nil
	end

	var_0_3:Stop()

	var_0_15 = {}

	arg_34_0:RemoveEvents()
	arg_34_0:RemoveAllFishes()
end

function var_0_0.Dispose(arg_35_0)
	if arg_35_0.currentDisappearItem_ then
		arg_35_0.currentDisappearItem_:Dispose()

		arg_35_0.currentDisappearItem_ = nil
	end

	if var_0_2 then
		var_0_2:Dispose()

		var_0_2 = nil
	end

	var_0_15 = {}

	var_0_3:Stop()
	arg_35_0:RemoveEvents()
	arg_35_0:RemoveAllFishes()
end

return var_0_0
