local var_0_0 = g.core.const.ConstMgr.ElderBossConst
local var_0_1 = g.core.model.User.elderBossData
local var_0_2 = g.core.event.EventManager
local var_0_3 = g.core.event.enum
local ElderRankLayer = class("ElderRankLayer", require("app.fairyGUI.elderBoss.UI_ElderRankLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/elderBoss/elderBoss",
		resName = "ElderRankLayer",
		pkgName = "elderBoss"
	}, ...)
end)

function ElderRankLayer:ctor()
	self:addBg("bg/common/pic_bb_beijing.jpg")
	self.m_leftTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onMainTabChanged))
	self.m_topTabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onElementTabChanged))
	self.m_rewardShowBtn:addClickListener(handler(self, self._onRewardBtnClick))

	if var_0_1:getChooseBuff() > 0 then
		self.m_topTabController:setSelectedIndex(var_0_1:getChooseBuff() - 1)
	end
end

function ElderRankLayer:onLoad()
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_GET_COMMON_RANK_LIST, self._updateView, self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_GET_USER_SNAP_SHOT, self._onGetSnapShot, self)
	var_0_2:addEventListener(var_0_3.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, self._onGetSnapShot, self)
	self:_sendC2SGetCommonRankList()
end

function ElderRankLayer:_onGetSnapShot()
	if self._content then
		self:_updateView(nil, nil, self._content)
	end
end

function ElderRankLayer:_updateView(arg_5_1, arg_5_2, arg_5_3)
	self._content = arg_5_3

	local var_5_0 = self.m_leftTabController:getSelectedIndex()

	if var_5_0 == var_0_0.RANK_MAIN_TAB.MAX then
		self.m_userRank:updateView(var_0_1:getRankListById(arg_5_3.id), var_0_0.RANK_AWARD_TYPE_MAX)

		if arg_5_3.self_rank == nil or arg_5_3.self_rank <= 0 or arg_5_3.self_rank > var_0_0.RANK_SHOW_SIZE then
			self.m_rankTxt:setText(g.core.lang:get(432505))

			local var_5_1 = var_0_1:getMaxHonor() or 0

			self.m_scoreNumTxt:setText(g.core.lang:get(432506, {
				score = var_5_1
			}))
		elseif arg_5_3.self_rank >= 1 and arg_5_3.self_rank <= var_0_0.RANK_SHOW_SIZE then
			self.m_rankTxt:setText(g.core.lang:get(432504, {
				rank = arg_5_3.self_rank
			}))
			self.m_scoreNumTxt:setText(g.core.lang:get(432506, {
				score = arg_5_3.rank_units[arg_5_3.self_rank].score
			}))
		end
	elseif var_5_0 == var_0_0.RANK_MAIN_TAB.TOTAL then
		self.m_userRank:updateView(var_0_1:getRankListById(arg_5_3.id), var_0_0.RANK_AWARD_TYPE_TOTAL)

		if arg_5_3.self_rank == nil or arg_5_3.self_rank <= 0 or arg_5_3.self_rank > var_0_0.RANK_SHOW_SIZE then
			self.m_rankTxt:setText(g.core.lang:get(432505))

			local var_5_2 = var_0_1:getTotalHonor() or 0

			self.m_scoreNumTxt:setText(g.core.lang:get(432507, {
				score = var_5_2
			}))
		elseif arg_5_3.self_rank >= 1 and arg_5_3.self_rank <= var_0_0.RANK_SHOW_SIZE then
			self.m_rankTxt:setText(g.core.lang:get(432504, {
				rank = arg_5_3.self_rank
			}))
			self.m_scoreNumTxt:setText(g.core.lang:get(432507, {
				score = arg_5_3.rank_units[arg_5_3.self_rank].score
			}))
		end
	elseif var_5_0 == var_0_0.RANK_MAIN_TAB.GUILD then
		self.m_guildRank:updateView(var_0_1:getRankListById(arg_5_3.id), var_0_0.RANK_AWARD_TYPE_GUILD)

		if not g.core.model.User:isJoinGuild() then
			self.m_rankTxt:setText(g.core.lang:get(411025))
			self.m_scoreNumTxt:setText("")

			return
		end

		if arg_5_3.self_rank == nil or arg_5_3.self_rank <= 0 or arg_5_3.self_rank > var_0_0.RANK_SHOW_SIZE then
			self.m_rankTxt:setText(g.core.lang:get(432509))

			local var_5_3 = var_0_1:getGuildRank() or 0

			self.m_scoreNumTxt:setText(g.core.lang:get(432510, {
				score = var_5_3
			}))
		elseif arg_5_3.self_rank >= 1 and arg_5_3.self_rank <= var_0_0.RANK_SHOW_SIZE then
			self.m_rankTxt:setText(g.core.lang:get(432508, {
				rank = arg_5_3.self_rank
			}))
			self.m_scoreNumTxt:setText(g.core.lang:get(432510, {
				score = arg_5_3.rank_units[arg_5_3.self_rank].score
			}))
		end
	end
end

function ElderRankLayer:_onRewardBtnClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.elderBoss.view.ElderRankRewardPop").new())
end

function ElderRankLayer:_onMainTabChanged()
	if var_0_1:getChooseBuff() > 0 then
		self.m_topTabController:setSelectedIndex(var_0_1:getChooseBuff() - 1)
	end

	self:_sendC2SGetCommonRankList()
end

function ElderRankLayer:_onElementTabChanged()
	self:_sendC2SGetCommonRankList()
end

function ElderRankLayer:_sendC2SGetCommonRankList()
	local var_9_0 = self.m_leftTabController:getSelectedIndex()
	local var_9_1 = self.m_topTabController:getSelectedIndex()

	if var_9_0 == var_0_0.RANK_MAIN_TAB.MAX then
		if var_9_1 == var_0_0.RANK_ELEMENT_TAB.WATER then
			g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
				id = var_0_0.MAX_HONNOR_RANK_ID[1],
				size = var_0_0.RANK_SHOW_SIZE
			})
		elseif var_9_1 == var_0_0.RANK_ELEMENT_TAB.FIRE then
			g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
				id = var_0_0.MAX_HONNOR_RANK_ID[2],
				size = var_0_0.RANK_SHOW_SIZE
			})
		elseif var_9_1 == var_0_0.RANK_ELEMENT_TAB.WIND then
			g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
				id = var_0_0.MAX_HONNOR_RANK_ID[3],
				size = var_0_0.RANK_SHOW_SIZE
			})
		elseif var_9_1 == var_0_0.RANK_ELEMENT_TAB.THUNDER then
			g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
				id = var_0_0.MAX_HONNOR_RANK_ID[4],
				size = var_0_0.RANK_SHOW_SIZE
			})
		elseif var_9_1 == var_0_0.RANK_ELEMENT_TAB.EARTH then
			g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
				id = var_0_0.MAX_HONNOR_RANK_ID[5],
				size = var_0_0.RANK_SHOW_SIZE
			})
		end
	elseif var_9_0 == var_0_0.RANK_MAIN_TAB.TOTAL then
		if var_9_1 == var_0_0.RANK_ELEMENT_TAB.WATER then
			g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
				id = var_0_0.TOTAL_HONNOR_RANK_ID[1],
				size = var_0_0.RANK_SHOW_SIZE
			})
		elseif var_9_1 == var_0_0.RANK_ELEMENT_TAB.FIRE then
			g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
				id = var_0_0.TOTAL_HONNOR_RANK_ID[2],
				size = var_0_0.RANK_SHOW_SIZE
			})
		elseif var_9_1 == var_0_0.RANK_ELEMENT_TAB.WIND then
			g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
				id = var_0_0.TOTAL_HONNOR_RANK_ID[3],
				size = var_0_0.RANK_SHOW_SIZE
			})
		elseif var_9_1 == var_0_0.RANK_ELEMENT_TAB.THUNDER then
			g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
				id = var_0_0.TOTAL_HONNOR_RANK_ID[4],
				size = var_0_0.RANK_SHOW_SIZE
			})
		elseif var_9_1 == var_0_0.RANK_ELEMENT_TAB.EARTH then
			g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
				id = var_0_0.TOTAL_HONNOR_RANK_ID[5],
				size = var_0_0.RANK_SHOW_SIZE
			})
		end
	elseif var_9_0 == var_0_0.RANK_MAIN_TAB.GUILD then
		g.core.network.GameNetProxy:send_C2S_GetCommonRankList({
			id = var_0_0.GUILD_HONNOR_RANK_ID,
			size = var_0_0.RANK_SHOW_SIZE
		})
	end
end

return ElderRankLayer
