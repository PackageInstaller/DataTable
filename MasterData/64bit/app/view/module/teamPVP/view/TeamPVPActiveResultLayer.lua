local var_0_0 = g.core.const.ConstMgr.ShopConst
local var_0_1 = g.core.module.ModuleManager
local var_0_2 = g.core.model.User.knightsData
local DrawKnight = require("app.view.common.DrawKnight")
local var_0_4 = g.core.common.Path
local var_0_5 = g.core.model.User.teamPvpData
local TeamPVPActiveResultLayer = class("TeamPVPActiveResultLayer", require("app.fairyGUI.teamPVP.UI_TeamPVPActiveResultLayer"), function()
	return fgui.GComponent:create({
		pkgName = "teamPVP",
		isFullScreen = true,
		pkgPath = "ui/teamPVP/teamPVP",
		resName = "TeamPVPActiveResultLayer"
	}, ...)
end)

function TeamPVPActiveResultLayer:ctor()
	self._showSpine = nil
	self._rankList = {}

	self:initView()
	self.m_enterTransition:play()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.TEAM_PVP)
end

function TeamPVPActiveResultLayer:initView()
	self.m_bgLoader:setURL(var_0_4:getTeamPVPMainBg(var_0_5:getMapInfo().map_id))
	self.m_rankBtn:addClickListener(handler(self, self._onClickRankBtn))
	self.m_shopBtn:addClickListener(handler(self, self._onClickShopBtn))
end

function TeamPVPActiveResultLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_COMMON_RANK_LIST, handler(self, self._onRefreshRankList), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self.updateView), self)
	g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
		size = 3,
		id = g.core.network.proto.GROUP_BATTLE_HONOR_CROSS
	})
end

function TeamPVPActiveResultLayer:_onRefreshRankList(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self._rankList = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_4.rank_units or {}) do
		self._rankList[iter_5_1.rank] = iter_5_1
	end

	self:updateView()
end

function TeamPVPActiveResultLayer:updateView()
	if not self._rankList[1] then
		return
	end

	local var_6_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, self._rankList[1].id)

	if var_6_0 then
		local var_6_1 = var_6_0.show_knight_id or 0

		if var_6_1 < 1 then
			var_6_1 = var_6_0.base_id
		end

		local var_6_2 = var_0_2:getKnightResInfo({
			knightId = var_6_1,
			skinId = var_6_0.show_knight_dress
		})

		if not self._showSpine then
			self._showSpine = DrawKnight.new({
				isShowBg = true,
				resId = var_6_2.painted_id
			})

			self.m_knightSpineDad:addChild(self._showSpine)
		end

		self.m_userName:setText(var_6_0.name)
	else
		self.m_userName:setText("")
	end

	local var_6_3 = 1

	while self["m_showComp" .. var_6_3] and self._rankList[var_6_3] do
		self["m_showComp" .. var_6_3]:updateShowComp(self._rankList[var_6_3])

		var_6_3 = var_6_3 + 1
	end
end

function TeamPVPActiveResultLayer:_onClickRankBtn()
	var_0_1:pushModule(g.view.entrance.TEAM_PVP_RANK_LAYER)
end

function TeamPVPActiveResultLayer:_onClickShopBtn()
	var_0_1:pushModule(g.view.entrance.SHOP, {
		tabType = var_0_0.SHOP_INFO_TAB_TYPE.PLAY_TAB_TYPE,
		shopType = var_0_0.SHOP_TYPE.TEAM_PVP
	})
end

return TeamPVPActiveResultLayer
