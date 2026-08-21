local var_0_0 = class("AprilFoolDiscoveryRePage", import(".AprilFoolDiscoveryPage"))

function var_0_0.OnInit(arg_1_0)
	var_0_0.super.OnInit(arg_1_0)

	arg_1_0.bulin = arg_1_0.bg:Find("bulin")
	arg_1_0.bulinAnim = arg_1_0.bulin:Find("bulin"):GetComponent("SpineAnimUI")

	setText(arg_1_0.bulin:Find("Text"), i18n("super_bulin_tip"))
	setActive(arg_1_0.bulin, false)

	arg_1_0._funcsLink = {}

	return
end

function var_0_0.AddFunc(arg_2_0, arg_2_1)
	table.insert(arg_2_0._funcsLink, arg_2_1)

	if #arg_2_0._funcsLink > 1 then
		return
	end

	arg_2_0:PlayFuncsLink()

	return
end

function var_0_0.PlayFuncsLink(arg_3_0)
	local var_3_0 = false

	;(function(...)
		if var_3_0 then
			table.remove(arg_3_0._funcsLink, 1)
		end

		var_3_0 = true

		if arg_3_0._funcsLink[1] then
			arg_3_0._funcsLink[1](var_0, ...)
		end

		return
	end)()

	return
end

function var_0_0.OnDataSetting(arg_5_0)
	local var_5_0 = var_0_0.super.OnDataSetting(arg_5_0)

	var_5_0 = var_5_0 or (function()
		if arg_5_0.activity.data1 == 1 and arg_5_0.activity.data3 == 1 then
			arg_5_0.activity.data3 = 0

			pg.m02:sendNotification(GAME.PUZZLE_PIECE_OP, {
				cmd = 4,
				actId = arg_5_0.activity.id
			})

			return true
		end

		return
	end)()

	return var_5_0
end

function var_0_0.OnFirstFlush(arg_7_0)
	assert(pg.activity_event_picturepuzzle[arg_7_0.activity.id], "Can't Find activity_event_picturepuzzle 's ID : " .. arg_7_0.activity.id)

	arg_7_0.puzzleConfig = pg.activity_event_picturepuzzle[arg_7_0.activity.id]
	arg_7_0.keyList = Clone(pg.activity_event_picturepuzzle[arg_7_0.activity.id].pickup_picturepuzzle)

	table.insertto(arg_7_0.keyList, pg.activity_event_picturepuzzle[arg_7_0.activity.id].drop_picturepuzzle)
	assert(#arg_7_0.keyList == #arg_7_0.items, string.format("keyList has {0}, but items has 9", #arg_7_0.keyList))
	table.sort(arg_7_0.keyList)
	onButton(arg_7_0, arg_7_0.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.bulin_help.tip
		})

		return
	end, SFX_PANEL)

	local var_7_0 = arg_7_0.activity.id

	onButton(arg_7_0, arg_7_0.btnBattle, function()
		if #arg_7_0.activity.data2_list < #arg_7_0.keyList then
			pg.TipsMgr.GetInstance():ShowTips(i18n("common_activity_not_start"))

			return
		end

		arg_7_0:emit(ActivityMediator.ON_SIMULATION_COMBAT, {
			warnMsg = "bulin_tip_other3",
			stageId = arg_7_0.puzzleConfig.chapter
		}, function()
			local var_10_0 = getProxy(ActivityProxy)
			local var_10_1 = var_10_0:getActivityById(var_7_0)

			if var_10_1.data1 == 1 then
				return
			end

			var_10_1.data3 = 1

			var_10_0:updateActivity(var_10_1)

			return
		end)

		return
	end, SFX_PANEL)
	onButton(arg_7_0, arg_7_0.bulin, function()
		if arg_7_0.activity.data1 >= 1 then
			seriesAsync({
				function(arg_12_0)
					pg.MsgboxMgr.GetInstance():ShowMsgBox({
						content = i18n("super_bulin"),
						onYes = arg_12_0
					})

					return
				end,
				function(arg_13_0)
					arg_7_0:emit(ActivityMediator.ON_SIMULATION_COMBAT, {
						warnMsg = "bulin_tip_other3",
						stageId = arg_7_0:GetLinkStage()
					}, function()
						local var_14_0 = getProxy(ActivityProxy)
						local var_14_1 = var_14_0:getActivityById(var_7_0)

						if var_14_1.data1 == 2 then
							return
						end

						var_14_1.data3 = 1

						var_14_0:updateActivity(var_14_1)

						return
					end)

					return
				end
			})
		end

		return
	end)

	local var_7_1 = arg_7_0.activity:getConfig("config_client").guideName

	arg_7_0:AddFunc(function(arg_15_0)
		pg.SystemGuideMgr.GetInstance():PlayByGuideId(var_7_1, nil, arg_15_0)

		return
	end)

	return
end

local var_0_1 = {
	"lock",
	"hint",
	"unlock"
}

function var_0_0.OnUpdateFlush(arg_16_0)
	local var_16_0 = arg_16_0.activity.data1 >= 1
	local var_16_1 = #arg_16_0.activity.data2_list == #arg_16_0.keyList
	local var_16_2 = arg_16_0.activity.data1 >= 1 and "activity_bg_aprilfool_final" or "activity_bg_aprilfool_discovery"

	if (arg_16_0.activity.data1 >= 1 and "activity_bg_aprilfool_final" or "activity_bg_aprilfool_discovery") ~= arg_16_0.bgName then
		setImageSprite(arg_16_0.bg, LoadSprite("ui/activityuipage/AprilFoolDiscoveryRePage_atlas", var_16_2))

		arg_16_0.bg:GetComponent(typeof(Image)).enabled = true
		arg_16_0.bgName = var_16_2
	end

	local var_16_3 = arg_16_0.activity.data2_list

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.items) do
		local var_16_4 = arg_16_0.keyList[iter_16_0]
		local var_16_5 = table.contains(var_16_3, arg_16_0.keyList[iter_16_0]) and 3 or table.contains(arg_16_0.activity.data3_list, arg_16_0.keyList[iter_16_0]) and 2 or 1

		onButton(arg_16_0, iter_16_1, function()
			if var_16_5 >= 3 then
				return
			end

			if var_16_5 == 2 then
				arg_16_0.selectIndex = iter_16_0

				arg_16_0:UpdateSelection()

				return
			elseif var_16_5 == 1 then
				if pg.TimeMgr.GetInstance():GetServerTime() < arg_16_0.activity.data2 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("bulin_tip_other2"))

					return
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("bulin_tip_other1"),
					onYes = function()
						pg.m02:sendNotification(GAME.PUZZLE_PIECE_OP, {
							cmd = 3,
							actId = arg_16_0.activity.id,
							id = var_16_4
						})

						arg_16_0.selectIndex = iter_16_0

						return
					end
				})
			end

			return
		end)
		arg_16_0.loader:GetSprite("UI/ActivityUIPage/AprilFoolDiscoveryRePage_atlas", var_0_1[var_16_5], iter_16_1:Find("state"))
		setActive(iter_16_1:Find("character"), var_16_5 == 3)
	end

	setActive(arg_16_0.btnBattle, var_16_1)
	setActive(arg_16_0.btnIncomplete, not var_16_1)
	arg_16_0:UpdateSelection()
	setActive(arg_16_0.bulin, var_16_0)

	if arg_16_0.activity.data1 == 1 then
		local var_16_6 = arg_16_0.activity:getConfig("config_client").popStory

		arg_16_0:AddFunc(function(arg_19_0)
			pg.NewStoryMgr.GetInstance():Play(var_16_6, arg_19_0)

			return
		end)
		arg_16_0:AddFunc(function(arg_20_0)
			local var_20_0 = getProxy(PlayerProxy):getRawData()

			if PlayerPrefs.GetInt("SuperBurinPopUp_" .. var_20_0.id, 0) == 0 then
				LoadContextCommand.LoadLayerOnTopContext(Context.New({
					mediator = SuperBulinPopMediator,
					viewComponent = SuperBulinPopView,
					data = {
						stageId = arg_16_0:GetLinkStage(),
						actId = arg_16_0.activity.id,
						onRemoved = arg_20_0
					}
				}))
				PlayerPrefs.SetInt("SuperBurinPopUp_" .. var_20_0.id, 1)
			end

			return
		end)
	end

	return
end

function var_0_0.OnDestroy(arg_21_0)
	var_0_0.super.OnDestroy(arg_21_0)

	return
end

function var_0_0.GetLinkStage(arg_22_0)
	return arg_22_0.activity:getConfig("config_client").lastChapter
end

return var_0_0
