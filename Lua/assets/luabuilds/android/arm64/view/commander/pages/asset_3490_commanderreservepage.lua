local CommanderReservePage = class("CommanderReservePage", import("...base.BaseSubView"))

function CommanderReservePage:getUIName()
	return "CommanderReserveUI"
end

function CommanderReservePage:OnInit()
	self.bg1 = self._tf:Find("frame/bg1")

	setActive(self.bg1, true)

	self.minusBtn = self.bg1:Find("count/min")
	self.addBtn = self.bg1:Find("count/add")
	self.countTxt = self.bg1:Find("count/Text"):GetComponent(typeof(Text))
	self.consumeTxt = self.bg1:Find("price/Text"):GetComponent(typeof(Text))
	self.totalTxt = self.bg1:Find("price_all/Text"):GetComponent(typeof(Text))
	self.firstTip = self.bg1:Find("firstTip")
	self.confirmBtn = self.bg1:Find("Button")
	self.maxBtn = self.bg1:Find("max")
	self.bg2 = self._tf:Find("frame/bg2")
	self.box1 = self.bg2:Find("boxes/1"):GetComponent(typeof(Image))
	self.box2 = self.bg2:Find("boxes/2"):GetComponent(typeof(Image))
	self.box3 = self.bg2:Find("boxes/3"):GetComponent(typeof(Image))
	self.box4 = self.bg2:Find("boxes/4"):GetComponent(typeof(Image))
	self.skipBtn = self.bg2:Find("Button")
	self.animtion = self.bg2:GetComponent(typeof(Animation))
	self.aniEvt = self.bg2:GetComponent(typeof(DftAniEvent))
	self.boxes = self.bg2:Find("boxes")
	self.closeBg = self._tf:Find("bg")
	self.boxTF = self.bg2:Find("box")
	self.boxMove = self.bg2:Find("boxMove")
	self.tweenList = {}

	setActive(self.bg2, false)

	self.skip = false
	self.block = false

	onButton(self, self.closeBg, function()
		if self.block then
			return
		end

		self:Hide()

		return
	end, SFX_PANEL)
	pressPersistTrigger(self.minusBtn, 0.5, function(arg_4_0)
		if self.currCnt == 1 then
			arg_4_0()

			return
		end

		self.currCnt = self.currCnt - 1

		self:updateValue()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	pressPersistTrigger(self.addBtn, 0.5, function(arg_5_0)
		if self.currCnt > CommanderConst.MAX_GETBOX_CNT - self.count - 1 then
			arg_5_0()

			return
		end

		self.currCnt = self.currCnt + 1

		self:updateValue()

		return
	end, nil, true, true, 0.1, SFX_PANEL)
	onButton(self, self.skipBtn, function()
		self.skip = true

		self.animtion:Stop()
		self:endAnim()

		return
	end, SFX_PANEL)
	onButton(self, self.maxBtn, function()
		local var_7_0 = getProxy(PlayerProxy):getRawData():getResById(1)
		local var_7_1 = 0
		local var_7_2 = 0

		for iter_7_0 = self.count, self.count + (CommanderConst.MAX_GETBOX_CNT - self.count) - 1 do
			var_7_2 = var_7_2 + CommanderConst.getBoxComsume(iter_7_0)

			if var_7_0 < var_7_2 then
				break
			else
				var_7_1 = var_7_1 + 1
			end
		end

		self.currCnt = math.max(1, var_7_1)

		self:updateValue()

		return
	end, SFX_PANEL)
	onButton(self, self.confirmBtn, function()
		if self.currCnt > 0 then
			self.skip = false

			self:OnConfirm(self.total, self.currCnt)
		end

		return
	end, SFX_PANEL)
	setText(self._tf:Find("frame/bg1/tip"), i18n("commander_build_rate_tip"))
	setText(self._tf:Find("frame/bg1/label"), i18n("commander_get_box_tip"))
	setText(self._tf:Find("frame/bg1/label1"), i18n("commander_total_gold"))
	setText(self._tf:Find("frame/bg1/Text"), i18n("commander_get_box_tip_1"))

	return
end

function CommanderReservePage:OnConfirm(arg_9_1, arg_9_2)
	local var_9_0 = getProxy(PlayerProxy):getRawData()
	local var_9_1

	if arg_9_1 > var_9_0.gold then
		self:GoShoppingMsgBox(i18n("switch_to_shop_tip_2", i18n("word_gold")), ChargeScene.TYPE_ITEM, {
			{
				59001,
				arg_9_1 - var_9_0.gold,
				arg_9_1
			}
		})

		do return end

		var_9_1 = {}
	end

	var_9_1.content = i18n(arg_9_1 <= 0 and "commander_get_1" or "commander_get", arg_9_1, arg_9_2)

	function var_9_1.onYes()
		self:emit(CommanderCatMediator.RESERVE_BOX, arg_9_2)

		return
	end

	self.contextData.msgBox:ExecuteAction("Show", var_9_1)

	return
end

function CommanderReservePage:GoShoppingMsgBox(arg_11_1, arg_11_2, arg_11_3)
	if arg_11_3 then
		local var_11_0 = ""

		for iter_11_0, iter_11_1 in ipairs(arg_11_3) do
			var_11_0 = var_11_0 .. i18n(iter_11_1[1] == 59001 and "text_noRes_info_tip" or "text_noRes_info_tip2", Item.getConfigData(iter_11_1[1]).name, iter_11_1[2])

			if iter_11_0 < #arg_11_3 then
				var_11_0 = var_11_0 .. i18n("text_noRes_info_tip_link")
			end
		end

		if var_11_0 ~= "" then
			arg_11_1 = arg_11_1 .. "\n" .. i18n("text_noRes_tip", var_11_0)
		end
	end

	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		parent = rtf(pg.UIMgr.GetInstance().OverlayToast),
		content = arg_11_1,
		onYes = function()
			gotoChargeScene(arg_11_2, arg_11_3)

			return
		end
	})

	return
end

function CommanderReservePage:OnLoaded()
	self:bind(CommanderCatScene.MSG_RESERVE_BOX, function(arg_14_0, arg_14_1)
		self:OnReserveDone(arg_14_1)

		return
	end)

	return
end

function CommanderReservePage:OnReserveDone(arg_15_1)
	self.block = true

	seriesAsync({
		function(arg_16_0)
			self:PlayAnim(arg_15_1, arg_16_0)

			return
		end,
		function(arg_17_0)
			self:Update()
			self:emit(BaseUI.ON_AWARD, {
				items = arg_15_1
			})
			arg_17_0()

			return
		end
	}, function()
		self.block = false

		return
	end)

	return
end

function CommanderReservePage:updateValue()
	self.countTxt.text = self.currCnt
	self.consumeTxt.text = CommanderConst.getBoxComsume(self.count + self.currCnt - 1)
	self.total = 0

	for iter_19_0 = self.count, self.count + self.currCnt - 1 do
		self.total = self.total + CommanderConst.getBoxComsume(iter_19_0)
	end

	if getProxy(PlayerProxy):getRawData().gold < self.total then
		self.totalTxt.text = "<color=" .. COLOR_RED .. ">" .. self.total .. "</color>" or self.total
	end

	return
end

function CommanderReservePage:Update()
	self.count = getProxy(CommanderProxy):getBoxUseCnt()
	self.currCnt = 1
	self.total = 0

	self:updateValue()
	setActive(self.firstTip, self.count <= 0)
	self:Show()

	return
end

function CommanderReservePage:endAnim()
	setActive(self.bg1, true)
	setActive(self.bg2, false)

	for iter_21_0 = 0, self.boxMove.childCount - 1 do
		Destroy((self.boxMove:GetChild(iter_21_0)))
	end

	for iter_21_1, iter_21_2 in ipairs(self.tweenList) do
		if iter_21_2 then
			LeanTween.cancel(iter_21_2)
		end
	end

	self.tweenList = {}
	self.skip = false

	if self.callback then
		self.callback()

		self.callback = nil
	end

	return
end

function CommanderReservePage:PlayAnim(arg_22_1, arg_22_2)
	assert(arg_22_2)

	self.callback = arg_22_2

	setActive(self.bg1, false)
	setActive(self.bg2, true)
	setActive(self.boxes, true)

	if self.skip then
		self:endAnim()
	else
		self.animtion:Play("reserve")

		local var_22_0 = 0
		local var_22_1 = 0

		self.aniEvt:SetTriggerEvent(function(arg_23_0)
			for iter_23_0, iter_23_1 in ipairs(arg_22_1) do
				var_22_0 = var_22_0 + iter_23_0
			end

			for iter_23_2, iter_23_3 in ipairs(arg_22_1) do
				for iter_23_4 = 1, iter_23_3.count do
					table.insert(self.tweenList, LeanTween.delayedCall(0.2 + 1 * var_22_1 + 1 * (iter_23_4 - 1), System.Action(function()
						self:playBoxMove(iter_23_3)

						return
					end)).uniqueId)
				end

				var_22_1 = var_22_1 + iter_23_3.count
			end

			table.insert(self.tweenList, LeanTween.delayedCall(0.2 + 1 * (var_22_1 - 1), System.Action(function()
				setActive(self.boxes, false)

				return
			end)).uniqueId)
			table.insert(self.tweenList, LeanTween.delayedCall(0.2 + 1 * (var_22_1 - 1) + 2, System.Action(function()
				self:endAnim()

				return
			end)).uniqueId)

			return
		end)
	end

	return
end

function CommanderReservePage:Show()
	setActive(self._tf, true)
	setActive(self.bg1, true)
	setActive(self.bg2, false)

	self.skip = false

	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function CommanderReservePage:Hide()
	CommanderReservePage.super.Hide(self)
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf, self._parentTf)

	return
end

function CommanderReservePage:playBoxMove(arg_29_1)
	local var_29_0 = cloneTplTo(self.boxTF, self.boxMove)

	if arg_29_1.id == 20011 then
		var_29_0:GetComponent(typeof(Image)).sprite = self.box1.sprite
	elseif arg_29_1.id == 20012 then
		var_29_0:GetComponent(typeof(Image)).sprite = self.box2.sprite
	elseif arg_29_1.id == 20013 then
		var_29_0:GetComponent(typeof(Image)).sprite = self.box3.sprite
	end

	var_29_0:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		Destroy(go(var_29_0))

		return
	end)

	return
end

function CommanderReservePage:OnDestroy()
	if self:isShowing() then
		self:Hide()
	end

	return
end

return CommanderReservePage
