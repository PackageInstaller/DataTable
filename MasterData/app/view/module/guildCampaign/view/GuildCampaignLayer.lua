local var_0_0 = g.core.model.User.guildCampaignData
local GuildCampaignLayer = class("GuildCampaignLayer", require("app.fairyGUI.guildCampaign.UI_GuildCampaignLayer"), function()
	return fgui.GComponent:create({
		resName = "GuildCampaignLayer",
		pkgPath = "ui/guildCampaign/guildCampaign",
		isFullScreen = true,
		pkgName = "guildCampaign"
	}, ...)
end)

function GuildCampaignLayer:ctor(arg_2_1)
	self._routeId = -1

	self:addBg("bg/guild/bg_jt_juntuanzhujiemian.jpg", false)
	self.m_scrollList:setVirtual()
	self.m_scrollList:setItemRenderer(handler(self, self._onListRenderer))
	self:addListen(self.m_scrollList)
end

function GuildCampaignLayer:onLoad()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 1)
	self:_updateView()
	g.core.sound.SoundManager:playMusic(g.core.const.ConstMgr.SoundConst.BGM.MUSIC_ARMY)
end

function GuildCampaignLayer:_updateView()
	self._campaignData = var_0_0:getPlayDesInfo() or {}

	self.m_scrollList:setNumItems(#self._campaignData)
	self.m_scrollList:transitionShowCells("enter_left", 0.03, 1)

	local var_5_0 = var_0_0:getNewestPlay()

	if var_5_0 > 0 then
		self.m_scrollList:scrollToView(var_5_0 - 1, true)
	end
end

function GuildCampaignLayer:_onListRenderer(arg_6_1, arg_6_2)
	if self._campaignData[arg_6_1 + 1] then
		arg_6_2:updateInfo(self._campaignData[arg_6_1 + 1])
	end
end

function GuildCampaignLayer:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "GuildCampaignCell_goToModule" and arg_7_2 and arg_7_2.routeId then
		self:_goToModule(arg_7_2.routeId)
	end
end

function GuildCampaignLayer:_goToModule(arg_8_1)
	self._routeId = arg_8_1

	self:_goTo()
end

function GuildCampaignLayer:_goTo()
	if self._routeId > 0 then
		local var_9_0, var_9_1 = g.view.entrance.ModuleGotoProxy:getModule(self._routeId)

		if not g.core.module.ModuleManager:isCurModule(var_9_0) then
			g.view.entrance.ModuleGotoProxy:gotoModule(self._routeId, false)
		end

		self._routeId = -1
	end
end

return GuildCampaignLayer
