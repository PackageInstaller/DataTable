local var_0_0 = g.core.model.User.allianceData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum
local var_0_4 = g.core.network.GameNetProxy
local AllianceHallApplyPop = class("AllianceHallApplyPop", require("app.fairyGUI.alliance.UI_AllianceHallApplyPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/alliance/alliance",
		resName = "AllianceHallApplyPop",
		pkgName = "alliance"
	})
end)

function AllianceHallApplyPop:ctor()
	self:showAtCenter()

	self._applyList = {}

	self.m_applyList:setVirtual(self)
	self.m_applyList:setItemRenderer(handler(self, self._onRenderApplyList))
	self.m_applySettingBtn:addClickListener(handler(self, self._onClickApplySettingBtn))
end

function AllianceHallApplyPop:_updateView()
	self.m_applySettingBtn:setVisible(g.core.config.guild_alliance_right_info.get((var_0_0:getGradeByUid(g.core.model.User.guildData:getGuildData(), g.core.model.User:getId()))).amend == 1)
	self:_updateApplySetting()
end

function AllianceHallApplyPop:onLoad()
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_GUILD_ALLIANCE_APPLYLIST, self._onS2CGetApplyList, self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_GUILD_ALLIANCE_APPROVEAPPLY, self._onS2CApproveApply, self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_GUILD_ALLIANCE_MODIFYSETTING, self._onS2CModifySetting, self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, self._onS2CGuildSnapShot, self)
	var_0_4:send_C2S_GuildAlliance_ApplyList({})
	self:_updateView()
	self:_onS2CGetApplyList()
end

function AllianceHallApplyPop:_onRenderApplyList(arg_5_1, arg_5_2)
	arg_5_2:updateInviteCell(self._applyList[arg_5_1 + 1])
	arg_5_2:setCtrlState("isShowBg", {
		index = arg_5_1 % 2
	})
end

function AllianceHallApplyPop:_onClickClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function AllianceHallApplyPop:receiveCompEvent(arg_7_1)
	if arg_7_1 == "ALLIANCE_HALL_APPLY_EXPIRE" then
		var_0_4:send_C2S_GuildAlliance_ApplyList({})
	end
end

function AllianceHallApplyPop:_onClickApplySettingBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.alliance.view.hall.AllianceHallApplySettingPop").new()))
end

function AllianceHallApplyPop:_updateApplySetting()
	local var_9_0, var_9_1 = var_0_0:getAllianceApplySetting()

	self.m_minLevel:setText(var_9_1)
	self.m_confirmState:setText(g.core.lang:get(var_9_0 and 109504 or 109505))
end

function AllianceHallApplyPop:_onS2CGetApplyList()
	self._applyList = var_0_0:getAllianceApplyList()

	self.m_applyList:setNumItems(#self._applyList)
	self.m_isEmptyController:setSelectedIndex(#self._applyList > 0 and 0 or 1)
end

function AllianceHallApplyPop:_onS2CApproveApply(arg_11_1, arg_11_2, arg_11_3)
	var_0_4:send_C2S_GuildAlliance_ApplyList({})
end

function AllianceHallApplyPop:_onS2CModifySetting()
	g.core.module.ModuleManager:tip(g.core.lang:get(100529))
	self:_updateApplySetting()
end

function AllianceHallApplyPop:_onS2CGuildSnapShot()
	self._applyList = var_0_0:getAllianceApplyList()

	self.m_applyList:setNumItems(#self._applyList)
end

return AllianceHallApplyPop
