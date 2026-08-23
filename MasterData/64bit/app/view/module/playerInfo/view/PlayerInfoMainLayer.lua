local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_1 = g.core.model.User.friendData
local DrawKnight = require("app.view.common.DrawKnight")
local var_0_3 = g.core.model.User
local var_0_4 = g.core.model.User.playerInfoData
local var_0_5 = g.core.event.EventManager
local var_0_6 = g.core.event.enum
local var_0_7 = g.core.module.ModuleManager
local PlayerInfoMainLayer = class("PlayerInfoMainLayer", require("app.fairyGUI.playerInfo.UI_PlayerInfoMainLayer"), function()
	return fgui.GComponent:create({
		pkgName = "playerInfo",
		isFullScreen = true,
		pkgPath = "ui/playerInfo/playerInfo",
		resName = "PlayerInfoMainLayer"
	}, ...)
end)

function PlayerInfoMainLayer:ctor(arg_2_1)
	self._uid = arg_2_1.uid or var_0_3:getId()
	self._showKnight = nil
	self._playerInfo = nil
	self._isNeedUpdate = arg_2_1.isUpdate or false
	self._isSelf = arg_2_1.isSelf or false

	if self._uid == var_0_3:getId() then
		self._isSelf = true
	end

	if arg_2_1.disableJump then
		self.m_topBar:hideHomeBtn()
		self.m_userComp:setDisableJump()
	end

	self:initView()
end

function PlayerInfoMainLayer:initView()
	self:addBg("bg/playerInfo/bg_personal_info.jpg")

	if not self._isSelf then
		g.core.network.GameNetProxy:send_C2S_NotifyUserViewDetail({
			target_user_id = self._uid
		})
	end
end

function PlayerInfoMainLayer:onLoad()
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_GET_USER_DETAIL_INFO, handler(self, self._onSynchronizePlayerInfo), self)
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_FURNITURE_ROOM_FRIENDGETINFO, self._onRecGetFriendFurnitureInfo, self)
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_FRIEND_ADDFRIEND, handler(self, self._onAddRequestSuc), self)
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_FRIEND_DELFRIEND, handler(self, self._onDeleteSuc), self)
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_FRIEND_ADDBLACKLIST, handler(self, self._onBlackSuc), self)
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_FRIEND_DUEL, self._onDuel, self)
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_FRIEND_NOTIFYADDFRIEND, handler(self, self._onSynchronizeInfoEnd), self)
	var_0_5:addEventListener(var_0_6.EVENT_NET_S2C_ARENA_GETMAININFO, self._onArenaGetMainInfo, self)

	if self._isSelf then
		self:updateView()
	else
		self._playerInfo = var_0_1:getPlayerInfo()

		if self._isNeedUpdate or not self._playerInfo.user or self._playerInfo.user.id ~= self._uid then
			g.core.network.GameNetProxy:send_C2S_GetUserDetailInfo({
				tp = 0,
				player_id = self._uid
			})

			self._playerInfo = nil

			self.m_hasDataController:setSelectedIndex(0)
		else
			self:updateView()
		end
	end
end

function g.core.model.User.playerInfoData:setDisableJump(arg_5_1)
	self.m_userComp:setDisableJump(arg_5_1)
end

function PlayerInfoMainLayer:_onSynchronizePlayerInfo()
	self._playerInfo = var_0_1:getPlayerInfo()

	self:updateView()
end

function PlayerInfoMainLayer:_createShowSpine()
	if self._showKnight == nil then
		local var_7_0 = self._isSelf and var_0_3:getAssistantResInfo() or var_0_4:getAssistantResInfo()

		if var_7_0 then
			local var_7_1 = {
				resId = var_7_0.painted_id
			}

			var_7_1.isShowBg = true
			self._showKnight = DrawKnight.new(var_7_1)

			self.m_showSpine:addChild(self._showKnight)
		end
	end
end

function PlayerInfoMainLayer:updateView()
	self.m_hasDataController:setSelectedIndex(1)
	self:_createShowSpine()
	self:updatePlayerContent()
	self:updateShowComp()
	self:updatePlayerProgress()
	self:updateTissueList()
	self:updateBtn()
end

function PlayerInfoMainLayer:updatePlayerContent()
	self.m_userComp:updatePlayerContent(self._isSelf, self._uid, self._playerInfo)
end

function PlayerInfoMainLayer:updateBtn()
	self.m_userComp:updateBtn()
end

function PlayerInfoMainLayer:updatePlayerProgress()
	self.m_bottomComp:updatePlayerProgress(self._isSelf)
end

function PlayerInfoMainLayer:_onArenaGetMainInfo()
	self.m_bottomComp:updateArenaRank((g.core.model.User.arenaData:getRank()))
end

function PlayerInfoMainLayer:updateTissueList()
	self.m_bottomComp:updateTissueList()
end

function PlayerInfoMainLayer:updateShowComp()
	local var_14_1 = self._isSelf and g.core.model.User.uniteTokenData:getLineupTokenList() or self._playerInfo.formationData.unitTokenData

	self.m_showComp:getChild("uniteShowComp"):updateUniteComp(self._playerInfo, self._isSelf)

	local var_14_2 = {}
	local var_14_3
	local var_14_4 = {}

	if not self._isSelf then
		var_14_2 = self._playerInfo.formationData.knightStructArr
		var_14_3 = self._playerInfo.formationData.matchInfos
		var_14_4 = self._playerInfo.vow_knights or {}
	end

	self.m_showComp:getChild("knightShowComp"):updateKnightComp(var_14_2, var_14_3, self._isSelf, var_14_4)
	self.m_showComp:getChild("titleShowComp"):updateTitleComp(self._isSelf)

	local var_14_5 = {}

	if self._isSelf then
		for iter_14_0, iter_14_1 in pairs((var_0_3.petsData:getLineupSidDict())) do
			if iter_14_1 > 0 then
				var_14_5 = true
			end
		end
	else
		var_14_5 = #self._playerInfo.formationData.pets > 0
	end

	if var_14_5 then
		self.m_isShowPetController:setSelectedIndex(1)
		self.m_showComp:getChild("petShowComp"):updatePetByStructList(self._playerInfo, self._isSelf)

		if not self.m_enter_1Transition:isPlaying() then
			self.m_enter_1Transition:play()
		end
	else
		self.m_isShowPetController:setSelectedIndex(0)

		if not self.m_enterTransition:isPlaying() then
			self.m_enterTransition:play()
		end
	end
end

function PlayerInfoMainLayer:_onRecGetFriendFurnitureInfo(arg_15_1, arg_15_2)
	local var_15_0 = var_0_7:getCurModule()

	if var_15_0 and var_15_0.module ~= g.view.entrance.FRIEND_FURNITURE and arg_15_2 and arg_15_2.friend_id then
		var_0_7:pushModule(g.view.entrance.FRIEND_FURNITURE, {
			friendId = arg_15_2.friend_id
		})
	end
end

function PlayerInfoMainLayer:_onAddRequestSuc()
	var_0_7:tip(g.core.lang:get(102517))
end

function PlayerInfoMainLayer:_onSynchronizeInfoEnd()
	var_0_7:tip(g.core.lang:get(102528))
	self:updateBtn()
end

function PlayerInfoMainLayer:_onDeleteSuc()
	var_0_7:tip(g.core.lang:get(102518))
	self:updateBtn()
end

function PlayerInfoMainLayer:_onBlackSuc()
	var_0_7:tip(g.core.lang:get(102519))
	self:updateBtn()
end

function PlayerInfoMainLayer:_onDuel(arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = {}

	var_20_0.battle_id = 0
	var_20_0.atk_type = 2
	var_20_0.is_auto = false
	var_20_0.random_seeds = {}

	for iter_20_0 = 1, 50 do
		var_20_0.random_seeds[iter_20_0] = math.random(1000) - 1
	end

	var_20_0.own_teams = {
		arg_20_3.self
	}
	var_20_0.enemy_teams = {
		arg_20_3.enemy
	}

	g.core.battle.BattleProxy:enterBattle({
		soundType = 2,
		noShare = true,
		report = var_20_0,
		type = BattleConst.TYPE_FRIEND_PVP,
		battleType = BattleConst.BATTLE_TYPE.PVP,
		skip = BattleConst.SKIP_TYPE.ACTIVE
	})
end

return PlayerInfoMainLayer
