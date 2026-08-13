class = var_0_10000

local var_0_0 = "LevelStageAutoFightPanel"

BaseSubView = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002)

function var_0_1.Ctor(arg_1_0, ...)
	var_0_1.super.Ctor(arg_1_0, ...)

	setmetatable = var_1
	arg_1_0.buffer = var_1({}, {
		__index = function(arg_2_0, arg_2_1)
			return function(arg_3_0, ...)
				local var_3_0 = arg_1_0

				var_1.ActionInvoke(var_3_0, arg_2_1, ...)

				return
			end
		end,
		__newindex = function()
			errorMsg = var_2_10000

			var_2_10000("Cant write Data in ActionInvoke buffer")

			return
		end
	})
	arg_1_0.isFrozen = nil

	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	LevelUIConst = var_3

	var_1_1(var_1_0, var_3.ON_FROZEN, function()
		arg_1_0.isFrozen = true

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	LevelUIConst = var_3

	var_1_3(var_1_2, var_3.ON_UNFROZEN, function()
		arg_1_0.isFrozen = nil

		return
	end)

	AutoLoader = var_1_3
	arg_1_0.loader = var_1_3.New()
	arg_1_0.isCO = false

	return
end

function var_0_1.getUIName(arg_7_0)
	return "LevelStageAutoFightPanel"
end

function var_0_1.OnInit(arg_8_0)
	local var_8_0 = arg_8_0._tf

	arg_8_0.btnOn = var_1.Find(var_8_0, "On")

	local var_8_1 = arg_8_0._tf

	arg_8_0.btnOff = var_1.Find(var_8_1, "Off")
	onButton = var_1

	local var_8_2 = arg_8_0
	local var_8_3 = arg_8_0.btnOn

	local function var_8_4()
		getProxy = var_2_10000
		ChapterProxy = var_2_10001

		local var_9_0 = var_2_10000(var_2_10001)
		local var_9_1 = "chapter_autofight_flag_" .. arg_8_0.contextData.chapterVO.id
		local var_9_2 = var_9_0
		local var_9_3 = var_9_0.SetChapterAutoFlag
		local var_9_4 = arg_8_0.contextData.chapterVO.id
		local var_9_5 = false

		ChapterConst = var_2_10006

		var_9_3(var_9_2, var_9_4, var_9_5, var_2_10006.AUTOFIGHT_STOP_REASON.MANUAL)

		PlayerPrefs = var_9_3

		var_9_3.SetInt(var_9_1, 0)

		PlayerPrefs = var_2

		var_2.Save()

		local var_9_6 = arg_8_0

		var_2.UpdateAutoFightMark(var_9_6)

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_8_2, var_8_3, var_8_4, var_1_10005)

	onButton = var_1

	local var_8_5 = arg_8_0
	local var_8_6 = arg_8_0.btnOff

	local function var_8_7()
		getProxy = var_2_10000
		ChapterProxy = var_2_10001

		local var_10_0 = var_2_10000(var_2_10001)
		local var_10_1 = "chapter_autofight_flag_" .. arg_8_0.contextData.chapterVO.id

		var_10_0:SetChapterAutoFlag(arg_8_0.contextData.chapterVO.id, true)

		PlayerPrefs = var_2

		var_2.SetInt(var_10_1, 1)

		PlayerPrefs = var_2

		var_2.Save()

		local var_10_2 = arg_8_0

		var_2.UpdateAutoFightMark(var_10_2)

		if not arg_8_0.isFrozen then
			local var_10_3 = arg_8_0
			local var_10_4 = var_2.emit

			LevelUIConst = var_4

			var_10_4(var_10_3, var_4.TRIGGER_ACTION)
		end

		return
	end

	SFX_PANEL = var_1_10005

	var_1(var_8_5, var_8_6, var_8_7, var_1_10005)

	local var_8_8 = arg_8_0.btnOn

	arg_8_0.restTime = var_1.Find(var_8_8, "Rest")
	i18n = var_1

	local var_8_9 = var_1("multiple_sorties_rest_time")

	string = var_2

	local var_8_10 = var_2.split(var_8_9, "$1/$2")

	setText = var_3

	local var_8_11 = arg_8_0.restTime

	var_3(var_4.Find(var_8_11, "Text"), var_8_10[1])

	setText = var_3

	local var_8_12 = arg_8_0.restTime

	var_3(var_4.Find(var_8_12, "Text (2)"), var_8_10[2])

	return
end

function var_0_1.UpdateAutoFightMark(arg_11_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10002

	local var_11_0 = var_1_10001(var_1_10002)
	local var_11_1 = var_1.GetChapterAutoFlag(var_11_0, arg_11_0.contextData.chapterVO.id) == 1

	setActive = var_11_0

	var_11_0(arg_11_0.btnOn, var_11_1)

	setActive = var_11_0

	var_11_0(arg_11_0.btnOff, not var_11_1)
	arg_11_0:UpdateContinuousOperation()

	local var_11_2 = arg_11_0
	local var_11_3 = arg_11_0.emit

	LevelUIConst = var_4

	var_11_3(var_11_2, var_4.STRATEGY_PANEL_AUTOFIGHT_ACTIVE, var_11_1)

	return
end

function var_0_1.UpdateContinuousOperation(arg_12_0)
	getProxy = var_1_10001
	ChapterProxy = var_1_10002

	local var_12_0 = var_1_10001(var_1_10002)
	local var_12_1 = var_1.GetContinuousData

	SYSTEM_SCENARIO = var_1_10003

	if var_12_1(var_12_0, var_1_10003) and var_1:IsActive() then
		var_12_0 = var_1:GetTotalBattleTime()

		local var_12_2 = var_1

		var_12_0 = var_12_0 - var_1.GetRestBattleTime(var_12_2) + 1

		local var_12_3 = "$1/$2"

		ipairs = var_12_2

		for iter_12_0, iter_12_1 in var_12_2({
			var_12_0,
			var_1:GetTotalBattleTime()
		}) do
			string = var_1_10009
			var_12_3 = var_1_10009.gsub(var_12_3, "$" .. iter_12_0, iter_12_1)
		end

		setText = var_4

		local var_12_4 = arg_12_0.restTime

		var_4(var_5.Find(var_12_4, "Count"), var_12_3)

		setActive = var_4

		var_4(arg_12_0.restTime, true)

		if not arg_12_0.isCO then
			local var_12_5 = arg_12_0.loader

			var_4.GetSprite(var_12_5, "ui/levelstageview_atlas", "continuous_operation_on", arg_12_0.btnOn)

			arg_12_0.isCO = true
		end
	else
		setActive = var_12_0

		var_12_0(arg_12_0.restTime, false)

		if arg_12_0.isCO then
			local var_12_6 = arg_12_0.loader

			var_2.GetSprite(var_12_6, "ui/levelstageview_atlas", "continuous_operation_on", arg_12_0.btnOn)

			arg_12_0.isCO = false
		end
	end

	return
end

function var_0_1.OnDestroy(arg_13_0)
	local var_13_0 = arg_13_0.loader

	var_1.Clear(var_13_0)
	var_0_1.super.OnDestroy(arg_13_0)

	return
end

return var_0_1
