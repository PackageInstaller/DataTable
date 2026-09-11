local GuildEntraceView = class("GuildEntraceView", ReduxView)

function GuildEntraceView:Init()
	self.enterGuildHandler_ = handler(self, self.EnterGuild)
	self.exitGuildHandler_ = handler(self, self.ExitGuild)
end

function GuildEntraceView:OnEnter()
	manager.notify:RegistListener(GUILD_ENTER, self.enterGuildHandler_)
	manager.notify:RegistListener(GUILD_EXIT, self.exitGuildHandler_)
end

function GuildEntraceView:OnExit()
	manager.notify:RemoveListener(GUILD_ENTER, self.enterGuildHandler_)
	manager.notify:RemoveListener(GUILD_EXIT, self.exitGuildHandler_)
end

function GuildEntraceView:Dispose()
	GuildEntraceView.super.Dispose(self)

	self.enterGuildHandler_ = nil
end

function GuildEntraceView:AddListeners()
	return
end

function GuildEntraceView:EnterGuild()
	if self:IsOpenRoute("chat") then
		JumpTools.OpenPageByJump("guildEntrace/guildMain/chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_GUILD
		}, ViewConst.SYSTEM_ID.CHAT)
	else
		self:Go("/guildEntrace/guildMain")
	end
end

function GuildEntraceView:ExitGuild()
	self:Go("/home")
end

return GuildEntraceView
