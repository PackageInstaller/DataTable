local var_0_0 = class("GoldMinerThief", ReduxView)
local var_0_1 = 540
local var_0_2 = 1200
local var_0_3 = 1
local var_0_4 = 70
local var_0_5 = 5
local var_0_6 = {
	idle = "idle",
	back = "hunter_back",
	pat = "hunter_pat"
}

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0.angleSpeed_ = 60
	arg_2_0.hooking_ = false
	arg_2_0.sleeping_ = true
	arg_2_0.curSleepTime_ = 0
	arg_2_0.catchingThingID_ = 0
	arg_2_0.catchingThingDir_ = nil
	arg_2_0.catchingThing_ = nil
	arg_2_0.catchThingList_ = {}
	arg_2_0.catchThingItemList_ = {}
	arg_2_0.talkTime_ = 0

	if arg_2_0.corners == nil then
		arg_2_0.corners = System.Array.CreateInstance(typeof(UnityEngine.Vector3), 4)
	end

	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.oriHeight_ = arg_3_0.hookTransform_.rect.height
	arg_3_0.thingNumController_ = arg_3_0.controllerEx_:GetController("thingNum")
	arg_3_0.spine_ = arg_3_0.spineGo_:GetComponent("Spine.Unity.SkeletonGraphic")
	arg_3_0.spine_.AnimationState.Complete = arg_3_0.spine_.AnimationState.Complete + function()
		arg_3_0.spine_.AnimationState:SetAnimation(0, var_0_6.idle, true)
	end
	arg_3_0.hookSpine_ = arg_3_0.hookSpineGo_:GetComponent("Spine.Unity.SkeletonGraphic")
end

function var_0_0.AddUIListener(arg_5_0)
	return
end

function var_0_0.AddEventListeners(arg_6_0)
	return
end

function var_0_0.SetData(arg_7_0, arg_7_1)
	arg_7_0.data_ = arg_7_1
	arg_7_0.hitArea_.sizeDelta = Vector2(arg_7_0.data_.hitWidth, arg_7_0.data_.hitHeight)

	arg_7_0:UpdateThingView()
end

function var_0_0.GetData(arg_8_0)
	return arg_8_0.data_
end

function var_0_0.TryToGetThing(arg_9_0)
	local var_9_0 = #arg_9_0.catchThingList_

	if var_9_0 >= 1 then
		local var_9_1 = arg_9_0.catchThingList_[var_9_0]
		local var_9_2 = arg_9_0.catchThingItemList_[var_9_0]

		GoldMinerManager.GetInstance():AddReturnThiefThing(var_9_1)
		table.remove(arg_9_0.catchThingList_, var_9_0)
		table.remove(arg_9_0.catchThingItemList_, var_9_0)
		SetActive(arg_9_0.talkGo_, true)

		arg_9_0.talkTime_ = 2

		local var_9_3 = math.random(1, 2)

		arg_9_0.talkText_.text = GetTips("GOLDMINER_THIEF_CHAT_" .. var_9_3)

		arg_9_0:UpdateThingView()

		return var_9_1, var_9_2
	end

	return 0
end

function var_0_0.UpdateThingView(arg_10_0)
	local var_10_0 = #arg_10_0.catchThingList_

	if var_10_0 >= 2 then
		arg_10_0.thingNumController_:SetSelectedState("2")

		arg_10_0.iconLastImage_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/V4_2_GodEaterUI/V4_2_GodEaterUI_GoldenMiner/" .. arg_10_0.catchThingList_[var_10_0])
		arg_10_0.iconSecondImage_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/V4_2_GodEaterUI/V4_2_GodEaterUI_GoldenMiner/" .. arg_10_0.catchThingList_[var_10_0 - 1])
	elseif var_10_0 == 1 then
		arg_10_0.thingNumController_:SetSelectedState("1")

		arg_10_0.iconLastImage_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/V4_2_GodEaterUI/V4_2_GodEaterUI_GoldenMiner/" .. arg_10_0.catchThingList_[var_10_0])
	else
		arg_10_0.thingNumController_:SetSelectedState("0")
	end
end

function var_0_0.UpdateView(arg_11_0)
	return
end

function var_0_0.Update(arg_12_0, arg_12_1)
	if arg_12_0.talkTime_ > 0 then
		arg_12_0.talkTime_ = arg_12_0.talkTime_ - arg_12_1

		if arg_12_0.talkTime_ <= 0 then
			arg_12_0.talkTime_ = 0

			SetActive(arg_12_0.talkGo_, false)
		end
	end

	if arg_12_0.sleeping_ then
		arg_12_0.isCallStartFunc_ = false
		arg_12_0.isCallBackFunc_ = false
		arg_12_0.curSleepTime_ = arg_12_0.curSleepTime_ + arg_12_1

		if arg_12_0.curSleepTime_ > var_0_5 then
			arg_12_0.sleeping_ = false
			arg_12_0.curSleepTime_ = 0
		end

		local var_12_0 = arg_12_0.rotaryTransform_.eulerAngles
		local var_12_1 = arg_12_1 * arg_12_0.angleSpeed_ * var_0_3 + var_12_0.z

		var_12_0.z = var_12_1
		arg_12_0.rotaryTransform_.eulerAngles = var_12_0

		if var_12_1 > 0 and var_12_1 <= 180 then
			if var_12_1 > var_0_4 then
				var_0_3 = -1
			end
		elseif var_12_1 > 180 and var_12_1 <= 360 and var_12_1 - 360 < -var_0_4 then
			var_0_3 = 1
		end
	elseif not arg_12_0.hooking_ then
		if arg_12_0.catchingThingID_ == 0 then
			local var_12_2 = GoldMinerManager.GetInstance():GetThing()
			local var_12_3 = 0
			local var_12_4 = 0

			for iter_12_0, iter_12_1 in pairs(var_12_2) do
				local var_12_5 = iter_12_1:GetData()

				if var_12_5.moveable == 0 and var_12_5.fishId ~= 7 then
					if var_12_3 == 0 then
						var_12_3 = iter_12_0

						local var_12_6 = iter_12_1:GetLocalPosition()

						var_12_4 = Vector3.Distance(arg_12_0.transform_.localPosition, var_12_6)
					else
						local var_12_7 = iter_12_1:GetLocalPosition()
						local var_12_8 = Vector3.Distance(arg_12_0.transform_.localPosition, var_12_7)

						if var_12_8 < var_12_4 then
							var_12_3 = iter_12_0
							var_12_4 = var_12_8
						end
					end
				end
			end

			if var_12_3 == 0 then
				arg_12_0.sleeping_ = true
			else
				local var_12_9 = var_12_2[var_12_3]

				arg_12_0.catchingThingID_ = var_12_9:GetID()
				arg_12_0.catchingThingDir_ = Vector3.Normalize(var_12_9:GetLocalPosition() - arg_12_0.transform_.localPosition)
			end
		elseif GoldMinerManager.GetInstance():ThingIsActive(arg_12_0.catchingThingID_) then
			local var_12_10 = arg_12_0.rotaryTransform_.eulerAngles
			local var_12_11 = arg_12_1 * arg_12_0.angleSpeed_ * var_0_3 + var_12_10.z

			var_12_10.z = var_12_11
			arg_12_0.rotaryTransform_.eulerAngles = var_12_10

			if var_12_11 > 0 and var_12_11 <= 180 then
				if var_12_11 > var_0_4 then
					var_0_3 = -1
				end
			elseif var_12_11 > 180 and var_12_11 <= 360 and var_12_11 - 360 < -var_0_4 then
				var_0_3 = 1
			end

			local var_12_12 = Vector3.Normalize(arg_12_0.hookTransform_.up * -1)

			if Vector3.Angle(var_12_12, arg_12_0.catchingThingDir_) < 10 then
				arg_12_0.hooking_ = true
				arg_12_0.rotaryTransform_.up = arg_12_0.catchingThingDir_ * -1
			end

			arg_12_0:SetSpine("clue_idle", true)
		else
			arg_12_0.catchingThingID_ = 0
		end
	elseif arg_12_0.catchingThing_ ~= nil then
		arg_12_0.catching_ = false

		local var_12_13 = arg_12_0.rotaryTransform_.eulerAngles

		if var_12_13.z >= 0 and var_12_13.z < 90 then
			local var_12_14 = arg_12_0.hitImageTransform_.localScale

			var_12_14.x = 1
			arg_12_0.hitImageTransform_.localScale = var_12_14

			local var_12_15 = arg_12_0.fishContainer.localScale

			var_12_15.x = 1
			arg_12_0.fishContainer.localScale = var_12_15
		else
			local var_12_16 = arg_12_0.hitImageTransform_.localScale

			var_12_16.x = -1
			arg_12_0.hitImageTransform_.localScale = var_12_16

			local var_12_17 = arg_12_0.fishContainer.localScale

			var_12_17.x = -1
			arg_12_0.fishContainer.localScale = var_12_17
		end

		if not arg_12_0.catching_ then
			arg_12_0:OnHookReturn()

			local var_12_18 = arg_12_0.hookTransform_.sizeDelta
			local var_12_19 = GameFishCfg[arg_12_0.catchingThing_:GetData().fishId]

			var_12_18.y = var_12_18.y - var_0_2 * arg_12_1 / (var_12_19.weight * 0.5)

			if var_12_18.y <= arg_12_0.oriHeight_ then
				var_12_18.y = arg_12_0.oriHeight_

				GoldMinerManager.GetInstance():AddThiefThing(var_12_19.id)
				table.insert(arg_12_0.catchThingList_, var_12_19.id)
				table.insert(arg_12_0.catchThingItemList_, arg_12_0.catchingThing_)
				arg_12_0:UpdateThingView()

				arg_12_0.hooking_ = false

				arg_12_0.catchingThing_:SetActive(false)

				arg_12_0.sleeping_ = true
				arg_12_0.catchingThing_ = nil
				arg_12_0.catchingThingID_ = 0
				arg_12_0.catchingThingDir_ = nil
			end

			arg_12_0.hookTransform_.sizeDelta = var_12_18
		end
	elseif arg_12_0.catchingEmpty_ then
		arg_12_0:OnHookReturn()

		local var_12_20 = arg_12_0.hookTransform_.sizeDelta

		var_12_20.y = var_12_20.y - var_0_2 * arg_12_1

		if var_12_20.y <= arg_12_0.oriHeight_ then
			var_12_20.y = arg_12_0.oriHeight_
			arg_12_0.catchingEmpty_ = false
			arg_12_0.hooking_ = false
			arg_12_0.sleeping_ = true
			arg_12_0.catchingThing_ = nil
			arg_12_0.catchingThingID_ = 0
			arg_12_0.catchingThingDir_ = nil
		end

		arg_12_0.hookTransform_.sizeDelta = var_12_20
	else
		arg_12_0:OnHookStart()

		local var_12_21 = arg_12_0.hookTransform_.sizeDelta

		var_12_21.y = var_12_21.y + var_0_1 * arg_12_1
		arg_12_0.hookTransform_.sizeDelta = var_12_21

		local var_12_22 = arg_12_0:GetHitThing()

		if var_12_22 then
			local var_12_23 = var_12_22:GetData()

			if var_12_23.fishId == 7 then
				return
			end

			arg_12_0.catching_ = true

			var_12_22.transform_:SetParent(arg_12_0.fishContainer, false)

			var_12_22.transform_.pivot = Vector2(var_12_23.pivotX / 100, 1 - var_12_23.pivotY / 100)
			var_12_22.transform_.localPosition = Vector2(0, 0)

			GoldMinerManager.GetInstance():RemoveThing(var_12_22)

			arg_12_0.catchingThing_ = var_12_22
		elseif arg_12_0:IsOutOfGameView() then
			arg_12_0.catchingEmpty_ = true
		end
	end
end

function var_0_0.IsOutOfGameView(arg_13_0)
	local var_13_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera
	local var_13_1 = arg_13_0.hitGo_.transform:TransformPoint(0, 0, 0)
	local var_13_2 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_13_0, var_13_1)
	local var_13_3 = GoldMinerManager.GetInstance():GetGameRoot():TransformPoint(0, 0, 0)
	local var_13_4 = var_13_2 - UnityEngine.RectTransformUtility.WorldToScreenPoint(var_13_0, var_13_3)
	local var_13_5 = 1080 / Screen.height
	local var_13_6 = (var_13_5 * var_13_4).x
	local var_13_7 = -(var_13_5 * var_13_4).y

	if var_13_7 < 0 or var_13_7 > 1080 or var_13_6 < 0 or var_13_6 > 1920 then
		return true
	end

	return false
end

function var_0_0.GetHitThing(arg_14_0)
	local var_14_0, var_14_1, var_14_2, var_14_3 = arg_14_0:GetScreenCorners(arg_14_0.hitGo_.transform)
	local var_14_4 = GoldMinerManager.GetInstance():GetThing()

	for iter_14_0, iter_14_1 in ipairs(var_14_4) do
		if iter_14_1:GetID() == arg_14_0.catchingThingID_ then
			local var_14_5 = iter_14_1:GetData()
			local var_14_6, var_14_7, var_14_8, var_14_9 = arg_14_0:GetScreenCorners(iter_14_1.hitArea_)

			if arg_14_0:HitCheckObb(var_14_0, var_14_1, var_14_2, var_14_3, var_14_6, var_14_7, var_14_8, var_14_9) then
				return iter_14_1
			end
		end
	end

	return nil
end

function var_0_0.HitCheckObb(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5, arg_15_6, arg_15_7, arg_15_8)
	local var_15_0 = {
		Vector2.Normalize(arg_15_2 - arg_15_1),
		Vector2.Normalize(arg_15_3 - arg_15_2),
		Vector2.Normalize(arg_15_6 - arg_15_5),
		Vector2.Normalize(arg_15_7 - arg_15_6)
	}
	local var_15_1 = (arg_15_1 + arg_15_3) / 2
	local var_15_2 = (arg_15_5 + arg_15_7) / 2
	local var_15_3 = Vector2.New(var_15_1.x - var_15_2.x, var_15_1.y - var_15_2.y)
	local var_15_4 = Vector2.New(arg_15_1.x - var_15_1.x, arg_15_1.y - var_15_1.y)
	local var_15_5 = Vector2.New(arg_15_2.x - var_15_1.x, arg_15_2.y - var_15_1.y)
	local var_15_6 = Vector2.New(arg_15_5.x - var_15_2.x, arg_15_5.y - var_15_2.y)
	local var_15_7 = Vector2.New(arg_15_6.x - var_15_2.x, arg_15_6.y - var_15_2.y)
	local var_15_8 = false

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_9 = math.abs(iter_15_1.x * var_15_3.x + iter_15_1.y * var_15_3.y)
		local var_15_10 = math.abs(iter_15_1.x * var_15_4.x + iter_15_1.y * var_15_4.y)
		local var_15_11 = math.abs(iter_15_1.x * var_15_5.x + iter_15_1.y * var_15_5.y)
		local var_15_12 = math.max(var_15_10, var_15_11)
		local var_15_13 = math.abs(iter_15_1.x * var_15_6.x + iter_15_1.y * var_15_6.y)
		local var_15_14 = math.abs(iter_15_1.x * var_15_7.x + iter_15_1.y * var_15_7.y)

		if var_15_9 > var_15_12 + math.max(var_15_13, var_15_14) then
			var_15_8 = true

			break
		end
	end

	return not var_15_8
end

function var_0_0.GetScreenCorners(arg_16_0, arg_16_1)
	local var_16_0 = manager.ui.canvas:GetComponent(typeof(Canvas)).worldCamera

	arg_16_1:GetWorldCorners(arg_16_0.corners)

	local var_16_1 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_16_0, arg_16_0.corners[0])
	local var_16_2 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_16_0, arg_16_0.corners[1])
	local var_16_3 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_16_0, arg_16_0.corners[2])
	local var_16_4 = UnityEngine.RectTransformUtility.WorldToScreenPoint(var_16_0, arg_16_0.corners[3])

	return var_16_1, var_16_2, var_16_3, var_16_4
end

function var_0_0.OnHookStart(arg_17_0)
	arg_17_0:SetSpine("clue_catch", true)

	if not arg_17_0.isCallStartFunc_ then
		arg_17_0.isCallStartFunc_ = true

		arg_17_0.spine_.AnimationState:SetAnimation(0, var_0_6.pat, false)
	end
end

function var_0_0.OnHookReturn(arg_18_0)
	arg_18_0:SetSpine("clue_take", true)

	if not arg_18_0.isCallBackFunc_ then
		arg_18_0.isCallBackFunc_ = true

		arg_18_0.spine_.AnimationState:SetAnimation(0, var_0_6.back, false)
	end
end

function var_0_0.SetSpine(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if arg_19_1 == arg_19_0.animName_ then
		return
	end

	arg_19_0.animName_ = arg_19_0.hookSpine_.AnimationState:GetCurrent(0).Animation.Name

	arg_19_0.hookSpine_.AnimationState:SetAnimation(0, arg_19_1, arg_19_2)

	if arg_19_3 then
		local var_19_0

		local function var_19_1()
			arg_19_0.hookSpine_.AnimationState.Complete = arg_19_0.hookSpine_.AnimationState.Complete - var_19_1

			arg_19_3()
		end

		arg_19_0.hookSpine_.AnimationState.Complete = arg_19_0.hookSpine_.AnimationState.Complete + var_19_1
	end
end

function var_0_0.Dispose(arg_21_0)
	if arg_21_0.catchingThing_ then
		arg_21_0.catchingThing_:Dispose()

		arg_21_0.catchingThing_ = nil
	end

	for iter_21_0, iter_21_1 in pairs(arg_21_0.catchThingItemList_) do
		iter_21_1:Dispose()
	end

	arg_21_0.catchThingItemList_ = nil

	Object.Destroy(arg_21_0.gameObject_)
	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
