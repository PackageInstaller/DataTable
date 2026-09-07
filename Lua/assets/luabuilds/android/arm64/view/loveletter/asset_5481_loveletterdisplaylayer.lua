local LoveLetterDisplayLayer = class("LoveLetterDisplayLayer", import("view.base.BaseUI"))

function LoveLetterDisplayLayer:getUIName()
	return "LoveLetterDisplayUI"
end

function LoveLetterDisplayLayer:preload(arg_2_1)
	pg.PoolMgr.GetInstance():GetPrefab("LoveLetterStyle/" .. self.contextData.prefab, "", true, function(arg_3_0)
		self.rtStyle = arg_3_0.transform

		arg_2_1()

		return
	end)

	return
end

LoveLetterDisplayLayer.optionsPath = {}

function LoveLetterDisplayLayer:SetLoveLetter(arg_4_1)
	self.ll = getProxy(LoveLetterProxy):GetGroupData(arg_4_1)
	self.letterIds = self.ll:GetDisplayLetterList()

	self:ShowLetter(self.contextData.letterId or self.letterIds[1])

	return
end

function LoveLetterDisplayLayer:init()
	setParent(self.rtStyle, self.rtPanel)
	onButton(self, self.rtBg, function()
		self:closeView()

		return
	end, SFX_CANCEL)
	onButton(self, self.rtStyle:Find("before"), function()
		self:emit(LoveLetterDisplayMediator.ON_UNLOCK_LETTER, self.letterId)

		return
	end, SFX_PANEL)
	self:addRingDragListenter()
	self:BlurPanel(self._tf)

	return
end

function LoveLetterDisplayLayer:didEnter()
	setText(self.rtStyle:Find("after/bg/paper_root/name"), self.ll:GetName())

	return
end

function LoveLetterDisplayLayer:ChangeLetter(arg_9_1)
	local var_9_0 = table.indexof(self.letterIds, self.letterId) + arg_9_1

	if var_9_0 ~= math.clamp(var_9_0, 1, #self.letterIds) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("loveactivity_ui_15"))
	else
		self:ShowLetter(self.letterIds[var_9_0])
	end

	return
end

function LoveLetterDisplayLayer:ShowLetter(arg_10_1)
	self.letterId = arg_10_1
	self.contextData.letterId = self.letterId

	setText(self.rtStyle:Find("after/bg/paper_root/content"), getProxy(LoveLetterProxy):GetLoveLetterContent(arg_10_1))

	local var_10_0 = table.indexof(self.letterIds, self.letterId)

	UIItemList.StaticAlign(self.rtPointsContainer, self.rtPointsTpl, #self.letterIds, function(arg_11_0, arg_11_1, arg_11_2)
		arg_11_1 = arg_11_1 + 1

		if arg_11_0 == UIItemList.EventUpdate then
			setActive(arg_11_2:Find("short"), arg_11_1 ~= var_10_0)
			setActive(arg_11_2:Find("long"), arg_11_1 == var_10_0)
			setActive(arg_11_2:Find("short/pick_up"), not self.ll:GetLetterUnlock(self.letterIds[arg_11_1]))
		end

		return
	end)
	self:UpdateLetterDisplay(self.ll:GetLetterUnlock(self.letterId))

	return
end

function LoveLetterDisplayLayer:DoOpenLetter()
	onButton(self, self.rtAnim:Find("click"), function()
		self.clickCall = nil

		existCall(self.clickCall)

		return
	end, SFX_PANEL)

	GetOrAddComponent(self._tf, "EventTriggerListener").enabled = false

	setActive(self.rtPointsContainer, false)
	pg.UIMgr.GetInstance():LoadingOn()

	local var_12_0 = {}

	table.insert(var_12_0, function(arg_14_0)
		local var_14_0 = self.ll:GetDisplayInfo()

		parallelAsync({
			function(arg_15_0)
				pg.PoolMgr.GetInstance():GetPrefab("loveletteranim/loveletteranim", "", true, function(arg_16_0)
					self.rtAnimation = arg_16_0.transform

					arg_15_0()

					return
				end)

				return
			end,
			function(arg_17_0)
				LoadSpriteAtlasAsync("bg/" .. self.contextData.bg, "", function(arg_18_0)
					self.spriteBg = arg_18_0

					arg_17_0()

					return
				end)

				return
			end,
			function(arg_19_0)
				LoadSpriteAtlasAsync("loveletterstyleatlas/mail_" .. self.contextData.prefab, "", function(arg_20_0)
					self.spriteMail = arg_20_0

					arg_19_0()

					return
				end)

				return
			end,
			function(arg_21_0)
				LoadSpriteAtlasAsync("loveletterstyleatlas/" .. var_14_0.hand, "", function(arg_22_0)
					self.spriteHand = arg_22_0

					arg_21_0()

					return
				end)

				return
			end,
			function(arg_23_0)
				LoadSpriteAtlasAsync("loveletterstyleatlas/" .. var_14_0.kiss, "", function(arg_24_0)
					self.spriteKiss = arg_24_0

					arg_23_0()

					return
				end)

				return
			end
		}, function()
			setParent(self.rtAnimation, self.rtAnim:Find("content"))
			setImageSprite(self.rtAnimation:Find("bg_root/bg"), self.spriteBg)
			setImageSprite(self.rtAnimation:Find("fx_letter_in/deco_letter/deco_letter_1"), self.spriteMail)
			setImageSprite(self.rtAnimation:Find("fx_letter_in/deco_letter/lip_01"), self.spriteKiss, true)
			setImageSprite(self.rtAnimation:Find("hand/hand_deco"), self.spriteHand, true)
			self.rtAnimation:GetComponent(typeof(DftAniEvent)):SetEndEvent(function(arg_26_0)
				self.nextCall = nil

				existCall(self.nextCall, arg_26_0)

				return
			end)
			eachChild(self.rtAnimation:Find("letter_style/root"), function(arg_27_0, arg_27_1)
				setActive(arg_27_0, arg_27_0.name == self.contextData.prefab)

				if arg_27_0.name == self.contextData.prefab then
					setText(arg_27_0:Find("after/bg/paper_root/name"), self.ll:GetName())
					setText(arg_27_0:Find("after/bg/paper_root/content"), getProxy(LoveLetterProxy):GetLoveLetterContent(self.contextData.letterId))
				end

				return
			end)
			arg_14_0()

			return
		end)

		return
	end)
	table.insert(var_12_0, function(arg_28_0)
		setPaintingPrefab(self.rtAnimation:Find("painting_root/paint"), self.ll:GetPainting(), "mainNormal", nil, nil, arg_28_0)

		return
	end)
	table.insert(var_12_0, function(arg_29_0)
		pg.UIMgr.GetInstance():LoadingOff()
		setActive(self.rtAnim, true)

		function self.nextCall()
			setActive(self.rtAnim:Find("click"), true)

			return
		end

		self.clickCall = arg_29_0

		setActive(self.rtAnim:Find("click"), false)
		quickPlayAnimation(self.rtAnimation, "anim_LoveLetterDisplayUI_fadein_01")

		return
	end)
	table.insert(var_12_0, function(arg_31_0)
		setActive(self.rtAnim, true)

		function self.nextCall()
			setActive(self.rtAnim:Find("click"), true)

			return
		end

		self.clickCall = arg_31_0

		setActive(self.rtAnim:Find("click"), false)
		quickPlayAnimation(self.rtAnimation, "anim_LoveLetterDisplayUI_fadein_02")

		return
	end)
	table.insert(var_12_0, function(arg_33_0)
		setActive(self.rtAnim, true)

		self.nextCall = arg_33_0

		setActive(self.rtAnim:Find("click"), false)
		quickPlayAnimation(self.rtAnimation, "anim_LoveLetterDisplayUI_fadeout_01")

		return
	end)
	seriesAsync(var_12_0, function()
		setActive(self.rtAnim, false)
		setActive(self.rtPointsContainer, true)
		self:UpdateLetterDisplay(true)

		GetOrAddComponent(self._tf, "EventTriggerListener").enabled = true

		return
	end)

	return
end

function LoveLetterDisplayLayer:UpdateLetterDisplay(arg_35_1)
	setActive(self.rtStyle:Find("after"), arg_35_1)
	setActive(self.rtStyle:Find("before"), not arg_35_1)
	setButtonEnabled(self.rtStyle:Find("before"), not arg_35_1)

	if not arg_35_1 then
		setLoveLetterMedal(self.rtStyle:Find("before/medal"), setmetatable({
			level = table.indexof(pg.lover_letter_content.get_id_list_by_ship_group[self.ll.groupId], self.contextData.letterId)
		}, {
			__index = self.ll
		}))
	end

	return
end

function LoveLetterDisplayLayer:addRingDragListenter()
	local var_36_0 = GetOrAddComponent(self._tf, "EventTriggerListener")
	local var_36_1
	local var_36_2 = 0

	var_36_0:AddBeginDragFunc(function()
		var_36_2 = 0
		var_36_1 = nil

		return
	end)
	var_36_0:AddDragFunc(function(arg_38_0, arg_38_1)
		var_36_1 = var_36_1 or arg_38_1.position
		var_36_2 = arg_38_1.position.x - var_36_1.x

		return
	end)
	var_36_0:AddDragEndFunc(function(arg_39_0, arg_39_1)
		if self.isBlock then
			return
		end

		if var_36_2 < -50 then
			self:ChangeLetter(1)
		elseif var_36_2 > 50 then
			self:ChangeLetter(-1)
		end

		return
	end)

	return
end

function LoveLetterDisplayLayer:willExit()
	if self.rtStyle then
		eachChild(self.rtStyle:Find("before/medal"), function(arg_41_0, arg_41_1)
			returnLoveLetterMedal(arg_41_0)

			return
		end)
		pg.PoolMgr.GetInstance():ReturnPrefab("LoveLetterStyle/" .. self.contextData.prefab, "", self.rtStyle.gameObject)

		self.rtStyle = nil
	end

	if self.rtAnimation then
		retPaintingPrefab(self.rtAnimation:Find("painting_root/paint"), self.ll:GetPainting(), "mainNormal")
		pg.PoolMgr.GetInstance():ReturnPrefab("loveletteranim/loveletteranim", "", self.rtAnimation.gameObject)

		self.rtAnimation = nil
	end

	return
end

return LoveLetterDisplayLayer
