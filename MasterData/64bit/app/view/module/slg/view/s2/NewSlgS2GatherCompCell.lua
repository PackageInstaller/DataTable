local NewSlgS2GatherCompCell = class("NewSlgS2GatherCompCell", require("app.fairyGUI.newSlg.UI_NewSlgS2GatherCompCell"))
local var_0_1 = g.core.const.ConstMgr.NewSlgConst
local var_0_2 = g.core.model.User.newSlgData

function NewSlgS2GatherCompCell:ctor()
	self.m_gatherBtn:addClickListener(handler(self, self._onClickBtnGather))
	self.m_gotoBtn:addClickListener(handler(self, self._onClickGotoBtn))
end

function NewSlgS2GatherCompCell:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SCHEDULE_NOTIFY_NEW, handler(self, self._onSchedule), self)
end

function NewSlgS2GatherCompCell:_onSchedule(arg_3_1, arg_3_2, arg_3_3)
	if self._st and self._et then
		if arg_3_3.key == "NewSlgS2GatherCompCell_updateTime" .. self._st .. self._et then
			self:_updateCountDown()
		elseif arg_3_3.key == "NewSlgS2GatherCompCell_updateComp" .. self._et then
			self:dispatchCompEvent("NewSlgS2GatherCompCell_updateComp")
		end
	end
end

function NewSlgS2GatherCompCell:updateCell(arg_4_1)
	if not arg_4_1 then
		return
	end

	self._data = arg_4_1
	self._period = self._data.period
	self._st = self._data.st
	self._et = self._data.et
	self._teamId = self._data.teamId or 0
	self._cityInfo = self._data.cityInfo
	self._farmInfo = self._data.farmInfo

	self.m_gatherTypeController:setSelectedIndex(self._data.gatherType or 0)
	self.m_periodController:setSelectedIndex(self._data.period)
	self.m_hasDeclareController:setSelectedIndex(self._data.hasDeclare and 1 or 0)
	self.m_descTxt:setText(self._data.titleDesc or "")
	self:_dealSch()
	self:_updateCountDown()
	self:_updateGatherNum()
	self:_updateTroopNumProg()
	self:_updateBtn()
end

function NewSlgS2GatherCompCell:_updateBtn()
	local var_5_0 = self.m_periodController:getSelectedIndex()

	self.m_teamNumGroup:setVisible(false)
	self.m_gotoBtn:setVisible(false)

	if var_5_0 == var_0_1.Slg2CityState.declare_war then
		self.m_gotoBtn:setVisible(self._data.hasDeclare)
		self.m_gotoBtn:setTitle(g.core.lang:get(429641))
	elseif var_5_0 == var_0_1.Slg2CityState.gather then
		if self._data.hasDeclare then
			local var_5_1 = var_0_2:isCityGather(self._cityInfo.id)

			self.m_gotoBtn:setVisible(var_5_1)
			self.m_gatherBtn:setVisible(not var_5_1)
			self.m_teamNumGroup:setVisible(not var_5_1)

			if var_5_1 then
				self.m_gotoBtn:setTitle(g.core.lang:get(429641))
			end
		end

		self.m_teamNumGroup:setVisible(self._data.showBtnType ~= 3)
	elseif var_5_0 == var_0_1.Slg2CityState.battle then
		self.m_gotoBtn:setVisible(self._data.hasDeclare)
		self.m_gotoBtn:setTitle(g.core.lang:get(429641))
	elseif var_5_0 == var_0_1.Slg2CityState.none then
		self.m_gotoBtn:setVisible(true)
		self.m_gotoBtn:setTitle(g.core.lang:get(429641))
	end
end

function NewSlgS2GatherCompCell:_updateTroopNumProg()
	if self._cityInfo and self.m_periodController:getSelectedIndex() == var_0_1.Slg2CityState.gather then
		local var_6_0 = 0
		local var_6_1 = 0
		local var_6_2 = false

		if var_0_2:isCityOccupied(self._cityInfo.id) then
			var_6_2 = true
			var_6_0 = var_0_2:getSelfGatherNum(self._cityInfo.id)
			var_6_1 = var_0_2:getOtherGatherNum(self._cityInfo.id)
		else
			var_6_2 = false
			var_6_0 = var_0_2:getSelfGatherNum(self._cityInfo.id)
			var_6_1 = math.max(var_0_2:getCityDefNum(self._cityInfo.id) - var_0_2:getCityNpcDefNum(self._cityInfo.id), 0)
		end

		self.m_Comp_troopNum:updateView({
			num1 = var_6_0,
			num2 = var_6_1,
			isDef = var_6_2
		})
	end
end

function NewSlgS2GatherCompCell:_updateGatherNum()
	if self._cityInfo and self.m_periodController:getSelectedIndex() == 2 then
		local var_7_1 = (var_0_2:getAdjacentOccupiedCities(self._cityInfo.id)[g.core.model.User.allianceData:getAllianceId()] or {})[1] or 0
		local var_7_2 = var_0_2:getChariotGatherMaxNum(self._cityInfo.id, var_7_1)
		local var_7_3 = var_0_2:getSelfGatherNum(self._cityInfo.id)

		if not var_0_2:isCityOccupied(self._cityInfo.id) then
			local var_7_4 = var_0_2:getChariotBelongAlliance(self._cityInfo.id, var_7_1)

			if var_7_4 and var_7_4 == g.core.model.User.allianceData:getAllianceId() and var_0_2:isCityAssisted(self._cityInfo.id) then
				var_7_3 = var_7_3 + var_0_2:getAssistTroopNum(self._cityInfo.id)
			end
		end

		self.m_gatherNumTxt:setText(g.core.lang:get(428977, {
			num1 = var_7_3,
			num2 = var_7_2
		}))
	end
end

function NewSlgS2GatherCompCell:_dealSch()
	if self._st and self._et then
		g.core.utils.Tools.newSlgFunc.addSchedule({
			key = "NewSlgS2GatherCompCell_updateTime" .. self._st .. self._et,
			startTime = self._st,
			endTime = self._et
		})
		g.core.utils.Tools.newSlgFunc.addSchedule({
			isOnce = true,
			key = "NewSlgS2GatherCompCell_updateComp" .. self._et,
			startTime = self._et
		})
	end
end

function NewSlgS2GatherCompCell:_updateCountDown()
	if self._st and self._et then
		local var_9_0 = g.core.common.ServerTime:getTime()
		local var_9_1 = g.core.common.ServerTime:secondToHMSString((math.max(self._et - var_9_0, 0)))

		if self._cityInfo or self._data.gatherType == var_0_1.Slg2GatherType.BOSS then
			self.m_countDownProg:setMax(self._et - self._st)
			self.m_countDownProg:setValue(math.max(self._et - self._st - (var_9_0 - self._st), 0))
			self.m_countDownTxt:setText(var_9_1)
		elseif self.m_periodController:getSelectedIndex() == var_0_1.Slg2CityState.declare_war then
			self.m_groupDeclare:setVisible(true)
			self.m_groupTip:setVisible(false)
			self.m_declareCd:setText(g.core.lang:get(429632, {
				time = var_9_1
			}))
		else
			self.m_groupDeclare:setVisible(false)
			self.m_groupTip:setVisible(true)
		end
	end
end

function NewSlgS2GatherCompCell:_onClickBtnGather()
	if self._cityInfo then
		local var_10_0 = var_0_2:getCityComponentById(self._cityInfo.id)

		self:dispatchCompEvent("NewSlgMainLayer_hideAllUI")
		self:dispatchCompEvent("NewSlg_jumpToPos", {
			pos = cc.p(var_10_0.anchor_x, var_10_0.anchor_y)
		})
		self:dispatchCompEvent("NewSlg_City_Gather", {
			buildType = g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.CITY,
			info = self._cityInfo,
			x = var_10_0.anchor_x,
			y = var_10_0.anchor_y,
			gatherTp = self._data.gatherType
		})
	elseif self._farmInfo then
		local var_10_1 = var_0_2:getFarmComponentById(self._farmInfo.id)

		if self._data.showBtnType == 2 then
			self:dispatchCompEvent("NewSlgMainLayer_hideAllUI")
			self:dispatchCompEvent("NewSlg_jumpToPos", {
				pos = cc.p(var_10_1.anchor_x, var_10_1.anchor_y)
			})
		end
	end
end

function NewSlgS2GatherCompCell:_onClickGotoBtn()
	if self._cityInfo then
		local var_11_0 = var_0_2:getCityComponentById(self._cityInfo.id)

		self:dispatchCompEvent("NewSlgMainLayer_hideAllUI")
		self:dispatchCompEvent("NewSlg_jumpToPos", {
			pos = cc.p(var_11_0.anchor_x, var_11_0.anchor_y)
		})
	elseif self._teamId > 0 then
		local var_11_1 = var_0_2:getBossTeamInfo(self._teamId)

		if var_11_1 then
			local var_11_2 = var_0_2:getBossComponentById(var_11_1.boss_id)

			self:dispatchCompEvent("NewSlgMainLayer_hideAllUI")
			self:dispatchCompEvent("NewSlg_jumpToPos_withoutClick", {
				pos = cc.p(var_11_2.anchor_x, var_11_2.anchor_y),
				callback = handler(self, function(arg_12_0)
					require("app.view.module.slg.const.NewSlgFunc").openBossTeamDetailPop({
						teamId = var_11_1.team_id
					})
				end)
			})
		end
	end
end

return NewSlgS2GatherCompCell
