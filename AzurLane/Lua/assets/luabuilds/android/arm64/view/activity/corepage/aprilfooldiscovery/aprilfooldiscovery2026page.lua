local var_0_0 = class("AprilFoolDiscovery2026Page", import("view.activity.CorePage.CoreActivityAprilFoolDiscoveryPage"))
local var_0_1 = "magicbuli"

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.items = CustomIndexLayer.Clone2Full(arg_1_0._tf:Find("AD/List"), 9)
	arg_1_0.selectIndex = 0
	arg_1_0.btnHelp = arg_1_0.bg:Find("help_btn")
	arg_1_0.btnBattle = arg_1_0.bg:Find("battle_btn")
	arg_1_0.battle_btn = arg_1_0.bg:Find("battle_btn_1")
	arg_1_0.btnIncomplete = arg_1_0.bg:Find("incomplete_btn")
	arg_1_0.tip = arg_1_0.bg:Find("tip")
	arg_1_0.tip_bg = arg_1_0.bg:Find("tipbg")
	arg_1_0.slider = arg_1_0.bg:Find("slider")
	arg_1_0.leftTime = arg_1_0.slider:Find("time")
	arg_1_0.sliderbg = arg_1_0.bg:Find("sliderbg")
	arg_1_0.loader = AutoLoader.New()

	for iter_1_0 = 1, #var_0_1 do
		arg_1_0.loader:GetSprite("UI/AprilFoolDiscovery2026Page_atlas", string.sub(var_0_1, iter_1_0, iter_1_0), arg_1_0.items[iter_1_0]:Find("Character"), true)
	end

	arg_1_0._funcsLink = {}

	setText(arg_1_0.slider:Find("timetext"), i18n("aprilfool_2026_cd"))

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

function var_0_0.CreateCDTimer(arg_7_0)
	if arg_7_0.CDTimer then
		return
	end

	if #arg_7_0.activity.data2_list ~= #arg_7_0.keyList then
		if pg.TimeMgr.GetInstance():GetServerTime() >= arg_7_0.activity.data2 then
			setActive(arg_7_0.slider, false)
			setActive(arg_7_0.sliderbg, false)
			arg_7_0:RemoveCDTimer()

			return
		end

		setActive(arg_7_0.slider, true)
		setActive(arg_7_0.sliderbg, true)

		arg_7_0.CDTimer = Timer.New(function()
			local var_8_0 = pg.TimeMgr.GetInstance():GetServerTime()

			if arg_7_0.activity.data2 <= var_8_0 then
				setActive(arg_7_0.slider, false)
				setActive(arg_7_0.sliderbg, false)
				arg_7_0:RemoveCDTimer()

				return
			end

			local var_8_1 = arg_7_0.activity.data2 - var_8_0

			setText(arg_7_0.leftTime, string.format("%d:%02d", math.floor((arg_7_0.activity.data2 - var_8_0) / 60), (arg_7_0.activity.data2 - var_8_0) % 60))
			setSlider(arg_7_0.slider, 0, 1, var_8_1 / arg_7_0.puzzleConfig.cd)

			return
		end, 1, -1)

		arg_7_0.CDTimer:Start()
		arg_7_0.CDTimer.func()

		return
	end
end

function var_0_0.OnFirstFlush(arg_9_0)
	assert(pg.activity_event_picturepuzzle[arg_9_0.activity.id], "Can't Find activity_event_picturepuzzle 's ID : " .. arg_9_0.activity.id)

	arg_9_0.puzzleConfig = pg.activity_event_picturepuzzle[arg_9_0.activity.id]
	arg_9_0.keyList = Clone(pg.activity_event_picturepuzzle[arg_9_0.activity.id].pickup_picturepuzzle)

	table.insertto(arg_9_0.keyList, pg.activity_event_picturepuzzle[arg_9_0.activity.id].drop_picturepuzzle)
	assert(#arg_9_0.keyList == #arg_9_0.items, string.format("keyList has {0}, but items has {1}", #arg_9_0.keyList, #arg_9_0.items))
	table.sort(arg_9_0.keyList)
	onButton(arg_9_0, arg_9_0.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.SuperBulin2_help.tip
		})

		return
	end, SFX_PANEL)

	local var_9_0 = arg_9_0.activity.id

	onButton(arg_9_0, arg_9_0.btnBattle, function()
		if #arg_9_0.activity.data2_list < #arg_9_0.keyList then
			pg.TipsMgr.GetInstance():ShowTips(i18n("caibulin_lock_tip"))

			return
		end

		;({
			warnMsg = "bulin_tip_other3"
		}).stageId = arg_9_0.puzzleConfig.chapter

		arg_9_0:emit(ActivityMediator.ON_SIMULATION_COMBAT, {
			warnMsg = "bulin_tip_other3"
		}, function()
			if not pg.NewStoryMgr.GetInstance():IsPlayed(tostring(var_0), true) then
				pg.m02:sendNotification(GAME.STORY_UPDATE, {
					storyId = tostring(var_0)
				})
			end

			local var_12_0 = getProxy(ActivityProxy)
			local var_12_1 = var_12_0:getActivityById(var_9_0)

			if var_12_1.data1 == 1 then
				return
			end

			var_12_1.data3 = 1

			var_12_0:updateActivity(var_12_1)

			return
		end)

		return
	end, SFX_PANEL)

	local var_9_1 = arg_9_0.activity:getConfig("config_client").guideName

	arg_9_0:AddFunc(function(arg_13_0)
		pg.NewStoryMgr.GetInstance():Play(var_9_1[1], arg_13_0)

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_14_0)
	local var_14_1 = #arg_14_0.activity.data2_list == #arg_14_0.keyList
	local var_14_2 = arg_14_0.activity.data2_list

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.items) do
		local var_14_3 = arg_14_0.keyList[iter_14_0]
		local var_14_4 = table.contains(var_14_2, arg_14_0.keyList[iter_14_0]) and 3 or table.contains(arg_14_0.activity.data3_list, arg_14_0.keyList[iter_14_0]) and 2 or 1

		onButton(arg_14_0, iter_14_1, function()
			if var_14_4 >= 3 then
				return
			end

			if var_14_4 == 2 then
				arg_14_0.selectIndex = iter_14_0

				arg_14_0:UpdateSelection()

				return quickPlayAnimation(iter_14_1:Find("Unlock"), "im_AprilFoolDiscovery2026Page_Unlock")
			elseif var_14_4 == 1 then
				if pg.TimeMgr.GetInstance():GetServerTime() < arg_14_0.activity.data2 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("bulin_tip_other2"))

					return
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("bulin_tip_other1"),
					onYes = function()
						pg.m02:sendNotification(GAME.PUZZLE_PIECE_OP, {
							cmd = 3,
							actId = arg_14_0.activity.id,
							id = var_14_3
						})

						arg_14_0.selectIndex = iter_14_0

						return
					end
				})
			end

			return
		end)
		setActive(iter_14_1:Find("Character"), var_14_4 == 3)

		if var_14_4 == 3 then
			quickPlayAnimation(iter_14_1, "anim_AprilFoolDiscovery2026Page_open")
		end

		setActive(iter_14_1:Find("Selected"), var_14_4 == 2)

		if var_14_4 == 2 then
			setActive(iter_14_1:Find("Unlock"), true)
		end

		setActive(iter_14_1:Find("Locked"), var_14_4 == 1)
	end

	SetActive(arg_14_0.battle_btn, not var_14_1)
	SetActive(arg_14_0.btnBattle, var_14_1)
	arg_14_0:UpdateSelection()

	if #table.mergeArray(arg_14_0.activity.data1_list, arg_14_0.activity.data2_list, true) >= #pg.activity_event_picturepuzzle[arg_14_0.activity.id].pickup_picturepuzzle + #pg.activity_event_picturepuzzle[arg_14_0.activity.id].drop_picturepuzzle then
		local var_14_5 = arg_14_0.activity:getConfig("config_client").comStory

		arg_14_0:AddFunc(function(arg_17_0)
			pg.NewStoryMgr.GetInstance():Play(var_14_5, arg_17_0)

			return
		end)
	end

	return
end

function var_0_0.UpdateSelection(arg_18_0)
	local var_18_0 = table.contains(arg_18_0.activity.data3_list, arg_18_0.keyList[arg_18_0.selectIndex])
	local var_18_1 = var_18_0 and i18n("SuperBulin2_tip" .. arg_18_0.selectIndex) or false

	SetActive(arg_18_0.tip, var_18_1)

	local var_18_2 = var_18_0 and i18n("SuperBulin2_tip" .. arg_18_0.selectIndex) or false

	SetActive(arg_18_0.tip_bg, var_18_2)

	local var_18_3 = var_18_0 and i18n("SuperBulin2_tip" .. arg_18_0.selectIndex) or ""

	setText(arg_18_0.tip, var_18_3)
	arg_18_0:CreateCDTimer()

	return
end

return var_0_0
