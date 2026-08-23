local BattlePassiveLeaderCurtainComp = class("BattlePassiveLeaderCurtainComp", require("app.fairyGUI.battle.UI_BattlePassiveLeaderCurtainComp"))
local var_0_1 = g.core.common.Path

function BattlePassiveLeaderCurtainComp:ctor()
	self:setSize(display.width, display.height)
end

function BattlePassiveLeaderCurtainComp:updateView(arg_2_1)
	arg_2_1 = arg_2_1 or {}

	local var_2_0 = ""

	if arg_2_1.identity == 1 then
		var_2_0 = "left"

		self.m_isSelfController:setSelectedIndex(1)
	else
		var_2_0 = "right"

		self.m_isSelfController:setSelectedIndex(0)
	end

	self._callback = arg_2_1.callback
	self._knightInfo = arg_2_1.knightInfo
	self._playInfo = arg_2_1.playInfo
	self._actor = arg_2_1.actor

	local var_2_1 = self.m_effUP:addEffectSpine({
		remove = true,
		isLoop = false,
		name = "eff_ui_battleWarBand_passiveSkillcurtain",
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
			slotStr = "slot_role",
			node = self:_createRoleView(arg_2_1.skillInfo, arg_2_1)
		}
	})
	var_2_1:addNodesAtSlots({
		{
			slotStr = "slot_icon",
			node = self:_createIconView(arg_2_1.skillInfo, arg_2_1)
		}
	})
end

function BattlePassiveLeaderCurtainComp:_onAnimEnd(arg_3_1)
	if arg_3_1.type == "complete" then
		self:newScheduleOnce(handler(self, self.onDelete), 0.1)
	end
end

function BattlePassiveLeaderCurtainComp:_createRoleView(arg_4_1, arg_4_2)
	local var_4_0
	local var_4_1 = 1

	if arg_4_1.curtain == 41 then
		var_4_1 = 1

		local var_4_2 = self._actor:getBaseInfo().skin

		if var_4_2 <= 0 then
			var_4_2 = self._knightInfo.advance_id
		end

		var_4_0 = var_0_1:getLeaderCurtain(var_4_2)
	end

	local var_4_3 = display.newSprite(var_4_0)

	var_4_3:setScaleY(var_4_1)
	var_4_3:setScaleX(arg_4_2.identity == 1 and var_4_1 or -var_4_1)
	var_4_3:setAnchorPoint(0.5, 0.5)

	return var_4_3
end

function BattlePassiveLeaderCurtainComp:_createIconView(arg_5_1, arg_5_2)
	local var_5_1 = 1

	if arg_5_1.curtain == 41 then
		var_5_1 = 1

		local var_5_2 = var_0_1:getKnightElementIcon(self._knightInfo.classical)
	end

	local var_5_3 = display.newSprite("battle/common/icon_duizhang.png")

	var_5_3:setScaleY(var_5_1)
	var_5_3:setScaleX(arg_5_2.identity == 1 and var_5_1 or -var_5_1)
	var_5_3:setAnchorPoint(0.5, 0.5)

	return var_5_3
end

function BattlePassiveLeaderCurtainComp:_createSkillNameView(arg_6_1)
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

function BattlePassiveLeaderCurtainComp:onDelete()
	if self._callback then
		self._callback()
	end

	self:removeFromParent()
end

function BattlePassiveLeaderCurtainComp:onLoad()
	return
end

function BattlePassiveLeaderCurtainComp:onUnload()
	return
end

return BattlePassiveLeaderCurtainComp
