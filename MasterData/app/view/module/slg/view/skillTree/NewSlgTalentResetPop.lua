local NewSlgTalentResetPop = class("NewSlgTalentResetPop", require("app.fairyGUI.newSlg.UI_NewSlgTalentResetPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgTalentResetPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	})
end)

function NewSlgTalentResetPop:ctor(arg_2_1)
	self:showAtCenter()

	self._skillData = arg_2_1.skillData
	self._resetTalentDict = arg_2_1.talentDict

	self.m_isAllController:setSelectedIndex(arg_2_1.isAll and 1 or 0)
	self:initView()
end

function NewSlgTalentResetPop:initView()
	self.m_cancelBtn:addClickListener(handler(self, self._onClickCancelBtn))
	self.m_confirmBtn:addClickListener(handler(self, self._onClickConfirmBtn))

	local var_3_0 = 0
	local var_3_1

	for iter_3_0, iter_3_1 in pairs(self._resetTalentDict) do
		var_3_1 = var_3_1 or {
			type = iter_3_1:getInfo().activate_type_1,
			value = iter_3_1:getInfo().activate_value_1
		}
		var_3_0 = var_3_0 + iter_3_1:getInfo().activate_size_1
	end

	self.m_resTip:setText(g.core.lang:get(429757, {
		name = g.core.common.Goods:convert(var_3_1).name,
		num = var_3_0
	}))
end

function NewSlgTalentResetPop:_onClickCancelBtn()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewSlgTalentResetPop:_onClickConfirmBtn()
	g.core.network.GameNetProxy:send_C2S_NewSlg_TechnologyReset({})
end

function NewSlgTalentResetPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_TECHNOLOGYRESET, handler(self, self._onResetTalent), self)
end

function NewSlgTalentResetPop:_onResetTalent()
	g.core.module.ModuleManager:tip(g.core.lang:get(429758))
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return NewSlgTalentResetPop
