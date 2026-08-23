local GuildAnnouncementPop = class("GuildAnnouncementPop", require("app.fairyGUI.guild.UI_GuildAnnouncementPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/guild/guild",
		resName = "GuildAnnouncementPop",
		pkgName = "guild",
		isFullScreen = true
	}, ...)
end)

function GuildAnnouncementPop:ctor(arg_2_1)
	self._type = arg_2_1 and arg_2_1.type
	self._placeHolderTxt = g.core.lang:get(109541)
	self._isInFocus = false

	self:_init()
end

function GuildAnnouncementPop:_init()
	self.m_finishBtn:addClickListener(handler(self, self._onFinishClick))
	self.m_clickLayer:addClickListener(handler(self, self._onExitClick))
	self.m_inputTxt:addClickListener(handler(self, self._onInputTextClick))
	self.m_inputTxt:setMaxLength(34)
	g.core.utils.Tools.setInputTextFont(self.m_inputTxt)
end

function GuildAnnouncementPop:_onFinishClick()
	local var_4_0 = self.m_inputTxt:getText()

	if g.core.utils.Black:isMatchText(var_4_0) then
		g.core.module.ModuleManager:tip(g.core.lang:get(100201))

		return false
	end

	if var_4_0 ~= "" and var_4_0 ~= self._placeHolderTxt then
		if string.find(var_4_0, "^%s+$") then
			g.core.module.ModuleManager:tip(g.core.lang:get(109542))

			return
		end

		if self._type == 1 then
			g.core.network.GameNetProxy:send_C2S_Guild_ModifyInfo({
				type = 32,
				announcement = var_4_0
			})
		else
			g.core.network.GameNetProxy:send_C2S_Guild_ModifyInfo({
				type = 16,
				declaration = var_4_0
			})
		end
	end

	g.core.module.ModuleManager:popComponent()
end

function GuildAnnouncementPop:_onExitClick()
	if self.m_inputTxt:getText() == "" then
		self.m_inputTxt:setText(self._placeHolderTxt)
	end

	if self._isInFocus then
		self._isInFocus = false

		return
	end

	g.core.module.ModuleManager:popComponent()
end

function GuildAnnouncementPop:_onInputTextClick()
	self._isInFocus = true

	if self.m_inputTxt:getText() == self._placeHolderTxt then
		self.m_inputTxt:setText("")
	end
end

return GuildAnnouncementPop
