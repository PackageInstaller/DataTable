local var_0_0 = class("CrossRoadRoleMgr")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._tpl = arg_1_1
	arg_1_0._runningData = arg_1_2
	arg_1_0._event = arg_1_3
	arg_1_0.roleList = {}
	arg_1_0._roleState = CrossRoadGameConst.SHIP_STATE
	arg_1_0.itemList = arg_1_2:GetItemGoList()
	arg_1_0.frontRoadList = arg_1_2:GetRoadList(CrossRoadGameConst.FRONT_ROAD_NAME)

	local var_1_0 = arg_1_2:GetRoadTF(CrossRoadGameConst.FRONT_ROAD_NAME)

	arg_1_0.frontRoadTF = var_1_0:Find("content")
	arg_1_0.comboGroupTF = var_1_0:Find("comboGroup")
	arg_1_0.roleFinishCntTF = var_1_0:Find("role_finish")
	arg_1_0.roleStartCntTF = var_1_0:Find("role_start")
	arg_1_0.allFinishTF = var_1_0:Find("allFinish")
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
	arg_1_0.lastFinishShowTime = CrossRoadGameConst.GAME_TIME

	return
end

function var_0_0.Prepare(arg_2_0)
	local var_2_0 = arg_2_0._runningData:GetAllShipTpl()

	for iter_2_0 = 1, #var_2_0 do
		table.insert(arg_2_0.roleList, (CrossRoadRole.New(var_2_0[iter_2_0], iter_2_0, arg_2_0._tpl, arg_2_0._runningData)))
	end

	arg_2_0.joyData = arg_2_0._runningData:GetJoyData()
	arg_2_0.lastSelectTime = 0

	arg_2_0._runningData:RefreshRound()
	arg_2_0:ReStatrGroup()

	arg_2_0.addScoreTF = arg_2_0.allFinishTF:Find("addScore")

	setText(arg_2_0.addScoreTF, "+" .. CrossRoadGameHelper.GetAddNum(CrossRoadGameConst.SCORE_GROUP))
	setActive(arg_2_0.allFinishTF, false)

	local var_2_1, var_2_2 = arg_2_0.roleList[1]:GetHW()

	arg_2_0.needwalkTime = var_2_1 / arg_2_0.roleList[1]:GetSpeed()
	arg_2_0.finishAnimator = GetComponent(arg_2_0.allFinishTF, typeof(Animator))
	arg_2_0.finishDft = GetOrAddComponent(arg_2_0.allFinishTF, typeof(DftAniEvent))

	arg_2_0.finishDft:SetStartEvent(function()
		setActive(arg_2_0.addScoreTF, true)
		arg_2_0.finishAnimator:Play("anim_CrossRoadGameUI_pac_addScore")

		return
	end)
	arg_2_0.finishDft:SetEndEvent(function()
		if arg_2_0.finishAnimator then
			arg_2_0.finishAnimator:Rebind()
			arg_2_0.finishAnimator:Update(0)
		end

		setActive(arg_2_0.allFinishTF, false)

		return
	end)

	return
end

function var_0_0.Step(arg_5_0, arg_5_1)
	arg_5_0.time = arg_5_0.time + arg_5_1

	arg_5_0:UpdateSelect()

	arg_5_0.itemList = arg_5_0._runningData:GetItemGoList()
	arg_5_0.joyData = arg_5_0._runningData:GetJoyData()

	for iter_5_0, iter_5_1 in ipairs(arg_5_0.roleList) do
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

			local var_5_0, var_5_1 = arg_5_0:CheckCanMoveRole(iter_5_1)

			if var_5_0 then
				if iter_5_1:GetID() == iter_5_1:GetFatherID() then
					arg_5_0._runningData:TryUpdateUnion(iter_5_1)
				end

				arg_5_0:UpdateRoleMove(iter_5_1, arg_5_1)
			else
				if var_5_1 then
					arg_5_0._runningData:InRoleUnion(iter_5_1, arg_5_0.roleList[var_5_1])

					if iter_5_1:GetTrack() ~= CrossRoadGameConst.BACK_ROAD_NAME then
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

	if arg_5_0._runningData:CanRefreshRound() then
		arg_5_0._runningData:RefreshRound()

		local var_5_2 = arg_5_0._runningData:GetRoundCnt()

		arg_5_0._event(CrossRoadGameConst.NEW_ROUND, var_5_2)

		if var_5_2 >= 0 then
			arg_5_0.lastFinishShowTime = arg_5_0.time

			setActive(arg_5_0.allFinishTF, true)
			setActive(arg_5_0.addScoreTF, false)
			arg_5_0.finishAnimator:Play("anim_CrossRoadGameUI_pac_allFinish_in")
			arg_5_0._event(CrossRoadGameConst.GET_SCORE, {
				CrossRoadGameConst.SCORE_GROUP
			})
		end

		arg_5_0:ReStatrGroup()
	end

	if arg_5_0.lastFinishShowTime + CrossRoadGameConst.SHOW_GROUP_TIME < arg_5_0.time then
		arg_5_0.lastFinishShowTime = arg_5_0.time + CrossRoadGameConst.GAME_TIME

		arg_5_0.finishAnimator:Play("anim_CrossRoadGameUI_pac_allFinish_out")
	end

	return
end

function var_0_0.UpdateSelect(arg_6_0)
	local var_6_0 = 999999999
	local var_6_1 = -1
	local var_6_2 = arg_6_0._runningData:GetPlayerPosition().x

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.roleList) do
		if iter_6_1:GetRunState() == arg_6_0._roleState.crash then
			-- block empty
		else
			local var_6_3 = arg_6_0._runningData:FindRoleFa(iter_6_1)
			local var_6_4 = arg_6_0.roleList[var_6_3]:GetPosition().x

			if var_6_0 > math.abs(var_6_2 - var_6_4) then
				var_6_0 = math.abs(var_6_2 - var_6_4)
				var_6_1 = var_6_3
			end
		end
	end

	if var_6_0 > CrossRoadGameConst.PLAYER_DISTANCE then
		var_6_1 = -1
	end

	if var_6_1 ~= -1 then
		arg_6_0.roleList[var_6_1]:SetSelectTime(arg_6_0.time)
		arg_6_0.roleList[var_6_1]:SetAngryActive(false)
	end

	if arg_6_0.selectRoleId ~= var_6_1 and arg_6_0.lastSelectTime + CrossRoadGameConst.PLAYER_SELECT_TIME < arg_6_0.time then
		if arg_6_0.selectRoleId ~= -1 then
			arg_6_0.roleList[arg_6_0.selectRoleId]:SetSelectActive(false)
		end

		arg_6_0.lastSelectTime = arg_6_0.time
		arg_6_0.selectRoleId = var_6_1
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
	if arg_8_1:GetStartTime() > arg_8_0.time then
		return false, nil
	end

	if arg_8_1:GetTrack() == CrossRoadGameConst.FRONT_ROAD_NAME then
		return true, nil
	end

	if arg_8_1:GetRunState() == arg_8_0._roleState.stop then
		return false, nil
	end

	return arg_8_0:CheckFrontCanMove(arg_8_1)
end

function var_0_0.CheckFrontCanMove(arg_9_0, arg_9_1)
	for iter_9_0 = arg_9_1:GetID() - 1, 1, -1 do
		if arg_9_0.roleList[iter_9_0]:GetRunState() == arg_9_0._roleState.crash then
			-- block empty
		elseif CrossRoadGameHelper:CheckTwoRoleIsCrash(arg_9_1, arg_9_0.roleList[iter_9_0]) then
			return false, iter_9_0
		else
			break
		end
	end

	return true, nil
end

function var_0_0.UpdateRoleMove(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1:GetPosition()
	local var_10_1 = arg_10_1:GetSpeed()
	local var_10_2 = arg_10_1:GetTarget()
	local var_10_3 = arg_10_1:GetTrack()
	local var_10_4 = arg_10_1:GetDirect()

	if var_10_3 == CrossRoadGameConst.SCENE_ROAD_NAME then
		for iter_10_0 = 1, 6 do
			if arg_10_0.itemList[iter_10_0] ~= nil and CrossRoadGameHelper:CheckRoleInItem(arg_10_1, arg_10_0.itemList[iter_10_0]) then
				if arg_10_0.itemList[iter_10_0].id == CrossRoadGameConst.BING_MIAN then
					var_10_1 = CrossRoadGameConst.CHILD_RUSH_SPEED
				elseif arg_10_0:xuanWoStop(arg_10_1) then
					arg_10_1:SetRunState(arg_10_0._roleState.stop)
					arg_10_1:setActionNormal()

					return
				end
			end
		end
	end

	local var_10_5 = Vector2(var_10_0.x + ({
		var_10_1 * var_10_4[1] * arg_10_2,
		var_10_1 * var_10_4[2] * arg_10_2
	})[1], var_10_0.y + ({
		var_10_1 * var_10_4[1] * arg_10_2,
		var_10_1 * var_10_4[2] * arg_10_2
	})[2])

	arg_10_1:SetAction(CrossRoadGameConst.SHIP_STATE_ACTION.walk, 0)

	if CrossRoadGameHelper:isMiddle(var_10_5.x, var_10_2.x, var_10_0.x) or var_10_0.x < var_10_2.x then
		if var_10_3 == CrossRoadGameConst.BACK_ROAD_NAME then
			arg_10_0:SetRoleSceneTaget(arg_10_1)
		elseif var_10_3 == CrossRoadGameConst.SCENE_ROAD_NAME then
			arg_10_0:SetRoleEndTarget(arg_10_1)
		elseif var_10_3 == CrossRoadGameConst.FRONT_ROAD_NAME then
			arg_10_0:SetRoleOver(arg_10_1)

			return
		end
	end

	arg_10_1:SetPosition(var_10_5)

	return
end

function var_0_0.SetRoleSceneTaget(arg_11_0, arg_11_1)
	if arg_11_1:GetPlayerHaveSelect() == false then
		arg_11_1:SetRunState(arg_11_0._roleState.stop)
		arg_11_1:SetRoleActionByState()
	end

	arg_11_0.roleStartCnt = arg_11_0.roleStartCnt - 1

	arg_11_0:SetImageNumber(arg_11_0.roleStartCntTF, arg_11_0.roleStartCnt)
	arg_11_1:SetTrack(CrossRoadGameConst.SCENE_ROAD_NAME)
	arg_11_1:SetTarget(arg_11_0.frontRoadList.lightTF.anchoredPosition)

	return
end

function var_0_0.SetRoleEndTarget(arg_12_0, arg_12_1)
	arg_12_0.comboCnt = arg_12_0:CanShowCombo() and arg_12_0.comboCnt + 1 or 0
	arg_12_0.comboTime = arg_12_0.time
	arg_12_0.roleFinishCnt = arg_12_0.roleFinishCnt + 1

	arg_12_0:SetImageNumber(arg_12_0.roleFinishCntTF, arg_12_0.roleFinishCnt)
	arg_12_0:ShowCombo(arg_12_0.comboCnt, CrossRoadGameConst.SCORE_ONE * arg_12_0.comboCnt)
	arg_12_0._event(CrossRoadGameConst.GET_SCORE, {
		CrossRoadGameConst.SCORE_ONE * arg_12_0.comboCnt + CrossRoadGameConst.SCORE_BASE
	}, nil)
	arg_12_0._event(CrossRoadGameConst.ADD_ROLE, nil, nil)
	arg_12_1:SetTrack(CrossRoadGameConst.FRONT_ROAD_NAME)
	arg_12_1:SetTarget(arg_12_0.frontRoadList.endTF.anchoredPosition)

	return
end

function var_0_0.CanShowCombo(arg_13_0)
	return arg_13_0.comboTime + CrossRoadGameConst.COMOBO_TIME + arg_13_0.needwalkTime > arg_13_0.time
end

function var_0_0.SetRoleOver(arg_14_0, arg_14_1)
	arg_14_1:SetActive(false)
	arg_14_1:SetRunState(arg_14_0._roleState.crash)
	arg_14_1:Clear()

	return
end

function var_0_0.ReStatrGroup(arg_15_0)
	arg_15_0.roleList = CrossRoadGameHelper:GetRandomList(arg_15_0.roleList)

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.roleList) do
		iter_15_1:SetID(iter_15_0)
		iter_15_1:SetFatherID(iter_15_0)
		iter_15_1:SetScale(Vector3(-1, 1, 1))
		iter_15_1:SetActive(true)
		iter_15_1:SetParent(arg_15_0.frontRoadTF)
		iter_15_1:SetPlayerHaveSelect(false)
		iter_15_1:SetPosition(arg_15_0.frontRoadList.startTF.anchoredPosition)
		iter_15_1:SetStartTime(arg_15_0.time + CrossRoadGameConst.WALKER_GO_AGIN_TIME * (iter_15_0 - 1))
		iter_15_1:SetTarget(arg_15_0.frontRoadList.midTF.anchoredPosition)
		iter_15_1:SetTrack(CrossRoadGameConst.BACK_ROAD_NAME)
		iter_15_1:SetRunState(arg_15_0._roleState.walk)
		iter_15_1:RandomAngryTime()
	end

	arg_15_0.roleStartCnt = #arg_15_0.roleList
	arg_15_0.roleFinishCnt = 0

	arg_15_0:RefreshRoleCountNum()
	arg_15_0._runningData:SetRoleList(arg_15_0.roleList)

	return
end

function var_0_0.ShowCombo(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0

	if arg_16_0.lastComboTF then
		setActive(arg_16_0.lastComboTF, false)
	end

	for iter_16_0 = 1, #CrossRoadGameConst.ROLE_COMOBO_LV do
		if arg_16_1 >= CrossRoadGameConst.ROLE_COMOBO_LV[iter_16_0] then
			var_16_0 = "combo" .. tostring(iter_16_0)
		end
	end

	if var_16_0 then
		arg_16_0.lastComboTF = arg_16_0.comboGroupTF:Find(var_16_0)

		arg_16_0.lastComboTF:GetComponent(typeof(Animation)):Play("anim_CrossRoadGameUI_pac_combo")
		setText(arg_16_0.lastComboTF:Find("combocnt"), "X " .. arg_16_1)
		setText(arg_16_0.lastComboTF:Find("addScore"), "+" .. arg_16_2)
		setActive(arg_16_0.lastComboTF, true)
	end

	return
end

function var_0_0.xuanWoStop(arg_17_0, arg_17_1)
	if arg_17_1:GetXuanWoRollTime() + CrossRoadGameConst.XUANWO_LIFE_TIME > arg_17_0.time then
		return false
	end

	arg_17_1:SetXuanWRollTime(arg_17_0.time)

	if math.random(1, 100) > CrossRoadGameConst.XUANWO_STOP_PERCENT then
		return false
	end

	return true
end

function var_0_0.SetImageNumber(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = math.floor(arg_18_2 / 10)

	setActive(arg_18_1:Find("wei2/0_" .. var_18_0), true)
	setActive(arg_18_1:Find("wei2/0_" .. (var_18_0 + 1) % 2), false)

	for iter_18_0 = 0, 9 do
		setActive(arg_18_1:Find("wei1/0_" .. iter_18_0), false)
	end

	setActive(arg_18_1:Find("wei1/0_" .. arg_18_2 % 10), true)

	return
end

function var_0_0.RefreshRoleCountNum(arg_19_0)
	arg_19_0:SetImageNumber(arg_19_0.roleFinishCntTF, arg_19_0.roleFinishCnt)
	arg_19_0:SetImageNumber(arg_19_0.roleStartCntTF, arg_19_0.roleStartCnt)

	return
end

function var_0_0.Clear(arg_20_0)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0.roleList) do
		iter_20_1:Clear()
	end

	arg_20_0.roleList = {}

	return
end

return var_0_0
