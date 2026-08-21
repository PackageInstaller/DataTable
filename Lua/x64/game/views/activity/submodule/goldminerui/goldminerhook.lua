local var_0_0 = class("GoldMinerHook", ReduxView)
local var_0_1 = 70
local var_0_2 = 1
local var_0_3 = 540
local var_0_4 = 1200
local var_0_5 = 1200
local var_0_6 = {
	x = 0,
	y = 0
}
local var_0_7 = 1000
local var_0_8 = 130
local var_0_9 = 80

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform
	arg_1_0.gameView_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.angleSpeed_ = 60
	arg_2_0.hooking_ = false
	arg_2_0.catchingThingIndex_ = 0
	arg_2_0.catchingThing_ = nil
	arg_2_0.movePointList_ = {}
	arg_2_0.moveLineList_ = {}
	arg_2_0.hookCurDir_ = nil
	arg_2_0.curTransThing_ = nil
	arg_2_0.boomShowTime_ = 0
	arg_2_0.addPointSkillEnable_ = false
	arg_2_0.addSpeedSkillEnable_ = false
	arg_2_0.playBackAudio_ = false
	arg_2_0.heroID_ = 0

	arg_2_0:GetTmpCorners()
	arg_2_0:InitUI()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.oriHeight_ = arg_3_0.hookTransform_.rect.height
	arg_3_0.hookSpine_ = arg_3_0.hookSpineGo_:GetComponent("Spine.Unity.SkeletonGraphic")

	SetActive(arg_3_0.boomAni_, false)
end

function var_0_0.UseSkill(arg_4_0, arg_4_1)
	arg_4_0.heroID_ = arg_4_1

	if arg_4_1 == 1045 then
		arg_4_0.addPointSkillEnable_ = true
	elseif arg_4_1 == 1046 then
		arg_4_0.addSpeedSkillEnable_ = true
	end
end

function var_0_0.ClearSkill(arg_5_0)
	arg_5_0.addPointSkillEnable_ = false
	arg_5_0.addSpeedSkillEnable_ = false
end

function var_0_0.StartHooking(arg_6_0)
	if not arg_6_0.hooking_ then
		arg_6_0.hooking_ = true
		arg_6_0.curTransThing_ = nil

		arg_6_0.hookGo_.transform:SetParent(GoldMinerManager.GetInstance():GetGameRoot())

		local var_6_0 = Vector2.New(arg_6_0.hookGo_.transform.localPosition.x, arg_6_0.hookGo_.transform.localPosition.y)

		arg_6_0.movePointList_ = {
			var_6_0
		}
		arg_6_0.hookCurDir_ = (arg_6_0.hitGo_.transform.position - arg_6_0.hookTransform_.position):Normalize()

		return true
	end

	return false
end

function var_0_0.TryToBoom(arg_7_0)
	if arg_7_0.catchingThingIndex_ > 0 and not arg_7_0.catching_ then
		SetActive(arg_7_0.boomAni_, true)

		arg_7_0.boomAni_.transform.parent = arg_7_0.gameView_.container_
		arg_7_0.boomShowTime_ = 1

		arg_7_0.catchingThing_:Dispose()

		arg_7_0.catchingThing_ = nil
		arg_7_0.catchingThingIndex_ = 0
		arg_7_0.catchingEmpty_ = true

		arg_7_0.gameView_:SubBoom(-1)

		return true
	end

	return false
end

function var_0_0.Update(arg_8_0, arg_8_1)
	if arg_8_0.boomShowTime_ > 0 then
		arg_8_0.boomShowTime_ = arg_8_0.boomShowTime_ - arg_8_1

		if arg_8_0.boomShowTime_ < 0 then
			SetActive(arg_8_0.boomAni_, false)

			arg_8_0.boomAni_.transform.parent = arg_8_0.hitImageTransform_
			arg_8_0.boomAni_.transform.localPosition = Vector3.New(0, 0, 0)
		end
	end

	if not arg_8_0.hooking_ then
		arg_8_0.isCallBackFunc_ = false
		arg_8_0.playBackAudio_ = false

		local var_8_0 = arg_8_0.rotaryTransform_.eulerAngles
		local var_8_1 = arg_8_1 * arg_8_0.angleSpeed_ * var_0_2 + var_8_0.z

		var_8_0.z = var_8_1
		arg_8_0.rotaryTransform_.eulerAngles = var_8_0

		if var_8_1 > 0 and var_8_1 <= 180 then
			if var_8_1 > var_0_1 then
				var_0_2 = -1
			end
		elseif var_8_1 > 180 and var_8_1 <= 360 and var_8_1 - 360 < -var_0_1 then
			var_0_2 = 1
		end

		arg_8_0:SetSpine("clue_idle", true)
	elseif arg_8_0.catchingThingIndex_ > 0 then
		arg_8_0.catching_ = false

		local var_8_2 = arg_8_0.rotaryTransform_.eulerAngles

		if var_8_2.z >= 0 and var_8_2.z < 90 then
			local var_8_3 = arg_8_0.hitImageTransform_.localScale

			var_8_3.x = 1
			arg_8_0.hitImageTransform_.localScale = var_8_3

			local var_8_4 = arg_8_0.fishContainer.localScale

			var_8_4.x = 1
			arg_8_0.fishContainer.localScale = var_8_4
		else
			local var_8_5 = arg_8_0.hitImageTransform_.localScale

			var_8_5.x = -1
			arg_8_0.hitImageTransform_.localScale = var_8_5

			local var_8_6 = arg_8_0.fishContainer.localScale

			var_8_6.x = -1
			arg_8_0.fishContainer.localScale = var_8_6
		end

		if not arg_8_0.catching_ then
			arg_8_0:OnHookReturn()

			local var_8_7 = arg_8_0.hookTransform_.sizeDelta
			local var_8_8 = GameFishCfg[arg_8_0.catchingThing_:GetData().fishId]
			local var_8_9

			if arg_8_0.addSpeedSkillEnable_ then
				local var_8_10 = ActivityGodEaterGoldminerHeroCfg[arg_8_0.heroID_]

				var_8_9 = var_0_4 * var_8_10.skill_param
			else
				var_8_9 = var_0_4
			end

			var_8_7.y = var_8_7.y - var_8_9 * arg_8_1 / (var_8_8.weight * 0.5)

			if #arg_8_0.movePointList_ > 1 then
				if var_8_7.y <= 0.1 then
					local var_8_11 = arg_8_0.movePointList_[#arg_8_0.movePointList_]
					local var_8_12 = arg_8_0.movePointList_[#arg_8_0.movePointList_ - 1]
					local var_8_13 = Vector2.Distance(var_8_11, var_8_12)
					local var_8_14 = var_8_11 - var_8_12

					SetActive(arg_8_0.moveLineList_[#arg_8_0.movePointList_ - 1], false)

					arg_8_0.hookTransform_.localPosition = Vector3.New(var_8_12.x, var_8_12.y, 0)
					arg_8_0.hookTransform_.up = -Vector3.New(var_8_14.x, var_8_14.y, 0):Normalize()

					table.remove(arg_8_0.movePointList_, #arg_8_0.movePointList_)

					var_8_7.y = var_8_13
				end
			elseif var_8_7.y > arg_8_0.oriHeight_ and (var_8_8.id == 10 or var_8_8.id == 11) then
				local var_8_15 = var_8_9 / var_0_4
				local var_8_16 = (var_8_8.id == 10 and var_0_8 or var_0_9) * var_8_15

				if var_8_7.y <= arg_8_0.oriHeight_ + var_8_16 then
					arg_8_0.gameView_:PlayRoleSpine("eat", 1.5)
					arg_8_0.gameView_:PlayAudio("kill")
				end
			elseif var_8_7.y <= arg_8_0.oriHeight_ then
				arg_8_0.gameView_:PlayAudio("back4")

				var_8_7.y = arg_8_0.oriHeight_

				if arg_8_0.addPointSkillEnable_ then
					local var_8_17 = ActivityGodEaterGoldminerHeroCfg[arg_8_0.heroID_]

					GoldMinerManager.GetInstance():AddScore(var_8_8.score * var_8_17.skill_param)
				else
					GoldMinerManager.GetInstance():AddScore(var_8_8.score)
				end

				GoldMinerManager.GetInstance():AddProp(var_8_8.id)

				if var_8_8.id == 12 then
					arg_8_0.gameView_:SubBoom(1)
				end

				arg_8_0.hooking_ = false
				arg_8_0.curTransThing_ = nil

				arg_8_0.hookGo_.transform:SetParent(arg_8_0.rotaryTransform_)

				arg_8_0.hookGo_.transform.localRotation = Quaternion.identity
				arg_8_0.hookGo_.transform.localPosition = Vector3.New(var_0_6.x, var_0_6.y, 0)

				arg_8_0.catchingThing_:Dispose()

				arg_8_0.catchingThing_ = nil
				arg_8_0.catchingThingIndex_ = 0
			end

			arg_8_0.hookTransform_.sizeDelta = var_8_7
		end
	elseif arg_8_0.catchingEmpty_ then
		arg_8_0:OnHookReturn()

		local var_8_18 = arg_8_0.hookTransform_.sizeDelta

		var_8_18.y = var_8_18.y - var_0_4 * arg_8_1

		if #arg_8_0.movePointList_ > 1 then
			if var_8_18.y <= 0.1 then
				local var_8_19 = arg_8_0.movePointList_[#arg_8_0.movePointList_]
				local var_8_20 = arg_8_0.movePointList_[#arg_8_0.movePointList_ - 1]
				local var_8_21 = Vector2.Distance(var_8_19, var_8_20)
				local var_8_22 = var_8_19 - var_8_20

				SetActive(arg_8_0.moveLineList_[#arg_8_0.movePointList_ - 1], false)

				arg_8_0.hookTransform_.localPosition = Vector3.New(var_8_20.x, var_8_20.y, 0)
				arg_8_0.hookTransform_.up = -Vector3.New(var_8_22.x, var_8_22.y, 0):Normalize()

				table.remove(arg_8_0.movePointList_, #arg_8_0.movePointList_)

				var_8_18.y = var_8_21
			end
		elseif var_8_18.y <= arg_8_0.oriHeight_ then
			arg_8_0.gameView_:PlayAudio("back4")

			var_8_18.y = arg_8_0.oriHeight_
			arg_8_0.catchingEmpty_ = false
			arg_8_0.hooking_ = false
			arg_8_0.curTransThing_ = nil

			arg_8_0.hookGo_.transform:SetParent(arg_8_0.rotaryTransform_)

			arg_8_0.hookGo_.transform.localRotation = Quaternion.identity
			arg_8_0.hookGo_.transform.localPosition = Vector3.New(var_0_6.x, var_0_6.y, 0)
		end

		arg_8_0.hookTransform_.sizeDelta = var_8_18
	else
		local var_8_23 = arg_8_0.hookTransform_.sizeDelta

		var_8_23.y = var_8_23.y + var_0_3 * arg_8_1
		arg_8_0.hookTransform_.sizeDelta = var_8_23

		arg_8_0:SetSpine("clue_catch", true)

		local var_8_24, var_8_25 = arg_8_0:GetHitThing()
		local var_8_26, var_8_27 = arg_8_0:GetHitThief()

		if var_8_24 > 0 then
			local var_8_28 = var_8_25:GetData()

			if var_8_28.fishId == 7 then
				if var_8_25 ~= arg_8_0.curTransThing_ then
					arg_8_0.gameView_:PlayAudio("spring")

					arg_8_0.curTransThing_ = var_8_25

					local var_8_29 = Vector2.New(arg_8_0.curTransThing_.transform_.localPosition.x, arg_8_0.curTransThing_.transform_.localPosition.y + 64)

					table.insert(arg_8_0.movePointList_, var_8_29)

					local var_8_30

					if arg_8_0.moveLineList_[#arg_8_0.movePointList_ - 1] then
						var_8_30 = arg_8_0.moveLineList_[#arg_8_0.movePointList_ - 1]
					else
						var_8_30 = GameObject.Instantiate(arg_8_0.lineGo_, GoldMinerManager.GetInstance():GetGameRoot())

						table.insert(arg_8_0.moveLineList_, var_8_30)
					end

					SetActive(var_8_30, true)

					local var_8_31 = arg_8_0.movePointList_[#arg_8_0.movePointList_ - 1]
					local var_8_32 = arg_8_0.movePointList_[#arg_8_0.movePointList_]
					local var_8_33 = (var_8_32 - var_8_31):Normalize()
					local var_8_34 = Vector2.Distance(var_8_32, var_8_31)

					var_8_30.transform.localPosition = Vector3.New(var_8_31.x, var_8_31.y, 0)
					var_8_30.transform.up = Vector3.New(var_8_33.x, var_8_33.y, 0)

					local var_8_35 = var_8_30.transform.sizeDelta

					var_8_35.y = var_8_34
					var_8_30.transform.sizeDelta = var_8_35
					arg_8_0.hookTransform_.localPosition = Vector3.New(var_8_32.x, var_8_32.y, 0)

					local var_8_36 = arg_8_0.hookTransform_.sizeDelta

					var_8_36.y = 0
					arg_8_0.hookTransform_.sizeDelta = var_8_36

					local var_8_37 = (arg_8_0.hookCurDir_ - Vector3.up * 2 * Vector3.Dot(arg_8_0.hookCurDir_, Vector3.up)):Normalize()

					arg_8_0.hookCurDir_ = var_8_37
					arg_8_0.hookTransform_.up = -Vector3.New(var_8_37.x, var_8_37.y, 0)
				end
			else
				arg_8_0.gameView_:PlayAudio("catch")

				arg_8_0.catchingThingIndex_ = var_8_24
				arg_8_0.catching_ = true

				var_8_25.transform_:SetParent(arg_8_0.fishContainer, false)

				var_8_25.transform_.pivot = Vector2(var_8_28.pivotX / 100, 1 - var_8_28.pivotY / 100)
				var_8_25.transform_.localPosition = Vector2(0, 0)

				GoldMinerManager.GetInstance():RemoveThing(var_8_25)

				arg_8_0.catchingThing_ = var_8_25
			end
		elseif var_8_26 > 0 then
			local var_8_38, var_8_39 = var_8_27:TryToGetThing()

			if var_8_38 > 0 then
				arg_8_0.catchingThingIndex_ = var_0_7
				arg_8_0.catching_ = true

				var_8_39:SetActive(true)

				local var_8_40 = var_8_39:GetData()

				var_8_39.transform_:SetParent(arg_8_0.fishContainer, false)

				var_8_39.transform_.pivot = Vector2(var_8_40.pivotX / 100, 1 - var_8_40.pivotY / 100)
				var_8_39.transform_.localPosition = Vector2(0, 0)
				arg_8_0.catchingThing_ = var_8_39
			end
		elseif arg_8_0:IsOutOfGameView() then
			arg_8_0.catchingEmpty_ = true
		end
	end
end

function var_0_0.IsOutOfGameView(arg_9_0)
	local var_9_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_9_1 = arg_9_0.hitGo_.transform:TransformPoint(0, 0, 0)
	local var_9_2 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_9_0, var_9_1)
	local var_9_3 = GoldMinerManager.GetInstance():GetGameRoot():TransformPoint(0, 0, 0)
	local var_9_4 = var_9_2 - UnityEngine.RectTransformUtility.WorldToScreenPoint(var_9_0, var_9_3)
	local var_9_5 = 1080 / Screen.height
	local var_9_6 = (var_9_5 * var_9_4).x
	local var_9_7 = -(var_9_5 * var_9_4).y

	if var_9_7 < 0 or var_9_7 > 1080 or var_9_6 < 0 or var_9_6 > 1920 then
		return true
	end

	return false
end

function var_0_0.GetHitThing(arg_10_0)
	local var_10_0, var_10_1, var_10_2, var_10_3 = arg_10_0:GetScreenCorners(arg_10_0.hitGo_.transform)
	local var_10_4 = GoldMinerManager.GetInstance():GetThing()

	for iter_10_0, iter_10_1 in ipairs(var_10_4) do
		local var_10_5 = iter_10_1:GetData()
		local var_10_6, var_10_7, var_10_8, var_10_9 = arg_10_0:GetScreenCorners(iter_10_1.hitArea_)

		if arg_10_0:HitCheckObb(var_10_0, var_10_1, var_10_2, var_10_3, var_10_6, var_10_7, var_10_8, var_10_9) then
			return iter_10_0, iter_10_1
		end
	end

	return 0
end

function var_0_0.GetHitThief(arg_11_0)
	local var_11_0, var_11_1, var_11_2, var_11_3 = arg_11_0:GetScreenCorners(arg_11_0.hitGo_.transform)
	local var_11_4 = GoldMinerManager.GetInstance():GetThief()

	for iter_11_0, iter_11_1 in ipairs(var_11_4) do
		local var_11_5 = iter_11_1:GetData()
		local var_11_6, var_11_7, var_11_8, var_11_9 = arg_11_0:GetScreenCorners(iter_11_1.hitArea_)

		if arg_11_0:HitCheckObb(var_11_0, var_11_1, var_11_2, var_11_3, var_11_6, var_11_7, var_11_8, var_11_9) then
			return iter_11_0, iter_11_1
		end
	end

	return 0
end

function var_0_0.GetScreenCorners(arg_12_0, arg_12_1)
	local var_12_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	arg_12_1:GetWorldCorners(arg_12_0.corners)

	local var_12_1 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_12_0, arg_12_0.corners[0])
	local var_12_2 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_12_0, arg_12_0.corners[1])
	local var_12_3 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_12_0, arg_12_0.corners[2])
	local var_12_4 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_12_0, arg_12_0.corners[3])

	return var_12_1, var_12_2, var_12_3, var_12_4
end

function var_0_0.HitCheckObb(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5, arg_13_6, arg_13_7, arg_13_8)
	local var_13_0 = {
		Vector2.Normalize(arg_13_2 - arg_13_1),
		Vector2.Normalize(arg_13_3 - arg_13_2),
		Vector2.Normalize(arg_13_6 - arg_13_5),
		Vector2.Normalize(arg_13_7 - arg_13_6)
	}
	local var_13_1 = (arg_13_1 + arg_13_3) / 2
	local var_13_2 = (arg_13_5 + arg_13_7) / 2
	local var_13_3 = Vector2.New(var_13_1.x - var_13_2.x, var_13_1.y - var_13_2.y)
	local var_13_4 = Vector2.New(arg_13_1.x - var_13_1.x, arg_13_1.y - var_13_1.y)
	local var_13_5 = Vector2.New(arg_13_2.x - var_13_1.x, arg_13_2.y - var_13_1.y)
	local var_13_6 = Vector2.New(arg_13_5.x - var_13_2.x, arg_13_5.y - var_13_2.y)
	local var_13_7 = Vector2.New(arg_13_6.x - var_13_2.x, arg_13_6.y - var_13_2.y)
	local var_13_8 = false

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_9 = math.abs(iter_13_1.x * var_13_3.x + iter_13_1.y * var_13_3.y)
		local var_13_10 = math.abs(iter_13_1.x * var_13_4.x + iter_13_1.y * var_13_4.y)
		local var_13_11 = math.abs(iter_13_1.x * var_13_5.x + iter_13_1.y * var_13_5.y)
		local var_13_12 = math.max(var_13_10, var_13_11)
		local var_13_13 = math.abs(iter_13_1.x * var_13_6.x + iter_13_1.y * var_13_6.y)
		local var_13_14 = math.abs(iter_13_1.x * var_13_7.x + iter_13_1.y * var_13_7.y)

		if var_13_9 > var_13_12 + math.max(var_13_13, var_13_14) then
			var_13_8 = true

			break
		end
	end

	return not var_13_8
end

function var_0_0.RegisterBackFunc(arg_14_0, arg_14_1)
	arg_14_0.backFunc_ = arg_14_1
end

function var_0_0.OnHookReturn(arg_15_0)
	arg_15_0:SetSpine("clue_take", true)

	if not arg_15_0.playBackAudio_ then
		if arg_15_0.addSpeedSkillEnable_ then
			arg_15_0.gameView_:PlayAudio("back1")
			arg_15_0.gameView_:PlayAudio("back2")
		else
			arg_15_0.gameView_:PlayAudio("back1")
			arg_15_0.gameView_:PlayAudio("back3")
		end

		arg_15_0.playBackAudio_ = true
	end

	if not arg_15_0.isCallBackFunc_ and arg_15_0.backFunc_ then
		arg_15_0.backFunc_()

		arg_15_0.isCallBackFunc_ = true
	end
end

function var_0_0.GetTmpCorners(arg_16_0)
	if arg_16_0.corners == nil then
		arg_16_0.corners = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	end
end

function var_0_0.Reset(arg_17_0)
	if arg_17_0.catchingThing_ then
		arg_17_0.catchingThing_:Dispose()

		arg_17_0.catchingThing_ = nil
	end

	local var_17_0 = arg_17_0.hookTransform_.sizeDelta

	if var_17_0.y <= arg_17_0.oriHeight_ then
		var_17_0.y = arg_17_0.oriHeight_
	end

	arg_17_0.hooking_ = false
	arg_17_0.curTransThing_ = nil

	arg_17_0.hookGo_.transform:SetParent(arg_17_0.rotaryTransform_)

	arg_17_0.hookGo_.transform.localRotation = Quaternion.identity
	arg_17_0.hookGo_.transform.localPosition = Vector3.New(var_0_6.x, var_0_6.y, 0)
	arg_17_0.catchingThingIndex_ = 0
	arg_17_0.hookTransform_.sizeDelta = var_17_0

	local var_17_1 = arg_17_0.rotaryTransform_.eulerAngles

	var_17_1.z = 0
	arg_17_0.rotaryTransform_.eulerAngles = var_17_1
end

function var_0_0.SetSpine(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_1 == arg_18_0.animName_ then
		return
	end

	arg_18_0.animName_ = arg_18_0.hookSpine_.AnimationState:GetCurrent(0).Animation.Name

	arg_18_0.hookSpine_.AnimationState:SetAnimation(0, arg_18_1, arg_18_2)

	if arg_18_3 then
		local var_18_0

		local function var_18_1()
			arg_18_0.hookSpine_.AnimationState.Complete = arg_18_0.hookSpine_.AnimationState.Complete - var_18_1

			arg_18_3()
		end

		arg_18_0.hookSpine_.AnimationState.Complete = arg_18_0.hookSpine_.AnimationState.Complete + var_18_1
	end
end

function var_0_0.Dispose(arg_20_0)
	if arg_20_0.catchingThing_ then
		arg_20_0.catchingThing_:Dispose()

		arg_20_0.catchingThing_ = nil
	end

	local var_20_0 = arg_20_0.hookTransform_.sizeDelta

	if var_20_0.y <= arg_20_0.oriHeight_ then
		var_20_0.y = arg_20_0.oriHeight_
	end

	arg_20_0.hookTransform_.sizeDelta = var_20_0

	var_0_0.super.Dispose(arg_20_0)
end

return var_0_0
