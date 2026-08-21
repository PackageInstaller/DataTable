local var_0_0 = class("CrossRoadRole")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._tf = arg_1_1
	arg_1_0._runningData = arg_1_4
	arg_1_0._tpl = arg_1_3
	arg_1_0.id = arg_1_2
	arg_1_0.fa = arg_1_2
	arg_1_0.startTime = 0
	arg_1_0.speed = CrossRoadGameConst.CHILD_SPEED
	arg_1_0.target = nil
	arg_1_0.spineAnimUI = GetComponent(findTF(arg_1_0._tf, "spine"), "SpineAnimUI")
	arg_1_0.playingAction = nil
	arg_1_0.arrowGroup = arg_1_0._tf:Find("player_arrow/ad/arrow")
	arg_1_0.selectTF = arg_1_0.arrowGroup:Find("select")
	arg_1_0.angryTF = arg_1_0.arrowGroup:Find("angry")
	arg_1_0.angryAni = arg_1_0.angryTF:GetComponent(typeof(Animation))
	arg_1_0.selectAni = arg_1_0.selectTF:GetComponent(typeof(Animation))
	arg_1_0.direct = {
		-1,
		0
	}
	arg_1_0.trackName = CrossRoadGameConst.BACK_ROAD_NAME
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

	return var_2_0.x - arg_2_0._tf.rect.width / 2, var_2_0.y - arg_2_0._tf.rect.height / 2, var_2_0.x + arg_2_0._tf.rect.width / 2, var_2_0.y + arg_2_0._tf.rect.height / 2
end

function var_0_0.SetRoleActionByState(arg_3_0, arg_3_1)
	if arg_3_1 == nil then
		arg_3_1 = arg_3_0:GetRunState()
	end

	if arg_3_1 == CrossRoadGameConst.SHIP_STATE.stop then
		arg_3_0:SetAction(CrossRoadGameConst.SHIP_STATE_ACTION.normal, 0)
	elseif arg_3_1 == CrossRoadGameConst.SHIP_STATE.walk then
		arg_3_0:SetAction(CrossRoadGameConst.SHIP_STATE_ACTION.walk, 0)
	elseif arg_3_1 == CrossRoadGameConst.SHIP_STATE.crash then
		arg_3_0:SetAction(CrossRoadGameConst.SHIP_STATE_ACTION.crash, 0)
	end

	return
end

function var_0_0.RandomAngryTime(arg_4_0)
	arg_4_0.angryTime = math.random(CrossRoadGameConst.CHILD_ANGER_TIME[1], CrossRoadGameConst.CHILD_ANGER_TIME[2])

	return
end

function var_0_0.CanAngryStart(arg_5_0, arg_5_1)
	if arg_5_0.id ~= arg_5_0.fa or arg_5_0.runState ~= CrossRoadGameConst.SHIP_STATE.stop then
		arg_5_0:SetAngryActive(false)

		arg_5_0.startAngryTime = nil

		return false
	end

	if arg_5_0.startAngryTime ~= nil then
		return true
	end

	if arg_5_1 > arg_5_0.lastSelectTime + CrossRoadGameConst.CAN_ANGRY_TIME then
		if arg_5_1 > arg_5_0.lastAngryRollTime + CrossRoadGameConst.ONCE_ANGRY_TIME then
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
	return math.random(1, 100) < CrossRoadGameConst.ANGRY_PERCENT
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

	arg_9_0.spineAnimUI:SetAction(arg_9_1, arg_9_2)

	return
end

function var_0_0.SetActionCallBack(arg_10_0, arg_10_1)
	arg_10_0._spineAnimUI:SetActionCallBack(arg_10_1)

	return
end

function var_0_0.setActionNormal(arg_11_0)
	arg_11_0:SetAction("normal", 0)

	return
end

function var_0_0.SetActive(arg_12_0, arg_12_1)
	setActive(arg_12_0._tf, arg_12_1)

	return
end

function var_0_0.SetAngryActive(arg_13_0, arg_13_1)
	if arg_13_1 then
		arg_13_0.angryAni:Play("anim_CrossRoadGameUI_pac_angry")
	end

	setActive(arg_13_0.angryTF, arg_13_1)

	return
end

function var_0_0.SetSelectActive(arg_14_0, arg_14_1)
	if arg_14_1 then
		arg_14_0.selectAni:Play("anim_CrossRoadGameUI_pac_select")
	end

	setActive(arg_14_0.selectTF, arg_14_1)

	return
end

function var_0_0.SetParent(arg_15_0, arg_15_1)
	setParent(arg_15_0._tf, arg_15_1, false)

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
	arg_39_0._runningData:CrashDeadRole()

	return
end

return var_0_0
