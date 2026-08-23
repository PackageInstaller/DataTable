local var_0_0 = g.core.model.User.gveDataMgr
local var_0_1 = g.core.event.enum
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.network.GameNetProxy
local var_0_4 = g.core.const.ConstMgr
local GveSeasonRankLayer = class("GveSeasonRankLayer", require("app.fairyGUI.gve.UI_GveSeasonRankLayer"), function()
	return fgui.GComponent:create({
		pkgName = "gve",
		isFullScreen = true,
		pkgPath = "ui/gve/gve",
		resName = "GveSeasonRankLayer"
	}, ...)
end)

function GveSeasonRankLayer:ctor()
	self:addBg("bg/common/pic_bb_beijing.jpg")

	self._honorData = {}
	self._rankData = {}

	self.m_topBarComp:setResInfoById(var_0_4.HelpConst.HELP_TYPE.GVE_RANK_POP)
	self:_initRegisterUI()
end

function GveSeasonRankLayer:_initRegisterUI()
	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardRenderer))
	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRankItemRenderer))
	self.m_rankList:doFairyBatching(false)
	self.m_honorList:setVirtual()
	self.m_honorList:setItemRenderer(handler(self, self._onHonorItemRenderer))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onRankTabCtrlChanged))
end

function GveSeasonRankLayer:onLoad()
	if not self._inInited then
		if var_0_0:getGveData():isAllNormalBossKilled() then
			self.m_isFinishController:setSelectedIndex(1)
		else
			self.m_isFinishController:setSelectedIndex(0)
			self.m_tabController:setSelectedIndex(2)
		end

		self._inInited = true
	end

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_GETBOSSRANK, self._onRcvRank, self)
	var_0_2:addEventListener(var_0_1.EVENT_NET_S2C_G_VE_GETBOSSFIRSTKILL, handler(self, self._onS2CGetHonorRankList), self)
	var_0_2:addEventListener(var_0_1.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._onUpdateRankList, self)
	var_0_2:addEventListener(var_0_1.EVENT_NET_S2C_GUILD_ALLIANCE_GETSNAPSHOT, self._onUpdateRankList, self)
	var_0_2:addEventListener(var_0_1.EVENT_NET_S2C_G_VE_GETBOSSAWARD, handler(self, self._onRewardBoss), self)
	g.core.network.GameNetProxy:send_C2S_GVE_GetBossRank({
		boss_id = 0,
		page = 1,
		rank_type = var_0_4.GveConst.GVE_RANK_TYPE.ALLIANCE_TOTAL_DAMAGE
	})
	var_0_3:send_C2S_GVE_GetBossFirstKill({})
	self:_updateAwardList()
end

function GveSeasonRankLayer:_onS2CGetSeasonRankList()
	self._rankData = var_0_0:getRankWorldGuild()

	if not self._rankData then
		return
	end

	if self.m_rankList then
		self.m_rankList:setNumItems(#self._rankData > 20 and 20 or #self._rankData)
	end

	self.m_myRankTxt:setText(var_0_0:getMyRankIdx())
end

function GveSeasonRankLayer:_onS2CGetHonorRankList()
	self._honorData = var_0_0:getSeasonHonorList()

	if self._honorData then
		self.m_honorList:setNumItems(#self._honorData)
	end
end

function GveSeasonRankLayer:_onUpdateRankList()
	self:_onS2CGetHonorRankList()
	self:_onS2CGetSeasonRankList()
end

function GveSeasonRankLayer:_onRewardBoss(arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	g.core.module.ModuleManager:awardSummary(arg_8_4.awards)

	self._honorData = var_0_0:getSeasonHonorList()

	if self._honorData then
		self.m_honorList:setNumItems(#self._honorData)
	end
end

function GveSeasonRankLayer:_updateAwardList()
	self._rankAward = var_0_0:getSeasonRankAwardList()

	if self.m_awardList then
		self.m_awardList:setNumItems(#self._rankAward)
	end
end

function GveSeasonRankLayer:_onAwardRenderer(arg_10_1, arg_10_2)
	if self._rankAward[arg_10_1 + 1] then
		arg_10_2:updateSeasonAwardCell(self._rankAward[arg_10_1 + 1])
		arg_10_2:setCtrlState("bg", {
			index = arg_10_1 % 2 ~= 0 and 1 or 0
		})
	end
end

function GveSeasonRankLayer:_onRankItemRenderer(arg_11_1, arg_11_2)
	if self._rankData[arg_11_1 + 1] then
		arg_11_2:updateSeasonRankCell(self._rankData[arg_11_1 + 1], arg_11_1 + 1)
		arg_11_2:setCtrlState("bg", {
			index = arg_11_1 % 2 ~= 0 and 1 or 0
		})
	end
end

function GveSeasonRankLayer:_onHonorItemRenderer(arg_12_1, arg_12_2)
	arg_12_2:updateCell(arg_12_1, self._honorData[arg_12_1 + 1])
end

function GveSeasonRankLayer:_onRankTabCtrlChanged()
	local var_13_0 = self.m_tabController:getSelectedIndex()

	if var_13_0 == 1 then
		if self.m_awardList then
			self.m_awardList:setNumItems(#self._rankAward)
			self.m_awardList:transitionShowCells("enter_left", 0.03)
		end
	elseif var_13_0 == 0 then
		if self.m_rankList then
			self.m_rankList:setNumItems(#self._rankData > 20 and 20 or #self._rankData)
			self.m_rankList:transitionShowCells("enter_left", 0.03)
		end
	elseif self.m_honorList then
		local var_13_1 = var_0_0:getGveTimeState()

		if var_13_1 == g.core.const.ConstMgr.GveConst.GVE_TIME_STATE.FORMAL or var_13_1 == g.core.const.ConstMgr.GveConst.GVE_TIME_STATE.RESULT then
			var_0_3:send_C2S_GVE_GetBossFirstKill({})
		end

		self.m_honorList:setNumItems(#self._honorData)
		self.m_honorList:transitionShowCells("enter_left", 0.03)
	end
end

function GveSeasonRankLayer:_onRcvRank(arg_14_1, arg_14_2, arg_14_3)
	if arg_14_3.rank_type == var_0_4.GveConst.GVE_RANK_TYPE.ALLIANCE_TOTAL_DAMAGE then
		self:_onS2CGetSeasonRankList(arg_14_1, arg_14_2, arg_14_3)
	end
end

return GveSeasonRankLayer
