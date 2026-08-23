local CultivateConst = require("app.view.module.cultivate.const.CultivateConst")
local var_0_1 = g.core.common.Path
local CultivatePassCardCellBtn = class("CultivatePassCardCellBtn", require("app.fairyGUI.cultivate.UI_CultivatePassCardCellBtn"))

function CultivatePassCardCellBtn:updatePassCardBtn(arg_1_1, arg_1_2, arg_1_3)
	self._actData = g.core.model.User.cultivateDataMgr:getCultivateData(arg_1_1)

	if not self._actData:isWitchActivity() then
		self.m_activeLoader:setURL(var_0_1:getCultivateImage("btn_zl_little1", g.core.model.User.cultivateDataMgr:getResDirId(arg_1_1)))
	else
		self.m_activeLoader:setURL(var_0_1:getCultivateImage("btn_mnzj_zl_little1", g.core.model.User.cultivateDataMgr:getResDirId(arg_1_1)))
	end

	self.m_lockLoader:setURL(var_0_1:getCultivateImage("btn_zl_little3", g.core.model.User.cultivateDataMgr:getResDirId(arg_1_1)))
	self.m_unactiveLoader:setURL(var_0_1:getCultivateImage("btn_zl_little2", g.core.model.User.cultivateDataMgr:getResDirId(arg_1_1)))

	if arg_1_2 == CultivateConst.PASS_CARE_PAY_STATE.ACTIVE then
		self.m_stateController:setSelectedIndex(1)
		self:setTitle(arg_1_3)
	elseif arg_1_2 == CultivateConst.PASS_CARE_PAY_STATE.UN_ACTIVE then
		self.m_stateController:setSelectedIndex(0)
		self:setTitle(g.core.lang:get(421406))
	elseif arg_1_2 == CultivateConst.PASS_CARE_PAY_STATE.ALL_BUY then
		self.m_stateController:setSelectedIndex(2)
		self:setTitle(g.core.lang:get(421405))
	end
end

function CultivatePassCardCellBtn:setState(arg_2_1)
	self.m_stateController:setSelectedIndex(arg_2_1)
end

return CultivatePassCardCellBtn
