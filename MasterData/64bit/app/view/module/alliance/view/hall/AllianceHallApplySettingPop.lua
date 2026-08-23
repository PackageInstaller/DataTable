local var_0_0 = g.core.model.User.allianceData
local AllianceHallApplySettingPop = class("AllianceHallApplySettingPop", require("app.fairyGUI.alliance.UI_AllianceHallApplySettingPop"), function()
	return fgui.GComponent:create({
		resName = "AllianceHallApplySettingPop",
		pkgPath = "ui/alliance/alliance",
		pkgName = "alliance"
	})
end)

function AllianceHallApplySettingPop:ctor(arg_2_1)
	self:showAtCenter()

	self._needConfirm = false
	self._applyLevel = 1

	self:_initView()
	self.m_confirmBtn:addClickListener(handler(self, self._onClickConfirm))
end

function AllianceHallApplySettingPop:_initView()
	self._needConfirm, self._applyLevel = var_0_0:getAllianceApplySetting()

	self.m_changeLvComp:initMinMaxNum({
		max = 10,
		min = 1,
		cur = self._applyLevel
	})
	self.m_needConfirmController:setSelectedIndex(self._needConfirm and 1 or 0)
end

function AllianceHallApplySettingPop:_onClickConfirm()
	self._needConfirm = self.m_needConfirmController:getSelectedIndex() == 1
	self._applyLevel = self.m_changeLvComp:getCurNum()

	g.core.network.GameNetProxy:send_C2S_GuildAlliance_ModifySetting({
		confirm = self._needConfirm,
		apply_level = self._applyLevel
	})
	self:_onClickClose()
end

function AllianceHallApplySettingPop:_onClickClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return AllianceHallApplySettingPop
