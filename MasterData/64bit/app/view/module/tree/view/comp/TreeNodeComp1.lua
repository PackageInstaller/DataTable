local var_0_0 = g.core.const.ConstMgr.TreeConst
local TreeTalentComp = class("TreeTalentComp", require("app.fairyGUI.tree.UI_TreeNodeComp1"))

function TreeTalentComp:ctor()
	self._nodeStruct = nil
	self._qualityCtrl = self.m_qualityBg:getController("quality")
	self._selectedComp = nil
	self._upgradeLoader = nil

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

function TreeTalentComp:setSelected(arg_4_1)
	if arg_4_1 then
		if not self._selectedComp then
			self._selectedComp = fgui.UIPackage:createObject("tree", "TreeNodeSelectComp", self)

			self:addChildAt(self._selectedComp, 0)
			self._selectedComp:setPosition(self:getWidth() / 2, self:getHeight() / 2)
			self._selectedComp:setScale(0.5)
			self._selectedComp:setTouchable(false)
			self._selectedComp:getChild("effPick"):addEffectSpine({
				name = "eff_ui_tree_pick",
				anim = "play",
				remove = false,
				isLoop = true
			})
		end

		self._selectedComp:setVisible(true)
	elseif self._selectedComp then
		self._selectedComp:setVisible(false)
	end
end

function TreeTalentComp:_onClickComp()
	self:dispatchCompEvent(var_0_0.EVENT.NODE_CLICK, {
		pos = self:getPosition(),
		nodeStruct = self._nodeStruct
	})
end

function TreeTalentComp:updateNode(arg_6_1)
	self._nodeStruct = arg_6_1

	self:setQuality(self._nodeStruct:getQuality())
	self:setLight(self._nodeStruct:isLight())
	self:setLevel(true, self._nodeStruct:getLevel(), self._nodeStruct:getMaxLevel())
	self:updateCanLightAndUpgrade()
	self.m_icon:setURL(arg_6_1:getIcon())
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			advId = self._nodeStruct:getAdvanceId()
		}
	})
end

function TreeTalentComp:updateStageUpNode(arg_7_1)
	self._nodeStruct = arg_7_1

	local var_7_0 = arg_7_1:getQuality()

	if self._qualityCtrl:getSelectedIndex() < var_7_0 then
		self.m_eff:addEffectSpine({
			anim = "play",
			remove = true,
			isLoop = false,
			name = "eff_ui_tree_pin" .. var_7_0
		})
		self.m_upTransition:play()
	end

	self:setQuality(var_7_0)
	self:setLight(self._nodeStruct:isLight())
	self:setLevel(true, self._nodeStruct:getLevel(), self._nodeStruct:getMaxLevel())
	self:updateCanLightAndUpgrade()
	self.m_icon:setURL(arg_7_1:getIcon())
end

function TreeTalentComp:updateByValue(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
	self:setQuality(arg_8_1)
	self:setLight(arg_8_2)
	self:setLevel(arg_8_5, arg_8_3, arg_8_4)
	self.m_icon:setURL(arg_8_6)
end

function TreeTalentComp:setLevel(arg_9_1, arg_9_2, arg_9_3)
	self.m_curLevel:setText(arg_9_2)
	self.m_curLevel:setVisible(arg_9_1)
	self.m_maxLevel:setText(g.core.lang:get(201028, {
		num = arg_9_3
	}))
	self.m_maxLevel:setVisible(arg_9_1)
end

function TreeTalentComp:updateCanLightAndUpgrade()
	if self._nodeStruct:isCanUpgradeLevel() or self._nodeStruct:isCanUpgradeStage() then
		if not self._upgradeLoader then
			self._upgradeLoader = fgui.GLoader:create()

			self._upgradeLoader:setAutoSize(true)
			self._upgradeLoader:setAutoRelease(true)
			self._upgradeLoader:setURL("ui://tree/pic_xp_keshengji")
			self._upgradeLoader:setScale(0.5)
			self:addChild(self._upgradeLoader)
			self._upgradeLoader:setPivot(0.5, 0.5, true)
			self._upgradeLoader:setPosition(self:getWidth() / 2, self:getHeight() / 2)
			self._upgradeLoader:addEffectSpine({
				name = "eff_ui_tree_beActivated",
				anim = "play",
				remove = false,
				isLoop = true
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
