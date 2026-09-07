local CrossRoadRoleMgr = class("CrossRoadRoleMgr")

function CrossRoadRoleMgr:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._tpl = arg_1_1
	self._runningData = arg_1_2
	self._event = arg_1_3
	self.roleList = {}
	self._roleState = CrossRoadGameConst.SHIP_STATE
	self.itemList = arg_1_2:GetItemGoList()
	self.frontRoadList = arg_1_2:GetRoadList(CrossRoadGameConst.FRONT_ROAD_NAME)

	local var_1_0 = arg_1_2:GetRoadTF(CrossRoadGameConst.FRONT_ROAD_NAME)

	self.frontRoadTF = var_1_0:Find("content")
	self.comboGroupTF = var_1_0:Find("comboGroup")
	self.roleFinishCntTF = var_1_0:Find("role_finish")
	self.roleStartCntTF = var_1_0:Find("role_start")
	self.allFinishTF = var_1_0:Find("allFinish")
	self.roleFinishCnt = 0
	self.roleStartCnt = 14
	self.selectRoleId = -1
	self.joyData = nil
	self.lastSelectTime = 0
	self.time = 0
	self.comboTime = 0
	self.comboCnt = 0
	self.needwalkTime = 0
	self.lastComboTF = nil
	self.lastFinishShowTime = CrossRoadGameConst.GAME_TIME

	return
end

function CrossRoadRoleMgr:Prepare()
	local var_2_0 = self._runningData:GetAllShipTpl()

	for iter_2_0 = 1, #var_2_0 do
		table.insert(self.roleList, (CrossRoadRole.New(var_2_0[iter_2_0], iter_2_0, self._tpl, self._runningData)))
	end

	self.joyData = self._runningData:GetJoyData()
	self.lastSelectTime = 0

	self._runningData:RefreshRound()
	self:ReStatrGroup()

	self.addScoreTF = self.allFinishTF:Find("addScore")

	setText(self.addScoreTF, "+" .. CrossRoadGameHelper.GetAddNum(CrossRoadGameConst.SCORE_GROUP))
	setActive(self.allFinishTF, false)

	local var_2_1, var_2_2 = self.roleList[1]:GetHW()

	self.needwalkTime = var_2_1 / self.roleList[1]:GetSpeed()
	self.finishAnimator = GetComponent(self.allFinishTF, typeof(Animator))
	self.finishDft = GetOrAddComponent(self.allFinishTF, typeof(DftAniEvent))

	self.finishDft:SetStartEvent(function()
		setActive(self.addScoreTF, true)
		self.finishAnimator:Play("anim_CrossRoadGameUI_pac_addScore")

		return
	end)
	self.finishDft:SetEndEvent(function()
		if self.finishAnimator then
			self.finishAnimator:Rebind()
			self.finishAnimator:Update(0)
		end

		setActive(self.allFinishTF, false)

		return
	end)

	return
end

function CrossRoadRoleMgr:Step(arg_5_1)
	self.time = self.time + arg_5_1

	self:UpdateSelect()

	self.itemList = self._runningData:GetItemGoList()
	self.joyData = self._runningData:GetJoyData()

	for iter_5_0, iter_5_1 in ipairs(self.roleList) do
		if iter_5_1:GetRunState() == self._roleState.crash then
			iter_5_1:SetRoleActionByState(self._roleState.crash)
		else
			if iter_5_0 == self.selectRoleId then
				self:updateSelectRole(iter_5_1)
			end

			if iter_5_1:CanAngryStart(self.time) and iter_5_1:CanAngryMove(self.time) then
				iter_5_1:SetRunState(self._roleState.walk)
				iter_5_1:SetAngryActive(false)
			end

			local var_5_0, var_5_1 = self:CheckCanMoveRole(iter_5_1)

			if var_5_0 then
				if iter_5_1:GetID() == iter_5_1:GetFatherID() then
					self._runningData:TryUpdateUnion(iter_5_1)
				end

				self:UpdateRoleMove(iter_5_1, arg_5_1)
			else
				if var_5_1 then
					self._runningData:InRoleUnion(iter_5_1, self.roleList[var_5_1])

					if iter_5_1:GetTrack() ~= CrossRoadGameConst.BACK_ROAD_NAME then
						iter_5_1:SetRunState(self._roleState.stop)
					end
				end

				iter_5_1:setActionNormal()
			end
		end
	end

	if not self:CanShowCombo() then
		self:ShowCombo(0, 0)
	end

	if self._runningData:CanRefreshRound() then
		self._runningData:RefreshRound()

		local var_5_2 = self._runningData:GetRoundCnt()

		self._event(CrossRoadGameConst.NEW_ROUND, var_5_2)

		if var_5_2 >= 0 then
			self.lastFinishShowTime = self.time

			setActive(self.allFinishTF, true)
			setActive(self.addScoreTF, false)
			self.finishAnimator:Play("anim_CrossRoadGameUI_pac_allFinish_in")
			self._event(CrossRoadGameConst.GET_SCORE, {
				CrossRoadGameConst.SCORE_GROUP
			})
		end

		self:ReStatrGroup()
	end

	if self.lastFinishShowTime + CrossRoadGameConst.SHOW_GROUP_TIME < self.time then
		self.lastFinishShowTime = self.time + CrossRoadGameConst.GAME_TIME

		self.finishAnimator:Play("anim_CrossRoadGameUI_pac_allFinish_out")
	end

	return
end

function CrossRoadRoleMgr:UpdateSelect()
	local var_6_0 = 999999999
	local var_6_1 = -1
	local var_6_2 = self._runningData:GetPlayerPosition().x

	for iter_6_0, iter_6_1 in ipairs(self.roleList) do
		if iter_6_1:GetRunState() == self._roleState.crash then
			-- block empty
		else
			local var_6_3 = self._runningData:FindRoleFa(iter_6_1)
			local var_6_4 = self.roleList[var_6_3]:GetPosition().x

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
		self.roleList[var_6_1]:SetSelectTime(self.time)
		self.roleList[var_6_1]:SetAngryActive(false)
	end

	if self.selectRoleId ~= var_6_1 and self.lastSelectTime + CrossRoadGameConst.PLAYER_SELECT_TIME < self.time then
		if self.selectRoleId ~= -1 then
			self.roleList[self.selectRoleId]:SetSelectActive(false)
		end

		self.lastSelectTime = self.time
		self.selectRoleId = var_6_1
	end

	return
end

function CrossRoadRoleMgr:updateSelectRole(arg_7_1)
	arg_7_1:SetSelectActive(true)

	local var_7_0 = arg_7_1:GetRunState()

	if not self.joyData.stop == self.joyData.go then
		var_7_0 = self.joyData.stop and self._roleState.stop or self._roleState.walk

		arg_7_1:SetPlayerHaveSelect(true)
	end

	arg_7_1:SetRunState(var_7_0)

	return
end

function CrossRoadRoleMgr:CheckCanMoveRole(arg_8_1)
	if arg_8_1:GetStartTime() > self.time then
		return false, nil
	end

	if arg_8_1:GetTrack() == CrossRoadGameConst.FRONT_ROAD_NAME then
		return true, nil
	end

	if arg_8_1:GetRunState() == self._roleState.stop then
		return false, nil
	end

	return self:CheckFrontCanMove(arg_8_1)
end

function CrossRoadRoleMgr:CheckFrontCanMove(arg_9_1)
	for iter_9_0 = arg_9_1:GetID() - 1, 1, -1 do
		if self.roleList[iter_9_0]:GetRunState() == self._roleState.crash then
			-- block empty
		elseif CrossRoadGameHelper:CheckTwoRoleIsCrash(arg_9_1, self.roleList[iter_9_0]) then
			return false, iter_9_0
		else
			break
		end
	end

	return true, nil
end

function CrossRoadRoleMgr:UpdateRoleMove(arg_10_1, arg_10_2)
	local var_10_0 = arg_10_1:GetPosition()
	local var_10_1 = arg_10_1:GetSpeed()
	local var_10_2 = arg_10_1:GetTarget()
	local var_10_3 = arg_10_1:GetTrack()
	local var_10_4 = arg_10_1:GetDirect()

	if var_10_3 == CrossRoadGameConst.SCENE_ROAD_NAME then
		for iter_10_0 = 1, 6 do
			if self.itemList[iter_10_0] ~= nil and CrossRoadGameHelper:CheckRoleInItem(arg_10_1, self.itemList[iter_10_0]) then
				if self.itemList[iter_10_0].id == CrossRoadGameConst.BING_MIAN then
					var_10_1 = CrossRoadGameConst.CHILD_RUSH_SPEED
				elseif self:xuanWoStop(arg_10_1) then
					arg_10_1:SetRunState(self._roleState.stop)
					arg_10_1:setActionNormal()

					return
				end
			end
		end
	end

	local var_10_5 = {
		var_10_1 * var_10_4[1] * arg_10_2,
		var_10_1 * var_10_4[2] * arg_10_2
	}
	local var_10_6 = Vector2(var_10_0.x + var_10_5[1], var_10_0.y + var_10_5[2])

	arg_10_1:SetAction(CrossRoadGameConst.SHIP_STATE_ACTION.walk, 0)

	if CrossRoadGameHelper:isMiddle(var_10_6.x, var_10_2.x, var_10_0.x) or var_10_0.x < var_10_2.x then
		if var_10_3 == CrossRoadGameConst.BACK_ROAD_NAME then
			self:SetRoleSceneTaget(arg_10_1)
		elseif var_10_3 == CrossRoadGameConst.SCENE_ROAD_NAME then
			self:SetRoleEndTarget(arg_10_1)
		elseif var_10_3 == CrossRoadGameConst.FRONT_ROAD_NAME then
			self:SetRoleOver(arg_10_1)

			return
		end
	end

	arg_10_1:SetPosition(var_10_6)

	return
end

function CrossRoadRoleMgr:SetRoleSceneTaget(arg_11_1)
	if arg_11_1:GetPlayerHaveSelect() == false then
		arg_11_1:SetRunState(self._roleState.stop)
		arg_11_1:SetRoleActionByState()
	end

	self.roleStartCnt = self.roleStartCnt - 1

	self:SetImageNumber(self.roleStartCntTF, self.roleStartCnt)
	arg_11_1:SetTrack(CrossRoadGameConst.SCENE_ROAD_NAME)
	arg_11_1:SetTarget(self.frontRoadList.lightTF.anchoredPosition)

	return
end

function CrossRoadRoleMgr:SetRoleEndTarget(arg_12_1)
	self.comboCnt = self:CanShowCombo() and self.comboCnt + 1 or 0
	self.comboTime = self.time
	self.roleFinishCnt = self.roleFinishCnt + 1

	self:SetImageNumber(self.roleFinishCntTF, self.roleFinishCnt)
	self:ShowCombo(self.comboCnt, CrossRoadGameConst.SCORE_ONE * self.comboCnt)
	self._event(CrossRoadGameConst.GET_SCORE, {
		CrossRoadGameConst.SCORE_ONE * self.comboCnt + CrossRoadGameConst.SCORE_BASE
	}, nil)
	self._event(CrossRoadGameConst.ADD_ROLE, nil, nil)
	arg_12_1:SetTrack(CrossRoadGameConst.FRONT_ROAD_NAME)
	arg_12_1:SetTarget(self.frontRoadList.endTF.anchoredPosition)

	return
end

function CrossRoadRoleMgr:CanShowCombo()
	return self.comboTime + CrossRoadGameConst.COMOBO_TIME + self.needwalkTime > self.time
end

function CrossRoadRoleMgr:SetRoleOver(arg_14_1)
	arg_14_1:SetActive(false)
	arg_14_1:SetRunState(self._roleState.crash)
	arg_14_1:Clear()

	return
end

function CrossRoadRoleMgr:ReStatrGroup()
	self.roleList = CrossRoadGameHelper:GetRandomList(self.roleList)

	for iter_15_0, iter_15_1 in ipairs(self.roleList) do
		iter_15_1:SetID(iter_15_0)
		iter_15_1:SetFatherID(iter_15_0)
		iter_15_1:SetScale(Vector3(-1, 1, 1))
		iter_15_1:SetActive(true)
		iter_15_1:SetParent(self.frontRoadTF)
		iter_15_1:SetPlayerHaveSelect(false)
		iter_15_1:SetPosition(self.frontRoadList.startTF.anchoredPosition)
		iter_15_1:SetStartTime(self.time + CrossRoadGameConst.WALKER_GO_AGIN_TIME * (iter_15_0 - 1))
		iter_15_1:SetTarget(self.frontRoadList.midTF.anchoredPosition)
		iter_15_1:SetTrack(CrossRoadGameConst.BACK_ROAD_NAME)
		iter_15_1:SetRunState(self._roleState.walk)
		iter_15_1:RandomAngryTime()
	end

	self.roleStartCnt = #self.roleList
	self.roleFinishCnt = 0

	self:RefreshRoleCountNum()
	self._runningData:SetRoleList(self.roleList)

	return
end

function CrossRoadRoleMgr:ShowCombo(arg_16_1, arg_16_2)
	local var_16_0

	if self.lastComboTF then
		setActive(self.lastComboTF, false)
	end

	for iter_16_0 = 1, #CrossRoadGameConst.ROLE_COMOBO_LV do
		if arg_16_1 >= CrossRoadGameConst.ROLE_COMOBO_LV[iter_16_0] then
			var_16_0 = "combo" .. tostring(iter_16_0)
		end
	end

	if var_16_0 then
		self.lastComboTF = self.comboGroupTF:Find(var_16_0)

		self.lastComboTF:GetComponent(typeof(Animation)):Play("anim_CrossRoadGameUI_pac_combo")
		setText(self.lastComboTF:Find("combocnt"), "X " .. arg_16_1)
		setText(self.lastComboTF:Find("addScore"), "+" .. arg_16_2)
		setActive(self.lastComboTF, true)
	end

	return
end

function CrossRoadRoleMgr:xuanWoStop(arg_17_1)
	if arg_17_1:GetXuanWoRollTime() + CrossRoadGameConst.XUANWO_LIFE_TIME > self.time then
		return false
	end

	arg_17_1:SetXuanWRollTime(self.time)

	if math.random(1, 100) > CrossRoadGameConst.XUANWO_STOP_PERCENT then
		return false
	end

	return true
end

function CrossRoadRoleMgr:SetImageNumber(arg_18_1, arg_18_2)
	local var_18_0 = math.floor(arg_18_2 / 10)

	setActive(arg_18_1:Find("wei2/0_" .. var_18_0), true)
	setActive(arg_18_1:Find("wei2/0_" .. (var_18_0 + 1) % 2), false)

	for iter_18_0 = 0, 9 do
		setActive(arg_18_1:Find("wei1/0_" .. iter_18_0), false)
	end

	setActive(arg_18_1:Find("wei1/0_" .. arg_18_2 % 10), true)

	return
end

function CrossRoadRoleMgr:RefreshRoleCountNum()
	self:SetImageNumber(self.roleFinishCntTF, self.roleFinishCnt)
	self:SetImageNumber(self.roleStartCntTF, self.roleStartCnt)

	return
end

function CrossRoadRoleMgr:Clear()
	for iter_20_0, iter_20_1 in ipairs(self.roleList) do
		iter_20_1:Clear()
	end

	self.roleList = {}

	return
end

return CrossRoadRoleMgr
