local SofmapPTPage = class("SofmapPTPage", import(".TemplatePage.PtTemplatePage"))

SofmapPTPage.FADE_TIME = 0.5
SofmapPTPage.SHOW_TIME = 1
SofmapPTPage.FADE_OUT_TIME = 0.5
SofmapPTPage.SpineActionByStep = {
	4,
	8,
	12,
	16,
	20
}

function SofmapPTPage:OnFirstFlush()
	SofmapPTPage.super.OnFirstFlush(self)

	self.shop = self.bg:Find("shop")
	self.shopAnim = GetComponent(self.shop, "SpineAnimUI")
	self.sdContainer = self.bg:Find("sdcontainer")
	self.spine = nil
	self.spineLRQ = GetSpineRequestPackage.New("mingshi_5", function(arg_2_0)
		SetParent(arg_2_0, self.sdContainer)

		self.spine = arg_2_0
		self.spine.transform.localScale = Vector3.one

		local var_2_0 = self.spine:GetComponent("SpineAnimUI")

		if var_2_0 then
			var_2_0:SetAction("stand", 0)
		end

		self.spineLRQ = nil

		return
	end):Start()

	onButton(self, self.bg:Find("sdBtn"), function()
		self:showBubble()

		return
	end, SFX_PANEL)

	self.levelBtn = self.bg:Find("level_btn")
	self.ptBtn = self.bg:Find("pt_btn")
	self.bubble = self.bg:Find("bubble")
	self.bubbleText = self.bubble:Find("Text")
	self.bubbleCG = GetComponent(self.bubble, "CanvasGroup")
	self.showBubbleTag = false

	onButton(self, self.getBtn, function()
		local var_4_0, var_4_1 = self.ptData:GetResProgress()

		self:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = self.ptData:GetId(),
			arg1 = var_4_1,
			callback = function()
				self:showBubble(i18n("sofmapsd_3"))

				return
			end
		})

		return
	end, SFX_PANEL)
	onButton(self, self.levelBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.sofmap_attention.tip
		})

		return
	end, SFX_PANEL)

	local var_1_0 = {
		count = 0,
		type = DROP_TYPE_RESOURCE,
		id = self.ptData.resId
	}

	onButton(self, self.ptBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_SINGLE_ITEM,
			drop = var_1_0
		})

		return
	end, SFX_PANEL)

	return
end

function SofmapPTPage:OnUpdateFlush()
	SofmapPTPage.super.OnUpdateFlush(self)

	local var_8_0, var_8_1, var_8_2 = self.ptData:GetResProgress()

	setText(self.progress, (var_8_2 >= 1 and setColorStr(var_8_0, "#68E9F4FF") or var_8_0) .. "/" .. var_8_1)

	local var_8_3, var_8_4, var_8_5 = self.ptData:GetLevelProgress()

	if var_8_3 <= SofmapPTPage.SpineActionByStep[1] then
		self.shopAnim:SetAction("stand2", 0)
	elseif var_8_3 <= SofmapPTPage.SpineActionByStep[2] then
		self.shopAnim:SetAction("stand1", 0)
	elseif var_8_3 <= SofmapPTPage.SpineActionByStep[3] then
		self.shopAnim:SetAction("stand1x2", 0)
	elseif var_8_3 <= SofmapPTPage.SpineActionByStep[4] then
		self.shopAnim:SetAction("stand1x4", 0)
	elseif var_8_3 <= SofmapPTPage.SpineActionByStep[5] then
		self.shopAnim:SetAction("stand1x8", 0)
	end

	if not self.showBubbleTag then
		self:showBubble()

		self.showBubbleTag = true
	end

	return
end

function SofmapPTPage:OnDestroy()
	if self.spineLRQ then
		self.spineLRQ:Stop()

		self.spineLRQ = nil
	end

	if self.spine then
		self.spine.transform.localScale = Vector3.one

		pg.PoolMgr.GetInstance():ReturnSpineChar("mingshi_5", self.spine)

		self.spine = nil
	end

	return
end

function SofmapPTPage:showBubble(arg_10_1)
	local var_10_0

	if not arg_10_1 then
		if isActive(self.battleBtn) then
			var_10_0 = i18n("sofmapsd_1")
		elseif isActive(self.getBtn) then
			var_10_0 = i18n("sofmapsd_2")
		elseif isActive(self.gotBtn) then
			var_10_0 = i18n("sofmapsd_4")
		end
	else
		var_10_0 = arg_10_1
	end

	setText(self.bubbleText, var_10_0)

	local function var_10_1(arg_11_0)
		self.bubbleCG.alpha = arg_11_0

		setLocalScale(self.bubble, Vector3.one * arg_11_0)

		return
	end

	local function var_10_2()
		LeanTween.value(go(self.bubble), 1, 0, SofmapPTPage.FADE_OUT_TIME):setOnUpdate(System.Action_float(var_10_1)):setOnComplete(System.Action(function()
			setActive(self.bubble, false)

			return
		end))

		return
	end

	LeanTween.cancel(go(self.bubble))
	setActive(self.bubble, true)
	LeanTween.value(go(self.bubble), 0, 1, SofmapPTPage.FADE_TIME):setOnUpdate(System.Action_float(var_10_1)):setOnComplete(System.Action(function()
		LeanTween.delayedCall(go(self.bubble), SofmapPTPage.SHOW_TIME, System.Action(var_10_2))

		return
	end))

	return
end

return SofmapPTPage
