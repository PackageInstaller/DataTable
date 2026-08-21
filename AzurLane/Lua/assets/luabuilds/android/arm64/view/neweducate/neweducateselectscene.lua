local var_0_0 = class("NewEducateSelectScene", import("view.base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "NewEducateSelectUI"
end

function var_0_0.preload(arg_2_0, arg_2_1)
	pg.PerformMgr.GetInstance():CheckLoad(function()
		arg_2_1()

		return
	end)

	return
end

function var_0_0.init(arg_4_0)
	arg_4_0.rootTF = arg_4_0._tf:Find("root")
	arg_4_0.bgTF = arg_4_0.rootTF:Find("bg")
	arg_4_0.sureBtn = arg_4_0.rootTF:Find("window/sure_btn")

	setText(arg_4_0.sureBtn:Find("Text"), i18n("child2_enter"))

	arg_4_0.hardSureBtn = arg_4_0.rootTF:Find("window/hard_sure_btn")

	setText(arg_4_0.hardSureBtn:Find("Text"), i18n("child2_hard_enter"))

	local var_4_0 = arg_4_0.rootTF:Find("window/info")

	arg_4_0.hardTF = var_4_0:Find("hard")

	setText(arg_4_0.hardTF:Find("Text"), i18n("child2_hard"))

	arg_4_0.hardToggle = var_4_0:Find("hard/toggle")
	arg_4_0.nameTF = var_4_0:Find("name")
	arg_4_0.progressTF = var_4_0:Find("progress")
	arg_4_0.gameTF = var_4_0:Find("game")
	arg_4_0.topTF = arg_4_0.rootTF:Find("top")
	arg_4_0.contentTF = arg_4_0.rootTF:Find("window/view/content")

	return
end

function var_0_0.InitData(arg_5_0)
	arg_5_0.infos = {}
	arg_5_0.infos[0] = getProxy(EducateProxy):GetSelectInfo()

	local var_5_0 = getProxy(NewEducateProxy)

	for iter_5_0, iter_5_1 in ipairs(pg.child2_data.all) do
		arg_5_0.infos[iter_5_1] = var_5_0:GetChar(iter_5_1):GetSelectInfo()
	end

	arg_5_0.playerID = getProxy(PlayerProxy):getRawData().id

	if NewEducateHelper.IsShowNewChildTip() then
		arg_5_0.newId = pg.child2_data.all[#pg.child2_data.all]

		NewEducateHelper.ClearShowNewChildTip()
	end

	return
end

function var_0_0.didEnter(arg_6_0)
	onButton(arg_6_0, arg_6_0.topTF:Find("return_btn"), function()
		arg_6_0:onBackPressed()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.topTF:Find("btns/collect"), function()
		arg_6_0:emit(NewEducateSelectMediator.GO_SUBLAYER, Context.New({
			mediator = NewEducateCollectEntranceMediator,
			viewComponent = NewEducateCollectEntranceLayer,
			data = {
				isSelect = true,
				id = arg_6_0.selectedId
			}
		}))

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.sureBtn, function()
		arg_6_0:EnterEasyMode()

		return
	end, SFX_PANEL)
	onButton(arg_6_0, arg_6_0.hardSureBtn, function()
		arg_6_0:EnterHardMode()

		return
	end, SFX_PANEL)
	eachChild(arg_6_0.contentTF, function(arg_11_0)
		onToggle(arg_6_0, arg_11_0, function(arg_12_0)
			local var_12_0 = tonumber(arg_11_0.name)

			if arg_12_0 then
				PlayerPrefs.SetInt(arg_6_0:GetSelectedLocalKey(), var_12_0)

				arg_6_0.selectedId = var_12_0

				arg_6_0:UpdataInfo()
				arg_11_0:SetAsLastSibling()
			end

			return
		end, SFX_PANEL)

		return
	end)
	onToggle(arg_6_0, arg_6_0.hardToggle, function(arg_13_0)
		quickPlayAnimation(arg_6_0._tf:Find("root/window"), arg_13_0 and "anim_educate_select_chage" or "anim_educate_select_chage2")
		setActive(arg_6_0.hardSureBtn, arg_13_0)
		setActive(arg_6_0.sureBtn, not arg_13_0)

		local var_13_0 = arg_13_0 and i18n("child2_hard") or ""

		setText(arg_6_0.gameTF, var_13_0 .. i18n("child2_game_cnt", arg_6_0.infos[arg_6_0.selectedId].gameCnt))

		return
	end, SFX_PANEL)
	arg_6_0:InitData()

	local var_6_0 = arg_6_0.newId

	if not arg_6_0.newId then
		var_6_0 = PlayerPrefs.GetInt(arg_6_0:GetSelectedLocalKey())
		var_6_0 = var_6_0 or 0
	end

	triggerToggle(arg_6_0.contentTF:Find(tostring(var_6_0)), true)

	return
end

function var_0_0.GetSelectedLocalKey(arg_14_0)
	return NewEducateConst.NEW_EDUCATE_SELECT_ID .. "_" .. arg_14_0.playerID
end

function var_0_0.UpdataInfo(arg_15_0)
	local var_15_0 = arg_15_0.infos[arg_15_0.selectedId]

	setText(arg_15_0.nameTF, arg_15_0.infos[arg_15_0.selectedId].name)
	setText(arg_15_0.progressTF, var_15_0.progressStr)
	setImageSprite(arg_15_0.bgTF, LoadSprite("bg/" .. var_15_0.bg), false)

	local var_15_1 = arg_15_0.selectedId > 1 and var_15_0.gameCnt > 1

	setActive(arg_15_0.hardTF, arg_15_0.selectedId > 1 and var_15_0.gameCnt > 1)
	triggerToggle(arg_15_0.hardToggle, var_15_1 and var_15_0.isHard)
	arg_15_0:CheckGuide(var_15_1)

	return
end

function var_0_0.EnterEasyMode(arg_16_0)
	if arg_16_0.selectedId == 0 then
		arg_16_0:EnterScene()

		return
	end

	local var_16_0 = {}

	if arg_16_0.infos[arg_16_0.selectedId].isHard then
		table.insert(var_16_0, function(arg_17_0)
			pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX, {
				contentText = i18n("child2_switch_sure"),
				onConfirm = arg_17_0
			})

			return
		end)
		table.insert(var_16_0, function(arg_18_0)
			arg_16_0:emit(NewEducateSelectMediator.SWITCH_DIFFICULTY, {
				id = arg_16_0.selectedId,
				difficulty = NewEducateChar.DIFFICULTY.EASY,
				callback = arg_18_0
			})

			return
		end)
	end

	seriesAsync(var_16_0, function()
		arg_16_0:EnterScene()

		return
	end)

	return
end

function var_0_0.EnterHardMode(arg_20_0)
	if arg_20_0.selectedId == 0 then
		return
	end

	local var_20_0 = {}

	if not arg_20_0.infos[arg_20_0.selectedId].isHard then
		table.insert(var_20_0, function(arg_21_0)
			pg.NewStyleMsgboxMgr.GetInstance():Show(pg.NewStyleMsgboxMgr.TYPE_COMMON_MSGBOX, {
				contentText = i18n("child2_switch_sure"),
				onConfirm = arg_21_0
			})

			return
		end)
		table.insert(var_20_0, function(arg_22_0)
			arg_20_0:emit(NewEducateSelectMediator.SWITCH_DIFFICULTY, {
				id = arg_20_0.selectedId,
				difficulty = NewEducateChar.DIFFICULTY.HARD,
				callback = arg_22_0
			})

			return
		end)
	end

	seriesAsync(var_20_0, function()
		arg_20_0:EnterScene()

		return
	end)

	return
end

function var_0_0.EnterScene(arg_24_0)
	if arg_24_0.selectedId == 0 then
		arg_24_0:emit(NewEducateSelectMediator.GO_SCENE, SCENE.EDUCATE, {
			isMainEnter = true
		})
	else
		arg_24_0:emit(NewEducateSelectMediator.GO_SCENE, SCENE.NEW_EDUCATE, {
			isMainEnter = true,
			id = arg_24_0.selectedId
		})
	end

	return
end

function var_0_0.CheckGuide(arg_25_0, arg_25_1)
	if arg_25_1 then
		if not pg.NewStoryMgr.GetInstance():IsPlayed("tb2_19") then
			pg.m02:sendNotification(GAME.STORY_UPDATE, {
				storyId = "tb2_19"
			})
			pg.NewGuideMgr.GetInstance():Play("tb2_19", {
				arg_25_0.selectedId
			})
		end
	end

	return
end

function var_0_0.onBackPressed(arg_26_0)
	if arg_26_0.contextData.isTb1 then
		arg_26_0:emit(NewEducateBaseUI.ON_HOME)
	else
		var_0_0.super.onBackPressed(arg_26_0)
	end

	return
end

return var_0_0
