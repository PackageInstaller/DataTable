local ActivityReturnPreviewCell = class("ActivityReturnPreviewCell", require("app.fairyGUI.activityReturn.UI_ActivityReturnPreviewCell"))

function ActivityReturnPreviewCell:ctor()
	self._itemData = nil

	self.m_iconList:setVirtual()
	self.m_iconList:setItemRenderer(handler(self, self._onIconItemRender))
end

function ActivityReturnPreviewCell:_onIconItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateItem(self._itemData[arg_2_1 + 1])
end

function ActivityReturnPreviewCell:updateItem(arg_3_1, arg_3_2, arg_3_3)
	local var_3_0, var_3_1 = self:_getTitleTxtByQuality(arg_3_2, arg_3_3)

	if var_3_1 then
		self.m_qualityIcon:setURL(var_3_1)
		self.m_title:setX(18 + self.m_qualityIcon:getWidth())
	else
		self.m_qualityIcon:setURL("")
		self.m_title:setX(25)
	end

	self.m_title:setText(var_3_0)

	if arg_3_2 ~= 2 then
		self._itemData = arg_3_1

		self.m_iconList:setNumItems(#arg_3_1)
		self.m_iconList:resizeToFit(#arg_3_1)
		self:setHeight(self.m_iconList:getSize().height + self.m_iconList:getY() + 4)
		self.m_typeController:setSelectedIndex(1)
	else
		local var_3_2 = ""

		for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
			var_3_2 = var_3_2 == "" and iter_3_1.name .. " X" .. iter_3_1.size or var_3_2 .. "、" .. iter_3_1.name .. " X" .. iter_3_1.size
		end

		self.m_itemNameTxt:setText(var_3_2)
		self:setHeight(self.m_itemNameTxt:getTextSize().height + self.m_itemNameTxt:getY() + 4)
		self.m_typeController:setSelectedIndex(0)
	end
end

function ActivityReturnPreviewCell:_getTitleTxtByQuality(arg_4_1, arg_4_2)
	local var_4_0 = self:_getIconByQuality(arg_4_1)

	if g.core.model.User.activityReturnData:getCurId() >= 7 and arg_4_1 == 4 then
		return g.core.lang:get(425007, {
			ratio = arg_4_2
		}), var_4_0
	else
		return g.core.lang:get(425005, {
			ratio = arg_4_2
		}), var_4_0
	end
end

function ActivityReturnPreviewCell:_getIconByQuality(arg_5_1)
	return "ui://text_new/pic_pinzhi_" .. arg_5_1
end

return ActivityReturnPreviewCell
