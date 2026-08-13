class = var_0_10000

local var_0_0 = "NewGuildScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "NewGuildUI"
end

function var_0_1.ResUISettings(arg_2_0)
	return true
end

function var_0_1.setPlayer(arg_3_0, arg_3_1)
	arg_3_0.playerVO = arg_3_1

	return
end

function var_0_1.init(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.createPanel = var_1.Find(var_4_0, "create_panel")

	local var_4_1 = arg_4_0._tf

	arg_4_0.factionPanel = var_1.Find(var_4_1, "faction_panel")

	local var_4_2 = arg_4_0._tf

	arg_4_0.createBtn = var_1.Find(var_4_2, "create_panel/frame/create_btn")

	local var_4_3 = arg_4_0._tf

	arg_4_0.joinBtn = var_1.Find(var_4_3, "create_panel/frame/join_btn")

	local var_4_4 = arg_4_0._tf

	arg_4_0.topPanel = var_1.Find(var_4_4, "blur_panel/adapt/top")

	local var_4_5 = arg_4_0._tf

	arg_4_0.publicGuildBtn = var_1.Find(var_4_5, "create_panel/frame/public_btn")

	local var_4_6 = arg_4_0.topPanel

	arg_4_0.backBtn = var_1.Find(var_4_6, "back")
	setActive = var_1

	var_1(arg_4_0.factionPanel, false)

	local var_4_7 = arg_4_0._tf

	arg_4_0.mask = var_1.Find(var_4_7, "mask")
	SetActive = var_1

	var_1(arg_4_0.mask, false)

	NewGuildMainRedPage = var_1
	arg_4_0.mainRedPage = var_1.New(arg_4_0._tf, arg_4_0.event)
	NewGuildMainBluePage = var_1
	arg_4_0.mainBluePage = var_1.New(arg_4_0._tf, arg_4_0.event)

	return
end

function var_0_1.didEnter(arg_5_0)
	arg_5_0:startCreate()

	onButton = var_1

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.createBtn

	local function var_5_2()
		local var_6_0 = arg_5_0

		var_0.createGuild(var_6_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_5_0, var_5_1, var_5_2, var_1_10006)

	onButton = var_1

	local var_5_3 = arg_5_0
	local var_5_4 = arg_5_0.joinBtn

	local function var_5_5()
		local var_7_0 = arg_5_0
		local var_7_1 = var_0.emit

		NewGuildMediator = var_2_10003

		var_7_1(var_7_0, var_2_10003.OPEN_GUILD_LIST)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_5_3, var_5_4, var_5_5, var_1_10006)

	onButton = var_1

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.createPanel

	local function var_5_8()
		local var_8_0 = arg_5_0

		var_0.emit(var_8_0, var_0_1.ON_BACK)

		return
	end

	SOUND_BACK = var_1_10006

	var_1(var_5_6, var_5_7, var_5_8, var_1_10006)

	onButton = var_1

	local var_5_9 = arg_5_0
	local var_5_10 = arg_5_0.publicGuildBtn

	local function var_5_11()
		local var_9_0 = arg_5_0
		local var_9_1 = var_0.emit

		NewGuildMediator = var_2_10003

		var_9_1(var_9_0, var_2_10003.OPEN_PUBLIC_GUILD)

		return
	end

	SOUND_BACK = var_1_10006

	var_1(var_5_9, var_5_10, var_5_11, var_1_10006)

	onButton = var_1

	local var_5_12 = arg_5_0
	local var_5_13 = arg_5_0.backBtn

	local function var_5_14()
		go = var_2_10000

		if var_2_10000(arg_5_0.createPanel).activeSelf then
			local var_10_0 = arg_5_0

			var_0.emit(var_10_0, var_0_1.ON_BACK)
		end

		return
	end

	SFX_CANCEL = var_1_10006

	var_1(var_5_12, var_5_13, var_5_14, var_1_10006)

	return
end

function var_0_1.startCreate(arg_11_0)
	setActive = var_1_10001

	var_1_10001(arg_11_0.createPanel, true)

	return
end

function var_0_1.createGuild(arg_12_0)
	setActive = var_1_10001

	var_1_10001(arg_12_0.createPanel, false)

	setActive = var_1_10001

	var_1_10001(arg_12_0.factionPanel, false)

	coroutine = var_1_10001
	arg_12_0.createProcess = var_1_10001.wrap(function()
		setActive = var_2_10000

		var_2_10000(arg_12_0.createPanel, false)

		Guild = var_2_10000

		local var_13_0 = var_2_10000.New({})
		local var_13_1 = arg_12_0

		var_1.selectFaction(var_13_1, var_13_0, arg_12_0.createProcess)

		coroutine = var_1

		var_1.yield()

		local var_13_2 = arg_12_0

		var_1.setDescInfo(var_13_2, var_13_0)

		return
	end)

	arg_12_0.createProcess()

	return
end

function var_0_1.selectFaction(arg_14_0, arg_14_1, arg_14_2)
	local function var_14_0(arg_15_0, arg_15_1)
		arg_14_0.isPlaying = true

		local var_15_0 = arg_15_0
		local var_15_1 = arg_15_0.Find(var_15_0, "bg")

		setActive = var_3

		var_3(var_15_1, true)

		local var_15_2 = var_15_1:GetComponent("CanvasGroup")

		LeanTween = var_15_0

		local var_15_3 = var_15_0.value

		go = var_6

		local var_15_4 = var_15_3(var_6(var_15_1), 1, 3, 0.5)
		local var_15_5 = var_4.setOnUpdate

		System = var_7

		local var_15_6 = var_15_5(var_15_4, var_7.Action_float(function(arg_16_0)
			local var_16_0 = var_15_1

			Vector3 = var_3_10002
			var_16_0.localScale = var_3_10002(arg_16_0, arg_16_0, 1)
			var_15_2.alpha = 1 - arg_16_0 / 3

			return
		end))
		local var_15_7 = var_4.setOnComplete

		System = var_7

		var_15_7(var_15_6, var_7.Action(function()
			setActive = var_3_10000

			var_3_10000(var_15_1, false)

			local var_17_0 = var_15_1

			Vector3 = var_3_10001
			var_17_0.localScale = var_3_10001(1, 1, 1)
			arg_14_0.isPlaying = false

			arg_15_1()

			return
		end))

		return
	end

	setActive = var_1_10004

	var_1_10004(arg_14_0.factionPanel, true)

	local var_14_1 = arg_14_0.factionPanel
	local var_14_2 = var_4.Find(var_14_1, "panel")
	local var_14_3 = var_5.Find(var_14_2, "blhx")
	local var_14_4 = var_5:Find("cszz")
	local var_14_5 = var_5:Find("bg")

	if not arg_14_0.isInitFaction then
		setImageSprite = var_9

		local var_14_6 = var_14_5

		GetSpriteFromAtlas = var_1_10012

		var_9(var_14_6, var_1_10012("commonbg/camp_bg", ""))

		setImageSprite = var_9

		local var_14_7 = var_14_3:Find("bg")

		GetSpriteFromAtlas = var_12

		var_9(var_14_7, var_12("clutter/blhx_icon", ""))

		setImageSprite = var_9

		local var_14_8 = var_14_4:Find("bg")

		GetSpriteFromAtlas = var_12

		var_9(var_14_8, var_12("clutter/cszz_icon", ""))

		setActive = var_9

		var_9(var_14_3:Find("bg"), false)

		setActive = var_9

		var_9(var_14_4:Find("bg"), false)

		arg_14_0.isInitFaction = true
	end

	onButton = var_9

	local var_14_9 = arg_14_0
	local var_14_10 = var_14_3

	local function var_14_11()
		if arg_14_0.isPlaying then
			return
		end

		local var_18_0 = arg_14_1
		local var_18_1 = var_0.setFaction

		GuildConst = var_2_10003

		var_18_1(var_18_0, var_2_10003.FACTION_TYPE_BLHX)

		if arg_14_2 then
			arg_14_2()
		else
			return
		end

		var_14_0(var_14_3, function()
			arg_14_2 = nil

			return
		end)

		return
	end

	SFX_PANEL = var_1_10014

	var_9(var_14_9, var_14_10, var_14_11, var_1_10014)

	onButton = var_9

	var_9(arg_14_0, var_14_4, function()
		if arg_14_0.isPlaying then
			return
		end

		local var_20_0 = arg_14_1
		local var_20_1 = var_0.setFaction

		GuildConst = var_2_10003

		var_20_1(var_20_0, var_2_10003.FACTION_TYPE_CSZZ)

		if arg_14_2 then
			arg_14_2()
		else
			return
		end

		var_14_0(var_14_4, function()
			arg_14_2 = nil

			return
		end)

		return
	end)

	onButton = var_9

	local var_14_12 = arg_14_0
	local var_14_13 = arg_14_0.backBtn

	local function var_14_14()
		if arg_14_0.isPlaying then
			return
		end

		local var_22_0 = arg_14_0

		var_22_0.createProcess = nil
		setActive = var_22_0

		var_22_0(arg_14_0.createPanel, true)

		setActive = var_22_0

		var_22_0(arg_14_0.factionPanel, false)

		onButton = var_22_0

		local var_22_1 = arg_14_0
		local var_22_2 = arg_14_0.backBtn

		local function var_22_3()
			local var_23_0 = arg_14_0

			var_0.emit(var_23_0, var_0_1.ON_BACK)

			return
		end

		SFX_CANCEL = var_2_10005

		var_22_0(var_22_1, var_22_2, var_22_3, var_2_10005)

		return
	end

	SFX_CANCEL = var_1_10014

	var_9(var_14_12, var_14_13, var_14_14, var_1_10014)

	setActive = var_9

	var_9(arg_14_0.topPanel, true)

	return
end

function var_0_1.setDescInfo(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1:getFaction()

	GuildConst = var_1_10003

	if var_24_0 == var_1_10003.FACTION_TYPE_BLHX then
		arg_24_0.mainPage = arg_24_0.mainBluePage
	else
		GuildConst = var_3

		if var_24_0 == var_3.FACTION_TYPE_CSZZ then
			arg_24_0.mainPage = arg_24_0.mainRedPage
		end
	end

	local function var_24_1()
		local var_25_0 = arg_24_0.mainPage

		if var_0.GetLoaded(var_25_0) then
			local var_25_1 = arg_24_0.mainPage

			if var_0.IsPlaying(var_25_1) then
				return
			end

			arg_24_0.createProcess = nil

			local var_25_2 = arg_24_0

			var_0.createGuild(var_25_2)

			local var_25_3 = arg_24_0.mainPage

			var_0.Hide(var_25_3)

			return
		end
	end

	local var_24_2 = arg_24_0.mainPage

	var_4.ExecuteAction(var_24_2, "Show", arg_24_1, arg_24_0.playerVO, function()
		setActive = var_2_10000

		var_2_10000(arg_24_0.factionPanel, false)

		return
	end, var_24_1)

	onButton = var_4

	local var_24_3 = arg_24_0
	local var_24_4 = arg_24_0.backBtn
	local var_24_5 = var_24_1

	SFX_CANCEL = var_9

	var_4(var_24_3, var_24_4, var_24_5, var_9)

	return
end

function var_0_1.ClosePage(arg_27_0)
	if arg_27_0.page then
		local var_27_0 = arg_27_0.page

		if var_1.GetLoaded(var_27_0) then
			local var_27_1 = arg_27_0.page

			if var_1.isShowing(var_27_1) then
				local var_27_2 = arg_27_0.page

				var_1.Hide(var_27_2)
			end
		end
	end

	return
end

function var_0_1.onBackPressed(arg_28_0)
	if arg_28_0.createProcess ~= nil then
		triggerButton = var_1

		var_1(arg_28_0.backBtn)
	else
		triggerButton = var_1

		var_1(arg_28_0.createPanel)
	end

	return
end

function var_0_1.willExit(arg_29_0)
	local var_29_0 = arg_29_0.mainRedPage

	var_1.Destroy(var_29_0)

	local var_29_1 = arg_29_0.mainBluePage

	var_1.Destroy(var_29_1)

	return
end

return var_0_1
