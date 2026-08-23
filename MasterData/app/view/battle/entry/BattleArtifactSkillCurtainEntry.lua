local BattlePath = require("app.view.battle.BattlePath")
local BattleConst = require("app.view.battle.const.BattleConst")
local SpineBase = require("app.view.common.SpineBase")
local BattleArtifactSkillCurtainEntry = class("BattleArtifactSkillCurtainEntry", require("app.view.battle.entry.Entry"))

function BattleArtifactSkillCurtainEntry:ctor(arg_1_1)
	self:setData(arg_1_1)
end

function BattleArtifactSkillCurtainEntry:setData(arg_2_1)
	self._battleLayer = arg_2_1.battleLayer
	self._identity = arg_2_1.identity
	self._skillInfo = arg_2_1.skillInfo
	self._skillIcon = self._skillInfo.icon
	self._knightInfo = arg_2_1.knightInfo
	self._skillName = arg_2_1.skillName
	self._isMonster = arg_2_1.isMonster
	self._actor = arg_2_1.actor
	self._isDone = false
	self._isSkillTween5 = arg_2_1.isSkillTween5
	self._tweenName = arg_2_1.tweenName
	self._anim = arg_2_1.anim
	self._startPos = self._actor:getHeadPosition()
	self._index = 0
	self._indexMax = 0

	BattleArtifactSkillCurtainEntry.super.ctor(self)
end

function BattleArtifactSkillCurtainEntry:initEntry()
	self.super.initEntry(self)

	local var_3_0 = 0

	if not self._spineEffect then
		self._spineEffect, var_3_0 = self:_createSpine()

		self._spineEffect:retain()
	else
		var_3_0 = self:updateSpine()
	end

	self._spineEffect:setPosition(self._startPos.x - var_3_0, self._startPos.y)
	self._battleLayer:getCamera():addToTop(self._spineEffect)
	self:getMaxFrame()
	self.addEntryToNewQueue(self, self, self._moveTweenNode)
end

function BattleArtifactSkillCurtainEntry:updateSpine()
	local var_4_0 = BattlePath:getSkillIcon(self._skillIcon)

	if self._skillName then
		self._pureNumberLabel:setString(self._skillName)
	end

	if var_4_0 then
		self._iconSprite:setTexture(var_4_0)
	end

	return (self:_resetPosition(self._pureNumberLabel))
end

function BattleArtifactSkillCurtainEntry:_moveTweenNode()
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

function BattleArtifactSkillCurtainEntry:getMaxFrame()
	self._indexMax = self._spineEffect:getAnimationDuration() / 0.03333333333333333

	return self._indexMax
end

function BattleArtifactSkillCurtainEntry:gotoFrame(arg_7_1)
	self._spineEffect:resume()

	local var_7_0 = self._spineEffect:getAnimationDuration()
	local var_7_1 = arg_7_1 * 0.03333333333333333

	if arg_7_1 * 0.03333333333333333 < 0 then
		var_7_1 = 0
	end

	if var_7_0 < var_7_1 then
		var_7_1 = var_7_0
	end

	self._spineEffect:play(var_7_1, var_7_1)

	self._index = arg_7_1
end

function BattleArtifactSkillCurtainEntry:_createSpine()
	local var_8_1 = self:_createIconView()
	local var_8_2, var_8_3 = self:_createSkillNameView()
	local var_8_4 = self:_createSkillTipView()
	local var_8_5 = self:_resetPosition(var_8_3)
	local var_8_6 = {
		resId = self._tweenName
	}

	var_8_6.isLoop = false
	var_8_6.path = BattlePath.getSpineTweenPath(self._tweenName)
	var_8_6.anim = self._anim and self._anim or self._identity == 1 and BattleConst.SPINE_ACTION_TYPE.PLAY or BattleConst.SPINE_ACTION_TYPE.PLAY
	var_8_6.listener = handler(self, self._onSpineEvent)

	local var_8_7 = SpineBase.new(var_8_6)

	var_8_7:addNodesAtSlots({
		{
			slotStr = "txt_slot",
			node = var_8_2
		}
	})
	var_8_7:addNodesAtSlots({
		{
			slotStr = "icon_slot",
			node = var_8_1
		}
	})

	return var_8_7, var_8_5
end

function BattleArtifactSkillCurtainEntry:_createSkillTipView()
	local var_9_0 = cc.Node:create()

	var_9_0:setCascadeOpacityEnabled(true)

	local var_9_1 = cc.Label:createWithTTF("skill", "font/SourceHanSerifCN-Heavy-4.otf", 10)

	var_9_1:setOpacity(128)
	var_9_1:setTextColor(cc.c3b(242, 242, 242))

	if var_9_1 then
		var_9_0:addChild(var_9_1)
	end

	return var_9_0
end

function BattleArtifactSkillCurtainEntry:_createSkillNameView()
	local var_10_0 = cc.Node:create()

	var_10_0:setCascadeOpacityEnabled(true)

	local var_10_1 = cc.Label:createWithTTF(self._skillName, "font/SourceHanSerifCN-Heavy-4.otf", 24)

	var_10_1:setTextColor(cc.c3b(242, 242, 242))
	var_10_1:enableOutline(cc.c3b(200, 35, 87), 1)

	self._pureNumberLabel = var_10_1

	if var_10_1 then
		var_10_0:addChild(var_10_1)
	end

	return var_10_0, self._pureNumberLabel
end

function BattleArtifactSkillCurtainEntry:_resetPosition(arg_11_1)
	if arg_11_1:getCascadeBoundingBox().width < 120 then
		arg_11_1:setAnchorPoint(0.5, 0.5)
		arg_11_1:setPosition(0, 0)
	else
		arg_11_1:setAnchorPoint(0, 0.5)
		arg_11_1:setPosition(-45, 0)
	end

	return 0
end

function BattleArtifactSkillCurtainEntry:_createIconView()
	local var_12_0 = cc.Node:create()

	var_12_0:setCascadeOpacityEnabled(true)

	local var_12_1 = BattlePath:getSkillIcon(self._skillIcon)

	if not cc.FileUtils:getInstance():isFileExist(var_12_1) then
		var_12_1 = nil
	end

	local var_12_2 = display.newSprite(var_12_1)
	local var_12_3 = cc.ClippingNode:create()

	var_12_3:addChild(var_12_2)
	var_12_3:setStencil((display.newSprite("battle/common/bg_bdlm_skill2_1.png")))
	var_12_3:setInverted(false)
	var_12_3:setAlphaThreshold(0.5)
	var_12_2:setAnchorPoint(0.5, 0.5)

	self._iconSprite = var_12_2

	if var_12_3 then
		var_12_0:addChild(var_12_3)
	end

	return var_12_0
end

function BattleArtifactSkillCurtainEntry:_updateIconNumberView()
	if self._iconNumberSprite then
		self._iconNumberSprite:setTexture(self._tweenImage)
	end

	if self._iconNumberLabel then
		self._iconNumberLabel:setString(self._tweenNumber)
	end
end

function BattleArtifactSkillCurtainEntry:_onSpineEvent(arg_14_1)
	return
end

function BattleArtifactSkillCurtainEntry:isDone()
	return self._isDone
end

function BattleArtifactSkillCurtainEntry:clearNode()
	if self._spineEffect ~= nil then
		self:_clearSpineEffect()
	end
end

function BattleArtifactSkillCurtainEntry:_clearSpineEffect()
	if not tolua.isnull(self._spineEffect) then
		self._spineEffect:release()

		if not tolua.isnull(self._spineEffect) then
			self._spineEffect:dispose()
		end
	end

	self._spineEffect = nil
end

function BattleArtifactSkillCurtainEntry:destroyEntry()
	BattleArtifactSkillCurtainEntry.super.destroyEntry(self)

	if not tolua.isnull(self._spineEffect) then
		if self._battleLayer and g.core.battle.BattleProxy:isInBattle() then
			self._spineEffect:removeFromParent()

			if not tolua.isnull(self._spineEffect) then
				self._battleLayer:getBattleEntryManager():saveToPool("artifactAttackCurtain", self)
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
	self._startPos = nil
	self._index = 0
end

return BattleArtifactSkillCurtainEntry
