local var_0_0 = g.core.common.Path
local var_0_1 = g.core.config.gve_regis_info
local GveApplyPreviewComp = class("GveApplyPreviewComp", require("app.fairyGUI.gve.UI_GveApplyPreviewComp"))

function GveApplyPreviewComp:updatePreview(arg_1_1)
	local var_1_0 = var_0_1.get(arg_1_1 or 1)

	self:setTitle(var_1_0.title)
	self.m_descTxt:setTitle(var_1_0.des)
	self.m_picLoader:setURL(var_0_0:getGveApplyPreviewPic(var_1_0.pic))
end

return GveApplyPreviewComp
