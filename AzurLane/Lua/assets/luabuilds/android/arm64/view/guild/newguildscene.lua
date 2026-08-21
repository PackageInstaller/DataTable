local var_0_0 = class("NewGuildScene", import("..base.BaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "NewGuildUI"
end

function var_0_0.ResUISettings(arg_2_0)
	return true
end

function var_0_0.setPlayer(arg_3_0, arg_3_1)
	arg_3_0.playerVO = arg_3_1

	return
end

function var_0_0.init(arg_4_0)
	arg_4_0.createPanel = arg_4_0._tf:Find("create_panel")
	arg_4_0.factionPanel = arg_4_0._tf:Find("faction_panel")
	arg_4_0.createBtn = arg_4_0._tf:Find("create_panel/frame/create_btn")
	arg_4_0.joinBtn = arg_4_0._tf:Find("create_panel/frame/join_btn")
	arg_4_0.topPanel = arg_4_0._tf:Find("blur_panel/adapt/top")
	arg_4_0.publicGuildBtn = arg_4_0._tf:Find("create_panel/frame/public_btn")
	arg_4_0.backBtn = arg_4_0.topPanel:Find("back")

	setActive(arg_4_0.factionPanel, false)

	arg_4_0.mask = arg_4_0._tf:Find("mask")

	SetActive(arg_4_0.mask, false)

	arg_4_0.mainRedPage = NewGuildMainRedPage.New(arg_4_0._tf, arg_4_0.event)
	arg_4_0.mainBluePage = NewGuildMainBluePage.New(arg_4_0._tf, arg_4_0.event)

	return
end

function var_0_0.didEnter(arg_5_0)
	arg_5_0:startCreate()
	onButton(arg_5_0, arg_5_0.createBtn, function()
		arg_5_0:createGuild()

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.joinBtn, function()
		arg_5_0:emit(NewGuildMediator.OPEN_GUILD_LIST)

		return
	end, SFX_PANEL)
	onButton(arg_5_0, arg_5_0.createPanel, function()
		arg_5_0:emit(var_0_0.ON_BACK)

		return
	end, SOUND_BACK)
	onButton(arg_5_0, arg_5_0.publicGuildBtn, function()
		arg_5_0:emit(NewGuildMediator.OPEN_PUBLIC_GUILD)

		return
	end, SOUND_BACK)
	onButton(arg_5_0, arg_5_0.backBtn, function()
		if go(arg_5_0.createPanel).activeSelf then
			arg_5_0:emit(var_0_0.ON_BACK)
		end

		return
	end, SFX_CANCEL)

	return
end

function var_0_0.startCreate(arg_11_0)
	setActive(arg_11_0.createPanel, true)

	return
end

function var_0_0.createGuild(arg_12_0)
	setActive(arg_12_0.createPanel, false)
	setActive(arg_12_0.factionPanel, false)

	arg_12_0.createProcess = coroutine.wrap(function()
		setActive(arg_12_0.createPanel, false)

		local var_13_0 = Guild.New({})

		arg_12_0:selectFaction(var_13_0, arg_12_0.createProcess)
		coroutine.yield()
		arg_12_0:setDescInfo(var_13_0)

		return
	end)

	arg_12_0.createProcess()

	return
end

function var_0_0.selectFaction(arg_14_0, arg_14_1, arg_14_2)
	local function var_14_0(arg_15_0, arg_15_1)
		arg_14_0.isPlaying = true

		local var_15_0 = arg_15_0:Find("bg")

		setActive(var_15_0, true)

		local var_15_1 = var_15_0:GetComponent("CanvasGroup")

		LeanTween.value(go(var_15_0), 1, 3, 0.5):setOnUpdate(System.Action_float(function(arg_16_0)
			var_15_0.localScale = Vector3(arg_16_0, arg_16_0, 1)
			var_15_1.alpha = 1 - arg_16_0 / 3

			return
		end)):setOnComplete(System.Action(function()
			setActive(var_15_0, false)

			var_15_0.localScale = Vector3(1, 1, 1)
			arg_14_0.isPlaying = false

			arg_15_1()

			return
		end))

		return
	end

	setActive(arg_14_0.factionPanel, true)

	local var_14_1 = arg_14_0.factionPanel:Find("panel")
	local var_14_2 = var_14_1:Find("blhx")
	local var_14_3 = var_14_1:Find("cszz")

	if not arg_14_0.isInitFaction then
		setImageSprite(var_14_1:Find("bg"), GetSpriteFromAtlas("commonbg/camp_bg", ""))
		setImageSprite(var_14_2:Find("bg"), GetSpriteFromAtlas("clutter/blhx_icon", ""))
		setImageSprite(var_14_3:Find("bg"), GetSpriteFromAtlas("clutter/cszz_icon", ""))
		setActive(var_14_2:Find("bg"), false)
		setActive(var_14_3:Find("bg"), false)

		arg_14_0.isInitFaction = true
	end

	onButton(arg_14_0, var_14_2, function()
		if arg_14_0.isPlaying then
			return
		end

		arg_14_1:setFaction(GuildConst.FACTION_TYPE_BLHX)

		if arg_14_2 then
			arg_14_2()
		else
			return
		end

		var_14_0(var_14_2, function()
			arg_14_2 = nil

			return
		end)

		return
	end, SFX_PANEL)
	onButton(arg_14_0, var_14_3, function()
		if arg_14_0.isPlaying then
			return
		end

		arg_14_1:setFaction(GuildConst.FACTION_TYPE_CSZZ)

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
	end)
	onButton(arg_14_0, arg_14_0.backBtn, function()
		if arg_14_0.isPlaying then
			return
		end

		arg_14_0.createProcess = nil

		setActive(arg_14_0.createPanel, true)
		setActive(arg_14_0.factionPanel, false)
		onButton(arg_14_0, arg_14_0.backBtn, function()
			arg_14_0:emit(var_0_0.ON_BACK)

			return
		end, SFX_CANCEL)

		return
	end, SFX_CANCEL)
	setActive(arg_14_0.topPanel, true)

	return
end

function var_0_0.setDescInfo(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1:getFaction()

	if var_24_0 == GuildConst.FACTION_TYPE_BLHX then
		arg_24_0.mainPage = arg_24_0.mainBluePage
	elseif var_24_0 == GuildConst.FACTION_TYPE_CSZZ then
		arg_24_0.mainPage = arg_24_0.mainRedPage
	end

	local function var_24_1()
		if not arg_24_0.mainPage:GetLoaded() or arg_24_0.mainPage:IsPlaying() then
			return
		end

		arg_24_0.createProcess = nil

		arg_24_0:createGuild()
		arg_24_0.mainPage:Hide()

		return
	end

	arg_24_0.mainPage:ExecuteAction("Show", arg_24_1, arg_24_0.playerVO, function()
		setActive(arg_24_0.factionPanel, false)

		return
	end, function()
		if not arg_24_0.mainPage:GetLoaded() or arg_24_0.mainPage:IsPlaying() then
			return
		end

		arg_24_0.createProcess = nil

		arg_24_0:createGuild()
		arg_24_0.mainPage:Hide()

		return
	end)
	onButton(arg_24_0, arg_24_0.backBtn, var_24_1, SFX_CANCEL)

	return
end

function var_0_0.ClosePage(arg_27_0)
	if arg_27_0.page and arg_27_0.page:GetLoaded() and arg_27_0.page:isShowing() then
		arg_27_0.page:Hide()
	end

	return
end

function var_0_0.onBackPressed(arg_28_0)
	if arg_28_0.createProcess ~= nil then
		triggerButton(arg_28_0.backBtn)
	else
		triggerButton(arg_28_0.createPanel)
	end

	return
end

function var_0_0.willExit(arg_29_0)
	arg_29_0.mainRedPage:Destroy()
	arg_29_0.mainBluePage:Destroy()

	return
end

return var_0_0
