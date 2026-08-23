local NewSlgTeamSelectArmyPop = class("NewSlgTeamSelectArmyPop", require("app.fairyGUI.newSlg.UI_NewSlgTeamSelectArmyPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgTeamSelectArmyPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg",
		dump({
			...
		})
	}, ...)
end)

function NewSlgTeamSelectArmyPop:ctor(arg_2_1)
	self:showAtCenter()

	self._txtDesc = self:getChild("Txt_desc")
	self._btnArmy1 = self:getChild("Btn_army1")

	self._btnArmy1:addClickListener(handler(self, self._onClickBtnArmy))

	self._btnArmy2 = self:getChild("Btn_army2")

	self._btnArmy2:addClickListener(handler(self, self._onClickBtnArmy))

	self._btnArmy3 = self:getChild("Btn_army3")

	self._btnArmy3:addClickListener(handler(self, self._onClickBtnArmy))

	self._compArmyIcon1 = self:getChild("Comp_army_icon1")
	self._compArmyIcon2 = self:getChild("Comp_army_icon2")
	self._btnGo = self:getChild("Btn_go")

	self._btnGo:addClickListener(handler(self, self._onClickBtnGo))

	self._armyTypeCtrl = self:getController("army_type")

	self._armyTypeCtrl:addEventListener(fgui.UIEventType.Changed, handler(self, self._onArmyChanged))

	self._armyCtrlCtrl = self:getController("army_ctrl")
	self._team = arg_2_1.team
	self._armyType = self._team.troop_type
	self._defArmyType = arg_2_1.defArmyType

	self.m_closeBtn:setClickCallBack(handler(self, self.onClose))
	self.m_closeGraph:addClickListener(handler(self, self.onClose))
	self:_initView()
end

function NewSlgTeamSelectArmyPop:_initView()
	local var_3_0 = {
		g.core.const.ConstMgr.NewSlgConst.ARMY_TYPE.QI,
		g.core.const.ConstMgr.NewSlgConst.ARMY_TYPE.DUN,
		g.core.const.ConstMgr.NewSlgConst.ARMY_TYPE.GONG
	}

	for iter_3_0 = 1, 3 do
		self["_btnArmy" .. iter_3_0]:updateView({
			armyType = var_3_0[iter_3_0],
			isMyArmyType = var_3_0[iter_3_0] == self._armyType,
			defArmyType = self._defArmyType
		})
	end

	self._compArmyIcon2:updateView({
		armyType = self._defArmyType
	})
end

function NewSlgTeamSelectArmyPop:onClose()
	if self._isClose then
		return
	end

	self._isClose = true

	self.m_backTransition:play(handler(self, self.onCloseFinish))
end

function NewSlgTeamSelectArmyPop:onCloseFinish()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewSlgTeamSelectArmyPop:onLoad()
	self.m_enterTransition:play()
	self:_updateView()
end

function NewSlgTeamSelectArmyPop:_updateView()
	self._armyTypeCtrl:setSelectedIndex(self._armyType - 1)
	self._compArmyIcon1:updateView({
		armyType = self._armyType
	})
	self._armyCtrlCtrl:setSelectedIndex(2)

	local var_7_0, var_7_1 = g.core.model.User.newSlgData:getArmyCtrlByType(self._armyType)

	if var_7_0 == self._defArmyType then
		self._armyCtrlCtrl:setSelectedIndex(1)
	elseif g.core.model.User.newSlgData:getArmyCtrlByType(self._defArmyType) == self._armyType then
		self._armyCtrlCtrl:setSelectedIndex(0)
	end

	self._txtDesc:setText(var_7_1)
end

function NewSlgTeamSelectArmyPop:_onClickBtnArmy(arg_8_1)
	local var_8_0 = arg_8_1:getSender():getArmyType()

	if self._team.troop_type ~= var_8_0 then
		self._team.troop_type = var_8_0
	end
end

function NewSlgTeamSelectArmyPop:_onArmyChanged()
	self._armyType = self._armyTypeCtrl:getSelectedIndex() + 1

	self:_updateView()
end

function NewSlgTeamSelectArmyPop:_onClickBtnGo()
	g.core.module.ModuleManager:popComponent()
end

return NewSlgTeamSelectArmyPop
