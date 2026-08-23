local LotteryItem = class("LotteryItem", require("app.fairyGUI.lottery.UI_LotteryItem"))

function LotteryItem:ctor()
	self._info = nil

	self:addClickListener(handler(self, self._onClicked))

	self._animInfo = {
		spineIdx = 0,
		fguiIdx = 0
	}
end

function LotteryItem:_onItemRender(arg_2_1, arg_2_2)
	arg_2_2:updateComp(self._layoutInfo[arg_2_1 + 1])
end

function LotteryItem:updateComp(arg_3_1, arg_3_2)
	self._info = arg_3_1

	self.m_stateController:setSelectedIndex(arg_3_1.state)
	self:setScale(1)

	local var_3_0 = false

	if next(arg_3_1.rewardInfo) then
		self.m_rewardIcon:setURL(g.core.common.Path:getIconByTypeValue(arg_3_1.rewardInfo[1].type, arg_3_1.rewardInfo[1].value))
		self.m_numText:setText(g.core.lang:get(107073, {
			num = arg_3_1.rewardInfo[1].size
		}))

		var_3_0 = self._info.id == g.core.model.User.lotteryData:getRareGridID()

		if var_3_0 then
			self.m_isBigRewardController:setSelectedIndex(1)
			self:setScale(1.5)
		else
			self.m_isBigRewardController:setSelectedIndex(0)
		end
	end

	self:_updateRareEffect(var_3_0)

	if arg_3_2 then
		self:_updateRandomIdx()
	end
end

function LotteryItem:_onClicked()
	if self._info.state == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(420000))
	elseif self._info.state == 1 then
		if g.core.model.User.resourceData:getResourceById(require("app.view.module.lottery.const.LotteryConst").COST_ID) < 1 then
			g.core.module.ModuleManager:tip(g.core.lang:get(420001))
		else
			self:dispatchCompEvent("drawLottery", {
				pos = self._info.id
			})
		end
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(420002))
	end
end

function LotteryItem:_updateRareEffect(arg_5_1)
	if arg_5_1 then
		if self.m_isBigRewardController:getSelectedIndex() ~= 1 then
			self.m_ssrIdle:addEffectSpine({
				isLoop = true,
				anim = "ssrIdle",
				name = "eff_ui_lottery_idle"
			})
		end
	else
		self.m_ssrIdle:removeAllEffect()
	end
end

function LotteryItem:_updateRandomIdx()
	self:_randomFGUIIdxAndPlay()
	self:_randomSpineIdxAndPlayEnter()
end

function LotteryItem:_randomFGUIIdxAndPlay()
	self.m_idle1Transition:stop()
	self.m_idle2Transition:stop()

	if self._info.state == 0 then
		return
	end

	self._animInfo.fguiIdx = math.random(1, 2)

	self["m_idle" .. self._animInfo.fguiIdx .. "Transition"]:play(-1, 0)
end

function LotteryItem:_randomSpineIdxAndPlayEnter()
	if self._animInfo.spineIdx > 0 then
		self["m_iconIdle" .. self._animInfo.spineIdx]:removeAllEffect()
		self["m_iconEnter" .. self._animInfo.spineIdx]:removeAllEffect()
	end

	if self._info.state == 0 then
		self._animInfo.spineIdx = 0

		return
	end

	self._animInfo.spineIdx = math.random(1, 3)

	self["m_iconEnter" .. self._animInfo.spineIdx]:addEffectSpine({
		remove = true,
		isLoop = false,
		name = "eff_ui_lottery_enter",
		anim = "iconEnterRandom" .. self._animInfo.spineIdx,
		eventHandler = handler(self, self._onEnterSpineEvent)
	})
end

function LotteryItem:_onEnterSpineEvent(arg_9_1, arg_9_2)
	if require("app.view.battle.const.BattleConst").SPINE_EVENT.COMPLETE == arg_9_1.type then
		self:_playIdleSpineAnim()
	end
end

function LotteryItem:_playIdleSpineAnim()
	self["m_iconIdle" .. self._animInfo.spineIdx]:addEffectSpine({
		isLoop = true,
		name = "eff_ui_lottery_idle",
		anim = "iconIdleRandom" .. self._animInfo.spineIdx
	})
end

function LotteryItem:playRewardEffect(arg_11_1)
	self.m_ssrAward:removeAllEffect()
	self.m_srAward:removeAllEffect()

	if arg_11_1.isRare then
		self.m_ssrAward:addEffectSpine({
			isLoop = false,
			remove = true,
			anim = "ssr",
			name = "eff_ui_lottery_reward",
			eventHandler = handler(self, function(arg_12_0, arg_12_1, arg_12_2)
				if arg_12_1.type == "event" then
					if (arg_12_1.eventData or {}).name == "rewardPop" then
						arg_12_0:_onRareRewardActionEnd(arg_11_1)
					end
				end
			end)
		})
	else
		self.m_srAward:addEffectSpine({
			isLoop = false,
			remove = true,
			anim = "sr",
			name = "eff_ui_lottery_reward"
		})
		self.m_srAward_2Transition:play()
	end
end

function LotteryItem:_onRareRewardActionEnd(arg_13_1)
	self:dispatchCompEvent("rareAwardShow", {
		awards = arg_13_1.awards
	})
end

return LotteryItem
