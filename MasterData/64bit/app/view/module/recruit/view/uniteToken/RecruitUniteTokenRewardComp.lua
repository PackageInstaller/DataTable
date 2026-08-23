local RecruitUniteTokenRewardComp = class("RecruitUniteTokenRewardComp", require("app.fairyGUI.recruitUniteToken.UI_RecruitUniteTokenRewardComp"))

function RecruitUniteTokenRewardComp:ctor()
	self._isNew = false

	self.m_enter1Transition:setHook("eff", handler(self, self._onPlayEnterFlagEff))
end

function RecruitUniteTokenRewardComp:updateItem(arg_2_1, arg_2_2, arg_2_3)
	self:clearEffect()

	self._rewardItem = arg_2_1

	local var_2_0 = g.core.common.Goods:convert(arg_2_1)

	if var_2_0.type == g.core.common.Goods.TYPE_UNITETOKEN then
		self._isUniteToken = true

		local var_2_1 = var_2_0.quality + 1

		self.m_typeController:setSelectedIndex(0)
		self.m_icon:setURL(var_2_0.pic)
		self.m_miniQualityLoader:setURL("ui://base_new/pic_zm_pinzhijt_" .. var_2_1)

		local var_2_2 = {
			nil,
			4,
			5,
			6,
			7,
			8
		}
		local var_2_3 = arg_2_2 or g.core.model.User.recruitData:isNewUniteToken(var_2_0.value)

		self._isNew = var_2_3

		if var_2_3 then
			self.m_fragShow:setVisible(false)
			self.m_newImg:setVisible(true)
		else
			local var_2_4 = g.core.config.unite_token_info.get(arg_2_1.value)

			self.m_newImg:setVisible(false)
			self.m_fragShow:setVisible(true)
			self.m_fragNumTxt:setText("x" .. var_2_4.return_fragment_num)
			self.m_fragIcon:setURL(g.core.common.Path:getUniteTokenIconById(arg_2_1.value))

			if var_2_0.quality > 0 then
				self.m_eff_frag_holder:addEffectSpine({
					isLoop = false,
					name = "eff_ui_recruitUniteToken_fragment",
					anim = "play_" .. var_2_1
				})
			end
		end

		if var_2_2[var_2_1] then
			if var_2_1 >= 4 then
				local var_2_5 = self.m_eff_idel_holder:addEffectSpine({
					isLoop = true,
					anim = "play_down",
					name = "eff_ui_recruitUniteToken_wholeIdle_" .. var_2_1
				})

				var_2_5:setOpacity(0)
				var_2_5:runAction(cc.Sequence:create({
					cc.FadeIn:create(0.5)
				}))
				self.m_eff_idel_holder:runFGAction(fgui.FFadeIn:create(0.5))
				self.m_eff_enter_holder:addEffectSpine({
					remove = true,
					isLoop = false,
					anim = "play",
					name = "eff_ui_recruitUniteToken_wholeEnter_" .. var_2_1
				})

				local var_2_6 = self.m_eff_enter_holder:addEffectSpine({
					isLoop = true,
					anim = "play_up",
					name = "eff_ui_recruitUniteToken_wholeIdle_" .. var_2_1
				})

				var_2_6:setOpacity(0)
				var_2_6:runAction(cc.Sequence:create({
					cc.FadeIn:create(0.5)
				}))
			else
				self.m_eff_idel_holder:addEffectSpine({
					isLoop = true,
					anim = "play",
					name = "eff_ui_recruitUniteToken_wholeIdle_" .. var_2_1
				})
				self.m_eff_idel_holder:runFGAction(fgui.FFadeIn:create(0.5))
				self.m_eff_enter_holder:addEffectSpine({
					remove = true,
					isLoop = false,
					anim = "play",
					name = "eff_ui_recruitUniteToken_wholeEnter_" .. var_2_1
				})
			end
		end
	else
		self.m_typeController:setSelectedIndex(1)
		self.m_itemIcon:setURL(var_2_0.icon)
		self.m_numTxt:setText("x" .. var_2_0.size)

		if var_2_0.quality + 1 >= 2 then
			self.m_eff_item_idel_holder:addEffectSpine({
				isLoop = true,
				anim = "play",
				name = "eff_ui_recruitUniteToken_frag_" .. var_2_0.quality + 1
			})
		end
	end

	self.m_nameTxt:setText(var_2_0.name)

	if not arg_2_3 then
		self.m_enterTransition:play()
	end
end

function RecruitUniteTokenRewardComp:setShareState()
	self.m_fragShow:setVisible(false)
	self.m_newImg:setVisible(false)
end

function RecruitUniteTokenRewardComp:_onPlayEnterFlagEff()
	if not self._isUniteToken then
		self.m_eff_fag_enter_holder:addEffectSpine({
			remove = true,
			isLoop = false,
			anim = "play",
			name = "eff_ui_recruitUniteToken_20"
		})
	end
end

function RecruitUniteTokenRewardComp:resetShareState()
	if self._isNew then
		self.m_fragShow:setVisible(false)
		self.m_newImg:setVisible(true)
	else
		self.m_newImg:setVisible(false)
		self.m_fragShow:setVisible(true)
	end
end

function RecruitUniteTokenRewardComp:getIsNew()
	return self._isNew
end

function RecruitUniteTokenRewardComp:clearEffect()
	self.m_eff_frag_holder:removeAllEffect()
	self.m_eff_idel_holder:removeAllEffect()
	self.m_eff_enter_holder:removeAllEffect()
	self.m_eff_item_idel_holder:removeAllEffect()
	self.m_eff_fag_enter_holder:removeAllEffect()
end

return RecruitUniteTokenRewardComp
