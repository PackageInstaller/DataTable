local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.network.GameNetProxy
local var_0_3 = g.core.model.User.explorationData
local var_0_4 = g.core.const.ConstMgr.ExplorationConst
local var_0_5 = g.core.module.ModuleManager
local var_0_6 = g.core.network.proto
local ExplorationExhibitLayer = class("ExplorationExhibitLayer", require("app.fairyGUI.exploration.UI_ExplorationExhibitLayer"), function()
	return fgui.GComponent:create({
		resName = "ExplorationExhibitLayer",
		pkgName = "exploration",
		isFullScreen = true,
		pkgPath = "ui/exploration/exploration"
	}, ...)
end)

function ExplorationExhibitLayer:ctor()
	self._clearRankList = {}
	self._myClearRank = 0

	self.m_rankList:setVirtual()
	self.m_rankList:setItemRenderer(handler(self, self._onRenderRankList))
	self.m_rankBtn:addClickListener(handler(self, self._onClickRankBtn))
	self.m_shopBtn:addClickListener(handler(self, self._onClickShopBtn))
	self:addBg("bg/exploration/bg_slmj_jiesuan.jpg")
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.EXPLORATION)
end

function ExplorationExhibitLayer:_updateView()
	if self._myClearRank > 0 then
		self.m_myRank:setText(g.core.lang:get(420661, {
			rank = self._myClearRank
		}))
	else
		self.m_myRank:setText(g.core.lang:get(420660))
	end

	self:_updateShowUser()
end

function ExplorationExhibitLayer:_onRenderRankList(arg_4_1, arg_4_2)
	arg_4_2:updateCell(arg_4_1 + 1, self._clearRankList[arg_4_1 + 1])
end

function ExplorationExhibitLayer:_onClickRankBtn()
	var_0_5:pushModule(g.view.entrance.EXPLORATION_RANK_LAYER)
end

function ExplorationExhibitLayer:_onClickShopBtn()
	var_0_5:pushModule(g.view.entrance.EXPLORATION_PLAY_SHOP)
end

function ExplorationExhibitLayer:_updateRankData(arg_7_1, arg_7_2, arg_7_3)
	if arg_7_3.id == var_0_6.EXPLORATION_PASS_CROSS then
		self._clearRankList, self._myClearRank = var_0_3:getRankList(var_0_4.RANK_TYPE.CLEAR)
	end

	self:_updateView()
end

function ExplorationExhibitLayer:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._updateRankData, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateRankData, self)
	var_0_1:addEventListener(var_0_0.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayUpdate, self)
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._updateShowUser, self)
	var_0_2:send_C2S_GetCommonRankList({
		size = 50,
		id = var_0_6.EXPLORATION_PASS_CROSS
	})
end

function ExplorationExhibitLayer:_onCrossDayUpdate()
	if var_0_3:getCurStage() == var_0_4.OPEN_STATE.NONE then
		var_0_5:tip(g.core.lang:get(420659))
		var_0_5:switchModuleIntelligent(g.view.entrance.HOME)

		return
	end
end

function ExplorationExhibitLayer:_updateShowUser()
	self.m_rankList:setNumItems(#self._clearRankList)

	if self._clearRankList[1] then
		local var_10_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._clearRankList[1].id)

		if var_10_0 then
			self.m_lordComp:updateComp(var_10_0)
		end
	end
end

return ExplorationExhibitLayer
