local NewSlgTeamSelectCell = class("NewSlgTeamSelectCell", require("app.fairyGUI.newSlg.UI_NewSlgTeamSelectCell"))

function NewSlgTeamSelectCell:ctor()
	self._txtName = self:getChild("Txt_name")
	self._txtRule = self:getChild("Txt_rule")
	self._txtPro = self:getChild("Txt_pro")
	self._txtUnlock = self:getChild("Txt_unlock")
	self._txtDesc = self:getChild("Txt_desc")
	self._lightCtrl = self:getController("light")
	self._stateCtrl = self:getController("state")
	self._compArmy = self:getChild("Comp_army")
	self._compIcon1 = self:getChild("Comp_icon1")

	self._compIcon1:addClickListener(handler(self, self._onIconClick1))

	self._compIcon2 = self:getChild("Comp_icon2")

	self._compIcon2:addClickListener(handler(self, self._onIconClick2))

	self._compIcon3 = self:getChild("Comp_icon3")

	self._compIcon3:addClickListener(handler(self, self._onIconClick3))

	self._compIcon4 = self:getChild("Comp_icon4")

	self._compIcon4:addClickListener(handler(self, self._onIconClick4))

	self._compIcon5 = self:getChild("Comp_icon5")

	self._compIcon5:addClickListener(handler(self, self._onIconClick5))

	self._compIcon6 = self:getChild("Comp_icon6")

	self._compIcon6:addClickListener(handler(self, self._onIconClick6))

	self._loaderView = self:getChild("Loader_view")

	self._loaderView:addClickListener(handler(self, self._onClickLoaderView))
	self:addClickListener(handler(self, self._onClickBtnCheck))

	self._compPro = self:getChild("Comp_pro")

	self._compPro:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSliderChanged))
	self._compPro:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onSliderEnd))

	self._compStatus = self:getChild("Comp_status")
	self._btnCheck = self:getChild("Btn_check")

	self._btnCheck:setTouchable(false)

	self._btnRestrain = self:getChild("Btn_restrain")

	self._btnRestrain:addClickListener(handler(self, self._onClickBtnRestrain))
	self._compArmy:addClickListener(handler(self, self._onClickBtnRestrain))
	self.m_elemBtn:addClickListener(handler(self, self._onClickElemBtn))

	self._typeCtrl = self:getController("type")
	self._imgRec = self:getChild("Img_rec")

	self.m_btnGoHome:addClickListener(handler(self, self._onGoHome))

	self._team = nil
	self._teamSignIdx = nil
	self._isIdle = true
	self._defArmyType = g.core.const.ConstMgr.NewSlgConst.ARMY_TYPE.QI
	self._itemCompArrMap = {
		[g.core.common.Goods.TYPE_KNIGHT] = {
			self._compIcon1,
			self._compIcon2,
			self._compIcon3,
			self._compIcon4,
			self._compIcon5,
			self._compIcon6
		}
	}
end

function NewSlgTeamSelectCell:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NEW_SLG_TEAM_SELECT, handler(self, self._onTeamSelect), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_MODULE_EXIT, handler(self, self._onModuleExit), self)
end

function NewSlgTeamSelectCell:_onModuleExit(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_3 and arg_3_3.params

	if (arg_3_3 and arg_3_3.params and var_3_0.index) == self._teamSignIdx then
		if var_3_0.isChangeArmy then
			self:_updateArmy()
			self:_updateDesc()
		end

		if var_3_0.isChangeItem then
			self:_updateIcon()
			self:_updateDesc()
		end
	end
end

function NewSlgTeamSelectCell:updateCell(arg_4_1, arg_4_2)
	self._isIdle = true

	self._typeCtrl:setSelectedIndex(0)

	self._team = arg_4_1.team
	self._teamSignIdx = arg_4_2

	if self._team then
		self._teamSignIdx = self._team.index
	end

	self._changeItem = arg_4_1.changeItem
	self._defAuthority = arg_4_1.defAuthority or 0
	self._defArmyType = arg_4_1.defArmyType
	self._defArmyNum = arg_4_1.defArmyNum or 0
	self._buildType = arg_4_1.buildType
	self._decrease = arg_4_1.decrease or 0
	self._isExt = arg_4_1.source == g.core.const.ConstMgr.NewSlgConst.TEAM_SOURCE_TYPE.SLG_PASS_CARD_SOURCE

	local var_4_0 = arg_4_1.lockLv == 0

	self._payType = 0

	if self._isExt then
		self._payType = arg_4_1.lockLv

		if not var_4_0 then
			self._txtUnlock:setText(g.core.lang:get(429805, {
				name = g.core.lang:get(429805 + self._payType)
			}))
		end
	else
		self._txtUnlock:setText(g.core.lang:get(429573, {
			level = arg_4_1.lockLv
		}))
	end

	self._txtName:setText(g.core.lang:get(428817, {
		index = arg_4_2
	}))

	self._teamMap = arg_4_1.teamMap
	self._team = self._teamMap[self._teamSignIdx]
	self._baseArmyNum = 0
	self._armyNum = 0

	if var_4_0 then
		self:_updateIcon()
		self:_updateArmy()
		self:_updateStatus()
		self:_updateDesc()
	else
		self._typeCtrl:setSelectedIndex(1)
		self._imgRec:setVisible(false)
		self.m_hasElemController:setSelectedIndex(0)
	end
end

function NewSlgTeamSelectCell:_updateStatus()
	self._isIdle = g.core.model.User.newSlgData:isTeamIdle(self._team)

	self._typeCtrl:setSelectedIndex(self._isIdle and 0 or 2)

	if not self._isIdle then
		self._compStatus:updateView({
			teamIndex = self._teamSignIdx
		})
	end
end

function NewSlgTeamSelectCell:_onTeamSelect(arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_3.selected

	self._lightCtrl:setSelectedIndex(0)

	if arg_6_3.index then
		self._btnCheck:setSelected(self._teamSignIdx == arg_6_3.index and var_6_0)
		self._lightCtrl:setSelectedIndex(self._btnCheck:isSelected() and 1 or 0)
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_Event_Shenshou_ShangZhen)
	self:_updateDesc()
end

function NewSlgTeamSelectCell:_updateArmy()
	if not self._team then
		return
	end

	local var_7_0 = self._team.troop_type or g.core.const.ConstMgr.NewSlgConst.ARMY_TYPE.QI
	local var_7_1 = g.core.model.User.newSlgDevelopData:getBarrackLvByType(var_7_0)

	self._armyMax = g.core.model.User.newSlgDevelopData:getArmyInitTroopsByType(var_7_0)

	if self._team.troops > self._armyMax then
		self._changeItem.size = self._changeItem.size + (self._team.troops - self._armyMax) * self._changeItem.cost

		self:dispatchCompEvent("NewSlgTeamSelectCell_change")

		self._team.troops = self._armyMax
	end

	self._baseArmyNum = self._team.troops or 0
	self._armyNum = self._baseArmyNum

	self._compArmy:updateView({
		armyType = var_7_0,
		level = var_7_1
	})
	self._compPro:setMax(self._armyMax)
	self._compPro:setValue(self._armyNum)
	self:_updateArmyNum()
	self._imgRec:setVisible(false)

	if g.core.model.User.newSlgData:getArmyCtrlByType(var_7_0) == self._defArmyType then
		self._imgRec:setVisible(true)
	else
		self._imgRec:setVisible(false)
	end

	if g.core.model.User.newSlgData:getArmyCtrlByType(self._defArmyType) == var_7_0 then
		-- block empty
	end
end

function NewSlgTeamSelectCell:_updateArmyNum()
	self._txtPro:setText(g.core.lang:get(428999, {
		value = self._armyNum,
		max = self._armyMax
	}))
end

function NewSlgTeamSelectCell:_updateIcon()
	local var_9_0 = self._team.characters or {}
	local var_9_1 = {}

	if #var_9_0 > 0 then
		for iter_9_0, iter_9_1 in ipairs(var_9_0) do
			if var_9_1[iter_9_1.tp] == nil then
				var_9_1[iter_9_1.tp] = {}
			end

			table.insert(var_9_1[iter_9_1.tp], iter_9_1)
		end
	end

	local var_9_2 = {}

	for iter_9_2, iter_9_3 in pairs(self._itemCompArrMap) do
		local var_9_3 = var_9_1[iter_9_2] or {}

		for iter_9_4, iter_9_5 in ipairs(iter_9_3) do
			local var_9_4 = var_9_3[iter_9_4] or {
				tp = iter_9_2
			}

			iter_9_5:updateView({
				character = var_9_4
			})

			if iter_9_2 == g.core.common.Goods.TYPE_KNIGHT then
				local var_9_5 = g.core.common.GlobalFunc.getStructByTypeAndSerId(iter_9_2, var_9_4.id)

				if var_9_5 then
					local var_9_6 = var_9_5:getBaseInfo().classical

					if var_9_6 ~= 0 then
						var_9_2[#var_9_2 + 1] = var_9_6
					end
				end
			end
		end
	end

	local var_9_7, var_9_8, var_9_9 = g.core.model.User.newSlgData:getTeamElementTypeAndAffectValue(var_9_2)

	if var_9_7 ~= 0 then
		self.m_elemIcon:setIcon((g.core.common.Path:getKnightElementIcon(var_9_7, "ui://newSlg_mapUI/")))
		self.m_hasElemController:setSelectedIndex(1)
		self.m_elemProTxt:setVisible(false)

		if var_9_9.nextCfg then
			self.m_elemProTxt:setText(table.concat({
				var_9_9.matchNum,
				g.core.const.ConstMgr.KNIGHT_CONST.LINEUP_MAX
			}, "/"))
			self.m_elemProTxt:setVisible(true)
		end
	else
		self.m_hasElemController:setSelectedIndex(0)
	end

	self._txtRule:setText((self:_getAuthority()))
end

function NewSlgTeamSelectCell:_updateDesc()
	self._txtDesc:setVisible(false)

	if self._team == nil then
		return
	end

	if #(self._team.characters or {}) <= 0 then
		return
	end

	if self._buildType == g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.MONSTER or self._buildType == g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.FARM then
		local var_10_0 = self._btnCheck:isSelected()

		self._txtDesc:setVisible(var_10_0)

		if var_10_0 then
			local var_10_1 = self._team.troop_type or g.core.const.ConstMgr.NewSlgConst.ARMY_TYPE.QI
			local var_10_2 = g.core.model.User.newSlgData:getBattleWinPercent(self._armyNum, self:_getAuthority() * (100 - self._decrease) / 100, var_10_1, self._defArmyType)
			local var_10_3 = var_10_2 * g.core.model.User.newSlgData:getNewSlgParamsValueByKey("battle_parameter_14") / 10000
			local var_10_4 = var_10_2 * g.core.model.User.newSlgData:getNewSlgParamsValueByKey("battle_parameter_15") / 10000
			local var_10_5 = g.core.model.User.newSlgData:getBattleWinPercent(self._defArmyNum, self._defAuthority, self._defArmyType, var_10_1)
			local var_10_6 = var_10_5 * g.core.model.User.newSlgData:getNewSlgParamsValueByKey("battle_parameter_14") / 10000
			local var_10_7 = var_10_5 * g.core.model.User.newSlgData:getNewSlgParamsValueByKey("battle_parameter_15") / 10000
			local var_10_8 = ""

			if var_10_6 <= var_10_3 and var_10_6 <= var_10_4 then
				self._stateCtrl:setSelectedIndex(0)

				var_10_8 = g.core.lang:get(428841)
			elseif var_10_6 <= var_10_3 and var_10_4 < var_10_6 then
				self._stateCtrl:setSelectedIndex(1)

				var_10_8 = g.core.lang:get(428842)
			elseif var_10_3 < var_10_6 and var_10_3 < var_10_7 then
				self._stateCtrl:setSelectedIndex(2)

				var_10_8 = g.core.lang:get(428843)
			elseif var_10_3 < var_10_6 and var_10_7 <= var_10_6 then
				self._stateCtrl:setSelectedIndex(3)

				var_10_8 = g.core.lang:get(428844)
			end

			self._txtDesc:setText(var_10_8)
		end
	end
end

function NewSlgTeamSelectCell:_getAuthority()
	self._isIdle = g.core.model.User.newSlgData:isTeamIdle(self._team)

	return self._isIdle and g.core.model.User.newSlgData:getTeamAuthorityByTeam(self._team) or self._team.authority or 0
end

function NewSlgTeamSelectCell:_onClickBtnCheck()
	if self._typeCtrl:getSelectedIndex() ~= 0 then
		return
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NEW_SLG_TEAM_SELECT, false, {
		index = self._teamSignIdx,
		selected = not self._btnCheck:isSelected()
	})
end

function NewSlgTeamSelectCell:_onClickBtnRestrain()
	self._changeArmyType = self._team.troop_type

	g.core.module.ModuleManager:pushPopup(require("app.view.module.slg.view.team.NewSlgTeamSelectArmyPop").new({
		team = self._team,
		defArmyType = self._defArmyType
	}), {
		isChangeArmy = true,
		index = self._team.index
	})
end

function NewSlgTeamSelectCell:_onGoHome()
	self:dispatchCompEvent("NEW_SLG_POP_GO_HOME", {
		extType = self._payType
	})
end

function NewSlgTeamSelectCell:_onSliderChanged()
	if self._sliderSchedule then
		return
	end

	self._sliderSchedule = self:newScheduleOnce(handler(self, self.onSliderChangeAction))
end

function NewSlgTeamSelectCell:onSliderChangeAction()
	local var_16_0 = math.floor(self._compPro:getValue())
	local var_16_1 = math.min(math.floor(self._changeItem.size / self._changeItem.cost), var_16_0 - self._baseArmyNum)

	self._changeItem.size = self._changeItem.size - var_16_1 * self._changeItem.cost

	local var_16_2 = math.min(var_16_0, self._baseArmyNum + var_16_1)

	self._armyNum = var_16_2
	self._team.troops = self._armyNum

	self._compPro:setValue(self._armyNum)
	self:_updateArmyNum()

	self._baseArmyNum = var_16_2

	self:cancelSchedule(self._sliderSchedule)

	self._sliderSchedule = nil

	self:_updateDesc()
	self:dispatchCompEvent("NewSlgTeamSelectCell_change")
end

function NewSlgTeamSelectCell:_onSliderEnd()
	return
end

function NewSlgTeamSelectCell:_showSelectItemPop(arg_18_1)
	g.core.module.ModuleManager:pushPopup(require("app.view.module.slg.view.team.NewSlgTeamSelectItemPop").new({
		teamMap = self._teamMap,
		teamIndex = self._teamSignIdx,
		itemType = arg_18_1
	}), {
		isChangeItem = true,
		index = self._teamSignIdx
	})
end

function NewSlgTeamSelectCell:_onIconClick1()
	self:_showSelectItemPop(g.core.common.Goods.TYPE_KNIGHT)
end

function NewSlgTeamSelectCell:_onIconClick2()
	self:_showSelectItemPop(g.core.common.Goods.TYPE_KNIGHT)
end

function NewSlgTeamSelectCell:_onIconClick3()
	self:_showSelectItemPop(g.core.common.Goods.TYPE_KNIGHT)
end

function NewSlgTeamSelectCell:_onIconClick4()
	self:_showSelectItemPop(g.core.common.Goods.TYPE_KNIGHT)
end

function NewSlgTeamSelectCell:_onIconClick5()
	self:_showSelectItemPop(g.core.common.Goods.TYPE_KNIGHT)
end

function NewSlgTeamSelectCell:_onIconClick6()
	self:_showSelectItemPop(g.core.common.Goods.TYPE_KNIGHT)
end

function NewSlgTeamSelectCell:_onClickLoaderView()
	self:dispatchCompEvent("NewSlgTeamSelectCell_show_rule")
end

function NewSlgTeamSelectCell:_onClickElemBtn()
	if not self._team or not self._team.characters then
		g.core.module.ModuleManager:tip(g.core.lang:get(429767))

		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_ELEM_TIP_POP, self._team.characters)
end

return NewSlgTeamSelectCell
