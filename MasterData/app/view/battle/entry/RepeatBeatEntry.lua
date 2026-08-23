local BattleConst = require("app.view.battle.const.BattleConst")
local RepeatBeatEntry = class("RepeatBeatEntry", require("app.view.battle.entry.MoreStageEntry"))

function RepeatBeatEntry:ctor(arg_1_1)
	self._identity = nil
	self._tweenData = nil
	self._numberText = nil

	self:_initData(arg_1_1)
	RepeatBeatEntry.super.ctor(self, self._tweenData)
end

function RepeatBeatEntry:_initData(arg_2_1)
	local var_2_0 = arg_2_1.battleLayer

	self._identity = arg_2_1.identity or 1

	local var_2_1 = cc.Director:getInstance():getSafeAreaRect()
	local var_2_3 = self._identity == 1 and cc.p(0 + var_2_1.x, display.height - 150) or cc.p(display.width - var_2_1.x - ((g.core.battle.BattleProxy:getType() == BattleConst.TYPE_DUNGEON or nil) and display.width * 0.025), display.height - 150)

	self._tweenData = {
		battleLayer = var_2_0,
		startPos = var_2_3,
		tweenName = "battletxt_combo",
		createWordFunc = handler(self, self._createTweenWord),
		createNumberFunc = handler(self, self.createTweenNumber),
		container = arg_2_1.container,
		identity = self._identity
	}
end

function RepeatBeatEntry:createTweenNumber()
	local var_3_0 = cc.Node:create()

	var_3_0:setCascadeOpacityEnabled(true)

	local var_3_1 = display.newSprite("battle/buff_icon/txt_lianji.png")

	if self._identity == 1 then
		var_3_1:setAnchorPoint(cc.p(0, 0.5))
	else
		var_3_1:setAnchorPoint(cc.p(1, 0.5))
	end

	var_3_0:addChild(var_3_1)

	return var_3_0
end

function RepeatBeatEntry:_createTweenWord()
	local var_4_0 = cc.Label:createWithBMFont("font/combo.fnt", 1)

	var_4_0:setScale(0.6)

	self._numberText = var_4_0

	local var_4_1 = cc.Node:create()

	var_4_1:setCascadeOpacityEnabled(true)
	var_4_1:addChild(var_4_0)

	return var_4_1
end

function RepeatBeatEntry:showNumber(arg_5_1)
	if self._numberText then
		self._numberText:setString(arg_5_1.num)
		self:playNumberAnimation()
	end

	if arg_5_1.hurt then
		local var_5_0 = require("app.view.battle.entry.RepeatHurtEntry").new({
			battleLayer = self._battleLayer,
			isUnit = self._isUnit,
			identity = self._identity,
			hurt = arg_5_1.hurt,
			container = self._container,
			numHurt = arg_5_1.numHurt,
			time = arg_5_1.time,
			isAdd = arg_5_1.isAdd
		})

		self:addEntryToNewQueue(var_5_0, var_5_0.updateEntry)
	end

	self._delay = 30
end

function RepeatBeatEntry:step()
	if self._delay then
		self._delay = self._delay - 1

		if self._delay <= 0 then
			self._delay = nil

			self:setSpineAnimation(self._identity == 1 and BattleConst.SPINE_ACTION_TYPE.PLAY_OUT_L or BattleConst.SPINE_ACTION_TYPE.PLAY_OUT_R)

			return false
		end
	end

	return self._isDone
end

function RepeatBeatEntry:destroyEntry()
	RepeatBeatEntry.super.destroyEntry(self)

	self._identity = nil
	self._tweenData = nil
	self._numberText = nil
end

return RepeatBeatEntry
