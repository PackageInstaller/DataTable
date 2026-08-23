local CommonKnight = require("app.view.common.CommonKnight")
local var_0_1 = 0.72
local RebelMonsterComp = class("RebelMonsterComp", require("app.fairyGUI.rebel.UI_RebelMonsterComp"))

function RebelMonsterComp:ctor(arg_1_1)
	self._refRebelElem = nil
	self._isOpen = false
	self._bossResID = nil
	self._bossAvatar = nil

	self:_initRebelMonster()
end

function RebelMonsterComp:refreshRebelMonster(arg_2_1)
	self._refRebelElem = arg_2_1

	local var_2_0 = arg_2_1:getBaseInfo()

	self.m_nameTxt:setText(var_2_0.name)
	self.m_levelTxt:setText(arg_2_1:getRebelPkg().level)
	self.m_descTxt:setText(g.core.lang:get(303502 + var_2_0.available_time))
	self.m_tipTxt:setText(g.core.lang:get(303520 + var_2_0.feature_type, {
		num = var_2_0.feature_value
	}))

	local var_2_1 = arg_2_1:isInValidTime()

	self._isOpen = var_2_1

	self.m_openController:setSelectedIndex(var_2_1 and 1 or 0)
	self:_buildBossView(var_2_0.res)

	if self._isOpen then
		self._bossAvatar:getKnightSpine():resume()
	else
		self._bossAvatar:getKnightSpine():pause()
	end

	local var_2_2, var_2_3 = arg_2_1:getHP()

	self.m_hpPerTxt:setText(math.ceil(100 * var_2_2 / var_2_3) .. "%")
	self.m_hpProg:setValue(math.ceil(100 * var_2_2 / var_2_3 * var_0_1))

	local var_2_4 = g.core.common.ServerTime:getLeftSeconds((arg_2_1:getEndTime()))

	if var_2_4 > 0 then
		self.m_coolComp:resetCooldownTs(var_2_4, handler(self, self._monsterToLife))
		self.m_isdeadController:setSelectedIndex(1)
	else
		self.m_isdeadController:setSelectedIndex(0)
	end

	if self._isOpen then
		local var_2_5

		if var_2_0.res == 300210 then
			var_2_5 = "jhhy_shan"

			self.m_effectPlaceHolder:setPosition(cc.p(150, -150 - (display.height - 750) * 0.1))
		elseif var_2_0.res == 300250 then
			var_2_5 = "jhhy_hai"

			self.m_effectPlaceHolder:setPosition(cc.p(150, 250))
		end

		if var_2_5 then
			self.m_effectPlaceHolder:addEffectSpineAsync({
				scale = 1,
				isLoop = true,
				name = var_2_5
			})
		end
	else
		self.m_effectPlaceHolder:removeChildren()
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp
	})
end

function RebelMonsterComp:_initRebelMonster()
	self:addClickListener(handler(self, self._onOpenFightClick))
end

function RebelMonsterComp:_buildBossView(arg_4_1)
	if self._bossResID == arg_4_1 then
		return
	end

	if self._bossResID ~= nil then
		self.m_holdComp:removeChildren()
	end

	self._bossResID = arg_4_1

	local var_4_0 = CommonKnight.new({
		resId = self._bossResID,
		scale = self._refRebelElem:getRebelScale(true)
	})

	self.m_holdComp:addChild(var_4_0)

	self._bossAvatar = var_4_0
end

function RebelMonsterComp:_monsterToLife()
	self.m_isdeadController:setSelectedIndex(0)
end

function RebelMonsterComp:_onOpenFightClick()
	if self._isOpen then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.rebel.view.RebelAttackPop").new(self._refRebelElem), {
			withoutAni = true
		})
	else
		g.core.module.ModuleManager:tip((g.core.lang:get(303502 + self._refRebelElem:getBaseInfo().available_time)))
	end
end

return RebelMonsterComp
