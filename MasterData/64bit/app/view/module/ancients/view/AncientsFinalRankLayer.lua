local AncientsFinalRankLayer = class("AncientsFinalRankLayer", require("app.fairyGUI.ancients.UI_AncientsFinalRankLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/ancients/ancients",
		resName = "AncientsFinalRankLayer",
		pkgName = "ancients"
	}, ...)
end)

function AncientsFinalRankLayer:ctor()
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_List_rank:setVirtual(self)
	self.m_List_rank:setItemRenderer(handler(self, self._onRenderListRankCell))
	self.m_List_rank:doFairyBatching(false)
	self.m_Comp_top_bar:setResInfoById(g.core.const.ConstMgr.AncientsConst.TopBarId)

	self._rankUnits = {}
end

function AncientsFinalRankLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GETFINALRANKLIST, handler(self, self._onRecvFinalRankList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onGetCommonSimpleUserSnapshot), self)

	self._isFinish = g.core.common.ServerTime:getTime() > g.core.model.User.ancientsData:getActivityData().final_end_time

	if self._isFinish then
		g.core.network.GameNetProxy:send_C2S_Ancient_GetFinalRankList({})
	else
		self:_createFakeRankUnits()
		self:_updateView()
	end
end

function AncientsFinalRankLayer:_updateView()
	local var_4_0 = g.core.model.User.ancientsData:getAncientsInfo()

	if not var_4_0 then
		return
	end

	self._awardArr = g.core.common.RankAward:getRankAwardArray(g.core.const.ConstMgr.RankAwardConst.ANCIENTS_FINAL, var_4_0.knockout_rank)

	self.m_List_rank:setNumItems(#self._rankUnits)
end

function AncientsFinalRankLayer:_onRenderListRankCell(arg_5_1, arg_5_2)
	arg_5_2:updateCell({
		isFinish = self._isFinish,
		rankUnit = self._rankUnits[arg_5_1 + 1],
		awards = self:_getAwards(self._rankUnits[arg_5_1 + 1].score)
	})
end

function AncientsFinalRankLayer:_onRecvFinalRankList(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self._rankUnits = arg_6_4.rank_units or {}

	self:_sendSimpleUserSnapshot()
end

function AncientsFinalRankLayer:_onGetCommonSimpleUserSnapshot(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	self:_updateView()
end

function AncientsFinalRankLayer:_sendSimpleUserSnapshot()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(self._rankUnits) do
		for iter_8_2, iter_8_3 in ipairs(g.core.common.GlobalFunc.rankUnit_param(iter_8_1.param, "AncientFinalRankUnit", true).user_ids or {}) do
			table.insert(var_8_0, iter_8_3)
		end
	end

	if g.core.utils.Tools.ancientsFunc.sendSimpleUserSnapshot(var_8_0) then
		self:_updateView()
	end
end

function AncientsFinalRankLayer:_createFakeRankUnits()
	self._rankUnits = {}

	for iter_9_0 = 1, 16 do
		local var_9_0 = 0

		if iter_9_0 == 1 then
			var_9_0 = 4
		elseif iter_9_0 == 2 then
			var_9_0 = 3
		elseif iter_9_0 <= 4 then
			var_9_0 = 2
		elseif iter_9_0 <= 8 then
			var_9_0 = 1
		end

		table.insert(self._rankUnits, {
			score = var_9_0
		})
	end
end

function AncientsFinalRankLayer:_getAwards(arg_10_1)
	for iter_10_0 = 1, #self._awardArr do
		if arg_10_1 == 0 then
			if self._awardArr[iter_10_0].minRank >= 9 then
				return self._awardArr[iter_10_0].data
			end
		elseif arg_10_1 == 1 then
			if self._awardArr[iter_10_0].minRank >= 5 and self._awardArr[iter_10_0].maxRank <= 8 then
				return self._awardArr[iter_10_0].data
			end
		elseif arg_10_1 == 2 then
			if self._awardArr[iter_10_0].minRank >= 3 and self._awardArr[iter_10_0].maxRank <= 4 then
				return self._awardArr[iter_10_0].data
			end
		elseif arg_10_1 == 3 then
			if self._awardArr[iter_10_0].minRank >= 2 and self._awardArr[iter_10_0].maxRank <= 2 then
				return self._awardArr[iter_10_0].data
			end
		elseif arg_10_1 == 4 and self._awardArr[iter_10_0].minRank >= 1 and self._awardArr[iter_10_0].maxRank <= 1 then
			return self._awardArr[iter_10_0].data
		end
	end

	return {}
end

return AncientsFinalRankLayer
