local ReversePacmanTechnologyRoleSkillItem = class("ReversePacmanTechnologyRoleSkillItem", import("view.base.BasePanel"))

function ReversePacmanTechnologyRoleSkillItem:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._go = arg_1_1.gameObject

	ReversePacmanTechnologyRoleSkillItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2
	self.id = arg_1_3

	self:attach(arg_1_2)
	self:Init()
	self:didEnter()

	return
end

function ReversePacmanTechnologyRoleSkillItem:Init()
	onButton(self, self.uiBuyBtn, function()
		self:emit(ReversePacmanTechnologyMediator.BUY_SHOP_ITEM, {
			activityID = pg.activity_shop_template[self.id].activity,
			shopID = self.id
		})

		return
	end, SFX_PANEL)
	onButton(self, self.uiIconBtn, function()
		self:emit(BaseUI.ON_DROP, (Drop.New({
			type = pg.activity_shop_template[self.id].commodity_type,
			id = pg.activity_shop_template[self.id].commodity_id
		})))

		return
	end, SFX_PANEL)
	setText(self.uiBuyText, i18n("reverse_pacman_buy"))
	setText(self.uiBuyText2, i18n("reverse_pacman_buy"))
	setText(self.uiSoldOutText, i18n("reverse_pacman_sold_out"))

	return
end

function ReversePacmanTechnologyRoleSkillItem:didEnter()
	self:RefreshUI()

	return
end

function ReversePacmanTechnologyRoleSkillItem:RefreshUI()
	local var_6_0 = Drop.New({
		type = pg.activity_shop_template[self.id].commodity_type,
		id = pg.activity_shop_template[self.id].commodity_id
	})

	setText(self.uiNameText, var_6_0:getConfig("name") .. string.format("(%s/%s)", getProxy(ShopsProxy):getActivityShopById(ReversePacmanTools.GetActivity():getConfig("config_client").shopActivityID).goods[self.id]:getBuyCount(), pg.activity_shop_template[self.id].num_limit))
	setText(self.uiDescText, var_6_0:getConfig("display"))
	setImageSprite(self.uiIconImage, (GetSpriteFromAtlas(var_6_0:getIcon(), "")))

	local var_6_1 = Drop.New({
		type = pg.activity_shop_template[self.id].resource_category,
		id = pg.activity_shop_template[self.id].resource_type
	})

	setText(self.uiCurrencyCntText, pg.activity_shop_template[self.id].resource_num)

	if not getProxy(ShopsProxy):getActivityShopById(pg.activity_shop_template[self.id].activity):getGoodsById(self.id):CheckCntLimit() then
		setTextColor(self.uiCurrencyCntText, Color.NewHex("#313131"))
		setActive(self.uiSoldOutGo, true)
		setActive(self.uiGreyGo, false)
		setActive(self.uiBuyGo, false)
	elseif var_6_1:getOwnedCount() < pg.activity_shop_template[self.id].resource_num then
		setTextColor(self.uiCurrencyCntText, Color.NewHex("#d45e5e"))
		setActive(self.uiSoldOutGo, false)
		setActive(self.uiGreyGo, true)
		setActive(self.uiBuyGo, false)
	else
		setTextColor(self.uiCurrencyCntText, Color.NewHex("#313131"))
		setActive(self.uiSoldOutGo, false)
		setActive(self.uiGreyGo, false)
		setActive(self.uiBuyGo, true)
	end

	setImageSprite(self.uiCurrencyImage, GetSpriteFromAtlas(var_6_1:getIcon(), ""))

	return
end

function ReversePacmanTechnologyRoleSkillItem:willExit()
	self:detach()
	Object.Destroy(self._go)

	self._go = nil
	self._tf = nil

	return
end

return ReversePacmanTechnologyRoleSkillItem
