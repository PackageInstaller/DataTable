local ArtifactRewardLayerItem = class("ArtifactRewardLayerItem", require("app.fairyGUI.recruitArtifact.UI_ArtifactRewardLayerItem"))
local var_0_1 = g.core.common.Goods

function ArtifactRewardLayerItem:ctor()
	self._info = nil
	self._artifactCfg = nil
	self._idx = -1
	self._newIndex = 0
	self._fragIndex = 0
	self._shareTrans = self.getSharedTrans(self, "enter_left", "CommonCardCellList", self)
end

function ArtifactRewardLayerItem:playShareTrans(arg_2_1)
	self:newScheduleOnce(handler(self._shareTrans, self._shareTrans.play), arg_2_1)
end

function ArtifactRewardLayerItem:updateItem(arg_3_1, arg_3_2)
	self.m_enterTransition:stop()
	self.m_switchFragTransition:stop()
	self.m_bgEffIdleTransition:stop()

	self._idx = arg_3_2
	self._info = arg_3_1
	self._artifactCfg = g.core.config.artifact_info.get(self._info.value)

	self.m_icon:setURL((g.core.common.Path:getArtifactPic(self._artifactCfg.res_id)))
	self.m_bgLoader:setURL("ui://base_new/pic_zm_ygcz_10_" .. self._artifactCfg.quality + 1)
	self.m_nameText:setText(self._artifactCfg.name)
	self.m_groupIcon:setURL(g.core.common.Path:getCampURL(g.core.model.User.knightsData:getKnightByAdvanceId(self._artifactCfg.knight_advance_code):getGroup(), 7))
	self.m_isFragController:setSelectedIndex(0)

	self._fragIndex = 0
	self._newIndex = self._info.isNew and 1 or 0

	if self._info.isNew then
		self.m_isNewController:setSelectedIndex(1)
	else
		self.m_fragBgLoader:setURL("ui://base_new/pic_zm_ygcz_10_sp_" .. self._artifactCfg.quality + 1)
		self.m_fragIcon:setURL((g.core.common.Path:getIconByTypeValue(var_0_1.TYPE_ARTIFACT, self._info.value, true)))
		self.m_fragIcon:setScale(0.6)
		self.m_fragNumText:setText("X" .. self._artifactCfg.return_fragment_num)
		self.m_isNewController:setSelectedIndex(0)
	end

	local var_3_0 = g.core.model.User.artifactData:getArtifactByAdvId(self._artifactCfg.advance_code)

	if var_3_0 then
		self.m_artifactBelongIcon:updateComp(var_3_0:getBelongToKnightAvdIdIncludingMainRole(), self._artifactCfg.quality)
	end
end

function ArtifactRewardLayerItem:playEnterAction(arg_4_1)
	self._actionCallBack = arg_4_1

	self.m_enterTransition:play(handler(self, self._enterActionPlayEnd))

	local var_4_0 = not not self._info.isNew
	local var_4_1 = "eff_ui_recruitArtifact_wholeEnter_" .. self._artifactCfg.quality + 1

	self.m_bgEffectNode:addEffectSpine({
		anim = "play",
		name = "eff_ui_recruitArtifact_wholeIdle_" .. self._artifactCfg.quality + 1,
		isLoop = var_4_0
	})
	self.m_topEffectNode:addEffectSpine({
		anim = "play",
		isLoop = false,
		name = var_4_1
	})
end

function ArtifactRewardLayerItem:_enterActionPlayEnd()
	if self._actionCallBack then
		self._actionCallBack(self._idx)
	end

	if self._info.isNew then
		-- block empty
	else
		self:_playFragEnterAction()
	end
end

function ArtifactRewardLayerItem:_playFragEnterAction()
	self.m_fragBgEffectNode:addEffectSpine({
		anim = "play",
		isLoop = true,
		name = "eff_ui_recruitArtifact_fragIdle_" .. self._artifactCfg.quality + 1
	})
	self.m_topEffectNode:addEffectSpine({
		anim = "play",
		isLoop = false,
		name = "eff_ui_recruitArtifact_fragEnter_" .. self._artifactCfg.quality + 1
	})
	self.m_switchFragTransition:play(handler(self, self._playFragAction))
	self.m_isFragController:setSelectedIndex(2)

	self._fragIndex = 2
end

function ArtifactRewardLayerItem:_playFragAction()
	local var_7_0 = "play_2"

	if self._artifactCfg.quality == 2 then
		var_7_0 = "play_3"
	elseif self._artifactCfg.quality == 3 then
		var_7_0 = "play_4"
	elseif self._artifactCfg.quality == 4 then
		var_7_0 = "play_5"
	end

	self.m_isFragController:setSelectedIndex(1)

	self._fragIndex = 1

	self.m_nameEffectNode:addEffectSpine({
		name = "eff_ui_recruitArtifact_frag",
		isLoop = false,
		anim = var_7_0,
		eventHandler = handler(self, self._fragActionEvent)
	})
end

function ArtifactRewardLayerItem:_fragActionEvent(arg_8_1, arg_8_2)
	if arg_8_1.type == "complete" then
		-- block empty
	end
end

function ArtifactRewardLayerItem:setCtrlIndex(arg_9_1, arg_9_2)
	self.m_isNewController:setSelectedIndex(arg_9_1)
	self.m_bgLoader:setOpacity(255)
	self.m_isFragController:setSelectedIndex(arg_9_2)
	self.m_fragBgLoader:setOpacity(0)
end

function ArtifactRewardLayerItem:resetState()
	self.m_isNewController:setSelectedIndex(self._newIndex)
	self.m_isFragController:setSelectedIndex(self._fragIndex)
	self.m_bgLoader:setOpacity(self._fragIndex ~= 1 and 255 or 0)
	self.m_fragBgLoader:setOpacity(self._fragIndex ~= 0 and 255 or 0)
end

return ArtifactRewardLayerItem
