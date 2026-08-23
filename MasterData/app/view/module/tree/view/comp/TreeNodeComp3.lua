local var_0_0 = g.core.const.ConstMgr.TreeConst
local var_0_1 = g.core.model.User.treeData
local TreeTalentComp = class("TreeTalentComp", require("app.fairyGUI.tree.UI_TreeNodeComp3"))

function TreeTalentComp:ctor()
	self._nodeStruct = nil
	self._qualityCtrl = self.m_qualityBg:getController("quality")

	self:initView()
end

function TreeTalentComp:initView()
	self:addClickListener(handler(self, self._onClickComp))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
end

function TreeTalentComp:_onTouchBegin(arg_3_1)
	self:dispatchCompEvent(var_0_0.EVENT.NODE_TOUCH_BEGIN, {
		pos = self:getPosition(),
		nodeStruct = self._nodeStruct
	})
end

function TreeTalentComp:_onClickComp()
	self:dispatchCompEvent(var_0_0.EVENT.NODE_CLICK, {
		pos = self:getPosition(),
		nodeStruct = self._nodeStruct
	})
end

function TreeTalentComp:updateNode(arg_5_1)
	self._nodeStruct = arg_5_1

	self:setLight((self._nodeStruct:isLight()))
	self:setQuality(self._nodeStruct:getQuality())
	self.m_nodeName:setText(self._nodeStruct:getInfo().node_name)
	self:updateCanLightAndUpgrade()
	self:updateBigNodeQuality()
	self.m_icon:setURL(arg_5_1:getIcon())
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			advId = self._nodeStruct:getAdvanceId()
		}
	})
end

function TreeTalentComp:updateStageUpNode(arg_6_1)
	self._nodeStruct = arg_6_1

	local var_6_0 = arg_6_1:getQuality()

	if self._qualityCtrl:getSelectedIndex() < var_6_0 then
		self.m_eff:addEffectSpine({
			anim = "play",
			remove = true,
			isLoop = false,
			name = "eff_ui_tree_pin" .. var_6_0
		})
		self.m_upTransition:play()
	end

	self:setLight(self._nodeStruct:isLight())
	self:setQuality(var_6_0)
	self:updateCanLightAndUpgrade()
	self:updateBigNodeQuality()
	self.m_icon:setURL(arg_6_1:getIcon())
end

function TreeTalentComp:updateByValue(arg_7_1, arg_7_2, arg_7_3)
	self:setLight(arg_7_2)
	self:setQuality(arg_7_1)
	self.m_icon:setURL(arg_7_3)
end

function TreeTalentComp:updateBigNodeQuality()
	local var_8_0 = var_0_0.CENTER_ID[self._nodeStruct:getAdvanceId()]

	self.m_node1:updateComp(var_0_1:getNodeByAdvanceId(var_8_0 + 1):getQuality())
	self.m_node2:updateComp(var_0_1:getNodeByAdvanceId(var_8_0 + 2):getQuality())
	self.m_node3:updateComp(var_0_1:getNodeByAdvanceId(var_8_0 + 3):getQuality())
end

function TreeTalentComp:setBigNodeQualityUp(arg_9_1)
	local var_9_0 = arg_9_1:getAdvanceId() - var_0_0.CENTER_ID[self._nodeStruct:getAdvanceId()]

	if var_9_0 == 1 then
		self.m_node1:updateComp(arg_9_1:getQuality(), true)
	elseif var_9_0 == 2 then
		self.m_node2:updateComp(arg_9_1:getQuality(), true)
	elseif var_9_0 == 3 then
		self.m_node3:updateComp(arg_9_1:getQuality(), true)
	end
end

function TreeTalentComp:setSelected(arg_10_1)
	if arg_10_1 then
		if not self._selectedComp then
			self._selectedComp = fgui.UIPackage:createObject("tree", "TreeNodeSelectComp", self)

			self:addChildAt(self._selectedComp, 1)
			self._selectedComp:setPosition(self:getWidth() / 2, self:getHeight() / 2)
			self._selectedComp:setScale(1)
			self._selectedComp:setTouchable(false)
			self._selectedComp:getChild("effPick"):addEffectSpine({
				anim = "play",
				name = "eff_ui_tree_pick",
				remove = false,
				isLoop = true
			})
		end

		self._selectedComp:setVisible(true)
		self.m_nodeName:setVisible(false)
	else
		if self._selectedComp then
			self._selectedComp:setVisible(false)
		end

		self.m_nodeName:setVisible(true)
	end
end

function TreeTalentComp:updateCanLightAndUpgrade()
	if self._nodeStruct:isCanUpgradeStage() then
		if not self._upgradeLoader then
			self._upgradeLoader = fgui.GLoader:create()

			self._upgradeLoader:setAutoSize(true)
			self._upgradeLoader:setAutoRelease(true)
			self._upgradeLoader:setURL("ui://tree/pic_xp_keshengji")
			self._upgradeLoader:setScale(1)
			self:addChild(self._upgradeLoader)
			self._upgradeLoader:setPivot(0.5, 0.5, true)
			self._upgradeLoader:setPosition(self:getWidth() / 2, self:getHeight() / 2)
			self._upgradeLoader:addEffectSpine({
				anim = "play",
				name = "eff_ui_tree_beActivated",
				remove = false,
				isLoop = true
			}):setPosition(self._upgradeLoader:getWidth() / 2, self._upgradeLoader:getHeight() / 2)
		end

		self._upgradeLoader:setVisible(true)
	elseif self._upgradeLoader then
		self._upgradeLoader:setVisible(false)
	end
end

function TreeTalentComp:setLight(arg_12_1)
	if arg_12_1 then
		self.m_isActiveController:setSelectedIndex(1)
	else
		self.m_isActiveController:setSelectedIndex(0)
	end
end

function TreeTalentComp:setQuality(arg_13_1)
	self._qualityCtrl:setSelectedIndex(arg_13_1)
end

return TreeTalentComp
