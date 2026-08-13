class = var_0_10000

local var_0_0 = var_0_10000("CrossRoadPlayerMgr")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tpl = arg_1_1
	arg_1_0._runningData = arg_1_2
	arg_1_0._event = arg_1_3
	arg_1_0.playingAction = "normal"

	local var_1_0 = arg_1_0._tpl

	arg_1_0._tf = var_4.Find(var_1_0, "zhihui_tpl")
	GetComponent = var_4
	findTF = var_1_0
	arg_1_0.spineAnimUI = var_4(var_1_0(arg_1_0._tf, "spine"), "SpineAnimUI")

	local var_1_1 = arg_1_2
	local var_1_2 = arg_1_2.GetRoadTF

	CrossRoadGameConst = var_6

	local var_1_3 = var_1_2(var_1_1, var_6.FRONT_ROAD_NAME)

	arg_1_0.frontRoadTF = var_4.Find(var_1_3, "content")

	local var_1_4 = arg_1_2
	local var_1_5 = arg_1_2.GetRoadList

	CrossRoadGameConst = var_6
	arg_1_0.frontRoadList = var_1_5(var_1_4, var_6.FRONT_ROAD_NAME)
	arg_1_0.joyData = {
		go = false,
		stop = false,
		left = false,
		right = false
	}
	CrossRoadGameConst = var_4
	arg_1_0.state = var_4.PLAYER_STATE.normal
	arg_1_0.roleList = arg_1_2:GetRoleList()
	CrossRoadGameConst = var_4
	arg_1_0.speed = var_4.PLAYER_SPEED
	arg_1_0.carshChangePos = true

	local var_1_6 = arg_1_0._runningData

	arg_1_0.hongCha = var_4.GetHongChaTpl(var_1_6)

	arg_1_0:setActionNormal()

	local var_1_7 = arg_1_0._runningData

	arg_1_0.itemList = var_4.GetItemGoList(var_1_7)

	return
end

function var_0_0.Prepare(arg_2_0)
	local var_2_0 = arg_2_0.frontRoadList.lightTF.anchoredPosition

	setParent = var_1_10002

	var_1_10002(arg_2_0._tf, arg_2_0.frontRoadTF, false)
	arg_2_0:SetPosition(var_2_0)

	local var_2_1 = arg_2_0._runningData

	var_2.SetPlayerPosition(var_2_1, arg_2_0:GetPosition())

	local var_2_2 = arg_2_0.spineAnimUI

	var_2.SetActionCallBack(var_2_2, function(arg_3_0)
		if arg_3_0 == "finish" then
			local var_3_0 = arg_2_0.state

			CrossRoadGameConst = var_2_10002

			if var_3_0 == var_2_10002.PLAYER_STATE.crash then
				var_2_10002 = arg_2_0

				var_1.SetAction(var_2_10002, "recover2", 0)

				local var_3_1 = arg_2_0

				CrossRoadGameConst = var_2_10002
				var_3_1.state = var_2_10002.PLAYER_STATE.recover

				do return end

				goto label_3_0
			end
		end

		if arg_3_0 == "action" then
			local var_3_2 = arg_2_0.state

			CrossRoadGameConst = var_2_10002

			if var_3_2 == var_2_10002.PLAYER_STATE.recover then
				local var_3_3 = arg_2_0

				CrossRoadGameConst = var_2
				var_3_3.state = var_2.PLAYER_STATE.normal
				arg_2_0.carshChangePos = true

				local var_3_4 = arg_2_0

				var_1.setActionNormal(var_3_4)

				return
			end
		end

		::label_3_0::

		return
	end)

	return
end

function var_0_0.Step(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._runningData

	arg_4_0.joyData = var_2.GetJoyData(var_4_0)

	local var_4_1 = arg_4_0._runningData

	arg_4_0.roleList = var_2.GetRoleList(var_4_1)

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
	local var_5_1
	local var_5_2
	local var_5_3

	if not var_5_0.left == var_5_0.right then
		CrossRoadGameConst = var_5
		var_5_2 = var_5.PLAYER_STATE.walk
	end

	if not var_5_0.stop == var_5_0.go then
		if var_5_0.stop then
			CrossRoadGameConst = var_5

			if not var_5.PLAYER_STATE.stop then
				::label_5_0::

				CrossRoadGameConst = var_5
				var_5_3 = var_5.PLAYER_STATE.sign
			end

			CrossRoadGameConst = var_5

			if var_5_2 == var_5.PLAYER_STATE.walk then
				if var_5_3 then
					if var_5_0.stop then
						CrossRoadGameConst = var_5

						if not var_5.PLAYER_STATE.stop_walk then
							::label_5_1::

							CrossRoadGameConst = var_5
							var_5_1 = var_5.PLAYER_STATE.sign_walk
						end

						if false then
							var_5_1 = var_5_2
						end

						goto label_5_3

						if not var_5_3 then
							::label_5_2::

							CrossRoadGameConst = var_5
							var_5_1 = var_5.PLAYER_STATE.normal
						end

						::label_5_3::

						arg_5_0.state = var_5_1

						arg_5_0:SetAction(arg_5_0.state, 0)

						return
					end
				end
			end
		end
	end
end

function var_0_0.UpdateMove(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.joyData
	local var_6_1 = {
		0,
		0
	}

	if arg_6_0:GetCrashState() then
		if arg_6_0.carshChangePos then
			local var_6_2 = arg_6_0._runningData
			local var_6_3 = var_4.GetPlayerCrashDir(var_6_2)
			local var_6_4 = arg_6_0._runningData
			local var_6_5 = var_5.GetPlayerCarshSize(var_6_4)

			arg_6_0:SetPlayerCarshPos(var_6_3, var_6_5)
		end

		return
	end

	if not var_6_0.left == var_6_0.right then
		local var_6_6 = var_6_0.left and {
			-1,
			0
		} or {
			1,
			0
		}

		arg_6_0:SetFaceDir(var_6_6[1])
		arg_6_0:SetPlayerPositionByDir(var_6_6, arg_6_1)
	end

	return
end

function var_0_0.SetPlayerPositionByDir(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:GetPosition()
	local var_7_1 = arg_7_0.speed * arg_7_1[1] * arg_7_2

	Vector2 = var_5

	local var_7_2 = var_5(var_7_0.x + var_7_1, var_7_0.y)
	local var_7_3 = arg_7_0._runningData
	local var_7_4 = var_6.GetSceneWidth(var_7_3)

	isActive = var_7_3

	if var_7_3(arg_7_0.hongCha) then
		CrossRoadGameHelper = var_7

		local var_7_5 = var_7

		if var_7.CheckPlayerInItem(var_7_5, arg_7_0._tf, arg_7_0.hongCha) then
			local var_7_6 = arg_7_0._event

			CrossRoadGameConst = var_7_5

			var_7_6(var_7_5.GET_HONGCHA)

			setActive = var_7_6

			var_7_6(arg_7_0.hongCha, false)
		end
	end

	if var_7_2.x > -var_7_4 / 2 and var_7_2.x < var_7_4 / 2 then
		arg_7_0:SetPosition(var_7_2)
	end

	local var_7_7 = arg_7_0._runningData

	var_7.SetPlayerPosition(var_7_7, arg_7_0:GetPosition())

	return
end

function var_0_0.SetPlayerCarshPos(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:GetPosition()

	arg_8_0:SetFaceDir(-arg_8_1[1])

	Vector2 = var_4

	local var_8_1 = var_4(var_8_0.x + arg_8_2 * arg_8_1[1], var_8_0.y)
	local var_8_2 = arg_8_0._runningData
	local var_8_3 = var_5.GetSceneWidth(var_8_2)

	if var_8_1.x > -var_8_3 / 2 and var_8_1.x < var_8_3 / 2 then
		arg_8_0:SetPosition(var_8_1)
	end

	arg_8_0.carshChangePos = false

	local var_8_4 = arg_8_0._runningData

	var_6.SetPlayerPosition(var_8_4, arg_8_0:GetPosition())

	return
end

function var_0_0.SetFaceDir(arg_9_0, arg_9_1)
	if arg_9_1 == 0 then
		return
	end

	local var_9_0 = arg_9_0._tf.localScale

	math = var_1_10003
	var_9_0.x = var_1_10003.abs(var_9_0.x) * arg_9_1
	arg_9_0._tf.localScale = var_9_0

	return
end

function var_0_0.GetCrashState(arg_10_0)
	local var_10_0 = arg_10_0.state

	CrossRoadGameConst = var_1_10002

	local var_10_2

	if var_10_0 ~= var_1_10002.PLAYER_STATE.crash then
		local var_10_1 = arg_10_0.state

		CrossRoadGameConst = var_2

		if var_10_1 ~= var_2.PLAYER_STATE.recover then
			var_10_2 = false

			goto label_10_0
		end
	end

	var_10_2 = true

	::label_10_0::

	return var_10_2
end

function var_0_0.PlayZhihuiHit(arg_11_0)
	if arg_11_0:GetCrashState() then
		return
	end

	CrossRoadGameConst = var_1
	arg_11_0.state = var_1.PLAYER_STATE.crash

	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.SetAction

	CrossRoadGameConst = var_1_10003

	var_11_1(var_11_0, var_1_10003.PLAYER_STATE.crash, 0)

	return
end

function var_0_0.CheckAndClearBin(arg_12_0)
	local var_12_0 = arg_12_0._runningData

	arg_12_0.itemList = var_1.GetItemGoList(var_12_0)

	local var_12_1 = 1

	CrossRoadGameConst = var_12_0

	for iter_12_0 = var_12_1, var_12_0.GAME_TRACK_COUNT do
		if arg_12_0.itemList[iter_12_0] ~= nil then
			local var_12_2 = arg_12_0.itemList[iter_12_0].id

			CrossRoadGameConst = var_1_10006

			if var_12_2 == var_1_10006.BING_MIAN then
				CrossRoadGameHelper = var_12_2
				var_1_10006 = var_12_2

				if var_12_2.CheckPlayerInItem(var_1_10006, arg_12_0._tf, arg_12_0.itemList[iter_12_0].go) then
					local var_12_3 = arg_12_0._event

					CrossRoadGameConst = var_1_10006

					var_12_3(var_1_10006.DISPOSE_BIN, iter_12_0)
				end
			end
		end
	end

	return
end

function var_0_0.SetAction(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_0.playingAction == arg_13_1 then
		return
	end

	arg_13_0.playingAction = arg_13_1

	local var_13_0 = arg_13_0.spineAnimUI

	var_3.SetAction(var_13_0, arg_13_1, arg_13_2)

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

	setParent = var_1

	var_1(arg_17_0._tf, arg_17_0._tpl, false)

	if arg_17_0.spineAnimUI then
		local var_17_0 = arg_17_0.spineAnimUI

		var_1.SetActionCallBack(var_17_0, nil)
	end

	return
end

function var_0_0.Dispose(arg_18_0)
	return
end

return var_0_0
