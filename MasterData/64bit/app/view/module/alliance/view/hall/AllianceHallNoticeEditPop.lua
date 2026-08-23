local var_0_0 = g.core.const.ConstMgr.AllianceConst
local var_0_1 = g.core.model.User.allianceData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum
local var_0_4 = g.core.module.ModuleManager
local var_0_5 = g.core.common.ServerTime
local AllianceHallNoticeEditPop = class("AllianceHallNoticeEditPop", require("app.fairyGUI.alliance.UI_AllianceHallNoticeEditPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/alliance/alliance",
		resName = "AllianceHallNoticeEditPop",
		pkgName = "alliance"
	})
end)

function AllianceHallNoticeEditPop:ctor(arg_2_1)
	self:showAtCenter()

	self._noticeType = arg_2_1

	local var_2_0, var_2_1

	if arg_2_1 == var_0_0.NOTICE_TYPE.DECLARE then
		var_2_0 = var_0_0.PARAMETER.DECLARE_MAX_WORDS or var_0_0.PARAMETER.ANNOUNCE_MAX_WORDS

		if arg_2_1 == var_0_0.NOTICE_TYPE.DECLARE then
			var_2_1 = var_0_1:getParams(var_0_0.PARAMETER.DECLARE_CD) or var_0_1:getParams(var_0_0.PARAMETER.ANNOUNCE_CD)
		end
	end

	self._cdTime = var_2_1
	self._maxWords = var_0_1:getParams(var_2_0)

	self.m_popPanel:setTitleName(g.core.lang:get(arg_2_1 == var_0_0.NOTICE_TYPE.DECLARE and 428558 or 428559))
	self.m_noticeTypeController:setSelectedIndex(arg_2_1)
	self.m_editComp:updateView(self._maxWords)
	self.m_confirmBtn:addClickListener(handler(self, self._onClickConfirmBtn))
end

function AllianceHallNoticeEditPop:onLoad()
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_GUILD_ALLIANCE_MODIFYCONTENT, self._onS2CModifyContent, self)
end

function AllianceHallNoticeEditPop:_onS2CModifyContent(arg_4_1, arg_4_2, arg_4_3)
	var_0_1:setNoticeSetTime(self._noticeType, (var_0_5:getTime()))

	if arg_4_3.tp == var_0_0.MODIFY_CONTENT_TYPE.DECLARE then
		g.core.module.ModuleManager:tip(g.core.lang:get(428592))
		var_0_4:onlyPopSelfByDisplay(self)
	elseif arg_4_3.tp == var_0_0.MODIFY_CONTENT_TYPE.ANNOUNCE then
		self.m_editComp:updateView(self._maxWords)
		g.core.module.ModuleManager:tip(g.core.lang:get(428591))
	end
end

function AllianceHallNoticeEditPop:_onClickConfirmBtn()
	if var_0_5:getTime() - var_0_1:getNoticeSetTime(self._noticeType) <= self._cdTime then
		if self._noticeType == var_0_0.NOTICE_TYPE.ANNOUNCE then
			var_0_4:tip(g.core.lang:get(428598))
		else
			var_0_4:tip(g.core.lang:get(428599))
		end

		return
	end

	local var_5_0, var_5_1 = self.m_editComp:getNoticeText()

	if g.core.utils.Black:isMatchText(var_5_0) then
		g.core.module.ModuleManager:tip(g.core.lang:get(100201))

		return false
	end

	if var_5_1 == var_0_0.INPUT_TEXT_STATE.VALID then
		if self._noticeType == var_0_0.NOTICE_TYPE.ANNOUNCE then
			g.core.network.GameNetProxy:send_C2S_GuildAlliance_ModifyContent({
				tp = var_0_0.MODIFY_CONTENT_TYPE.ANNOUNCE,
				content = var_5_0
			})
		else
			g.core.network.GameNetProxy:send_C2S_GuildAlliance_ModifyContent({
				tp = var_0_0.MODIFY_CONTENT_TYPE.DECLARE,
				content = var_5_0
			})
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(var_5_1 == var_0_0.INPUT_TEXT_STATE.EMPTY and 109542 or 428554))
	end
end

return AllianceHallNoticeEditPop
