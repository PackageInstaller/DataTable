local GveInstituteRankPop = class("GveInstituteRankPop", require("app.fairyGUI.gve.UI_GveInstituteRankPop"), function()
	return fgui.GComponent:create({
		resName = "GveInstituteRankPop",
		pkgPath = "ui/gve/gve",
		pkgName = "gve"
	}, ...)
end)

function GveInstituteRankPop:ctor()
	self:showAtCenter()
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankRenderer))
end

function GveInstituteRankPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_RESEARCHRANKLIST, self._onGetRankList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateList, self)
	g.core.network.GameNetProxy:send_C2S_GVE_ResearchRankList({})
end

function GveInstituteRankPop:_onGetRankList(arg_4_1, arg_4_2, arg_4_3)
	self._rank = arg_4_3.list or {}

	self.m_rankList:setNumItems(#self._rank)
end

function GveInstituteRankPop:_updateList()
	self.m_rankList:setNumItems(#self._rank)
end

function GveInstituteRankPop:_onRankRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateRank(self._rank[arg_6_1 + 1], arg_6_1 + 1)
end

return GveInstituteRankPop
