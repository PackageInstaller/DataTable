local var_0_0 = class("MapBuilder", import("view.base.BaseSubView"))

var_0_0.TYPENORMAL = 1
var_0_0.TYPEESCORT = 2
var_0_0.TYPESHINANO = 3
var_0_0.TYPESKIRMISH = 4
var_0_0.TYPEBISMARCK = 5
var_0_0.TYPESSSS = 6
var_0_0.TYPEATELIER = 7
var_0_0.TYPESENRANKAGURA = 8
var_0_0.TYPESP = 9
var_0_0.TYPESPFULL = 10
var_0_0.TYPESPSERIES = 11
var_0_0.TYPESPSERIESFULL = 12
var_0_0.TYPEATELIERYUMIA = 13
var_0_0.TYPEEXSP = 14
var_0_0.TYPESPSERIESRECREW = 15

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2.event, arg_1_2.contextData)

	arg_1_0.sceneParent = arg_1_2
	arg_1_0.map = arg_1_1:Find("maps")
	arg_1_0.float = arg_1_1:Find("float")
	arg_1_0.tweens = {}
	arg_1_0.mapWidth, arg_1_0.mapHeight = arg_1_0.sceneParent._tf.rect.size.x, arg_1_0.sceneParent._tf.rect.size.y
	arg_1_0.buffer = setmetatable({}, {
		__index = function(arg_2_0, arg_2_1)
			return function(arg_3_0, ...)
				if arg_2_1 == "UpdateMapItems" and underscore.any(arg_1_0._funcQueue, function(arg_4_0)
					return arg_4_0.funcName == arg_2_1
				end) then
					errorMsg("Multiple Calls of function 'UpdateMapItems' in Mapbuilder")

					return
				end

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

	return
end

function var_0_0.Load(arg_8_0)
	if arg_8_0._state ~= var_0_0.STATES.NONE then
		return
	end

	arg_8_0._state = var_0_0.STATES.LOADING

	pg.UIMgr.GetInstance():LoadingOn()
	PoolMgr.GetInstance():GetUI(arg_8_0:getUIName(), true, function(arg_9_0)
		arg_8_0:Loaded(arg_9_0)
		arg_8_0:Init()

		return
	end)

	return
end

function var_0_0.isfrozen(arg_10_0)
	return arg_10_0.isFrozen
end

function var_0_0.GetType(arg_11_0)
	return 0
end

function var_0_0.Destroy(arg_12_0)
	if arg_12_0._state == var_0_0.STATES.INITED then
		arg_12_0:Hide()
	end

	var_0_0.super.Destroy(arg_12_0)

	return
end

function var_0_0.OnDestroy(arg_13_0)
	arg_13_0.tweens = nil

	return
end

function var_0_0.Show(arg_14_0)
	var_0_0.super.Show(arg_14_0)
	arg_14_0:OnShow()

	return
end

function var_0_0.Hide(arg_15_0)
	arg_15_0:OnHide()
	var_0_0.super.Hide(arg_15_0)

	return
end

function var_0_0.OnShow(arg_16_0)
	return
end

function var_0_0.OnHide(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0.tweens) do
		LeanTween.cancel(iter_17_1)
	end

	arg_17_0.tweens = {}

	return
end

function var_0_0.UpdateMapVO(arg_18_0, arg_18_1)
	arg_18_0.data = arg_18_1

	return
end

function var_0_0.UpdateView(arg_19_0)
	arg_19_0:UpdateButtons()

	return
end

function var_0_0.UpdateButtons(arg_20_0)
	return
end

function var_0_0.UpdateMapItems(arg_21_0)
	return
end

function var_0_0.HideFloat(arg_22_0)
	return
end

function var_0_0.ShowFloat(arg_23_0)
	return
end

function var_0_0.RecordTween(arg_24_0, arg_24_1, arg_24_2)
	arg_24_0.tweens[arg_24_1] = arg_24_2

	return
end

function var_0_0.DeleteTween(arg_25_0, arg_25_1)
	if arg_25_0.tweens[arg_25_1] then
		LeanTween.cancel(arg_25_0.tweens[arg_25_1])

		arg_25_0.tweens[arg_25_1] = nil
	end

	return
end

function var_0_0.UpdateChapterTF(arg_26_0, arg_26_1)
	return
end

function var_0_0.TryOpenChapter(arg_27_0, arg_27_1)
	errorMsg("Not Implent TryOpenChapter in " .. arg_27_0.__cname)

	return
end

function var_0_0.TryOpenChapterInfo(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	if arg_28_0:isfrozen() then
		return
	end

	local var_28_0 = getProxy(ChapterProxy):getChapterById(arg_28_1, true)

	if var_28_0.active then
		arg_28_0.sceneParent:switchToChapter(var_28_0)

		return
	end

	if not var_28_0:isUnlock() then
		local var_28_1 = var_28_0:GetPrevChapterNames()

		if #var_28_1 == 1 then
			pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_tracking_error_pre", var_28_1[1]))
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_tracking_error_pre_2", var_28_1[1], var_28_1[2]))
		end

		return
	end

	local var_28_2 = getProxy(ChapterProxy):getMapById(var_28_0:getConfig("map"))

	if not var_28_2:isRemaster() and not var_28_0:inActTime() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("battle_levelScene_close"))

		return
	end

	local var_28_3 = var_28_0:getConfig("unlocklevel")

	if var_28_3 > getProxy(PlayerProxy):getRawData().level then
		pg.TipsMgr.GetInstance():ShowTips(i18n("levelScene_chapter_level_limit", var_28_3))

		return
	end

	local var_28_4 = getProxy(ChapterProxy):getActiveChapter(true)

	if var_28_4 and var_28_4.id ~= arg_28_1 then
		arg_28_0:emit(LevelMediator2.ON_STRATEGYING_CHAPTER)

		return
	end

	if var_28_0:IsSpChapter() then
		SettingsProxy.SetActivityMapSPTip()
		arg_28_0:UpdateChapterTF(arg_28_1)
	end

	if not arg_28_3 then
		arg_28_0.sceneParent:DisplayLevelInfoPanel(arg_28_1, arg_28_2)
	else
		arg_28_0.sceneParent:DisplayLevelInfoSPPanel(arg_28_1, arg_28_3, arg_28_2)
	end

	return
end

function var_0_0.OnSubmitTaskDone(arg_29_0)
	return
end

function var_0_0.PlayEnterAnim(arg_30_0)
	return
end

return var_0_0
