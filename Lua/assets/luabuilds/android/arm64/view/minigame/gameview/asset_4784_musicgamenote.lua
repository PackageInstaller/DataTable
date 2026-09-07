local MusicGameNote = class("MusicGameNote")

MusicGameNote.easyTriggerStepTime = nil
MusicGameNote.type_left = 1
MusicGameNote.type_right = 2
MusicGameNote.type_pu_normal = 1
MusicGameNote.type_pu_both = 2
MusicGameNote.type_dgree_easy = 1
MusicGameNote.type_dgree_hard = 2

local var_0_1 = 1
local var_0_2 = 2
local var_0_3 = 3
local var_0_4 = 4
local var_0_5 = 4
local var_0_6 = 0
local var_0_7 = 1
local var_0_8 = 2
local var_0_9 = {
	500,
	800,
	1250,
	1450
}
local var_0_10 = {
	0.26,
	0.2,
	0.15,
	0.13
}
local var_0_11 = 3
local var_0_12
local var_0_13 = false

local function var_0_14(arg_1_0)
	local var_1_0 = {
		_tf = arg_1_0
	}

	var_1_0.type = nil
	var_1_0.beginTime = nil
	var_1_0.endTime = nil
	var_1_0.longFlag = nil
	var_1_0.removeTime = nil
	var_1_0.speedOffsetX = nil
	var_1_0.longTime = 0
	var_1_0.triggerDown = nil
	var_1_0.triggerUp = nil
	var_1_0.fixedScoreType = nil

	function var_1_0:Ctor()
		self.longTf = findTF(self._tf, "longNote")
		self.singleTf = findTF(self._tf, "singleNote")

		return
	end

	function var_1_0:stepUpdate(arg_3_1)
		if not isActive(self._tf) then
			self:changeActive(true)
		end

		local var_3_0 = (arg_3_1 - self.beginTime) * self.speedOffsetX

		if (arg_3_1 - self.beginTime) * self.speedOffsetX > 0 then
			var_3_0 = 0
		end

		self._tf.localPosition = Vector3(var_3_0, 0, 0)

		if self.longFlag then
			local var_3_1

			if var_3_0 == 0 then
				var_3_1 = (self.endTime - arg_3_1) * self.speedOffsetX

				if not self.triggerDown and not self.removeTime then
					self.removeTime = arg_3_1 + var_0_12
				end
			else
				var_3_1 = (self.endTime - self.beginTime) * self.speedOffsetX
			end

			if var_3_1 < 0 then
				var_3_1 = 0
			end

			self.longTf.sizeDelta = Vector2(var_3_1, self.longTf.sizeDelta.y)

			if var_3_1 == 0 and not self.triggerUp and not self.removeTime then
				self.removeTime = arg_3_1 + var_0_12
			end
		elseif var_3_0 == 0 and not self.removeTime then
			self.removeTime = arg_3_1 + var_0_12
		end

		return
	end

	function var_1_0:setNoteData(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		self.removeTime = nil
		self.triggerDown = nil
		self.triggerUp = nil
		self.fixedScoreType = nil

		if arg_4_1.key_flag == "K_BOTH" then
			self.keyType = MusicGameNote.type_pu_both or MusicGameNote.type_pu_normal
		end

		self.beginTime = tonumber(arg_4_1.begin_time)
		self.endTime = tonumber(arg_4_1.end_time)
		self.longTime = self.endTime - self.beginTime
		self.longFlag = arg_4_1.begin_time ~= arg_4_1.end_time
		self.speedOffsetX = arg_4_2
		self.dgree = arg_4_3
		self.directType = arg_4_4
		self.imgType = self:getImageType()
		self._tf.localPosition = Vector3(0, 0, 0)
		self._tf.name = "beginTime" .. self.beginTime

		self:updateNoteTf()

		return
	end

	function var_1_0:updateNoteTf()
		setActive(findTF(self._tf, "singleNote"), false)
		setActive(findTF(self._tf, "longNote"), false)

		if self.longFlag then
			setActive(findTF(self._tf, "longNote"), true)

			for iter_5_0 = 1, var_0_5 do
				setActive(findTF(self._tf, "longNote/note/img" .. iter_5_0), iter_5_0 == self.imgType)
				setActive(findTF(self._tf, "longNote/long/img" .. iter_5_0), iter_5_0 == self.imgType)
			end
		else
			setActive(findTF(self._tf, "singleNote"), true)

			for iter_5_1 = 1, var_0_5 do
				setActive(findTF(self._tf, "singleNote/note/img" .. iter_5_1), iter_5_1 == self.imgType)
			end
		end

		return
	end

	function var_1_0:getImageType()
		if self.dgree == MusicGameNote.type_dgree_easy then
			return var_0_1
		elseif self.keyType == MusicGameNote.type_pu_both then
			return var_0_4
		elseif self.directType == MusicGameNote.type_left then
			return var_0_2
		elseif self.directType == MusicGameNote.type_right then
			return var_0_3
		end

		return var_0_1
	end

	function var_1_0:getRemoveTime()
		return self.removeTime
	end

	function var_1_0:triggerScore()
		if self.removeTime then
			self.removeTime = nil
		end

		return
	end

	function var_1_0:changeActive(arg_9_1)
		setActive(self._tf, arg_9_1)

		return
	end

	function var_1_0:dispose()
		if self._tf then
			Destroy(self._tf)
		end

		return
	end

	var_1_0:Ctor()

	return var_1_0
end

function MusicGameNote:Ctor(arg_11_1, arg_11_2, arg_11_3)
	self._tf = arg_11_1
	self.noteTpl = arg_11_2
	self.directType = arg_11_3
	self.noteStateCallback = nil
	self.notePool = {}
	self.noteList = {}

	return
end

function MusicGameNote:setStateCallback(arg_12_1)
	self.noteStateCallback = arg_12_1

	return
end

function MusicGameNote:setLongTimeCallback(arg_13_1)
	self.longNoteCallback = arg_13_1

	return
end

function MusicGameNote:setStartData(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	var_0_12 = var_0_10[arg_14_2]
	self.puList = arg_14_1
	self.speedLevel = arg_14_2
	self.dgree = arg_14_3
	self.noteType = arg_14_4
	self.speedOffsetX = var_0_9[arg_14_2]
	self.tplNote = findTF(self.noteTpl, "tplNote" .. arg_14_4)

	if self.lastNoteType and self.lastNoteType ~= arg_14_4 then
		self:destroyNoteAll()
	else
		self:clearNote()
	end

	self.lastNoteType = self.noteType

	return
end

function MusicGameNote:step(arg_15_1)
	self.stepTime = arg_15_1 / 1000

	if #self.noteList > 0 then
		local var_15_0 = self:checkScoreType(self.noteList[1])

		if var_15_0 then
			self.noteList[1]:triggerScore()
			self.noteStateCallback(var_15_0)

			if not self.noteList[1].longFlag or var_15_0 == var_0_6 then
				self:returnNote(table.remove(self.noteList, 1))
			elseif self.noteList[1].longFlag and self.noteList[1].triggerUp then
				self:returnNote(table.remove(self.noteList, 1))

				if self.longNoteCallback then
					self.longNoteCallback(self.noteList[1].longTime)
				end
			end
		end
	end

	for iter_15_0 = #self.noteList, 1, -1 do
		if self.noteList[iter_15_0].fixedScoreType and self.noteStateCallback then
			self.noteStateCallback(self.noteList[iter_15_0].fixedScoreType)

			if self.loopFlag then
				self.loopFlag = false
			end

			self:returnNote(table.remove(self.noteList, iter_15_0))
		end
	end

	for iter_15_1 = #self.noteList, 1, -1 do
		local var_15_3 = self.noteList[iter_15_1]:getRemoveTime()

		if var_15_3 and var_15_3 < self.stepTime then
			if self.noteStateCallback then
				if not var_0_13 then
					self.noteStateCallback(var_0_6)
				else
					self.noteStateCallback(var_0_8)
				end
			end

			if self.loopFlag then
				self.loopFlag = false
			end

			self:returnNote(table.remove(self.noteList, iter_15_1))
		end
	end

	for iter_15_2 = #self.noteList, 1, -1 do
		self.noteList[iter_15_2]:stepUpdate(self.stepTime)
	end

	if self.puList and #self.puList > 0 then
		if self:checkPuShow(self.puList[1]) then
			self:pushNoteToList(self:getNote(self.puList[1]))
			table.remove(self.puList, 1)
		end
	end

	return
end

function MusicGameNote:checkScoreType(arg_16_1)
	if self.dgree == MusicGameNote.type_dgree_easy and self.keyDownStepTime and self.keyDownStepTime and self.keyDownStepTime == MusicGameNote.easyTriggerStepTime then
		self.keyDownTrigger = true
	end

	local var_16_0

	if not arg_16_1.longFlag then
		if self.keyDownStepTime and not self.keyDownTrigger then
			local var_16_3 = math.abs(self.keyDownStepTime - arg_16_1.beginTime)

			if arg_16_1.keyType == MusicGameNote.type_pu_both then
				if self.keyBothDown then
					var_16_0 = self:getScoreType(var_16_3)
				end
			else
				var_16_0 = self:getScoreType(var_16_3)
			end

			if var_16_0 then
				arg_16_1.triggerDown = true
				self.keyDownTrigger = true

				if self.dgree == MusicGameNote.type_dgree_easy then
					MusicGameNote.easyTriggerStepTime = self.keyDownStepTime
				end
			end
		end
	elseif not arg_16_1.triggerDown then
		if self.keyDownStepTime and not self.keyDownTrigger then
			local var_16_4 = math.abs(self.keyDownStepTime - arg_16_1.beginTime)

			if arg_16_1.keyType == MusicGameNote.type_pu_both then
				if self.keyBothDown then
					var_16_0 = self:getScoreType(var_16_4)
				end
			else
				var_16_0 = self:getScoreType(var_16_4)
			end

			if var_16_0 then
				arg_16_1.triggerDown = true
				self.keyDownTrigger = true
				self.loopFlag = true
			end
		end
	else
		local var_16_5 = arg_16_1.endTime

		if not self.keyDown and self.stepTime < arg_16_1.endTime - var_0_12 then
			if self.loopFlag then
				self.loopFlag = false
			end

			arg_16_1.fixedScoreType, arg_16_1.endTime = self:getScoreType(math.abs(self.stepTime - arg_16_1.endTime)) or var_0_7, arg_16_1.beginTime
			var_16_0 = nil
		elseif self.keyUpStepTime and not self.keyUpTrigger then
			local var_16_6 = math.abs(self.keyUpStepTime - var_16_5)

			if arg_16_1.keyType == MusicGameNote.type_pu_both then
				if self.keyBothUp then
					var_16_0 = self:getScoreType(var_16_6)
				end
			else
				var_16_0 = self:getScoreType(var_16_6)
			end

			if var_16_0 then
				if self.loopFlag then
					self.loopFlag = false
				end

				arg_16_1.triggerUp = true
				self.keyUpTrigger = true
			end
		end
	end

	return var_16_0
end

function MusicGameNote:loopTime()
	return self.loopFlag
end

function MusicGameNote:getScoreType(arg_18_1)
	if arg_18_1 < var_0_12 / 2 then
		return var_0_8
	elseif arg_18_1 < var_0_12 then
		return var_0_7
	end

	return nil
end

function MusicGameNote:pushNoteToList(arg_19_1)
	table.insert(self.noteList, arg_19_1)

	return
end

function MusicGameNote:checkPuShow(arg_20_1)
	if arg_20_1.begin_time - self.stepTime <= var_0_11 then
		return true
	end

	return false
end

function MusicGameNote:destroyNoteAll()
	for iter_21_0 = #self.noteList, 1, -1 do
		self.noteList[iter_21_0]:dispose()
	end

	for iter_21_1 = #self.notePool, 1, -1 do
		self.notePool[iter_21_1]:dispose()
	end

	self.noteList = {}
	self.notePool = {}

	return
end

function MusicGameNote:clearNote()
	for iter_22_0 = #self.noteList, 1, -1 do
		self:returnNote((table.remove(self.noteList, iter_22_0)))
	end

	return
end

function MusicGameNote:getNote(arg_23_1)
	if #self.notePool == 0 then
		table.insert(self.notePool, (self:createNote()))
	end

	local var_23_0 = table.remove(self.notePool, 1)

	var_23_0:setNoteData(arg_23_1, self.speedOffsetX, self.dgree, self.directType)

	return var_23_0
end

function MusicGameNote:returnNote(arg_24_1)
	arg_24_1:changeActive(false)
	table.insert(self.notePool, arg_24_1)

	return
end

function MusicGameNote:createNote()
	local var_25_0 = tf(instantiate(self.tplNote))

	setActive(var_25_0, false)

	local var_25_1 = var_0_14(var_25_0)

	setParent(var_25_0, self._tf)

	return var_0_14(var_25_0)
end

function MusicGameNote:onKeyDown()
	self.keyDown = true
	self.keyUp = false
	self.keyDownStepTime = self.stepTime
	self.keyDownTrigger = false
	self.keyBothDown = false

	return
end

function MusicGameNote:onKeyUp()
	self.keyUp = true
	self.keyDown = false
	self.keyUpStepTime = self.stepTime
	self.keyUpTrigger = false
	self.keyBothUp = false

	return
end

function MusicGameNote:bothDown()
	self.keyDownStepTime = self.stepTime
	self.keyBothDown = true
	self.keyBothUp = false

	return
end

function MusicGameNote:bothUp()
	self.keyBothUp = true
	self.keyBothDown = false
	self.keyUpStepTime = self.stepTime

	return
end

return MusicGameNote
