local PetRewardLayerItem = class("PetRewardLayerItem", require("app.fairyGUI.recruitPet.UI_PetRewardLayerItem"))
local var_0_1 = g.core.common.Goods
local var_0_4 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_6 = g.core.common.Path
local var_0_7 = cc.c3b(242, 242, 242)

function PetRewardLayerItem:ctor()
	self._data = nil
	self._cfg = nil
	self._idx = -1
	self._newIndex = 0
	self._fragIndex = 0
end

function PetRewardLayerItem:playShareTrans(arg_2_1)
	return
end

function PetRewardLayerItem:updateItem(arg_3_1, arg_3_2)
	self._idx = arg_3_2
	self._data = {
		info = arg_3_1
	}

	if arg_3_1.type == var_0_1.TYPE_PET then
		self._cfg = g.core.config.pet_info.get(arg_3_1.value)
		self._data.url = g.core.common.Path:getPetRecruitPic(self._cfg.resource)
		self._data.knightAdvId = self._cfg.link_advance_id
		self._data.num = self._data.info.isNew and 1 or self._cfg.return_fragment_num

		self.m_typeController:setSelectedIndex(0)
	else
		self._cfg = var_0_1:convert(arg_3_1)

		if arg_3_1.value == var_0_1.TYPE_FRAGMENT and self._cfg.fragmentType then
			local var_3_0 = g.core.config.pet_info.get(self._cfg.fragment_value)

			self._data.knightAdvId = var_3_0.link_advance_id
			self._data.url = g.core.common.Path:getPetRecruitPic(var_3_0.resource)
		else
			self._data.url = g.core.common.Path:getIconByTypeValue(arg_3_1.type, arg_3_1.value)
		end

		self._data.num = arg_3_1.size

		self.m_typeController:setSelectedIndex(3)
	end

	self.m_numText:setText("X" .. self._data.num)
	self.m_iconComp:getChild("icon"):setURL(self._data.url)

	local var_3_1 = math.max(self._cfg.quality, 1)

	self.m_bgLoader:setURL((var_0_6:getRecruitPetBg(var_3_1)))
	self.m_fragBgLoader:setURL(var_0_6:getRecruitPetFragmentBg(var_3_1))
	self.m_nameText:setText(self._cfg.name)
	self.m_nameLeftLoader:setURL(var_0_6:getRecruitPetCornerMark(var_3_1))
	self.m_nameRightLoader:setURL(var_0_6:getRecruitPetCornerMark(var_3_1))

	self._fragIndex = 0
	self._newIndex = self._data.info.isNew and 1 or 0

	if self._data.info.isNew then
		self.m_isNewController:setSelectedIndex(1)
	else
		self.m_isNewController:setSelectedIndex(0)
	end

	if self._data.knightAdvId then
		-- block empty
	end
end

function PetRewardLayerItem:playEnterAction(arg_4_1)
	self._actionCallBack = arg_4_1

	self.m_enterTransition:play(handler(self, self._enterActionPlayEnd))

	if self._data.info.type == var_0_1.TYPE_PET then
		self:_playPetEnterAction()
	elseif self._cfg.is_frag and g.core.config.fragment_info.get(self._data.info.value).fragment_type == var_0_1.TYPE_PET then
		self:_onlyPlayFragEnterAction()
	else
		self:_playItemEnterAction()
	end
end

function PetRewardLayerItem:_playItemEnterAction()
	self.m_topEffectNode:addEffectSpine({
		isLoop = false,
		anim = "play",
		name = "eff_ui_petRecruit_reward_equip_enter_" .. math.clamp(self._cfg.quality, var_0_4.R, var_0_4.MAX_QUALITY) + 1
	})

	self._fragIndex = 3
end

function PetRewardLayerItem:_playPetEnterAction()
	local var_6_0 = not not self._data.info.isNew
	local var_6_1 = math.clamp(self._cfg.quality, var_0_4.R, var_0_4.MAX_QUALITY)

	self.m_bgEffectNode:addEffectSpine({
		anim = "play",
		name = "eff_ui_petRecruit_reward_idle_" .. var_6_1 + 1,
		isLoop = var_6_0
	})
	self.m_topEffectNode:addEffectSpine({
		isLoop = false,
		anim = "play",
		name = "eff_ui_petRecruit_reward_enter_" .. var_6_1 + 1
	})
end

function PetRewardLayerItem:_enterActionPlayEnd()
	if self._actionCallBack then
		self._actionCallBack(self._idx)
	end

	if self._data.info.type == var_0_1.TYPE_PET and not self._data.info.isNew then
		self:_playFragEnterAction()
	end
end

function PetRewardLayerItem:_playFragEnterAction()
	self.m_fragBgEffectNode:addEffectSpine({
		isLoop = true,
		anim = "play",
		name = "eff_ui_petRecruit_reward_frag_enter_" .. self._cfg.quality
	})
	self.m_topEffectNode:addEffectSpine({
		isLoop = false,
		anim = "play",
		name = "eff_ui_petRecruit_reward_frag_enter_" .. self._cfg.quality
	})
	self.m_switchFragTransition:play(handler(self, self._playFragAction))
	self.m_typeController:setSelectedIndex(2)

	self._fragIndex = 2
end

function PetRewardLayerItem:_playFragAction()
	self.m_typeController:setSelectedIndex(1)

	self._fragIndex = 1

	self.m_nameEffectNode:addEffectSpine({
		name = "eff_ui_recruitArtifact_frag",
		isLoop = false,
		anim = "play_" .. math.clamp(self._cfg.quality, var_0_4.R, var_0_4.MAX_QUALITY) + 1,
		eventHandler = handler(self, self._fragActionEvent)
	})
end

function PetRewardLayerItem:_fragActionEvent(arg_10_1, arg_10_2)
	if arg_10_1.type == "complete" then
		-- block empty
	end
end

function PetRewardLayerItem:_onlyPlayFragEnterAction()
	local var_11_0 = math.clamp(self._cfg.quality, var_0_4.R, var_0_4.MAX_QUALITY)

	self.m_fragBgEffectNode:addEffectSpine({
		isLoop = true,
		anim = "play",
		name = "eff_ui_petRecruit_reward_frag_idle_" .. var_11_0 + 1
	})
	self.m_topEffectNode:addEffectSpine({
		isLoop = false,
		anim = "play",
		name = "eff_ui_petRecruit_reward_frag_enter_" .. var_11_0 + 1
	})
	self.m_switchFragTransition:play(handler(self, self._onlyPlayFragAction))
end

function PetRewardLayerItem:_onlyPlayFragAction()
	local var_12_0 = "play_2"

	if self._cfg.quality == var_0_4.SR then
		var_12_0 = "play_3"
	elseif self._cfg.quality == var_0_4.SSR then
		var_12_0 = "play_4"
	elseif self._cfg.quality == var_0_4.UR then
		var_12_0 = "play_5"
	end

	self.m_nameEffectNode:addEffectSpine({
		name = "eff_ui_recruitArtifact_frag",
		isLoop = false,
		anim = var_12_0,
		eventHandler = handler(self, self._fragActionEvent)
	})

	self._fragIndex = 3
end

function PetRewardLayerItem:setCtrlIndex(arg_13_1)
	self.m_isNewController:setSelectedIndex(arg_13_1)
	self.m_typeController:setSelectedIndex(self._fragIndex)
end

function PetRewardLayerItem:resetState()
	self.m_isNewController:setSelectedIndex(self._newIndex)
	self.m_typeController:setSelectedIndex(self._fragIndex)
	self.m_bgLoader:setOpacity(self._fragIndex ~= 1 and 255 or 0)
	self.m_fragBgLoader:setOpacity(self._fragIndex ~= 0 and 255 or 0)
end

return PetRewardLayerItem
