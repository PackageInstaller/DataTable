local var_0_0 = g.core.common.Path
local var_0_1 = g.core.const.ConstMgr.AllianceConst
local var_0_2 = g.core.model.User.allianceData
local AllianceJoinSuccessPop = class("AllianceJoinSuccessPop", require("app.fairyGUI.alliance.UI_AllianceJoinSuccessPop"), function()
	return fgui.GComponent:create({
		resName = "AllianceJoinSuccessPop",
		pkgName = "alliance",
		pkgPath = "ui/alliance/alliance"
	}, ...)
end)

function AllianceJoinSuccessPop:ctor()
	self:initView()
	self:showAtCenter()
	var_0_2:savePopJoinAlliance()
	self.m_enterTransition:play()
end

function AllianceJoinSuccessPop:initView()
	self.m_flag:setURL(var_0_0:getAllianceFlag256(var_0_2:getAllianceFlag()))
	self.m_allianceName:setText(var_0_2:getAllianceName())
	self.m_isLeaderController:setSelectedIndex(var_0_2:getGradeByUid(g.core.model.User.guildData:getGuildData(), g.core.model.User:getId()) == var_0_1.GRADE.LEADER and 1 or 0)
end

function AllianceJoinSuccessPop:_onClickClose()
	if self._isOnClose then
		return
	end

	self._isOnClose = true

	self.m_backTransition:play(handler(self, self.onTranBack))
end

function AllianceJoinSuccessPop:onTranBack()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function AllianceJoinSuccessPop:onUnload()
	self:dispatchCompEvent("Success_pop_end")
end

return AllianceJoinSuccessPop
