local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_1 = g.core.common.ServerTime
local RedCliffConst = require("app.view.module.redCliff.const.RedCliffConst")
local RedCliffRoleVirtual = require("app.view.module.redCliff.stage.entity.RedCliffRoleVirtual")
local RedCliffMapKnightComp = class("RedCliffMapKnightComp", require("app.fairyGUI.redCliff.UI_RedCliffMapKnightComp"))

function RedCliffMapKnightComp:ctor()
	self._knightVisual = nil
	self._resId = 0
	self._callback = nil
	self._isWin = nil
	self._playerStruct = nil
	self._cdType = RedCliffConst.COUNT_DOWN_TYPE.NONE
	self._cdEndTime = 0
	self._lastTickTime = 0
	self._occupyEffectUP = nil
	self._occupyEffectDown = nil
	self._protectEffect = nil

	self.m_hpProg:setMax(100)

	self._oldTime = 0
end

function RedCliffMapKnightComp:initMapRole(arg_2_1)
	self._playerStruct = arg_2_1

	local var_2_0 = arg_2_1:getUser()

	self:_createKnightSpine(self:_getResId(var_2_0), true)
	self.m_fightText:setText(g.core.lang:get(421030, {
		num = var_2_0.fight_value
	}))
	self.m_nameText:setText(var_2_0.name)
	self:_updateCountDownState()
	self:updateHpView()
end

function RedCliffMapKnightComp:updateMapRole()
	self:updateHpView()
	self:_updateCountDownState()
	self:updateMapRoleCountDown()
end

function RedCliffMapKnightComp:updateEditorRole(arg_4_1)
	self._playerStruct = arg_4_1

	local var_4_0 = arg_4_1:getUser()

	self:_createKnightSpine((self:_getResId(var_4_0)))
	self.m_fightText:setText(g.core.lang:get(421030, {
		num = var_4_0.fight_value
	}))
	self.m_nameText:setText(var_4_0.name)
	self:_updateCountDownState()
	self:_updateReduceHp()

	if arg_4_1:isOccupy() then
		self.m_heartComp:playReduceHpAnim()
	else
		self.m_heartComp:stopReduceHpAnim()
	end
end

function RedCliffMapKnightComp:playAttackAnimation(arg_5_1, arg_5_2)
	self._isWin = arg_5_1
	self._callback = arg_5_2

	self._knightVisual:addSpineEventListener(handler(self, self._attackFinish))
	self._knightVisual:playInnerAction(BattleConst.SPINE_ACTION_TYPE.ATTACK, false)
end

function RedCliffMapKnightComp:_attackFinish(arg_6_1)
	if arg_6_1.animation == BattleConst.SPINE_ACTION_TYPE.ATTACK and arg_6_1.type == BattleConst.SPINE_EVENT.COMPLETE then
		if self._isWin then
			self._knightVisual:addSpineEventListener(nil)
			self._knightVisual:playInnerAction(BattleConst.SPINE_ACTION_TYPE.IDLE, true)

			if self._callback then
				self._callback()

				self._callback = nil
			end
		elseif self._isWin == false then
			self._knightVisual:addSpineEventListener(handler(self, self._deadFinish))
			self._knightVisual:playInnerAction(BattleConst.SPINE_ACTION_TYPE.DEAD, false)
		end
	end
end

function RedCliffMapKnightComp:_deadFinish(arg_7_1)
	if arg_7_1.animation == BattleConst.SPINE_ACTION_TYPE.DEAD and arg_7_1.type == BattleConst.SPINE_EVENT.COMPLETE then
		self._knightVisual:addSpineEventListener(nil)
		self._knightVisual:playInnerAction(BattleConst.SPINE_ACTION_TYPE.IDLE, true)

		if self._callback then
			self._callback()

			self._callback = nil
		end
	end
end

function RedCliffMapKnightComp:_getResId(arg_8_1)
	if arg_8_1.skin and arg_8_1.skin > 0 then
		local var_8_0 = g.core.config.skin_info.fetch(arg_8_1.skin)

		if var_8_0 then
			local var_8_1 = g.core.config.knight_base_info.fetch(var_8_0.res)

			if var_8_1 then
				return var_8_1.fight_id
			end
		end
	end

	return g.core.config.knight_info.get(arg_8_1.base_id).res_id
end

function RedCliffMapKnightComp:_createKnightSpine(arg_9_1)
	if self._knightVisual then
		self._knightVisual:updateRole(arg_9_1, true)
	else
		self._knightVisual = RedCliffRoleVirtual.new(arg_9_1, true)

		self.m_knightNode:addNode(self._knightVisual)
	end

	self._resId = arg_9_1
end

function RedCliffMapKnightComp:_updateCountDownState()
	if not self._playerStruct then
		return
	end

	local var_10_0 = self._playerStruct:isSelf()

	self.m_isSelfController:setSelectedIndex(var_10_0 and 1 or 0)

	local var_10_1 = self._playerStruct:isOccupy()
	local var_10_2 = self._playerStruct:isCool()
	local var_10_3 = self._playerStruct:getCoolEndTime()
	local var_10_4 = self._playerStruct:isProtect()
	local var_10_5 = self._playerStruct:getProtectEndTime()

	self:updateProtectEffect(var_10_4 and var_10_1)
	self.m_cdTypeController:setSelectedIndex(RedCliffConst.COUNT_DOWN_TYPE.NONE)

	if var_10_0 then
		if self._playerStruct:isDead() then
			self._cdType = RedCliffConst.COUNT_DOWN_TYPE.DEAD

			self.m_cdTypeController:setSelectedIndex(self._cdType)

			self._cdEndTime = self._playerStruct:getDeadEndTime()
		elseif var_10_1 then
			if var_10_4 then
				self._cdType = RedCliffConst.COUNT_DOWN_TYPE.PROTECT

				self.m_cdTypeController:setSelectedIndex(self._cdType)

				self._cdEndTime = var_10_5
			elseif var_10_2 then
				self.m_cdTypeController:setSelectedIndex(self._cdType)

				self._cdEndTime = var_10_3
			end
		elseif var_10_2 then
			self._cdType = RedCliffConst.COUNT_DOWN_TYPE.COOL

			self.m_cdTypeController:setSelectedIndex(self._cdType)

			self._cdEndTime = var_10_3
		end
	elseif var_10_4 then
		self._cdType = RedCliffConst.COUNT_DOWN_TYPE.PROTECT

		self.m_cdTypeController:setSelectedIndex(self._cdType)

		self._cdEndTime = var_10_5
	end
end

function RedCliffMapKnightComp:updateCountDown()
	local var_11_0 = self._cdEndTime - var_0_1:getTime()

	if var_11_0 > 0 then
		local var_11_1 = ""

		if self._cdType == RedCliffConst.COUNT_DOWN_TYPE.PROTECT then
			if var_11_0 <= 1.5 then
				self.m_protectOutTransition:play()
			end

			var_11_1 = g.core.lang:get(421027, {
				time = var_11_0
			})
		elseif self._cdType == RedCliffConst.COUNT_DOWN_TYPE.COOL then
			var_11_1 = g.core.lang:get(421028, {
				time = var_11_0
			})
		elseif self._cdType == RedCliffConst.COUNT_DOWN_TYPE.DEAD then
			var_11_1 = g.core.lang:get(421029, {
				time = var_11_0
			})
		end

		self.m_cdTxt:setText(var_11_1)
	else
		self._cdType = RedCliffConst.COUNT_DOWN_TYPE.NONE
		self._cdEndTime = 0

		self:_updateCountDownState()
	end
end

function RedCliffMapKnightComp:updateMapRoleCountDown()
	if self._cdType == RedCliffConst.COUNT_DOWN_TYPE.PROTECT or self._cdType == RedCliffConst.COUNT_DOWN_TYPE.NONE then
		return
	end

	local var_12_0 = self._cdEndTime - var_0_1:getTime()

	if var_12_0 > 0 then
		local var_12_1 = ""

		if self._cdType == RedCliffConst.COUNT_DOWN_TYPE.COOL then
			var_12_1 = g.core.lang:get(421028, {
				time = var_12_0
			})
		elseif self._cdType == RedCliffConst.COUNT_DOWN_TYPE.DEAD then
			var_12_1 = g.core.lang:get(421029, {
				time = var_12_0
			})
		end

		self.m_cdTxt:setText(var_12_1)
	else
		self._cdType = RedCliffConst.COUNT_DOWN_TYPE.NONE
		self._cdEndTime = 0

		self:_updateCountDownState()
	end
end

function RedCliffMapKnightComp:_updateReduceHp()
	if not self._playerStruct then
		return
	end

	self:updateHpView()
end

function RedCliffMapKnightComp:updateHpView()
	if not self._playerStruct then
		return
	end

	local var_14_0 = var_0_1:getTime()

	if var_14_0 > self._lastTickTime then
		self._lastTickTime = var_14_0

		self._playerStruct:reduceHp()

		local var_14_1 = self._playerStruct:getRestHp()

		self.m_heartComp:updateHeartComp(var_14_1)
		self.m_hpProg:setValue(var_14_1)
	end
end

function RedCliffMapKnightComp:playOccupyEffect()
	if not self._occupyEffectDown then
		self._occupyEffectDown = self.m_occupyEffectDown:addEffectSpine({
			anim = "playDown",
			name = "eff_ui_redCliff_renew",
			isLoop = false
		})
	else
		self._occupyEffectDown:setAnimation(0, "playDown", false)
	end

	if not self._occupyEffectUP then
		self._occupyEffectUp = self.m_occupyEffectUp:addEffectSpine({
			anim = "playUp",
			name = "eff_ui_redCliff_renew",
			isLoop = false
		})
	else
		self._occupyEffectUp:setAnimation(0, "playUp", false)
	end

	self.m_protectEffect:setVisible(false)
	self:newScheduleOnce(handler(self, self._delayPlayProtectEff), 1)
end

function RedCliffMapKnightComp:_delayPlayProtectEff()
	self:updateProtectEffect(true)
end

function RedCliffMapKnightComp:updateProtectEffect(arg_17_1)
	self.m_protectEffect:setVisible(arg_17_1)

	if arg_17_1 then
		self.m_protectInTransition:play()

		self._protectEffect = self._protectEffect or self.m_protectEffect:addEffectSpine({
			anim = "play",
			name = "eff_ui_redCliff_shield",
			isLoop = true
		})
	end
end

function RedCliffMapKnightComp:playInnerAction(arg_18_1)
	if not self._knightVisual then
		return
	end

	self._knightVisual:playInnerAction(arg_18_1)
end

function RedCliffMapKnightComp:setInnerDir(arg_19_1)
	if not self._knightVisual then
		return
	end

	self._knightVisual:setInnerDir(arg_19_1)
end

return RedCliffMapKnightComp
