local var_0_0 = g.core.model.User.redCliffData
local var_0_1 = g.core.const.ConstMgr.RedCliffConst
local RedCliffRankLayer = class("RedCliffRankLayer", require("app.fairyGUI.redCliff.UI_RedCliffRankLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/redCliff/redCliff",
		resName = "RedCliffRankLayer",
		pkgName = "redCliff",
		isFullScreen = true
	}, ...)
end)

function RedCliffRankLayer:ctor()
	self._rankType = var_0_1.RANK_TYPE.CROSS
	self._topSel = 0
	self._rankList = {}
	self._rewardList = {}

	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRenderRankList))
	self.m_rewardList:setVirtual()
	self.m_rewardList:setItemRenderer(handler(self, self._onRenderRewardList))
	self.m_rankTypeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onRankTypeChanged))
	self.m_topSelController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTopSelChanged))
	self.m_rankTypeController:setSelectedIndex(var_0_1.RANK_TYPE.CROSS)
	self.m_topSelController:setSelectedIndex(self._topSel)
	self:addBg("bg/common/pic_bb_beijing.jpg")
end

function RedCliffRankLayer:_updateView()
	local var_3_0 = var_0_0:getMyRankByRankType(self._rankType)

	if var_3_0 > 0 then
		self.m_rankTxt:setText(g.core.lang:get(421100, {
			rank = var_3_0
		}))
	else
		self.m_rankTxt:setText(g.core.lang:get(421099))
	end

	if self._topSel == var_0_1.TOP_TYPE.RANK then
		local var_3_1 = g.core.network.proto.CHIBI_ACHIEVEMENT_CROSS
		local var_3_2 = var_0_1.RANK_SHOW_SIZE.CROSS

		if self._rankType == 0 then
			var_3_1 = g.core.network.proto.CHIBI_ACHIEVEMENT_ALL_SERVER
			var_3_2 = var_0_1.RANK_SHOW_SIZE.ALL_SERVER
		end

		self._rankList = var_0_0:getRankListByRankType(var_3_1)

		self.m_rankList:setNumItems(var_3_2)
	else
		self._rewardList = var_0_0:getRewardByRewardType((self._rankType == 0 or nil) and (var_0_1.REWARD_TYPE.ALL_SERVER or var_0_1.REWARD_TYPE.CROSS))

		self.m_rewardList:setNumItems(#self._rewardList)
	end
end

function RedCliffRankLayer:_onRankTypeChanged()
	self._rankType = self.m_rankTypeController:getSelectedIndex()

	self:_updateView()
end

function RedCliffRankLayer:_onTopSelChanged()
	self._topSel = self.m_topSelController:getSelectedIndex()

	self:_updateView()
end

function RedCliffRankLayer:_onRenderRankList(arg_6_1, arg_6_2)
	arg_6_2:updateRankCell(self._rankList[arg_6_1 + 1], arg_6_1)
end

function RedCliffRankLayer:_onRenderRewardList(arg_7_1, arg_7_2)
	arg_7_2:updateCell(arg_7_1, self._rewardList[arg_7_1 + 1])
end

function RedCliffRankLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._updateView, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateView, self)

	local var_8_0 = g.core.common.ServerTime:getTime() >= var_0_0:getSemiFinalTime()[1].startTime

	self._rankType = var_8_0 and 0 or 1

	self.m_showAllSvrController:setSelectedIndex(var_8_0 and 1 or 0)
	self.m_rankTypeController:setSelectedIndex(self._rankType)
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		id = g.core.network.proto.CHIBI_ACHIEVEMENT_CROSS,
		size = var_0_1.RANK_SHOW_SIZE.CROSS
	})

	if var_8_0 then
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			id = g.core.network.proto.CHIBI_ACHIEVEMENT_ALL_SERVER,
			size = var_0_1.RANK_SHOW_SIZE.ALL_SERVER
		})
	end

	self:_updateView()
end

return RedCliffRankLayer
