local NewGuildScene = class("NewGuildScene", import("..base.BaseUI"))

function NewGuildScene:getUIName()
	return "NewGuildUI"
end

function NewGuildScene:ResUISettings()
	return true
end

function NewGuildScene:setPlayer(arg_3_1)
	self.playerVO = arg_3_1

	return
end

function NewGuildScene:init()
	self.createPanel = self._tf:Find("create_panel")
	self.factionPanel = self._tf:Find("faction_panel")
	self.createBtn = self._tf:Find("create_panel/frame/create_btn")
	self.joinBtn = self._tf:Find("create_panel/frame/join_btn")
	self.topPanel = self._tf:Find("blur_panel/adapt/top")
	self.publicGuildBtn = self._tf:Find("create_panel/frame/public_btn")
	self.backBtn = self.topPanel:Find("back")

	setActive(self.factionPanel, false)

	self.mask = self._tf:Find("mask")

	SetActive(self.mask, false)

	self.mainRedPage = NewGuildMainRedPage.New(self._tf, self.event)
	self.mainBluePage = NewGuildMainBluePage.New(self._tf, self.event)

	return
end

function NewGuildScene:didEnter()
	self:startCreate()
	onButton(self, self.createBtn, function()
		self:createGuild()

		return
	end, SFX_PANEL)
	onButton(self, self.joinBtn, function()
		self:emit(NewGuildMediator.OPEN_GUILD_LIST)

		return
	end, SFX_PANEL)
	onButton(self, self.createPanel, function()
		self:emit(NewGuildScene.ON_BACK)

		return
	end, SOUND_BACK)
	onButton(self, self.publicGuildBtn, function()
		self:emit(NewGuildMediator.OPEN_PUBLIC_GUILD)

		return
	end, SOUND_BACK)
	onButton(self, self.backBtn, function()
		if go(self.createPanel).activeSelf then
			self:emit(NewGuildScene.ON_BACK)
		end

		return
	end, SFX_CANCEL)

	return
end

function NewGuildScene:startCreate()
	setActive(self.createPanel, true)

	return
end

function NewGuildScene:createGuild()
	setActive(self.createPanel, false)
	setActive(self.factionPanel, false)

	self.createProcess = coroutine.wrap(function()
		setActive(self.createPanel, false)

		local var_13_0 = Guild.New({})

		self:selectFaction(var_13_0, self.createProcess)
		coroutine.yield()
		self:setDescInfo(var_13_0)

		return
	end)

	self.createProcess()

	return
end

function NewGuildScene:selectFaction(arg_14_1, arg_14_2)
	local function var_14_0(arg_15_0, arg_15_1)
		self.isPlaying = true

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
			self.isPlaying = false

			arg_15_1()

			return
		end))

		return
	end

	setActive(self.factionPanel, true)

	local var_14_1 = self.factionPanel:Find("panel")
	local var_14_2 = var_14_1:Find("blhx")
	local var_14_3 = var_14_1:Find("cszz")

	if not self.isInitFaction then
		setImageSprite(var_14_1:Find("bg"), GetSpriteFromAtlas("commonbg/camp_bg", ""))
		setImageSprite(var_14_2:Find("bg"), GetSpriteFromAtlas("clutter/blhx_icon", ""))
		setImageSprite(var_14_3:Find("bg"), GetSpriteFromAtlas("clutter/cszz_icon", ""))
		setActive(var_14_2:Find("bg"), false)
		setActive(var_14_3:Find("bg"), false)

		self.isInitFaction = true
	end

	onButton(self, var_14_2, function()
		if self.isPlaying then
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
	onButton(self, var_14_3, function()
		if self.isPlaying then
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
	onButton(self, self.backBtn, function()
		if self.isPlaying then
			return
		end

		self.createProcess = nil

		setActive(self.createPanel, true)
		setActive(self.factionPanel, false)
		onButton(self, self.backBtn, function()
			self:emit(NewGuildScene.ON_BACK)

			return
		end, SFX_CANCEL)

		return
	end, SFX_CANCEL)
	setActive(self.topPanel, true)

	return
end

function NewGuildScene:setDescInfo(arg_24_1)
	local var_24_0 = arg_24_1:getFaction()

	if var_24_0 == GuildConst.FACTION_TYPE_BLHX then
		self.mainPage = self.mainBluePage
	elseif var_24_0 == GuildConst.FACTION_TYPE_CSZZ then
		self.mainPage = self.mainRedPage
	end

	local function var_24_1()
		if not self.mainPage:GetLoaded() or self.mainPage:IsPlaying() then
			return
		end

		self.createProcess = nil

		self:createGuild()
		self.mainPage:Hide()

		return
	end

	self.mainPage:ExecuteAction("Show", arg_24_1, self.playerVO, function()
		setActive(self.factionPanel, false)

		return
	end, var_24_1)
	onButton(self, self.backBtn, var_24_1, SFX_CANCEL)

	return
end

function NewGuildScene:ClosePage()
	if self.page and self.page:GetLoaded() and self.page:isShowing() then
		self.page:Hide()
	end

	return
end

function NewGuildScene:onBackPressed()
	if self.createProcess ~= nil then
		triggerButton(self.backBtn)
	else
		triggerButton(self.createPanel)
	end

	return
end

function NewGuildScene:willExit()
	self.mainRedPage:Destroy()
	self.mainBluePage:Destroy()

	return
end

return NewGuildScene
