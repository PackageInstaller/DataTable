local BattlePetSkillCurtainComp = class("BattlePetSkillCurtainComp", require("app.fairyGUI.battle.UI_BattlePetSkillCurtainComp"))
local var_0_1 = g.core.common.Path

function BattlePetSkillCurtainComp:ctor()
	self:setSize(display.width, display.height)
end

function BattlePetSkillCurtainComp:updateView(arg_2_1)
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
		name = "eff_ui_battle_passiveSkillcurtain",
		isLoop = false,
		remove = true,
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

function BattlePetSkillCurtainComp:onDelete()
	if self._callback then
		self._callback()
	end

	self:removeFromParent()
end

function BattlePetSkillCurtainComp:_onAnimEnd(arg_4_1)
	if arg_4_1.type == "complete" then
		self:newScheduleOnce(handler(self, self.onDelete), 0.1)
	end
end

function BattlePetSkillCurtainComp:_createIconView(arg_5_1, arg_5_2)
	local var_5_0 = 0.4
	local var_5_1 = display.newSprite((var_0_1:getPetMiddle(arg_5_1.curtain_title)))

	var_5_1:setScaleY(0.4)
	var_5_1:setScaleX(arg_5_2.identity == 1 and var_5_0 or -var_5_0)
	var_5_1:setAnchorPoint(0.5, 0.5)

	return var_5_1
end

function BattlePetSkillCurtainComp:_createSkillNameView(arg_6_1)
	local var_6_0 = cc.Node:create()

	var_6_0:setCascadeOpacityEnabled(true)

	local var_6_1 = cc.Label:createWithTTF(arg_6_1, "font/SourceHanSerifCN-Heavy-4.otf", 24)

	var_6_1:setTextColor(cc.c3b(242, 242, 242))
	var_6_1:enableOutline(cc.c3b(200, 35, 87), 1)

	self._pureNumberLabel = var_6_1

	if var_6_1 then
		var_6_1:setAnchorPoint(0.5, 0.5)
		var_6_0:addChild(var_6_1)
	end

	return var_6_0, self._pureNumberLabel
end

function BattlePetSkillCurtainComp:onLoad()
	return
end

function BattlePetSkillCurtainComp:onUnload()
	return
end

return BattlePetSkillCurtainComp
