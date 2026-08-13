class = var_0_10000

local var_0_0 = "NewBattleResultScene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "NewBattleResultEmptyUI"
end

function var_0_1.getGroupName(arg_2_0)
	return "BattleScene"
end

function var_0_1.didEnter(arg_3_0)
	arg_3_0._parentTf = arg_3_0._tf.parent

	arg_3_0:InitData()
	arg_3_0:Adjustion()
	arg_3_0:SetUp(arg_3_0.pages)

	if arg_3_0.contextData.needVibrate then
		arg_3_0:Vibrate()
	end

	arg_3_0:BlurPanel(arg_3_0._tf, {
		staticBlur = true,
		lockGlobalBlur = true
	})

	onDelayTick = var_1

	var_1(function()
		if arg_3_0.contextData.needCloseCamera then
			local var_4_0 = arg_3_0

			var_0.CloseCamera(var_4_0)
		end

		return
	end, 0.2)

	return
end

function var_0_1.Adjustion(arg_5_0)
	GetComponent = var_1_10001

	local var_5_0 = arg_5_0._tf

	typeof = var_1_10003
	AspectRatioFitter = var_1_10004

	local var_5_1 = var_1_10001(var_5_0, var_1_10003(var_1_10004))

	var_5_1.enabled = true
	pg = var_2
	var_5_1.aspectRatio = var_2.CameraFixMgr.GetInstance().targetRatio
	pg = var_2

	local var_5_2 = var_2.CameraFixMgr.GetInstance()
	local var_5_3 = var_2.bind

	pg = var_1_10004
	arg_5_0.camEventId = var_5_3(var_5_2, var_1_10004.CameraFixMgr.ASPECT_RATIO_UPDATE, function(arg_6_0, arg_6_1)
		var_5_1.aspectRatio = arg_6_1

		return
	end)

	return
end

local function var_0_2(arg_7_0)
	getProxy = var_1_10001
	SettingsProxy = var_1_10002

	local var_7_0 = var_1_10001(var_1_10002)

	if var_1.IsDisplayResultPainting(var_7_0) then
		return
	end

	for iter_7_0 = #arg_7_0, 1, -1 do
		local var_7_1 = arg_7_0[iter_7_0]

		NewBattleResultDisplayPaintingsPage = var_1_10007

		if var_7_1 == var_1_10007 then
			table = var_7_1

			var_7_1.remove(arg_7_0, iter_7_0)
		end
	end

	return
end

function var_0_1.InitData(arg_8_0)
	NewBattleResultYumiaMaterialPage = var_1_10001

	if var_1_10001.NeedShowYumiaMaterailDrop(arg_8_0.contextData.drops) then
		local var_8_0 = {}

		NewBattleResultGradePage = var_2
		var_8_0[1] = var_2
		NewBattleResultDisplayAwardPage = var_2
		var_8_0[2] = var_2
		NewBattleResultYumiaMaterialPage = var_2
		var_8_0[3] = var_2
		NewBattleResultDisplayPaintingsPage = var_2
		var_8_0[4] = var_2
		NewBattleResultStatisticsPage = var_2
		var_8_0[5] = var_2

		if not var_8_0 then
			var_8_0 = {}
			NewBattleResultGradePage = var_2
			var_8_0[1] = var_2
			NewBattleResultDisplayAwardPage = var_2
			var_8_0[2] = var_2
			NewBattleResultDisplayPaintingsPage = var_2
			var_8_0[3] = var_2
			NewBattleResultStatisticsPage = var_2
			var_8_0[4] = var_2
		end

		NewBattleResultSystem2Pages = var_2

		local var_8_1

		if not var_2[arg_8_0.contextData.system] then
			var_8_1 = var_8_0
		end

		arg_8_0.pages = var_8_1

		var_0_2(arg_8_0.pages)

		local var_8_2 = arg_8_0.contextData

		NewBattleResultUtil = var_3
		var_8_2.oldMainShips = var_3.RemoveNonStatisticShips(arg_8_0.contextData.oldMainShips, arg_8_0.contextData.statistics)

		local var_8_3 = arg_8_0.contextData

		NewBattleResultDataExtender = var_3
		var_8_3.newMainShips = var_3.GetNewMainShips(arg_8_0.contextData)

		local var_8_4 = arg_8_0.contextData

		NewBattleResultDataExtender = var_3
		var_8_4.autoSkipFlag = var_3.GetAutoSkipFlag(arg_8_0.contextData, arg_8_0.contextData.system)

		local var_8_5 = arg_8_0.contextData

		NewBattleResultDataExtender = var_3
		var_8_5.needVibrate = var_3.NeedVibrate(arg_8_0.contextData.autoSkipFlag)

		local var_8_6 = arg_8_0.contextData

		NewBattleResultDataExtender = var_3
		var_8_6.needCloseCamera = var_3.NeedCloseCamera(arg_8_0.contextData.system)

		local var_8_7 = arg_8_0.contextData

		NewBattleResultDataExtender = var_3
		var_8_7.needHelpMessage = var_3.NeedHelpMessage(arg_8_0.contextData.system, arg_8_0.contextData.score)

		local var_8_8 = arg_8_0.contextData

		NewBattleResultDataExtender = var_3
		var_8_8.expBuff = var_3.GetExpBuffs(arg_8_0.contextData.system)

		local var_8_9 = arg_8_0.contextData

		NewBattleResultDataExtender = var_3
		var_8_9.buffShips = var_3.GetShipBuffs(arg_8_0.contextData.system)

		return
	end
end

function var_0_1.CloseCamera(arg_9_0)
	ys = var_1_10001

	var_1_10001.Battle.BattleCameraUtil.GetInstance().ActiveMainCamera(false)

	return
end

function var_0_1.Vibrate(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.CriMgr.GetInstance()
	local var_10_1 = var_1.PlaySoundEffect_V3

	SFX_AUTO_BATTLE = var_1_10003

	var_10_1(var_10_0, var_1_10003)

	LuaHelper = var_10_1

	var_10_1.Vibrate()

	return
end

function var_0_1.SetUp(arg_11_0, arg_11_1)
	local var_11_0 = {}

	arg_11_0.history = {}
	ipairs = var_3

	for iter_11_0, iter_11_1 in var_3(arg_11_1) do
		table = var_1_10008

		var_1_10008.insert(var_11_0, function(arg_12_0)
			if arg_11_0.exited then
				return
			end

			local var_12_0 = iter_11_1.New(arg_11_0._tf, arg_11_0.event, arg_11_0.contextData)

			var_1.ExecuteAction(var_12_0, "SetUp", arg_12_0, function()
				local var_13_0 = arg_11_0

				var_0.DestroyHistory(var_13_0)

				return
			end)

			table = var_2

			var_2.insert(arg_11_0.history, var_1)

			return
		end)
	end

	seriesAsync = var_3

	var_3(var_11_0, function()
		local var_14_0 = arg_11_0

		var_0.GoBack(var_14_0)

		return
	end)

	return
end

function var_0_1.DestroyHistory(arg_15_0)
	ipairs = var_1_10001

	for iter_15_0, iter_15_1 in var_1_10001(arg_15_0.history) do
		isa = var_1_10006

		local var_15_0 = iter_15_1

		NewBattleResultStatisticsPage = var_1_10008

		if not var_1_10006(var_15_0, var_1_10008) then
			iter_15_1:Destroy()
		end
	end

	return
end

function var_0_1.GoBack(arg_16_0)
	local function var_16_0()
		local var_17_0 = arg_16_0

		NewBattleResultBackSceneHandler = var_2_10001
		var_17_0.backSceneHandler = var_2_10001.New(arg_16_0.contextData)

		local var_17_1 = arg_16_0.backSceneHandler

		var_0.Execute(var_17_1)

		return
	end

	if arg_16_0.contextData.needHelpMessage then
		local var_16_1 = arg_16_0
		local var_16_2 = arg_16_0.emit

		NewBattleResultMediator = var_1_10004

		var_16_2(var_16_1, var_1_10004.OPEN_FIALED_HELP, var_16_0)
	else
		var_16_0()
	end

	return
end

function var_0_1.onBackPressed(arg_18_0)
	return
end

function var_0_1.willExit(arg_19_0)
	pg = var_1_10001

	local var_19_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_19_0, arg_19_0._tf, arg_19_0._parentTf)

	if arg_19_0.camEventId then
		pg = var_1

		local var_19_1 = var_1.CameraFixMgr.GetInstance()

		var_1.disconnect(var_19_1, arg_19_0.camEventId)

		arg_19_0.camEventId = nil
	end

	if arg_19_0.backSceneHandler then
		local var_19_2 = arg_19_0.backSceneHandler

		var_1.Dispose(var_19_2)

		arg_19_0.backSceneHandler = nil
	end

	if arg_19_0.history then
		ipairs = var_1

		for iter_19_0, iter_19_1 in var_1(arg_19_0.history) do
			iter_19_1:Destroy()
		end

		arg_19_0.history = nil
	end

	return
end

return var_0_1
