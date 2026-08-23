local BattleSettingPop = class("BattleSettingPop", require("app.fairyGUI.battle.UI_BattleSettingPop"), function()
	return fgui.GComponent:create({
		resName = "BattleSettingPop",
		pkgPath = "ui/battle/battle",
		pkgName = "battle"
	})
end)

function BattleSettingPop:ctor()
	self:showAtCenter()

	self._syncInfo = false

	self.m_btnFirstSkipCG:addClickListener(handler(self, self._onSkipCGBtnClicked))
	self.m_btnSkipCG:addClickListener(handler(self, self._onSkipCGBtnClicked))
	self.m_btnCG:addClickListener(handler(self, self._onSkipCGBtnClicked))
	self.m_btnFirstSkipTween:addClickListener(handler(self, self._onSkipTweenBtnClicked))
	self.m_btnSkipTween:addClickListener(handler(self, self._onSkipTweenBtnClicked))
	self.m_btnTween:addClickListener(handler(self, self._onSkipTweenBtnClicked))
end

function BattleSettingPop:onLoad()
	self:_onSynchronizeAndSetUI()
end

function BattleSettingPop:_onSynchronizeAndSetUI()
	if self._syncInfo then
		return
	end

	local var_4_0 = g.core.common.Setting:getValue(g.core.common.Setting.SKIP_CG) or 0

	self._skipCGIdx = var_4_0

	if var_4_0 == 0 then
		self:_onSkipCGBtnSelected(self.m_btnFirstSkipCG)
	elseif var_4_0 == 1 then
		self:_onSkipCGBtnSelected(self.m_btnSkipCG)
	elseif var_4_0 == 2 then
		self:_onSkipCGBtnSelected(self.m_btnCG)
	end

	local var_4_1 = g.core.common.Setting:getValue(g.core.common.Setting.SKIP_TWEEN) or 0

	self._skipTweenIdx = var_4_1

	if var_4_1 == 0 then
		self:_onSkipTweenBtnSelected(self.m_btnFirstSkipTween)
	elseif var_4_1 == 1 then
		self:_onSkipTweenBtnSelected(self.m_btnSkipTween)
	elseif var_4_1 == 2 then
		self:_onSkipTweenBtnSelected(self.m_btnTween)
	end

	self._syncInfo = true
end

function BattleSettingPop:_onSkipCGBtnClicked(arg_5_1)
	local var_5_0 = arg_5_1:getSender()

	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.JUMP_CG) then
		local var_5_1 = var_5_0:getName()
		local var_5_2 = 0

		if var_5_1 == "btnFirstSkipCG" then
			var_5_2 = 0
		elseif var_5_1 == "btnSkipCG" then
			var_5_2 = 1
		elseif var_5_1 == "btnCG" then
			var_5_2 = 2
		end

		if self._skipCGIdx ~= var_5_2 then
			var_5_0:setSelected(false)
		end

		return
	end

	self:_onSkipCGBtnSelected(var_5_0)
end

function BattleSettingPop:_onSkipCGBtnSelected(arg_6_1)
	local var_6_0 = arg_6_1:getName()

	if self._lastCGBtn then
		self._lastCGBtn:setSelected(false)
	end

	local var_6_1 = 0

	if var_6_0 == "btnFirstSkipCG" then
		var_6_1 = 0
	elseif var_6_0 == "btnSkipCG" then
		var_6_1 = 1
	elseif var_6_0 == "btnCG" then
		var_6_1 = 2
	end

	arg_6_1:setSelected(true)

	self._lastCGBtn = arg_6_1

	if self._skipCGIdx ~= var_6_1 and self._syncInfo then
		g.core.common.Setting:set(g.core.common.Setting.SKIP_CG, var_6_1)
		g.core.module.ModuleManager:tip(g.core.lang:get(100529))

		self._skipCGIdx = var_6_1
	end
end

function BattleSettingPop:_onSkipTweenBtnClicked(arg_7_1)
	local var_7_0 = arg_7_1:getSender()

	if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.JUMP_SKILL_ENTRANCE) then
		local var_7_1 = var_7_0:getName()
		local var_7_2 = 0

		if var_7_1 == "btnFirstSkipTween" then
			var_7_2 = 0
		elseif var_7_1 == "btnSkipTween" then
			var_7_2 = 1
		elseif var_7_1 == "btnTween" then
			var_7_2 = 2
		end

		if self._skipTweenIdx ~= var_7_2 then
			var_7_0:setSelected(false)
		end

		return
	end

	self:_onSkipTweenBtnSelected(var_7_0)
end

function BattleSettingPop:_onSkipTweenBtnSelected(arg_8_1)
	local var_8_0 = arg_8_1:getName()

	if self._lastTweenBtn then
		self._lastTweenBtn:setSelected(false)
	end

	local var_8_1 = 0

	if var_8_0 == "btnFirstSkipTween" then
		var_8_1 = 0
	elseif var_8_0 == "btnSkipTween" then
		var_8_1 = 1
	elseif var_8_0 == "btnTween" then
		var_8_1 = 2
	end

	arg_8_1:setSelected(true)

	self._lastTweenBtn = arg_8_1

	if self._skipTweenIdx ~= var_8_1 and self._syncInfo then
		g.core.common.Setting:set(g.core.common.Setting.SKIP_TWEEN, var_8_1)
		g.core.module.ModuleManager:tip(g.core.lang:get(100529))

		self._skipTweenIdx = var_8_1
	end
end

function BattleSettingPop:onUnload()
	g.core.layer.LayerManager:getFloatLayer():setFloatCompVisible("battleAssistantIcon", true)
end

return BattleSettingPop
