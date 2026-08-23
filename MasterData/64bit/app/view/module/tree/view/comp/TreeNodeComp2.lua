local var_0_0 = g.core.const.ConstMgr.TreeConst
local TreeTalentComp = class("TreeTalentComp", require("app.fairyGUI.tree.UI_TreeNodeComp2"))

function TreeTalentComp:ctor()
	self._nodeStruct = nil
	self._stageCompList = {}
	self._stageCompList[1] = self.m_stageComp1
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

	self:setLight(self._nodeStruct:isLight())
	self:setQuality((self._nodeStruct:getQuality()))
	self.m_talentName:setText(self._nodeStruct:getInfo().node_name)
	self:updateStage(self._nodeStruct:getStage(), self._nodeStruct:getQualityStageList())
	self:updateCanLightAndUpgrade()
	self.m_icon:setURL(self._nodeStruct:getIcon())
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
	self.m_talentName:setText(self._nodeStruct:getInfo().node_name)
	self:updateStage(self._nodeStruct:getStage(), self._nodeStruct:getQualityStageList())
	self:updateCanLightAndUpgrade()
	self.m_icon:setURL(self._nodeStruct:getIcon())
end

function TreeTalentComp:updateByValue(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	self:setLight(arg_7_2)
	self:setQuality(arg_7_1)
	self:updateStage(arg_7_3, arg_7_5:getQualityStageList(arg_7_1))
	self.m_icon:setURL(arg_7_4)
end

function TreeTalentComp:updateStage(arg_8_1, arg_8_2)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_2) do
		var_8_0[iter_8_1.node_stage] = iter_8_0
	end

	local var_8_1 = math.max(#arg_8_2 - 1, #self._stageCompList)

	self.m_stageGroup:setVisible(#arg_8_2 - 1 > 0)

	for iter_8_2 = 1, var_8_1 do
		local var_8_2 = self._stageCompList[iter_8_2]
		local var_8_3 = arg_8_2[iter_8_2]

		if not self._stageCompList[iter_8_2] then
			var_8_2 = fgui.UIPackage:createObject("tree", "TreeNodeStageComp", self)

			self:addChild(var_8_2)
			table.insert(self._stageCompList, var_8_2)
			var_8_2:setGroup(self.m_stageGroup)
		end

		if var_8_3 then
			var_8_2:setVisible(true)
			var_8_2:getController("isActive"):setSelectedIndex(arg_8_1 >= var_8_3.node_stage and 1 or 0)
		else
			var_8_2:setVisible(false)
		end
	end
end

function TreeTalentComp:setSelected(arg_9_1)
	if arg_9_1 then
		if not self._selectedComp then
			self._selectedComp = fgui.UIPackage:createObject("tree", "TreeNodeSelectComp", self)

			self:addChildAt(self._selectedComp, 0)
			self._selectedComp:setPosition(self:getWidth() / 2, self:getHeight() / 2)
			self._selectedComp:setScale(0.7)
			self._selectedComp:setTouchable(false)
			self._selectedComp:getChild("effPick"):addEffectSpine({
				anim = "play",
				remove = false,
				isLoop = true,
				name = "eff_ui_tree_pick"
			})
		end

		self._selectedComp:setVisible(true)
		self.m_isHideNameController:setSelectedIndex(1)
	else
		if self._selectedComp then
			self._selectedComp:setVisible(false)
		end

		self.m_isHideNameController:setSelectedIndex(0)
	end
end

function TreeTalentComp:updateCanLightAndUpgrade()
	if self._nodeStruct:isCanUpgradeStage() then
		if not self._upgradeLoader then
			self._upgradeLoader = fgui.GLoader:create()

			self._upgradeLoader:setAutoSize(true)
			self._upgradeLoader:setAutoRelease(true)
			self._upgradeLoader:setURL("ui://tree/pic_xp_keshengji")
			self._upgradeLoader:setScale(0.7)
			self:addChild(self._upgradeLoader)
			self._upgradeLoader:setPivot(0.5, 0.5, true)
			self._upgradeLoader:setPosition(self:getWidth() / 2, self:getHeight() / 2)
			self._upgradeLoader:addEffectSpine({
				anim = "play",
				remove = false,
				isLoop = true,
				name = "eff_ui_tree_beActivated"
			}):setPosition(self._upgradeLoader:getWidth() / 2, self._upgradeLoader:getHeight() / 2)
		end

		self._upgradeLoader:setVisible(true)
	elseif self._upgradeLoader then
		self._upgradeLoader:setVisible(false)
	end
end

function TreeTalentComp:setLight(arg_11_1)
	if arg_11_1 then
		self.m_isActiveController:setSelectedIndex(1)
	else
		self.m_isActiveController:setSelectedIndex(0)
	end
end

function TreeTalentComp:setQuality(arg_12_1)
	self._qualityCtrl:setSelectedIndex(arg_12_1)
end

return TreeTalentComp
