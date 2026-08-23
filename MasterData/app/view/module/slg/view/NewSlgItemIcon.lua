local NewSlgItemIcon = class("NewSlgItemIcon")

function NewSlgItemIcon:ctor()
	self._compStar = self:getChild("Comp_star")
	self._headLoader = self:getChild("headLoader")
	self._qualityLoader = self:getChild("qualityLoader")
	self._showItemBgCtrl = self:getController("show_item_bg")
	self._showStarCtrl = self:getController("showStar")
	self._elementLoader = self:getChild("elementLoader")
	self._character = nil
	self._ctrlType = {
		[g.core.common.Goods.TYPE_KNIGHT] = 1,
		[g.core.common.Goods.TYPE_UNITETOKEN] = 2,
		[g.core.common.Goods.TYPE_PET] = 3
	}
end

function NewSlgItemIcon:updateView(arg_2_1)
	self._showStarCtrl:setSelectedIndex(0)

	arg_2_1 = arg_2_1 or {}
	self._character = arg_2_1.character or {}

	if self._character.id and self._character.id ~= 0 then
		if self._character.tp then
			self._showItemBgCtrl:setSelectedIndex(self._ctrlType[self._character.tp])
		else
			self._showItemBgCtrl:setSelectedIndex(0)
		end
	elseif self._character.base_id and self._character.base_id ~= 0 then
		if self._character.tp then
			self._showItemBgCtrl:setSelectedIndex(self._ctrlType[self._character.tp])
		else
			self._showItemBgCtrl:setSelectedIndex(0)
		end
	else
		self._showStarCtrl:setSelectedIndex(0)
		self._showItemBgCtrl:setSelectedIndex(0)
	end

	local var_2_0, var_2_1 = g.core.utils.Tools.newSlgFunc.getIconPathByChapterOrStruct(self._character)

	self._headLoader:setURL(var_2_0)

	if var_2_1 then
		self._compStar:initStar({
			index = 3,
			style = 1,
			gap = -8,
			num = var_2_1.star
		})
		self._showStarCtrl:setSelectedIndex(var_2_1.star > 0 and 1 or 0)
		self._qualityLoader:setURL("ui://base_new/bg_xd_pinzhi" .. var_2_1.quality + 1 .. "_2")
		self:setElement(var_2_1.classical)
	else
		self:setElement()
	end
end

function NewSlgItemIcon:setElement(arg_3_1)
	if not arg_3_1 or arg_3_1 == 0 then
		self._elementLoader:setVisible(false)
	else
		self._elementLoader:setURL(g.core.common.Path:getKnightElementIcon(arg_3_1))
		self._elementLoader:setVisible(true)
	end
end

return NewSlgItemIcon
