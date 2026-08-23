local NewSlgGatherCompCell = class("NewSlgGatherCompCell", require("app.fairyGUI.newSlg.UI_NewSlgGatherCompCell"))
local var_0_1 = 1
local var_0_2 = 0
local var_0_3 = 0

function NewSlgGatherCompCell:ctor()
	self._txtDesc = self:getChild("Txt_desc")
	self._txtCountDown = self:getChild("Txt_countDown")
	self._numTxt = self:getChild("gatherNumTxt")
	self._compProg = self:getChild("Comp_prog")
	self._btnGather = self:getChild("Btn_gather")

	self._btnGather:addClickListener(handler(self, self._onClickBtnGather))

	self._gatherTypeCtrl = self:getController("gather_type")
	self._countDownCtrl = self:getController("count_down")
	self._btnStatus = var_0_2
	self._value = 0
end

function NewSlgGatherCompCell:updateCell(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._gatherType = arg_2_1.gatherType

	self._gatherTypeCtrl:setSelectedIndex(self._gatherType)

	if self._gatherType == var_0_3 then
		self:_updateCityTeam()
	else
		self:_updateBossTeam(arg_2_1.data)
	end
end

function NewSlgGatherCompCell:_updateBossTeam(arg_3_1)
	local var_3_0, var_3_1

	if not arg_3_1 then
		self.m_iconGatherNum:setVisible(false)

		do return end

		var_3_0 = g.core.model.User.newSlgData:getBossTeamInfo(arg_3_1.teamId).users or {}
		var_3_1 = {
			num1 = #var_3_0
		}
	end

	var_3_1.num2 = 4

	self._numTxt:setText(g.core.lang:get(428977, var_3_1))

	self._teamId = arg_3_1.teamId

	self._txtDesc:setText(arg_3_1.text)
	self:_setBtnStatus(var_0_1)

	if arg_3_1.totalTime > 0 then
		self._countDownCtrl:setSelectedIndex(1)

		local var_3_2 = g.core.common.ServerTime:getTime()
		local var_3_3 = arg_3_1.startTime + arg_3_1.totalTime

		if var_3_2 < arg_3_1.startTime then
			self._compProg:setValue(100)
			self._compProg:setMax(100)
		else
			self._compProg:setValue(var_3_3 - var_3_2)
			self._compProg:setMax(arg_3_1.totalTime)
		end

		self._txtCountDown:setText((g.core.common.ServerTime:secondToHMSString(var_3_3 - var_3_2)))
	else
		self._countDownCtrl:setSelectedIndex(0)
	end
end

function NewSlgGatherCompCell:_setBtnStatus(arg_4_1)
	self._btnStatus = arg_4_1

	if arg_4_1 == var_0_2 then
		self._btnGather:setVisible(true)
		self._btnGather:setTitle(g.core.lang:get(428990))
	elseif arg_4_1 == var_0_1 then
		self._btnGather:setVisible(true)
		self._btnGather:setTitle(g.core.lang:get(429005))
	end
end

function NewSlgGatherCompCell:_updateCityTeam()
	if not g.core.model.User.allianceData:hasAlliance() then
		self._txtDesc:setText(g.core.lang:get(428881, {
			time = g.core.model.User.newSlgData:getDailyGatherTimeStr()
		}))
		self._btnGather:setVisible(false)
		self.m_iconGatherNum:setVisible(true)
		self._countDownCtrl:setSelectedIndex(2)

		return
	end

	local var_5_0 = g.core.model.User.newSlgData:getNextAttackCityIds()[1]

	if var_5_0 > 0 then
		self._value = var_5_0

		local var_5_1 = g.core.model.User.newSlgData:getCityInfoById(self._value)

		self._numTxt:setText(g.core.lang:get(428977, {
			num1 = g.core.model.User.newSlgData:getChariotGatherNum(self._value),
			num2 = var_5_1.team_num
		}))
		self.m_iconGatherNum:setVisible(true)

		if not g.core.model.User.newSlgData:isInAttackCityProcess() then
			self._countDownCtrl:setSelectedIndex(0)
			self._txtDesc:setText(g.core.lang:get(428882, {
				time = g.core.model.User.newSlgData:getDailyGatherTimeStr()
			}))
			self:_setBtnStatus(var_0_1)
		elseif g.core.model.User.newSlgData:isChariotGatherTime() then
			self._countDownCtrl:setSelectedIndex(1)

			local var_5_2 = g.core.model.User.newSlgData:getChariotGatherEndTime() - g.core.common.ServerTime:getTime()

			self._txtCountDown:setText((g.core.common.ServerTime:secondToHMSString(var_5_2)))
			self._compProg:setValue(var_5_2)
			self._compProg:setMax((g.core.model.User.newSlgData:getChariotGatherTotalTime()))
			self._txtDesc:setText(g.core.lang:get(428883, {
				name = var_5_1.name
			}))
			self:_setBtnStatus(var_0_2)
		elseif g.core.model.User.newSlgData:isChariotMoveTime() then
			local var_5_3 = g.core.model.User.newSlgData:getCitySerData(var_5_0)

			if not var_5_3 or var_5_3.gatherNum > 0 then
				self._countDownCtrl:setSelectedIndex(1)

				local var_5_4 = g.core.model.User.newSlgData:getChariotMoveTimeEndTime() - g.core.common.ServerTime:getTime()

				self._txtCountDown:setText((g.core.common.ServerTime:secondToHMSString(var_5_4)))
				self._compProg:setValue(var_5_4)
				self._compProg:setMax((g.core.model.User.newSlgData:getChariotMoveTotalTime()))
				self._txtDesc:setText(g.core.lang:get(428884, {
					name = var_5_1.name
				}))
				self:_setBtnStatus(var_0_1)
			else
				self._countDownCtrl:setSelectedIndex(0)
				self._txtDesc:setText(g.core.lang:get(428888))
				self:_setBtnStatus(var_0_1)
			end
		elseif g.core.model.User.newSlgData:isCityFighting(self._value) then
			self._countDownCtrl:setSelectedIndex(0)
			self._txtDesc:setText(g.core.lang:get(428885, {
				name = var_5_1.name
			}))
			self:_setBtnStatus(var_0_1)
		end
	else
		self.m_iconGatherNum:setVisible(false)

		if g.core.model.User.newSlgData:isNewSlgLastDay() then
			self._countDownCtrl:setSelectedIndex(2)
			self._txtDesc:setText(g.core.lang:get(428896))
			self._btnGather:setVisible(false)
		else
			local var_5_5 = g.core.model.User.newSlgData:getNextIdWithoutJudge()

			self._value = g.core.model.User.newSlgData:getAllianceData().occupiedCityId or 0

			if self._value == 0 then
				self._value = var_5_5
			end

			local var_5_6 = g.core.model.User.newSlgData:getCityInfoById(self._value)
			local var_5_7, var_5_8 = g.core.model.User.newSlgData:isCityDayUnlock(var_5_5)

			if not g.core.model.User.newSlgData:isCityPointUnlock(self._value) then
				self._countDownCtrl:setSelectedIndex(0)
				self._txtDesc:setText(g.core.lang:get(428886, {
					name1 = g.core.model.User.newSlgData:getCheckPointInfoById(var_5_6.unlock_quest).name
				}))
				self:_setBtnStatus(var_0_1)
			elseif not var_5_7 then
				self._countDownCtrl:setSelectedIndex(1)

				local var_5_9 = (var_5_8 - 1) * 86400 + (86400 - g.core.common.ServerTime:secondsFromToday())

				self._txtCountDown:setText((g.core.common.ServerTime:getCountDownBySecond(var_5_9)))
				self._compProg:setValue(var_5_9)
				self._compProg:setMax(var_5_9)
				self._txtDesc:setText(g.core.lang:get(428887, {
					num = var_5_8
				}))
				self:_setBtnStatus(var_0_1)
			end
		end
	end
end

function NewSlgGatherCompCell:_onClickBtnGather()
	if self._gatherType == var_0_3 then
		local var_6_0 = g.core.model.User.newSlgData:getCityComponentById(self._value)

		if self._btnStatus == var_0_2 then
			if g.core.model.User.newSlgData:canMoveToBornProvince(cc.p(var_6_0.anchor_x, var_6_0.anchor_y)) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_MOVE_ALLIANCE_POP, {
					tmpl = var_6_0
				})
			else
				self:dispatchCompEvent("NewSlgMainLayer_hideAllUI")
				self:dispatchCompEvent("NewSlg_jumpToPos", {
					pos = cc.p(var_6_0.anchor_x, var_6_0.anchor_y)
				})
				self:dispatchCompEvent("NewSlg_City_Gather", {
					buildType = g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.CITY,
					info = g.core.model.User.newSlgData:getCityInfoById(self._value),
					x = var_6_0.anchor_x,
					y = var_6_0.anchor_y
				})
			end
		elseif self._btnStatus == var_0_1 then
			if g.core.model.User.newSlgData:canMoveToBornProvince(cc.p(var_6_0.anchor_x, var_6_0.anchor_y)) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_MOVE_ALLIANCE_POP, {
					tmpl = var_6_0
				})
			else
				self:dispatchCompEvent("NewSlgMainLayer_hideAllUI")
				self:dispatchCompEvent("NewSlg_jumpToPos", {
					pos = cc.p(var_6_0.anchor_x, var_6_0.anchor_y)
				})
			end
		end
	elseif self._btnStatus == var_0_1 then
		local var_6_2 = g.core.model.User.newSlgData:getBossTeamInfo(self._teamId or 0)

		if var_6_2 then
			local var_6_3 = g.core.model.User.newSlgData:getBossComponentById(var_6_2.boss_id)

			self:dispatchCompEvent("NewSlgMainLayer_hideAllUI")
			self:dispatchCompEvent("NewSlg_jumpToPos_withoutClick", {
				pos = cc.p(var_6_3.anchor_x, var_6_3.anchor_y),
				callback = handler(self, function(arg_7_0)
					g.core.utils.Tools.newSlgFunc.openBossTeamDetailPop({
						teamId = var_6_2.team_id
					})
				end)
			})
		end
	end
end

return NewSlgGatherCompCell
