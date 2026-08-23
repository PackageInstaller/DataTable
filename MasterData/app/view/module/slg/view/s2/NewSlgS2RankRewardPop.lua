local NewSlgS2RankRewardPop = class("NewSlgS2RankRewardPop", function()
	return fgui.GComponent:create({
		resName = "NewSlgS2RankRewardPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end)
local var_0_1 = g.core.const.ConstMgr.NewSlgConst
local var_0_2 = {
	[g.core.const.ConstMgr.NewSlgConst.RANK_TYPE.PERSONAL_ALL] = 0,
	[g.core.const.ConstMgr.NewSlgConst.RANK_TYPE.S2_ALLIANCE] = 1
}

function NewSlgS2RankRewardPop:ctor(arg_2_1)
	self:getView():center(true)
	self:getChild("ComPopPanel"):setHelpId(g.const.HelpConst.HELP_TYPE.NEW_SLG_RANK2)

	self._compSelf = self:getChild("Comp_self")
	self._listReward = self:getChild("List_reward")

	self._listReward:setVirtual(self)
	self._listReward:setItemRenderer(handler(self, self._onRenderListRewardCell))

	self._bigTabCtrl = self:getController("bigTab")
	self._inRankCtrl = self:getController("inRank")
	self._typeCtrl = self:getController("type")

	self._typeCtrl:addEventListener(fgui.UIEventType.Changed, handler(self, self._onCtrlTypeChange))

	self._noSend = false

	if arg_2_1 and arg_2_1.rankType then
		self._rankId = arg_2_1.rankType
	else
		self._rankId = var_0_1.RANK_TYPE.PERSONAL_ALL
		self._noSend = true
	end

	self._typeIndex = var_0_2[self._rankId]

	self._bigTabCtrl:setSelectedIndex(self._typeIndex)
end

function NewSlgS2RankRewardPop:_onCtrlTypeChange()
	local var_3_0 = self._typeCtrl:getSelectedIndex()

	if var_3_0 + 1 == self._rankId then
		return
	end

	self._rankId = var_3_0 + 1

	self:_sendMsg()
end

function NewSlgS2RankRewardPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETRANK, handler(self, self._onS2CNewSlgGetRank), self)
	self:_sendMsg()
end

function NewSlgS2RankRewardPop:_sendMsg()
	if self._noSend then
		self:_updateView()
	else
		g.core.network.GameNetProxy:send_C2S_NewSlg_GetRank({
			limit = 1,
			id = self._rankId
		})
	end
end

function NewSlgS2RankRewardPop:_onS2CNewSlgGetRank(arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	self._selfRank = arg_6_4.self_unit

	self:_updateView()
end

function NewSlgS2RankRewardPop:_updateView()
	self._dataArr = g.core.model.User.newSlgData:getNewSlgCurrentRankReward(self._rankId)

	self._listReward:setNumItems(#self._dataArr)

	if self._selfRank and self._selfRank.rank > 0 then
		local var_7_0

		for iter_7_0, iter_7_1 in ipairs(self._dataArr) do
			if iter_7_1.min_rank <= self._selfRank.rank and self._selfRank.rank <= iter_7_1.max_rank then
				var_7_0 = iter_7_1

				break
			end
		end

		if var_7_0 then
			self._inRankCtrl:setSelectedIndex(1)
			self._compSelf:updateNewSlgFinalRewardCell(var_7_0, self._rankId)
			self._compSelf:setSelf()
		else
			self._inRankCtrl:setSelectedIndex(0)
		end
	else
		self._inRankCtrl:setSelectedIndex(0)
	end
end

function NewSlgS2RankRewardPop:_onRenderListRewardCell(arg_8_1, arg_8_2)
	arg_8_2:updateNewSlgFinalRewardCell(self._dataArr[arg_8_1 + 1], self._rankId)
	arg_8_2:setCurRank((self._selfRank or nil) and (self._selfRank.rank or 0))
end

return NewSlgS2RankRewardPop
