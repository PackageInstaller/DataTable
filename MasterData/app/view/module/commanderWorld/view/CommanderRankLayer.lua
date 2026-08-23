local var_0_0 = g.core.const.ConstMgr.CommanderWorldConst
local var_0_1 = g.core.model.User.commanderWorldData
local CommanderRankLayer = class("CommanderRankLayer", require("app.fairyGUI.commanderWorld.UI_CommanderRankLayer"), function()
	return fgui.GComponent:create({
		resName = "CommanderRankLayer",
		pkgPath = "ui/commanderWorld/commanderWorld",
		isFullScreen = true,
		pkgName = "commanderWorld"
	}, ...)
end)

function CommanderRankLayer:ctor()
	self._tabIndex = 0
	self._rankData = {}
	self._personRewardInfoData = {}
	self._guildRewardInfoData = {}
	self._stage = var_0_0.STAGE.LOCALSERVICE

	self:_initRegisterUI()
end

function CommanderRankLayer:_initRegisterUI()
	self.m_topBarComp:setResInfoById(var_0_0.TOP_BAR_ID)
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankItemRender))
	self.m_rankRewardList:setVirtual()
	self.m_rankRewardList:setItemRenderer(handler(self, self._onRankRewardItemRender))
	self.m_typeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onRankOrRewardChanged))
	self.m_srvTypeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onLocalOrCrossChanged))
end

function CommanderRankLayer:_onRankItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateRankCell((self._rankData.rankData and self._rankData.rankData[arg_4_1 + 1] or nil) and self._rankData.rankData[arg_4_1 + 1], self._tabIndex, arg_4_1 + 1)
end

function CommanderRankLayer:_onRankRewardItemRender(arg_5_1, arg_5_2)
	arg_5_2:updateRankRewardCell(self._personRewardInfoData[arg_5_1 + 1], self._guildRewardInfoData[arg_5_1 + 1], self.m_typeController:getSelectedIndex(), arg_5_1 + 1)
end

function CommanderRankLayer:_onRankOrRewardChanged()
	self:_updateRankList()
end

function CommanderRankLayer:_onLocalOrCrossChanged()
	if self._stage == var_0_0.STAGE.LOCALSERVICE and self.m_srvTypeController:getSelectedIndex() == 1 then
		self.m_rankTab:setVisible(false)
		self.m_typeController:setSelectedIndex(1)
	else
		self.m_rankTab:setVisible(true)
	end

	self:_updateRankList()
end

function CommanderRankLayer:onRevCommanderRankInfo()
	self:_updateRankList()
end

function CommanderRankLayer:sendGetRankInfo()
	if self._stage ~= var_0_0.STAGE.LOCALSERVICE then
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			id = g.core.network.proto.ORDER_WORLD_SCORE_CROSS,
			size = var_0_0.RANK_SIZE
		})
	else
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			id = g.core.network.proto.ORDER_WORLD_SCORE_LOCAL,
			size = var_0_0.RANK_SIZE
		})
	end
end

function CommanderRankLayer:onLoad()
	self._stage = var_0_1:getActivityStageAndRemainTime()

	self.m_srvTypeController:setSelectedIndex(math.min(1, self._stage - 1))
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self.onRevCommanderRankInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ORDER_WORLD_NOTIFYRANK, self.onRevCommanderRankInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateRankList, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, self._updateRankList, self)
	self:sendGetRankInfo()
end

function CommanderRankLayer:_updateRankList()
	local var_11_0 = self.m_srvTypeController:getSelectedIndex()
	local var_11_1 = var_0_1:getMyRankInfo(var_11_0 + 1)

	if var_11_1 == 0 then
		self.m_numTxt:setText(g.core.lang:get(410300))
	else
		self.m_numTxt:setText(var_11_1)
	end

	if var_11_0 == 0 then
		self._tabIndex = var_0_0.REWARDTAB.LOCALSERVICE
	elseif var_11_0 == 1 then
		self._tabIndex = var_0_0.REWARDTAB.CROSSSERVICE
	end

	self._rankData = var_0_1:getRankShowInfos(self._tabIndex)
	self._personRewardInfoData = var_0_1:getAllRankReardInfos(self._tabIndex)
	self._guildRewardInfoData = var_0_1:getAllRankReardInfos(self._tabIndex + 2)

	self.m_rankList:setNumItems(#self._personRewardInfoData)
	self.m_rankList:transitionShowCells("enter_left", 0.03)
	self.m_rankRewardList:setNumItems(#self._personRewardInfoData)
	self.m_rankRewardList:transitionShowCells("enter_left", 0.03)
	self.m_isEmptyController:setSelectedIndex(#self._personRewardInfoData > 0 and 0 or 1)
end

return CommanderRankLayer
