local BattleShmcDamageComp = class("BattleShmcDamageComp", require("app.fairyGUI.battle.UI_BattleShmcDamageComp"))

function BattleShmcDamageComp:ctor()
	self._lastMaxDamage = 0
	self._isShowedEff = false
	self._curDamage = 0

	local var_1_0 = cc.Label:createWithBMFont("font/baoji.fnt", "0")

	self._pureNumberLabel = var_1_0

	var_1_0:setAnchorPoint(cc.p(0, 0.35))
	var_1_0:setAdditionalKerning(-10)
	var_1_0:setBMFontSize(32)
	self.m_damageHolder:addNode(var_1_0)
	self.m_numChangeTransition:setHook("change", handler(self, self._changeNum))
end

function BattleShmcDamageComp:setLastMaxDamage(arg_2_1)
	self._lastMaxDamage = arg_2_1
end

function BattleShmcDamageComp:_changeNew(arg_3_1)
	if arg_3_1.eventData and arg_3_1.eventData.name == "showNew" then
		self.m_isNewController:setSelectedIndex(1)
	end
end

function BattleShmcDamageComp:_changeNum()
	self._pureNumberLabel:setString(g.core.utils.Number.transTextNumFormation(self._curDamage))
end

function BattleShmcDamageComp:updateCurDamage(arg_5_1)
	if arg_5_1 == self._curDamage then
		return
	end

	if arg_5_1 > self._lastMaxDamage then
		if not self._isShowedEff then
			self._isShowedEff = true

			self.m_newEffect:addEffectSpine({
				remove = true,
				name = "eff_ui_spire_newlight",
				isLoop = false,
				eventHandler = handler(self, self._changeNew)
			})
		end
	else
		self.m_isNewController:setSelectedIndex(0)
	end

	self._curDamage = arg_5_1

	self.m_numChangeTransition:play()
end

return BattleShmcDamageComp
