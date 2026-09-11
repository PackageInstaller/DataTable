local ShelfGoodsBubble = class("ShelfGoodsBubble", (require("game.views.simBusiness.bubble.EntityBubbleBase")))

function ShelfGoodsBubble:UIName()
	return "Widget/Version/SummerUI_3_5/SummerUI_3_5_SimBusinessUI/item/PropBubble"
end

function ShelfGoodsBubble:InitUI()
	self.goodsItem = SimBusinessGoodsItem.New(self.goodsItem_)
end

function ShelfGoodsBubble:SetData(arg_3_1, arg_3_2)
	self.focus = arg_3_1

	self:SetFollowEntity(arg_3_1, "gua_bubble")

	local var_3_0 = DormUtils.GetEntityData(arg_3_1)
	local var_3_1 = arg_3_2 or var_3_0.goods

	self.goodsItem:RefreshData(arg_3_2 or var_3_0.goods)
	self.goodsItem:RegisterClick(function()
		manager.notify:Invoke("ON_FURNITURE_CLICKED", arg_3_1)
	end)

	self.info_.text = SimBusinessTools.GetSellAbilityTextShort(var_3_0.cfgID, var_3_1)
end

function ShelfGoodsBubble:Refresh()
	local var_5_0 = DormUtils.GetEntityData(self.focus)

	self.info_.text = SimBusinessTools.GetSellAbilityTextShort(var_5_0.cfgID, var_5_0.goods)
end

function ShelfGoodsBubble:OnSetGoods(arg_6_1, arg_6_2)
	if arg_6_1 == self.focus then
		self:SetData(arg_6_1, arg_6_2)
	else
		self:Refresh()
	end
end

function ShelfGoodsBubble:RegisterEvents()
	self:RegistEventListener("SIM_BUSINESS_SET_GOODS", handler(self, self.OnSetGoods))
end

function ShelfGoodsBubble:Dispose()
	self.goodsItem:Dispose()
	ShelfGoodsBubble.super.Dispose(self)
end

return ShelfGoodsBubble
