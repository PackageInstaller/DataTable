local var_0_0 = class("LevelStageAutoFightPanel", BaseSubView)

function var_0_0.Ctor(arg_1_0, ...)
	var_0_0.super.Ctor(arg_1_0, ...)

	arg_1_0.buffer = setmetatable({}, {
		__index = function(arg_2_0, arg_2_1)
			return function(arg_3_0, ...)
				arg_1_0:ActionInvoke(arg_2_1, ...)

				return
			end
		end,
		__newindex = function()
			errorMsg("Cant write Data in ActionInvoke buffer")

			return
		end
	})
	arg_1_0.isFrozen = nil

	arg_1_0:bind(LevelUIConst.ON_FROZEN, function()
		arg_1_0.isFrozen = true

		return
	end)
	arg_1_0:bind(LevelUIConst.ON_UNFROZEN, function()
		arg_1_0.isFrozen = nil

		return
	end)

	arg_1_0.loader = AutoLoader.New()
	arg_1_0.isCO = false

	return
end

function var_0_0.getUIName(arg_7_0)
	return "LevelStageAutoFightPanel"
end

function var_0_0.OnInit(arg_8_0)
	arg_8_0.btnOn = arg_8_0._tf:Find("On")
	arg_8_0.btnOff = arg_8_0._tf:Find("Off")

	onButton(arg_8_0, arg_8_0.btnOn, function()
		getProxy(ChapterProxy):SetChapterAutoFlag(arg_8_0.contextData.chapterVO.id, false, ChapterConst.AUTOFIGHT_STOP_REASON.MANUAL)
		PlayerPrefs.SetInt("chapter_autofight_flag_" .. arg_8_0.contextData.chapterVO.id, 0)
		PlayerPrefs.Save()
		arg_8_0:UpdateAutoFightMark()

		return
	end, SFX_PANEL)
	onButton(arg_8_0, arg_8_0.btnOff, function()
		getProxy(ChapterProxy):SetChapterAutoFlag(arg_8_0.contextData.chapterVO.id, true)
		PlayerPrefs.SetInt("chapter_autofight_flag_" .. arg_8_0.contextData.chapterVO.id, 1)
		PlayerPrefs.Save()
		arg_8_0:UpdateAutoFightMark()

		if not arg_8_0.isFrozen then
			arg_8_0:emit(LevelUIConst.TRIGGER_ACTION)
		end

		return
	end, SFX_PANEL)

	arg_8_0.restTime = arg_8_0.btnOn:Find("Rest")

	local var_8_0 = string.split(i18n("multiple_sorties_rest_time"), "$1/$2")

	setText(arg_8_0.restTime:Find("Text"), var_8_0[1])
	setText(arg_8_0.restTime:Find("Text (2)"), var_8_0[2])

	return
end

function var_0_0.UpdateAutoFightMark(arg_11_0)
	local var_11_0 = getProxy(ChapterProxy):GetChapterAutoFlag(arg_11_0.contextData.chapterVO.id) == 1

	setActive(arg_11_0.btnOn, var_11_0)
	setActive(arg_11_0.btnOff, not var_11_0)
	arg_11_0:UpdateContinuousOperation()
	arg_11_0:emit(LevelUIConst.STRATEGY_PANEL_AUTOFIGHT_ACTIVE, var_11_0)

	return
end

function var_0_0.UpdateContinuousOperation(arg_12_0)
	local var_12_0 = getProxy(ChapterProxy):GetContinuousData(SYSTEM_SCENARIO)

	if var_12_0 and var_12_0:IsActive() then
		local var_12_1 = "$1/$2"

		for iter_12_0, iter_12_1 in ipairs({
			var_12_0:GetTotalBattleTime() - var_12_0:GetRestBattleTime() + 1,
			var_12_0:GetTotalBattleTime()
		}) do
			var_12_1 = string.gsub(var_12_1, "$" .. iter_12_0, iter_12_1)
		end

		setText(arg_12_0.restTime:Find("Count"), var_12_1)
		setActive(arg_12_0.restTime, true)

		if not arg_12_0.isCO then
			arg_12_0.loader:GetSprite("ui/levelstageview_atlas", "continuous_operation_on", arg_12_0.btnOn)

			arg_12_0.isCO = true
		end
	else
		setActive(arg_12_0.restTime, false)

		if arg_12_0.isCO then
			arg_12_0.loader:GetSprite("ui/levelstageview_atlas", "continuous_operation_on", arg_12_0.btnOn)

			arg_12_0.isCO = false
		end
	end

	return
end

function var_0_0.OnDestroy(arg_13_0)
	arg_13_0.loader:Clear()
	var_0_0.super.OnDestroy(arg_13_0)

	return
end

return var_0_0
