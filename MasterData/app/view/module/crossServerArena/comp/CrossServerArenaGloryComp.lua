local var_0_0 = g.core.model.User.crossServerArenaData
local var_0_1 = g.core.const.ConstMgr.CrossServerArenaConst
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.config.knight_info
local var_0_4 = g.core.config.knight_base_info
local var_0_5 = g.core.config.dress_info
local var_0_6 = g.core.config.avata_info
local var_0_7 = g.core.config.avatar_frame_info
local CrossServerArenaGloryComp = class("CrossServerArenaGloryComp", require("app.fairyGUI.crossServerArena.UI_CrossServerArenaGloryComp"))

function CrossServerArenaGloryComp:ctor()
	self.m_rewardBtn:addClickListener(handler(self, self._onClickRewardBtn))

	self._rank = self.m_rankController:getSelectedIndex()
end

function CrossServerArenaGloryComp:updateGloryComp(arg_2_1)
	if not arg_2_1.user then
		self.m_nameTxt:setText(g.core.lang:get(411030))
		self.m_hasMemberController:setSelectedIndex(0)

		return
	end

	self.m_hasMemberController:setSelectedIndex(1)
	self.m_nameTxt:setText(arg_2_1.user.name)
	self.m_rankTxt:setText(arg_2_1.rank)
	self.m_scoreTxt:setText(var_0_0:getRankScoreByRank(arg_2_1.rank))
	self:_updateMemberAvatarAndFrame(arg_2_1.user)
	self:_updateAnim(arg_2_1.hasReceived)
end

function CrossServerArenaGloryComp:_updateMemberAvatarAndFrame(arg_3_1)
	local var_3_1 = var_0_3.get(arg_3_1.base_id or 210000)
	local var_3_2 = var_0_4.get(var_3_1.res_id)
	local var_3_3 = ((arg_3_1.skin and arg_3_1.skin > 0 and arg_3_1.skin_ts and (arg_3_1.skin_ts == 0 or arg_3_1.skin_ts > g.core.common.ServerTime:getTime()) or nil) and var_0_4.get(g.core.config.skin_info.get(arg_3_1.skin).res)).icon_id
	local var_3_4 = 0

	if arg_3_1.dress_id and arg_3_1.dress_id ~= 0 then
		var_3_4 = var_3_1.sex
		var_3_3 = var_0_4.get((var_3_1.sex == 0 or nil) and var_0_5.get(arg_3_1.dress_id).woman_res_id).icon_id
	end

	local var_3_7 = false
	local var_3_8 = arg_3_1.avata_id or 0

	if var_3_8 == 200000 or var_3_8 == 210000 then
		var_3_7 = true
		var_3_3 = var_3_8
	end

	if var_3_8 > 0 and not var_3_7 then
		local var_3_9 = var_0_6.get(var_3_8)
		local var_3_10 = string.split(var_3_9.res, ",")

		if #var_3_10 > 1 then
			local var_3_11 = {}

			for iter_3_0, iter_3_1 in ipairs(var_3_10) do
				local var_3_12 = string.split(iter_3_1, "_")

				var_3_11[var_3_12[1]] = var_3_12[2]
			end

			self.m_iconLoader:setURL(var_0_2:getRoleHeadIcon(var_3_11[tostring(var_3_4)]))
		else
			self.m_iconLoader:setURL(var_0_2:getRoleHeadIcon(var_3_9.res))
		end
	else
		self.m_iconLoader:setURL(var_0_2:getKnightIconById(var_3_3))
	end

	self.m_frameLoader:setVisible(false)
	self.m_effHolder:setVisible(false)

	if arg_3_1.frame_id and arg_3_1.frame_id ~= 0 then
		local var_3_13 = var_0_7.get(arg_3_1.frame_id)

		if var_3_13.resEffect ~= "0" then
			self.m_effHolder:setVisible(true)
			self.m_effHolder:removeAllEffect()
			self.m_effHolder:addEffectSpine({
				anim = "play",
				isLoop = true,
				name = var_3_13.resEffect
			})
		else
			self.m_frameLoader:setVisible(true)
			self.m_frameLoader:setURL(var_0_2:getRoleHeadFrameIcon(var_3_13.res))
		end
	end
end

function CrossServerArenaGloryComp:_updateAnim(arg_4_1)
	if arg_4_1 then
		self.m_effRewardDown:removeAllEffect()
		self.m_effRewardUp:removeAllEffect()
	else
		local var_4_0 = var_0_1.BOX_ANIM[self._rank]

		self.m_effRewardDown:addEffectSpine({
			anim = "playDown",
			isLoop = true,
			name = var_0_1.BOX_ANIM[self._rank]
		})
		self.m_effRewardUp:addEffectSpine({
			anim = "playUp",
			isLoop = true,
			name = var_4_0
		})
	end
end

function CrossServerArenaGloryComp:removeAnim()
	self.m_effRewardDown:removeAllEffect()
	self.m_effRewardUp:removeAllEffect()
end

function CrossServerArenaGloryComp:_onClickRewardBtn()
	if g.core.model.User:getGuildId() <= 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(411037))

		return
	end

	if var_0_0:isGuildRewardCanReceive(self._rank) then
		g.core.network.GameNetProxy:send_C2S_ChiefArena_GuildRankAward({
			index = self._rank
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(411031))
	end
end

return CrossServerArenaGloryComp
