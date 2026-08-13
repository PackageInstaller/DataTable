class = var_0_10000

local var_0_0 = "MapBuilder"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

var_0_1.TYPENORMAL = 1
var_0_1.TYPEESCORT = 2
var_0_1.TYPESHINANO = 3
var_0_1.TYPESKIRMISH = 4
var_0_1.TYPEBISMARCK = 5
var_0_1.TYPESSSS = 6
var_0_1.TYPEATELIER = 7
var_0_1.TYPESENRANKAGURA = 8
var_0_1.TYPESP = 9
var_0_1.TYPESPFULL = 10
var_0_1.TYPESPSERIES = 11
var_0_1.TYPESPSERIESFULL = 12
var_0_1.TYPEATELIERYUMIA = 13
var_0_1.TYPEEXSP = 14
var_0_1.TYPESPSERIESRECREW = 15

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2.event, arg_1_2.contextData)

	arg_1_0.sceneParent = arg_1_2
	arg_1_0.map = arg_1_1:Find("maps")
	arg_1_0.float = arg_1_1:Find("float")
	arg_1_0.tweens = {}

	local var_1_0 = arg_1_0.sceneParent._tf.rect.size.x

	arg_1_0.mapHeight = var_3.y
	arg_1_0.mapWidth = var_1_0
	setmetatable = var_1_0
	arg_1_0.buffer = var_1_0({}, {
		__index = function(arg_2_0, arg_2_1)
			return function(arg_3_0, ...)
				if arg_2_1 == "UpdateMapItems" then
					underscore = var_1

					if var_1.any(arg_1_0._funcQueue, function(arg_4_0)
						return arg_4_0.funcName == arg_2_1
					end) then
						errorMsg = var_1

						var_1("Multiple Calls of function 'UpdateMapItems' in Mapbuilder")

						return
					end
				end

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

	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_0.bind

	LevelUIConst = var_7

	var_1_2(var_1_1, var_7.ON_FROZEN, function()
		arg_1_0.isFrozen = true

		return
	end)

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.bind

	LevelUIConst = var_7

	var_1_4(var_1_3, var_7.ON_UNFROZEN, function()
		arg_1_0.isFrozen = nil

		return
	end)

	return
end

function var_0_1.Load(arg_8_0)
	if arg_8_0._state ~= var_0_1.STATES.NONE then
		return
	end

	arg_8_0._state = var_0_1.STATES.LOADING
	pg = var_1

	local var_8_0 = var_1.UIMgr.GetInstance()

	var_1.LoadingOn(var_8_0)

	PoolMgr = var_1

	local var_8_1 = var_1.GetInstance()

	var_1.GetUI(var_8_1, arg_8_0:getUIName(), true, function(arg_9_0)
		local var_9_0 = arg_8_0

		var_1.Loaded(var_9_0, arg_9_0)

		local var_9_1 = arg_8_0

		var_1.Init(var_9_1)

		return
	end)

	return
end

function var_0_1.isfrozen(arg_10_0)
	return arg_10_0.isFrozen
end

function var_0_1.GetType(arg_11_0)
	return 0
end

function var_0_1.Destroy(arg_12_0)
	if arg_12_0._state == var_0_1.STATES.INITED then
		arg_12_0:Hide()
	end

	var_0_1.super.Destroy(arg_12_0)

	return
end

function var_0_1.OnDestroy(arg_13_0)
	arg_13_0.tweens = nil

	return
end

function var_0_1.Show(arg_14_0)
	var_0_1.super.Show(arg_14_0)
	arg_14_0:OnShow()

	return
end

function var_0_1.Hide(arg_15_0)
	arg_15_0:OnHide()
	var_0_1.super.Hide(arg_15_0)

	return
end

function var_0_1.OnShow(arg_16_0)
	return
end

function var_0_1.OnHide(arg_17_0)
	pairs = var_1_10001

	for iter_17_0, iter_17_1 in var_1_10001(arg_17_0.tweens) do
		LeanTween = var_1_10006

		var_1_10006.cancel(iter_17_1)
	end

	arg_17_0.tweens = {}

	return
end

function var_0_1.UpdateMapVO(arg_18_0, arg_18_1)
	arg_18_0.data = arg_18_1

	return
end

function var_0_1.UpdateView(arg_19_0)
	arg_19_0:UpdateButtons()

	return
end

function var_0_1.UpdateButtons(arg_20_0)
	return
end

function var_0_1.UpdateMapItems(arg_21_0)
	return
end

function var_0_1.HideFloat(arg_22_0)
	return
end

function var_0_1.ShowFloat(arg_23_0)
	return
end

function var_0_1.RecordTween(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0.tweens[arg_24_1] = arg_24_2

	return
end

function var_0_1.DeleteTween(arg_25_0, arg_25_1)
	if arg_25_0.tweens[arg_25_1] then
		LeanTween = var_1_10003

		var_1_10003.cancel(var_2)

		arg_25_0.tweens[arg_25_1] = nil
	end

	return
end

function var_0_1.UpdateChapterTF(arg_26_0, arg_26_1)
	return
end

function var_0_1.TryOpenChapter(arg_27_0, arg_27_1)
	errorMsg = var_1_10002

	var_1_10002("Not Implent TryOpenChapter in " .. arg_27_0.__cname)

	return
end

function var_0_1.TryOpenChapterInfo(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = arg_28_0

	if arg_28_0.isfrozen(var_28_0) then
		return
	end

	getProxy = var_4
	ChapterProxy = var_28_0

	local var_28_1 = var_4(var_28_0)

	if var_4.getChapterById(var_28_1, arg_28_1, true).active then
		local var_28_2 = arg_28_0.sceneParent

		var_5.switchToChapter(var_28_2, var_4)

		return
	end

	local var_28_3 = var_4

	if not var_4.isUnlock(var_28_3) then
		var_28_3 = var_4

		local var_28_5

		if #var_4.GetPrevChapterNames(var_28_3) == 1 then
			pg = var_28_5

			local var_28_4 = var_28_5.TipsMgr.GetInstance()

			var_28_5 = var_28_5.ShowTips
			i18n = var_1_10009

			var_28_5(var_28_4, var_1_10009("levelScene_tracking_error_pre", var_5[1]))
		else
			pg = var_28_5

			local var_28_6 = var_28_5.TipsMgr.GetInstance()
			local var_28_7 = var_6.ShowTips

			i18n = var_1_10009

			var_28_7(var_28_6, var_1_10009("levelScene_tracking_error_pre_2", var_5[1], var_5[2]))
		end

		return
	end

	getProxy = var_5
	ChapterProxy = var_28_3

	local var_28_8 = var_5(var_28_3)
	local var_28_9 = var_5.getMapById
	local var_28_10 = var_4
	local var_28_11 = var_28_9(var_28_8, var_4.getConfig(var_28_10, "map"))

	if not var_5.isRemaster(var_28_11) and not var_4:inActTime() then
		pg = var_6

		local var_28_12 = var_6.TipsMgr.GetInstance()
		local var_28_13 = var_6.ShowTips

		i18n = var_1_10009

		var_28_13(var_28_12, var_1_10009("battle_levelScene_close"))

		return
	end

	local var_28_14 = var_4:getConfig("unlocklevel")

	getProxy = var_28_8
	PlayerProxy = var_9

	local var_28_15 = var_28_8(var_9)
	local var_28_16

	if var_7.getRawData(var_28_15).level < var_28_14 then
		pg = var_28_16
		var_28_10 = var_28_16.TipsMgr.GetInstance()
		var_28_16 = var_28_16.ShowTips
		i18n = var_11

		var_28_16(var_28_10, var_11("levelScene_chapter_level_limit", var_28_14))

		return
	end

	getProxy = var_28_16
	ChapterProxy = var_28_10

	local var_28_17 = var_28_16(var_28_10)

	if var_8.getActiveChapter(var_28_17, true) and var_8.id ~= arg_28_1 then
		local var_28_18 = arg_28_0
		local var_28_19 = arg_28_0.emit

		LevelMediator2 = var_1_10012

		var_28_19(var_28_18, var_1_10012.ON_STRATEGYING_CHAPTER)

		return
	end

	if var_4:IsSpChapter() then
		SettingsProxy = var_9

		var_9.SetActivityMapSPTip()
		arg_28_0:UpdateChapterTF(arg_28_1)
	end

	if not arg_28_3 then
		local var_28_20 = arg_28_0.sceneParent

		var_9.DisplayLevelInfoPanel(var_28_20, arg_28_1, arg_28_2)
	else
		local var_28_21 = arg_28_0.sceneParent

		var_9.DisplayLevelInfoSPPanel(var_28_21, arg_28_1, arg_28_3, arg_28_2)
	end

	return
end

function var_0_1.OnSubmitTaskDone(arg_29_0)
	return
end

function var_0_1.PlayEnterAnim(arg_30_0)
	return
end

return var_0_1
