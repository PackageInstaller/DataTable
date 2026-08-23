local BattlePath = require("app.view.battle.BattlePath")
local BattleConst = require("app.view.battle.const.BattleConst")
local SpineBase = require("app.view.common.SpineBase")
local MarkEntry = class("MarkEntry", require("app.view.battle.entry.Entry"))
local var_0_4 = BattleConst.TWEEN_TYPE

function MarkEntry:ctor(arg_1_1)
	self:setData(arg_1_1)
end

function MarkEntry:setData(arg_2_1)
	self._actor = arg_2_1.actor
	self._img = arg_2_1.markIcon
	self._markDesc = arg_2_1.markDesc
	self._isDone = false
	self._battleLayer = arg_2_1.battleLayer
	self._scale = arg_2_1.scale
	self.buffIncreaseType = arg_2_1.buffIncreaseType
	self._tweenName = "battletxt_buff"
	self._index = 0
	self._indexMax = 0
	self._hasInit = false

	MarkEntry.super.ctor(self)
end

function MarkEntry:initEntry()
	self.super.initEntry(self)
	self.addEntryToNewQueue(self, self, self.step)
end

function MarkEntry:_init()
	if self._hasInit then
		return
	end

	self._hasInit = self._hasInit or true

	if not self._spineEffect then
		self._spineEffect = self:_createSpine()

		self._spineEffect:retain()
	else
		self:updateSpine()
	end

	self._spineEffect:setPosition(cc.p(0, 80))
	self._actor:addChild(self._spineEffect)
	self:getMaxFrame()
end

function MarkEntry:updateSpine()
	if self.buffIncreaseType == 1 then
		self._buffIconLabel:enableOutline(cc.c3b(0, 181, 43), 1)
	else
		self._buffIconLabel:enableOutline(cc.c3b(202, 11, 11), 1)
	end

	local var_5_0 = BattlePath:getBuffSpinePath(self._img)

	self._buffIconLabel:setString(self._markDesc)
	self._buffIconSprite:setTexture(var_5_0)
end

function MarkEntry:step()
	if tolua.isnull(self._actor) then
		self._index = self._indexMax
		self._isDone = true

		return self._isDone
	end

	self:_init()

	if self._index + 1 > self._indexMax then
		self._isDone = true
	else
		self:gotoFrame(self._index + 1)
	end

	return self._isDone
end

function MarkEntry:getMaxFrame()
	self._indexMax = self._spineEffect:getAnimationDuration() / 0.03333333333333333

	return self._indexMax
end

function MarkEntry:gotoFrame(arg_8_1)
	self._spineEffect:resume()

	local var_8_0 = self._spineEffect:getAnimationDuration()
	local var_8_1 = arg_8_1 * 0.03333333333333333

	if arg_8_1 * 0.03333333333333333 < 0 then
		var_8_1 = 0
	end

	if var_8_0 < var_8_1 then
		var_8_1 = var_8_0
	end

	self._spineEffect:play(var_8_1, var_8_1)

	self._index = arg_8_1
end

function MarkEntry:_createSpine()
	local var_9_1 = {}

	var_9_1.resId = self._tweenName or "battletxt_buff"
	var_9_1.isLoop = false
	var_9_1.path = BattlePath.getSpineTweenPath(self._tweenName or "battletxt_buff")
	var_9_1.anim = BattleConst.SPINE_ACTION_TYPE.PLAY

	local var_9_2 = SpineBase.new(var_9_1)

	var_9_2:addNodesAtSlots({
		{
			node = self:_createHandler(),
			slotStr = BattleConst.SPINE_TWEEN_SLOT.NORMAL
		}
	})

	return var_9_2
end

function MarkEntry:_createHandler(arg_10_1)
	local var_10_1 = cc.Node:create()

	var_10_1:setCascadeOpacityEnabled(true)

	local var_10_2 = display.newSprite("battle/common/bg_tubiaodi.png")

	var_10_2:setAnchorPoint(0.5, 0.5)
	var_10_2:setContentSize(cc.size(22, 22))
	var_10_2:setCascadeColorEnabled(true)
	var_10_2:setCascadeOpacityEnabled(true)

	local var_10_3 = display.newSprite((BattlePath:getBuffSpinePath(self._img)))

	self._buffIconSprite = var_10_3

	var_10_3:setAnchorPoint(0.5, 0.5)
	var_10_3:setPosition(11, 11)

	local var_10_4 = cc.Label:createWithTTF(self._markDesc, "font/SourceHanSerifCN-Heavy-4.otf", 28)

	var_10_4:setAnchorPoint(0, 0.5)
	var_10_4:setTextColor(cc.c3b(242, 242, 242))

	self._buffIconLabel = var_10_4

	if self.buffIncreaseType == 1 then
		var_10_4:enableOutline(cc.c3b(0, 181, 43), 1)
	else
		var_10_4:enableOutline(cc.c3b(202, 11, 11), 1)
	end

	var_10_4:setPosition(cc.p(25, 11))
	var_10_2:addChild(var_10_3)
	var_10_2:addChild(var_10_4)
	var_10_2:setPositionX(-1 * (var_10_2:getCascadeBoundingBox().width - 22) / 2)
	var_10_1:addChild(var_10_2)

	return var_10_1
end

function MarkEntry:isDone()
	return self._isDone
end

function MarkEntry:clearNode()
	if self._spineEffect ~= nil then
		self:_clearSpineEffect()
	end
end

function MarkEntry:_clearSpineEffect()
	if not tolua.isnull(self._spineEffect) then
		self._spineEffect:release()

		if not tolua.isnull(self._spineEffect) then
			self._spineEffect:dispose()
		end
	end

	self._spineEffect = nil
end

function MarkEntry:destroyEntry()
	MarkEntry.super.destroyEntry(self)

	if not tolua.isnull(self._spineEffect) then
		if self._battleLayer and g.core.battle.BattleProxy:isInBattle() then
			self._spineEffect:removeFromParent()

			if not tolua.isnull(self._spineEffect) then
				self._battleLayer:getBattleEntryManager():saveToPool(var_0_4.MARK_TWEEN, self)
			end
		else
			self:_clearSpineEffect()
		end
	end

	self._actor = nil
	self._isDone = false
	self._tweenName = nil
	self._img = nil
	self._markDesc = nil
	self.buffIncreaseType = nil
	self._battleLayer = nil
	self._scale = 1
end

return MarkEntry
