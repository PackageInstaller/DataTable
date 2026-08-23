local var_0_0 = g.core.config.knight_info
local var_0_1 = g.core.config.knight_base_info
local BattleKnight = require("app.view.battle.BattleKnight")
local var_0_3 = g.core.const.ConstMgr.AllianceConst
local var_0_4 = g.core.model.User.allianceData
local var_0_5 = g.core.const.ConstMgr.SnapShotCacheConst
local var_0_6 = g.core.model.User.snapShotCacheData
local AllianceHonourMainLayer = class("AllianceHonourMainLayer", require("app.fairyGUI.alliance.UI_AllianceHonourMainLayer"), function()
	return fgui.GComponent:create({
		resName = "AllianceHonourMainLayer",
		pkgPath = "ui/alliance/alliance",
		isFullScreen = true,
		pkgName = "alliance"
	}, ...)
end)

function AllianceHonourMainLayer:ctor()
	self._lastBubbleTime = 0
	self._showIndex = 1
	self._maxLen = 0
	self._curShowId = 0
	self._curHonourTypeData = nil

	self:initView()
end

function AllianceHonourMainLayer:initView()
	self:addBg("bg/alliance/bg_ghlm_datingi_taizi_di.jpg")
	self.m_leftBtn:addClickListener(handler(self, self._onClickLeftBtn))
	self.m_rightBtn:addClickListener(handler(self, self._onClickRightBtn))
	self.m_topBar:setResInfoById(348, true)
end

function AllianceHonourMainLayer:_onClickLeftBtn()
	self._showIndex = self._showIndex - 1

	if self._showIndex < 1 then
		self._showIndex = self._maxLen
	end

	self:updateView()
	self.m_left_InTransition:play()
	self.m_likeBtn:clearBubbleEff()
end

function AllianceHonourMainLayer:_onClickRightBtn()
	self._showIndex = self._showIndex + 1

	if self._showIndex > self._maxLen then
		self._showIndex = 1
	end

	self:updateView()
	self.m_right_InTransition:play()
	self.m_likeBtn:clearBubbleEff()
end

function AllianceHonourMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._updateShowUser), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GUILD_ALLIANCE_HONOURSENDLIKE, handler(self, self._onS2CSendLike), self)

	if var_0_4:getParams(var_0_3.PARAMETER.HONOUR_END) * 3600 <= g.core.common.ServerTime:secondsFromToday() then
		self:newScheduleOnce(handler(self, self._onClickClose))
	else
		self:_onS2CGetInfo()
	end

	self.m_enterTransition:play()
end

function AllianceHonourMainLayer:onScheduleTimeEnd()
	if var_0_4:getParams(var_0_3.PARAMETER.HONOUR_END) * 3600 <= g.core.common.ServerTime:secondsFromToday() then
		self:_onClickClose()
	end
end

function AllianceHonourMainLayer:_onClickClose()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function AllianceHonourMainLayer:updateView()
	self.m_bubbleRoot:clearBubble()

	self._curHonourTypeData = var_0_4:getHonourByIndex(self._showIndex)

	if self._curHonourTypeData then
		self:_updateShowUser()
		self:_updateShowView()
	end
end

function AllianceHonourMainLayer:_updateShowUser()
	local var_10_0 = var_0_6:getSnapShot(var_0_5.SNAP_SHOT_KEY.USER, self._curHonourTypeData.honourData.uid)

	if var_10_0 then
		self.m_userIcon:updateAsUser(var_10_0)
		self.m_userName:setText(var_10_0.name)
		self.m_serverName:setText(var_10_0.server_name)
		self.m_guildName:setText(var_10_0.guild_name)
		self.m_fightValue:setText(var_10_0.fight_value)
		self.m_showDesc:setTitle(g.core.lang:getByString(var_0_4:getHonourInfo(self._curHonourTypeData).des, {
			name = var_10_0.name
		}))

		local var_10_2 = var_10_0.skin and var_10_0.skin > 0 and var_0_1.get(g.core.config.skin_info.get(var_10_0.skin).res) or var_0_1.get(var_0_0.get(var_10_0.base_id).res_id)

		if self._curShowId ~= var_10_0.id then
			self._curShowId = var_10_0.id

			if self._showKnight then
				self._showKnight:removeFromParent()

				self._showKnight = nil
			end

			if self._scheduleId then
				self:cancelSchedule(self._scheduleId)

				self._scheduleId = nil
			end
		end

		if not self._showKnight then
			self._showKnight = BattleKnight.new((g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot(var_10_0)))

			self.m_showKnight:addNode(self._showKnight)

			self._scheduleId = self:newScheduleOnce(handler(self, self._scheduleKnightAction), 0.5)
		end
	end
end

function AllianceHonourMainLayer:_scheduleKnightAction()
	self._scheduleId = nil

	if self._showKnight then
		self._showKnight:setAnimation(0, "show", false)
		self._showKnight:addAnimation(0, "idle", true)
	end
end

function AllianceHonourMainLayer:_onS2CGetInfo(arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	self._maxLen = #var_0_4:getHonorList()

	self:updateView()
end

function AllianceHonourMainLayer:_onS2CSendLike(arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if arg_13_4.awards then
		self.m_likeBtn:playEffect("reward", arg_13_4.awards)
	else
		self.m_likeBtn:playEffect("like")
	end

	self:_updateShowView()
end

function AllianceHonourMainLayer:_updateShowView()
	local var_14_0 = var_0_4:getHonourInfo(self._curHonourTypeData)

	if var_14_0 then
		self.m_showTitle:setText(var_14_0.name)
		self.m_likeBtn:updateComp(self._curHonourTypeData, var_14_0)
		self.m_showBottom:setURL(g.core.common.Path:getAllianceHonourBg(var_14_0.base_display))

		for iter_14_0 = 1, var_14_0.text_num do
			self.m_bubbleRoot:addBubble(var_14_0.text_group, math.random(0, var_14_0.text_num))
		end
	end
end

function AllianceHonourMainLayer:receiveCompEvent(arg_15_1, arg_15_2)
	if arg_15_1 == "show_honour_next" then
		if self._showIndex < self._maxLen then
			self:_onClickRightBtn()
		end
	elseif arg_15_1 == "click_like_btn" then
		local var_15_0 = g.core.common.ServerTime:getTime()

		if var_15_0 - self._lastBubbleTime > 0.5 then
			self._lastBubbleTime = var_15_0

			self.m_likeBtn:playBubbleEffect()
		end
	elseif arg_15_1 == "need_add_bubble" then
		self.m_bubbleRoot:addSelfBubble(var_0_4:getHonourInfo(self._curHonourTypeData).text_group)
	end
end

return AllianceHonourMainLayer
