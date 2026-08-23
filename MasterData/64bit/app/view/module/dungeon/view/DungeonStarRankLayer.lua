local var_0_0 = g.core.model.User.dungeonData
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.event.EventManager
local DungeonStarRankLayer = class("DungeonStarRankLayer", require("app.fairyGUI.dungeon.UI_DungeonStarRankLayer"), function()
	return fgui.GComponent:create({
		pkgName = "dungeon",
		isFullScreen = true,
		pkgPath = "ui/dungeon/dungeon",
		resName = "DungeonStarRankLayer"
	})
end)

function DungeonStarRankLayer:ctor()
	self._rankData = {}
	self._showAnime = false

	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_topBarComp:setResInfoById(43)
	self:_initUiListener()
end

function DungeonStarRankLayer:_initUiListener()
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._setItemRenderer))
end

function DungeonStarRankLayer:_setItemRenderer(arg_4_1, arg_4_2)
	arg_4_2:updateRankCell(self._rankData[arg_4_1 + 1], self._rankVal, arg_4_1)
end

function DungeonStarRankLayer:onLoad()
	var_0_2:addEventListener(var_0_1.EVENT_NET_S2C_GET_COMMON_RANK_LIST, handler(self, self._onRecvRankList), self)
	var_0_2:addEventListener(var_0_1.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._updateRankUI), self)
	self:_sendGetRankList()
end

function DungeonStarRankLayer:_sendGetRankList()
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		id = 1,
		size = 20
	})
end

function DungeonStarRankLayer:_onRecvRankList(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self._rankVal = arg_7_4.self_rank or 0
	self._rankData = arg_7_4.rank_units or {}

	self:_updateRankUI()
end

function DungeonStarRankLayer:_updateRankUI()
	if self._rankData then
		self.m_rankList:setNumItems(table.nums(self._rankData))

		if not self._showAnime then
			self._showAnime = true

			self.m_rankList:animateShowCells()
		end

		self:_updateMeRank()
	end
end

function DungeonStarRankLayer:_updateMeRank()
	self.m_rankTxt:setText((self._rankVal > 0 or nil) and (self._rankVal or g.core.lang:get(300012)))
	self.m_starTxt:setText(var_0_0:getTotalStars())
end

return DungeonStarRankLayer
