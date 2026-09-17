local var_0_0 = {}

require("view.Layer.ActivityMusicalNotes.MusicialNoteSprite")
require("view.Layer.ActivityMusicalNotes.LineSprite")

local bump = require("view.Layer.ActivityMusicalNotes.bump")
local audio_manager = require("controller.audio_manager")
local var_0_3 = require("view.Layer.ObjectPool"):new()

function var_0_3:getObjectByMyType(arg_1_1, arg_1_2, ...)
	local var_1_0 = self:getObject(arg_1_1)

	if var_1_0 then
		return var_1_0
	else
		local var_1_1 = arg_1_2:create(...)

		var_1_1.type = arg_1_1

		self:createObject(var_1_1)
	end

	return self:getObject(arg_1_1)
end

function var_0_3:clearAllActiveObject()
	for iter_2_0, iter_2_1 in pairs(self.activePool) do
		iter_2_1.isActive = false

		iter_2_1:setVisible(false)
	end

	self.activePool = {}
end

local function var_0_4(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.y
	local var_3_1 = false

	for iter_3_0 = 1, #arg_3_1 do
		local var_3_2 = arg_3_1[iter_3_0].x
		local var_3_3 = arg_3_1[iter_3_0].y
		local var_3_4 = arg_3_1[#arg_3_1].x
		local var_3_5 = arg_3_1[#arg_3_1].y

		if arg_3_1[iter_3_0].x == arg_3_0.x and var_3_3 == var_3_0 then
			return true
		end

		if var_3_0 < var_3_3 ~= (var_3_0 < var_3_5) and arg_3_0.x < (var_3_4 - var_3_2) * (var_3_0 - var_3_3) / (var_3_5 - var_3_3) + var_3_2 then
			var_3_1 = not var_3_1
		end
	end

	return var_3_1
end

local var_0_5 = {
	0,
	180,
	240,
	400,
	450,
	550,
	640
}
local var_0_6 = {
	60,
	80,
	100,
	30,
	50,
	40
}
local var_0_7 = 250
local var_0_8 = 70
local var_0_9 = 6

function var_0_0:resetData()
	self.Notes = {}
	self.SelectedNotes = {}
	self.Lines = {}
	self.curMusicialNote = nil
	self.curLineSprite = nil
	self.objPool = nil

	if self.world then
		for iter_4_0, iter_4_1 in pairs(self.world:getItems()) do
			self.world:remove(iter_4_1)
		end

		self.world = nil
	end

	self.world = nil
	self.gamePaused = false
	self.usingGameItem = false
	self.collision_check = true
end

function var_0_0.initData(arg_5_0)
	arg_5_0.Notes = {}
	arg_5_0.SelectedNotes = {}
	arg_5_0.Lines = {}
	arg_5_0.curMusicialNote = nil
	arg_5_0.curLineSprite = nil
	arg_5_0.objPool = var_0_3:new()
	arg_5_0.world = bump.newWorld(64)
	arg_5_0.gamePaused = false
	arg_5_0.usingGameItem = false
	arg_5_0.collision_check = true
end

function var_0_0.registerUIRef(arg_6_0, arg_6_1)
	arg_6_0.uiref = arg_6_1
end

function var_0_0.unregisterUIRef(arg_7_0)
	arg_7_0.uiref = nil
end

function var_0_0:exitGame()
	self:saveLocalData()
	self:unloop()
	self:resetData()
	self:unregisterUIRef()
end

function var_0_0:registerGameEvent(arg_9_1, arg_9_2, arg_9_3)
	self.gameEvents[arg_9_1] = self.gameEvents[arg_9_1] or {}

	table.insert(self.gameEvents[arg_9_1], {
		obj = arg_9_2,
		handler = arg_9_3
	})
end

function var_0_0:unregisterGameEvent(arg_10_1, arg_10_2)
	if self.gameEvents[arg_10_1] then
		for iter_10_0, iter_10_1 in pairs(self.gameEvents[arg_10_1]) do
			if iter_10_1.handler == arg_10_2 then
				table.remove(self.gameEvents[arg_10_1], iter_10_1)
			end
		end
	end
end

function var_0_0:dispatcherEvent(arg_11_1, ...)
	if self.gameEvents[arg_11_1] then
		for iter_11_0, iter_11_1 in pairs(self.gameEvents[arg_11_1]) do
			iter_11_1.handler(iter_11_1.obj, ...)
		end
	end
end

function var_0_0:gameContinue()
	self.gamePaused = false

	if self.curLineSprite then
		self.objPool:recycleObject(self.curLineSprite)
		self.curLineSprite:resetData()

		self.curLineSprite = nil
	end
end

function var_0_0.gamePaused(arg_13_0)
	arg_13_0.gamePaused = true
end

function var_0_0:gameStart()
	if not self.uiref then
		return
	end

	if self.mainloop then
		return
	end

	self:initData()

	local var_14_0 = self:loadLocalData()
	local var_14_1 = {
		{
			10,
			60
		},
		{
			120,
			160
		},
		{
			220,
			260
		},
		{
			330,
			370
		},
		{
			460,
			520
		}
	}
	local var_14_2 = 1

	for iter_14_0 = 1, var_0_8 do
		local var_14_3 = math.floor(iter_14_0 / 5)
		local var_14_4 = self.objPool:getObjectByMyType("note", MusicialNoteSprite, {
			activityId = self.uiref.activityId,
			gameLogicManager = self
		})

		var_14_4:setAnchorPoint(0, 0)
		var_14_4:setPosition(math.random(var_14_1[var_14_2][1], var_14_1[var_14_2][2]), 500 + 30 * iter_14_0)
		table.insert(self.Notes, var_14_4)
		var_14_4:initData()

		if not var_14_4:getParent() then
			self.uiref.rootLayer:addChild(var_14_4, 3)
		end

		if var_14_0 and var_14_0[iter_14_0] then
			var_14_4:setPosition(var_14_0[iter_14_0].x, var_14_0[iter_14_0].y)
			var_14_4:changeNoteType(var_14_0[iter_14_0].type)
		end

		self.world:add(var_14_4, var_14_4:getPositionX(), var_14_4:getPositionY(), var_14_4:getContentSize().width, var_14_4:getContentSize().height)

		var_14_2 = var_14_2 + 1

		if var_14_2 > #var_14_1 then
			var_14_2 = 1
		end
	end

	for iter_14_1 = 1, #var_0_5 - 1 do
		self.world:add({
			name = "grand"
		}, var_0_5[iter_14_1], 0, var_0_5[iter_14_1 + 1] - var_0_5[iter_14_1], var_0_6[iter_14_1])
	end

	self:createMainLoop()
end

function var_0_0:gameUpdate(arg_15_1)
	if self.gamePaused then
		return
	end

	if self.collision_check then
		self.collision_check = false

		for iter_15_0, iter_15_1 in ipairs(self.Notes) do
			if not iter_15_1:update() then
				self.collision_check = true
			end
		end
	end

	for iter_15_2, iter_15_3 in pairs(self.Lines) do
		iter_15_3:updateUIFrame()
	end
end

function var_0_0:useingGameItem()
	if self.gamePaused then
		return
	end

	self.usingGameItem = true

	self.uiref:popUseGameItemMask()
end

function var_0_0:noteSpriteTouch(arg_17_1, arg_17_2)
	if self.gamePaused then
		return
	end

	if self.curMusicialNote and arg_17_1 ~= self.curMusicialNote then
		return
	end

	if self.usingGameItem then
		self:useingGameItemTouch(arg_17_1, arg_17_2)

		return
	end

	if next(self.SelectedNotes) and self.SelectedNotes[#self.SelectedNotes] ~= arg_17_1 then
		self.curMusicialNote = nil

		return
	end

	if arg_17_1._preNode and arg_17_1._nextNode then
		self.curMusicialNote = nil

		return
	end

	self.curMusicialNote = arg_17_1

	if arg_17_2 == ccui.TouchEventType.began then
		self:noteTouchBeganHandle(arg_17_1)

		return
	elseif arg_17_2 == ccui.TouchEventType.moved then
		self:noteTouchMoveHandle(arg_17_1)

		return
	elseif arg_17_2 == ccui.TouchEventType.ended or arg_17_2 == ccui.TouchEventType.canceled then
		self:noteTouchEndHandle(arg_17_1)

		self.curMusicialNote = nil
	end
end

function var_0_0:useingGameItemTouch(arg_18_1, arg_18_2)
	if arg_18_2 == ccui.TouchEventType.canceled then
		self.curMusicialNote = nil

		return
	end

	if arg_18_2 ~= ccui.TouchEventType.ended then
		return
	end

	arg_18_1:changeNoteType(var_0_9)
	self.uiref.use_gameitem_mask:setVisible(false)

	self.usingGameItem = false
end

function var_0_0:noteTouchBeganHandle(arg_19_1, arg_19_2)
	self.curLineSprite = self.objPool:getObjectByMyType("line", LineSprite, {
		activityId = self.uiref.activityId,
		max_line_length = var_0_7
	})

	if not self.curLineSprite:getParent() then
		self.uiref.rootLayer:addChild(self.curLineSprite, 4)
	end

	self.curLineSprite:setStartNode(arg_19_1)
	self.curLineSprite:setVisible(false)
end

function var_0_0:noteTouchMoveHandle(arg_20_1, arg_20_2)
	self.curLineSprite:updateTouch((self.uiref.rootLayer:convertToNodeSpace(cc.p(arg_20_1:getTouchMovePosition().x, arg_20_1:getTouchMovePosition().y))))
	self.curLineSprite:setVisible(true)
end

function var_0_0:noteTouchEndHandle(arg_21_1, arg_21_2)
	hx_print("musicialNotes_gamelogic_manager:noteTouchEndHandle")

	local var_21_0 = self.curLineSprite:getMaxLenghtPos((self.uiref.rootLayer:convertToNodeSpace(cc.p(arg_21_1:getTouchEndPosition().x, arg_21_1:getTouchEndPosition().y))))
	local var_21_1 = self.world:queryPoint(var_21_0.x, var_21_0.y)
	local var_21_2 = (function()
		if #var_21_1 <= 0 then
			return false
		end

		local var_22_0 = var_21_1[1]

		if var_21_1[1].name ~= "note" then
			print("note.name ~= note")

			return false
		end

		if var_22_0 == arg_21_1 then
			print("note == ref")

			return false
		end

		if arg_21_1.noteType ~= var_0_9 and var_22_0.noteType ~= var_0_9 and var_22_0.noteType ~= arg_21_1.noteType then
			print("note.noteType ~= ref.noteType")

			return false
		end

		if var_22_0._nextNode and var_22_0._preNode then
			print("note._nextNode and note._preNode")

			return false
		end

		if var_22_0._nextNode == arg_21_1 or var_22_0._preNode == arg_21_1 then
			print("note._nextNode == ref or note._preNode == ref")

			return false
		end

		return true
	end)()

	hx_print("isCanSelect:")
	print(var_21_2)

	if var_21_2 then
		audio_manager:playeffectMusic("sound/musicialNote_effect1")

		local var_21_3 = var_21_1[1]

		if var_21_1[1]._preNode or var_21_3._nextNode then
			local var_21_4 = self:getNoteDispealNum(var_21_3)

			self.gamePaused = true

			self.uiref:popGameSurePanel({
				count = var_21_4,
				note = var_21_3
			})
		else
			if arg_21_1._nextNode then
				arg_21_1._preNode = var_21_3
				var_21_3._nextNode = arg_21_1
			else
				arg_21_1._nextNode = var_21_3
				var_21_3._preNode = arg_21_1
			end

			local var_21_5 = self.objPool:getObjectByMyType("spine", sp.SkeletonAnimation, "spine/bakery/lizi.json", "spine/bakery/lizi.atlas", 1)

			if not var_21_5:getParent() then
				self.uiref:addChild(var_21_5)
			end

			var_21_5:setAnimation(0, "2", true)
			var_21_5:setPosition(var_21_3:getPositionX() + var_21_3:getContentSize().width / 2, var_21_3:getPositionY() + var_21_3:getContentSize().height / 2)
			var_21_5:registerSpineEventHandler(function()
				return
			end, SP_ANIMATION_COMPLETE)
			table.insert(self.SelectedNotes, var_21_3)

			self.curLineSprite.endNode = var_21_3

			table.insert(self.Lines, self.curLineSprite)

			self.curLineSprite = nil

			if var_21_3.noteType == var_0_9 then
				var_21_3.noteType = arg_21_1.noteType
			end
		end
	else
		self.objPool:recycleObject(self.curLineSprite)
		self.curLineSprite:resetData()

		self.curLineSprite = nil
	end
end

function var_0_0:getNoteDispealNum(arg_24_1)
	local var_24_0 = {}
	local var_24_1 = 0

	for iter_24_0, iter_24_1 in pairs(self.SelectedNotes) do
		table.insert(var_24_0, {
			x = iter_24_1:getPositionX() + iter_24_1:getContentSize().width / 2,
			y = iter_24_1:getPositionY() + iter_24_1:getContentSize().height / 2
		})
	end

	table.insert(var_24_0, {
		x = arg_24_1:getPositionX() + arg_24_1:getContentSize().width / 2,
		y = arg_24_1:getPositionY() + arg_24_1:getContentSize().height / 2
	})

	for iter_24_2, iter_24_3 in ipairs(self.Notes) do
		if var_0_4({
			x = iter_24_3:getPositionX() + iter_24_3:getContentSize().width / 2,
			y = iter_24_3:getPositionY() + iter_24_3:getContentSize().height / 2
		}, var_24_0) then
			var_24_1 = var_24_1 + 1
		end
	end

	return var_24_1
end

function var_0_0:NoteDispealSuccess(arg_25_1)
	audio_manager:playeffectMusic("sound/musicialNote_effect2")

	self.gamePaused = false

	table.insert(self.SelectedNotes, arg_25_1)

	self.curLineSprite.endNode = arg_25_1

	table.insert(self.Lines, self.curLineSprite)

	local var_25_0 = {}

	for iter_25_0, iter_25_1 in pairs(self.SelectedNotes) do
		table.insert(var_25_0, {
			x = iter_25_1:getPositionX() + iter_25_1:getContentSize().width / 2,
			y = iter_25_1:getPositionY() + iter_25_1:getContentSize().height / 2
		})
	end

	local var_25_1 = {}
	local var_25_2 = {}

	for iter_25_2 = #self.Notes, 1, -1 do
		local var_25_3 = {
			x = self.Notes[iter_25_2]:getPositionX() + self.Notes[iter_25_2]:getContentSize().width / 2,
			y = self.Notes[iter_25_2]:getPositionY() + self.Notes[iter_25_2]:getContentSize().height / 2
		}

		if var_0_4(var_25_3, var_25_0) then
			table.insert(var_25_2, self.Notes[iter_25_2])
			table.remove(self.Notes, iter_25_2)
			self.objPool:recycleObject(self.Notes[iter_25_2])
			self.world:remove(self.Notes[iter_25_2])
			table.insert(var_25_1, var_25_3)
		end
	end

	for iter_25_3, iter_25_4 in pairs(self.Lines) do
		self.objPool:recycleObject(iter_25_4)
		iter_25_4:resetData()
	end

	self.SelectedNotes = {}

	for iter_25_5 = 1, #var_25_2 do
		local var_25_4 = self.objPool:getObjectByMyType("note", MusicialNoteSprite, {
			activityId = self.uiref.activityId,
			gameLogicManager = self
		})

		var_25_4:setAnchorPoint(0, 0)
		var_25_4:setPosition(math.random(30, 510), math.random(1000, 1400))
		self.world:add(var_25_4, var_25_4:getPositionX(), var_25_4:getPositionY(), var_25_4:getContentSize().width, var_25_4:getContentSize().height)
		table.insert(self.Notes, var_25_4)
		var_25_4:initData()

		if not var_25_4:getParent() then
			self.uiref.rootLayer:addChild(var_25_4, 3)
		end
	end

	self.collision_check = true

	self.objPool:clearAllActiveObjectByType("spine")

	for iter_25_6, iter_25_7 in pairs(var_25_1) do
		local var_25_5 = self.objPool:getObjectByMyType("spine", sp.SkeletonAnimation, "spine/bakery/lizi.json", "spine/bakery/lizi.atlas", 1)

		if not var_25_5:getParent() then
			self.uiref:addChild(var_25_5)
		end

		var_25_5:setAnimation(0, "1", true)
		var_25_5:setPosition(iter_25_7)
		var_25_5:registerSpineEventHandler(function()
			self.objPool:recycleObject(var_25_5)
		end, SP_ANIMATION_COMPLETE)
	end
end

function var_0_0:musicialNotesRefresh()
	for iter_27_0, iter_27_1 in ipairs(self.Notes) do
		self.objPool:recycleObject(iter_27_1)
		self.world:remove(iter_27_1)
	end

	for iter_27_2, iter_27_3 in pairs(self.Lines) do
		self.objPool:recycleObject(iter_27_3)
		iter_27_3:resetData()
	end

	if self.curLineSprite then
		self.objPool:recycleObject(self.curLineSprite)
		self.curLineSprite:resetData()

		self.curLineSprite = nil
	end

	self.objPool:clearAllActiveObjectByType("spine")

	self.Notes = {}
	self.SelectedNotes = {}
	self.Lines = {}
	self.collision_check = true

	local var_27_0 = {
		{
			10,
			60
		},
		{
			120,
			160
		},
		{
			220,
			260
		},
		{
			330,
			370
		},
		{
			460,
			520
		}
	}
	local var_27_1 = 1

	for iter_27_4 = 1, var_0_8 do
		local var_27_2 = math.floor(iter_27_4 / 5)
		local var_27_3 = self.objPool:getObjectByMyType("note", MusicialNoteSprite, {
			activityId = self.uiref.activityId,
			gameLogicManager = self
		})

		var_27_3:setAnchorPoint(0, 0)
		var_27_3:setPosition(math.random(var_27_0[var_27_1][1], var_27_0[var_27_1][2]), 500 + 30 * iter_27_4)
		table.insert(self.Notes, var_27_3)
		var_27_3:initData()

		if not var_27_3:getParent() then
			self.uiref.rootLayer:addChild(var_27_3, 3)
		end

		self.world:add(var_27_3, var_27_3:getPositionX(), var_27_3:getPositionY(), var_27_3:getContentSize().width, var_27_3:getContentSize().height)

		var_27_1 = var_27_1 + 1

		if var_27_1 > #var_27_0 then
			var_27_1 = 1
		end
	end
end

function var_0_0:clearLines()
	for iter_28_0, iter_28_1 in pairs(self.Lines) do
		self.objPool:recycleObject(iter_28_1)
		iter_28_1:resetData()
	end

	if self.curLineSprite then
		self.objPool:recycleObject(self.curLineSprite)
		self.curLineSprite:resetData()

		self.curLineSprite = nil
	end

	for iter_28_2, iter_28_3 in ipairs(self.Notes) do
		iter_28_3._preNode = nil
		iter_28_3._nextNode = nil
	end

	self.objPool:clearAllActiveObjectByType("spine")

	self.SelectedNotes = {}
	self.Lines = {}
end

function var_0_0:createMainLoop()
	self.mainloop = self.mainloop or cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_30_0)
		self:gameUpdate(arg_30_0)
	end, 0, false)
end

function var_0_0:unloop()
	if self.mainloop then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.mainloop)

		self.mainloop = nil
	end
end

function var_0_0:saveLocalData()
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in ipairs(self.Notes) do
		local var_32_1 = iter_32_1:getPositionX()
		local var_32_2 = iter_32_1:getPositionY()

		if var_32_1 >= 0 and var_32_1 <= 640 and var_32_2 >= 0 and var_32_2 <= 3000 then
			table.insert(var_32_0, {
				x = iter_32_1:getPositionX(),
				y = iter_32_1:getPositionY(),
				type = iter_32_1.noteType
			})
		end
	end

	RoleDefault:getInstance():setStringForKey("musicialNote" .. self.uiref.activityId, json.encode(var_32_0))
end

function var_0_0:loadLocalData()
	local var_33_0 = RoleDefault:getInstance():getStringForKey("musicialNote" .. self.uiref.activityId, "")

	if var_33_0 == "" then
		return
	end

	local var_33_1, var_33_2 = pcall(json.decode, var_33_0)

	if var_33_1 then
		return var_33_2
	else
		print("JSON 解码错误: " .. var_33_2)

		return
	end
end

return var_0_0
