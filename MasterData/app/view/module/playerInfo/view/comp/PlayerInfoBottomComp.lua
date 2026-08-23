local var_0_0 = g.core.config.dungeon_stage_info
local var_0_1 = g.core.model.User.playerInfoData
local var_0_2 = g.core.model.User.knightsData
local var_0_3 = g.core.config.dungeon_chapter_info
local PlayerInfoBottomComp = class("PlayerInfoBottomComp", require("app.fairyGUI.playerInfo.UI_PlayerInfoBottomComp"))

function PlayerInfoBottomComp:ctor()
	self._tissueList = {}

	self:initView()
end

function PlayerInfoBottomComp:initView()
	self.m_tissueList:setVirtual()
	self.m_tissueList:setItemRenderer(handler(self, self._onRenderTissueList))
end

function PlayerInfoBottomComp:_onRenderTissueList(arg_3_1, arg_3_2)
	arg_3_2:updateCell(self._tissueList[arg_3_1 + 1], arg_3_1, self._isSelf)
end

function PlayerInfoBottomComp:updatePlayerProgress(arg_4_1)
	if arg_4_1 then
		self.m_praiseText:setText(g.core.model.User.furnitureData:getSumCharmValue())

		local var_4_0 = g.core.model.User.dungeonData:getLastPassedChapter()
		local var_4_1 = {}

		if var_4_0 > 0 then
			var_4_1 = var_0_3.get(var_4_0)
		end

		self.m_dungeonText:setText((var_4_1.land_id or 0) .. "-" .. (var_4_1.id or 0))
		self.m_curKnightText:setText(#var_0_2:getBagList(0))
		self.m_allKnightCountText:setText("/ " .. #var_0_2:getAllPutKnight() + 1)
		self.m_wushText:setText(g.core.model.User.wushData:getOldMaxFloor() .. "KM")

		local var_4_2, var_4_3 = g.core.model.User.arenaData:getRank()

		self.m_arenaText:setText(not var_4_2 and g.core.lang:get(2080) or var_4_2)

		if not var_4_2 then
			g.core.network.GameNetProxy:send_C2S_Arena_GetMainInfo({})
		end

		self.m_charmText:setText((g.core.model.User.succubaData:getTotalCharm()))
		self.m_honorNumText:setText((g.core.model.User.knightSoulData:getCurHonorNum()))

		if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_SOUL) then
			self.m_unLockStateController:setSelectedIndex(2)
		elseif g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.SUCCUBA) then
			self.m_unLockStateController:setSelectedIndex(1)
		end

		return
	end

	self.m_praiseText:setText((var_0_1:getFurnitureRoomCharm()))

	local var_4_4 = var_0_0.fetch((var_0_1:getDungeonStage()))
	local var_4_5 = {}

	if var_4_4 then
		var_4_5 = var_0_3.get(var_4_4.chapter_id)
	end

	self.m_dungeonText:setText((var_4_5.land_id or 0) .. "-" .. (var_4_5.id or 0))
	self.m_curKnightText:setText((var_0_1:getKnightNum()))
	self.m_allKnightCountText:setText("/ " .. #var_0_2:getAllPutKnight() + 1)
	self.m_wushText:setText(var_0_1:getWushMaxFloor() .. "KM")

	local var_4_6 = var_0_1:getArenaTopRank()

	self.m_arenaText:setText(var_4_6 == 0 and g.core.lang:get(2080) or var_4_6)
	self.m_charmText:setText((var_0_1:getSuccubaTotalCharm()))
	self.m_honorNumText:setText((var_0_1:getKnightSoulHonorNum()))

	local var_4_7 = var_0_1:getPlayerSnapShot().level or 0

	if var_4_7 >= g.core.common.ModuleUnlock:getModuleUnlockLevel(g.core.const.ConstMgr.FUNCTION_TYPE.KNIGHT_SOUL) then
		self.m_unLockStateController:setSelectedIndex(2)
	elseif g.core.common.ModuleUnlock:getModuleUnlockLevel(g.core.const.ConstMgr.FUNCTION_TYPE.SUCCUBA) <= var_4_7 then
		self.m_unLockStateController:setSelectedIndex(1)
	end
end

function PlayerInfoBottomComp:updateTissueList()
	self._tissueList = var_0_1:getAllTissue()

	self.m_tissueList:setNumItems(table.nums(self._tissueList))
end

function PlayerInfoBottomComp:updateArenaRank(arg_6_1)
	self.m_arenaText:setText(not arg_6_1 and g.core.lang:get(2080) or arg_6_1)
end

return PlayerInfoBottomComp
