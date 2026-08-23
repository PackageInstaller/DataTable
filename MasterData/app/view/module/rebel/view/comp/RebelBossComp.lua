local CommonKnight = require("app.view.common.CommonKnight")
local var_0_1 = 0.72
local RebelBossComp = class("RebelBossComp", require("app.fairyGUI.rebel.UI_RebelBossComp"))

function RebelBossComp:ctor(arg_1_1)
	self._refRebelElem = nil
	self._isMine = false
	self._bossResID = nil
	self._bossAvatar = nil

	self:_initRebelBoss()
end

function RebelBossComp:refreshRebelBoss(arg_2_1)
	self._refRebelElem = arg_2_1

	local var_2_0 = arg_2_1:getBaseInfo()

	self.m_nameTxt:setText(var_2_0.name)
	self.m_levelTxt:setText(arg_2_1:getRebelPkg().level)

	self._isMine = arg_2_1:isMySelf()

	self.m_mineController:setSelectedIndex(self._isMine and 1 or 0)
	self:_buildBossView(var_2_0.res)

	local var_2_1, var_2_2 = arg_2_1:getHP()

	self.m_hpPerTxt:setText(math.ceil(100 * var_2_1 / var_2_2) .. "%")
	self.m_hpProg:setValue(math.ceil(100 * var_2_1 / var_2_2 * var_0_1))
	self.m_coolComp:resetCooldownTs(g.core.common.ServerTime:getLeftSeconds((arg_2_1:getEndTime())), handler(self, self._onCDEnd))
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
end

function RebelBossComp:_onCDEnd()
	self:setVisible(false)
end

function RebelBossComp:_initRebelBoss()
	self:addClickListener(handler(self, self._onOpenFightClick))
end

function RebelBossComp:_buildBossView(arg_5_1)
	if self._bossResID == arg_5_1 then
		return
	end

	if self._bossResID ~= nil then
		self.m_holdComp:removeChildren()
	end

	self._bossResID = arg_5_1

	local var_5_0 = CommonKnight.new({
		resId = self._bossResID,
		scale = self._refRebelElem:getRebelScale(true)
	})

	self.m_holdComp:addChild(var_5_0)

	self._bossAvatar = var_5_0
end

function RebelBossComp:_onOpenFightClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.rebel.view.RebelAttackPop").new(self._refRebelElem), {
		withoutAni = true
	})
end

return RebelBossComp
