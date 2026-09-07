local MallSettleBox = class("MallSettleBox", import("view.base.BaseSubView"))

MallSettleBox.SILDER_TIME = 2
MallSettleBox.DIALOGUE_PROGRESS = 0.5
MallSettleBox.DIALOGUE_INTERVAL_TIME = 0.5
MallSettleBox.STAFF_CHANGE_INTERVAL = 0.2
MallSettleBox.STAFF_BODY_CNT = 4
MallSettleBox.STAFF_CLOTHES_CNT = 6
MallSettleBox.STAFF_FACE_CNT = 5

function MallSettleBox:getUIName()
	return "MallSettleBox"
end

function MallSettleBox:OnLoaded()
	setText(self.uiSummaryText, i18n("mall_summary_btn"))
	setText(self._tf:Find("window/tip"), i18n("word_click_to_close"))
	setActive(self.uiDialogueTpl, false)

	return
end

function MallSettleBox:OnInit()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.uiSummaryBtn, function()
		self:emit(MallMediator.OPEN_SUMMARY_BOX)

		return
	end, SFX_PANEL)

	return
end

function MallSettleBox:Show(arg_6_1, arg_6_2)
	MallSettleBox.super.Show(self)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	self.onHide = arg_6_2
	self.level = arg_6_1

	self:ShowAnim()
	setSlider(self.uiSliderTF, 0, 1, 0)

	self.isShowEvaluate = false

	self:managedTween(LeanTween.value, nil, go(self.uiSliderTF), 0, 1, MallSettleBox.SILDER_TIME):setOnUpdate(System.Action_float(function(arg_7_0)
		if not self.isShowEvaluate and arg_7_0 > MallSettleBox.DIALOGUE_PROGRESS then
			self.isShowEvaluate = true

			self:ChangeToEvaluate()
		end

		setSlider(self.uiSliderTF, 0, 1, arg_7_0)

		return
	end))

	return
end

function MallSettleBox:ShowAnim()
	setText(self.uiTitleText, i18n("mall_open_title"))
	setActive(self.uiAnimTF, true)
	setActive(self.uiDialogueTF, false)
	setActive(self.uiSummaryBtn, false)
	self:StartTimer()

	return
end

function MallSettleBox:ShowRandomShowStaff()
	GetImageSpriteFromAtlasAsync("ui/mallstafftpl_atlas", "body" .. math.random(1, MallSettleBox.STAFF_BODY_CNT), self.uiStaffTF:Find("body"))
	GetImageSpriteFromAtlasAsync("ui/mallstafftpl_atlas", "clothes" .. math.random(1, MallSettleBox.STAFF_CLOTHES_CNT), self.uiStaffTF:Find("clothes"))
	GetImageSpriteFromAtlasAsync("ui/mallstafftpl_atlas", "face" .. math.random(1, MallSettleBox.STAFF_FACE_CNT), self.uiStaffTF:Find("face"))

	return
end

function MallSettleBox:StartTimer()
	self:StopTimer()

	self.timer = Timer.New(function()
		self:ShowRandomShowStaff()

		return
	end, MallSettleBox.STAFF_CHANGE_INTERVAL, -1)

	self.timer:Start()
	self.timer.func()

	return
end

function MallSettleBox:StopTimer()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function MallSettleBox:ChangeToEvaluate()
	if self.isInDialogue then
		return
	end

	self:StopTimer()
	setText(self.uiTitleText, i18n("mall_evaluate_title"))
	setActive(self.uiAnimTF, false)
	removeAllChildren(self.uiDialogueContentTF)
	setActive(self.uiDialogueTF, true)

	local var_13_0 = {}
	local var_13_1 = MallLevel.GetShowInfos(self.level)
	local var_13_2 = pg.ship_skin_template[var_13_1.skinId].name
	local var_13_3 = "squareicon/" .. pg.ship_skin_template[var_13_1.skinId].prefab

	for iter_13_0, iter_13_1 in ipairs(var_13_1.wordList) do
		table.insert(var_13_0, function(arg_14_0)
			local var_14_0 = cloneTplTo(self.uiDialogueTpl, self.uiDialogueContentTF)

			setText(var_14_0:Find("name/Text"), var_13_2)
			setText(var_14_0:Find("word/Text"), iter_13_1)
			GetImageSpriteFromAtlasAsync(var_13_3, "", var_14_0:Find("icon"), true)
			scrollToBottom(self.uiDialogueTF)
			self:managedTween(LeanTween.delayedCall, function()
				arg_14_0()

				return
			end, MallSettleBox.DIALOGUE_INTERVAL_TIME, nil)

			return
		end)
	end

	self.isInDialogue = true

	seriesAsync(var_13_0, function()
		self.isInDialogue = false

		setActive(self.uiSummaryBtn, true)

		return
	end)

	return
end

function MallSettleBox:Hide()
	if self.timer then
		self:ChangeToEvaluate()

		return
	end

	if self.isInDialogue then
		return
	end

	MallSettleBox.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	self:StopTimer()
	self:cleanManagedTween()
	existCall(self.onHide)

	self.onHide = nil

	return
end

function MallSettleBox:OnDestroy()
	return
end

return MallSettleBox
