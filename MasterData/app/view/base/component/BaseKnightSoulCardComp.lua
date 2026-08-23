local var_0_1 = g.core.const.ConstMgr.KnightSoulConst
local var_0_2 = g.core.model.User.bagData
local var_0_3 = g.core.const.ConstMgr.BAG_TYPE
local var_0_4 = g.core.common.Path
local var_0_5 = g.core.config.artifact_info
local var_0_6 = g.core.config.ksoul_info
local BaseKnightSoulCardComp = class("BaseKnightSoulCardComp", require("app.fairyGUI.base_new.UI_BaseKnightSoulCardComp"))

function BaseKnightSoulCardComp:ctor()
	self._params = {}
	self._ksoulInfo = {}
	self._callback = nil

	self:addClickListener(handler(self, self._onClickSelf))

	self._eff = nil
	self._act = nil
	self._act2 = nil
end

function BaseKnightSoulCardComp:updateCard(arg_2_1)
	self.m_eff:setVisible(false)
	self.m_act:setVisible(false)
	self.m_act2:setVisible(false)
	self.m_typeController:setSelectedIndex(0)

	if not arg_2_1 then
		return
	end

	self._params = arg_2_1

	local var_2_0 = var_0_6.fetch(arg_2_1.kSoulId)

	self._ksoulInfo = var_2_0

	if var_2_0 then
		local var_2_1 = 0

		if var_2_0.type == var_0_3.ARTIFACT then
			var_2_1 = 1
		end

		local var_2_2, var_2_3 = var_0_4:getKnightSoulCardBgAndFg(var_2_0.quality)

		self.m_qualityBg:setURL(var_2_2)
		self.m_qualityFg:setURL(var_2_3)
		self.m_group:setURL((var_0_4:getKnightSoulCardGroupIcon(var_2_0.quality, var_2_0.group)))

		if var_2_0.type == var_0_3.KNIGHT then
			self.m_knightCutComp:getChild("knightIcon"):setURL(var_0_4:getMiddleKnightPicById(var_2_0.advance_id))
		elseif var_2_0.type == var_0_3.ARTIFACT then
			self.m_knightCutComp:getChild("artifactIcon"):setURL(var_0_4:getArtifactPic(var_2_0.advance_id))
			self.m_knightCutComp:getChild("knightIcon"):setURL(var_0_4:getMiddleKnightPicById(var_0_5.get(var_2_0.advance_id).knight_advance_code))
		elseif var_2_0.type == var_0_3.SKIN then
			self.m_knightCutComp:getChild("knightIcon"):setURL(var_0_4:getMiddleKnightPicById(var_2_0.advance_id))
		end

		self.m_nameTxt:setText(var_2_0.name)
		self.m_isOwnController:setSelectedIndex(1)
		self.m_typeController:setSelectedIndex(var_2_1)
	end
end

function BaseKnightSoulCardComp:_onClickSelf()
	if self._params.kSoulId > 0 then
		g.core.common.GlobalFunc.pushInfoPop({
			type = var_0_3.KSOUL,
			value = self._params.kSoulId,
			size = var_0_2:getOwnNum(var_0_3.KSOUL, self._params.kSoulId)
		})
	end
end

function BaseKnightSoulCardComp:_playStarUpLoopAnim(arg_4_1)
	self.m_eff:setVisible(true)

	if self._eff then
		self._eff:setAnimation(0, "play_up_" .. arg_4_1 + 1, true)
	else
		self._eff = self.m_eff:addEffectSpine({
			name = "eff_ui_KnightSoul_waitActCard",
			isLoop = true,
			anim = "play_up_" .. arg_4_1 + 1
		})
	end
end

function BaseKnightSoulCardComp:_playActivateLoopAnim(arg_5_1)
	self.m_act:setVisible(true)
	self.m_act:setAlpha(100)

	if self._act then
		self._act:setAnimation(0, "play_act_" .. arg_5_1 + 1, true)
	else
		self._act = self.m_act:addEffectSpine({
			name = "eff_ui_KnightSoul_waitActCard",
			isLoop = true,
			anim = "play_act_" .. arg_5_1 + 1
		})
	end
end

function BaseKnightSoulCardComp:playActivateStarUpAnim(arg_6_1, arg_6_2)
	if not self._ksoulInfo then
		return
	end

	self.m_eff:setVisible(false)
	self.m_act:setVisible(false)
	self.m_act2:setVisible(false)

	if arg_6_1 == var_0_1.BOOK_STATUS.STAR_UP_ABLE then
		self.m_enterTransition:play()
		self:_playStarUpLoopAnim(self._ksoulInfo.quality)
	elseif arg_6_1 == var_0_1.BOOK_STATUS.NOT_MAX_STAR then
		if arg_6_2 and arg_6_2:isOpenStarUp() and var_0_2:getOwnNum(var_0_3.KSOUL, self._params.kSoulId) > 0 then
			self:_playStarUpLoopAnim(self._ksoulInfo.quality)
		end
	elseif arg_6_1 == var_0_1.BOOK_STATUS.ACTIVATE_ABLE then
		self:_playActivateLoopAnim(self._ksoulInfo.quality)
	elseif arg_6_1 == var_0_1.BOOK_STATUS.ACTIVATE_UNABLE and var_0_2:getOwnNum(var_0_3.KSOUL, self._params.kSoulId) > 0 then
		self:_playActivateLoopAnim(self._ksoulInfo.quality)
	end
end

function BaseKnightSoulCardComp:playActivateAnim(arg_7_1)
	if not self._ksoulInfo then
		return
	end

	self.m_act2:setVisible(true)
	self.m_enterTransition:setHook("cut", handler(self, self._removeAnim))
	self.m_activateTransition:play()

	self._callback = arg_7_1

	self.m_act2:removeAllEffect()
	self.m_act2:addEffectSpine({
		name = "eff_ui_KnightSoul_activateCard",
		isLoop = false,
		anim = "play_" .. self._ksoulInfo.quality + 1,
		eventHandler = handler(self, self._onAnimEnd)
	})
end

function BaseKnightSoulCardComp:_removeAnim()
	self.m_act:removeAllEffect()
end

function BaseKnightSoulCardComp:_onAnimEnd(arg_9_1)
	if arg_9_1.type == "complete" and self._callback then
		self._callback()

		self._callback = nil
	end
end

return BaseKnightSoulCardComp
