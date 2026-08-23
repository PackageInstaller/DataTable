local NewSlgKnightIcon = class("NewSlgKnightIcon")

function NewSlgKnightIcon:ctor()
	self._comIcon = self:getChild("Comp_icon")
	self._compStar = self:getChild("Comp_star")

	self._compStar:setVisible(false)

	self._showItemBgCtrl = self:getController("show_item_bg")
	self._character = nil
	self._ctrlType = {
		[g.core.common.Goods.TYPE_KNIGHT] = 1,
		[g.core.common.Goods.TYPE_UNITETOKEN] = 2,
		[g.core.common.Goods.TYPE_PET] = 3
	}
end

function NewSlgKnightIcon:updateView(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._character = arg_2_1.character or {}

	self._comIcon:setEmpty()
	self._compStar:setVisible(false)

	if self._character.base_id and self._character.base_id ~= 0 then
		self._showItemBgCtrl:setSelectedIndex(0)

		local var_2_0 = g.core.common.Goods.CFG[self._character.tp].get(self._character.base_id)

		self._comIcon:updateIcon({
			type = self._character.tp,
			value = var_2_0.id
		})
		self._compStar:updateStar({
			star = var_2_0.star,
			quality = var_2_0.quality
		})
	elseif self._character.id and self._character.id ~= 0 then
		self._showItemBgCtrl:setSelectedIndex(0)

		local var_2_1 = g.core.common.GlobalFunc.getStructByTypeAndSerId(self._character.tp, self._character.id)

		if var_2_1 and var_2_1:isOwn() then
			local var_2_2 = var_2_1:getCfg()

			self._comIcon:updateIcon({
				type = self._character.tp,
				value = var_2_2.id
			})
			self._compStar:updateStar({
				star = var_2_2.star,
				quality = var_2_2.quality
			})
		end
	elseif self._character.tp then
		self._showItemBgCtrl:setSelectedIndex(self._ctrlType[self._character.tp])
	else
		self._showItemBgCtrl:setSelectedIndex(0)
	end
end

return NewSlgKnightIcon
