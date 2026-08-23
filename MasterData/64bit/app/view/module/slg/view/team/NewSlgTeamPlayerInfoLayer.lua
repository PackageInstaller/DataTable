local DrawKnight = require("app.view.common.DrawKnight")
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.event.enum
local var_0_3 = g.core.module.ModuleManager
local var_0_4 = g.core.model.User.snapShotCacheData
local var_0_5 = g.core.const.ConstMgr.SnapShotCacheConst
local NewSlgTeamPlayerInfoLayer = class("NewSlgTeamPlayerInfoLayer", require("app.fairyGUI.newSlg.UI_NewSlgTeamPlayerInfoLayer"), function()
	return fgui.GComponent:create({
		pkgName = "newSlg",
		isFullScreen = true,
		pkgPath = "ui/newSlg/newSlg",
		resName = "NewSlgTeamPlayerInfoLayer"
	}, ...)
end)

function NewSlgTeamPlayerInfoLayer:ctor(arg_2_1)
	self._params = arg_2_1 or {}
	self._uid = self._params.uid
	self._showKnight = nil
	self._player = nil
	self._authority = 0
	self._teams = {}

	self.m_topBar:hideHomeBtn()
	self:initView()
end

function NewSlgTeamPlayerInfoLayer:initView()
	self:addBg("bg/playerInfo/bg_personal_info.jpg")
	self.m_teamList:setVirtual(self)
	self.m_teamList:setItemRenderer(handler(self, self._onRenderListTeamCell))
	self.m_teamList:setScrollEnabled(false)
end

function NewSlgTeamPlayerInfoLayer:onLoad()
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_NEW_SLG_GETUSERDETAIL, handler(self, self._onNewSlgGetUserDetailSuc), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_FRIEND_ADDFRIEND, handler(self, self._onAddRequestSuc), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_FRIEND_DELFRIEND, handler(self, self._onDeleteSuc), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_FRIEND_ADDBLACKLIST, handler(self, self._onBlackSuc), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_FRIEND_NOTIFYADDFRIEND, handler(self, self._onSynchronizeInfoEnd), self)
	var_0_1:addEventListener(var_0_2.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._updatePlayerInfo), self)
	var_0_1:addEventListener(var_0_2.EVENT_CROSS_DAY_NOTIFY, self._onCrossDayNotify, self)
	g.core.network.GameNetProxy:send_C2S_NewSlg_GetUserDetail({
		uid = self._uid
	})
	self.m_hasDataController:setSelectedIndex(0)
	self:_updatePlayerInfo()
	self.m_enterTransition:play()
end

function NewSlgTeamPlayerInfoLayer:_onNewSlgGetUserDetailSuc(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self._authority = arg_5_4.detail.authority
	self._teams = arg_5_4.detail.teams or {}

	self:_updateTeam()
	self.m_userComp:updateAuthority(self._authority)
end

function NewSlgTeamPlayerInfoLayer:_createShowSpine()
	if self._player and self._showKnight == nil then
		local var_6_0 = g.core.config.knight_base_info.fetch(self._player.show_knight_id)
		local var_6_1 = self._player.show_knight_dress or 0

		if var_6_1 > 0 then
			var_6_0 = g.core.config.knight_base_info.fetch(var_6_1)
		end

		if var_6_0 then
			local var_6_2 = {
				resId = var_6_0.painted_id
			}

			var_6_2.isShowBg = true
			self._showKnight = DrawKnight.new(var_6_2)

			self.m_showSpine:addChild(self._showKnight)
		end
	end
end

function NewSlgTeamPlayerInfoLayer:_updatePlayerInfo()
	self._player = var_0_4:getSnapShot(var_0_5.SNAP_SHOT_KEY.USER, self._uid)

	if self._player then
		self:_createShowSpine()
		self.m_userComp:updatePlayerContent(self._player)
		self.m_userComp:updateBtn()
		self.m_hasDataController:setSelectedIndex(1)
	end
end

function NewSlgTeamPlayerInfoLayer:_onCrossDayNotify()
	if not g.core.model.User.newSlgData:isOpen() then
		self:newScheduleOnce(function()
			g.core.module.ModuleManager:popToRoot()
		end)
	end
end

function NewSlgTeamPlayerInfoLayer:updateBtn()
	self.m_userComp:updateBtn()
end

function NewSlgTeamPlayerInfoLayer:_updateTeam()
	self.m_teamList:setNumItems((g.core.model.User.newSlgData:getMaxTeamCnt()))
end

function NewSlgTeamPlayerInfoLayer:_onAddRequestSuc()
	var_0_3:tip(g.core.lang:get(102517))
end

function NewSlgTeamPlayerInfoLayer:_onSynchronizeInfoEnd()
	var_0_3:tip(g.core.lang:get(102528))
	self:updateBtn()
end

function NewSlgTeamPlayerInfoLayer:_onDeleteSuc()
	var_0_3:tip(g.core.lang:get(102518))
	self:updateBtn()
end

function NewSlgTeamPlayerInfoLayer:_onBlackSuc()
	var_0_3:tip(g.core.lang:get(102519))
	self:updateBtn()
end

function NewSlgTeamPlayerInfoLayer:_onRenderListTeamCell(arg_16_1, arg_16_2)
	arg_16_2:updateTeamComp(self._teams[arg_16_1 + 1], arg_16_1 + 1)
end

return NewSlgTeamPlayerInfoLayer
