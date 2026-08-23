local var_0_0 = g.core.common.Goods
local KnightSoulSellCell = class("KnightSoulSellCell", require("app.fairyGUI.knightSoul.UI_KnightSoulSellCell"))

function KnightSoulSellCell:ctor()
	self.getSharedTrans(self, "listIconUiScaleIn", "ItemBagList", self)
	self.m_sellArea:addClickListener(handler(self, self._onClickCellBtn))
end

function KnightSoulSellCell:updateCell(arg_2_1)
	self._itemData = arg_2_1

	self.m_iconComp:updateIcon(self._itemData)
	self.m_nameTxt:setText(self._itemData.info.name)

	self._sellParam = {
		type = self._itemData.type,
		value = self._itemData.info.id,
		size = self._itemData.size
	}
	self._costItem = {
		type = self._itemData.info.sale_type,
		value = self._itemData.info.sale_value,
		size = self._itemData.info.sale_size
	}

	local var_2_0 = var_0_0:convert(self._costItem)

	if var_2_0 then
		self.m_costLoader:setURL(var_2_0.icon_mini)
		self.m_costNum:setText(self._itemData.info.sale_size)
	end
end

function KnightSoulSellCell:_onClickCellBtn()
	self._sellItems = {
		costItem = self._costItem,
		award = self._sellParam
	}

	self:addPopup((require("app.view.module.knightSoul.view.KnightSoulSelectSellPop").new(self._sellItems)))
end

return KnightSoulSellCell
