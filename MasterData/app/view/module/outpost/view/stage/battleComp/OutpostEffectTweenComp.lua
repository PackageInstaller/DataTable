local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_1 = g.core.common.Path
local SpineBase = require("app.view.common.SpineBase")
local var_0_3 = table.concat
local var_0_4 = g.core.const.ConstMgr.outpostConst.TweenType
local OutpostEffectTweenComp = class("OutpostEffectTweenComp")

function OutpostEffectTweenComp:ctor()
	self._tweenType = var_0_4.Number
	self._fontTypeName = ""
	self._tweenNumber = 0
	self._tweenImage = nil
	self._isLine = true
	self._pureNumberLabel = nil
	self._pureWordSprite = nil
	self._iconNumberSprite = nil
	self._iconNumberLabel = nil
end

function OutpostEffectTweenComp:initComp(arg_2_1)
	local var_2_0 = arg_2_1.endCall
	local var_2_1 = arg_2_1.poolKey

	self._spineNode = SpineBase.new({
		isLoop = false,
		anim = "play",
		resId = arg_2_1.effectTweenName,
		path = var_0_1:getOutpostEffectTween(arg_2_1.effectTweenName),
		listener = function(self)
			if self.type == "complete" and var_2_0 then
				var_2_0(var_2_1, self)
			end
		end
	})

	self:addNode(self._spineNode)

	self._tweenType = arg_2_1.tweenType
	self._fontTypeName = arg_2_1.fontTypeName
	self._tweenNumber = 0
	self._tweenImage = arg_2_1.tweenImage and var_0_3({
		"battle/buff_icon/",
		arg_2_1.tweenImage,
		".png"
	})

	local var_2_2

	if self._tweenType == var_0_4.Number then
		var_2_2 = self:_createPureNumberView()
		self._tweenNode = var_2_2
	elseif self._tweenType == var_0_4.Word then
		var_2_2 = self:_createPureWordView()
		self._tweenNode = var_2_2
	elseif self._tweenType == var_0_4.IconNumberLine then
		self._isLine = true
		var_2_2 = self:_createIconNumberView()
		self._tweenNode = var_2_2
	elseif self._tweenType == var_0_4.IconNumberNoLine then
		self._isLine = false
		var_2_2 = self:_createIconNumberView()
		self._tweenNode = var_2_2
	else
		var_2_2 = cc.Node:create()
	end

	self._spineNode:addNodesAtSlots({
		{
			node = var_2_2,
			slotStr = BattleConst.SPINE_TWEEN_SLOT.NORMAL
		}
	})
end

function OutpostEffectTweenComp:playEffect(arg_4_1)
	self._tweenNumber = arg_4_1.effectValue

	if self._tweenType == var_0_4.Number then
		if self._tweenNode then
			self:_updatePureNumberView()
		end
	elseif self._tweenType == var_0_4.Word then
		if self._tweenNode then
			self:_updatePureWordView()
		end
	elseif (self._tweenType == var_0_4.IconNumberLine or self._tweenType == var_0_4.IconNumberNoLine) and self._tweenNode then
		self:_updateIconNumberView()
	end

	self._spineNode:setAnimation(0, "play", false)
end

function OutpostEffectTweenComp:_createPureNumberView()
	local var_5_0 = cc.Node:create()

	var_5_0:setCascadeOpacityEnabled(true)

	local var_5_1 = cc.Label:createWithBMFont("font/" .. self._fontTypeName .. ".fnt", self._tweenNumber)

	self._pureNumberLabel = var_5_1

	if var_5_1 then
		var_5_1:setAdditionalKerning(-16)
		var_5_0:addChild(var_5_1)
	end

	return var_5_0
end

function OutpostEffectTweenComp:_updatePureNumberView()
	if self._pureNumberLabel then
		self._pureNumberLabel:setString(self._tweenNumber)
	end
end

function OutpostEffectTweenComp:_createPureWordView()
	local var_7_0 = cc.Node:create()

	var_7_0:setCascadeOpacityEnabled(true)

	if not self._tweenImage then
		return var_7_0
	end

	local var_7_1 = display.newSprite(self._tweenImage)

	self._pureWordSprite = var_7_1

	var_7_1:setAnchorPoint(0.5, 0.5)
	var_7_0:addChild(var_7_1)

	return var_7_0
end

function OutpostEffectTweenComp:_updatePureWordView()
	if self._pureWordSprite then
		self._pureWordSprite:setTexture(self._tweenImage)
	end
end

function OutpostEffectTweenComp:_createIconNumberView()
	local var_9_1 = cc.Node:create()

	var_9_1:setCascadeOpacityEnabled(true)

	if not self._tweenImage then
		return var_9_1
	end

	local var_9_2 = cc.Node:create()
	local var_9_3 = display.newSprite(self._tweenImage)

	self._iconNumberSprite = var_9_3

	if self._isLine then
		var_9_3:setAnchorPoint(1, 0.5)
		var_9_3:setPosition(0, -7)
	else
		var_9_3:setAnchorPoint(0.5, 0.5)
		var_9_3:setPosition(0, 25)
	end

	local var_9_4 = cc.Label:createWithBMFont("font/" .. self._fontTypeName .. ".fnt", self._tweenNumber)

	self._iconNumberLabel = var_9_4

	var_9_4:setAdditionalKerning(-16)
	var_9_4:setAnchorPoint(0, 0.5)
	var_9_2:addChild(var_9_3)
	var_9_2:addChild(var_9_4)
	var_9_2:setPositionX((var_9_3:getCascadeBoundingBox().width - var_9_4:getCascadeBoundingBox().width) / 2)

	if var_9_2 then
		var_9_2:setScale(self._scale or 1)
		var_9_1:addChild(var_9_2)
	end

	return var_9_1
end

function OutpostEffectTweenComp:_updateIconNumberView()
	if self._iconNumberSprite then
		self._iconNumberSprite:setTexture(self._tweenImage)
	end

	if self._iconNumberLabel then
		self._iconNumberLabel:setString(self._tweenNumber)
	end
end

return OutpostEffectTweenComp
