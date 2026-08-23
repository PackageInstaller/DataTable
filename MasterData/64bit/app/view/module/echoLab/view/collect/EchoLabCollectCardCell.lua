local EchoLabCollectCardCell = class("EchoLabCollectCardCell", require("app.fairyGUI.echoLab.UI_EchoLabCollectCardCell"))

function EchoLabCollectCardCell:ctor()
	self._isInitEff = false
	self._downEff = nil
	self._upEff = nil
	self._cardStruct = nil
end

function EchoLabCollectCardCell:updateView(arg_2_1, arg_2_2)
	self._cardStruct = arg_2_1

	self:_updateSelf()

	if arg_2_2 then
		self.m_isShowRightLineController:setSelectedIndex(1)
	else
		self.m_isShowRightLineController:setSelectedIndex(0)
	end
end

function EchoLabCollectCardCell:_updateSelf()
	self.m_knightComp:updateIcon(self._cardStruct:getPicResUrl(true), self._cardStruct:getCardType(), self._cardStruct:isActive())
	self.m_nameText:setText(self._cardStruct:getCardName())

	if self._cardStruct:isActive() then
		local var_3_0 = {
			cur = 0,
			target = 1
		}

		if self._cardStruct:getCardType() ~= g.core.common.Goods.TYPE_SKIN then
			var_3_0 = self._cardStruct:getUpgradeInfo()

			self.m_starComp:setVisible(true)
		else
			self.m_starComp:setVisible(false)
		end

		self.m_starComp:initStar({
			index = 3,
			style = 2,
			gap = 0,
			num = var_3_0.cur,
			max = var_3_0.target
		})
	end

	self.m_qualityLoader:setURL(g.core.common.Path:getGeneCollectCardQuality((self._cardStruct:getCardQuality(true))))
	self.m_knightComp:updateLockCtr(false)

	if not self._cardStruct:isActive() then
		local var_3_1 = self._cardStruct:getCardType()
		local var_3_2 = g.core.model.User.echoLabData:getCollectData():getBuildInfoByCardType(var_3_1):getDailyActiveInfo(var_3_1)

		if self._cardStruct:canActive() and var_3_2.activeCount < var_3_2.activeMaxCount then
			self:_setActiveEffect(true, true)
			self.m_stateController:setSelectedIndex(1)
		else
			self:_setActiveEffect(false, false)
			self.m_knightComp:updateLockCtr(true)
			self.m_stateController:setSelectedIndex(0)
		end
	elseif self._cardStruct:isMaxGrade() then
		self:_setActiveEffect(true, false)
		self.m_stateController:setSelectedIndex(4)
	elseif self._cardStruct:canUpgrade() then
		self:_onUpgradeEffect(true, true)
		self.m_stateController:setSelectedIndex(3)
	else
		self:_setActiveEffect(true, false)
		self.m_stateController:setSelectedIndex(2)
	end
end

function EchoLabCollectCardCell:_setActiveEffect(arg_4_1, arg_4_2)
	if arg_4_1 then
		self._downEff = self._downEff or self.m_effectDownNode:addEffectSpine({
			anim = "activationDown",
			name = "eff_ui_echoLabCollect_card",
			isLoop = true
		})

		self._downEff:setAnimation(0, "activationDown", true)
	end

	if arg_4_2 then
		self._upEff = self._upEff or self.m_effectUpNode:addEffectSpine({
			anim = "activationUp",
			name = "eff_ui_echoLabCollect_card",
			isLoop = true
		})

		self._upEff:setAnimation(0, "activationUp", true)
	end

	self.m_effectDownNode:setVisible(arg_4_1)
	self.m_effectUpNode:setVisible(arg_4_2)
end

function EchoLabCollectCardCell:_onUpgradeEffect(arg_5_1, arg_5_2)
	if arg_5_1 then
		self._downEff = self._downEff or self.m_effectDownNode:addEffectSpine({
			anim = "levelupDown",
			name = "eff_ui_echoLabCollect_card",
			isLoop = true
		})

		self._downEff:setAnimation(0, "levelupDown", true)
	end

	if arg_5_2 then
		self._upEff = self._upEff or self.m_effectUpNode:addEffectSpine({
			anim = "levelupUp",
			name = "eff_ui_echoLabCollect_card",
			isLoop = true
		})

		self._upEff:setAnimation(0, "levelupUp", true)
	end

	self.m_effectDownNode:setVisible(arg_5_1)
	self.m_effectUpNode:setVisible(arg_5_2)
end

function EchoLabCollectCardCell:onEnterEffect()
	self.m_effectNode:removeAllEffect()
	self.m_effectNode:addEffectSpine({
		remove = true,
		anim = "cell",
		name = "eff_ui_echoLabCollect_enter",
		isLoop = false
	})
end

return EchoLabCollectCardCell
