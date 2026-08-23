local BattlePassiveCurtainComp = class("BattlePassiveCurtainComp", require("app.fairyGUI.battle.UI_BattlePassiveCurtainComp"))
local var_0_1 = g.core.common.Path

function BattlePassiveCurtainComp:ctor()
	self:setSize(display.width, display.height)
end

function BattlePassiveCurtainComp:updateView(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	local var_2_0 = ""

	if arg_2_1.identity == 1 then
		var_2_0 = "left_" .. arg_2_1.quality + 1

		self.m_isSelfController:setSelectedIndex(1)
	else
		var_2_0 = "right_" .. arg_2_1.quality + 1

		self.m_isSelfController:setSelectedIndex(0)
	end

	self._callback = arg_2_1.callback

	local var_2_1 = self.m_effUP:addEffectSpine({
		remove = true,
		name = "eff_ui_battle_passiveSkillcurtain",
		isLoop = false,
		anim = var_2_0,
		eventHandler = handler(self, self._onAnimEnd)
	})

	var_2_1:addNodesAtSlots({
		{
			slotStr = "slot_txt",
			node = self:_createSkillNameView(arg_2_1.skillInfo.curtain_name)
		}
	})
	var_2_1:addNodesAtSlots({
		{
			slotStr = "slot_icon",
			node = self:_createIconView(arg_2_1.skillInfo, arg_2_1)
		}
	})
end

function BattlePassiveCurtainComp:_onAnimEnd(arg_3_1)
	if arg_3_1.type == "complete" then
		self:newScheduleOnce(handler(self, self.onDelete), 0.1)
	end
end

function BattlePassiveCurtainComp:_createIconView(arg_4_1, arg_4_2)
	local var_4_0
	local var_4_1 = 1

	if arg_4_1.curtain == 13 then
		var_4_1 = 0.4
		var_4_0 = var_0_1:getPetMiddle(arg_4_1.curtain_title)
	elseif arg_4_1.curtain == 12 then
		var_4_1 = 0.5
		var_4_0 = var_0_1:getUniteTokenCardImg(arg_4_1.curtain_title)
	elseif arg_4_1.curtain == 16 then
		var_4_1 = 1

		if arg_4_1.curtain_title ~= 0 then
			var_4_0 = var_0_1:getSuccubaImg(arg_4_1.curtain_title)
		end
	end

	local var_4_2 = display.newSprite(var_4_0)

	var_4_2:setScaleY(var_4_1)
	var_4_2:setScaleX(arg_4_2.identity == 1 and var_4_1 or -var_4_1)
	var_4_2:setAnchorPoint(0.5, 0.5)

	return var_4_2
end

function BattlePassiveCurtainComp:_createSkillNameView(arg_5_1)
	local var_5_0 = cc.Node:create()

	var_5_0:setCascadeOpacityEnabled(true)

	local var_5_1 = cc.Label:createWithTTF(arg_5_1, "font/SourceHanSerifCN-Heavy-4.otf", 24)

	var_5_1:setTextColor(cc.c3b(242, 242, 242))
	var_5_1:enableOutline(cc.c3b(200, 35, 87), 1)

	self._pureNumberLabel = var_5_1

	if var_5_1 then
		var_5_1:setAnchorPoint(0.5, 0.5)
		var_5_0:addChild(var_5_1)
	end

	return var_5_0, self._pureNumberLabel
end

function BattlePassiveCurtainComp:onDelete()
	if self._callback then
		self._callback()
	end

	self:removeFromParent()
end

function BattlePassiveCurtainComp:onLoad()
	return
end

function BattlePassiveCurtainComp:onUnload()
	return
end

return BattlePassiveCurtainComp
