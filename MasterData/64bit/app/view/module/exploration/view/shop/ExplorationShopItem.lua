local var_0_0 = g.core.const.ConstMgr.ExplorationConst
local ExplorationShopItem = class("ExplorationShopItem", require("app.fairyGUI.exploration.UI_ExplorationShopItem"))

function ExplorationShopItem:ctor()
	self._itemId = 0
	self._sellNum = 0
	self._shopType = 0
	self._name = ""
	self._quality = 1
	self._iconPath = ""
	self._costTVS = {}
	self._isPlayEffect = false
	self._formationData = g.core.model.User.explorationData:getFormationData()

	self:_initBtn()
end

function ExplorationShopItem:_initBtn()
	self.m_costComp:setTitleNormalColor(2)
	self.m_buyLoader:addClickListener(handler(self, self._onBuyItemClick))
end

function ExplorationShopItem:updateShopItem(arg_3_1, arg_3_2)
	if not arg_3_1 or not arg_3_2 then
		return
	end

	self._itemId = arg_3_1.id
	self._sellNum = arg_3_1.num
	self._shopType = arg_3_2

	local var_3_0 = var_0_0.SHOP_ITEM_TYPE.KNIGHT
	local var_3_1 = 0
	local var_3_2 = 0

	if arg_3_2 == var_0_0.EVENT_TYPE.KNIGHT_SHOP then
		local var_3_3 = g.core.config.knight_info.get(self._itemId)

		var_3_2 = var_3_3.advance_id
		var_3_1 = var_3_3.star
		self._name = var_3_3.name
		self._quality = var_3_3.quality
		self._iconPath = g.core.common.Path:getKnightPicRes(var_3_3.res_id)

		self.m_elementLoader:setURL(g.core.common.Path:getKnightElementIcon(var_3_3.classical))
	end

	self.m_nameText:setText(self._name)

	if not self._isPlayEffect then
		self.m_itemPicComp:setIcon(self._iconPath)
	end

	local var_3_4, var_3_5 = g.core.common.Path:getExplorationShopItemQuality(self._quality)

	self.m_bgLoader:setURL(var_3_4)
	self.m_kuangLoader:setURL(var_3_5)

	for iter_3_0 = 1, 7 do
		self["m_starLoader" .. iter_3_0]:setURL(iter_3_0 <= var_3_1 and "ui://base_new/pic_star_1" or "ui://base_new/pic_star_2")
	end

	local var_3_6 = false

	if self._sellNum > 0 then
		self.m_isSoldOutController:setSelectedIndex(0)

		local var_3_7 = g.core.config.exploration_shop_item_value_info.match(function(arg_4_0)
			if arg_4_0.item_type == var_3_0 and arg_4_0.item_quality == self._quality and arg_4_0.item_star == var_3_1 then
				return arg_4_0
			end
		end)

		self._costTVS = {
			type = g.core.common.Goods.TYPE_RESOURCE,
			value = g.core.common.Goods.RESOURCE.TYPE_EXPLORATION_COMMON_RESOURCE,
			size = (#var_3_7 > 0 or nil) and (var_3_7[1].price or 0)
		}

		self.m_costComp:updateByTVS(self._costTVS)

		var_3_6 = self._formationData:isHigherStarByKnight(var_3_2, var_3_1)
	else
		self.m_isSoldOutController:setSelectedIndex(1)
	end

	if var_3_6 and not self._betterSpine then
		self._betterSpine = self.m_betterEffect:addEffectSpine({
			isLoop = true,
			name = "eff_ui_explorationShop_itemBetter",
			anim = "play"
		})
	end

	if self._betterSpine then
		self._betterSpine:setVisible(var_3_6)
	end
end

function ExplorationShopItem:playFreshEffect()
	self._isPlayEffect = true

	self.m_switchTransition:play(handler(self, self.onFreshAnimEnd))
	self.m_qualityEffect:addEffectSpine({
		isLoop = false,
		name = "eff_ui_explorationShop_itemNew",
		remove = true,
		anim = "play_" .. self._quality + 1
	})
end

function ExplorationShopItem:onFreshAnimEnd()
	self.m_itemPicComp:setIcon(self._iconPath)

	self._isPlayEffect = false
end

function ExplorationShopItem:_onBuyItemClick()
	if self._sellNum <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(420669))

		return
	end

	local var_7_0, var_7_1 = g.core.model.User.explorationData:getMapData():isShopFull(self._shopType)

	if var_7_0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(var_7_1))

		return
	end

	if self._itemId > 0 then
		g.core.module.ModuleManager:pushModule(g.view.entrance.CONFIRM_POP, {
			title = g.core.lang:get(107043),
			desc = g.core.lang:get(107044, {
				num = self._costTVS.size,
				name = self._name,
				costName = g.core.common.Goods:convert(self._costTVS).name
			}),
			onConfirm = handler(self, self.ensureBuyItem)
		})
	end
end

function ExplorationShopItem:ensureBuyItem()
	if g.core.utils.Tools.isCountEnoughByTVS(self._costTVS, true) then
		self:dispatchCompEvent("Exploration_buy_shop_item", {
			itemId = self._itemId
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(420674))
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RESONATOR_SHOP_MONEY_DEFICIT)
	end
end

return ExplorationShopItem
