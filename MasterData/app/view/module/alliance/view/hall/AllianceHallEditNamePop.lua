local var_0_0 = g.core.model.User.allianceData
local var_0_1 = g.core.const.ConstMgr.AllianceConst
local var_0_2 = g.core.utils.String
local var_0_3 = g.core.common.Goods
local var_0_4 = g.core.model.User.bagData
local var_0_5 = g.core.module.ModuleManager
local AllianceHallEditNamePop = class("AllianceHallEditNamePop", require("app.fairyGUI.alliance.UI_AllianceHallEditNamePop"), function()
	return fgui.GComponent:create({
		resName = "AllianceHallEditNamePop",
		pkgPath = "ui/alliance/alliance",
		pkgName = "alliance"
	})
end)

function AllianceHallEditNamePop:ctor()
	self:showAtCenter()

	self._maxWords = var_0_0:getParams(var_0_1.PARAMETER.NAME_LEN)
	self._minWords = var_0_0:getParams(var_0_1.PARAMETER.NAME_LEN_LOWER)
	self._cost = var_0_0:getParams(var_0_1.PARAMETER.CHANGE_NAME_COST)

	self.m_costResComp:updateByTVS({
		value = 0,
		type = var_0_3.TYPE_GOLD,
		size = self._cost
	})
	self.m_btnConfirm:addClickListener(handler(self, self._onClickConfirmBtn))
	self.m_btnCancel:addClickListener(handler(self, self._onClickCancelBtn))
end

function AllianceHallEditNamePop:_onClickConfirmBtn()
	local var_3_0 = self.m_nameInput:getText()

	if not self:_isNameValid(var_3_0) then
		return
	end

	if var_0_4:getOwnNum(var_0_3.TYPE_GOLD, 0) < self._cost then
		var_0_5:tip(g.core.lang:get(109522))

		return
	end

	var_0_5:onlyPopSelfByDisplay(self)
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_ModifyContent({
		tp = var_0_1.MODIFY_CONTENT_TYPE.NAME,
		content = var_3_0
	})
end

function AllianceHallEditNamePop:_isNameValid(arg_4_1)
	if g.core.utils.Black:isMatchText(arg_4_1) then
		g.core.module.ModuleManager:tip(g.core.lang:get(100201))

		return false
	end

	local var_4_0 = var_0_2.getCharactersNum(arg_4_1, 2)

	if var_4_0 < self._minWords then
		var_0_5:tip(g.core.lang:get(428600))

		return false
	end

	if var_4_0 > self._maxWords then
		var_0_5:tip(g.core.lang:get(428554))

		return false
	end

	return true
end

function AllianceHallEditNamePop:_onClickCancelBtn()
	var_0_5:onlyPopSelfByDisplay(self)
end

return AllianceHallEditNamePop
