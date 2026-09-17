local var_0_0 = config._DEBUG and 0 or 1
local var_0_1 = 5

MusicialNoteSprite = class("MusicialNoteSprite", function(arg_1_0)
	return ccui.ImageView:create(("ActivityMusicalNotesLayer_" .. arg_1_0.activityId .. "/") .. "note1.png", var_0_0)
end)

function MusicialNoteSprite.create(arg_2_0, arg_2_1)
	local var_2_0 = MusicialNoteSprite.new(arg_2_1)

	var_2_0:init(arg_2_1)

	return var_2_0
end

function MusicialNoteSprite:init(arg_3_1)
	self.activityId = arg_3_1.activityId
	self.respath = "ActivityMusicalNotesLayer_" .. arg_3_1.activityId .. "/"
	self.gameLogicManager = arg_3_1.gameLogicManager

	self:setAnchorPoint(0, 0)
	self:setTouchEnabled(true)
	self:addTouchEventListener(function(arg_4_0, arg_4_1)
		self.gameLogicManager:noteSpriteTouch(arg_4_0, arg_4_1)
	end)
end

function MusicialNoteSprite:initData(arg_5_1)
	self.noteType = math.random(var_0_1)
	self._preNode = nil
	self._nextNode = nil

	self:loadTexture(self.respath .. "note" .. self.noteType .. ".png", var_0_0)

	self.normal_speed = -10
	self.name = "note"
end

function MusicialNoteSprite.setPreNode(arg_6_0, arg_6_1)
	arg_6_0._preNode = arg_6_1
end

function MusicialNoteSprite.setNextNode(arg_7_0, arg_7_1)
	arg_7_0._nextNode = arg_7_1
end

function MusicialNoteSprite:update()
	local var_8_0 = true

	if self:getPositionY() < 0 then
		return var_8_0
	end

	local var_8_1, var_8_2, var_8_3, var_8_4 = self.gameLogicManager.world:move(self, self:getPositionX(), self:getPositionY() + self.normal_speed)

	if var_8_4 <= 0 then
		var_8_0 = false
	end

	self:setPosition(math.floor(var_8_1), (math.floor(var_8_2)))
	self:setVisible(self:getPositionY() < 880 + GameDisplay.fix_y)

	return var_8_0
end

function MusicialNoteSprite:changeNoteType(arg_9_1)
	self.noteType = arg_9_1

	self:loadTexture(self.respath .. "note" .. self.noteType .. ".png", var_0_0)
end
