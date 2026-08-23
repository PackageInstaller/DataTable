local var_0_0 = g.core.config.gve_guild_icon_info
local var_0_1 = g.core.model.User.gveDataMgr
local GvePioneerTeamEditInfoPop = class("GvePioneerTeamEditInfoPop", require("app.fairyGUI.gve.UI_GvePioneerTeamEditInfoPop"), function()
	return fgui.GComponent:create({
		resName = "GvePioneerTeamEditInfoPop",
		pkgPath = "ui/gve/gve",
		pkgName = "gve"
	}, ...)
end)

function GvePioneerTeamEditInfoPop:ctor()
	self:showAtCenter()

	self._useIconIdx = var_0_1:getPioneerTeamIconId()

	self:_initRegisterUI()
	self:_updateMainView()
	self.m_enterTransition:play()
end

function GvePioneerTeamEditInfoPop:_initRegisterUI()
	g.core.utils.Black:filterBlackOnInput(self.m_inputText)
	g.core.utils.Tools.setInputTextFont(self.m_inputText)
	self.m_teamSignList:setVirtual()
	self.m_teamSignList:setItemRenderer(handler(self, self._onTeamSignListRenderer))
	self.m_teamSignList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onChangeTeamIcon))
	self.m_changeIconBtn:addClickListener(handler(self, self._onClickChangeIconBtn))
	self.m_confirmBtn:addClickListener(handler(self, self._onClickConfirmEditTeamInfo))
end

function GvePioneerTeamEditInfoPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_TEAMMODIFY, handler(self, self._onS2CEditGveTeamModify), self)
end

function GvePioneerTeamEditInfoPop:_updateMainView()
	local var_5_0 = var_0_0.get(self._useIconIdx)

	self.m_teamIconLoader:setURL((g.core.common.Path:getGveTeamBigIconRes(var_5_0.path, var_5_0.icon)))
	self.m_teamSignList:setNumItems(var_0_0.getLength())
end

function GvePioneerTeamEditInfoPop:_onTeamSignListRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateIconPic(var_0_0.get(arg_6_1 + 1), arg_6_1 + 1, self._useIconIdx)
end

function GvePioneerTeamEditInfoPop:_onChangeTeamIcon(arg_7_1)
	self._useIconIdx = arg_7_1:getDataValue() + 1

	self:_updateMainView()
	self.m_isChangeHeadController:setSelectedIndex(0)
end

function GvePioneerTeamEditInfoPop:_onClickChangeIconBtn()
	self.m_isChangeHeadController:setSelectedIndex(1)
end

function GvePioneerTeamEditInfoPop:_onClickConfirmEditTeamInfo()
	if not self:_checkLegitimate() then
		return
	end

	local var_9_0 = false
	local var_9_1 = var_0_1:getPioneerTeamIconId()
	local var_9_2 = var_0_1:getPioneerTeamName()
	local var_9_3 = self.m_inputText:getText()
	local var_9_4 = {}

	if var_9_1 ~= self._useIconIdx then
		var_9_4.icon = self._useIconIdx
		var_9_0 = true
	else
		var_9_4.icon = var_9_1
	end

	if var_9_2 ~= var_9_3 then
		var_9_4.name = var_9_3
		var_9_0 = true
	else
		var_9_4.name = var_9_2
	end

	if not var_9_0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(109565))

		return
	else
		g.core.network.GameNetProxy:send_C2S_GVE_TeamModify(var_9_4)
	end
end

function GvePioneerTeamEditInfoPop:_checkLegitimate()
	local var_10_0 = self.m_inputText:getText()

	if g.core.utils.Black:isMatchText(var_10_0) or string.find(var_10_0, "*") then
		self.m_inputText:setText("")
		g.core.module.ModuleManager:tip(g.core.lang:get(100201))

		return false
	end

	if string.find(var_10_0, "^%s+$") or var_10_0 == "" or string.find(var_10_0, "　") then
		g.core.module.ModuleManager:tip(g.core.lang:get(309126))

		return false
	end

	local var_10_1 = #string.gsub(var_10_0, "[\x80-\xBF]", "")

	if var_10_1 < 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(309127))

		return false
	elseif var_10_1 > 8 then
		g.core.module.ModuleManager:tip(g.core.lang:get(309128))

		return false
	end

	return true
end

function GvePioneerTeamEditInfoPop:_onS2CEditGveTeamModify()
	g.core.module.ModuleManager:popModule()
end

return GvePioneerTeamEditInfoPop
