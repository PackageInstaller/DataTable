local var_0_0 = g.core.config.dead_tower_card_info
local var_0_1 = g.core.const.ConstMgr.WushTowerConst
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.const.ConstMgr.SoundConst
local WushTowerChooseCard = class("WushTowerChooseCard", require("app.fairyGUI.wushTower.UI_WushTowerChooseCard"))

function WushTowerChooseCard:ctor()
	self._cardId = nil

	self.m_lookBtn:addClickListener(handler(self, self._onClickLookCardBtn))
end

function WushTowerChooseCard:updateChooseCard(arg_2_1, arg_2_2)
	if arg_2_1 then
		if not self._cardId then
			self._cardId = arg_2_1.id

			local var_2_0 = var_0_0.get(self._cardId)

			if var_2_0 then
				self.m_isUpController:setSelectedIndex(1)
				self:setIcon(var_0_2:getWushCardIconById(var_2_0.icon))
				self.m_cardNameTxt:setText(var_2_0.name)

				local var_2_1 = false

				for iter_2_0 = 1, var_0_1.RECOMMEND_NUM do
					if arg_2_2["recommend_" .. iter_2_0] > 0 and arg_2_2["recommend_" .. iter_2_0] == self._cardId then
						var_2_1 = true
					end
				end

				self.m_isRecommendController:setSelectedIndex(var_2_1 and 1 or 0)
				self.m_enterTransition:play()
				self.m_effCard:removeAllEffect()
				self.m_effCard:addEffectSpine({
					anim = "play",
					name = "eff_ui_wushTower_card",
					isLoop = false
				})
				g.core.sound.SoundManager:playSound(var_0_3.Sound.UI_EVENT_SY_CARDON)
			end
		end
	else
		self.m_isUpController:setSelectedIndex(0)
	end
end

function WushTowerChooseCard:isSelectCard()
	return checkbool(self._cardId)
end

function WushTowerChooseCard:setUnSelectCard()
	self._cardId = nil

	self.m_backTransition:play()
	self.m_isUpController:setSelectedIndex(0)
	self.m_effCard:removeAllEffect()
	self.m_effCard:addEffectSpine({
		anim = "play2",
		name = "eff_ui_wushTower_card",
		isLoop = false
	})
	g.core.sound.SoundManager:playSound(var_0_3.Sound.UI_EVENT_SY_CARDON)
end

function WushTowerChooseCard:getCardId()
	return self._cardId
end

function WushTowerChooseCard:_onClickLookCardBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.wushTower.view.WushTowerCardDetailsPop").new({
		cardId = self._cardId
	})))
end

return WushTowerChooseCard
