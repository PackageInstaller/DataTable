local var_0_0 = g.core.model.User.allianceData
local AllianceRankLayer = class("AllianceRankLayer", require("app.fairyGUI.alliance.UI_AllianceRankLayer"), function()
	return fgui.GComponent:create({
		resName = "AllianceRankLayer",
		pkgName = "alliance",
		isFullScreen = true,
		pkgPath = "ui/alliance/alliance"
	}, ...)
end)

function AllianceRankLayer:ctor()
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRendererAsync1(handler(self, self._onRankListRenderer), 0.05)
	self:addBg("bg/guild/bg_jt_juantuanrenwu.jpg")
	self.m_topBar:setResInfoById(341)
end

function AllianceRankLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_SEARCHLIST, handler(self, self._onGetSearchList), self)
	g.core.network.GameNetProxy:send_C2S_GuildAlliance_SearchList({
		name = ""
	})
end

function AllianceRankLayer:_onGetSearchList(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self._alliances = arg_4_4.alliances or {}

	self:_sortAllianceRankList()
	self:updateRankView()
end

function AllianceRankLayer:_sortAllianceRankList()
	table.sort(self._alliances, function(arg_6_0, arg_6_1)
		if arg_6_0.fight_value ~= arg_6_1.fight_value then
			return arg_6_1.fight_value < arg_6_0.fight_value
		end

		if arg_6_0.level ~= arg_6_1.level then
			return arg_6_1.level < arg_6_0.level
		end

		if #arg_6_0.guild_ids ~= #arg_6_1.guild_ids then
			return #arg_6_1.guild_ids < #arg_6_0.guild_ids
		end
	end)
end

function AllianceRankLayer:updateRankView()
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in ipairs(self._alliances) do
		if iter_7_1.id == var_0_0:getAllianceId() then
			var_7_0 = iter_7_0

			break
		end
	end

	if var_7_0 == 0 then
		self.m_myRankTxt:setText(g.core.lang:get(109556))
	else
		self.m_myRankTxt:setText(var_7_0)
	end

	self.m_rankList:setNumItems(#self._alliances)
	self.m_rankList:transitionShowCells("enter_up", 0.03, 1)
end

function AllianceRankLayer:_onRankListRenderer(arg_8_1, arg_8_2)
	arg_8_2:updateRankCell(arg_8_1 + 1, self._alliances[arg_8_1 + 1])
end

return AllianceRankLayer
