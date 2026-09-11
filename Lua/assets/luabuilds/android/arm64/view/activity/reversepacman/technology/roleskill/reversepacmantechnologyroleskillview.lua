local ReversePacmanTechnologyRoleSkillView = class("ReversePacmanTechnologyRoleSkillView", import("view.base.BasePanel"))

ReversePacmanTechnologyRoleSkillView.BUY_SHOP_ITEM_SUCCESS = "ReversePacmanTechnologyRoleSkillView::BUY_SHOP_ITEM_SUCCESS"
ReversePacmanTechnologyRoleSkillView.REFRESH_ITEM_CNT = "ReversePacmanTechnologyRoleSkillView::REFRESH_ITEM_CNT"

function ReversePacmanTechnologyRoleSkillView:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	ReversePacmanTechnologyRoleSkillView.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()
	self:didEnter()

	return
end

function ReversePacmanTechnologyRoleSkillView:Init()
	self.itemList = {}

	for iter_2_0, iter_2_1 in ipairs(ReversePacmanTools.GetActivity():getConfig("config_client").technologyShopIDList) do
		self.itemList[iter_2_0] = self:GetItemClass().New(Object.Instantiate(self.uiSkillItem, self.uiSkillParent), self, iter_2_1)
	end

	setText(self.uiFrontText, i18n("reverse_pacman_owned"))
	setImageSprite(self.uiIconImage, GetSpriteFromAtlas(ReversePacmanTools.GetTechnologyPTDrop():getIcon(), ""))
	onButton(self, self.uiCurrencyBtn, function()
		local var_3_0 = ReversePacmanTools.GetTechnologyPTDrop()
		local var_3_1 = {
			viewComponent = ReversePacmanItemPopScene,
			mediator = ReversePacmanItemPopMediator
		}
		local var_3_2 = {
			dropType = var_3_0.type,
			dropID = var_3_0.id,
			count = var_3_0:getOwnedCount()
		}
		local var_3_3 = ReversePacmanTools.GetActivity():getConfig("config_client").pt_link

		var_3_3 = var_3_3 or 240
		var_3_2.limitItemGuideID = var_3_3
		var_3_1.data = var_3_2

		self:emit(BaseUI.ON_ADD_SUBLAYER, Context.New(var_3_1))

		return
	end, SFX_PANEL)

	return
end

function ReversePacmanTechnologyRoleSkillView:GetItemClass()
	return ReversePacmanTechnologyRoleSkillItem
end

function ReversePacmanTechnologyRoleSkillView:didEnter()
	self.eventIDList = {
		self:bind(ReversePacmanTechnologyRoleSkillView.BUY_SHOP_ITEM_SUCCESS, handler(self, self.OnBuyShopItemSuccess)),
		self:bind(ReversePacmanTechnologyRoleSkillView.REFRESH_ITEM_CNT, handler(self, self.RefreshCurrency))
	}

	self:RefreshCurrency()

	return
end

function ReversePacmanTechnologyRoleSkillView:RefreshCurrency()
	setText(self.uiPtCntText, i18n("reverse_pacman_count", (ReversePacmanTools.GetTechnologyPTDrop():getOwnedCount())))

	return
end

function ReversePacmanTechnologyRoleSkillView:OnBuyShopItemSuccess(arg_7_1, arg_7_2)
	for iter_7_0, iter_7_1 in ipairs(self.itemList) do
		iter_7_1:RefreshUI()
	end

	return
end

function ReversePacmanTechnologyRoleSkillView:willExit()
	for iter_8_0, iter_8_1 in ipairs(self.eventIDList) do
		self:disconnect(iter_8_1)
	end

	self.eventIDList = nil

	for iter_8_2, iter_8_3 in ipairs(self.itemList) do
		iter_8_3:willExit()
	end

	self.itemList = nil

	self:detach()

	return
end

return ReversePacmanTechnologyRoleSkillView
