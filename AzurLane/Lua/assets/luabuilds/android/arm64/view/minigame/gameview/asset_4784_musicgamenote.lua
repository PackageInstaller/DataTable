class = var_0_10000

local var_0_0 = var_0_10000("MusicGameNote")

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

	function var_1_0.Ctor(arg_2_0)
		findTF = var_2_10001
		arg_2_0.longTf = var_2_10001(arg_2_0._tf, "longNote")
		findTF = var_1
		arg_2_0.singleTf = var_1(arg_2_0._tf, "singleNote")

		return
	end

	function var_1_0.stepUpdate(arg_3_0, arg_3_1)
		isActive = var_2_10002

		local var_3_0

		if not var_2_10002(arg_3_0._tf) then
			var_3_0 = arg_3_0

			arg_3_0.changeActive(var_3_0, true)
		end

		local var_3_1

		if (arg_3_1 - arg_3_0.beginTime) * arg_3_0.speedOffsetX > 0 then
			var_3_1 = 0
		end

		local var_3_2 = arg_3_0._tf

		Vector3 = var_3_0
		var_3_2.localPosition = var_3_0(var_3_1, 0, 0)

		if arg_3_0.longFlag then
			local var_3_3

			if var_3_1 == 0 then
				var_3_3 = (arg_3_0.endTime - arg_3_1) * arg_3_0.speedOffsetX

				if not arg_3_0.triggerDown and not arg_3_0.removeTime then
					arg_3_0.removeTime = arg_3_1 + var_0_12
				end
			else
				var_3_3 = (arg_3_0.endTime - arg_3_0.beginTime) * arg_3_0.speedOffsetX
			end

			if var_3_3 < 0 then
				var_3_3 = 0
			end

			local var_3_4 = arg_3_0.longTf

			Vector2 = var_2_10005
			var_3_4.sizeDelta = var_2_10005(var_3_3, arg_3_0.longTf.sizeDelta.y)

			if var_3_3 == 0 and not arg_3_0.triggerUp and not arg_3_0.removeTime then
				arg_3_0.removeTime = arg_3_1 + var_0_12
			end
		elseif var_3_1 == 0 and not arg_3_0.removeTime then
			arg_3_0.removeTime = arg_3_1 + var_0_12
		end

		return
	end

	function var_1_0.setNoteData(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
		arg_4_0.removeTime = nil
		arg_4_0.triggerDown = nil
		arg_4_0.triggerUp = nil
		arg_4_0.fixedScoreType = nil

		if arg_4_1.key_flag == "K_BOTH" then
			MusicGameNote = var_4_0

			local var_4_0

			if not var_4_0.type_pu_both then
				MusicGameNote = var_4_0
				var_4_0 = var_4_0.type_pu_normal
			end

			arg_4_0.keyType = var_4_0
			tonumber = var_4_0
			arg_4_0.beginTime = var_4_0(arg_4_1.begin_time)
			tonumber = var_5
			arg_4_0.endTime = var_5(arg_4_1.end_time)
			arg_4_0.longTime = arg_4_0.endTime - arg_4_0.beginTime
			arg_4_0.longFlag = arg_4_1.begin_time ~= arg_4_1.end_time
			arg_4_0.speedOffsetX = arg_4_2
			arg_4_0.dgree = arg_4_3
			arg_4_0.directType = arg_4_4
			arg_4_0.imgType = arg_4_0:getImageType()

			local var_4_1 = arg_4_0._tf

			Vector3 = var_6
			var_4_1.localPosition = var_6(0, 0, 0)
			arg_4_0._tf.name = "beginTime" .. arg_4_0.beginTime

			arg_4_0:updateNoteTf()

			return
		end
	end

	function var_1_0.updateNoteTf(arg_5_0)
		setActive = var_2_10001
		findTF = var_2_10003

		var_2_10001(var_2_10003(arg_5_0._tf, "singleNote"), false)

		setActive = var_2_10001
		findTF = var_3

		var_2_10001(var_3(arg_5_0._tf, "longNote"), false)

		if arg_5_0.longFlag then
			setActive = var_1
			findTF = var_3

			var_1(var_3(arg_5_0._tf, "longNote"), true)

			for iter_5_0 = 1, var_0_5 do
				setActive = var_5
				findTF = var_2_10007

				var_5(var_2_10007(arg_5_0._tf, "longNote/note/img" .. iter_5_0), iter_5_0 == arg_5_0.imgType)

				setActive = var_5
				findTF = var_2_10007

				var_5(var_2_10007(arg_5_0._tf, "longNote/long/img" .. iter_5_0), iter_5_0 == arg_5_0.imgType)
			end
		else
			setActive = var_1
			findTF = var_3

			var_1(var_3(arg_5_0._tf, "singleNote"), true)

			for iter_5_1 = 1, var_0_5 do
				setActive = var_5
				findTF = var_2_10007

				var_5(var_2_10007(arg_5_0._tf, "singleNote/note/img" .. iter_5_1), iter_5_1 == arg_5_0.imgType)
			end
		end

		return
	end

	function var_1_0.getImageType(arg_6_0)
		local var_6_0 = arg_6_0.dgree

		MusicGameNote = var_2_10002

		if var_6_0 == var_2_10002.type_dgree_easy then
			return var_0_1
		else
			local var_6_1 = arg_6_0.keyType

			MusicGameNote = var_2

			if var_6_1 == var_2.type_pu_both then
				return var_0_4
			else
				local var_6_2 = arg_6_0.directType

				MusicGameNote = var_2

				if var_6_2 == var_2.type_left then
					return var_0_2
				else
					local var_6_3 = arg_6_0.directType

					MusicGameNote = var_2

					if var_6_3 == var_2.type_right then
						return var_0_3
					end
				end
			end
		end

		return var_0_1
	end

	function var_1_0.getRemoveTime(arg_7_0)
		return arg_7_0.removeTime
	end

	function var_1_0.triggerScore(arg_8_0)
		if arg_8_0.removeTime then
			arg_8_0.removeTime = nil
		end

		return
	end

	function var_1_0.changeActive(arg_9_0, arg_9_1)
		setActive = var_2_10002

		var_2_10002(arg_9_0._tf, arg_9_1)

		return
	end

	function var_1_0.dispose(arg_10_0)
		if arg_10_0._tf then
			Destroy = var_1

			var_1(arg_10_0._tf)
		end

		return
	end

	var_1_0:Ctor()

	return var_1_0
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
	findTF = var_5
	arg_14_0.tplNote = var_5(arg_14_0.noteTpl, "tplNote" .. arg_14_4)

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
		local var_15_0 = arg_15_0.noteList[1]

		if arg_15_0:checkScoreType(var_15_0) then
			var_15_0:triggerScore()
			arg_15_0.noteStateCallback(var_3)

			if not var_15_0.longFlag or var_3 == var_0_6 then
				local var_15_1 = arg_15_0
				local var_15_2 = arg_15_0.returnNote

				table = var_1_10007

				var_15_2(var_15_1, var_1_10007.remove(arg_15_0.noteList, 1))
			elseif var_15_0.longFlag and var_15_0.triggerUp then
				local var_15_3 = arg_15_0
				local var_15_4 = arg_15_0.returnNote

				table = var_1_10007

				var_15_4(var_15_3, var_1_10007.remove(arg_15_0.noteList, 1))

				if arg_15_0.longNoteCallback then
					arg_15_0.longNoteCallback(var_15_0.longTime)
				end
			end
		end
	end

	for iter_15_0 = #arg_15_0.noteList, 1, -1 do
		if arg_15_0.noteList[iter_15_0].fixedScoreType and arg_15_0.noteStateCallback then
			arg_15_0.noteStateCallback(var_7)

			if arg_15_0.loopFlag then
				arg_15_0.loopFlag = false
			end

			local var_15_5 = arg_15_0
			local var_15_6 = arg_15_0.returnNote

			table = var_1_10011

			var_15_6(var_15_5, var_1_10011.remove(arg_15_0.noteList, iter_15_0))
		end
	end

	for iter_15_1 = #arg_15_0.noteList, 1, -1 do
		local var_15_7 = arg_15_0.noteList[iter_15_1].longFlag
		local var_15_8 = var_6.triggerDown
		local var_15_9 = arg_15_0.noteList[iter_15_1]

		if var_9.getRemoveTime(var_15_9) and var_9 < arg_15_0.stepTime then
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

			local var_15_10 = arg_15_0
			local var_15_11 = arg_15_0.returnNote

			table = var_1_10013

			var_15_11(var_15_10, var_1_10013.remove(arg_15_0.noteList, iter_15_1))
		end
	end

	for iter_15_2 = #arg_15_0.noteList, 1, -1 do
		local var_15_12 = arg_15_0.noteList[iter_15_2]

		var_6.stepUpdate(var_15_12, arg_15_0.stepTime)
	end

	if arg_15_0.puList and #arg_15_0.puList > 0 then
		local var_15_13 = arg_15_0.puList[1]

		if arg_15_0:checkPuShow(var_15_13) then
			arg_15_0:pushNoteToList(arg_15_0:getNote(var_15_13))

			table = var_3

			var_3.remove(arg_15_0.puList, 1)
		end
	end

	return
end

function var_0_0.checkScoreType(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.dgree

	MusicGameNote = var_1_10003

	if var_16_0 == var_1_10003.type_dgree_easy and arg_16_0.keyDownStepTime and arg_16_0.keyDownStepTime then
		local var_16_1 = arg_16_0.keyDownStepTime

		MusicGameNote = var_3

		if var_16_1 == var_3.easyTriggerStepTime then
			arg_16_0.keyDownTrigger = true
		end
	end

	local var_16_2
	local var_16_3
	local var_16_4 = false

	if not arg_16_1.longFlag then
		local var_16_5 = arg_16_1.beginTime

		if arg_16_0.keyDownStepTime and not arg_16_0.keyDownTrigger then
			math = var_5

			local var_16_6 = var_5.abs(arg_16_0.keyDownStepTime - var_16_5)
			local var_16_7 = arg_16_1.keyType

			MusicGameNote = var_7

			if var_16_7 == var_7.type_pu_both then
				if arg_16_0.keyBothDown then
					var_16_2 = arg_16_0:getScoreType(var_16_6)
				end
			else
				var_16_2 = arg_16_0:getScoreType(var_16_6)
			end

			if var_16_2 then
				arg_16_1.triggerDown = true
				arg_16_0.keyDownTrigger = true

				local var_16_8 = arg_16_0.dgree

				MusicGameNote = var_7

				if var_16_8 == var_7.type_dgree_easy then
					MusicGameNote = var_16_8
					var_16_8.easyTriggerStepTime = arg_16_0.keyDownStepTime
				end
			end
		end
	elseif not arg_16_1.triggerDown then
		local var_16_9 = arg_16_1.beginTime

		if arg_16_0.keyDownStepTime and not arg_16_0.keyDownTrigger then
			math = var_5

			local var_16_10 = var_5.abs(arg_16_0.keyDownStepTime - var_16_9)
			local var_16_11 = arg_16_1.keyType

			MusicGameNote = var_7

			if var_16_11 == var_7.type_pu_both then
				if arg_16_0.keyBothDown then
					var_16_2 = arg_16_0:getScoreType(var_16_10)
				end
			else
				var_16_2 = arg_16_0:getScoreType(var_16_10)
			end

			if var_16_2 then
				arg_16_1.triggerDown = true
				arg_16_0.keyDownTrigger = true
				arg_16_0.loopFlag = true
			end
		end
	else
		local var_16_12 = arg_16_1.endTime
		local var_16_13 = arg_16_0.stepTime < var_16_12 - var_0_12

		if not arg_16_0.keyDown and var_16_13 then
			if arg_16_0.loopFlag then
				arg_16_0.loopFlag = false
			end

			local var_16_14 = arg_16_0
			local var_16_15 = arg_16_0.getScoreType

			math = var_1_10009

			local var_16_16

			if not var_16_15(var_16_14, var_1_10009.abs(arg_16_0.stepTime - arg_16_1.endTime)) then
				var_16_16 = var_0_7
			end

			arg_16_1.endTime = arg_16_1.beginTime
			arg_16_1.fixedScoreType = var_16_16
			var_16_2 = nil
		elseif arg_16_0.keyUpStepTime and not arg_16_0.keyUpTrigger then
			math = var_6

			local var_16_17 = var_6.abs(arg_16_0.keyUpStepTime - var_16_12)
			local var_16_18 = arg_16_1.keyType

			MusicGameNote = var_8

			if var_16_18 == var_8.type_pu_both then
				if arg_16_0.keyBothUp then
					var_16_2 = arg_16_0:getScoreType(var_16_17)
				end
			else
				var_16_2 = arg_16_0:getScoreType(var_16_17)
			end

			if var_16_2 then
				if arg_16_0.loopFlag then
					arg_16_0.loopFlag = false
				end

				arg_16_1.triggerUp = true
				arg_16_0.keyUpTrigger = true
			end
		end
	end

	return var_16_2
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
	table = var_1_10002

	var_1_10002.insert(arg_19_0.noteList, arg_19_1)

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
		local var_21_0 = arg_21_0.noteList[iter_21_0]

		var_5.dispose(var_21_0)
	end

	for iter_21_1 = #arg_21_0.notePool, 1, -1 do
		local var_21_1 = arg_21_0.notePool[iter_21_1]

		var_5.dispose(var_21_1)
	end

	arg_21_0.noteList = {}
	arg_21_0.notePool = {}

	return
end

function var_0_0.clearNote(arg_22_0)
	for iter_22_0 = #arg_22_0.noteList, 1, -1 do
		table = var_1_10005
		var_1_10005 = var_1_10005.remove(arg_22_0.noteList, iter_22_0)

		arg_22_0:returnNote(var_1_10005)
	end

	return
end

function var_0_0.getNote(arg_23_0, arg_23_1)
	local var_23_0

	if #arg_23_0.notePool == 0 then
		var_23_0 = arg_23_0:createNote()
		table = var_1_10003

		var_1_10003.insert(arg_23_0.notePool, var_23_0)
	end

	table = var_23_0

	local var_23_1 = var_23_0.remove(arg_23_0.notePool, 1)

	var_2.setNoteData(var_23_1, arg_23_1, arg_23_0.speedOffsetX, arg_23_0.dgree, arg_23_0.directType)

	return var_2
end

function var_0_0.returnNote(arg_24_0, arg_24_1)
	arg_24_1:changeActive(false)

	table = var_2

	var_2.insert(arg_24_0.notePool, arg_24_1)

	return
end

function var_0_0.createNote(arg_25_0)
	tf = var_1_10001
	instantiate = var_1_10003

	local var_25_0 = var_1_10001(var_1_10003(arg_25_0.tplNote))

	setActive = var_1_10002

	var_1_10002(var_25_0, false)

	local var_25_1 = var_0_14(var_25_0)

	setParent = var_3

	var_3(var_25_0, arg_25_0._tf)

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
