local var_0_0 = g.core.model.User.cultivateDataMgr
local CultivateOneKeyBtn = class("CultivateOneKeyBtn", require("app.fairyGUI.cultivate.UI_CultivateOneKeyBtn"))

function CultivateOneKeyBtn:updateOneKeyBtn(arg_1_1)
	self._actData = var_0_0:getCultivateData(arg_1_1)

	if not self._actData:isWitchActivity() then
		self.m_bgIcon:setURL(g.core.common.Path:getCultivateImage("btn_zl_middle1", var_0_0:getResDirId(arg_1_1)))
	else
		self.m_bgIcon:setURL(g.core.common.Path:getCultivateImage("btn_mnzj_zl_middle1", var_0_0:getResDirId(arg_1_1)))
	end
end

return CultivateOneKeyBtn
