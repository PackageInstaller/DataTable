local ShipEvaluationLayer = class("ShipEvaluationLayer", import("..base.BaseUI"))

ShipEvaluationLayer.EVENT_LIKE = "event like"
ShipEvaluationLayer.EVENT_EVA = "event eva"
ShipEvaluationLayer.EVENT_ZAN = "event zan"
ShipEvaluationLayer.EVENT_IMPEACH = "event impeach"

function ShipEvaluationLayer:getUIName()
	return "EvaluationUI"
end

function ShipEvaluationLayer:init()
	self.mainPanel = self._tf:Find("mainPanel")
	self.head = self.mainPanel:Find("bg/left_panel/ship_tpl")
	self.labelHeart = self.mainPanel:Find("bg/left_panel/evaluation_count/heart")
	self.labelEva = self.mainPanel:Find("bg/left_panel/evaluation_count/count")
	self.btnLike = self.mainPanel:Find("bg/left_panel/btnLike")
	self.btnEva = self.mainPanel:Find("bg/bottom_panel/send_btn")
	self.input = self.mainPanel:Find("bg/bottom_panel/Input")
	self.inputText = self.input:Find("Text")
	self.list = self.mainPanel:Find("bg/right_panel/list")
	self.hotContent = self.list:Find("content/hots")
	self.commonContent = self.list:Find("content/commons")
	self.hotTpl = self.list:Find("content/hot_tpl")
	self.commonTpl = self.list:Find("content/commom_tpl")
	self.iconType = findTF(self.head, "content/main_bg/type_mask/type_icon"):GetComponent(typeof(Image))
	self.imageBg = findTF(self.head, "content/icon_bg"):GetComponent(typeof(Image))
	self.imageFrame = findTF(self.head, "content/main_bg/frame")
	self.iconShip = findTF(self.head, "content/icon"):GetComponent(typeof(Image))
	self.labelName = findTF(self.head, "content/main_bg/name_mask/name"):GetComponent(typeof(Text))
	self.scrollText = findTF(self.head, "content/main_bg/name_mask/name"):GetComponent(typeof(ScrollText))
	self.stars = findTF(self.head, "content/main_bg/stars")
	self.star = findTF(self.stars, "tpl")
	self.bg = self._tf:Find("BG")
	self.btnHelp = self._tf:Find("mainPanel/bg/top_panel/title/help")

	setActive(self.btnHelp, getProxy(PlayerProxy):getRawData():IsOpenShipEvaluationImpeach())
	self:initImpeachPanel()
	setActive(self.mainPanel, true)
	setActive(self.impackPanel, false)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function ShipEvaluationLayer:onBackPressed()
	if isActive(self.impackPanel) then
		setActive(self.mainPanel, true)
		setActive(self.impackPanel, false)
	else
		self:closeView()
	end

	return
end

function ShipEvaluationLayer:didEnter()
	onButton(self, self.bg, function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("mainPanel/bg/top_panel/btnBack"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self.btnHelp, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = i18n("report_sent_help")
		})

		return
	end, SFX_PANEL)
	onButton(self, self.btnLike, function()
		self:emit(ShipEvaluationLayer.EVENT_LIKE)

		return
	end, SFX_PANEL)
	onButton(self, self.btnEva, function()
		local var_9_0 = getInputText(self.input)

		if string.len(var_9_0) > 0 then
			setInputText(self.input, "")
			self:emit(ShipEvaluationLayer.EVENT_EVA, var_9_0)
		else
			pg.TipsMgr.GetInstance():ShowTips(i18n("eva_comment_send_null"))
		end

		return
	end, SFX_PANEL)
	onInputChanged(self, self.input, function()
		local var_10_0 = getInputText(self.input)
		local var_10_1
		local var_10_2

		if string.len(var_10_0) > 0 then
			if self.shipGroup.evaluation.ievaCount >= CollectionProxy.MAX_DAILY_EVA_COUNT then
				var_10_1 = true
				var_10_2 = i18n("eva_count_limit")
			elseif wordVer(var_10_0) > 0 then
				var_10_1 = true
				var_10_2 = i18n("invalidate_evaluation")
			end
		end

		if var_10_1 then
			setTextColor(self.inputText, Color.red)
			setButtonEnabled(self.btnEva, false)
			pg.TipsMgr.GetInstance():ShowTips(var_10_2)
		else
			setTextColor(self.inputText, Color.white)
			setButtonEnabled(self.btnEva, true)
		end

		return
	end)

	return
end

function ShipEvaluationLayer:setShipGroup(arg_11_1)
	self.shipGroup = arg_11_1

	return
end

function ShipEvaluationLayer:setShowTrans(arg_12_1)
	self.showTrans = arg_12_1

	return
end

function ShipEvaluationLayer:flushAll()
	self:flushShip()
	self:flushHeart()
	self:flushEva()

	return
end

function ShipEvaluationLayer:flushShip()
	local var_14_0 = self.shipGroup:rarity2bgPrint(self.showTrans)

	setShipCardFrame(self.imageFrame, var_14_0, nil)
	GetImageSpriteFromAtlasAsync("bg/star_level_card_" .. var_14_0, "", self.imageBg)

	self.iconShip.sprite = GetSpriteFromAtlas("shipYardIcon/unknown", "")

	LoadImageSpriteAsync("shipYardIcon/" .. self.shipGroup:getPainting(self.showTrans), self.iconShip)

	self.labelName.text = self.shipGroup:getName(self.showTrans)

	if self.scrollText then
		self.scrollText:SetText(self.shipGroup:getName(self.showTrans))
	end

	local var_14_1 = GetSpriteFromAtlas("shiptype", shipType2print(self.shipGroup:getShipType(self.showTrans)))

	if not var_14_1 then
		warning("找不到船形, shipConfigId: " .. self.shipGroup.shipConfig.id)
	end

	self.iconType.sprite = var_14_1

	for iter_14_0 = self.stars.childCount, pg.ship_data_template[self.shipGroup.shipConfig.id].star_max - 1 do
		local var_14_2 = cloneTplTo(self.star, self.stars)
	end

	return
end

function ShipEvaluationLayer:flushHeart()
	setButtonEnabled(self.btnLike, not self.shipGroup.iheart)
	setText(self.labelHeart, self.shipGroup.evaluation.hearts)

	return
end

function ShipEvaluationLayer:flushEva()
	setText(self.labelEva, self.shipGroup.evaluation.evaCount)

	for iter_16_0 = 1, self.hotContent.childCount do
		local var_16_0 = go(self.hotContent:GetChild(iter_16_0 - 1))

		if var_16_0.name ~= "tag" then
			Destroy(var_16_0)
		end
	end

	for iter_16_1 = 1, self.commonContent.childCount do
		local var_16_1 = go(self.commonContent:GetChild(iter_16_1 - 1))

		if var_16_1.name ~= "tag" then
			Destroy(var_16_1)
		end
	end

	local var_16_2 = getProxy(PlayerProxy):getRawData():IsOpenShipEvaluationImpeach()

	for iter_16_2 = 1, #self.shipGroup.evaluation.evas do
		local var_16_3
		local var_16_4 = self.shipGroup.evaluation.evas[iter_16_2]

		var_16_3 = self.shipGroup.evaluation.evas[iter_16_2].hot and cloneTplTo(self.hotTpl, self.hotContent) or cloneTplTo(self.commonTpl, self.commonContent)

		local var_16_5 = var_16_3:Find("bg/evaluation"):GetComponent(typeof(Text))
		local var_16_6 = var_16_3:Find("bg/zan_bg/Text")

		setText(var_16_3:Find("bg/name"), var_16_4.nick_name .. ":")
		setText(var_16_6, var_16_4.good_count - var_16_4.bad_count)

		var_16_5.supportRichText = false
		var_16_5.text = var_16_4.context

		local function var_16_7(arg_17_0)
			if not var_16_4.izan then
				self:emit(ShipEvaluationLayer.EVENT_ZAN, var_16_4.id, arg_17_0)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("zan_ship_eva_error_7"))
			end

			return
		end

		onButton(self, var_16_3:Find("bg/zan_bg/up"), function()
			var_16_7(0)

			return
		end, SFX_PANEL)
		onButton(self, var_16_3:Find("bg/zan_bg/down"), function()
			var_16_7(1)

			return
		end, SFX_PANEL)
		onButton(self, var_16_3:Find("bg/zan_bg/impeach"), function()
			self:openImpeachPanel(var_16_4.id)

			return
		end, SFX_PANEL)
		SetActive(var_16_3:Find("bg/zan_bg/down"), not defaultValue(LOCK_DOWNVOTE, true))
		setActive(var_16_3:Find("bg/zan_bg/impeach"), var_16_2)
	end

	local var_16_8 = 1

	for iter_16_3 = 1, self.hotContent.childCount do
		local var_16_9 = self.hotContent:GetChild(iter_16_3 - 1)

		if go(var_16_9).name ~= "tag" then
			setActive(var_16_9:Find("print1"), var_16_8 % 2 ~= 0)
			setActive(var_16_9:Find("print2"), var_16_8 % 2 == 0)

			var_16_8 = var_16_8 + 1
		end
	end

	setActive(self.hotContent:Find("tag"), self.hotContent.childCount > 1)
	setActive(self.commonContent:Find("tag"), self.commonContent.childCount > 1)
	self.hotContent:Find("tag"):SetAsLastSibling()
	self.commonContent:Find("tag"):SetAsLastSibling()

	return
end

local var_0_1 = 3

function ShipEvaluationLayer:initImpeachPanel()
	self.impackPanel = self._tf:Find("impeachPanel")

	setText(self.impackPanel:Find("window/top/bg/impeach/title"), i18n("report_sent_title"))
	onButton(self, self.impackPanel:Find("window/top/btnBack"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)

	local var_21_0 = self.impackPanel:Find("window/msg_panel/content")

	setText(var_21_0:Find("title"), i18n("report_sent_desc"))

	local var_21_1 = UIItemList.New(var_21_0:Find("options"), var_21_0:Find("options/tpl"))

	var_21_1:make(function(arg_23_0, arg_23_1, arg_23_2)
		arg_23_1 = arg_23_1 + 1

		if arg_23_0 == UIItemList.EventUpdate then
			setText(arg_23_2:Find("Text"), i18n("report_type_" .. arg_23_1))
			setText(arg_23_2:Find("Text_2"), i18n("report_type_" .. arg_23_1 .. "_1"))
			onToggle(self, arg_23_2, function(arg_24_0)
				self.impeachOption = arg_23_1

				return
			end)
		end

		return
	end)
	var_21_1:align(var_0_1)
	setText(var_21_0:Find("other/field/Text"), i18n("report_type_other"))
	setText(var_21_0:Find("other/field/input/Placeholder"), i18n("report_type_other_1"))
	onToggle(self, var_21_0:Find("other"), function(arg_25_0)
		self.impeachOption = "other"

		setActive(var_21_0:Find("other/field/input"), arg_25_0)

		return
	end)

	local var_21_2 = var_21_0:Find("other/field/input")

	onInputChanged(self, var_21_2, function()
		Canvas.ForceUpdateCanvases()

		return
	end)
	onButton(self, self.impackPanel:Find("window/button_container/button"), function()
		if self.impeachOption == "other" then
			local var_27_0 = getInputText(var_21_2)

			if string.len(var_27_0) > 0 then
				self:emit(ShipEvaluationLayer.EVENT_IMPEACH, self.targetEvaId, i18n("report_type_other") .. ":" .. var_27_0)
			else
				pg.TipsMgr.GetInstance():ShowTips(i18n("report_type_other_2"))

				return
			end
		else
			self:emit(ShipEvaluationLayer.EVENT_IMPEACH, self.targetEvaId, i18n("report_type_" .. self.impeachOption))
		end

		self:onBackPressed()

		return
	end, SFX_CONFIRM)

	return
end

function ShipEvaluationLayer:openImpeachPanel(arg_28_1)
	self.targetEvaId = arg_28_1

	setActive(self.mainPanel, false)
	setActive(self.impackPanel, true)
	triggerToggle(self.impackPanel:Find("window/msg_panel/content/other"), true)
	triggerToggle(self.impackPanel:Find("window/msg_panel/content/options/tpl"), true)

	return
end

function ShipEvaluationLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return ShipEvaluationLayer
