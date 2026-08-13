class = var_0_10000

local var_0_0 = var_0_10000("CrossRoadRole")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._tf = arg_1_1
	arg_1_0._runningData = arg_1_4
	arg_1_0._tpl = arg_1_3
	arg_1_0.id = arg_1_2
	arg_1_0.fa = arg_1_2
	arg_1_0.startTime = 0
	CrossRoadGameConst = var_5
	arg_1_0.speed = var_5.CHILD_SPEED
	arg_1_0.target = nil
	GetComponent = var_5
	findTF = var_1_10006
	arg_1_0.spineAnimUI = var_5(var_1_10006(arg_1_0._tf, "spine"), "SpineAnimUI")
	arg_1_0.playingAction = nil

	local var_1_0 = arg_1_0._tf

	arg_1_0.arrowGroup = var_5.Find(var_1_0, "player_arrow/ad/arrow")

	local var_1_1 = arg_1_0.arrowGroup

	arg_1_0.selectTF = var_5.Find(var_1_1, "select")

	local var_1_2 = arg_1_0.arrowGroup

	arg_1_0.angryTF = var_5.Find(var_1_2, "angry")

	local var_1_3 = arg_1_0.angryTF
	local var_1_4 = var_5.GetComponent

	typeof = var_7
	Animation = var_8
	arg_1_0.angryAni = var_1_4(var_1_3, var_7(var_8))

	local var_1_5 = arg_1_0.selectTF
	local var_1_6 = var_5.GetComponent

	typeof = var_7
	Animation = var_8
	arg_1_0.selectAni = var_1_6(var_1_5, var_7(var_8))
	arg_1_0.direct = {
		-1,
		0
	}
	CrossRoadGameConst = var_5
	arg_1_0.trackName = var_5.BACK_ROAD_NAME
	arg_1_0.runState = nil
	arg_1_0.playerHaveSelect = false
	arg_1_0.angryTime = 0
	arg_1_0.lastSelectTime = 0
	arg_1_0.startAngryTime = 0
	arg_1_0.lastAngryRollTime = 0
	arg_1_0.lastXuanWoRollTime = 0

	arg_1_0:setActionNormal()

	return
end

function var_0_0.GetRoleRectPoint(arg_2_0)
	local var_2_0 = arg_2_0:GetPosition()
	local var_2_1 = arg_2_0._tf.rect

	return var_2_0.x - var_2_1.width / 2, var_2_0.y - var_2_1.height / 2, var_2_0.x + var_2_1.width / 2, var_2_0.y + var_2_1.height / 2
end

function var_0_0.SetRoleActionByState(arg_3_0, arg_3_1)
	if arg_3_1 == nil then
		arg_3_1 = arg_3_0:GetRunState()
	end

	CrossRoadGameConst = var_1_10002

	local var_3_1

	if arg_3_1 == var_1_10002.SHIP_STATE.stop then
		local var_3_0 = arg_3_0

		var_3_1 = arg_3_0.SetAction
		CrossRoadGameConst = var_1_10004

		var_3_1(var_3_0, var_1_10004.SHIP_STATE_ACTION.normal, 0)
	else
		CrossRoadGameConst = var_3_1

		local var_3_3

		if arg_3_1 == var_3_1.SHIP_STATE.walk then
			local var_3_2 = arg_3_0

			var_3_3 = arg_3_0.SetAction
			CrossRoadGameConst = var_1_10004

			var_3_3(var_3_2, var_1_10004.SHIP_STATE_ACTION.walk, 0)
		else
			CrossRoadGameConst = var_3_3

			if arg_3_1 == var_3_3.SHIP_STATE.crash then
				local var_3_4 = arg_3_0
				local var_3_5 = arg_3_0.SetAction

				CrossRoadGameConst = var_1_10004

				var_3_5(var_3_4, var_1_10004.SHIP_STATE_ACTION.crash, 0)
			end
		end
	end

	return
end

function var_0_0.RandomAngryTime(arg_4_0)
	math = var_1_10001

	local var_4_0 = var_1_10001.random

	CrossRoadGameConst = var_1_10002

	local var_4_1 = var_1_10002.CHILD_ANGER_TIME[1]

	CrossRoadGameConst = var_1_10003
	arg_4_0.angryTime = var_4_0(var_4_1, var_1_10003.CHILD_ANGER_TIME[2])

	return
end

function var_0_0.CanAngryStart(arg_5_0, arg_5_1)
	if arg_5_0.id == arg_5_0.fa then
		local var_5_0 = arg_5_0.runState

		CrossRoadGameConst = var_5_1

		local var_5_1

		if var_5_0 ~= var_5_1.SHIP_STATE.stop then
			var_5_1 = arg_5_0

			arg_5_0.SetAngryActive(var_5_1, false)

			arg_5_0.startAngryTime = nil

			return false
		end

		if arg_5_0.startAngryTime ~= nil then
			return true
		end

		local var_5_2 = arg_5_0.lastSelectTime

		CrossRoadGameConst = var_5_1

		if arg_5_1 > var_5_2 + var_5_1.CAN_ANGRY_TIME then
			local var_5_3 = arg_5_0.lastAngryRollTime

			CrossRoadGameConst = var_3

			if arg_5_1 > var_5_3 + var_3.ONCE_ANGRY_TIME then
				if arg_5_0:RollAngryState() then
					arg_5_0.startAngryTime = arg_5_1

					arg_5_0:SetAngryActive(true)
				else
					arg_5_0.lastAngryRollTime = arg_5_1
				end
			end

			return true
		else
			arg_5_0.startAngryTime = nil
		end

		return false
	end
end

function var_0_0.CanAngryMove(arg_6_0, arg_6_1)
	if arg_6_0.startAngryTime == nil then
		return
	end

	if arg_6_1 > arg_6_0.startAngryTime + arg_6_0.angryTime then
		return true
	end

	return
end

function var_0_0.RollAngryState(arg_7_0)
	math = var_1_10001

	local var_7_0 = var_1_10001.random(1, 100)

	CrossRoadGameConst = var_2

	return var_7_0 < var_2.ANGRY_PERCENT
end

function var_0_0.SetSelectTime(arg_8_0, arg_8_1)
	arg_8_0.lastSelectTime = arg_8_1
	arg_8_0.startAngryTime = nil

	return
end

function var_0_0.SetAction(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_0.playingAction == arg_9_1 then
		return
	end

	arg_9_0.playingAction = arg_9_1

	local var_9_0 = arg_9_0.spineAnimUI

	var_3.SetAction(var_9_0, arg_9_1, arg_9_2)

	return
end

function var_0_0.SetActionCallBack(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._spineAnimUI

	var_2.SetActionCallBack(var_10_0, arg_10_1)

	return
end

function var_0_0.setActionNormal(arg_11_0)
	arg_11_0:SetAction("normal", 0)

	return
end

function var_0_0.SetActive(arg_12_0, arg_12_1)
	setActive = var_1_10002

	var_1_10002(arg_12_0._tf, arg_12_1)

	return
end

function var_0_0.SetAngryActive(arg_13_0, arg_13_1)
	if arg_13_1 then
		local var_13_0 = arg_13_0.angryAni

		var_1_10002.Play(var_13_0, "anim_CrossRoadGameUI_pac_angry")
	end

	setActive = var_1_10002

	var_1_10002(arg_13_0.angryTF, arg_13_1)

	return
end

function var_0_0.SetSelectActive(arg_14_0, arg_14_1)
	if arg_14_1 then
		local var_14_0 = arg_14_0.selectAni

		var_1_10002.Play(var_14_0, "anim_CrossRoadGameUI_pac_select")
	end

	setActive = var_1_10002

	var_1_10002(arg_14_0.selectTF, arg_14_1)

	return
end

function var_0_0.SetParent(arg_15_0, arg_15_1)
	setParent = var_1_10002

	var_1_10002(arg_15_0._tf, arg_15_1, false)

	return
end

function var_0_0.SetScale(arg_16_0, arg_16_1)
	arg_16_0._tf.localScale = arg_16_1

	return
end

function var_0_0.SetPosition(arg_17_0, arg_17_1)
	arg_17_0._tf.anchoredPosition = arg_17_1

	return
end

function var_0_0.GetPosition(arg_18_0)
	return arg_18_0._tf.anchoredPosition
end

function var_0_0.GetHW(arg_19_0)
	return arg_19_0._tf.rect.width, arg_19_0._tf.rect.height
end

function var_0_0.SetTarget(arg_20_0, arg_20_1)
	arg_20_0.target = arg_20_1

	return
end

function var_0_0.GetTarget(arg_21_0)
	return arg_21_0.target
end

function var_0_0.GetDirect(arg_22_0)
	return arg_22_0.direct
end

function var_0_0.SetSpeed(arg_23_0, arg_23_1)
	arg_23_0.speed = arg_23_1

	return
end

function var_0_0.GetSpeed(arg_24_0)
	return arg_24_0.speed
end

function var_0_0.SetRunState(arg_25_0, arg_25_1)
	arg_25_0.runState = arg_25_1

	return
end

function var_0_0.GetRunState(arg_26_0)
	return arg_26_0.runState
end

function var_0_0.SetStartTime(arg_27_0, arg_27_1)
	arg_27_0.startTime = arg_27_1

	return
end

function var_0_0.GetStartTime(arg_28_0)
	return arg_28_0.startTime
end

function var_0_0.GetFatherID(arg_29_0)
	return arg_29_0.fa
end

function var_0_0.SetFatherID(arg_30_0, arg_30_1)
	arg_30_0.fa = arg_30_1

	return
end

function var_0_0.GetID(arg_31_0)
	return arg_31_0.id
end

function var_0_0.SetID(arg_32_0, arg_32_1)
	arg_32_0.id = arg_32_1

	return
end

function var_0_0.GetTrack(arg_33_0)
	return arg_33_0.trackName
end

function var_0_0.SetTrack(arg_34_0, arg_34_1)
	arg_34_0.trackName = arg_34_1

	return
end

function var_0_0.SetPlayerHaveSelect(arg_35_0, arg_35_1)
	arg_35_0.playerHaveSelect = arg_35_1

	return
end

function var_0_0.GetXuanWoRollTime(arg_36_0)
	return arg_36_0.lastXuanWoRollTime
end

function var_0_0.SetXuanWRollTime(arg_37_0, arg_37_1)
	arg_37_0.lastXuanWoRollTime = arg_37_1

	return
end

function var_0_0.GetPlayerHaveSelect(arg_38_0)
	return arg_38_0.playerHaveSelect
end

function var_0_0.Clear(arg_39_0)
	arg_39_0:SetParent(arg_39_0._tpl)

	local var_39_0 = arg_39_0._runningData

	var_1.CrashDeadRole(var_39_0)

	return
end

return var_0_0
