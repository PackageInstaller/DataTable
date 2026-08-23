local NewSlgBossViewComp = class("NewSlgBossViewComp")

function NewSlgBossViewComp:ctor()
	self._compPlace = self:getChild("Comp_place")
	self._compArmyIcon = self:getChild("Comp_armyIcon")
	self._valueTxt = self:getChild("valueTxt")
	self._lvTxt = self:getChild("lvTxt")
	self._btnView = self:getChild("Btn_view")

	self._btnView:addClickListener(handler(self, self._onClickBtnView))

	self._txtName = self:getChild("Txt_name")
end

function NewSlgBossViewComp:updateView(arg_2_1)
	if not arg_2_1 then
		return
	end

	local var_2_0 = g.core.model.User.newSlgData
	local var_2_1 = g.core.model.User.newSlgData:getBossComponentById(arg_2_1)

	if self._sprite then
		self._sprite:removeFromParent()

		self._sprite = nil
	end

	self._sprite = display.newSprite("#" .. g.core.common.Path:getNewSlgMonster(var_2_1.res_1))

	self._sprite:setScale(var_2_1.scale / 10000)
	self._sprite:setAnchorPoint(0.5, 0.5)
	self._compPlace:addNode(self._sprite)

	self._bossCfg = var_2_0:getBossInfoById(arg_2_1)

	self._txtName:setText(self._bossCfg.name)
	self._lvTxt:setText(g.core.lang:get(429006, {
		level = self._bossCfg.level
	}))
	self._compArmyIcon:updateView({
		armyType = self._bossCfg.boss_army_type
	})
	self._valueTxt:setText(var_2_0:getBossTotalAuthority(arg_2_1))
end

function NewSlgBossViewComp:_onClickBtnView()
	if not self._bossCfg then
		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_PVC_DEFENDER_POP, {
		type = g.core.const.ConstMgr.NewSlgConst.MONSTER_TYPE.BOSS,
		id = self._bossCfg.id
	})
end

return NewSlgBossViewComp
