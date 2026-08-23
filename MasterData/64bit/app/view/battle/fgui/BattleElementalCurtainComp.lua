local BattleEffect = require("app.view.battle.BattleEffect")
local var_0_1 = g.core.common.Color
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_3 = g.core.common.Path
local BattleElementalCurtainComp = class("BattleElementalCurtainComp", require("app.fairyGUI.battle.UI_BattleElementalCurtainComp"))

function BattleElementalCurtainComp:ctor()
	self._isDelete = false

	self:setSize(display.width, display.height)
end

function BattleElementalCurtainComp:updateView(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._callback = arg_2_1.callback

	local var_2_0 = arg_2_1.elemental or 1
	local var_2_1 = arg_2_1.skillName or ""
	local var_2_2 = self:_createIconView(arg_2_1.skillInfo.icon)
	local var_2_3 = self:_createSkillNameView(var_2_1)

	var_2_3:setScaleX(arg_2_1.identity == 1 and 1 or -1)

	self._spineEff = BattleEffect.new({
		path = g.core.common.Path:getEffSpine("eff_ui_battle_elementalcurtain_" .. var_2_0),
		listener = handler(self, self._onSpineEvent)
	})

	self._spineEff:addNodesAtSlots({
		{
			slotStr = "slot_icon",
			node = var_2_2
		}
	})
	self._spineEff:addNodesAtSlots({
		{
			slotStr = "slot_txt",
			node = var_2_3
		}
	})
	self.m_effNode:addNode(self._spineEff)
end

function BattleElementalCurtainComp:_createSkillNameView(arg_3_1)
	local var_3_0 = cc.Node:create()

	var_3_0:setCascadeOpacityEnabled(true)

	local var_3_1 = cc.Label:createWithTTF(arg_3_1, "font/SourceHanSerifCN-Heavy-4.otf", 34)

	var_3_1:setAnchorPoint(0.5, 0.5)
	var_3_1:setTextColor(var_0_1.A6)

	if var_3_1 then
		var_3_0:addChild(var_3_1)
	end

	return var_3_0
end

function BattleElementalCurtainComp:_createIconView(arg_4_1)
	local var_4_0 = var_0_3:getSkillIconById(arg_4_1)

	if not cc.FileUtils:getInstance():isFileExist(var_4_0) then
		var_4_0 = nil
	end

	local var_4_1 = display.newSprite(var_4_0)

	var_4_1:setAnchorPoint(0.5, 0.5)

	return var_4_1
end

function BattleElementalCurtainComp:_onSpineEvent(arg_5_1)
	if arg_5_1.type == BattleConst.SPINE_EVENT.COMPLETE then
		self:onDelete()
	end
end

function BattleElementalCurtainComp:onDelete()
	if self._isDelete then
		return
	end

	self._isDelete = true

	if self._callback then
		self._callback()
	end

	self:removeFromParent()
end

return BattleElementalCurtainComp
