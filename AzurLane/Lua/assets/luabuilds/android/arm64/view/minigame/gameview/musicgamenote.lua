local var_0_0 = class("MusicGameNote")

var_0_0.easyTriggerStepTime = nil
var_0_0.type_left = 1
var_0_0.type_right = 2
var_0_0.type_pu_normal = 1
var_0_0.type_pu_both = 2
var_0_0.type_dgree_easy = 1
var_0_0.type_dgree_hard = 2

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
	({
		_tf = arg_1_0
	}).type = nil
	;({
		_tf = arg_1_0
	}).beginTime = nil
	;({
		_tf = arg_1_0
	}).endTime = nil
	;({
		_tf = arg_1_0
	}).longFlag = nil
	;({
		_tf = arg_1_0
	}).removeTime = nil
	;({
		_tf = arg_1_0
	}).speedOffsetX = nil
	;({
		_tf = arg_1_0
	}).longTime = 0
	;({
		_tf = arg_1_0
	}).triggerDown = nil
	;({
		_tf = arg_1_0
	}).triggerUp = nil
	;({
		_tf = arg_1_0
	}).fixedScoreType = nil
	;({
		_tf = arg_1_0
	}).Ctor = function(arg_2_0)
		arg_2_0.longTf = findTF(arg_2_0._tf, "longNote")
		arg_2_0.singleTf = findTF(arg_2_0._tf, "singleNote")

		return
	end
	;({
		_tf = arg_1_0
	}).stepUpdate = function(arg_3_0, arg_3_1)
		if not isActive(arg_3_0._tf) then
			arg_3_0:changeActive(true)
		end

		local var_3_0 = (arg_3_1 - arg_3_0.beginTime) * arg_3_0.speedOffsetX

		if (arg_3_1 - arg_3_0.beginTime) * arg_3_0.speedOffsetX > 0 then
			var_3_0 = 0
		end

		arg_3_0._tf.localPosition = Vector3(var_3_0, 0, 0)

		if arg_3_0.longFlag then
			local var_3_1

			if var_3_0 == 0 then
				var_3_1 = (arg_3_0.endTime - arg_3_1) * arg_3_0.speedOffsetX

				if not arg_3_0.triggerDown and not arg_3_0.removeTime then
					arg_3_0.removeTime = arg_3_1 + var_0_12
				end
			else
				var_3_1 = (arg_3_0.endTime - arg_3_0.beginTime) * arg_3_0.speedOffsetX
			end

			if var_3_1 < 0 then
				var_3_1 = 0
			end

			arg_3_0.longTf.sizeDelta = Vector2(var_3_1, arg_3_0.longTf.sizeDelta.y)

			if var_3_1 == 0 and not arg_3_0.triggerUp and not arg_3_0.removeTime then
				arg_3_0.removeTime = arg_3_1 + var_0_12
			end
		elseif var_3_0 == 0 and not arg_3_0.removeTime then
			arg_3_0.removeTime = arg_3_1 + var_0_12
		end

		return
	end
	;({
		_tf = arg_1_0
	}).setNoteData = function(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		arg_4_0.removeTime = nil
		arg_4_0.triggerDown = nil
		arg_4_0.triggerUp = nil
		arg_4_0.fixedScoreType = nil

		if arg_4_1.key_flag == "K_BOTH" then
			arg_4_0.keyType = MusicGameNote.type_pu_both or MusicGameNote.type_pu_normal
			arg_4_0.beginTime = tonumber(arg_4_1.begin_time)
			arg_4_0.endTime = tonumber(arg_4_1.end_time)
			arg_4_0.longTime = arg_4_0.endTime - arg_4_0.beginTime
			arg_4_0.longFlag = arg_4_1.begin_time ~= arg_4_1.end_time
			arg_4_0.speedOffsetX = arg_4_2
			arg_4_0.dgree = arg_4_3
			arg_4_0.directType = arg_4_4
			arg_4_0.imgType = arg_4_0:getImageType()
			arg_4_0._tf.localPosition = Vector3(0, 0, 0)
			arg_4_0._tf.name = "beginTime" .. arg_4_0.beginTime

			arg_4_0:updateNoteTf()

			return
		end
	end
	;({
		_tf = arg_1_0
	}).updateNoteTf = function(arg_5_0)
		setActive(findTF(arg_5_0._tf, "singleNote"), false)
		setActive(findTF(arg_5_0._tf, "longNote"), false)

		if arg_5_0.longFlag then
			setActive(findTF(arg_5_0._tf, "longNote"), true)

			for iter_5_0 = 1, var_0_5 do
				setActive(findTF(arg_5_0._tf, "longNote/note/img" .. iter_5_0), iter_5_0 == arg_5_0.imgType)
				setActive(findTF(arg_5_0._tf, "longNote/long/img" .. iter_5_0), iter_5_0 == arg_5_0.imgType)
			end
		else
			setActive(findTF(arg_5_0._tf, "singleNote"), true)

			for iter_5_1 = 1, var_0_5 do
				setActive(findTF(arg_5_0._tf, "singleNote/note/img" .. iter_5_1), iter_5_1 == arg_5_0.imgType)
			end
		end

		return
	end
	;({
		_tf = arg_1_0
	}).getImageType = function(arg_6_0)
		if arg_6_0.dgree == MusicGameNote.type_dgree_easy then
			return var_0_1
		elseif arg_6_0.keyType == MusicGameNote.type_pu_both then
			return var_0_4
		elseif arg_6_0.directType == MusicGameNote.type_left then
			return var_0_2
		elseif arg_6_0.directType == MusicGameNote.type_right then
			return var_0_3
		end

		return var_0_1
	end
	;({
		_tf = arg_1_0
	}).getRemoveTime = function(arg_7_0)
		return arg_7_0.removeTime
	end
	;({
		_tf = arg_1_0
	}).triggerScore = function(arg_8_0)
		if arg_8_0.removeTime then
			arg_8_0.removeTime = nil
		end

		return
	end
	;({
		_tf = arg_1_0
	}).changeActive = function(arg_9_0, arg_9_1)
		setActive(arg_9_0._tf, arg_9_1)

		return
	end
	;({
		_tf = arg_1_0
	}).dispose = function(arg_10_0)
		if arg_10_0._tf then
			Destroy(arg_10_0._tf)
		end

		return
	end

	;({
		_tf = arg_1_0
	}):Ctor()

	return {
		_tf = arg_1_0
	}
end

function var_0_0.Ctor(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0._tf = arg_11_1
	arg_11_0.noteTpl = arg_11_2
	arg_11_0.directType = arg_11_3
	arg_11_0.noteStateCallback = nil
	arg_11_0.notePool = {}
	arg_11_0.noteList = {}

	return
end

function var_0_0.setStateCallback(arg_12_0, arg_12_1)
	arg_12_0.noteStateCallback = arg_12_1

	return
end

function var_0_0.setLongTimeCallback(arg_13_0, arg_13_1)
	arg_13_0.longNoteCallback = arg_13_1

	return
end

function var_0_0.setStartData(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	var_0_12 = var_0_10[arg_14_2]
	arg_14_0.puList = arg_14_1
	arg_14_0.speedLevel = arg_14_2
	arg_14_0.dgree = arg_14_3
	arg_14_0.noteType = arg_14_4
	arg_14_0.speedOffsetX = var_0_9[arg_14_2]
	arg_14_0.tplNote = findTF(arg_14_0.noteTpl, "tplNote" .. arg_14_4)

	if arg_14_0.lastNoteType and arg_14_0.lastNoteType ~= arg_14_4 then
		arg_14_0:destroyNoteAll()
	else
		arg_14_0:clearNote()
	end

	arg_14_0.lastNoteType = arg_14_0.noteType

	return
end

function var_0_0.step(arg_15_0, arg_15_1)
	arg_15_0.stepTime = arg_15_1 / 1000

	if #arg_15_0.noteList > 0 then
		local var_15_0 = arg_15_0:checkScoreType(arg_15_0.noteList[1])

		if var_15_0 then
			arg_15_0.noteList[1]:triggerScore()
			arg_15_0.noteStateCallback(var_15_0)

			if not arg_15_0.noteList[1].longFlag or var_15_0 == var_0_6 then
				arg_15_0:returnNote(table.remove(arg_15_0.noteList, 1))
			elseif arg_15_0.noteList[1].longFlag and arg_15_0.noteList[1].triggerUp then
				arg_15_0:returnNote(table.remove(arg_15_0.noteList, 1))

				if arg_15_0.longNoteCallback then
					arg_15_0.longNoteCallback(arg_15_0.noteList[1].longTime)
				end
			end
		end
	end

	for iter_15_0 = #arg_15_0.noteList, 1, -1 do
		if arg_15_0.noteList[iter_15_0].fixedScoreType and arg_15_0.noteStateCallback then
			arg_15_0.noteStateCallback(arg_15_0.noteList[iter_15_0].fixedScoreType)

			if arg_15_0.loopFlag then
				arg_15_0.loopFlag = false
			end

			arg_15_0:returnNote(table.remove(arg_15_0.noteList, iter_15_0))
		end
	end

	for iter_15_1 = #arg_15_0.noteList, 1, -1 do
		local var_15_3 = arg_15_0.noteList[iter_15_1]:getRemoveTime()

		if var_15_3 and var_15_3 < arg_15_0.stepTime then
			if arg_15_0.noteStateCallback then
				if not var_0_13 then
					arg_15_0.noteStateCallback(var_0_6)
				else
					arg_15_0.noteStateCallback(var_0_8)
				end
			end

			if arg_15_0.loopFlag then
				arg_15_0.loopFlag = false
			end

			arg_15_0:returnNote(table.remove(arg_15_0.noteList, iter_15_1))
		end
	end

	for iter_15_2 = #arg_15_0.noteList, 1, -1 do
		arg_15_0.noteList[iter_15_2]:stepUpdate(arg_15_0.stepTime)
	end

	if arg_15_0.puList and #arg_15_0.puList > 0 then
		if arg_15_0:checkPuShow(arg_15_0.puList[1]) then
			arg_15_0:pushNoteToList(arg_15_0:getNote(arg_15_0.puList[1]))
			table.remove(arg_15_0.puList, 1)
		end
	end

	return
end

function var_0_0.checkScoreType(arg_16_0, arg_16_1)
	if arg_16_0.dgree == MusicGameNote.type_dgree_easy and arg_16_0.keyDownStepTime and arg_16_0.keyDownStepTime and arg_16_0.keyDownStepTime == MusicGameNote.easyTriggerStepTime then
		arg_16_0.keyDownTrigger = true
	end

	local var_16_0

	if not arg_16_1.longFlag then
		if arg_16_0.keyDownStepTime and not arg_16_0.keyDownTrigger then
			local var_16_3 = math.abs(arg_16_0.keyDownStepTime - arg_16_1.beginTime)

			if arg_16_1.keyType == MusicGameNote.type_pu_both then
				if arg_16_0.keyBothDown then
					var_16_0 = arg_16_0:getScoreType(var_16_3)
				end
			else
				var_16_0 = arg_16_0:getScoreType(var_16_3)
			end

			if var_16_0 then
				arg_16_1.triggerDown = true
				arg_16_0.keyDownTrigger = true

				if arg_16_0.dgree == MusicGameNote.type_dgree_easy then
					MusicGameNote.easyTriggerStepTime = arg_16_0.keyDownStepTime
				end
			end
		end
	elseif not arg_16_1.triggerDown then
		if arg_16_0.keyDownStepTime and not arg_16_0.keyDownTrigger then
			local var_16_4 = math.abs(arg_16_0.keyDownStepTime - arg_16_1.beginTime)

			if arg_16_1.keyType == MusicGameNote.type_pu_both then
				if arg_16_0.keyBothDown then
					var_16_0 = arg_16_0:getScoreType(var_16_4)
				end
			else
				var_16_0 = arg_16_0:getScoreType(var_16_4)
			end

			if var_16_0 then
				arg_16_1.triggerDown = true
				arg_16_0.keyDownTrigger = true
				arg_16_0.loopFlag = true
			end
		end
	else
		local var_16_5 = arg_16_1.endTime
		local var_16_6 = arg_16_0.stepTime < arg_16_1.endTime - var_0_12

		if not arg_16_0.keyDown and var_16_6 then
			if arg_16_0.loopFlag then
				arg_16_0.loopFlag = false
			end

			arg_16_1.fixedScoreType, arg_16_1.endTime = arg_16_0:getScoreType(math.abs(arg_16_0.stepTime - arg_16_1.endTime)) or var_0_7, arg_16_1.beginTime
			var_16_0 = nil
		elseif arg_16_0.keyUpStepTime and not arg_16_0.keyUpTrigger then
			local var_16_7 = math.abs(arg_16_0.keyUpStepTime - var_16_5)

			if arg_16_1.keyType == MusicGameNote.type_pu_both then
				if arg_16_0.keyBothUp then
					var_16_0 = arg_16_0:getScoreType(var_16_7)
				end
			else
				var_16_0 = arg_16_0:getScoreType(var_16_7)
			end

			if var_16_0 then
				if arg_16_0.loopFlag then
					arg_16_0.loopFlag = false
				end

				arg_16_1.triggerUp = true
				arg_16_0.keyUpTrigger = true
			end
		end
	end

	return var_16_0
end

function var_0_0.loopTime(arg_17_0)
	return arg_17_0.loopFlag
end

function var_0_0.getScoreType(arg_18_0, arg_18_1)
	if arg_18_1 < var_0_12 / 2 then
		return var_0_8
	elseif arg_18_1 < var_0_12 then
		return var_0_7
	end

	return nil
end

function var_0_0.pushNoteToList(arg_19_0, arg_19_1)
	table.insert(arg_19_0.noteList, arg_19_1)

	return
end

function var_0_0.checkPuShow(arg_20_0, arg_20_1)
	if arg_20_1.begin_time - arg_20_0.stepTime <= var_0_11 then
		return true
	end

	return false
end

function var_0_0.destroyNoteAll(arg_21_0)
	for iter_21_0 = #arg_21_0.noteList, 1, -1 do
		arg_21_0.noteList[iter_21_0]:dispose()
	end

	for iter_21_1 = #arg_21_0.notePool, 1, -1 do
		arg_21_0.notePool[iter_21_1]:dispose()
	end

	arg_21_0.noteList = {}
	arg_21_0.notePool = {}

	return
end

function var_0_0.clearNote(arg_22_0)
	for iter_22_0 = #arg_22_0.noteList, 1, -1 do
		arg_22_0:returnNote((table.remove(arg_22_0.noteList, iter_22_0)))
	end

	return
end

function var_0_0.getNote(arg_23_0, arg_23_1)
	if #arg_23_0.notePool == 0 then
		table.insert(arg_23_0.notePool, (arg_23_0:createNote()))
	end

	local var_23_0 = table.remove(arg_23_0.notePool, 1)

	var_23_0:setNoteData(arg_23_1, arg_23_0.speedOffsetX, arg_23_0.dgree, arg_23_0.directType)

	return var_23_0
end

function var_0_0.returnNote(arg_24_0, arg_24_1)
	arg_24_1:changeActive(false)
	table.insert(arg_24_0.notePool, arg_24_1)

	return
end

function var_0_0.createNote(arg_25_0)
	local var_25_0 = tf(instantiate(arg_25_0.tplNote))

	setActive(var_25_0, false)

	local var_25_1 = var_0_14(var_25_0)

	setParent(var_25_0, arg_25_0._tf)

	return var_0_14(var_25_0)
end

function var_0_0.onKeyDown(arg_26_0)
	arg_26_0.keyDown = true
	arg_26_0.keyUp = false
	arg_26_0.keyDownStepTime = arg_26_0.stepTime
	arg_26_0.keyDownTrigger = false
	arg_26_0.keyBothDown = false

	return
end

function var_0_0.onKeyUp(arg_27_0)
	arg_27_0.keyUp = true
	arg_27_0.keyDown = false
	arg_27_0.keyUpStepTime = arg_27_0.stepTime
	arg_27_0.keyUpTrigger = false
	arg_27_0.keyBothUp = false

	return
end

function var_0_0.bothDown(arg_28_0)
	arg_28_0.keyDownStepTime = arg_28_0.stepTime
	arg_28_0.keyBothDown = true
	arg_28_0.keyBothUp = false

	return
end

function var_0_0.bothUp(arg_29_0)
	arg_29_0.keyBothUp = true
	arg_29_0.keyBothDown = false
	arg_29_0.keyUpStepTime = arg_29_0.stepTime

	return
end

return var_0_0
