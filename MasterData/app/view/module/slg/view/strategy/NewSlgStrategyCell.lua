local NewSlgStrategyCell = class("NewSlgStrategyCell", require("app.fairyGUI.newSlg.UI_NewSlgStrategyCell"))

function NewSlgStrategyCell:ctor()
	self._data = nil

	self.m_useBtn:addClickListener(handler(self, self._onUseBtnClicked))
	self.m_touchMask:addClickListener(self._onClickedTouchMask)
end

function NewSlgStrategyCell:updateStrategyCell(arg_2_1)
	self._data = arg_2_1

	self:setIcon(g.core.common.Path:getNewSlgStrategyIcon(arg_2_1.cfg.res))
	self.m_nameText:setText(arg_2_1.cfg.name)
	self.m_desTxt:setText((g.core.lang:getByString(arg_2_1.cfg.des, {
		num = (arg_2_1.cfg.type ~= 5 or nil) and math.floor(arg_2_1.cfg.value / 10)
	})))

	if arg_2_1.canChose then
		self.m_canChoseController:setSelectedIndex(1)
	else
		self.m_canChoseController:setSelectedIndex(0)
	end

	self.m_effNode:removeAllEffect()

	if arg_2_1.isUsing then
		self.m_useController:setSelectedIndex(1)

		if not arg_2_1.forceHideUseBtn then
			self:_playUsingEffect()
			self.m_usingGroup:setVisible(true)
		else
			self.m_usingGroup:setVisible(false)
		end
	else
		self.m_useController:setSelectedIndex(0)
	end
end

function NewSlgStrategyCell:_playUsingEffect()
	self.m_effNode:addEffectSpine({
		anim = "loop",
		name = "eff_ui_newSlg_strategylight",
		isLoop = true
	})
end

function NewSlgStrategyCell:playChoseEffect()
	self.m_effNode:addEffectSpine({
		remove = true,
		name = "eff_ui_newSlg_strategylight",
		isLoop = false
	})
end

function NewSlgStrategyCell:_onUseBtnClicked()
	self:dispatchCompEvent("doUseStrategy", {
		id = self._data.cfg.id
	})
end

function NewSlgStrategyCell:_onClickedTouchMask()
	local var_6_0 = g.core.const.ConstMgr.AllianceConst
	local var_6_1 = g.core.model.User.allianceData:getMyGrade()

	if not (var_6_1 == g.core.const.ConstMgr.AllianceConst.GRADE.LEADER or var_6_1 == var_6_0.GRADE.VICE_LEADER) then
		g.core.module.ModuleManager:tip(g.core.lang:get(429804))
	end
end

return NewSlgStrategyCell
