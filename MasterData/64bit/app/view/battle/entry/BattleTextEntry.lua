local BattlePath = require("app.view.battle.BattlePath")
local BattleConst = require("app.view.battle.const.BattleConst")
local SpineBase = require("app.view.common.SpineBase")
local BattleTextEntry = class("BattleTextEntry", require("app.view.battle.entry.Entry"))
local var_0_4 = BattleConst.TWEEN_TYPE

function BattleTextEntry:ctor(arg_1_1)
	self:setData(arg_1_1)
end

function BattleTextEntry:setData(arg_2_1)
	self._actor = arg_2_1.actor
	self.battleEffectData = arg_2_1.battleEffect
	self._battleLayer = arg_2_1.battleLayer
	self._isDone = false
	self._tweenName = nil
	self._tweenImage = nil
	self._tweenNumber = 0
	self._fontTypeName = nil
	self._otherFontTypeName = nil
	self._isLine = true
	self._tweenType = var_0_4.DEFAULT
	self._startPos = self._actor:getHeadPosition()
	self._index = 0
	self._indexMax = 0
	self._numHurt = arg_2_1.numHurt or 1

	BattleTextEntry.super.ctor(self)
end

function BattleTextEntry:initEntry()
	self.super.initEntry(self)
	self:_preControlData()

	if not self._spineEffect then
		self._spineEffect = self:_createSpine()

		self._spineEffect:retain()
	else
		self:updateSpine()
	end

	self._spineEffect:setPosition(self._startPos)
	self._battleLayer:getCamera():addToTop(self._spineEffect)
	self:getMaxFrame()
	self.addEntryToNewQueue(self, self, self._moveTweenNode)
end

function BattleTextEntry:_moveTweenNode()
	if tolua.isnull(self._actor) then
		self._index = self._indexMax
		self._isDone = true

		return self._isDone
	end

	if self._index + 1 > self._indexMax then
		self._isDone = true
	else
		self._spineEffect:setPosition((self._actor:getCurrentHeadPosition()))
		self:gotoFrame(self._index + 1)
	end

	return self._isDone
end

function BattleTextEntry:getMaxFrame()
	self._indexMax = self._spineEffect:getAnimationDuration() / 0.03333333333333333

	return self._indexMax
end

function BattleTextEntry:gotoFrame(arg_6_1)
	self._spineEffect:resume()

	local var_6_0 = self._spineEffect:getAnimationDuration()
	local var_6_1 = arg_6_1 * 0.03333333333333333

	if arg_6_1 * 0.03333333333333333 < 0 then
		var_6_1 = 0
	end

	if var_6_0 < var_6_1 then
		var_6_1 = var_6_0
	end

	self._spineEffect:play(var_6_1, var_6_1)

	self._index = arg_6_1
end

function BattleTextEntry:_setTweenData(arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5, arg_7_6, arg_7_7)
	self._tweenName = arg_7_2
	self._tweenImage = arg_7_3 and BattlePath:getBuffSpinePath(arg_7_3) or nil
	self._tweenNumber = arg_7_4
	self._fontTypeName = arg_7_5
	self._otherFontTypeName = arg_7_6
	self._isLine = arg_7_7
	self._tweenType = arg_7_1
end

function BattleTextEntry:_hasAddType(arg_8_1, arg_8_2)
	local var_8_0 = not arg_8_2 and (self.battleEffectData.add_effects or {}) or arg_8_2.add_effects or {}

	for iter_8_0 = 1, #var_8_0 do
		if var_8_0[iter_8_0].add_type == arg_8_1 then
			return true, var_8_0[iter_8_0].add_value
		end
	end

	return false
end

function BattleTextEntry:_isDeEffect(arg_9_1)
	if arg_9_1 == 15 then
		return false
	elseif arg_9_1 == 35 then
		return true
	end

	if arg_9_1 <= 8 then
		return arg_9_1 % 2 == 1
	end

	return false
end

function BattleTextEntry:getTweenType(arg_10_1)
	if arg_10_1.effect_type == 15 or arg_10_1.effect_type == 35 then
		return var_0_4.ICON_NUMBER_INLINE .. "putongshanghai"
	elseif arg_10_1.effect_type == 2 or arg_10_1.effect_type == 204 then
		return var_0_4.PURE_NUMBER .. "buff"
	elseif self:_hasAddType(1, arg_10_1) then
		return var_0_4.ICON_NUMBER_NOT_INLINE .. "baoji"
	elseif self:_hasAddType(2, arg_10_1) then
		return var_0_4.PURE_WORD
	elseif self:_hasAddType(13, arg_10_1) then
		return var_0_4.ICON_NUMBER_NOT_INLINE .. "putongshanghai"
	elseif self:_hasAddType(3, arg_10_1) then
		return var_0_4.ICON_NUMBER_NOT_INLINE .. "putongshanghai"
	elseif self:_hasAddType(7, arg_10_1) then
		return var_0_4.PURE_WORD
	elseif self:_hasAddType(17, arg_10_1) then
		return var_0_4.ICON_NUMBER_NOT_INLINE .. "baoji"
	elseif arg_10_1.effect_type == 1 or arg_10_1.effect_type == 203 then
		return var_0_4.PURE_NUMBER .. "putongshanghai"
	elseif arg_10_1.effect_type == 3 then
		if self:_hasAddType(8, arg_10_1) then
			return var_0_4.ICON_NUMBER_INLINE .. "baoji"
		elseif arg_10_1.add_value and arg_10_1.add_value == 0 then
			return var_0_4.ICON_NUMBER_INLINE .. "baoji"
		end
	elseif arg_10_1.effect_type == 4 then
		if self:_hasAddType(8, arg_10_1) then
			return var_0_4.ICON_NUMBER_INLINE .. "buff"
		elseif arg_10_1.add_value and arg_10_1.add_value == 0 then
			return var_0_4.ICON_NUMBER_INLINE .. "buff"
		end
	elseif arg_10_1.effect_type == 5 or arg_10_1.effect_type == 6 then
		-- block empty
	elseif arg_10_1.effect_type == 11 then
		-- block empty
	elseif arg_10_1.effect_type == 102 then
		-- block empty
	elseif arg_10_1.effect_type == 104 then
		-- block empty
	end

	return var_0_4.DEFAULT
end

function BattleTextEntry:_preControlData()
	local var_11_0 = self.battleEffectData.effect_type
	local var_11_1 = self.battleEffectData.add_value
	local var_11_2 = self:_isDeEffect(self.battleEffectData.effect_type) and "-" or "+"
	local var_11_4 = g.core.utils.Number.transTextNumFormation((math.floor(self.battleEffectData.effect_value / self._numHurt)))

	if self.battleEffectData.effect_type == 15 or var_11_0 == 35 then
		var_11_4 = var_11_2 .. var_11_4

		self:_setTweenData(var_0_4.ICON_NUMBER_INLINE, "battletxt_damage", "txt_hudun", var_11_4, "putongshanghai", nil, true)
	elseif var_11_0 == 2 then
		var_11_4 = var_11_2 .. var_11_4

		self:_setTweenData(var_0_4.PURE_NUMBER, "battletxt_cure", nil, var_11_4, "buff", nil, false)
	elseif self:_hasAddType(1) then
		if var_11_0 == 1 or var_11_0 == 3 then
			self:_setTweenData(var_0_4.ICON_NUMBER_NOT_INLINE, "battletxt_critical", "txt_baoji", var_11_4, "baoji", nil, false)
		else
			self:_setTweenData(var_0_4.ICON_NUMBER_NOT_INLINE, "battletxt_critical", "txt_baoji", var_11_4, "baoji", nil, false)
		end
	elseif self:_hasAddType(2) then
		self:_setTweenData(var_0_4.PURE_WORD, "battletxt_dodge", "txt_huibi", nil, nil, nil, false)
	elseif self:_hasAddType(13) then
		local var_11_5, var_11_6 = self:_hasAddType(13)

		var_11_4 = g.core.utils.Number.transTextNumFormation(var_11_6 or 0)

		self:_setTweenData(var_0_4.ICON_NUMBER_NOT_INLINE, "battletxt_shield", "txt_hudun", var_11_4, "putongshanghai", nil, nil, false)
	elseif self:_hasAddType(3) then
		self:_setTweenData(var_0_4.ICON_NUMBER_NOT_INLINE, "battletxt_shield", "txt_gedang_2", var_11_4, "putongshanghai", nil, false)
	elseif self:_hasAddType(7) then
		self:_setTweenData(var_0_4.PURE_WORD, "battletxt_shield", "txt_huibi", nil, nil, nil, false)
	elseif self:_hasAddType(17) then
		self:_setTweenData(var_0_4.ICON_NUMBER_NOT_INLINE, "battletxt_critical", "txt_baoji", var_11_4, "baoji", nil, false)
	elseif var_11_0 == 1 then
		self:_setTweenData(var_0_4.PURE_NUMBER, "battletxt_damage", nil, var_11_4, "putongshanghai", nil, false)
	elseif var_11_0 == 3 then
		if self:_hasAddType(8) then
			self:_setTweenData(var_0_4.ICON_NUMBER_INLINE, "battletxt_damage", "pic_nengliang", var_11_4, "baoji", nil, true)
		elseif var_11_1 and var_11_1 == 0 then
			self:_setTweenData(var_0_4.ICON_NUMBER_INLINE, "battletxt_damage", "pic_nengliang", var_11_4, "baoji", nil, true)
		end
	elseif var_11_0 == 4 then
		if self:_hasAddType(8) then
			self:_setTweenData(var_0_4.ICON_NUMBER_INLINE, "battletxt_damage", "pic_nengliang", var_11_4, "buff", nil, true)
		elseif var_11_1 and var_11_1 == 0 then
			self:_setTweenData(var_0_4.ICON_NUMBER_INLINE, "battletxt_damage", "pic_nengliang", var_11_4, "buff", nil, true)
		end
	elseif var_11_0 == 5 or var_11_0 == 6 then
		-- block empty
	elseif var_11_0 == 11 then
		-- block empty
	elseif var_11_0 == 102 then
		-- block empty
	elseif var_11_0 == 104 then
		-- block empty
	end
end

function BattleTextEntry:updateSpine()
	if self._tweenType == var_0_4.PURE_NUMBER then
		if self._tweenNode then
			self:_updatePureNumberView()
		end
	elseif self._tweenType == var_0_4.PURE_WORD then
		if self._tweenNode then
			self:_updatePureWordView()
		end
	elseif (self._tweenType == var_0_4.ICON_NUMBER_INLINE or self._tweenType == var_0_4.ICON_NUMBER_NOT_INLINE) and self._tweenNode then
		self:_updateIconNumberView()
	end
end

function BattleTextEntry:_createSpine()
	local var_13_1

	if self._tweenType == var_0_4.PURE_NUMBER then
		var_13_1 = self:_createPureNumberView()
		self._tweenNode = var_13_1
	elseif self._tweenType == var_0_4.PURE_WORD then
		var_13_1 = self:_createPureWordView()
		self._tweenNode = var_13_1
	elseif self._tweenType == var_0_4.ICON_NUMBER_INLINE or self._tweenType == var_0_4.ICON_NUMBER_NOT_INLINE then
		var_13_1 = self:_createIconNumberView()
		self._tweenNode = var_13_1
	else
		var_13_1 = cc.Node:create()
	end

	local var_13_2 = {}

	var_13_2.resId = self._tweenName or "battletxt_damage"
	var_13_2.isLoop = false
	var_13_2.path = BattlePath.getSpineTweenPath(self._tweenName or "battletxt_damage")
	var_13_2.anim = BattleConst.SPINE_ACTION_TYPE.PLAY
	var_13_2.listener = handler(self, self._onSpineEvent)

	local var_13_3 = SpineBase.new(var_13_2)

	var_13_3:addNodesAtSlots({
		{
			node = var_13_1,
			slotStr = BattleConst.SPINE_TWEEN_SLOT.NORMAL
		}
	})

	return var_13_3
end

function BattleTextEntry:_createPureNumberView()
	local var_14_0 = cc.Node:create()

	var_14_0:setCascadeOpacityEnabled(true)

	local var_14_1 = cc.Label:createWithBMFont("font/" .. self._fontTypeName .. ".fnt", self._tweenNumber)

	self._pureNumberLabel = var_14_1

	if var_14_1 then
		var_14_1:setAdditionalKerning(-16)
		var_14_0:addChild(var_14_1)
	end

	return var_14_0
end

function BattleTextEntry:_updatePureNumberView()
	if self._pureNumberLabel then
		self._pureNumberLabel:setString(self._tweenNumber)
	end
end

function BattleTextEntry:_createPureWordView()
	local var_16_0 = cc.Node:create()

	var_16_0:setCascadeOpacityEnabled(true)

	if not self._tweenImage then
		return var_16_0
	end

	local var_16_1 = display.newSprite(self._tweenImage)

	self._pureWordSprite = var_16_1

	var_16_1:setAnchorPoint(0.5, 0.5)
	var_16_0:addChild(var_16_1)

	return var_16_0
end

function BattleTextEntry:_updatePureWordView()
	if self._pureWordSprite then
		self._pureWordSprite:setTexture(self._tweenImage)
	end
end

function BattleTextEntry:_createIconNumberView()
	local var_18_1 = cc.Node:create()

	var_18_1:setCascadeOpacityEnabled(true)

	if not self._tweenImage then
		return var_18_1
	end

	local var_18_2 = cc.Node:create()
	local var_18_3 = display.newSprite(self._tweenImage)

	self._iconNumberSprite = var_18_3

	if self._isLine then
		var_18_3:setAnchorPoint(1, 0.5)
		var_18_3:setPosition(0, -7)
	else
		var_18_3:setAnchorPoint(0.5, 0.5)
		var_18_3:setPosition(0, 25)
	end

	local var_18_4 = cc.Label:createWithBMFont("font/" .. self._fontTypeName .. ".fnt", self._tweenNumber)

	self._iconNumberLabel = var_18_4

	var_18_4:setAdditionalKerning(-16)
	var_18_4:setAnchorPoint(0, 0.5)
	var_18_2:addChild(var_18_3)
	var_18_2:addChild(var_18_4)
	var_18_2:setPositionX((var_18_3:getCascadeBoundingBox().width - var_18_4:getCascadeBoundingBox().width) / 2)

	if var_18_2 then
		var_18_2:setScale(self._scale or 1)
		var_18_1:addChild(var_18_2)
	end

	return var_18_1
end

function BattleTextEntry:_updateIconNumberView()
	if self._iconNumberSprite then
		self._iconNumberSprite:setTexture(self._tweenImage)
	end

	if self._iconNumberLabel then
		self._iconNumberLabel:setString(self._tweenNumber)
	end
end

function BattleTextEntry:_onSpineEvent(arg_20_1)
	return
end

function BattleTextEntry:isDone()
	return self._isDone
end

function BattleTextEntry:clearNode()
	if self._spineEffect ~= nil then
		self:_clearSpineEffect()
	end
end

function BattleTextEntry:_clearSpineEffect()
	if not tolua.isnull(self._spineEffect) then
		self._spineEffect:release()

		if not tolua.isnull(self._spineEffect) then
			self._spineEffect:dispose()
		end
	end

	self._spineEffect = nil
end

function BattleTextEntry:destroyEntry()
	BattleTextEntry.super.destroyEntry(self)

	if not tolua.isnull(self._spineEffect) then
		if self._battleLayer and g.core.battle.BattleProxy:isInBattle() then
			self._spineEffect:removeFromParent()

			if not tolua.isnull(self._spineEffect) then
				self._battleLayer:getBattleEntryManager():saveToPool(self._tweenType .. (self._fontTypeName or ""), self)
			end
		else
			self:_clearSpineEffect()
		end
	end

	self._actor = nil
	self.battleEffectData = nil
	self._battleLayer = nil
	self._isDone = false
	self._tweenName = nil
	self._tweenImage = nil
	self._tweenNumber = 0
	self._fontTypeName = nil
	self._otherFontTypeName = nil
	self._isLine = false
	self._startPos = nil
	self._numHurt = nil
	self._index = 0
end

return BattleTextEntry
