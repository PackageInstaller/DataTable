local var_0_0 = g.core.config.new_slg_cost_info
local NewSlgTeamInfoBubbleComp = class("NewSlgTeamInfoBubbleComp", require("app.fairyGUI.newSlg.UI_NewSlgTeamInfoBubbleComp"))

function NewSlgTeamInfoBubbleComp:ctor()
	self._compPro = self:getChild("Comp_pro")
	self._compMovePro = self:getChild("Comp_move_pro")
	self._btnExe = self:getChild("Btn_exe")

	self._btnExe:addClickListener(handler(self, self._onClickBtnExe))

	self._btnCheck = self:getChild("Btn_check")

	self._btnCheck:addClickListener(handler(self, self._onClickBtnCheck))
	self.m_addSpeedBtn:addClickListener(handler(self, self.onClickMoveRightNow))

	self._btnIcon1 = self:getChild("Btn_icon1")
	self._btnIcon2 = self:getChild("Btn_icon2")
	self._btnIcon3 = self:getChild("Btn_icon3")
	self._btnIcon4 = self:getChild("Btn_icon4")
	self._btnIcon5 = self:getChild("Btn_icon5")
	self._btnIcon6 = self:getChild("Btn_icon6")
	self._compArmyType = self:getChild("Comp_army_type")
	self._txtPro = self:getChild("Txt_pro")
	self._txtPower = self:getChild("Txt_power")
	self._txtMovePro = self:getChild("Txt_move_pro")
	self._txtDesc = self:getChild("Txt_desc")
	self._isMoveCtrl = self:getController("is_move")
	self._armyTypeCtrl = self:getController("army_type")
	self._itemCompArrMap = {
		[g.core.common.Goods.TYPE_KNIGHT] = {
			self._btnIcon1,
			self._btnIcon2,
			self._btnIcon3,
			self._btnIcon4,
			self._btnIcon5,
			self._btnIcon6
		}
	}
	self._team = nil
	self._teamIndex = nil
	self._endTime = nil
	self._totalTime = 0
end

function NewSlgTeamInfoBubbleComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SYNCUSERTEAM, handler(self, self._onRcvTeamRefresh), self)
	self:newSchedule(handler(self, self._onUpdate), 1)
end

function NewSlgTeamInfoBubbleComp:updateView(arg_3_1)
	self._team = arg_3_1.team
	self._teamIndex = self._team.index

	self:_updateStatus()
	self:_updateTroop()
	self:_updateIcon()
	self:_onUpdate()
end

function NewSlgTeamInfoBubbleComp:_updateTroop()
	local var_4_0 = self._team.troop_type
	local var_4_1

	if not self._team.troop_type then
		var_4_0 = g.core.const.ConstMgr.NewSlgConst.ARMY_TYPE.QI
		var_4_1 = {
			armyType = var_4_0
		}
	end

	var_4_1.level = g.core.model.User.newSlgDevelopData:getBarrackLvByType(var_4_0)

	self._compArmyType:updateView(var_4_1)

	local var_4_2 = self._team.troops or 0
	local var_4_3 = g.core.model.User.newSlgDevelopData:getArmyInitTroopsByType(var_4_0)

	self._txtPro:setText(g.core.lang:get(428999, {
		value = var_4_2,
		max = var_4_3
	}))
	self._compPro:setMax(var_4_3)
	self._compPro:setValue(var_4_2)

	local var_4_4 = g.core.model.User.newSlgData:isTeamIdle(self._team) and g.core.model.User.newSlgData:getTeamAuthorityByTeam(self._team) or self._team.authority

	self._txtPower:setText((self._teamStatus and self._teamStatus.isReachDest and self._teamStatus.monsterType == g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.CITY or nil) and self:_calcElemCityAuthority())
end

function NewSlgTeamInfoBubbleComp:_calcElemCityAuthority()
	local var_5_0 = self._team.authority
	local var_5_1, var_5_2, var_5_3 = g.core.model.User.newSlgData:getDestTargetInfo(self._team.target_point)
	local var_5_4, var_5_5 = g.core.model.User.newSlgData:getCitySerData(var_5_3)

	if not var_5_5 then
		return var_5_0
	end

	local var_5_6 = {}

	for iter_5_0, iter_5_1 in pairs(self._team.characters) do
		local var_5_7 = g.core.config.knight_info.get(iter_5_1.base_id).classical

		if var_5_7 ~= 0 then
			var_5_6[#var_5_6 + 1] = var_5_7
		end
	end

	local var_5_8 = g.core.model.User.newSlgData:getTeamElementTypeAndAffectValue(var_5_6)

	if var_5_8 == 0 then
		return var_5_0
	end

	if var_5_5.element == var_5_8 then
		local var_5_9 = math.floor(self._team.base_authority * (var_5_5.num / 1000))

		if var_5_5.type == 1 then
			-- block empty
		elseif var_5_5.type == 2 then
			var_5_9 = -var_5_9
		end

		var_5_0 = var_5_0 + var_5_9
	end

	return var_5_0
end

function NewSlgTeamInfoBubbleComp:_updateIcon()
	local var_6_0 = self._team.characters or {}
	local var_6_1 = {}

	if #var_6_0 > 0 then
		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			if var_6_1[iter_6_1.tp] == nil then
				var_6_1[iter_6_1.tp] = {}
			end

			table.insert(var_6_1[iter_6_1.tp], iter_6_1)
		end
	end

	for iter_6_2, iter_6_3 in pairs(self._itemCompArrMap) do
		local var_6_2 = var_6_1[iter_6_2] or {}

		for iter_6_4, iter_6_5 in ipairs(iter_6_3) do
			local var_6_3 = var_6_2[iter_6_4] or {
				tp = iter_6_2
			}

			iter_6_5:updateView({
				character = var_6_3
			})
		end
	end
end

function NewSlgTeamInfoBubbleComp:_updateStatus()
	self._endTime = nil

	self._isMoveCtrl:setSelectedIndex(0)

	if not g.core.model.User.newSlgData:isTeamIdle(self._team) then
		local var_7_1 = g.core.model.User.newSlgData:getTeamStateByTeam(self._team)

		self._teamStatus = var_7_1

		local var_7_2 = var_7_1.totalTime

		self._endTime = var_7_1.startTime + var_7_1.totalTime

		if var_7_2 and var_7_2 > 0 then
			if var_7_1.state == g.core.const.ConstMgr.NewSlgConst.TEAM_CLIENT_STATUS_TYPE.MARCHING then
				self._isMoveCtrl:setSelectedIndex(1)
			else
				self._isMoveCtrl:setSelectedIndex(self._canQuickBack and 3 or 2)
			end

			self._compMovePro:setMax(var_7_2)
			self._compMovePro:setValue(var_7_2)
			self._txtMovePro:setText((g.core.common.ServerTime:getActivityLeftTime(var_7_2)))
		end

		self._txtDesc:setText(var_7_1.text)
	else
		self._txtDesc:setText(g.core.lang:get(428835))
	end
end

function NewSlgTeamInfoBubbleComp:_onClickBtnFarm()
	self:dispatchCompEvent("NewSlgTeamInfoBubbleComp_clickFarm", {
		teamIndex = self._teamIndex
	})
end

function NewSlgTeamInfoBubbleComp:updateShowMoveRightNow()
	if self._teamStatus then
		if self._teamStatus.isReachDest then
			self.m_showSpeedController:setSelectedIndex(0)
		else
			local var_9_0 = g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_ITEM, 60012)

			self.m_showSpeedController:setSelectedIndex(1)

			if var_9_0 > 0 then
				self.m_costLoader:setURL(g.core.common.Goods:convert({
					value = 60012,
					type = g.core.common.Goods.TYPE_ITEM
				}).icon_mini)
				self.m_descTxt:setText(g.core.lang:get(429033, {
					num = 1
				}))
			else
				self.m_costLoader:setURL(g.core.common.Goods:convert({
					value = 0,
					type = 999
				}).icon_mini)

				local var_9_1 = self._endTime - g.core.common.ServerTime:getTime()

				for iter_9_0 = 1, var_0_0.getLength() do
					local var_9_2 = var_0_0.indexOf(iter_9_0)

					if var_9_1 >= var_9_2.min_time and var_9_1 < var_9_2.max_time then
						self.m_descTxt:setText(g.core.lang:get(429033, {
							num = var_9_2.cost
						}))

						break
					end
				end
			end
		end
	end
end

function NewSlgTeamInfoBubbleComp:onClickMoveRightNow()
	if self._teamStatus then
		if self._teamStatus.isReachDest then
			return
		else
			local var_10_0 = self._team.move

			if self._team.move then
				g.core.network.GameNetProxy:send_C2S_NewSlg_MoveTargetRightNow({
					move_id = var_10_0.id,
					end_time = self._endTime
				})
			end
		end
	end
end

function NewSlgTeamInfoBubbleComp:_onClickBtnExe()
	if self._teamStatus and self._teamStatus.monsterType == g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.MONSTER then
		g.core.network.GameNetProxy:send_C2S_NewSlg_MonsterMarchCancel({
			index = self._teamIndex
		})
	elseif self._teamStatus and self._teamStatus.monsterType == g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.CITY then
		g.core.network.GameNetProxy:send_C2S_NewSlg_CityCancelMove({
			team_index = self._teamIndex
		})
	elseif self._teamStatus and self._teamStatus.monsterType == g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.BOSS then
		g.core.network.GameNetProxy:send_C2S_NewSlg_BossLeave({
			is_dismiss = false,
			team_id = self._team.boss_team_id
		})
	elseif self._teamStatus and self._teamStatus.monsterType == g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.FARM then
		g.core.network.GameNetProxy:send_C2S_NewSlg_FarmCancelMove({
			team_index = self._teamIndex
		})
	end
end

function NewSlgTeamInfoBubbleComp:_onClickBtnCheck()
	if self._team then
		local var_12_1

		if self._team.move then
			for iter_12_0, iter_12_1 in pairs((g.core.model.User.newSlgData:getMarchUnit())) do
				if iter_12_1.id == self._team.move.id then
					local var_12_3 = require("app.view.module.slg.const.NewSlgFunc").getMarchDurationByPath(iter_12_1.path, 0, self._team.move.move_action_type)
					local var_12_4 = 1

					if #iter_12_1.path > 1 then
						var_12_4 = var_12_3 / (#iter_12_1.path - 1)
						var_12_4 = math.max(var_12_3 / (#iter_12_1.path - 1), 1)
					end

					var_12_1 = iter_12_1.path[math.ceil((g.core.common.ServerTime:getTime() - iter_12_1.startTime) / var_12_4) + 1]

					break
				end
			end
		end

		if var_12_1 == nil then
			var_12_1 = self._team.target_point
		end

		if g.core.module.ModuleManager:getCurModule().module == g.view.entrance.NEW_SLG_DEVELOP_MAIN_LAYER then
			g.core.model.User.newSlgData:setJumpPos(var_12_1)
			g.core.module.ModuleManager:popComponent()

			return
		end

		if var_12_1 then
			self:dispatchCompEvent("NewSlg_jumpToPos_withoutClick", {
				pos = var_12_1
			})
		end
	end
end

function NewSlgTeamInfoBubbleComp:_onUpdate()
	if self._endTime == nil then
		return
	end

	local var_13_0 = g.core.common.ServerTime:getTime()

	if self._endTime - var_13_0 >= 0 then
		self._txtMovePro:setText((g.core.common.ServerTime:getActivityLeftTime(self._endTime - var_13_0)))
		self._compMovePro:setValue(self._endTime - var_13_0)
	elseif self._teamIndex then
		local var_13_1 = g.core.model.User.newSlgData:getMyTeamByIndex(self._teamIndex)

		if var_13_1 then
			self._team = var_13_1

			self:_updateStatus()
			self:_updateTroop()
			self:_updateIcon()
		end
	end

	self:updateShowMoveRightNow()
end

function NewSlgTeamInfoBubbleComp:_onRcvTeamRefresh(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	if self._teamIndex then
		local var_14_0 = g.core.model.User.newSlgData:getMyTeamByIndex(self._teamIndex)

		if var_14_0 and not g.core.model.User.newSlgData:isTeamIdle(var_14_0) then
			self:updateView({
				team = var_14_0,
				index = self._teamIndex
			})
		end
	end
end

return NewSlgTeamInfoBubbleComp
