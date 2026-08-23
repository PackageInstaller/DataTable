local GuildCampaignMoviePop = class("GuildCampaignMoviePop", require("app.fairyGUI.guildCampaign.UI_GuildCampaignMoviePop"), function()
	return fgui.GComponent:create({
		resName = "GuildCampaignMoviePop",
		pkgName = "guildCampaign",
		isFullScreen = true,
		pkgPath = "ui/guildCampaign/guildCampaign"
	}, ...)
end)

function GuildCampaignMoviePop:ctor(arg_2_1)
	self:addClickListener(handler(self, self._onClick))

	self._callBack = arg_2_1.callBack
	self.functionId = arg_2_1.functionId

	self:showAtCenter()

	local var_2_0 = {}

	var_2_0.x = 25
	var_2_0.y = 25
	var_2_0.moduleName = arg_2_1.movieInfo.moduleName
	var_2_0.movieName = arg_2_1.movieInfo.movieName
	var_2_0.listener = handler(self, self._onMoviePlayEvent)
	self.movie = self.m_movieComp:addCriSprite(var_2_0)
	self._isMessageBack = false
end

function GuildCampaignMoviePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ARENA_GETMAININFO, self._onArenaGetMainInfo, self)

	if self.functionId and self.functionId == 10003 then
		g.core.network.GameNetProxy:send_C2S_Arena_GetMainInfo({})
	end
end

function GuildCampaignMoviePop:_onArenaGetMainInfo()
	self._isMessageBack = true
end

function GuildCampaignMoviePop:_onMoviePlayEvent(arg_5_1, arg_5_2)
	if arg_5_1 == "complete" then
		self:_closeAll()
	end
end

function GuildCampaignMoviePop:_closeAll()
	if self._callBack then
		self._callBack(self._isMessageBack)
	end

	self.m_movieComp:removeAllCriSprite()
	self:newScheduleOnce(function()
		g.core.module.ModuleManager:popComponent()
	end, 0.06666666666666667)
end

function GuildCampaignMoviePop:_onClick()
	return
end

return GuildCampaignMoviePop
