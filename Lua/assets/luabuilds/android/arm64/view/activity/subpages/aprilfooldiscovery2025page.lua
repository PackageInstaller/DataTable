local var_0_0 = class("AprilFoolDiscovery2025Page", import(".AprilFoolDiscoveryRePage"))
local var_0_1 = "burinteam"

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bg = arg_1_0._tf:Find("AD")
	arg_1_0.items = CustomIndexLayer.Clone2Full(arg_1_0._tf:Find("AD/List"), 9)
	arg_1_0.selectIndex = 0
	arg_1_0.btnHelp = arg_1_0.bg:Find("help_btn")
	arg_1_0.btnBattle = arg_1_0.bg:Find("battle_btn")
	arg_1_0.battle_btn = arg_1_0.bg:Find("battle_btn_1")
	arg_1_0.btnIncomplete = arg_1_0.bg:Find("incomplete_btn")
	arg_1_0.tip = arg_1_0.bg:Find("tip")
	arg_1_0.slider = arg_1_0.bg:Find("slider")
	arg_1_0.leftTime = arg_1_0.slider:Find("time")
	arg_1_0.loader = AutoLoader.New()

	for iter_1_0 = 1, #var_0_1 do
		arg_1_0.loader:GetSprite("ui/activityuipage/AprilFoolDiscovery2025Page_atlas", string.sub(var_0_1, iter_1_0, iter_1_0), arg_1_0.items[iter_1_0]:Find("Character"))
	end

	arg_1_0._funcsLink = {}

	return
end

function var_0_0.OnDataSetting(arg_2_0)
	local var_2_0 = var_0_0.super.OnDataSetting(arg_2_0)

	var_2_0 = var_2_0 or (function()
		if arg_2_0.activity.data1 == 1 and arg_2_0.activity.data3 == 1 then
			arg_2_0.activity.data3 = 0

			pg.m02:sendNotification(GAME.PUZZLE_PIECE_OP, {
				cmd = 4,
				actId = arg_2_0.activity.id
			})

			return true
		end

		return
	end)()

	return var_2_0
end

function var_0_0.OnFirstFlush(arg_4_0)
	assert(pg.activity_event_picturepuzzle[arg_4_0.activity.id], "Can't Find activity_event_picturepuzzle 's ID : " .. arg_4_0.activity.id)

	arg_4_0.puzzleConfig = pg.activity_event_picturepuzzle[arg_4_0.activity.id]
	arg_4_0.keyList = Clone(pg.activity_event_picturepuzzle[arg_4_0.activity.id].pickup_picturepuzzle)

	table.insertto(arg_4_0.keyList, pg.activity_event_picturepuzzle[arg_4_0.activity.id].drop_picturepuzzle)
	assert(#arg_4_0.keyList == #arg_4_0.items, string.format("keyList has {0}, but items has {1}", #arg_4_0.keyList, #arg_4_0.items))
	table.sort(arg_4_0.keyList)
	onButton(arg_4_0, arg_4_0.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.SuperBulin2_help.tip
		})

		return
	end, SFX_PANEL)

	local var_4_0 = arg_4_0.activity.id

	onButton(arg_4_0, arg_4_0.btnBattle, function()
		if #arg_4_0.activity.data2_list < #arg_4_0.keyList then
			pg.TipsMgr.GetInstance():ShowTips(i18n("caibulin_lock_tip"))

			return
		end

		;({
			warnMsg = "bulin_tip_other3"
		}).stageId = arg_4_0.puzzleConfig.chapter

		arg_4_0:emit(ActivityMediator.ON_SIMULATION_COMBAT, {
			warnMsg = "bulin_tip_other3"
		}, function()
			if not pg.NewStoryMgr.GetInstance():IsPlayed(tostring(var_0), true) then
				pg.m02:sendNotification(GAME.STORY_UPDATE, {
					storyId = tostring(var_0)
				})
			end

			local var_7_0 = getProxy(ActivityProxy)
			local var_7_1 = var_7_0:getActivityById(var_4_0)

			if var_7_1.data1 == 1 then
				return
			end

			var_7_1.data3 = 1

			var_7_0:updateActivity(var_7_1)

			return
		end)

		return
	end, SFX_PANEL)

	local var_4_1 = arg_4_0.activity:getConfig("config_client").guideName

	arg_4_0:AddFunc(function(arg_8_0)
		pg.NewStoryMgr.GetInstance():Play(var_4_1[1], arg_8_0)

		return
	end)

	return
end

function var_0_0.OnUpdateFlush(arg_9_0)
	local var_9_1 = #arg_9_0.activity.data2_list == #arg_9_0.keyList
	local var_9_2 = arg_9_0.activity.data2_list

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.items) do
		local var_9_3 = arg_9_0.keyList[iter_9_0]
		local var_9_4 = table.contains(var_9_2, arg_9_0.keyList[iter_9_0]) and 3 or table.contains(arg_9_0.activity.data3_list, arg_9_0.keyList[iter_9_0]) and 2 or 1

		onButton(arg_9_0, iter_9_1, function()
			if var_9_4 >= 3 then
				return
			end

			if var_9_4 == 2 then
				arg_9_0.selectIndex = iter_9_0

				arg_9_0:UpdateSelection()

				return
			elseif var_9_4 == 1 then
				if pg.TimeMgr.GetInstance():GetServerTime() < arg_9_0.activity.data2 then
					pg.TipsMgr.GetInstance():ShowTips(i18n("bulin_tip_other2"))

					return
				end

				pg.MsgboxMgr.GetInstance():ShowMsgBox({
					content = i18n("bulin_tip_other1"),
					onYes = function()
						pg.m02:sendNotification(GAME.PUZZLE_PIECE_OP, {
							cmd = 3,
							actId = arg_9_0.activity.id,
							id = var_9_3
						})

						arg_9_0.selectIndex = iter_9_0

						return
					end
				})
			end

			return
		end)
		setActive(iter_9_1:Find("Character"), var_9_4 == 3)
		setActive(iter_9_1:Find("Unlock"), var_9_4 == 2)
		setActive(iter_9_1:Find("Locked"), var_9_4 == 1)
	end

	SetActive(arg_9_0.battle_btn, not var_9_1)
	SetActive(arg_9_0.btnBattle, var_9_1)
	arg_9_0:UpdateSelection()

	if #table.mergeArray(arg_9_0.activity.data1_list, arg_9_0.activity.data2_list, true) >= #pg.activity_event_picturepuzzle[arg_9_0.activity.id].pickup_picturepuzzle + #pg.activity_event_picturepuzzle[arg_9_0.activity.id].drop_picturepuzzle then
		local var_9_5 = arg_9_0.activity:getConfig("config_client").comStory

		arg_9_0:AddFunc(function(arg_12_0)
			pg.NewStoryMgr.GetInstance():Play(var_9_5, arg_12_0)

			return
		end)
	end

	return
end

function var_0_0.UpdateSelection(arg_13_0)
	local var_13_0 = table.contains(arg_13_0.activity.data3_list, arg_13_0.keyList[arg_13_0.selectIndex]) and i18n("SuperBulin2_tip" .. arg_13_0.selectIndex) or ""

	setText(arg_13_0.tip, var_13_0)
	arg_13_0:CreateCDTimer()

	return
end

return var_0_0
