local var_0_0 = g.core.const.ConstMgr.NewSlgConst
local NewSlgTeamSelectPop = class("NewSlgTeamSelectPop", require("app.fairyGUI.newSlg.UI_NewSlgTeamSelectPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgTeamSelectPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)
local var_0_2 = g.core.utils.Tools.newSlgFunc
local var_0_3 = g.core.model.User.newSlgData

function NewSlgTeamSelectPop:ctor(arg_2_1)
	self:showAtCenter()

	self._hideCostCtrl = self:getController("hide_cost")

	self._hideCostCtrl:setSelectedIndex(0)

	self._compArmy = self:getChild("Comp_army")
	self._compName = self:getChild("Txt_name")
	self._resTitle = self:getChild("resTitle")
	self._resIcon = self:getChild("resIcon")
	self._btnGo = self:getChild("Btn_go")

	self._btnGo:addClickListener(handler(self, self._onClickBtnGo))

	self._btnRule = self:getChild("Btn_rule")

	self._btnRule:addClickListener(handler(self, self._onClickBtnRule))

	self._txtLevel = self:getChild("Txt_level")
	self._txtArmy = self:getChild("Txt_army")
	self._txtRule = self:getChild("Txt_rule")
	self._txtTeamNum = self:getChild("Txt_team_num")
	self._loaderView = self:getChild("Loader_view")

	self._loaderView:addClickListener(handler(self, self._onClickBtnView))

	self._listTeam = self:getChild("List_team")

	self._listTeam:setVirtual(self)
	self._listTeam:setItemRenderer(handler(self, self._onRenderListTeamCell))

	self._typeCtrl = self:getController("type")
	self._monsterTypeCtrl = self:getController("monster_type")
	self._posCtrl = self:getController("pos")
	self._buildType = arg_2_1.buildType
	self._buildInfo = arg_2_1.info
	self._buildArmyType = g.core.const.ConstMgr.NewSlgConst.ARMY_TYPE.QI
	self._defTroopNum = 0
	self._posX = arg_2_1.x
	self._posY = arg_2_1.y
	self._path = arg_2_1.path
	self._returnPath = arg_2_1.returnPath
	self._params = arg_2_1

	self:getChild("Group_army"):setVisible(self._buildType ~= g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.BOSS)

	self._baseCnt = g.core.model.User.newSlgDevelopData:getMaxTroopNum()

	self:getChild("Txt_time"):setText(g.core.lang:get(428839, {
		time = g.core.common.ServerTime:getLeftMSFormat(g.core.common.ServerTime:getTime() + require("app.view.module.slg.const.NewSlgFunc").getMarchDurationByPath(self._path, 0, self._buildType), true)
	}))

	if self._buildType == g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.CITY then
		self._monsterTypeCtrl:setSelectedIndex(1)
		self._hideCostCtrl:setSelectedIndex(1)
		self._posCtrl:setSelectedIndex(2)
	elseif self._buildType == g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.BOSS then
		self._hideCostCtrl:setSelectedIndex(1)
		self._posCtrl:setSelectedIndex(1)
	elseif self._buildType == var_0_0.MONSTER_TYPE.FARM then
		self._posCtrl:setSelectedIndex(3)
		self._hideCostCtrl:setSelectedIndex(1)
		self._monsterTypeCtrl:setSelectedIndex(0)
	elseif self._buildType == g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.MONSTER then
		self._posCtrl:setSelectedIndex(0)
		self._loaderView:setVisible(false)
	end

	self._selectTeamIdxMap = {}

	self:_updateMyTeamData()
	self.m_closeBtn:setClickCallBack(handler(self, self.onClose))
	self.m_closeGraph:addClickListener(handler(self, self.onClose))
end

function NewSlgTeamSelectPop:onLoad()
	self.m_enterTransition:play()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NEW_SLG_TEAM_SELECT, handler(self, self._onTeamSelect), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OP_OBJECT, handler(self, self._onOpObject), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETCITYDEFINFO, handler(self, self._onRcvNewSlgGetCityDefInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_BOSSMONSTERTEAM, handler(self, self._onRcvNewSlgGetBossDefInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SYNCUSERTEAM, handler(self, self._onRcvTeamRefresh), self)

	if self._buildType == g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.CITY then
		g.core.network.GameNetProxy:send_C2S_NewSlg_GetCityDefInfo({
			city_id = self._buildInfo.id
		})
	elseif self._buildType == g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.BOSS then
		g.core.network.GameNetProxy:send_C2S_NewSlg_BossMonsterTeam({
			boss_id = self._buildInfo.id
		})
	end

	self:_updateMyTeamData()
	self:_updateView()
end

function NewSlgTeamSelectPop:_onRcvNewSlgGetCityDefInfo(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self._defArr = arg_4_4.def_teams or {}

	self:updateAuthority()
end

function NewSlgTeamSelectPop:_onRcvNewSlgGetBossDefInfo(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = var_0_3:getBossInfoById(arg_5_4.boss_id)

	arg_5_4.team.authority = math.floor(var_0_3:getBossTotalAuthority(arg_5_4.boss_id) / var_5_0.num)
	self._defArr = {}

	for iter_5_0 = 1, var_5_0.num do
		table.insert(self._defArr, arg_5_4.team)
	end

	self:updateAuthority()
end

function NewSlgTeamSelectPop:updateAuthority()
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs(self._defArr) do
		var_6_0 = var_6_0 + iter_6_1.authority
	end

	self._txtRule:setText(var_6_0)
end

function NewSlgTeamSelectPop:onClose()
	if self._isClose then
		return
	end

	self._isClose = true

	self.m_backTransition:play(handler(self, self.onCloseFinish))
end

function NewSlgTeamSelectPop:onCloseFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewSlgTeamSelectPop:_checkGuide()
	return
end

function NewSlgTeamSelectPop:receiveCompEvent(arg_10_1, arg_10_2)
	if arg_10_1 == "NewSlgTeamSelectCell_change" then
		self:_updateRes()
	elseif arg_10_1 == "NEW_SLG_POP_GO_HOME" then
		if arg_10_2.extType == 0 then
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_DEVELOP_MAIN_LAYER)
		else
			g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_BP, {
				activityId = var_0_3:getCommonPassCardActId()
			})
		end

		return true
	elseif arg_10_1 == "NewSlgFarmConfirmPop_ok" then
		self:dispatchCompEvent("NewSlg_play_march_sound")
		g.core.module.ModuleManager:send_C2S_NewSlg_FarmMarch(arg_10_2)

		if not tolua.isnull(self) then
			self:removeSelf()
		end
	elseif arg_10_1 == "NewSlgSupply_goto_farm" then
		self:dispatchCompEvent("NewSlgSupply_goto_farm")
	end

	if arg_10_1 == "NewSlgTeamSelectCell_show_rule" then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.slg.view.team.NewSlgTeamRulePop").new({
			teamMap = clone(self._tempMyTeam)
		}), {
			touchDisappear = true
		})
	end
end

function NewSlgTeamSelectPop:_updateView()
	if self._buildType == var_0_0.MONSTER_TYPE.MONSTER then
		self:_updateMonster()
	elseif self._buildType == var_0_0.MONSTER_TYPE.BOSS then
		self:_updateBoss()
	elseif self._buildType == var_0_0.MONSTER_TYPE.CITY then
		self:_updateCity()
	elseif self._buildType == var_0_0.MONSTER_TYPE.FARM then
		self:_updateFarm()
	end

	self._btnGo:updateCost(g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_ITEM,
		value = g.core.const.ConstMgr.NewSlgConst.MONSTER_COST_ID
	}), 1, (var_0_3:getLeftMonsterFightCount()))
	self:_updateTeam()
	self:_updateRes()
	self:_updateSelect()
end

function NewSlgTeamSelectPop:_updateMonster()
	self._buildArmyType = self._buildInfo.army_type

	self._compName:setText(self._buildInfo.name)
	self._txtLevel:setText(g.core.lang:get(428819, {
		level = self._buildInfo.level
	}))
	self._compArmy:updateView({
		armyType = self._buildArmyType
	})

	local var_12_0 = var_0_3:getMonsterDataByRC(self._posX, self._posY)
	local var_12_1, var_12_2

	if var_12_0 then
		var_12_1 = var_12_0.maxTroops or self._buildInfo.troops

		if var_12_0 then
			var_12_2 = var_12_0.troops or var_12_1
		end
	end

	self._defTroopNum = var_12_2

	self._txtArmy:setText(g.core.lang:get(428977, {
		num1 = self._defTroopNum,
		num2 = var_12_1
	}))
	self._txtRule:setText(self._buildInfo.authority)
end

function NewSlgTeamSelectPop:_updateBoss()
	self._buildArmyType = self._buildInfo.boss_army_type

	self._compName:setText(self._buildInfo.name)
	self._txtLevel:setText(g.core.lang:get(429003, {
		level = self._buildInfo.level
	}))
	self._txtRule:setText(self._buildInfo.authority)
	self._compArmy:updateView({
		armyType = self._buildArmyType
	})
end

function NewSlgTeamSelectPop:_updateCity()
	self._buildArmyType = self._buildInfo.army_type

	self._compName:setText(self._buildInfo.name)
	self._txtLevel:setText(g.core.lang:get(429003, {
		level = self._buildInfo.level
	}))

	local var_14_0 = var_0_3:getCitySerData(self._buildInfo.id)
	local var_14_1 = self._buildInfo.num

	self._txtArmy:setText(g.core.lang:get(428977, {
		num1 = (var_14_0 or nil) and (var_14_0.defTroopNum or var_14_1),
		num2 = var_14_1
	}))
	self._txtRule:setText(self._buildInfo.authority)
	self._compArmy:updateView({
		armyType = self._buildArmyType
	})
end

function NewSlgTeamSelectPop:_updateFarm()
	self._buildArmyType = self._buildInfo.army_type

	self._compName:setText(self._buildInfo.name)
	self._txtLevel:setText(g.core.lang:get(429690, {
		level = self._buildInfo.level
	}))

	local var_15_0 = self._params and self._params.serverData

	if not var_15_0 then
		self._txtArmy:setText(1)
		self._txtRule:setText(self._buildInfo.authority)
	else
		local var_15_1 = var_15_0.def_data

		self._defTeams = var_15_0.def_data.def_teams or {}
		self._farmTeams = var_15_1.farm_teams or {}

		local var_15_2 = 0
		local var_15_3 = 0

		for iter_15_0, iter_15_1 in ipairs(self._defTeams) do
			var_15_2 = var_15_2 + iter_15_1.authority
			var_15_3 = var_15_3 + iter_15_1.troops
		end

		for iter_15_2, iter_15_3 in ipairs(self._farmTeams) do
			var_15_2 = var_15_2 + iter_15_3.authority
			var_15_3 = var_15_3 + iter_15_3.troops
		end

		if not self._defTeams[1] then
			self._defTeams = var_15_1.robot_teams or {}

			for iter_15_4, iter_15_5 in ipairs(self._defTeams) do
				var_15_2 = var_15_2 + iter_15_5.authority
				var_15_3 = var_15_3 + iter_15_5.troops
			end
		end

		self._txtArmy:setText(var_15_3)

		self._defTroopNum = var_15_3

		if self._defTeams[1].uid then
			var_15_2 = math.floor(math.floor(var_15_2 * (100 - g.core.model.User.newSlgData:getAuthorityDecreaseNum(self._buildInfo.belong, self._defTeams[1].uid)) / 100))
		end

		self._txtRule:setText(var_15_2)

		self._buildInfo.authority = var_15_2
	end

	self._compArmy:updateView({
		armyType = self._buildArmyType
	})
end

function NewSlgTeamSelectPop:_updateTeam()
	self._teamInfoList = {}

	local var_16_0 = {}
	local var_16_1 = {}
	local var_16_3 = 0
	local var_16_4 = 0

	for iter_16_0 = 1, g.core.model.User.newSlgData:getMaxTeamCnt() do
		local var_16_5, var_16_6, var_16_7 = g.core.model.User.newSlgData:getTeamUnlockLevelByIndex(iter_16_0)

		dump({
			isUnlock = var_16_5,
			lv = var_16_6,
			source = var_16_7
		})

		local var_16_8 = {
			teamMap = self._tempMyTeam,
			defArmyType = self._buildArmyType,
			defAuthority = self._buildInfo.authority,
			defArmyNum = self._defTroopNum,
			buildType = self._buildType,
			changeItem = self._changeItem,
			isFarmHasOwner = self._params.isFarmHasOwner,
			decrease = self._params.decrease,
			source = var_16_7,
			lockLv = var_16_6
		}

		if var_16_5 then
			var_16_8.source = self._tempMyTeam[iter_16_0].source

			if var_0_3:isTeamIdle(self._tempMyTeam[iter_16_0]) then
				local var_16_9 = math.min(math.floor(self._changeItem.size / self._changeItem.cost), g.core.model.User.newSlgDevelopData:getArmyInitTroopsByType(self._tempMyTeam[iter_16_0].troop_type) - self._tempMyTeam[iter_16_0].troops)

				self._tempMyTeam[iter_16_0].troops = self._tempMyTeam[iter_16_0].troops + var_16_9
				self._changeItem.size = self._changeItem.size - var_16_9 * self._changeItem.cost
			end
		end

		if var_16_8.source == var_0_0.TEAM_SOURCE_TYPE.SLG_PASS_CARD_SOURCE then
			if var_16_5 then
				var_16_1[#var_16_1 + 1] = var_16_8
			else
				var_16_0[#var_16_0 + 1] = var_16_8
			end
		else
			local var_16_10 = #self._teamInfoList + 1

			self._teamInfoList[#self._teamInfoList + 1] = var_16_8

			if var_16_5 then
				var_16_3 = var_16_10 + 1
			elseif var_16_4 == 0 then
				var_16_4 = var_16_10
			end
		end
	end

	for iter_16_1 = #var_16_1, 1, -1 do
		table.insert(self._teamInfoList, var_16_3, var_16_1[iter_16_1])
	end

	if var_16_4 == 0 then
		var_16_4 = #self._teamInfoList + 1
	end

	for iter_16_2 = #var_16_0, 1, -1 do
		table.insert(self._teamInfoList, var_16_4, var_16_0[iter_16_2])
	end

	self._listTeam:setNumItems(#self._teamInfoList)
end

function NewSlgTeamSelectPop:_updateSelect()
	self._txtTeamNum:setText(g.core.lang:get(428977, {
		num2 = 1,
		num1 = table.nums(self._selectTeamIdxMap)
	}))
end

function NewSlgTeamSelectPop:_updateRes()
	local var_18_0 = g.core.common.Goods:convert({
		type = self._changeItem.type,
		value = self._changeItem.value
	})

	self._resTitle:setText(self._changeItem.size)
end

function NewSlgTeamSelectPop:_onClickBtnGet()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_SUPPLY_POP, {
		tab = 0
	})
end

function NewSlgTeamSelectPop:_onClickBtnRule()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.slg.view.team.NewSlgTeamRulePop").new(), {
		touchDisappear = true
	})
end

function NewSlgTeamSelectPop:_onClickBtnGo()
	if table.nums(self._selectTeamIdxMap) <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(428823))

		return
	end

	for iter_21_0, iter_21_1 in pairs(self._selectTeamIdxMap) do
		if self._tempMyTeam[iter_21_0] then
			if #(self._tempMyTeam[iter_21_0].characters or {}) <= 0 then
				g.core.module.ModuleManager:tip(g.core.lang:get(428822))

				return
			end

			if (self._tempMyTeam[iter_21_0].troops or 0) <= 0 then
				g.core.module.ModuleManager:tip(g.core.lang:get(428824))

				return
			end

			if not self:checkCanFightWin(self._tempMyTeam[iter_21_0]) then
				g.core.module.ModuleManager:pushModule(g.view.entrance.CONFIRM_POP, {
					title = g.core.lang:get(429038),
					desc = g.core.lang:get(429039),
					cancelText = g.core.lang:get(429040),
					onConfirm = handler(self, self._sendMarch),
					onCancel = handler(self, self.onClickGoToMainCity)
				})

				return
			end
		end
	end

	self:_sendMarch()
end

function NewSlgTeamSelectPop:onClickGoToMainCity()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_DEVELOP_MAIN_LAYER)
end

function NewSlgTeamSelectPop:checkCanFightWin(arg_23_1)
	local var_23_0 = arg_23_1.troop_type or g.core.const.ConstMgr.NewSlgConst.ARMY_TYPE.QI
	local var_23_1 = var_0_3:getBattleWinPercent(arg_23_1.troops, self:_getAuthority(arg_23_1), var_23_0, self._buildArmyType) * var_0_3:getNewSlgParamsValueByKey("battle_parameter_14") / 10000
	local var_23_2 = var_0_3:getBattleWinPercent(self._defTroopNum, self._buildInfo.authority, self._buildArmyType, var_23_0)

	if var_23_1 < var_23_2 * var_0_3:getNewSlgParamsValueByKey("battle_parameter_14") / 10000 and var_23_1 < var_23_2 * var_0_3:getNewSlgParamsValueByKey("battle_parameter_15") / 10000 then
		return false
	end

	return true
end

function NewSlgTeamSelectPop:_getAuthority(arg_24_1)
	return var_0_3:getTeamAuthorityByTeam(arg_24_1) or arg_24_1.authority or 0
end

function NewSlgTeamSelectPop:_onClickBtnView()
	if self._buildType == g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.CITY then
		if var_0_3:isCityInShare(self._buildInfo.id) then
			g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_S2_DEFENDER_POP, {
				id = self._buildInfo.id
			})
		else
			g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_PVC_DEFENDER_POP, {
				type = self._buildType,
				id = self._buildInfo.id
			})
		end
	elseif self._buildType == var_0_0.MONSTER_TYPE.FARM then
		g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_FARM_TEAM_POP, {
			tp = var_0_0.FARM_TEAM_POP_TYPE.DEF,
			id = self._buildInfo.id
		})
	else
		g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_PVC_DEFENDER_POP, {
			type = self._buildType,
			id = self._buildInfo.id
		})
	end
end

function NewSlgTeamSelectPop:_onTeamSelect(arg_26_1, arg_26_2, arg_26_3)
	if arg_26_3.index then
		self._selectTeamIdxMap = {}
		self._selectTeamIdxMap[arg_26_3.index] = arg_26_3.selected and true or nil

		self:_updateSelect()
	end
end

function NewSlgTeamSelectPop:_onOpObject(arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	if self._changeItem then
		local var_27_0 = g.core.model.User.bagData:getOwnNum(self._changeItem.type, self._changeItem.value)

		self._changeItem.init = var_27_0
		self._changeItem.size = self._changeItem.size + (var_27_0 - self._changeItem.init)

		self:_updateRes()
	end
end

function NewSlgTeamSelectPop:_onRenderListTeamCell(arg_28_1, arg_28_2)
	arg_28_2:updateCell(self._teamInfoList[arg_28_1 + 1], arg_28_1 + 1)
end

function NewSlgTeamSelectPop:_saveTeam()
	local var_29_0 = {}

	for iter_29_0, iter_29_1 in pairs(self._tempMyTeam) do
		if var_0_3:isTeamIdle(iter_29_1) then
			var_0_3:correctTeamTroopLevel(iter_29_1)
			var_0_3:formatTeamCharactersByTeam(iter_29_1)
			table.insert(var_29_0, iter_29_1)
		end
	end

	if var_29_0 and #var_29_0 > 0 then
		g.core.network.GameNetProxy:send_C2S_NewSlg_EditUserTeam({
			teams = var_29_0
		})
	end
end

function NewSlgTeamSelectPop:_onBtnClose()
	self:_saveTeam()
	g.core.module.ModuleManager:popComponent()
end

function NewSlgTeamSelectPop:_checkCityElemTip(arg_31_1, arg_31_2, arg_31_3)
	if self._buildType ~= g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.CITY then
		return
	end

	local var_31_0, var_31_1 = g.core.model.User.newSlgData:getCitySerData(self._buildInfo.id)

	if not var_31_1 or var_31_1.type == 1 then
		return true
	end

	local var_31_2 = var_31_1.element
	local var_31_3 = {}

	for iter_31_0, iter_31_1 in pairs(arg_31_1) do
		var_31_3[#var_31_3 + 1] = self._tempMyTeam[iter_31_1]
	end

	for iter_31_2, iter_31_3 in ipairs(var_31_3) do
		local var_31_4 = {}

		for iter_31_4, iter_31_5 in ipairs(iter_31_3.characters) do
			local var_31_5 = g.core.common.GlobalFunc.getStructByTypeAndSerId(g.core.common.Goods.TYPE_KNIGHT, iter_31_5.id)

			if var_31_5 then
				local var_31_6 = var_31_5:getBaseInfo().classical

				if var_31_6 ~= 0 then
					var_31_4[#var_31_4 + 1] = var_31_6
				end
			end
		end

		if g.core.model.User.newSlgData:getTeamElementTypeAndAffectValue(var_31_4) == var_31_2 then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(112543),
				desc = g.core.lang:get(429800, {
					value = var_31_1.num / 10
				}),
				onConfirm = handler(self, function(arg_32_0)
					arg_32_0:_sendCityMarch(arg_31_1, arg_31_2, arg_31_3)
				end)
			}))

			return false
		end
	end

	return true
end

function NewSlgTeamSelectPop:_sendCityMarch(arg_33_1, arg_33_2, arg_33_3)
	if var_0_3:getChariotMoveTimeStartTime() <= g.core.common.ServerTime:getTime() + var_0_2.getMarchDurationByPath(self._path, 0, self._buildType) then
		g.core.module.ModuleManager:tip(g.core.lang:get(428893))
	elseif var_0_3:getSelfGatherNum(self._buildInfo.id) >= var_0_3:getChariotGatherMaxNum(self._buildInfo.id, (not self._params.value2 or nil) and 0) then
		g.core.module.ModuleManager:tip(g.core.lang:get(428894))
	else
		self:dispatchCompEvent("NewSlg_play_march_sound")

		local var_33_1 = {
			city_id = self._buildInfo.id,
			teams = arg_33_2,
			move_path = self._path,
			supply_troop = arg_33_3,
			city_move_path = self._returnPath,
			team_index = arg_33_1[1]
		}

		var_33_1.march_tp = self._params.gatherTp or 0

		g.core.network.GameNetProxy:send_C2S_NewSlg_CityMarch(var_33_1)
	end

	g.core.module.ModuleManager:popComponent()
end

function NewSlgTeamSelectPop:_sendMarch()
	local var_34_0 = {}
	local var_34_1 = {}

	for iter_34_0, iter_34_1 in pairs(self._tempMyTeam) do
		if var_0_3:isTeamIdle(iter_34_1) then
			if self._selectTeamIdxMap[iter_34_0] then
				table.insert(var_34_0, iter_34_0)
			end

			var_0_3:correctTeamTroopLevel(iter_34_1)
			var_0_3:formatTeamCharactersByTeam(iter_34_1)
			table.insert(var_34_1, iter_34_1)
		end
	end

	for iter_34_2, iter_34_3 in ipairs(var_34_0) do
		if var_0_3:getTeamAuthorityByTeam(self._tempMyTeam[iter_34_3]) <= 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(428825))

			return
		end
	end

	if #var_34_0 > 0 and #var_34_1 > 0 then
		local var_34_2 = (self._changeItem.init - self._changeItem.size) / self._changeItem.cost

		if self._buildType == g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.MONSTER then
			self:_checkArmyControl({
				teamIndex = var_34_0[1],
				teamArr = var_34_1,
				callback = handler(self, function(arg_35_0)
					arg_35_0:dispatchCompEvent("NewSlg_play_march_sound")
					g.core.network.GameNetProxy:send_C2S_NewSlg_MonsterMarch({
						monster_id = arg_35_0._buildInfo.id,
						move_path = arg_35_0._path,
						supply_troop = var_34_2,
						team_indexs = var_34_0,
						teams = var_34_1
					})
					g.core.module.ModuleManager:popComponent()
				end)
			})
		elseif self._buildType == g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.CITY then
			if self:_checkCityElemTip(var_34_0, var_34_1, (self._changeItem.init - self._changeItem.size) / self._changeItem.cost) then
				self:_sendCityMarch(var_34_0, var_34_1, (self._changeItem.init - self._changeItem.size) / self._changeItem.cost)
			end
		elseif self._buildType == var_0_0.MONSTER_TYPE.FARM then
			local var_34_4 = self._params.marchTp
			local var_34_5 = {
				farm_id = self._buildInfo.id,
				teams = var_34_1,
				move_path = self._path,
				supply_troop = (self._changeItem.init - self._changeItem.size) / self._changeItem.cost,
				team_index = var_34_0[1]
			}
			local var_34_6, var_34_7, var_34_8 = var_0_3:isFarmPeriod()

			if var_34_4 == var_0_0.FARM_SERVER_TYPE.FARM then
				if self._btnFarmCheck:isSelected() then
					if not g.core.model.User.newSlgData:isCityInShare(self._buildInfo.belong) then
						g.core.module.ModuleManager:tip(g.core.lang:get("NEW_SLG_FARM_ERROR6"))
						self._btnFarmCheck:setSelected(false)

						return
					elseif var_34_8 == var_0_0.FARM_PERIOD.CLOSE then
						g.core.module.ModuleManager:tip(g.core.lang:get("NEW_SLG_FARM_ERROR7"))
						self._btnFarmCheck:setSelected(false)

						return
					else
						var_34_4 = var_0_0.FARM_SERVER_TYPE.FARM_DEF
					end
				end

				g.core.module.ModuleManager:pushPopup((require("app.view.newSlg.farm.NewSlgFarmConfirmPop").new({
					tp = 1,
					id = self._buildInfo.id,
					handlerParam = var_34_5
				})))
			elseif var_34_8 == var_0_0.FARM_PERIOD.OPEN then
				if var_34_7 < var_0_2.getMarchDurationByPath(self._path, self._speedAddPer) then
					g.core.module.ModuleManager:tip(g.core.lang:get(429691))
				elseif var_34_4 == var_0_0.FARM_SERVER_TYPE.ATK and not g.core.model.User:getIsNotTips("NEWSLG_FARM_OCC_MAX") and g.core.model.User.newSlgData:getFarmMaxLimit() <= g.core.model.User.newSlgData:getSelfOccupyFarmNum() then
					g.core.model.User:setIsNotTips("NEWSLG_FARM_OCC_MAX", true)
					g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
						title = g.core.lang:get(112543),
						desc = g.core.lang:get(429692),
						onConfirm = handler(self, function()
							g.core.network.GameNetProxy:send_C2S_NewSlg_FarmMarch(var_34_5)
							g.core.module.ModuleManager:popAllPopup()
						end),
						onCheck = handler(self, function(arg_37_0, arg_37_1)
							g.core.model.User:setIsNotTips("NEWSLG_FARM_OCC_MAX", arg_37_1)
						end),
						tip = {
							isChecked = true,
							txt = g.core.lang:get(108045)
						}
					}))
				else
					self:dispatchCompEvent("NewSlg_play_march_sound")
					g.core.network.GameNetProxy:send_C2S_NewSlg_FarmMarch(var_34_5)
					g.core.module.ModuleManager:popComponent()
				end
			else
				g.core.module.ModuleManager:tip(g.core.lang:get(429693))
				g.core.module.ModuleManager:popComponent()
			end
		elseif self._buildType == g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.BOSS then
			if self._params.bossJoinType == g.core.const.ConstMgr.NewSlgConst.SLGBossJoinType.CREATE then
				local var_34_9 = var_0_3:getBossChallengeTime()

				self:_checkArmyControl({
					teamIndex = var_34_0[1],
					teamArr = var_34_1,
					callback = handler(self, function(arg_38_0)
						g.core.network.GameNetProxy:send_C2S_NewSlg_BossCreateTeam({
							boss_id = arg_38_0._buildInfo.id,
							move_path = arg_38_0._path,
							supply_troop = var_34_2,
							teams = var_34_1,
							team_index = var_34_0[1]
						})
						g.core.module.ModuleManager:popComponent()
					end)
				})
			elseif self._params.bossJoinType == g.core.const.ConstMgr.NewSlgConst.SLGBossJoinType.JOIN then
				local var_34_10 = var_0_3:getBossTeamInfo(self._params.teamId)

				if not var_34_10 then
					g.core.module.ModuleManager:tip(g.core.lang:get(428930))
				elseif var_34_10.state ~= g.core.const.ConstMgr.NewSlgConst.SLGBossTeamState.STATE_1 then
					g.core.module.ModuleManager:tip(g.core.lang:get(428931))
				elseif var_34_10.create_time + var_0_3:getBossTeamGatherTotalTime() < g.core.common.ServerTime:getTime() + var_0_2.getMarchDurationByPath(self._path, 0, self._buildType) then
					g.core.module.ModuleManager:tip(g.core.lang:get(428932))
				else
					self:_checkArmyControl({
						teamIndex = var_34_0[1],
						teamArr = var_34_1,
						callback = handler(self, function(arg_39_0)
							g.core.network.GameNetProxy:send_C2S_NewSlg_BossJoinTeam({
								team_id = arg_39_0._params.teamId,
								teams = var_34_1,
								team_index = var_34_0[1],
								move_path = arg_39_0._path,
								supply_troop = var_34_2
							})
							g.core.module.ModuleManager:popComponent()
						end)
					})
				end
			elseif self._params.bossJoinType == g.core.const.ConstMgr.NewSlgConst.SLGBossJoinType.QUICK_JOIN then
				self:_checkArmyControl({
					teamIndex = var_34_0[1],
					teamArr = var_34_1,
					callback = handler(self, function(arg_40_0)
						g.core.network.GameNetProxy:send_C2S_NewSlg_BossQuickJoinTeam({
							boss_id = arg_40_0._buildInfo.id,
							teams = var_34_1,
							team_index = var_34_0[1],
							move_path = arg_40_0._path,
							supply_troop = var_34_2
						})
						g.core.module.ModuleManager:popComponent()
					end)
				})
			end
		end
	end
end

function NewSlgTeamSelectPop:_checkArmyControl(arg_41_1)
	local var_41_0

	for iter_41_0, iter_41_1 in ipairs(arg_41_1.teamArr) do
		if iter_41_1.index == arg_41_1.teamIndex then
			var_41_0 = iter_41_1
		end
	end

	if not var_41_0 and arg_41_1.callback then
		arg_41_1.callback()
	end

	if var_0_3:getDebuffArmyCtrlByType(var_41_0.troop_type) == self._buildArmyType then
		g.core.module.ModuleManager:pushModule(g.view.entrance.CONFIRM_POP, {
			title = g.core.lang:get(112543),
			desc = g.core.lang:get(428840),
			onConfirm = function()
				if arg_41_1.callback then
					arg_41_1.callback()
				end
			end
		})
	elseif arg_41_1.callback then
		arg_41_1.callback()
	end
end

function NewSlgTeamSelectPop:_updateMyTeamData()
	self._unlockTeamNum = g.core.model.User.newSlgDevelopData:getUnlockTeamNum()
	self._unlockPassCardTeamNum = var_0_3:getUnlockPassCardTeamNum()

	local var_43_0 = var_0_3:getCacheTeamData()
	local var_43_1 = {}
	local var_43_2 = 0

	self._tempMyTeam = clone(var_0_3:getMyTeamMap())

	local var_43_3 = 1
	local var_43_4 = self._unlockTeamNum
	local var_43_5 = self._unlockPassCardTeamNum
	local var_43_6 = {
		[var_0_0.TEAM_SOURCE_TYPE.CITY_DEVELOP_SOURCE] = 0,
		[var_0_0.TEAM_SOURCE_TYPE.SLG_PASS_CARD_SOURCE] = 0
	}

	while var_43_4 + var_43_5 > 0 do
		local var_43_7 = self._tempMyTeam[var_43_3]

		if not self._tempMyTeam[var_43_3] then
			var_43_7 = var_0_3:getInitTeamData(var_43_3)

			if var_43_4 > 0 then
				var_43_4 = var_43_4 - 1
			else
				var_43_7.source = var_0_0.TEAM_SOURCE_TYPE.SLG_PASS_CARD_SOURCE
				var_43_5 = var_43_5 - 1
			end

			self._tempMyTeam[var_43_3] = var_43_7
		elseif var_43_7.source == var_0_0.TEAM_SOURCE_TYPE.CITY_DEVELOP_SOURCE then
			var_43_4 = var_43_4 - 1
		elseif var_43_7.source == var_0_0.TEAM_SOURCE_TYPE.SLG_PASS_CARD_SOURCE then
			var_43_5 = var_43_5 - 1
		end

		local var_43_9 = var_43_6[var_43_7.source] + 1

		var_43_6[var_43_7.source] = var_43_6[var_43_7.source] + 1

		if var_43_2 > 0 then
			for iter_43_0, iter_43_1 in pairs(var_43_1) do
				if iter_43_1.source == var_43_7.source and iter_43_1.localIndex == var_43_9 then
					var_43_7.characters = iter_43_1.characters
					var_43_1[iter_43_0] = nil

					break
				end
			end
		end

		var_43_3 = var_43_3 + 1
	end

	self:_initTempTeamData()

	local var_43_10 = var_0_3:getSlgInfo()
	local var_43_11 = g.core.model.User.bagData:getOwnNum(var_43_10.troop_cost_type, var_43_10.troop_cost_value)

	self._changeItem = {
		type = var_43_10.troop_cost_type,
		value = var_43_10.troop_cost_value,
		cost = var_43_10.troop_cost_size,
		size = var_43_11,
		init = var_43_11
	}
end

function NewSlgTeamSelectPop:_initTempTeamData()
	return
end

function NewSlgTeamSelectPop:_onRcvTeamRefresh(arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	if arg_46_4 and arg_46_4.teams and #arg_46_4.teams > 0 then
		self:_updateMyTeamData()
		self:_updateTeam()
	end
end

return NewSlgTeamSelectPop
