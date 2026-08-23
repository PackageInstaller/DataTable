local ValentinesDayVoteLevelAwardComp = class("ValentinesDayVoteLevelAwardComp", require("app.fairyGUI.valentinesDayVote.UI_ValentinesDayVoteLevelAwardComp"))
local var_0_1 = g.core.model.User.valentinesDayVoteData

ValentinesDayVoteLevelAwardComp._TWEEN_DURATION = 0.3

function ValentinesDayVoteLevelAwardComp:ctor()
	self._curLv = 0
	self._curStepNum = 0
	self._curStepNumMax = 0
	self._isProgressBarInited = false

	self.m_scoreProgressBar:addClickListener(handler(self, self._onLevelClick))
	self.m_levelupTransition:setHook("cut", function()
		g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_SMALL_LEVELUP)
		self:updateView()
	end)
	self.m_getBtn:addClickListener(handler(self, self._onGetClick))
	self.m_awardList:setVirtual(self)
	self.m_awardList:setItemRenderer(handler(self, self._onAwardListItemRender))
	self:updateView()
end

function ValentinesDayVoteLevelAwardComp:updateView()
	local var_3_0 = var_0_1:getCurLevel()
	local var_3_1 = var_0_1:getCurExpSum()
	local var_3_2 = 0
	local var_3_3 = 0
	local var_3_4 = ""

	if var_3_0 >= 1 then
		local var_3_5 = var_0_1:getLevelRewardDataById(var_3_0)
		local var_3_6 = var_0_1:getLevelRewardDataById(var_3_0 + 1)

		if var_3_6 then
			var_3_3 = var_3_6:getCfg().exp - var_3_5:getCfg().exp
			var_3_2 = var_3_1 - var_3_5:getCfg().exp
			var_3_4 = g.core.lang:get(502001, {
				num = var_3_3 - var_3_2
			})
		else
			var_3_3 = var_3_1
			var_3_2 = var_3_1
			var_3_4 = g.core.lang:get(502002, {
				num = var_3_1
			})
		end
	else
		var_3_3 = var_0_1:getLevelRewardDataById(1):getCfg().exp
		var_3_2 = var_3_1
		var_3_4 = g.core.lang:get(502001, {
			num = var_3_3 - var_3_1
		})
	end

	if not self._isProgressBarInited then
		self._isProgressBarInited = true
		self._curStepNumMax = var_3_3
		self._curStepNum = var_3_2
		self._curLv = var_3_0

		self.m_scoreProgressBar:setMax(var_3_3)
		self.m_scoreProgressBar:setValue(var_3_2)
	elseif var_3_0 == self._curLv then
		self._curStepNumMax = var_3_3
		self._curStepNum = var_3_2
		self._curLv = var_3_0

		self.m_scoreProgressBar:setMax(var_3_3)
		self.m_scoreProgressBar:tweenValue(var_3_2, self._TWEEN_DURATION)
		self:getChild("num"):setText(var_3_0)
		self.m_descTxt:setText(var_3_4)

		self._awardList = var_0_1:getCanGetLevelAward()

		if #self._awardList > 3 then
			self.m_awardList:setNumItems(3)
		else
			self.m_awardList:setNumItems(#self._awardList)
		end

		if #self._awardList > 0 then
			self.m_has_awardController:setSelectedIndex(0)
		else
			self.m_has_awardController:setSelectedIndex(1)
		end
	elseif var_3_0 > self._curLv then
		self._curStepNumMax = var_3_3
		self._curStepNum = var_3_2
		self._curLv = var_3_0

		self.m_scoreProgressBar:setMax(var_3_3)
		self.m_scoreProgressBar:tweenValue(var_3_3, self._TWEEN_DURATION)
		self:runFGAction(fgui.FSequence:create(fgui.FDelayTime:create(self._TWEEN_DURATION), fgui.FCallFunc:create(function()
			self.m_scoreProgressBar:setValue(0)
			self:playRiseEffect()
			self.m_levelupTransition:play()
		end)))
	end
end

function ValentinesDayVoteLevelAwardComp:_onAwardListItemRender(arg_5_1, arg_5_2)
	arg_5_2:getChild("icon"):setURL((g.core.common.Path:getIconByTypeValue(self._awardList[arg_5_1 + 1].type, self._awardList[arg_5_1 + 1].value)))
	arg_5_2:getChild("title"):setText(self._awardList[arg_5_1 + 1].size)
end

function ValentinesDayVoteLevelAwardComp:_onLevelClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.valentinesDayVote.view.ValentinesDayVoteLevelPop").new(), {
		touchDisappear = true,
		ignoreTouch = false
	})
end

function ValentinesDayVoteLevelAwardComp:_onGetClick()
	g.core.network.GameNetProxy:send_C2S_Support_VoteAllAward({})
end

function ValentinesDayVoteLevelAwardComp:getEffectPosition()
	return self:localToGlobal(self.m_effectComp:getPosition())
end

function ValentinesDayVoteLevelAwardComp:playVoteEffect()
	self.m_effectComp:addEffectSpine({
		remove = true,
		anim = "play",
		isLoop = false,
		name = "eff_ui_valentinesDayVote_growth",
		x = self.m_effectComp:getWidth() / 2,
		y = self.m_effectComp:getHeight() / 2
	})
end

function ValentinesDayVoteLevelAwardComp:playRiseEffect()
	self.m_effectComp:addEffectSpine({
		remove = true,
		anim = "play",
		isLoop = false,
		name = "eff_ui_valentinesDayVote_levelup",
		x = self.m_effectComp:getWidth() / 2,
		y = self.m_effectComp:getHeight() / 2
	})
end

return ValentinesDayVoteLevelAwardComp
