class = var_0_10000

local var_0_0 = "MapBuilderSSSS"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".MapBuilderNormal"))
local var_0_2 = "ssss_buttons"

function var_0_1.GetType(arg_1_0)
	MapBuilder = var_1_10001

	return var_1_10001.TYPESSSS
end

function var_0_1.OnInit(arg_2_0)
	var_0_1.super.OnInit(arg_2_0)

	PoolMgr = var_1

	local var_2_0 = var_1.GetInstance()

	var_1.GetUI(var_2_0, var_0_2, false, function(arg_3_0)
		arg_2_0.buttons = arg_3_0

		return
	end)

	local var_2_1 = arg_2_0._parentTf

	arg_2_0.mainLayer = var_1.Find(var_2_1, "main")

	local var_2_2 = arg_2_0._parentTf

	arg_2_0.rightChapter = var_1.Find(var_2_2, "main/right_chapter/event_btns/BottomList")

	local var_2_3 = arg_2_0._parentTf

	arg_2_0.leftChapter = var_1.Find(var_2_3, "main/left_chapter/buttons")
	tf = var_1

	local var_2_4 = var_1(arg_2_0.buttons)

	arg_2_0.challengeBtn = var_1.Find(var_2_4, "btn_challenge")
	tf = var_1

	local var_2_5 = var_1(arg_2_0.buttons)

	arg_2_0.missionBtn = var_1.Find(var_2_5, "btn_mission")
	onButton = var_1

	local var_2_6 = arg_2_0
	local var_2_7 = arg_2_0.challengeBtn

	local function var_2_8()
		local var_4_0 = arg_2_0

		if var_0.isfrozen(var_4_0) then
			return
		end

		local var_4_1 = arg_2_0
		local var_4_2 = var_0.emit

		LevelUIConst = var_2_10003

		local var_4_3 = var_2_10003.SWITCH_ACT_MAP

		Map = var_2_10004

		var_4_2(var_4_1, var_4_3, var_2_10004.ACTIVITY_HARD)

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_6, var_2_7, var_2_8, var_6)

	onButton = var_1

	local var_2_9 = arg_2_0
	local var_2_10 = arg_2_0.missionBtn

	local function var_2_11()
		local var_5_0 = arg_2_0

		if var_0.isfrozen(var_5_0) then
			return
		end

		local var_5_1 = arg_2_0
		local var_5_2 = var_0.emit

		LevelMediator2 = var_2_10003

		local var_5_3 = var_2_10003.ON_GO_TO_TASK_SCENE
		local var_5_4 = {}

		TaskScene = var_2_10005
		var_5_4.page = var_2_10005.PAGE_TYPE_ACT

		var_5_2(var_5_1, var_5_3, var_5_4)

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_9, var_2_10, var_2_11, var_6)

	setParent = var_1

	var_1(arg_2_0.buttons, arg_2_0.mainLayer)

	return
end

function var_0_1.OnHide(arg_6_0)
	setParent = var_1_10001

	var_1_10001(arg_6_0.challengeBtn, arg_6_0.buttons)

	setParent = var_1_10001

	var_1_10001(arg_6_0.missionBtn, arg_6_0.buttons)

	setActive = var_1_10001

	var_1_10001(arg_6_0.buttons, false)
	var_0_1.super.OnHide(arg_6_0)

	return
end

function var_0_1.OnShow(arg_7_0)
	var_0_1.super.OnShow(arg_7_0)

	setActive = var_1

	var_1(arg_7_0.buttons, true)

	setParent = var_1

	var_1(arg_7_0.challengeBtn, arg_7_0.leftChapter)

	local var_7_0 = arg_7_0.challengeBtn

	var_1.SetSiblingIndex(var_7_0, 5)

	setParent = var_1

	var_1(arg_7_0.missionBtn, arg_7_0.rightChapter)

	local var_7_1 = arg_7_0.missionBtn

	var_1.SetSiblingIndex(var_7_1, 0)

	return
end

local var_0_3 = {
	18993,
	18994,
	18995,
	18996,
	18997
}

function var_0_1.UpdateButtons(arg_8_0)
	var_0_1.super.UpdateButtons(arg_8_0)

	local var_8_0 = arg_8_0.data
	local var_8_1 = var_1.getConfig(var_8_0, "type")

	setActive = var_1_10002

	var_1_10002(arg_8_0.sceneParent.actEliteBtn, false)

	setActive = var_1_10002

	local var_8_2 = arg_8_0.challengeBtn

	Map = var_5

	var_1_10002(var_8_2, var_8_1 ~= var_5.ACTIVITY_HARD)

	setActive = var_1_10002

	local var_8_3 = arg_8_0.missionBtn

	Map = var_5

	var_1_10002(var_8_3, var_8_1 == var_5.ACTIVITY_HARD)

	Map = var_1_10002

	if var_8_1 == var_1_10002.ACTIVITY_HARD then
		_ = var_2

		local var_8_4 = var_2.any(var_0_3, function(arg_9_0)
			getProxy = var_2_10001
			TaskProxy = var_2_10003

			local var_9_0 = var_2_10001(var_2_10003)
			local var_9_1 = var_1.getTaskById(var_9_0, arg_9_0)

			tobool = var_2_10002

			return var_2_10002(var_9_1)
		end)

		setActive = var_8_0

		var_8_0(arg_8_0.missionBtn, var_8_4)

		if var_8_4 then
			setActive = var_8_0

			local var_8_5 = arg_8_0.missionBtn
			local var_8_6 = var_5.Find(var_8_5, "Tip")

			_ = var_6

			var_8_0(var_8_6, var_6.any(var_0_3, function(arg_10_0)
				getProxy = var_2_10001
				TaskProxy = var_2_10003

				local var_10_0 = var_2_10001(var_2_10003)

				return var_1.getTaskById(var_10_0, arg_10_0) and var_1:isFinish()
			end))
		end
	end

	return
end

function var_0_1.OnDestroy(arg_11_0)
	PoolMgr = var_1_10001

	local var_11_0 = var_1_10001.GetInstance()

	var_1.ReturnUI(var_11_0, var_0_2, arg_11_0.buttons)
	var_0_1.super.OnDestroy(arg_11_0)

	return
end

return var_0_1
