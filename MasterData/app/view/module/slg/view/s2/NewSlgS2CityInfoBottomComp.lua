local NewSlgS2CityInfoBottomComp = class("NewSlgS2CityInfoBottomComp", require("app.fairyGUI.newSlg.UI_NewSlgS2CityInfoBottomComp"))
local var_0_1 = g.core.const.ConstMgr.NewSlgConst
local var_0_2 = g.core.model.User.newSlgData
local var_0_3 = g.core.event.EventManager
local var_0_4 = g.core.event.enum
local var_0_5 = g.core.model.User.allianceData
local var_0_6 = g.core.const.ConstMgr.AllianceConst
local var_0_7 = g.core.module.ModuleManager
local var_0_8 = g.core.utils.String

function NewSlgS2CityInfoBottomComp:ctor()
	self._isCityUnlock = false
	self._cityUnlockState = 0
	self._maxWords = 20

	self.m_promptTxt:setText(g.core.lang:get(429619, {
		num = self._maxWords
	}))
	self.m_btnGather:addClickListener(handler(self, self._onClickBtnGather))
	self.m_btnBuild:addClickListener(handler(self, self._onClickBtnBuild))
	self.m_Btn_checkDefenderInfo:addClickListener(handler(self, self._onClickBtnCheckDefenderInfo))
	self.m_selTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabSelChanged))
	self.m_inputTxt:addEventListener(fgui.UIEventType.Changed, handler(self, self._onInputTextChanged))
	self.m_deleteBtn:addClickListener(handler(self, self._onClickDeleteBtn))
	self.m_confirmBtn:addClickListener(handler(self, self._onClickConfirmBtn))
	self.m_loaderBtn:addClickListener(handler(self, self.onClickDecayClick))
end

function NewSlgS2CityInfoBottomComp:_onInputTextChanged()
	self.m_promptTxt:setVisible(self.m_inputTxt:getText() == "")
end

function NewSlgS2CityInfoBottomComp:onLoad()
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_NEW_SLG_CITYDECLARENTF, handler(self, self._onUpdateViewAgain), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_NEW_SLG_CITYBEDECLAREDNTF, handler(self, self._onUpdateViewAgain), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_NEW_SLG_CITYMARCHNTF, handler(self, self._onUpdateViewAgain), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_NEW_SLG_GETINFOONCITYBATTLEEND, handler(self, self._onUpdateViewAgain), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_NEW_SLG_CITYOCCUPIERNTF, handler(self, self._onUpdateViewAgain), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_NEW_SLG_SETCITYDECLARATION, handler(self, self._onEditDeclaration), self)
	var_0_3:addEventListener(var_0_4.EVENT_NET_S2C_NEW_SLG_BUILDCITY, handler(self, self._updateBuildBtn), self)
end

function NewSlgS2CityInfoBottomComp:_onUpdateViewAgain()
	self:updateView({
		cityId = self._cityId
	})
end

function NewSlgS2CityInfoBottomComp:updateView(arg_5_1)
	self.m_gradeController:setSelectedIndex((var_0_5:getMyGrade()))
	self.m_selTabController:setSelectedIndex(0)

	local var_5_0 = arg_5_1.cityId

	if not arg_5_1.cityId then
		return
	end

	local var_5_1, var_5_2 = g.core.model.User.newSlgData:getCityAuthorityDecreaseNumAndScoreDecrease(var_5_0)
	local var_5_3

	if var_5_1 + var_5_2 > 0 then
		local var_5_4 = {}

		if var_5_1 > 0 then
			var_5_4[#var_5_4 + 1] = g.core.lang:get(429740, {
				num = var_5_1
			})
		end

		if var_5_2 > 0 then
			var_5_4[#var_5_4 + 1] = g.core.lang:get(429803, {
				num = var_5_2
			})
		end

		var_5_3 = table.concat(var_5_4, "\t")
	end

	if not var_5_3 then
		self.m_decayController:setSelectedIndex(1)
	else
		self.m_decayController:setSelectedIndex(0)
		self.m_decayTxt:setText(var_5_3)
	end

	self._cityId = var_5_0
	self._state = self:_getState()

	if not self._state then
		return
	end

	self.m_stateController:setSelectedIndex(self._state - 1)
	self:_updateDesc()
	self:_updateTroopNumProg()
	self:_updateBuildBtn()
	self:_updateGatherBtn()
	self:_updateDeclare()
end

function NewSlgS2CityInfoBottomComp:_updateDesc()
	if self._state == var_0_1.Slg2CityInfoState.CANT_GATHER then
		if self:_getCityGatherState() == var_0_1.Slg2CityGatherState.NOT_DECLARE then
			self.m_Txt_cityDesc:setText(g.core.lang:get(429602))
		else
			self.m_Txt_cityDesc:enableRich()
			self.m_Txt_cityDesc:setText(g.core.lang:get(429601))
		end
	elseif self._state == var_0_1.Slg2CityInfoState.CANT_DECLARE then
		local var_6_0, var_6_1, var_6_2 = var_0_2:isS2CityUnlock(self._cityId)

		self._isCityUnlock = var_6_0
		self._cityUnlockState = var_6_1

		if not var_6_0 then
			if var_6_1 == var_0_1.Slg2CityUnlockState.time then
				self.m_Txt_cityDesc:setText(g.core.lang:get(429610, {
					day = var_6_2
				}))
			elseif var_6_1 == var_0_1.Slg2CityUnlockState.front then
				self.m_Txt_cityDesc:setText(g.core.lang:get(429611, {
					name = var_0_2:getCityInfoById(var_6_2).name
				}))
			elseif var_6_1 == var_0_1.Slg2CityUnlockState.invalid then
				self.m_Txt_cityDesc:setText(g.core.lang:get(429612))
			else
				self.m_Txt_cityDesc:setText(g.core.lang:get(429613))
			end
		end
	elseif self._state == var_0_1.Slg2CityInfoState.CAN_DECLARE then
		if var_0_2:isCityDeclared(self._cityId) then
			self.m_Txt_cityDesc:setText(g.core.lang:get(429621))
		else
			self.m_Txt_cityDesc:setText(g.core.lang:get(429614))
		end
	elseif self._state == var_0_1.Slg2CityInfoState.REWARD then
		self.m_Txt_cityDesc:setText(g.core.lang:get(429615))
	elseif self._state == var_0_1.Slg2CityInfoState.GATHER_GATHER then
		self.m_Txt_cityDesc:setText(g.core.lang:get(429616))
	end
end

function NewSlgS2CityInfoBottomComp:_updateBuildBtn()
	local var_7_0 = var_0_2:getBuildDataById(self._cityId)

	if var_7_0 and var_7_0.baseId > 0 then
		self.m_buildLv:setText(var_0_2:getBuildInfoById(var_7_0.baseId).level_index)
	end
end

function NewSlgS2CityInfoBottomComp:_updateTroopNumProg()
	local var_8_0 = var_0_2:getCitySerData(self._cityId)

	if var_8_0 then
		self.m_troopNumTxt:setText(var_8_0.defTroopNum)
	else
		self.m_troopNumTxt:setText(var_0_2:getCityInfoById(self._cityId).num)
	end

	if var_0_2:isInfiniteCity(self._cityId) then
		self._txtTroopNum:setText(g.core.lang:get(429013))
	end

	if self._state == var_0_1.Slg2CityInfoState.GATHER_OTHER_OCCUPY or self._state == var_0_1.Slg2CityInfoState.GATHER_SELF_OCCUPY then
		local var_8_1 = 0
		local var_8_2 = 0
		local var_8_3 = false

		if var_0_2:isCityOccupied(self._cityId) then
			var_8_3 = true
			var_8_1 = var_0_2:getSelfGatherNum(self._cityId)
			var_8_2 = var_0_2:getOtherGatherNum(self._cityId)
		else
			var_8_3 = false
			var_8_1 = var_0_2:getSelfGatherNum(self._cityId)
			var_8_2 = math.max(var_0_2:getCityDefNum(self._cityId) - var_0_2:getCityNpcDefNum(self._cityId), 0)
		end

		self.m_Comp_troopNum:updateView({
			num1 = var_8_1,
			num2 = var_8_2,
			isDef = var_8_3
		})
	end
end

function NewSlgS2CityInfoBottomComp:_updateGatherBtn()
	local var_9_0 = var_0_2:getCityPeriod()

	self.m_btnGather:setCtrlState("state", {
		index = self.m_stateController:getSelectedIndex()
	})
	self.m_btnGather:setCtrlState("isGray", {
		index = 0
	})
	self.m_btnGather:getChild("title"):setColor(g.core.common.Color.A6)

	local var_9_1 = self.m_gradeController:getSelectedIndex()

	if var_9_0 == var_0_1.Slg2CityState.declare_war then
		if var_9_1 == var_0_6.GRADE.LEADER or var_9_1 == var_0_6.GRADE.VICE_LEADER then
			if var_0_2:isCityDeclared(self._cityId) then
				self.m_btnGather:setTitle(g.core.lang:get(429653))
			else
				self.m_btnGather:setTitle(g.core.lang:get(429652))
			end
		else
			self.m_btnGather:setCtrlState("state", {
				index = 6
			})
			self.m_btnGather:setCtrlState("isGray", {
				index = 1
			})
			self.m_btnGather:getChild("title"):setColor(g.core.common.Color.A2)
			self.m_btnGather:setTitle(g.core.lang:get(429549))
		end
	elseif var_9_0 == var_0_1.Slg2CityState.gather then
		if var_0_2:isCityGather(self._cityId) then
			self.m_btnGather:setTitle(g.core.lang:get(429641))
		else
			self.m_btnGather:setTitle(g.core.lang:get(428990))
		end
	end
end

function NewSlgS2CityInfoBottomComp:_updateDeclare()
	local var_10_0 = var_0_2:getCityDeclaration(self._cityId) or ""
	local var_10_1 = self.m_gradeController:getSelectedIndex()
	local var_10_2 = var_10_1 == var_0_6.GRADE.LEADER or var_10_1 == var_0_6.GRADE.VICE_LEADER

	if not (var_10_1 == var_0_6.GRADE.LEADER or var_10_1 == var_0_6.GRADE.VICE_LEADER) then
		self.m_tabGroup:setVisible(var_10_0 ~= "")
	end

	self.m_promptTxt:setVisible(false)

	if var_10_0 ~= "" then
		self.m_inputTxt:setText(var_10_0)
	else
		self.m_inputTxt:setText("")

		if var_10_2 then
			self.m_promptTxt:setVisible(self.m_selTabController:getSelectedIndex() == 1)
		end
	end
end

function NewSlgS2CityInfoBottomComp:_getState()
	local var_11_0 = var_0_2:getCityPeriod()

	if var_11_0 == var_0_1.Slg2CityState.last_day_declare_war then
		return 10
	end

	if var_0_2:isCityInShare(self._cityId) then
		if var_11_0 == var_0_1.Slg2CityState.gather then
			local var_11_1 = var_0_2:getCityOccupyAllianceId(self._cityId)

			if var_11_1 == 0 then
				if var_0_2:isCityCanGather(self._cityId) then
					return var_0_1.Slg2CityInfoState.GATHER_GATHER
				else
					return var_0_1.Slg2CityInfoState.CANT_GATHER
				end
			elseif var_11_1 ~= var_0_5:getAllianceId() then
				if var_0_2:isCityCanGather(self._cityId) then
					return var_0_1.Slg2CityInfoState.GATHER_OTHER_OCCUPY
				else
					return var_0_1.Slg2CityInfoState.CANT_GATHER
				end
			else
				return var_0_1.Slg2CityInfoState.GATHER_SELF_OCCUPY
			end
		elseif var_11_0 == var_0_1.Slg2CityState.declare_war then
			local var_11_2 = var_0_2:getCityOccupyAllianceId(self._cityId)

			if var_11_2 == 0 then
				if var_0_2:isCityCanDeclare(self._cityId) then
					return var_0_1.Slg2CityInfoState.CAN_DECLARE
				else
					return var_0_1.Slg2CityInfoState.CANT_DECLARE
				end
			elseif var_11_2 ~= var_0_5:getAllianceId() then
				if var_0_2:isCityCanDeclare(self._cityId) then
					return var_0_1.Slg2CityInfoState.DECLARE_OTHER_OCCUPY
				else
					return var_0_1.Slg2CityInfoState.CANT_DECLARE
				end
			else
				return var_0_1.Slg2CityInfoState.DECLARE_SELF_OCCUPY
			end
		end
	else
		if var_0_2:isCityOccupied(self._cityId) then
			return var_0_1.Slg2CityInfoState.HAS_OCCUPY
		end

		if var_11_0 == var_0_1.Slg2CityState.gather then
			if not var_0_2:isCityCanGather(self._cityId) then
				return var_0_1.Slg2CityInfoState.CANT_GATHER
			else
				return var_0_1.Slg2CityInfoState.CAN_GATHER
			end
		elseif var_11_0 == var_0_1.Slg2CityState.declare_war then
			if not var_0_2:isCityCanDeclare(self._cityId) then
				return var_0_1.Slg2CityInfoState.CANT_DECLARE
			else
				return var_0_1.Slg2CityInfoState.CAN_DECLARE
			end
		end
	end
end

function NewSlgS2CityInfoBottomComp:_getCityGatherState()
	if var_0_2:isCityDeclared(self._cityId) then
		if g.core.common.ServerTime:getTimestampByHMS(12, 0, 0) > g.core.common.ServerTime:getTime() then
			return var_0_1.Slg2CityGatherState.TIME_LIMIT
		end

		return var_0_1.Slg2CityGatherState.CAN_GATHER
	else
		return var_0_1.Slg2CityGatherState.NOT_DECLARE
	end
end

function NewSlgS2CityInfoBottomComp:_onClickBtnGather()
	if var_0_2:getCityPeriod() == var_0_1.Slg2CityState.declare_war then
		local var_13_0 = self.m_gradeController:getSelectedIndex()

		if var_13_0 ~= var_0_6.GRADE.LEADER and var_13_0 ~= var_0_6.GRADE.VICE_LEADER then
			if var_0_2:isCityDeclared(self._cityId) then
				var_0_7:tip(g.core.lang:get(429621))
			else
				var_0_7:tip(g.core.lang:get(429663))
			end

			return
		end
	end

	if self._state == var_0_1.Slg2CityInfoState.CANT_GATHER then
		if self:_getCityGatherState() == var_0_1.Slg2CityGatherState.NOT_DECLARE then
			var_0_7:tip(g.core.lang:get(429602))
		else
			var_0_7:tip(g.core.lang:get(429621))
		end

		return
	end

	if self._state == var_0_1.Slg2CityInfoState.CANT_DECLARE then
		if self._cityUnlockState == var_0_1.Slg2CityUnlockState.time or self._cityUnlockState == var_0_1.Slg2CityUnlockState.front then
			var_0_7:tip(g.core.lang:get(429603))
		elseif self._cityUnlockState == var_0_1.Slg2CityUnlockState.invalid then
			var_0_7:tip(g.core.lang:get(429604))
		else
			var_0_7:tip(g.core.lang:get(429605))
		end

		return
	end

	if self._state == var_0_1.Slg2CityInfoState.REWARD then
		var_0_7:tip(g.core.lang:get(429606))

		return
	end

	local var_13_1 = var_0_2:getCityInfoById(self._cityId)
	local var_13_2 = var_0_2:getCityComponentById(self._cityId)

	if self._state == var_0_1.Slg2CityInfoState.CAN_GATHER or self._state == var_0_1.Slg2CityInfoState.GATHER_OTHER_OCCUPY or self._state == var_0_1.Slg2CityInfoState.GATHER_GATHER then
		if var_0_2:isCityGather(self._cityId) then
			var_0_7:tip(g.core.lang:get(429659))

			return
		end

		self:dispatchCompEvent("NewSlg_City_Gather", {
			gatherTp = 0,
			buildType = var_0_1.MONSTER_TYPE.CITY,
			info = var_13_1,
			x = var_13_2.anchor_x,
			y = var_13_2.anchor_y
		})
	elseif self._state == var_0_1.Slg2CityInfoState.GATHER_SELF_OCCUPY then
		local var_13_3 = false
		local var_13_4 = var_0_5:getAllianceId()

		for iter_13_0, iter_13_1 in ipairs((var_0_2:getCityDeclaredAlliances(self._cityId))) do
			if iter_13_1 ~= var_13_4 then
				var_13_3 = true

				break
			end
		end

		local var_13_5 = handler(self, function(arg_14_0)
			arg_14_0:dispatchCompEvent("NewSlg_City_Gather", {
				gatherTp = 1,
				buildType = var_0_1.MONSTER_TYPE.CITY,
				info = var_13_1,
				x = var_13_2.anchor_x,
				y = var_13_2.anchor_y
			})
		end)

		if var_0_2:isCityGather(self._cityId) then
			var_0_7:tip(g.core.lang:get(429659))

			return
		end

		if var_13_3 then
			var_13_5()
		else
			local var_13_6 = require("app.view.base.pop.BaseConfirmPop").new

			var_0_7:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				desc = g.core.lang:get(429607),
				title = g.core.lang:get(429608),
				onConfirm = handler(self, function()
					var_13_5()
				end)
			}), {
				touchDisappear = false,
				ignoreTouch = true
			})
		end
	elseif self._state == var_0_1.Slg2CityInfoState.CAN_DECLARE or self._state == var_0_1.Slg2CityInfoState.DECLARE_OTHER_OCCUPY then
		local var_13_7 = {
			tp = 0,
			cityId = self._cityId
		}

		if var_0_2:isCityDeclared(self._cityId) then
			var_13_7.tp = 1
		end

		if var_13_7.tp == 0 and var_0_2:getDeclaredCityMaxCnt() <= #var_0_2:getSelfDeclaredCities() then
			var_0_7:tip(g.core.lang:get(429654))

			return
		end

		self:dispatchCompEvent("NewSlg_City_Declare", var_13_7)
	end
end

function NewSlgS2CityInfoBottomComp:_onClickBtnBuild()
	var_0_7:pushModule(g.view.entrance.NEW_SLG_S2_BUILD, {
		cityId = self._cityId
	})
end

function NewSlgS2CityInfoBottomComp:_onClickBtnCheckDefenderInfo()
	if not g.core.model.User.allianceData:hasAlliance() then
		var_0_7:tip(g.core.lang:get(428966))
	end

	if var_0_2:isCityInShare(self._cityId) then
		g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_S2_DEFENDER_POP, {
			id = self._cityId
		})
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_S2_DEFENDER_POP, {
			id = self._cityId
		})
	end
end

function NewSlgS2CityInfoBottomComp:_onClickEditBtn()
	local var_18_0 = var_0_2:isCityDeclared(self._cityId)
	local var_18_1 = #var_0_2:getCityDeclaredAlliances(self._cityId) > 0
	local var_18_2 = var_0_2:isCityOccupied(self._cityId)

	if var_18_2 and not var_18_1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(429661))
	elseif not var_18_2 and not var_18_0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(429662))
	end
end

function NewSlgS2CityInfoBottomComp:_onTabSelChanged()
	if self.m_selTabController:getSelectedIndex() == 1 then
		self:_updateDeclare()
	end
end

function NewSlgS2CityInfoBottomComp:_onClickConfirmBtn()
	local var_20_0 = var_0_2:isCityDeclared(self._cityId)
	local var_20_1 = #var_0_2:getCityDeclaredAlliances(self._cityId) > 0
	local var_20_2 = var_0_2:isCityOccupied(self._cityId)

	if var_20_2 and not var_20_1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(429661))

		return
	elseif not var_20_2 and not var_20_0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(429662))

		return
	end

	local var_20_3 = self.m_inputTxt:getText()

	if var_0_8.getCharactersNum(var_20_3, 2) > self._maxWords then
		var_0_7:tip(g.core.lang:get(429620, {
			num = self._maxWords
		}))

		return
	end

	g.core.network.GameNetProxy:send_C2S_NewSlg_SetCityDeclaration({
		city_id = self._cityId,
		declaration = var_20_3
	})
end

function NewSlgS2CityInfoBottomComp:_onClickDeleteBtn()
	g.core.network.GameNetProxy:send_C2S_NewSlg_SetCityDeclaration({
		declaration = "",
		city_id = self._cityId
	})
end

function NewSlgS2CityInfoBottomComp:_onEditDeclaration(arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0 = var_0_2:getCityDeclaration(self._cityId) or ""

	self.m_inputTxt:setText(var_22_0)
	self.m_promptTxt:setVisible(var_22_0 == "")
end

function NewSlgS2CityInfoBottomComp:onClickDecayClick()
	self:dispatchCompEvent("NewSlgDecayClick")
end

return NewSlgS2CityInfoBottomComp
