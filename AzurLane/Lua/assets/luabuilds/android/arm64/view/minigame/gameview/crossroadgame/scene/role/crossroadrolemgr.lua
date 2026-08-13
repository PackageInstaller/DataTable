class = var_0_10000

local var_0_0 = var_0_10000("CrossRoadRoleMgr")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tpl = arg_1_1
	arg_1_0._runningData = arg_1_2
	arg_1_0._event = arg_1_3
	arg_1_0.roleList = {}
	CrossRoadGameConst = var_4
	arg_1_0._roleState = var_4.SHIP_STATE
	arg_1_0.itemList = arg_1_2:GetItemGoList()

	local var_1_0 = arg_1_2
	local var_1_1 = arg_1_2.GetRoadList

	CrossRoadGameConst = var_1_10007
	arg_1_0.frontRoadList = var_1_1(var_1_0, var_1_10007.FRONT_ROAD_NAME)

	local var_1_2 = arg_1_2
	local var_1_3 = arg_1_2.GetRoadTF

	CrossRoadGameConst = var_7

	local var_1_4 = var_1_3(var_1_2, var_7.FRONT_ROAD_NAME)

	arg_1_0.frontRoadTF = var_4.Find(var_1_4, "content")
	arg_1_0.comboGroupTF = var_4:Find("comboGroup")
	arg_1_0.roleFinishCntTF = var_4:Find("role_finish")
	arg_1_0.roleStartCntTF = var_4:Find("role_start")
	arg_1_0.allFinishTF = var_4:Find("allFinish")
	arg_1_0.roleFinishCnt = 0
	arg_1_0.roleStartCnt = 14
	arg_1_0.selectRoleId = -1
	arg_1_0.joyData = nil
	arg_1_0.lastSelectTime = 0
	arg_1_0.time = 0
	arg_1_0.comboTime = 0
	arg_1_0.comboCnt = 0
	arg_1_0.needwalkTime = 0
	arg_1_0.lastComboTF = nil
	CrossRoadGameConst = var_5
	arg_1_0.lastFinishShowTime = var_5.GAME_TIME

	return
end

function var_0_0.Prepare(arg_2_0)
	local var_2_0 = arg_2_0._runningData
	local var_2_1 = var_1.GetAllShipTpl(var_2_0)

	for iter_2_0 = 1, #var_2_1 do
		var_1_10006 = var_2_1[iter_2_0]
		CrossRoadRole = var_1_10007
		var_1_10007 = var_1_10007.New(var_1_10006, iter_2_0, arg_2_0._tpl, arg_2_0._runningData)
		table = var_1_10008

		var_1_10008.insert(arg_2_0.roleList, var_1_10007)
	end

	local var_2_2 = arg_2_0._runningData

	arg_2_0.joyData = var_2.GetJoyData(var_2_2)
	arg_2_0.lastSelectTime = 0

	local var_2_3 = arg_2_0._runningData

	var_2.RefreshRound(var_2_3)
	arg_2_0:ReStatrGroup()

	local var_2_4 = arg_2_0.allFinishTF

	arg_2_0.addScoreTF = var_2.Find(var_2_4, "addScore")
	setText = var_2

	local var_2_5 = arg_2_0.addScoreTF
	local var_2_6 = "+"

	CrossRoadGameHelper = var_1_10006

	local var_2_7 = var_1_10006.GetAddNum

	CrossRoadGameConst = var_1_10008

	var_2(var_2_5, var_2_6 .. var_2_7(var_1_10008.SCORE_GROUP))

	setActive = var_2

	var_2(arg_2_0.allFinishTF, false)

	local var_2_8 = arg_2_0.roleList[1]
	local var_2_9, var_2_10 = var_2.GetHW(var_2_8)
	local var_2_11 = arg_2_0.roleList[1]

	arg_2_0.needwalkTime = var_2_9 / var_4.GetSpeed(var_2_11)
	GetComponent = var_4

	local var_2_12 = arg_2_0.allFinishTF

	typeof = var_1_10007
	Animator = var_1_10009
	arg_2_0.finishAnimator = var_4(var_2_12, var_1_10007(var_1_10009))
	GetOrAddComponent = var_4

	local var_2_13 = arg_2_0.allFinishTF

	typeof = var_7
	DftAniEvent = var_1_10009
	arg_2_0.finishDft = var_4(var_2_13, var_7(var_1_10009))

	local var_2_14 = arg_2_0.finishDft

	var_4.SetStartEvent(var_2_14, function()
		setActive = var_2_10000

		var_2_10000(arg_2_0.addScoreTF, true)

		local var_3_0 = arg_2_0.finishAnimator

		var_0.Play(var_3_0, "anim_CrossRoadGameUI_pac_addScore")

		return
	end)

	local var_2_15 = arg_2_0.finishDft

	var_4.SetEndEvent(var_2_15, function()
		if arg_2_0.finishAnimator then
			local var_4_0 = arg_2_0.finishAnimator

			var_0.Rebind(var_4_0)

			local var_4_1 = arg_2_0.finishAnimator

			var_0.Update(var_4_1, 0)
		end

		setActive = var_0

		var_0(arg_2_0.allFinishTF, false)

		return
	end)

	return
end

function var_0_0.Step(arg_5_0, arg_5_1)
	arg_5_0.time = arg_5_0.time + arg_5_1

	arg_5_0:UpdateSelect()

	local var_5_0 = arg_5_0._runningData

	arg_5_0.itemList = var_2.GetItemGoList(var_5_0)

	local var_5_1 = arg_5_0._runningData

	arg_5_0.joyData = var_2.GetJoyData(var_5_1)
	ipairs = var_2

	for iter_5_0, iter_5_1 in var_2(arg_5_0.roleList) do
		if iter_5_1:GetRunState() == arg_5_0._roleState.crash then
			iter_5_1:SetRoleActionByState(arg_5_0._roleState.crash)
		else
			if iter_5_0 == arg_5_0.selectRoleId then
				arg_5_0:updateSelectRole(iter_5_1)
			end

			if iter_5_1:CanAngryStart(arg_5_0.time) and iter_5_1:CanAngryMove(arg_5_0.time) then
				iter_5_1:SetRunState(arg_5_0._roleState.walk)
				iter_5_1:SetAngryActive(false)
			end

			local var_5_2

			var_1_10007, var_5_2 = arg_5_0:CheckCanMoveRole(iter_5_1)

			if var_1_10007 then
				if iter_5_1:GetID() == iter_5_1:GetFatherID() then
					local var_5_3 = arg_5_0._runningData

					var_9.TryUpdateUnion(var_5_3, iter_5_1)
				end

				arg_5_0:UpdateRoleMove(iter_5_1, arg_5_1)
			else
				if var_5_2 then
					local var_5_4 = arg_5_0._runningData

					var_9.InRoleUnion(var_5_4, iter_5_1, arg_5_0.roleList[var_5_2])

					local var_5_5 = iter_5_1:GetTrack()

					CrossRoadGameConst = var_10

					if var_5_5 ~= var_10.BACK_ROAD_NAME then
						iter_5_1:SetRunState(arg_5_0._roleState.stop)
					end
				end

				iter_5_1:setActionNormal()
			end
		end
	end

	if not arg_5_0:CanShowCombo() then
		arg_5_0:ShowCombo(0, 0)
	end

	local var_5_6 = arg_5_0._runningData
	local var_5_10

	if var_2.CanRefreshRound(var_5_6) then
		local var_5_7 = arg_5_0._runningData

		var_2.RefreshRound(var_5_7)

		local var_5_8 = arg_5_0._runningData
		local var_5_9 = var_2.GetRoundCnt(var_5_8)

		var_5_10 = arg_5_0._event
		CrossRoadGameConst = iter_5_0

		var_5_10(iter_5_0.NEW_ROUND, var_5_9)

		if 0 <= var_5_9 then
			arg_5_0.lastFinishShowTime = arg_5_0.time
			setActive = var_5_10

			var_5_10(arg_5_0.allFinishTF, true)

			setActive = var_5_10

			var_5_10(arg_5_0.addScoreTF, false)

			local var_5_11 = arg_5_0.finishAnimator

			var_5_10.Play(var_5_11, "anim_CrossRoadGameUI_pac_allFinish_in")

			var_5_10 = arg_5_0._event
			CrossRoadGameConst = var_5_11

			local var_5_12 = var_5_11.GET_SCORE
			local var_5_13 = {}

			CrossRoadGameConst = var_1_10007
			var_5_13[1] = var_1_10007.SCORE_GROUP

			var_5_10(var_5_12, var_5_13)
		end

		arg_5_0:ReStatrGroup()
	end

	local var_5_14 = arg_5_0.lastFinishShowTime

	CrossRoadGameConst = var_5_10

	if var_5_14 + var_5_10.SHOW_GROUP_TIME < arg_5_0.time then
		local var_5_15 = arg_5_0.time

		CrossRoadGameConst = var_3
		arg_5_0.lastFinishShowTime = var_5_15 + var_3.GAME_TIME

		local var_5_16 = arg_5_0.finishAnimator

		var_2.Play(var_5_16, "anim_CrossRoadGameUI_pac_allFinish_out")
	end

	return
end

function var_0_0.UpdateSelect(arg_6_0)
	local var_6_0 = 999999999
	local var_6_1 = -1
	local var_6_2 = arg_6_0._runningData
	local var_6_3 = var_3.GetPlayerPosition(var_6_2).x

	ipairs = var_1_10004

	for iter_6_0, iter_6_1 in var_1_10004(arg_6_0.roleList) do
		if iter_6_1:GetRunState() == arg_6_0._roleState.crash then
			-- block empty
		else
			local var_6_4 = arg_6_0._runningData
			local var_6_5 = var_9.FindRoleFa(var_6_4, iter_6_1)
			local var_6_6 = arg_6_0.roleList[var_6_5]
			local var_6_7 = var_10.GetPosition(var_6_6).x

			math = var_12

			if var_12.abs(var_6_3 - var_6_7) < var_6_0 then
				math = var_12
				var_6_0 = var_12.abs(var_6_3 - var_6_7)
				var_6_1 = var_6_5
			end
		end
	end

	CrossRoadGameConst = var_4

	if var_6_0 > var_4.PLAYER_DISTANCE then
		var_6_1 = -1
	end

	if var_6_1 ~= -1 then
		local var_6_8 = arg_6_0.roleList[var_6_1]

		var_4.SetSelectTime(var_6_8, arg_6_0.time)

		local var_6_9 = arg_6_0.roleList[var_6_1]

		var_4.SetAngryActive(var_6_9, false)
	end

	if arg_6_0.selectRoleId ~= var_6_1 then
		local var_6_10 = arg_6_0.lastSelectTime

		CrossRoadGameConst = var_5

		if var_6_10 + var_5.PLAYER_SELECT_TIME < arg_6_0.time then
			if arg_6_0.selectRoleId ~= -1 then
				local var_6_11 = arg_6_0.roleList[arg_6_0.selectRoleId]

				var_4.SetSelectActive(var_6_11, false)
			end

			arg_6_0.lastSelectTime = arg_6_0.time
			arg_6_0.selectRoleId = var_6_1
		end
	end

	return
end

function var_0_0.updateSelectRole(arg_7_0, arg_7_1)
	arg_7_1:SetSelectActive(true)

	local var_7_0 = arg_7_1:GetRunState()

	if not arg_7_0.joyData.stop == arg_7_0.joyData.go then
		var_7_0 = arg_7_0.joyData.stop and arg_7_0._roleState.stop or arg_7_0._roleState.walk

		arg_7_1:SetPlayerHaveSelect(true)
	end

	arg_7_1:SetRunState(var_7_0)

	return
end

function var_0_0.CheckCanMoveRole(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1

	if arg_8_1.GetStartTime(var_8_0) > arg_8_0.time then
		return false, nil
	end

	local var_8_1 = arg_8_1:GetTrack()

	CrossRoadGameConst = var_8_0

	if var_8_1 == var_8_0.FRONT_ROAD_NAME then
		return true, nil
	end

	if arg_8_1:GetRunState() == arg_8_0._roleState.stop then
		return false, nil
	end

	return arg_8_0:CheckFrontCanMove(arg_8_1)
end

function var_0_0.CheckFrontCanMove(arg_9_0, arg_9_1)
	for iter_9_0 = arg_9_1:GetID() - 1, 1, -1 do
		local var_9_0 = arg_9_0.roleList[iter_9_0]

		if var_7.GetRunState(var_9_0) == arg_9_0._roleState.crash then
			-- block empty
		else
			CrossRoadGameHelper = var_8

			if var_8:CheckTwoRoleIsCrash(arg_9_1, arg_9_0.roleList[iter_9_0]) then
				return false, iter_9_0
			else
				break
			end
		end
	end

	return true, nil
end

function var_0_0.UpdateRoleMove(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1:GetPosition()
	local var_10_1 = arg_10_1:GetSpeed()
	local var_10_2 = arg_10_1:GetTarget()
	local var_10_3 = arg_10_1
	local var_10_4 = arg_10_1.GetTrack(var_10_3)
	local var_10_5 = arg_10_1:GetDirect()

	CrossRoadGameConst = var_10_3

	if var_10_4 == var_10_3.SCENE_ROAD_NAME then
		for iter_10_0 = 1, 6 do
			if arg_10_0.itemList[iter_10_0] ~= nil then
				CrossRoadGameHelper = var_1_10013

				if var_1_10013:CheckRoleInItem(arg_10_1, var_12) then
					var_1_10013 = var_12.id
					CrossRoadGameConst = var_1_10014

					if var_1_10013 == var_1_10014.BING_MIAN then
						CrossRoadGameConst = var_1_10013
						var_10_1 = var_1_10013.CHILD_RUSH_SPEED
					elseif arg_10_0:xuanWoStop(arg_10_1) then
						arg_10_1:SetRunState(arg_10_0._roleState.stop)
						arg_10_1:setActionNormal()

						return
					end
				end
			end
		end
	end

	local var_10_6 = {
		var_10_1 * var_10_5[1] * arg_10_2,
		var_10_1 * var_10_5[2] * arg_10_2
	}

	Vector2 = var_9

	local var_10_7 = var_9(var_10_0.x + var_10_6[1], var_10_0.y + var_10_6[2])
	local var_10_8 = arg_10_1
	local var_10_9 = arg_10_1.SetAction

	CrossRoadGameConst = var_13

	var_10_9(var_10_8, var_13.SHIP_STATE_ACTION.walk, 0)

	CrossRoadGameHelper = var_10_9

	if var_10_9:isMiddle(var_10_7.x, var_10_2.x, var_10_0.x) or var_10_0.x < var_10_2.x then
		CrossRoadGameConst = var_10

		if var_10_4 == var_10.BACK_ROAD_NAME then
			arg_10_0:SetRoleSceneTaget(arg_10_1)
		else
			CrossRoadGameConst = var_10

			if var_10_4 == var_10.SCENE_ROAD_NAME then
				arg_10_0:SetRoleEndTarget(arg_10_1)
			else
				CrossRoadGameConst = var_10

				if var_10_4 == var_10.FRONT_ROAD_NAME then
					arg_10_0:SetRoleOver(arg_10_1)

					return
				end
			end
		end
	end

	arg_10_1:SetPosition(var_10_7)

	return
end

function var_0_0.SetRoleSceneTaget(arg_11_0, arg_11_1)
	if arg_11_1:GetPlayerHaveSelect() == false then
		arg_11_1:SetRunState(arg_11_0._roleState.stop)
		arg_11_1:SetRoleActionByState()
	end

	arg_11_0.roleStartCnt = arg_11_0.roleStartCnt - 1

	arg_11_0:SetImageNumber(arg_11_0.roleStartCntTF, arg_11_0.roleStartCnt)

	local var_11_0 = arg_11_1
	local var_11_1 = arg_11_1.SetTrack

	CrossRoadGameConst = var_5

	var_11_1(var_11_0, var_5.SCENE_ROAD_NAME)
	arg_11_1:SetTarget(arg_11_0.frontRoadList.lightTF.anchoredPosition)

	return
end

function var_0_0.SetRoleEndTarget(arg_12_0, arg_12_1)
	if arg_12_0:CanShowCombo() then
		arg_12_0.comboCnt = arg_12_0.comboCnt + 1
	else
		arg_12_0.comboCnt = 0
	end

	arg_12_0.comboTime = arg_12_0.time
	CrossRoadGameConst = var_2

	local var_12_0 = var_2.SCORE_ONE * arg_12_0.comboCnt

	CrossRoadGameConst = var_3

	local var_12_1 = var_12_0 + var_3.SCORE_BASE

	arg_12_0.roleFinishCnt = arg_12_0.roleFinishCnt + 1

	arg_12_0:SetImageNumber(arg_12_0.roleFinishCntTF, arg_12_0.roleFinishCnt)

	local var_12_2 = arg_12_0
	local var_12_3 = arg_12_0.ShowCombo
	local var_12_4 = arg_12_0.comboCnt

	CrossRoadGameConst = var_7

	var_12_3(var_12_2, var_12_4, var_7.SCORE_ONE * arg_12_0.comboCnt)

	local var_12_5 = arg_12_0._event

	CrossRoadGameConst = var_12_2

	var_12_5(var_12_2.GET_SCORE, {
		var_12_1
	}, nil)

	local var_12_6 = arg_12_0._event

	CrossRoadGameConst = var_5

	var_12_6(var_5.ADD_ROLE, nil, nil)

	local var_12_7 = arg_12_1
	local var_12_8 = arg_12_1.SetTrack

	CrossRoadGameConst = var_6

	var_12_8(var_12_7, var_6.FRONT_ROAD_NAME)
	arg_12_1:SetTarget(arg_12_0.frontRoadList.endTF.anchoredPosition)

	return
end

function var_0_0.CanShowCombo(arg_13_0)
	local var_13_0 = arg_13_0.comboTime

	CrossRoadGameConst = var_1_10002

	return var_13_0 + var_1_10002.COMOBO_TIME + arg_13_0.needwalkTime > arg_13_0.time
end

function var_0_0.SetRoleOver(arg_14_0, arg_14_1)
	arg_14_1:SetActive(false)
	arg_14_1:SetRunState(arg_14_0._roleState.crash)
	arg_14_1:Clear()

	return
end

function var_0_0.ReStatrGroup(arg_15_0)
	CrossRoadGameHelper = var_1_10001
	arg_15_0.roleList = var_1_10001:GetRandomList(arg_15_0.roleList)
	ipairs = var_1

	for iter_15_0, iter_15_1 in var_1(arg_15_0.roleList) do
		iter_15_1:SetID(iter_15_0)
		iter_15_1:SetFatherID(iter_15_0)

		local var_15_0 = iter_15_1
		local var_15_1 = iter_15_1.SetScale

		Vector3 = var_9

		var_15_1(var_15_0, var_9(-1, 1, 1))
		iter_15_1:SetActive(true)
		iter_15_1:SetParent(arg_15_0.frontRoadTF)
		iter_15_1:SetPlayerHaveSelect(false)
		iter_15_1:SetPosition(arg_15_0.frontRoadList.startTF.anchoredPosition)

		local var_15_2 = iter_15_1
		local var_15_3 = iter_15_1.SetStartTime
		local var_15_4 = arg_15_0.time

		CrossRoadGameConst = var_1_10010

		var_15_3(var_15_2, var_15_4 + var_1_10010.WALKER_GO_AGIN_TIME * (iter_15_0 - 1))
		iter_15_1:SetTarget(arg_15_0.frontRoadList.midTF.anchoredPosition)

		local var_15_5 = iter_15_1
		local var_15_6 = iter_15_1.SetTrack

		CrossRoadGameConst = var_9

		var_15_6(var_15_5, var_9.BACK_ROAD_NAME)
		iter_15_1:SetRunState(arg_15_0._roleState.walk)
		iter_15_1:RandomAngryTime()
	end

	arg_15_0.roleStartCnt = #arg_15_0.roleList
	arg_15_0.roleFinishCnt = 0

	arg_15_0:RefreshRoleCountNum()

	local var_15_7 = arg_15_0._runningData

	var_1.SetRoleList(var_15_7, arg_15_0.roleList)

	return
end

function var_0_0.ShowCombo(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0

	if arg_16_0.lastComboTF then
		setActive = var_4

		var_4(arg_16_0.lastComboTF, false)
	end

	local var_16_1 = 1

	CrossRoadGameConst = var_1_10005

	for iter_16_0 = var_16_1, #var_1_10005.ROLE_COMOBO_LV do
		CrossRoadGameConst = var_1_10008

		if var_1_10008.ROLE_COMOBO_LV[iter_16_0] <= arg_16_1 then
			var_1_10008 = "combo"
			tostring = var_1_10009
			var_16_0 = var_1_10008 .. var_1_10009(iter_16_0)
		end
	end

	if var_16_0 then
		local var_16_2 = arg_16_0.comboGroupTF

		arg_16_0.lastComboTF = var_4.Find(var_16_2, var_16_0)

		local var_16_3 = arg_16_0.lastComboTF
		local var_16_4 = var_4.GetComponent

		typeof = var_7
		Animation = var_1_10009

		local var_16_5 = var_16_4(var_16_3, var_7(var_1_10009))

		var_4.Play(var_16_5, "anim_CrossRoadGameUI_pac_combo")

		setText = var_5

		local var_16_6 = arg_16_0.lastComboTF

		var_5(var_7.Find(var_16_6, "combocnt"), "X " .. arg_16_1)

		setText = var_5

		local var_16_7 = arg_16_0.lastComboTF

		var_5(var_7.Find(var_16_7, "addScore"), "+" .. arg_16_2)

		setActive = var_5

		var_5(arg_16_0.lastComboTF, true)
	end

	return
end

function var_0_0.xuanWoStop(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1:GetXuanWoRollTime()

	CrossRoadGameConst = var_1_10003

	local var_17_1 = var_17_0 + var_1_10003.XUANWO_LIFE_TIME

	if arg_17_0.time < var_17_1 then
		return false
	end

	arg_17_1:SetXuanWRollTime(arg_17_0.time)

	math = var_3

	local var_17_2 = var_3.random(1, 100)

	CrossRoadGameConst = var_4

	if var_17_2 > var_4.XUANWO_STOP_PERCENT then
		return false
	end

	return true
end

function var_0_0.SetImageNumber(arg_18_0, arg_18_1, arg_18_2)
	math = var_1_10003

	local var_18_0 = (var_1_10003.floor(arg_18_2 / 10) + 1) % 2

	setActive = var_5

	var_5(arg_18_1:Find("wei2/0_" .. var_3), true)

	setActive = var_5

	var_5(arg_18_1:Find("wei2/0_" .. var_18_0), false)

	local var_18_1 = arg_18_2 % 10

	for iter_18_0 = 0, 9 do
		setActive = var_10

		var_10(arg_18_1:Find("wei1/0_" .. iter_18_0), false)
	end

	setActive = var_6

	var_6(arg_18_1:Find("wei1/0_" .. var_18_1), true)

	return
end

function var_0_0.RefreshRoleCountNum(arg_19_0)
	arg_19_0:SetImageNumber(arg_19_0.roleFinishCntTF, arg_19_0.roleFinishCnt)
	arg_19_0:SetImageNumber(arg_19_0.roleStartCntTF, arg_19_0.roleStartCnt)

	return
end

function var_0_0.Clear(arg_20_0)
	ipairs = var_1_10001

	for iter_20_0, iter_20_1 in var_1_10001(arg_20_0.roleList) do
		iter_20_1:Clear()
	end

	arg_20_0.roleList = {}

	return
end

return var_0_0
