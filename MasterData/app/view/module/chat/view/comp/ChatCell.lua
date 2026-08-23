local var_0_0 = g.core.config.talk_show_info
local var_0_1 = g.core.config.guild_news_info
local var_0_2 = g.core.config.guild_right_info
local var_0_3 = {
	TEXT = 0,
	SHARE = 4,
	BIO_TEAM_BATTLE_ADD_FRIEND = 3,
	IMG = 1,
	INVITE = 2
}
local var_0_4 = g.core.const.ConstMgr.FormationConst
local var_0_5 = g.core.const.ConstMgr.ChatConst
local var_0_6 = g.core.utils.Black
local var_0_7 = g.core.model.User
local var_0_8 = g.core.common.Path
local var_0_9 = g.core.common.ServerTime
local var_0_10 = g.core.model.User.chatData
local ChatCell = class("ChatCell", require("app.fairyGUI.chat.UI_ChatLeftCell"))

function ChatCell:ctor(arg_1_1)
	self._runScheduler = nil
	self._isHasBlack = false
	self._chatProp = nil
	self._inviteId = nil
	self._uniqueId = nil
	self._params = nil
	self._data = nil
	self._translated = false
	self._translateAddHeight = 0
	self._EXTRA_HEIGHT = 9

	self:_addListener()

	if (g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION] and g.core.const.ConstMgr.PlatformConst.REGION_CFG[config.PUBLISH_REGION].HIDE_TRANSLATE_BTN or g.core.platform.PlatformProxy:isChannelOfChina()) and self.m_translateBtn then
		self.m_translateBtn:setVisible(false)
	end
end

function ChatCell:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_FURNITURE_ROOM_FRIENDGETINFO, self._onRecGetFriendFurnitureInfo, self)
end

function ChatCell:updateCell(arg_3_1)
	local var_3_0 = arg_3_1.data or {}

	self._inviteId = arg_3_1.data and arg_3_1.data.invite_id
	self._uniqueId = arg_3_1.data and arg_3_1.data.unique_id
	self._params = arg_3_1.data and arg_3_1.data.param1
	self._data = arg_3_1.data

	local var_3_1 = not not (self._data.channel == var_0_5.TROOPS and self._data.isBioTeamBattleAddFriend)
	local var_3_2 = var_3_0.user

	var_3_2.hideLevel = true

	self.m_userIcon:updateIcon(var_3_2)
	self.m_levelText:setText(g.core.lang:get(200017, {
		level = var_3_0.user.level
	}))

	local var_3_3 = var_3_0.user.name

	if var_0_10:isCrossServerChat(var_3_0.channel) then
		if var_3_0.user.id ~= var_0_7:getId() and var_3_0.user.guild_name and self._data.channel == var_0_5.GVE then
			var_3_3 = var_3_3 .. "(" .. var_3_0.user.server_name .. ")" .. var_3_0.user.guild_name
		end

		if var_3_0.args then
			var_3_0.look = var_3_0.args[1]
		end
	end

	self.m_nameText:setText(var_3_3)

	if var_0_10:isFriendCrossServer(var_3_2.sid or 0) then
		self.m_isCrossServerController:setSelectedIndex(1)
		self:_updateCrossServerChatView(var_3_0.user.server_name)
	else
		self.m_isCrossServerController:setSelectedIndex(0)
	end

	local var_3_4 = var_3_0.look
	local var_3_5 = false

	if var_3_0.look then
		var_3_4 = tonumber(var_3_4)

		if var_3_4 > 0 then
			var_3_5 = true
		end
	end

	local var_3_6 = 0

	if var_3_5 then
		self.m_stateController:setSelectedIndex(var_0_3.IMG)
		self.m_imgLoader:setURL((var_0_8:getEmojiGroupIcon(var_0_0.get(var_3_4).res)))
	elseif self._inviteId and self._inviteId ~= 0 then
		self:updateShareView(var_3_0)
	else
		self._translateAddHeight = 0

		self.m_stateController:setSelectedIndex(var_0_3.TEXT)

		self._isHasBlack = var_0_6:isMatchText(var_3_0.content)

		local var_3_7 = g.core.utils.String.splitString((var_0_6:filterBlack(var_3_0.content)))

		self.m_chatText:setWidth(250)
		self.m_chatText:setText(var_3_7, false, true)
		self.m_text2:setText(var_3_7, false, true)

		local var_3_8 = self.m_text2:getWidth()
		local var_3_9 = 0

		self._translated = false

		if not var_3_0.user or var_3_0.user.id ~= g.core.model.User:getId() then
			local var_3_10 = g.core.model.User.translateData:getChatTranslated(var_3_0)

			if var_3_10 then
				self._translated = true

				self.m_translateController:setSelectedIndex(1)
				self.m_chatTransText:setWidth(250)
				self.m_chatTransText:setText(var_3_10, false, true)
				self.m_text2:setText(var_3_10, false, true)

				var_3_9 = self.m_text2:getWidth()
				self._translateAddHeight = 8 + self.m_chatTransText:getHeight()
			else
				self.m_translateController:setSelectedIndex(0)
			end
		end

		var_3_6 = var_3_9 < var_3_8 and var_3_8 or var_3_9

		if var_3_6 < 250 then
			self.m_chatText:setWidth(math.ceil(var_3_6 + 4))
			self.m_clickBg:setWidth(var_3_6 + 20)
		else
			self.m_clickBg:setWidth(var_3_6 + 16)
		end
	end

	if var_3_1 then
		self.m_stateController:setSelectedIndex(var_0_3.BIO_TEAM_BATTLE_ADD_FRIEND)

		if var_3_6 < 250 then
			self.m_chatText:setWidth(math.ceil(var_3_6 + 4 + 100))
			self.m_clickBg:setWidth(var_3_6 + 20 + 100)
		else
			self.m_clickBg:setWidth(var_3_6 + 16 + 100)
		end
	end

	self:_resize()
end

function ChatCell:updateShareView(arg_4_1)
	if self._inviteId and self:_checkInvite() then
		self.m_stateController:setSelectedIndex(var_0_3.SHARE)
		self:setApplyBtnURLById()

		if self._inviteId == 2 or self._inviteId == 3 or self._inviteId == 27 then
			self.m_stateController:setSelectedIndex(var_0_3.INVITE)
			self:setBgURLById(1)
		elseif self._inviteId == 15 then
			self:setBgURLById(6)
		elseif self._inviteId == 9 or self._inviteId == 10 then
			self:setBgURLById(8)
		elseif self._inviteId == 8 then
			self:setBgURLById(7)
		elseif self._inviteId == 13 then
			self:setBgURLById(4)
		elseif self._inviteId == 5 or self._inviteId == 6 or self._inviteId == 14 or self._inviteId == 11 or self._inviteId == 12 then
			self:setBgURLById(2)
		elseif self._inviteId == 22 or self._inviteId == 23 then
			self:setBgURLById(6)
		elseif self._inviteId == 16 or self._inviteId == 17 then
			self:setBgURLById(7)
		elseif self._inviteId == 18 or self._inviteId == 19 then
			self:setBgURLById(7)
		elseif self._inviteId == 24 then
			self:setBgURLById(9)
		elseif self._inviteId == 25 or self._inviteId == 26 then
			self:setBgURLById(8)
		elseif self._inviteId == 38 or self._inviteId == 39 or self._inviteId == 40 then
			local var_4_1 = g.core.config.group_battle_map_info.get((tonumber(self._params)))

			self:setApplyBtnURLById(var_4_1.chat_bg)
			self:setBgURLById(var_4_1.chat_bg)
		elseif self._inviteId == 41 or self._inviteId == 42 or self._inviteId == 43 then
			self:setBgURLById(17)
		elseif self._inviteId == 44 or self._inviteId == 45 then
			self:setBgURLById(18)
		elseif self._inviteId == 46 or self._inviteId == 47 then
			self:setBgURLById(19)
		elseif self._inviteId >= 48 and self._inviteId <= 55 then
			self:setBgURLById(20)
		elseif self._inviteId >= 56 and self._inviteId <= 58 then
			self.m_bgLoader:setURL(g.core.model.User.anniversaryData:getActivityResource("ui_cocos", "pic_liaotian_zzbg21.png"))
			self:_updateAnniversaryShareCell(arg_4_1)

			return
		elseif self._inviteId == 59 or self._inviteId == 60 then
			self:setBgURLById(23)
		else
			self:setBgURLById(3)
		end

		self.m_inviteText:setText(arg_4_1.content, true)

		if arg_4_1.title then
			self.m_inviteTitle:setText(arg_4_1.title, true)
		end
	elseif arg_4_1.special_id and arg_4_1.special_id > 0 then
		local var_4_2 = g.core.utils.Table.convertListToMap(arg_4_1.special_params)

		var_4_2.time = var_0_9:getTimeStringHMS(arg_4_1.time or 0)

		if tonumber(var_4_2.position) then
			var_4_2.position = var_0_2.get(tonumber(var_4_2.position)).name
		end

		local var_4_3 = g.core.utils.String.dealMailStr(var_0_1.get(arg_4_1.special_id).news, var_4_2)
	end
end

function ChatCell:_updateCrossServerChatView(arg_5_1)
	if self.m_serverName then
		self.m_serverName:initRaceTextParams({
			scrollDirection = 1,
			moveType = 1,
			playMode = 2,
			pauseTime = 0.5,
			duration = 3,
			title = arg_5_1 or ""
		})

		local var_5_0 = self.m_serverName:getContainerSize()
		local var_5_1 = self.m_serverName:getTextSize()

		self.m_serverName:setTitleAlign("left")

		if var_5_1.width > var_5_0.width then
			self.m_serverName:setMoveDistance(var_5_1.width - var_5_0.width)
			self.m_serverName:setStartPos(cc.p(0, self.m_serverName:getTextPosition().y))
		end

		self.m_serverName:play()
	end
end

function ChatCell:setBgURLById(arg_6_1)
	if arg_6_1 >= 10 then
		self.m_bgLoader:setURL("ui://chat/pic_liaotian_zzbg" .. arg_6_1)
	else
		self.m_bgLoader:setURL("ui://chat/pic_liaotian_zzbg0" .. arg_6_1)
	end
end

function ChatCell:setApplyBtnURLById(arg_7_1)
	if not arg_7_1 then
		self.m_applyBtn:setIcon("ui://chat/btn_liaotian_zhuzhan")

		return
	end

	if arg_7_1 >= 10 then
		self.m_applyBtn:setIcon("ui://chat/btn_liaotian_zhuzhan" .. arg_7_1)
	else
		self.m_applyBtn:setIcon("ui://chat/btn_liaotian_zhuzhan0" .. arg_7_1)
	end
end

function ChatCell:_checkInvite()
	return self._inviteId == 2 or self._inviteId == 3 or self._inviteId >= 5 and self._inviteId <= 8 or self._inviteId == 13 or self._inviteId == 14 or self._inviteId == 15 or self._inviteId == 11 or self._inviteId == 12 or self._inviteId == 22 or self._inviteId == 23 or self._inviteId == 16 or self._inviteId == 17 or self._inviteId == 9 or self._inviteId == 10 or self._inviteId == 18 or self._inviteId == 19 or self._inviteId == 24 or self._inviteId == 25 or self._inviteId == 26 or self._inviteId >= 27 and self._inviteId <= 34 or self._inviteId >= 36 and self._inviteId <= 58 or self._inviteId == 59 or self._inviteId == 60
end

function ChatCell:_addListener()
	self.m_clickBg:addClickListener(handler(self, self._onClickBg))
	self.m_bgLoader:addClickListener(handler(self, self._onClickLink))

	if self.m_translateBtn then
		self.m_translateBtn:addClickListener(handler(self, self._onTranslateClick))
	end
end

function ChatCell:_onTranslateClick()
	if self._translated then
		g.core.module.ModuleManager:tip(g.core.lang:get(2503))

		return
	end

	if self.m_translateBtn.clickTime and os.time() - self.m_translateBtn.clickTime < 2 then
		g.core.module.ModuleManager:tip(g.core.lang:get(2502))

		return
	end

	self.m_translateBtn.clickTime = os.time()

	g.core.module.ModuleManager:tip(g.core.lang:get(2500))
	g.core.model.User.translateData:onTranslateChat(self._data)
end

function ChatCell:_resize()
	local var_11_0 = self.m_stateController:getSelectedIndex()
	local var_11_1 = self:getHeight()
	local var_11_2

	if var_11_0 == var_0_3.TEXT or var_11_0 == var_0_3.BIO_TEAM_BATTLE_ADD_FRIEND then
		var_11_2 = self.m_chatText
	elseif var_11_0 == var_0_3.IMG then
		var_11_2 = self.m_imgLoader
	elseif var_11_0 == var_0_3.INVITE or var_11_0 == var_0_3.SHARE then
		var_11_2 = self.m_applyBtn
	end

	local var_11_3 = var_11_2:getPosition()
	local var_11_4 = var_11_2:getHeight()

	var_11_4 = var_11_4 > 32 and var_11_4 or 32

	local var_11_5 = var_11_3.y + var_11_4 + self._EXTRA_HEIGHT + self._translateAddHeight

	self.m_heightBg:setHeight(var_11_3.y + var_11_4 + self._EXTRA_HEIGHT + self._translateAddHeight)
	self.m_clickBg:setHeight(var_11_5 - 37)
end

function ChatCell:_onRecGetFriendFurnitureInfo(arg_12_1, arg_12_2)
	local var_12_0 = g.core.module.ModuleManager:getCurModule()

	if var_12_0 and var_12_0.module ~= g.view.entrance.FRIEND_FURNITURE and arg_12_2 and arg_12_2.friend_id then
		g.core.module.ModuleManager:pushModule(g.view.entrance.FRIEND_FURNITURE, {
			friendId = arg_12_2.friend_id
		})
	end
end

function ChatCell:_onClickLink()
	if g.core.battle.BattleProxy:isInBattle() then
		g.core.module.ModuleManager:tip(g.core.lang:get(109040))

		return
	end

	if g.core.module.ModuleManager:isExistModule(g.view.entrance.PUZZLE_GAME) then
		local var_13_0 = fgui.GComponent:create()

		g.core.layer.LayerManager:getModuleLoadingLayer():addChild(var_13_0)

		local var_13_1 = fgui.UIPackage:createObject("base_new", "BaseTxtTipInfoComp")

		var_13_0:addChild(var_13_1)
		var_13_1:init((g.core.lang:get(2601)))

		return
	end

	if self._inviteId == 15 then
		if g.core.model.User.guildData:hasGuild() then
			g.core.module.ModuleManager:tip(g.core.lang:get(109041))
		else
			local var_13_2 = g.core.model.User:getUserData().join_guild_limit

			var_13_2 = var_13_2 or 0

			if var_13_2 > g.core.common.ServerTime:getTime() then
				g.core.module.ModuleManager:tip(g.core.lang:get(109042, {
					time = g.core.common.ServerTime:getLeftDHMSFormat(var_13_2)
				}))
			elseif g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.GUILD) then
				g.core.network.GameNetProxy:send_C2S_Guild_ReqJoin({
					guild_id = self._uniqueId
				})
			end
		end
	elseif self._inviteId == 2 or self._inviteId == 3 or self._inviteId == 27 then
		if g.core.model.User.bioData:getTeamInfo().id ~= 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(109044))

			return
		end

		local var_13_3, var_13_4 = g.core.model.User.bioData:isCampainOpen(tonumber(self._params))
		local var_13_5

		if not var_13_3 then
			g.core.module.ModuleManager:tip(var_13_4)

			do return end

			var_13_5 = require("app.view.base.component.BaseTxtPopComp").new
		end

		self:addPopup((require("app.view.base.component.BaseTxtPopComp").new({
			text = g.core.lang:get(109045),
			handler_ok = handler(self, function()
				g.core.network.GameNetProxy:send_C2S_Biography_JoinTeam({
					id = tonumber(self._params),
					teamId = self._uniqueId
				})
			end)
		})))
	elseif self._inviteId == 38 or self._inviteId == 39 or self._inviteId == 40 then
		local var_13_6 = g.core.model.User.teamPvpData:getTeamInfo()

		if var_13_6 and var_13_6.id ~= 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(109044))

			return
		end

		if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.TEAM_PVP, nil) then
			return
		end

		local var_13_7 = self._uniqueId

		self:addPopup((require("app.view.base.component.BaseTxtPopComp").new({
			text = g.core.lang:get(109045),
			handler_ok = function()
				g.core.network.GameNetProxy:send_C2S_GroupBattle_JoinRoom({
					room_id = var_13_7
				})
			end
		})))
	elseif self._inviteId ~= 5 and self._inviteId ~= 6 then
		if self._inviteId == 28 then
			g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT_REWARD, {
				justShowResult = true,
				isShare = true,
				recruit_type = 2,
				awards = self._data.share.recruit_awards,
				num = #self._data.share.recruit_awards
			})
		elseif self._inviteId == 7 or self._inviteId == 8 or self._inviteId == 29 then
			if g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.HOME_LAND_FURNITURE, nil, true) then
				if self._data.share.id ~= g.core.model.User:getId() then
					local var_13_8 = tonumber(g.core.common.ServerTime:getTime())

					if var_13_8 - g.core.model.User.friendData:getFriendRoomConnectTime() >= 3 then
						g.core.network.GameNetProxy:send_C2S_FurnitureRoom_FriendGetInfo({
							friend_id = self._data.share.id
						})
						g.core.model.User.friendData:setFriendRoomConnectTime(var_13_8)
					else
						g.core.module.ModuleManager:tip(g.core.lang:get(309184))
					end
				else
					local var_13_9 = g.core.module.ModuleManager:getCurModule()

					if var_13_9 and var_13_9.module ~= g.view.entrance.FURNITURE then
						g.core.module.ModuleManager:pushModule(g.view.entrance.FURNITURE)
					end
				end
			end
		elseif self._inviteId ~= 9 and self._inviteId ~= 10 then
			if self._inviteId == 30 then
				g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT_ARTIFACT_REWARD, {
					justShowResult = true,
					isShare = true,
					recruit_type = 2,
					awards = self._data.share.recruit_awards,
					num = #self._data.share.recruit_awards
				})
			elseif self._inviteId ~= 11 and self._inviteId ~= 12 then
				if self._inviteId == 31 then
					local var_13_10 = {
						isShare = true,
						awards = self._data.share.recruit_awards
					}

					var_13_10.recruit_type = g.core.const.ConstMgr.RecruitConst.RECRUIT_TYPE.UNITE_TOKEN_NORMAL
					var_13_10.num = #self._data.share.recruit_awards
					var_13_10.param1 = self._data.param1

					if self._data.share.id then
						var_13_10.recruit_type = self._data.share.id
					end

					g.core.module.ModuleManager:pushPopup(require("app.view.module.recruit.view.uniteToken.RecruitUniteTokenRewardPop").new(var_13_10))
				elseif self._inviteId == 13 or self._inviteId == 14 or self._inviteId == 32 then
					local AutoButtonConst = require("app.view.common.const.AutoButtonConst")
					local var_13_12 = AutoButtonConst.getButtonCfg(AutoButtonConst.ButtonConstCfg.LINE_UP)

					if self._data.param2 == var_0_4.SHARE_IS_PRESET and self._data.user.id ~= g.core.model.User:getId() then
						if self._data.share.preset_formation_info and self._data.share.preset_formation_info ~= "" then
							var_13_12.callback(self._data, self._data.share.preset_formation_info)
						else
							g.core.network.GameNetProxy:send_C2S_GetChatShare({
								share_type = g.core.network.proto.CST_PRESET_FORMATION,
								own_id = self._data.user.id,
								id = self._data.share.id
							})
						end
					else
						var_13_12.callback(self._data)
					end
				elseif self._inviteId == 22 or self._inviteId == 23 or self._inviteId == 36 then
					g.core.module.ModuleManager:pushModule(g.view.entrance.EASTEREGG_LAYER, {
						isFromShare = true,
						eggId = self._uniqueId,
						interactionId = tonumber(self._params),
						uid = self._data.share.id
					})
				elseif self._inviteId == 16 or self._inviteId == 17 or self._inviteId == 33 then
					g.core.module.ModuleManager:pushModule(g.view.entrance.PUZZLE_GAME, {
						isShare = true,
						isRepeatModel = true,
						level = tonumber(self._params),
						missionid = self._uniqueId
					})
				elseif self._inviteId ~= 18 and self._inviteId ~= 19 then
					if self._inviteId == 34 then
						local var_13_13 = require("app.view.module.touchGame.view.TouchGameLayer").new

						g.core.module.ModuleManager:pushPopup((require("app.view.module.touchGame.view.TouchGameLayer").new({
							isShare = true,
							missionId = tonumber(self._params),
							gameId = self._uniqueId
						})))
					elseif self._inviteId == 24 then
						if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.GVE) then
							g.core.module.ModuleManager:tip(g.core.lang:get(309203))

							return
						end

						if not g.core.model.User.gveDataMgr:isOpenChat() then
							g.core.module.ModuleManager:tip(g.core.lang:get(309164))

							return
						end

						local var_13_14 = string.split(self._data.param2, "_")
						local var_13_15 = cc.p(tonumber(var_13_14[1]), tonumber(var_13_14[2]))
						local var_13_16 = {
							jumpPos = cc.p(var_13_15.x, var_13_15.y)
						}

						if g.core.module.ModuleManager:getPreModuleName() ~= "GveGameStage" then
							g.core.module.ModuleManager:pushModule(g.view.entrance.GVE_GAME_STAGE, var_13_16)
						else
							g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GVE_GOTO_TARGET_POS, false, var_13_16.jumpPos)
						end
					elseif self._inviteId ~= 25 and self._inviteId ~= 26 then
						if self._inviteId == 37 then
							g.core.module.ModuleManager:pushModule(g.view.entrance.RECRUIT_PET_REWARD, {
								justShowResult = true,
								isShare = true,
								recruit_type = 2,
								awards = self._data.share.recruit_awards,
								num = #self._data.share.recruit_awards
							})
						elseif self._inviteId == 41 or self._inviteId == 42 or self._inviteId == 43 then
							if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.BOUNTY) then
								return
							end

							if g.core.model.User.bountyData:getCurStage() ~= g.core.const.ConstMgr.BountyConst.ACTIVITY_STATE.OPEN then
								g.core.module.ModuleManager:tip(g.core.lang:get(422035))

								return
							end

							local var_13_17

							if self._data.user.id == g.core.model.User:getId() then
								g.core.module.ModuleManager:tip(g.core.lang:get(422036))

								do return end

								var_13_17 = {
									id = self._uniqueId
								}
							end

							var_13_17.share_type = g.core.const.ConstMgr.BountyConst.INVITE_ID[self._inviteId]

							g.core.network.GameNetProxy:send_C2S_Bounty_GetMonsterInfo(var_13_17)
						elseif self._inviteId == 44 or self._inviteId == 45 then
							if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.TEAM_BATTLE) then
								return
							end

							local var_13_18 = g.core.model.User.teamBattleData

							if not g.core.model.User.teamBattleData:isActivityOpen() then
								g.core.module.ModuleManager:tip(g.core.lang:get(307536))

								return
							end

							local var_13_19 = string.split(self._data.param2 or "", ";")
							local var_13_20 = tonumber(var_13_19[1])
							local var_13_21 = var_13_18:getTeamUpData():getMyTeamId()

							if var_13_21 > 0 then
								if var_13_21 == var_13_20 then
									if var_13_18:getTeamUpData():getMyTeam().ready then
										g.core.module.ModuleManager:tip(g.core.lang:get(427013))
									else
										self:dispatchCompEvent("ChatCell_Goto_TeamBattleTeam")
									end
								else
									g.core.module.ModuleManager:tip(g.core.lang:get(427101))
								end

								return
							end

							if (tonumber(var_13_19[2]) or 999) > var_0_7:getLevel() then
								g.core.module.ModuleManager:tip(g.core.lang:get(427102))

								return
							end

							g.core.network.GameNetProxy:send_C2S_TeamBattle_JoinTeam({
								team_id = var_13_20
							})
						elseif self._inviteId == 46 or self._inviteId == 47 then
							g.core.module.ModuleManager:pushPopup(require("app.view.module.alliance.view.pop.AllianceInfoPop").new({
								allianceId = self._uniqueId
							}), {
								touchDisappear = true
							})
						elseif self._inviteId == 48 or self._inviteId == 49 then
							if not g.core.common.ModuleUnlock:checkModuleUnlockStatus(g.core.const.ConstMgr.FUNCTION_TYPE.NEW_SLG) then
								return
							end

							if not g.core.model.User.newSlgData:isPlaying() then
								g.core.module.ModuleManager:tip(g.core.lang:get(307536))

								return
							end

							local var_13_22 = string.split(self._data.param2 or "", ";")

							g.core.utils.Tools.newSlgFunc.clickBossInvite({
								teamId = tonumber(var_13_22[2]),
								bossId = tonumber(var_13_22[1]),
								createTime = tonumber(var_13_22[3])
							})
						elseif self._inviteId >= 50 and self._inviteId <= 55 then
							local var_13_24 = string.split(self._data.param2 or "", ";")
							local var_13_25 = tonumber(var_13_24[1])
							local var_13_26 = tonumber(var_13_24[2])

							if g.core.module.ModuleManager:isCurModule(g.view.entrance.NEW_SLG_MAIN) then
								g.core.event.EventManager:dispatchEvent(g.core.const.ConstMgr.NewSlgConst.GOTO_SHARE_POS, false, cc.p(var_13_25, var_13_26))
							else
								g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_MAIN, {
									route1 = cc.p(var_13_25, var_13_26)
								})
							end
						elseif self._inviteId >= 56 and self._inviteId <= 58 then
							if not g.core.model.User.anniversaryData:isActivityOpen() then
								g.core.module.ModuleManager:tip(g.core.lang:get(307536))

								return
							end

							if g.core.model.User.anniversaryData:getCurStage() == g.core.const.ConstMgr.AnniversaryConst.STAGE.SHOW then
								g.core.module.ModuleManager:tip(g.core.lang:get(431661))

								return
							end

							local var_13_27 = string.split(self._data.param2 or "", ";")
							local var_13_28 = tonumber(var_13_27[1])
							local var_13_29 = tonumber(var_13_27[2])
							local var_13_30 = tonumber(var_13_27[3])

							if var_13_28 == g.core.model.User:getId() then
								return
							end

							if g.core.model.User.anniversaryData:getTodayShareAwardMaxNum() - g.core.model.User.anniversaryData:getShareAwardTimes() <= 0 then
								g.core.module.ModuleManager:tip(g.core.lang:get(431658))

								return
							end

							if not g.core.model.User.anniversaryData:isGetSharejigsaw(var_13_28, var_13_29, var_13_30) then
								g.core.network.GameNetProxy:send_C2S_Anniversary_GetShareJigsaw({
									uid = var_13_28,
									item_id = var_13_29,
									time = var_13_30
								})
							end
						elseif self._inviteId == 59 or self._inviteId == 60 then
							if not g.core.model.User.ancientsData:isTimeToOpen() then
								g.core.module.ModuleManager:tip(g.core.lang:get(307536))

								return
							end

							if g.core.model.User.ancientsData:getTeam(g.core.const.ConstMgr.AncientsConst.GET_TEAM_TYPE.CURRENT_TEAM) == nil then
								g.core.network.GameNetProxy:send_C2S_Ancient_ReqJoin({
									team_id = tonumber(self._params)
								})
							else
								g.core.module.ModuleManager:tip(g.core.lang:get(433367))
							end
						end
					end
				end
			end
		end
	end
end

function ChatCell:_updateAnniversaryShareCell(arg_16_1)
	local var_16_1 = string.split(arg_16_1.param2 or "", ";")
	local var_16_2 = tonumber(var_16_1[1])

	self.m_inviteText:setText(arg_16_1.content, true)

	if var_16_2 == g.core.model.User:getId() then
		self.m_inviteTitle:setText("", true)
	elseif not g.core.model.User.anniversaryData:isGetSharejigsaw(var_16_2, tonumber(var_16_1[2]), (tonumber(var_16_1[3]))) then
		if arg_16_1.title then
			self.m_inviteTitle:setText(arg_16_1.title, true)
		end
	else
		self.m_inviteTitle:setText(g.core.lang:get(111901), true)
	end
end

function ChatCell:_onClickBg()
	if self._data and self._data.share then
		if self._data.share.share_type == 1 then
			g.core.network.GameNetProxy:send_C2S_GetChatShare({
				share_type = 1,
				own_id = self._data.share.battle_res_share_title.own_id,
				id = self._data.share.id
			})
		end
	end
end

return ChatCell
