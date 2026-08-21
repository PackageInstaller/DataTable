local var_0_0 = class("CrossRoadPlayerMgr")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tpl = arg_1_1
	arg_1_0._runningData = arg_1_2
	arg_1_0._event = arg_1_3
	arg_1_0.playingAction = "normal"
	arg_1_0._tf = arg_1_0._tpl:Find("zhihui_tpl")
	arg_1_0.spineAnimUI = GetComponent(findTF(arg_1_0._tf, "spine"), "SpineAnimUI")
	arg_1_0.frontRoadTF = arg_1_2:GetRoadTF(CrossRoadGameConst.FRONT_ROAD_NAME):Find("content")
	arg_1_0.frontRoadList = arg_1_2:GetRoadList(CrossRoadGameConst.FRONT_ROAD_NAME)
	arg_1_0.joyData = {
		go = false,
		stop = false,
		left = false,
		right = false
	}
	arg_1_0.state = CrossRoadGameConst.PLAYER_STATE.normal
	arg_1_0.roleList = arg_1_2:GetRoleList()
	arg_1_0.speed = CrossRoadGameConst.PLAYER_SPEED
	arg_1_0.carshChangePos = true
	arg_1_0.hongCha = arg_1_0._runningData:GetHongChaTpl()

	arg_1_0:setActionNormal()

	arg_1_0.itemList = arg_1_0._runningData:GetItemGoList()

	return
end

function var_0_0.Prepare(arg_2_0)
	setParent(arg_2_0._tf, arg_2_0.frontRoadTF, false)
	arg_2_0:SetPosition(arg_2_0.frontRoadList.lightTF.anchoredPosition)
	arg_2_0._runningData:SetPlayerPosition(arg_2_0:GetPosition())
	arg_2_0.spineAnimUI:SetActionCallBack(function(arg_3_0)
		if arg_3_0 == "finish" and arg_2_0.state == CrossRoadGameConst.PLAYER_STATE.crash then
			arg_2_0:SetAction("recover2", 0)

			arg_2_0.state = CrossRoadGameConst.PLAYER_STATE.recover

			return
		elseif arg_3_0 == "action" and arg_2_0.state == CrossRoadGameConst.PLAYER_STATE.recover then
			arg_2_0.state = CrossRoadGameConst.PLAYER_STATE.normal
			arg_2_0.carshChangePos = true

			arg_2_0:setActionNormal()

			return
		end

		return
	end)

	return
end

function var_0_0.Step(arg_4_0, arg_4_1)
	arg_4_0.joyData = arg_4_0._runningData:GetJoyData()
	arg_4_0.roleList = arg_4_0._runningData:GetRoleList()

	arg_4_0:UpdateAction()
	arg_4_0:UpdateMove(arg_4_1)
	arg_4_0:CheckAndClearBin()

	return
end

function var_0_0.UpdateAction(arg_5_0)
	if arg_5_0:GetCrashState() then
		return
	end

	local var_5_0 = arg_5_0.joyData
	local var_5_2
	local var_5_3

	if not arg_5_0.joyData.left == arg_5_0.joyData.right then
		var_5_2 = CrossRoadGameConst.PLAYER_STATE.walk
	end

	if not var_5_0.stop == var_5_0.go then
		var_5_3 = var_5_0.stop and CrossRoadGameConst.PLAYER_STATE.stop or CrossRoadGameConst.PLAYER_STATE.sign
	end

	arg_5_0.state = var_5_2 == CrossRoadGameConst.PLAYER_STATE.walk and (var_5_3 and (var_5_0.stop and CrossRoadGameConst.PLAYER_STATE.stop_walk or CrossRoadGameConst.PLAYER_STATE.sign_walk) or var_5_2) or var_5_3 or CrossRoadGameConst.PLAYER_STATE.normal

	arg_5_0:SetAction(arg_5_0.state, 0)

	return
end

function var_0_0.UpdateMove(arg_6_0, arg_6_1)
	if arg_6_0:GetCrashState() then
		if arg_6_0.carshChangePos then
			arg_6_0:SetPlayerCarshPos(arg_6_0._runningData:GetPlayerCrashDir(), (arg_6_0._runningData:GetPlayerCarshSize()))
		end

		return
	end

	if not arg_6_0.joyData.left == arg_6_0.joyData.right then
		local var_6_1 = arg_6_0.joyData.left and {
			-1,
			0
		} or {
			1,
			0
		}

		arg_6_0:SetFaceDir((arg_6_0.joyData.left and {
			-1,
			0
		} or {
			1,
			0
		})[1])
		arg_6_0:SetPlayerPositionByDir(var_6_1, arg_6_1)
	end

	return
end

function var_0_0.SetPlayerPositionByDir(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:GetPosition()
	local var_7_1 = Vector2(var_7_0.x + arg_7_0.speed * arg_7_1[1] * arg_7_2, var_7_0.y)
	local var_7_2 = arg_7_0._runningData:GetSceneWidth()

	if isActive(arg_7_0.hongCha) and CrossRoadGameHelper:CheckPlayerInItem(arg_7_0._tf, arg_7_0.hongCha) then
		arg_7_0._event(CrossRoadGameConst.GET_HONGCHA)
		setActive(arg_7_0.hongCha, false)
	end

	if var_7_1.x > -var_7_2 / 2 and var_7_1.x < var_7_2 / 2 then
		arg_7_0:SetPosition(var_7_1)
	end

	arg_7_0._runningData:SetPlayerPosition(arg_7_0:GetPosition())

	return
end

function var_0_0.SetPlayerCarshPos(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:GetPosition()

	arg_8_0:SetFaceDir(-arg_8_1[1])

	local var_8_1 = Vector2(var_8_0.x + arg_8_2 * arg_8_1[1], var_8_0.y)
	local var_8_2 = arg_8_0._runningData:GetSceneWidth()

	if var_8_1.x > -var_8_2 / 2 and var_8_1.x < var_8_2 / 2 then
		arg_8_0:SetPosition(var_8_1)
	end

	arg_8_0.carshChangePos = false

	arg_8_0._runningData:SetPlayerPosition(arg_8_0:GetPosition())

	return
end

function var_0_0.SetFaceDir(arg_9_0, arg_9_1)
	if arg_9_1 == 0 then
		return
	end

	local var_9_0 = arg_9_0._tf.localScale

	var_9_0.x = math.abs(arg_9_0._tf.localScale.x) * arg_9_1
	arg_9_0._tf.localScale = var_9_0

	return
end

function var_0_0.GetCrashState(arg_10_0)
	return arg_10_0.state == CrossRoadGameConst.PLAYER_STATE.crash or arg_10_0.state == CrossRoadGameConst.PLAYER_STATE.recover
end

function var_0_0.PlayZhihuiHit(arg_11_0)
	if arg_11_0:GetCrashState() then
		return
	end

	arg_11_0.state = CrossRoadGameConst.PLAYER_STATE.crash

	arg_11_0:SetAction(CrossRoadGameConst.PLAYER_STATE.crash, 0)

	return
end

function var_0_0.CheckAndClearBin(arg_12_0)
	arg_12_0.itemList = arg_12_0._runningData:GetItemGoList()

	for iter_12_0 = 1, CrossRoadGameConst.GAME_TRACK_COUNT do
		if arg_12_0.itemList[iter_12_0] ~= nil and arg_12_0.itemList[iter_12_0].id == CrossRoadGameConst.BING_MIAN and CrossRoadGameHelper:CheckPlayerInItem(arg_12_0._tf, arg_12_0.itemList[iter_12_0].go) then
			arg_12_0._event(CrossRoadGameConst.DISPOSE_BIN, iter_12_0)
		end
	end

	return
end

function var_0_0.SetAction(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0.playingAction == arg_13_1 then
		return
	end

	arg_13_0.playingAction = arg_13_1

	arg_13_0.spineAnimUI:SetAction(arg_13_1, arg_13_2)

	return
end

function var_0_0.setActionNormal(arg_14_0)
	arg_14_0:SetAction("normal", 0)

	return
end

function var_0_0.SetPosition(arg_15_0, arg_15_1)
	arg_15_0._tf.anchoredPosition = arg_15_1

	return
end

function var_0_0.GetPosition(arg_16_0)
	return arg_16_0._tf.anchoredPosition
end

function var_0_0.Clear(arg_17_0)
	arg_17_0:setActionNormal()
	setParent(arg_17_0._tf, arg_17_0._tpl, false)

	if arg_17_0.spineAnimUI then
		arg_17_0.spineAnimUI:SetActionCallBack(nil)
	end

	return
end

function var_0_0.Dispose(arg_18_0)
	return
end

return var_0_0
