local var_0_0 = g.core.const.ConstMgr.AnniversaryConst
local var_0_1 = g.core.model.User.anniversaryData
local AnniversaryJigsawGroupComp = class("AnniversaryJigsawGroupComp", require("app.fairyGUI.anniversary.UI_AnniversaryJigsawGroupComp"))

function AnniversaryJigsawGroupComp:updateJigsawComp(arg_1_1)
	self._group = arg_1_1

	for iter_1_0 = 1, var_0_0.JIGSAW_LEN_NUM do
		self["m_mahjong" .. iter_1_0]:updateItem(self._group, iter_1_0)
	end

	self.m_groupAward:updateGroupAward(self._group)
end

function AnniversaryJigsawGroupComp:playGetGroupAwardEff(arg_2_1)
	self._groupAward = arg_2_1

	self.m_effAward:addEffectSpine({
		anim = "play",
		name = "eff_ui_anniversaryJigsaw_rewardlight",
		isLoop = false,
		eventHandler = handler(self, self._onAnimationEnd)
	})
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_StarNight_Majiang04)
end

function AnniversaryJigsawGroupComp:_onAnimationEnd(arg_3_1)
	if arg_3_1.type == "event" then
		if arg_3_1.eventData.name == "scale" then
			local var_3_0 = {}

			for iter_3_0 = 1, var_0_0.JIGSAW_LEN_NUM do
				table.insert(var_3_0, (fgui.FSequence:create({
					fgui.FDelayTime:create(0.06),
					fgui.FCallFunc:create(handler(self, function()
						self["m_mahjong" .. iter_3_0]:playScaleOnceTransition()
					end))
				})))
			end

			self:runFGAction(fgui.FSequence:create(var_3_0))
		end

		if arg_3_1.eventData.name == "cut" then
			self.m_groupAward:updateGroupAward(self._group)
			self.m_groupAward:playBigAwardTransition()
		end
	elseif arg_3_1.type == "complete" and self._groupAward then
		g.core.module.ModuleManager:awardSummary(self._groupAward, nil, nil, nil, handler(self, self._checkBigAwardCanGet))
	end
end

function AnniversaryJigsawGroupComp:_checkBigAwardCanGet()
	if var_0_1:isCanGetTotalScoreAward() then
		g.core.network.GameNetProxy:send_C2S_Anniversary_GetTotalScoreAward({})
	else
		self:dispatchCompEvent("CHECK_CAN_AWARD_GROUP")
	end
end

return AnniversaryJigsawGroupComp
