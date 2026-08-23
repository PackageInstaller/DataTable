local var_0_0 = g.core.const.ConstMgr.TeamBattleConst
local TeamBattleShopItem = class("TeamBattleShopItem", require("app.fairyGUI.teamBattle.UI_TeamBattleShopItem"))

function TeamBattleShopItem:ctor()
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

function TeamBattleShopItem:_initBtn()
	self.m_costComp:setTitleNormalColor(2)
	self.m_qualityLoader:addClickListener(handler(self, self._onBuyItemClick))
end

function TeamBattleShopItem:updateShopItem(arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_1 or not arg_3_2 then
		return
	end

	self._shopType = arg_3_2
	self._pos = arg_3_3

	self:_updateKnightItem(arg_3_1)
end

function TeamBattleShopItem:_updateKnightItem(arg_4_1)
	self._itemId = arg_4_1.id
	self._sellNum = arg_4_1.num

	local var_4_0 = var_0_0.SHOP_ITEM_TYPE.KNIGHT
	local var_4_3 = g.core.config.knight_info.get(self._itemId)
	local var_4_4 = var_4_3.advance_id
	local var_4_5 = var_4_3.star

	self._name = var_4_3.name
	self._quality = var_4_3.quality
	self._iconPath = g.core.common.Path:getKnightPicRes(var_4_3.res_id)

	self.m_elementLoader:setURL(g.core.common.Path:getKnightElementIcon(var_4_3.classical))
	self.m_nameText:setText(self._name)

	if not self._isPlayEffect then
		self.m_itemPicComp:setIcon(self._iconPath)
	end

	self.m_qualityLoader:setURL((g.core.common.Path:getTeamBattleShopItemQuality(self._quality + 1)))
	self.m_starComp:initStar({
		type = 1,
		index = 3,
		gap = 0,
		style = 2,
		num = var_4_5
	})

	local var_4_6 = false

	if not arg_4_1.isBuy then
		self.m_isSoldOutController:setSelectedIndex(0)

		local var_4_7 = g.core.config.team_battle_shop_item_value_info.match(function(arg_5_0)
			if arg_5_0.item_type == var_4_0 and arg_5_0.item_quality == self._quality and arg_5_0.item_star == var_4_5 then
				return arg_5_0
			end
		end)

		self._costTVS = {
			type = g.core.common.Goods.TYPE_RESOURCE,
			value = g.core.common.Goods.RESOURCE.TYPE_TEAM_BATTLE_COMMON_RESOURCE,
			size = (#var_4_7 > 0 or nil) and (var_4_7[1].price or 0)
		}

		self.m_costComp:updateByTVS(self._costTVS)

		var_4_6 = self._formationData:isHigherStarByKnight(var_4_4, var_4_5)
	else
		self._sellNum = 0

		self.m_isSoldOutController:setSelectedIndex(1)
	end

	self.m_isBetterController:setSelectedIndex(var_4_6 and 1 or 0)
end

function TeamBattleShopItem:playFreshEffect()
	self._isPlayEffect = true

	self.m_switchTransition:play(handler(self, self.onFreshAnimEnd))
	self.m_qualityEffect:addEffectSpine({
		name = "eff_ui_explorationShop_itemNew",
		remove = true,
		isLoop = false,
		anim = "play_" .. self._quality + 1
	})
end

function TeamBattleShopItem:onFreshAnimEnd()
	self.m_itemPicComp:setIcon(self._iconPath)

	self._isPlayEffect = false
end

function TeamBattleShopItem:_onBuyItemClick()
	if self._sellNum <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(420669))

		return
	end

	local var_8_0, var_8_1 = g.core.model.User.teamBattleData:getMapData():isShopFull(self._shopType)

	if var_8_0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(var_8_1))

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

function TeamBattleShopItem:ensureBuyItem()
	if g.core.utils.Tools.isCountEnoughByTVS(self._costTVS, true) then
		self:dispatchCompEvent("TEAMBATTLE_SHOP_BUY_ITEM", {
			pos = self._pos
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(420674))
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_RESONATOR_SHOP_MONEY_DEFICIT)
	end
end

return TeamBattleShopItem
