local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User
local var_0_2 = g.core.common.Goods
local SkinBuyConfirmPop = class("SkinBuyConfirmPop", require("app.fairyGUI.recharge.UI_SkinBuyConfirmPop"), function()
	return fgui.GComponent:create({
		pkgName = "recharge",
		resName = "SkinBuyConfirmPop",
		pkgPath = "ui/recharge/recharge"
	})
end)

function SkinBuyConfirmPop:ctor(arg_2_1)
	self:showAtCenter()

	self._skinGoods = arg_2_1
	self._isOwn = var_0_1.skinData:getSkinState(self._skinGoods.skin_id) == 1

	self.m_confirmBtn:addClickListener(handler(self, self._onBuy))
	self:_updateView()
end

function SkinBuyConfirmPop:_updateView()
	self.m_nameTxt:setText(self._skinGoods.name)
	self.m_baseItem:setURL(var_0_0:getKnightIconById(self._skinGoods.icon))
	self.m_nameBg:setURL(var_0_0:getBaseBuyPopNameBg(self._skinGoods.skinInfo.quality or 0))
	self.m_itemBg:setURL(var_0_0:getBaseBuyPopItemBg(self._skinGoods.skinInfo.quality))
	self.m_descTxt:setText(self._skinGoods.skinInfo.description)
	self.m_costText:setText(self._skinGoods.price)
	self.m_costLoader:setURL((g.core.common.Path:getIconByTypeValue(var_0_2.TYPE_RESOURCE, var_0_2.RESOURCE.TYPE_SKIN_FRAG, true)))
end

function SkinBuyConfirmPop:_onBuy()
	if not self._isOwn then
		local var_4_0 = var_0_1.bagData:getOwnNum(var_0_2.TYPE_RESOURCE, var_0_2.RESOURCE.TYPE_SKIN_FRAG)

		if var_4_0 < self._skinGoods.price then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = var_0_2.TYPE_RESOURCE,
				value = var_0_2.RESOURCE.TYPE_SKIN_FRAG,
				size = var_4_0
			})
		else
			g.core.network.GameNetProxy:send_C2S_Shop_SkinShopping({
				id = self._skinGoods.id
			})

			if not self._hasPop then
				self._hasPop = true

				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			end
		end
	end
end

return SkinBuyConfirmPop
