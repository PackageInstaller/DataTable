local RecruitRewardCell = class("RecruitRewardCell", require("app.fairyGUI.recruitKnight.UI_RecruitRewardCell"))
local var_0_1 = g.core.common.Goods
local var_0_4 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_5 = g.core.config.knight_info

function RecruitRewardCell:ctor()
	self._count = 0
end

function RecruitRewardCell:updateView(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	self._isShare = arg_2_2

	local var_2_0 = var_0_5.get(arg_2_1.value)
	local var_2_1 = var_0_1:convert(arg_2_1)

	self.m_knightPic:updatePic(arg_2_1.value)
	self:_clearEffects()
	self.m_groupIcon:setURL(g.core.common.Path:getCampURL(var_2_0.group, 2))
	self.m_groupText:setText(g.core.lang:get(108100 + var_2_0.group))
	self.m_isNewController:setSelectedIndex(0)
	self.m_isKnightController:setSelectedIndex(0)

	self._isFrag = false

	if arg_2_1.type == var_0_1.TYPE_KNIGHT then
		if arg_2_1.isNew then
			self.m_isNewController:setSelectedIndex(1)
			self.m_isKnightController:setSelectedIndex(1)
			self.m_knightPic:setMaskVisible(false)
		else
			self.m_isKnightController:setSelectedIndex(1)

			if not arg_2_1.hideFrag then
				self._isFrag = true
			end

			self.m_knightPic:setFragStatue()
			self.m_knightPic:setMaskVisible(true)
			self.m_groupFrag:setOpacity(0)
		end

		if not arg_2_1.isNew then
			self.m_fragIcon:setURL((g.core.common.Path:getIconByTypeValue(var_0_1.TYPE_FRAGMENT, arg_2_1.value, true)))
			self.m_numTxt:setText("X" .. var_2_0.return_fragment_num)
		end

		self.m_qualityBorder:setURL("ui://base_new/pic_zm_pinzhi_" .. var_2_1.quality + 1)
	else
		self.m_fragIcon:setURL((g.core.common.Path:getIconByTypeValue(var_0_1.TYPE_FRAGMENT, arg_2_1.value, true)))
		self.m_numTxt:setText("X" .. var_2_1.size)
		self.m_isKnightController:setSelectedIndex(self._isShare and 1 or 0)
		self.m_knightPic:setMaskVisible(true)
	end

	self.m_qualityBg:setURL(g.core.common.Path:getRecruitRewardCellLeftQualityLine(var_2_1.quality))

	self._quality = var_2_1.quality

	if self._quality > var_0_4.SR then
		local var_2_3 = {
			isLoop = false,
			remove = true
		}

		var_2_3.name = "eff_ui_recruitReward_card"
		var_2_3.anim = "play_enter_" .. self._quality + 1

		self.m_qualityBorderEffect:addEffectSpine(var_2_3)
	end

	if arg_2_2 then
		self:setCtrlIndex(0, 1)
	end

	local var_2_4 = {
		isLoop = true
	}

	var_2_4.name = "eff_ui_recruitReward_card"
	var_2_4.anim = "play_idle_" .. self._quality + 1

	self.m_qualityBorderEffect:addEffectSpine(var_2_4)
end

function RecruitRewardCell:showRewardChangeAnim()
	if self._isFrag then
		self:_playFragmentEffect()
	else
		self:_playKnightEffect()
	end
end

function RecruitRewardCell:_changeToFrag(arg_4_1, arg_4_2)
	if arg_4_1.type == "complete" then
		-- block empty
	end
end

function RecruitRewardCell:_getNameStr(arg_5_1)
	local var_5_0 = g.core.utils.String.splitStringToList(arg_5_1)

	if #var_5_0 > 5 then
		local var_5_1 = ""

		for iter_5_0 = 1, 5 do
			var_5_1 = var_5_1 .. var_5_0[iter_5_0]
		end

		return var_5_1 .. "..."
	end

	return arg_5_1
end

function RecruitRewardCell:_playKnightEffect()
	local var_6_0 = {
		isLoop = true
	}

	var_6_0.name = "eff_ui_recruitReward_card"
	var_6_0.anim = "play_idle_" .. self._quality + 1

	self.m_qualityBorderEffect:addEffectSpine(var_6_0)
end

function RecruitRewardCell:_playFragmentEffect()
	self.m_fragEffectNode:removeChildren()

	local var_7_0 = {
		isLoop = false,
		remove = true
	}

	var_7_0.name = "eff_ui_recruitReward_cardFrag"
	var_7_0.anim = "play_" .. self._quality + 1

	function var_7_0:eventHandler(arg_8_1)
		if self.type == "complete" then
			-- block empty
		end
	end

	self.m_fragEffectNode:addEffectSpine(var_7_0)
	self.m_fragEnterTransition:play()
	self.m_isKnightController:setSelectedIndex(self._isShare and 1 or 0)
end

function RecruitRewardCell:_clearEffects()
	self.m_qualityBgEffect:removeAllEffect()
	self.m_qualityBorderEffect:removeAllEffect()
	self.m_fragEffectNode:removeAllEffect()
end

function RecruitRewardCell:playEffectSpineAction(arg_10_1)
	return
end

function RecruitRewardCell:setPos()
	local var_11_0 = self:getView():getSize()

	self:setPosition(-var_11_0.width / 2, -var_11_0.height / 2)
end

function RecruitRewardCell:setCtrlIndex(arg_12_1, arg_12_2)
	self.m_isNewController:setSelectedIndex(arg_12_1)
	self.m_isKnightController:setSelectedIndex(arg_12_2)
end

function RecruitRewardCell:getCtrlIndex()
	return self.m_isNewController:getSelectedIndex(), (self.m_isKnightController:getSelectedIndex())
end

return RecruitRewardCell
