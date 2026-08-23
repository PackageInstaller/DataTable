local var_0_0 = g.core.const.ConstMgr.SpineConst
local SpineBase = require("app.view.common.SpineBase")
local var_0_2 = 1
local DisplayBase = class("DisplayBase", function()
	return cc.Node:create()
end)

function DisplayBase:ctor()
	self._content = nil
	self._size = nil
	self._onwer = nil

	if ... then
		self:updateDisplay(...)
	end

	self:enableNodeEvents()
	self:setTag(var_0_2)

	var_0_2 = var_0_2 + 1
end

function DisplayBase:onEnter()
	return
end

function DisplayBase:onExit()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)
	self:removeGuideComp()
end

function DisplayBase:updateDisplay()
	if self._content then
		self._content:removeFromParent()
	end
end

function DisplayBase:_calcSize()
	if not self._content then
		self._size = cc.size(0, 0)

		return
	end

	self._size = self._content:getContentSize()
end

function DisplayBase:getSize()
	return self._size
end

function DisplayBase:setContentNode(arg_8_1)
	if self._content then
		return
	end

	self._content = arg_8_1

	self:addChild(arg_8_1)
end

function DisplayBase:playCollide(arg_9_1, arg_9_2)
	return
end

function DisplayBase:playHurt(arg_10_1)
	return
end

function DisplayBase:onPlayShow(arg_11_1)
	return
end

function DisplayBase:onPlayDestory(arg_12_1)
	return
end

function DisplayBase:_onPlayMove(arg_13_1, arg_13_2)
	return
end

function DisplayBase:setOwner(arg_14_1)
	self._onwer = arg_14_1
end

function DisplayBase:getOwner()
	return self._owner
end

function DisplayBase:getContent()
	return self._content
end

function DisplayBase:onPlayEffectSpine(arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5, arg_17_6)
	local var_17_0
	local var_17_1 = handler(self, self._onEffectSpineEventCall)

	var_17_0 = SpineBase.new({
		resId = arg_17_1,
		path = g.core.common.Path:getEffSpine(arg_17_1),
		isLoop = arg_17_2,
		listener = function(self, arg_18_1)
			if self.type == var_0_0.SPINE_EVENT.COMPLETE and arg_17_6 then
				arg_17_6()
			end

			var_17_1(var_17_0, arg_17_5, self, arg_18_1)
		end
	})

	self:addChild(nil)

	if arg_17_4 then
		local var_17_2 = cc.p(self:getScaleX(), self:getScaleY())

		arg_17_3 = cc.p(self._size.width * var_17_2.x * arg_17_4.x, self._size.height * var_17_2.y * arg_17_4.y)
	end

	if arg_17_3 then
		var_17_0:setPosition(arg_17_3)
	end
end

function DisplayBase:_onEffectSpineEventCall(arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	if arg_19_2 then
		arg_19_2(arg_19_3, arg_19_4)
	end

	if arg_19_3 == var_0_0.SPINE_EVENT.COMPLETE and not arg_19_4 then
		arg_19_1:dispose()
	end
end

function DisplayBase:setHide()
	self._content:setOpacity(0)
end

function DisplayBase:createGuideComp()
	if not self._guideComp then
		fgui.UIPackage:addPackage("ui/guide/guide")

		local var_21_0 = fgui.UIPackage:createObject("guide", "GuideBattleActorComp")

		g.core.layer.LayerManager:getGuideLayer():addChild(var_21_0)

		local var_21_1 = self._content:getContentSize()

		var_21_1.width = var_21_1.width * self._content:getScaleX()
		var_21_1.height = var_21_1.height * self._content:getScaleY()

		var_21_0:setSize(var_21_1)
		var_21_0:setPivot(0.5, 0.5, true)
		var_21_0:setRotation((self._content:getRotation()))

		self._guideComp = var_21_0
	end
end

function DisplayBase:setGuideCompVisible(arg_22_1)
	if self._guideComp then
		self._guideComp:setVisible(arg_22_1)
	end
end

function DisplayBase:onTriggerGuide(arg_23_1)
	self:_fixGuideCompPos()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_TICK, false, {
		key = arg_23_1,
		targetBtn = self._guideComp
	})
end

function DisplayBase:_fixGuideCompPos()
	local var_24_0 = self:convertToWorldSpace(cc.p(self._content:getPosition()))

	var_24_0.y = display.height * 1.5 - var_24_0.y + 5
	var_24_0.x = var_24_0.x + display.width / 2

	self._guideComp:setPosition(var_24_0)
	self._guideComp:setVisible(true)
end

function DisplayBase:removeGuideComp()
	if self._guideComp then
		self._guideComp:removeFromParent()
	end

	self._guideComp = nil
end

return DisplayBase
