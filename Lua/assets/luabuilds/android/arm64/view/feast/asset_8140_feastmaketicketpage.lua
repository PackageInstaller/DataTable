local FeastMakeTicketPage = class("FeastMakeTicketPage", import("view.base.BaseSubView"))

function FeastMakeTicketPage:getUIName()
	return "FeastPuzzlePage"
end

function FeastMakeTicketPage:OnLoaded()
	self.back = self._tf:Find("back")
	self.finishTr = self._tf:Find("finish")
	self.envelopesAnim = self.finishTr:Find("envelopes"):GetComponent(typeof(SpineAnimUI))
	self.sendBtn = self.finishTr:Find("send")
	self.titleTr = self.finishTr:Find("label1")
	self.failedTip = self._tf:Find("failed_tip")
	self.descTr = self._tf:Find("desc_panel")
	self.descTxt = self.descTr:Find("frame/Text"):GetComponent(typeof(Text))
	self.homeBtn = self._tf:Find("home")
	self.helpBtn = self._tf:Find("help")
	self.tipTopTr = self._tf:Find("tip")

	setText(self._tf:Find("tip/Text"), i18n("feast_label_make_ticket_tip"))
	setText(self._tf:Find("tip/label"), i18n("feast_label_make_ticket_click_tip"))
	setText(self._tf:Find("failed_tip/Text"), i18n("feast_label_make_ticket_failed_tip"))

	return
end

function FeastMakeTicketPage:OnInit()
	self:bind(FeastScene.ON_MAKE_TICKET, function(arg_4_0, arg_4_1)
		self:OnMakeTicket(arg_4_1)

		return
	end)

	return
end

function FeastMakeTicketPage:OnMakeTicket(arg_5_1)
	if self.feastShip and self.feastShip.id == arg_5_1 then
		setActive(self.finishTr, true)
		setActive(self.tipTopTr, false)

		self.sendBtn.localScale = Vector3.zero
		self.titleTr.localScale = Vector3.zero

		self.envelopesAnim:SetActionCallBack(function(arg_6_0)
			if arg_6_0 == "finish" then
				LeanTween.scale(self.sendBtn, Vector3(1, 1, 1), 0.3)
				LeanTween.scale(self.titleTr, Vector3(1, 1, 1), 0.3)
				self.envelopesAnim:SetActionCallBack(nil)
				self.envelopesAnim:SetAction("action2", 0)
			end

			return
		end)
		self.envelopesAnim:SetAction("action1", 0)
	end

	return
end

function FeastMakeTicketPage:Show(arg_7_1)
	Input.multiTouchEnabled = false

	FeastMakeTicketPage.super.Show(self)
	self:CloseTip()
	setActive(self.tipTopTr, true)
	setActive(self.finishTr, false)

	self.feastShip = arg_7_1

	seriesAsync({
		function(arg_8_0)
			self:LoadPuzzleRes(arg_7_1:GetPrefab(), arg_8_0)

			return
		end
	}, function()
		self:InitPuzzle()
		self:RegisterEvent()

		return
	end)

	return
end

function FeastMakeTicketPage:LoadPuzzleRes(arg_10_1, arg_10_2)
	ResourceMgr.Inst:getAssetAsync("FeastPuzzle/" .. arg_10_1, "", typeof(GameObject), UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_11_0)
		if self.exited then
			return
		end

		self.puzzleGo = Object.Instantiate(arg_11_0, self._tf:Find("container"))
		self.rect = self.puzzleGo.transform:Find("nodes")
		self.items = {}

		eachChild(self.rect, function(arg_12_0)
			local var_12_0 = tonumber(arg_12_0.name)

			table.insert(self.items, {
				level = var_12_0,
				tr = arg_12_0,
				isCompletion = var_12_0 == 1
			})

			return
		end)
		arg_10_2()

		return
	end), true, true)

	return
end

local function var_0_1(arg_13_0, arg_13_1)
	return (LuaHelper.ScreenToLocal(arg_13_0:GetComponent("RectTransform"), arg_13_1, pg.UIMgr.GetInstance().overlayCameraComp))
end

function FeastMakeTicketPage:InitPuzzle(arg_14_1)
	self.dragging = false

	for iter_14_0, iter_14_1 in ipairs(self.items) do
		local var_14_0 = iter_14_1.tr:GetComponent(typeof(EventTriggerListener))
		local var_14_1 = Vector3.zero

		var_14_0:AddBeginDragFunc(function(arg_15_0, arg_15_1)
			self.dragging = true
			var_14_1 = iter_14_1.tr.localPosition

			iter_14_1.tr:SetAsLastSibling()

			return
		end)
		var_14_0:AddDragFunc(function(arg_16_0, arg_16_1)
			iter_14_1.tr.localPosition = var_0_1(self.rect, arg_16_1.position)

			return
		end)
		var_14_0:AddDragEndFunc(function(arg_17_0, arg_17_1)
			self.dragging = false

			local var_17_0 = self:FindMatcher(iter_14_1)

			if var_17_0 then
				self:Merge(iter_14_1, var_17_0, var_14_1)

				if self:CheckFinish() then
					self:OnPass()
				end
			else
				self:ShowTip()

				iter_14_1.tr.localPosition = var_14_1
			end

			return
		end)
		var_14_0:AddPointUpFunc(function(arg_18_0, arg_18_1)
			if self.dragging then
				return
			end

			self:ShowDesc(iter_14_1)

			return
		end)
	end

	return
end

function FeastMakeTicketPage:ShowTip()
	self:CloseTip()
	setActive(self.failedTip, true)

	self.timer = Timer.New(function()
		self:CloseTip()

		return
	end, 2, 1)

	self.timer:Start()

	return
end

function FeastMakeTicketPage:CloseTip()
	if self.timer then
		setActive(self.failedTip, false)
		self.timer:Stop()

		self.timer = nil
	end

	return
end

function FeastMakeTicketPage:CheckFinish()
	return self.rect.childCount == 1
end

function FeastMakeTicketPage:Merge(arg_23_1, arg_23_2, arg_23_3)
	if arg_23_2.level < arg_23_1.level then
		arg_23_1.tr.localPosition = arg_23_3

		setParent(arg_23_2.tr, arg_23_1.tr:Find("slot"))

		arg_23_2.tr.localPosition = Vector3.zero

		self:ClearEvent(arg_23_2.tr)

		arg_23_1.isCompletion = true
	else
		setParent(arg_23_1.tr, arg_23_2.tr:Find("slot"))

		arg_23_1.tr.localPosition = Vector3.zero

		self:ClearEvent(arg_23_1.tr)

		arg_23_2.isCompletion = true
	end

	return
end

local function var_0_2(arg_24_0, arg_24_1)
	return getBounds(arg_24_0.tr):Intersects((getBounds(arg_24_1.tr)))
end

local function var_0_3(arg_25_0, arg_25_1)
	if arg_25_0.level < arg_25_1.level then
		return arg_25_0.isCompletion
	else
		return arg_25_1.isCompletion
	end

	return
end

function FeastMakeTicketPage:FindMatcher(arg_26_1)
	for iter_26_0, iter_26_1 in pairs(self.items) do
		if (arg_26_1.level + 1 == iter_26_1.level or arg_26_1.level - 1 == iter_26_1.level) and var_0_3(arg_26_1, iter_26_1) and var_0_2(arg_26_1, iter_26_1) then
			return iter_26_1
		end
	end

	return nil
end

function FeastMakeTicketPage:OnPass()
	for iter_27_0, iter_27_1 in ipairs(self.items) do
		self:ClearEvent(iter_27_1.tr)
	end

	setActive(self.rect, false)
	self:emit(FeastMediator.MAKE_TICKET, self.feastShip.tid)

	return
end

function FeastMakeTicketPage:RegisterEvent(arg_28_1)
	onButton(self, self.back, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.sendBtn, function()
		self:Hide()
		self:emit(FeastScene.ON_SKIP_GIVE_GIFT, self.feastShip)

		return
	end, SFX_PANEL)
	onButton(self, self.helpBtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.feast_make_invitation_tip.tip
		})

		return
	end, SFX_PANEL)
	onButton(self, self.homeBtn, function()
		self:emit(BaseUI.ON_HOME)

		return
	end, SFX_PANEL)

	return
end

function FeastMakeTicketPage:ShowDesc(arg_33_1)
	self.isShowDesc = true

	pg.UIMgr.GetInstance():BlurPanel(self.descTr)
	setActive(self.descTr, true)

	self.descNode = Object.Instantiate(arg_33_1.tr.gameObject, self.descTr)
	self.descNode.transform.localPosition = Vector3(0, 100, 0)
	self.descTxt.text = i18n("feast_invitation_part" .. arg_33_1.level)

	onButton(self, self.descTr, function()
		self:HideDesc()

		return
	end, SFX_PANEL)

	return
end

function FeastMakeTicketPage:HideDesc()
	if not self.isShowDesc then
		return
	end

	self.isShowDesc = false

	pg.UIMgr.GetInstance():UnOverlayPanel(self.descTr, self._tf)

	if self.descNode then
		Object.Destroy(self.descNode.gameObject)

		self.descNode = nil
	end

	setActive(self.descTr, false)

	return
end

function FeastMakeTicketPage:Clear()
	self.envelopesAnim:SetActionCallBack(nil)
	self:CloseTip()

	for iter_36_0, iter_36_1 in ipairs(self.items) do
		self:ClearEvent(iter_36_1.tr)
	end

	self.items = {}

	if self.puzzleGo then
		Object.Destroy(self.puzzleGo)

		self.puzzleGo = nil
	end

	removeOnButton(self.back)

	if LeanTween.isTweening(self.sendBtn.gameObject) then
		LeanTween.cancel(self.sendBtn.gameObject)
	end

	if LeanTween.isTweening(self.titleTr.gameObject) then
		LeanTween.cancel(self.titleTr.gameObject)
	end

	self:HideDesc()

	return
end

function FeastMakeTicketPage:ClearEvent(arg_37_1)
	local var_37_0 = arg_37_1:GetComponent(typeof(EventTriggerListener))

	var_37_0:AddBeginDragFunc(nil)
	var_37_0:AddDragFunc(nil)
	var_37_0:AddDragEndFunc(nil)
	var_37_0:AddPointUpFunc(nil)

	for iter_37_0, iter_37_1 in ipairs((arg_37_1:GetComponentsInChildren(typeof(Image)):ToTable())) do
		iter_37_1.raycastTarget = false
	end

	return
end

function FeastMakeTicketPage:Hide()
	Input.multiTouchEnabled = true

	FeastMakeTicketPage.super.Hide(self)
	self:Clear()

	return
end

function FeastMakeTicketPage:OnDestroy()
	self.exited = true

	self:Clear()

	if self:isShowing() then
		self:Hide()
	end

	return
end

return FeastMakeTicketPage
