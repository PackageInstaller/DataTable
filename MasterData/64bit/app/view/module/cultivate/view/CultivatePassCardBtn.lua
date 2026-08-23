local var_0_0 = g.core.model.User.cultivateDataMgr
local CultivatePassCardBtn = class("CultivatePassCardBtn", require("app.fairyGUI.cultivate.UI_CultivatePassCardBtn"))

function CultivatePassCardBtn:ctor()
	self._actId = 0

	self:addClickListener(handler(self, self._onSelfClick))
end

function CultivatePassCardBtn:updatePassCardActiveBtn(arg_2_1)
	self._actId = arg_2_1
	self._actData = var_0_0:getCultivateData(arg_2_1)

	local var_2_0 = self._actData:getPassCardData():isCanActivePassCard()

	if not self._actData:isWitchActivity() then
		if var_2_0 then
			self.m_lockIcon:setVisible(false)
			self.m_bgLoader:setURL(g.core.common.Path:getCultivateImage("btn_zl_1", var_0_0:getResDirId(arg_2_1)))
		else
			self.m_lockIcon:setVisible(true)
			self.m_bgLoader:setURL(g.core.common.Path:getCultivateImage("btn_zl_2", var_0_0:getResDirId(arg_2_1)))
		end
	elseif var_2_0 then
		self.m_lockIcon:setVisible(false)
		self.m_bgLoader:setURL(g.core.common.Path:getCultivateImage("btn_mnzj_jl_1", var_0_0:getResDirId(arg_2_1)))
	else
		self.m_lockIcon:setVisible(true)
		self.m_bgLoader:setURL(g.core.common.Path:getCultivateImage("btn_mnzj_jl_2", var_0_0:getResDirId(arg_2_1)))
	end
end

function CultivatePassCardBtn:_onSelfClick()
	if self._actId == 0 then
		return
	end

	if var_0_0:getCultivateData(self._actId):getPassCardData():isCanActivePassCard() then
		if not self._actData:isWitchActivity() then
			g.core.module.ModuleManager:replaceModule(g.view.entrance.CULTIVATE_PASSCARD, self._actId)
		else
			g.core.module.ModuleManager:replaceModule(g.view.entrance.CULTIVATE_WITCH_PASSCARD, self._actId)
		end
	else
		g.core.module.ModuleManager:tip(g.core.config.cultivate_activity_display_info.get(self._actId).gain_des)
	end
end

return CultivatePassCardBtn
