local var_0_0 = g.core.model.User.allianceData
local var_0_1 = g.core.const.ConstMgr.AllianceConst
local var_0_2 = g.core.config.guild_alliance_right_info
local AllianceHallNoticeLabel = class("AllianceHallNoticeLabel", require("app.fairyGUI.alliance.UI_AllianceHallNoticeLabel"))

function AllianceHallNoticeLabel:ctor()
	self._noticeType = 0

	self.m_editBtn:addClickListener(handler(self, self._onClickEditBtn))
end

function AllianceHallNoticeLabel:updateNoticeLabel(arg_2_1, arg_2_2)
	self._noticeType = arg_2_1

	local var_2_0 = ""
	local var_2_1 = var_0_2.get(arg_2_2)

	if arg_2_1 == var_0_1.NOTICE_TYPE.DECLARE then
		self.m_canEditController:setSelectedIndex(var_2_1.declaration)

		var_2_0 = var_0_0:getAllianceDeclare()
	else
		self.m_canEditController:setSelectedIndex(var_2_1.announce)

		var_2_0 = var_0_0:getAllianceAnnounce()
	end

	self:setTitle(var_2_0, false, true)
end

function AllianceHallNoticeLabel:_onClickEditBtn()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.alliance.view.hall.AllianceHallNoticeEditPop").new(self._noticeType), {
		touchDisappear = true,
		ignoreTouch = false
	})
end

return AllianceHallNoticeLabel
