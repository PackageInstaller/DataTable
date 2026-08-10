local var_0_0 = class("GuildEntraceView", ReduxView)

function var_0_0.Init(arg_1_0)
	arg_1_0.enterGuildHandler_ = handler(arg_1_0, arg_1_0.EnterGuild)
	arg_1_0.exitGuildHandler_ = handler(arg_1_0, arg_1_0.ExitGuild)
end

function var_0_0.OnEnter(arg_2_0)
	manager.notify:RegistListener(GUILD_ENTER, arg_2_0.enterGuildHandler_)
	manager.notify:RegistListener(GUILD_EXIT, arg_2_0.exitGuildHandler_)
end

function var_0_0.OnExit(arg_3_0)
	manager.notify:RemoveListener(GUILD_ENTER, arg_3_0.enterGuildHandler_)
	manager.notify:RemoveListener(GUILD_EXIT, arg_3_0.exitGuildHandler_)
end

function var_0_0.Dispose(arg_4_0)
	var_0_0.super.Dispose(arg_4_0)

	arg_4_0.enterGuildHandler_ = nil
end

function var_0_0.AddListeners(arg_5_0)
	return
end

function var_0_0.EnterGuild(arg_6_0)
	if arg_6_0:IsOpenRoute("chat") then
		JumpTools.OpenPageByJump("guildEntrace/guildMain/chat", {
			ignoreBG = true,
			chatToggleID = ChatConst.CHAT_CHANNEL_GUILD
		}, ViewConst.SYSTEM_ID.CHAT)
	else
		arg_6_0:Go("/guildEntrace/guildMain")
	end
end

function var_0_0.ExitGuild(arg_7_0)
	arg_7_0:Go("/home")
end

return var_0_0
