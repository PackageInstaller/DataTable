local TeamBattleShopBuffItem = class("TeamBattleShopBuffItem", require("app.fairyGUI.teamBattle.UI_TeamBattleShopBuffItem"))

function TeamBattleShopBuffItem:ctor()
	self.getSharedTrans(self, "enter_scaleIn", "CommonCardCellList", self)

	self._itemId = 0
	self._sellNum = 0
	self._shopType = 0
	self._pos = 0
	self._name = ""
	self._quality = 1
	self._iconPath = ""
	self._costTVS = {}
	self._isPlayEffect = false
	self._formationData = g.core.model.User.teamBattleData:getFormationData()

	self:_initBtn()
end

function TeamBattleShopBuffItem:_initBtn()
	self.m_costComp:setTitleNormalColor(2)
	self.m_buffCard:addClickListener(handler(self, self._onBuyItemClick))
end

function TeamBattleShopBuffItem:updateShopItem(arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_1 or not arg_3_2 then
		return
	end

	self._pos = arg_3_3

	self:_updateBuffItem(arg_3_1)
end

function TeamBattleShopBuffItem:_updateBuffItem(arg_4_1)
	self.m_buffCard:updateCardInfo(arg_4_1.id, true)

	self._name = self.m_buffCard:getNameTxt()

	if arg_4_1.isBuy then
		self.m_isBuyController:setSelectedIndex(1)
	else
		local var_4_0 = g.core.config.team_battle_buff_shop_info.match(function(arg_5_0)
			if arg_5_0.id == arg_4_1.id then
				return arg_5_0
			end
		end)

		self._costTVS = {
			type = g.core.common.Goods.TYPE_RESOURCE,
			value = g.core.common.Goods.RESOURCE.TYPE_TEAM_BATTLE_COMMON_RESOURCE,
			size = (#var_4_0 > 0 or nil) and (var_4_0[1].value or 0)
		}

		self.m_costComp:updateByTVS(self._costTVS)
		self.m_isBuyController:setSelectedIndex(0)
	end

	self._params = arg_4_1
end

function TeamBattleShopBuffItem:playFreshEffect()
	self._isPlayEffect = true

	self.m_switchTransition:play(handler(self, self.onFreshAnimEnd))
	self.m_qualityEffect:addEffectSpine({
		isLoop = false,
		name = "eff_ui_explorationShop_itemNew",
		remove = true,
		anim = "play_" .. self._quality + 1
	})
end

function TeamBattleShopBuffItem:onFreshAnimEnd()
	self.m_itemPicComp:setIcon(self._iconPath)

	self._isPlayEffect = false
end

function TeamBattleShopBuffItem:_onBuyItemClick()
	local var_8_0, var_8_1

	if self.m_isBuyController:getSelectedIndex() == 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(420669))

		do return end

		var_8_0 = {
			title = g.core.lang:get(107043)
		}
		var_8_1 = {
			num = self._costTVS.size,
			name = self._name
		}
	end

	var_8_1.costName = g.core.common.Goods:convert(self._costTVS).name
	var_8_0.desc = g.core.lang:get(107044, var_8_1)
	var_8_0.onConfirm = handler(self, self.ensureBuyItem)

	g.core.module.ModuleManager:pushModule(g.view.entrance.CONFIRM_POP, var_8_0)
end

function TeamBattleShopBuffItem:ensureBuyItem()
	if g.core.utils.Tools.isCountEnoughByTVS(self._costTVS, true) then
		self:dispatchCompEvent("TEAMBATTLE_SHOP_BUY_ITEM", {
			pos = self._pos
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(420674))
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RESONATOR_SHOP_MONEY_DEFICIT)
	end
end

return TeamBattleShopBuffItem
