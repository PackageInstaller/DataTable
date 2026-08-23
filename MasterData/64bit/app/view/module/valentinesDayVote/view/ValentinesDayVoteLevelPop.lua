local ValentinesDayVoteLevelPop = class("ValentinesDayVoteLevelPop", require("app.fairyGUI.valentinesDayVote.UI_ValentinesDayVoteLevelPop"), function()
	return fgui.GComponent:create({
		pkgName = "valentinesDayVote",
		resName = "ValentinesDayVoteLevelPop",
		pkgPath = "ui/valentinesDayVote/valentinesDayVote"
	}, ...)
end)
local var_0_1 = g.core.model.User.valentinesDayVoteData

function ValentinesDayVoteLevelPop:ctor()
	self:showAtCenter()
	self.m_rewardList:setVirtual(self)
	self.m_rewardList:setItemRenderer(handler(self, self._onRewardListItemRender))
	self.m_popPanel:getChild("closeBtn"):addClickListener(handler(self, self._onClose))
	self:_initView()
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_OPEN_VOTE_LEVEL_POP)
end

function ValentinesDayVoteLevelPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_SUPPORT_VOTEAWARD, handler(self, self._showReward), self)
end

function ValentinesDayVoteLevelPop:_initView()
	self:_updateList()

	local var_4_0 = var_0_1:getCurLevel()

	self.m_curLvText:setText(g.core.lang:get(205526, {
		num = var_4_0
	}))

	local var_4_1 = var_0_1:getCurExpSum()

	if var_4_0 >= 1 then
		local var_4_4 = var_0_1:getLevelRewardDataById(var_4_0)
		local var_4_5 = var_0_1:getLevelRewardDataById(var_4_0 + 1)

		if var_4_5 then
			local var_4_6 = var_4_5:getCfg().exp - var_4_4:getCfg().exp
			local var_4_7 = var_4_1 - var_4_4:getCfg().exp

			self.m_progressText:setText(var_4_7 .. "/" .. var_4_6)
			self.m_progressBar:setMax(var_4_6)
			self.m_progressBar:setValue(var_4_7)
		else
			local var_4_8 = var_4_1

			self.m_progressText:setText(var_4_1)
			self.m_progressBar:setMax(var_4_8)
			self.m_progressBar:setValue(var_4_8)
		end
	else
		local var_4_9 = var_0_1:getLevelRewardDataById(1):getCfg().exp

		self.m_progressText:setText(var_4_1 .. "/" .. var_4_9)
		self.m_progressBar:setMax(var_4_9)
		self.m_progressBar:setValue(var_4_1)
	end
end

function ValentinesDayVoteLevelPop:_updateList()
	self._levelRewardData = var_0_1:getLevelRewardDataWithReward()

	table.sort(self._levelRewardData, function(arg_6_0, arg_6_1)
		local var_6_0 = var_0_1:getCurLevel()
		local var_6_1 = 1
		local var_6_2 = 1

		if arg_6_0:isGetReward() then
			var_6_1 = 2
		elseif var_6_0 >= arg_6_0:getCfg().id then
			var_6_1 = 0
		end

		if arg_6_1:isGetReward() then
			var_6_2 = 2
		elseif var_6_0 >= arg_6_1:getCfg().id then
			var_6_2 = 0
		end

		if var_6_1 == var_6_2 then
			return arg_6_0:getCfg().id < arg_6_1:getCfg().id
		else
			return var_6_1 < var_6_2
		end
	end)
	self.m_rewardList:setNumItems(#self._levelRewardData)
end

function ValentinesDayVoteLevelPop:_updateView()
	self:_updateList()
end

function ValentinesDayVoteLevelPop:_onRewardListItemRender(arg_8_1, arg_8_2)
	arg_8_2:updateView(self._levelRewardData[arg_8_1 + 1])
end

function ValentinesDayVoteLevelPop:_showReward(arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	g.core.module.ModuleManager:awardSummary(arg_9_4.awards or {}, nil, nil, g.core.lang:get(300001))
	arg_9_1:_updateView()
end

function ValentinesDayVoteLevelPop:_onClose()
	self:dispatchCompEvent("levelPop_close")
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_CLOSE_VOTE_LEVEL_POP)
end

return ValentinesDayVoteLevelPop
