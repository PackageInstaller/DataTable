local var_0_0 = g.core.common.Color
local var_0_1 = g.core.const.ConstMgr.AllianceConst
local var_0_2 = g.core.model.User.allianceData
local AllianceHonourBubbleRoot = class("AllianceHonourBubbleRoot", require("app.fairyGUI.alliance.UI_AllianceHonourBubbleRoot"))

function AllianceHonourBubbleRoot:ctor()
	self._colorCompDict = {}
end

function AllianceHonourBubbleRoot:addBubble(arg_2_1, arg_2_2)
	arg_2_2 = arg_2_2 or 0

	local var_2_0 = var_0_2:getHonourTextGroup(arg_2_1)
	local var_2_1 = math.random(1, #var_2_0)
	local var_2_2 = self:_getBubbleComp(var_2_0[var_2_1]["color_" .. math.random(1, var_0_1.HONOUR.COLOR_NUM)])

	self.m_normalRoot:addChild(var_2_2)
	var_2_2:setTitle(var_2_0[var_2_1].text)
	var_2_2:setPosition(display.width + 100, math.random(100, display.height - 100))
	var_2_2:runFGAction((fgui.FSequence:create({
		fgui.FDelayTime:create(arg_2_2),
		fgui.FMoveBy:create(math.random(5, 8), cc.p(-display.width - var_2_2:getWidth() - 100, 0)),
		fgui.FCallFunc:create(handler(self, function(arg_3_0)
			arg_3_0:_recoverComp(var_2_2)
			arg_3_0:addBubble(arg_2_1)
		end))
	})))
end

function AllianceHonourBubbleRoot:addSelfBubble(arg_4_1)
	local var_4_0 = var_0_2:getHonourTextGroup(arg_4_1)
	local var_4_1 = math.random(1, #var_4_0)
	local var_4_2 = fgui.UIPackage:createObject("alliance", "AllianceHonourSelfBubbleComp")

	self.m_underLineRoot:addChild(var_4_2)
	var_4_2:setTitleColor(var_0_0.hexToCC3(var_4_0[var_4_1]["color_" .. math.random(1, var_0_1.HONOUR.COLOR_NUM)]))
	var_4_2:setTitle(var_4_0[var_4_1].text)
	var_4_2:setPosition(display.width + 100, math.random(100, display.height - 100))
	var_4_2:runFGAction((fgui.FSequence:create({
		fgui.FDelayTime:create(0.1),
		fgui.FMoveBy:create(math.random(5, 8), cc.p(-display.width - var_4_2:getWidth() - 100, 0)),
		fgui.FCallFunc:create(handler(self, function(arg_5_0)
			var_4_2:removeFromParent()
		end))
	})))
end

function AllianceHonourBubbleRoot:_getBubbleComp(arg_6_1)
	self._colorCompDict[arg_6_1] = self._colorCompDict[arg_6_1] or {}

	local var_6_0 = table.remove(self._colorCompDict[arg_6_1])

	if not var_6_0 then
		var_6_0 = fgui.UIPackage:createObject("alliance", "AllianceHonourBubbleComp")

		self.m_normalRoot:addAutoRetain(var_6_0)
		var_6_0:setTitleColor(var_0_0.hexToCC3(arg_6_1))
		var_6_0:setName(arg_6_1)
	end

	return var_6_0
end

function AllianceHonourBubbleRoot:_recoverComp(arg_7_1)
	arg_7_1:removeFromParent()
	arg_7_1:stopAllFGActions()

	local var_7_0 = arg_7_1:getName()

	self._colorCompDict[var_7_0] = self._colorCompDict[var_7_0] or {}

	table.insert(self._colorCompDict[var_7_0], arg_7_1)
end

function AllianceHonourBubbleRoot:clearBubble()
	for iter_8_0, iter_8_1 in ipairs(self.m_normalRoot:getChildren() or {}) do
		self:_recoverComp(iter_8_1)
	end

	self.m_underLineRoot:removeChildren()
end

return AllianceHonourBubbleRoot
