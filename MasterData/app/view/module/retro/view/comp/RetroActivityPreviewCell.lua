local var_0_0 = g.core.model.User.retroData
local RetroActivityPreviewCell = class("RetroActivityPreviewCell", require("app.fairyGUI.retro.UI_RetroActivityPreviewCell"))

function RetroActivityPreviewCell:ctor()
	self._itemData = nil

	self.m_iconList:setVirtual()
	self.m_iconList:setItemRenderer(handler(self, self._onIconItemRender))
end

function RetroActivityPreviewCell:_onIconItemRender(arg_2_1, arg_2_2)
	arg_2_2:updatePreviewIcon(self._itemData[arg_2_1 + 1])
end

function RetroActivityPreviewCell:updateCell(arg_3_1)
	local var_3_0 = var_0_0:getBoxCfgByQuality(arg_3_1[1].quality)

	self.m_title:setText(var_3_0.name)
	self.m_ratioTxt:setText(var_3_0.weight_show / 100 .. "%")
	self.m_boxLoader:setURL("ui://retro/icon_box" .. var_3_0.quality .. "_2")

	self._itemData = arg_3_1

	self.m_iconList:setNumItems(#self._itemData)
	self.m_iconList:resizeToFit(#self._itemData)
	self:setHeight(self.m_iconList:getSize().height + self.m_iconList:getY() + 4)
end

return RetroActivityPreviewCell
