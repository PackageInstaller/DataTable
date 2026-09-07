local BackYardDecorationPutlistPage = class("BackYardDecorationPutlistPage", import(".BackYardDecorationBasePage"))

BackYardDecorationPutlistPage.SELECTED_FURNITRUE = "BackYardDecorationPutlistPage:SELECTED_FURNITRUE"

function BackYardDecorationPutlistPage:getUIName()
	return "BackYardPutListPage"
end

function BackYardDecorationPutlistPage:OnLoaded()
	self:bind(BackYardDecrationLayer.INNER_SELECTED_FURNITRUE, function(arg_3_0, arg_3_1)
		self:Selected(arg_3_1)

		return
	end)

	self._bg = self._tf:Find("frame")
	self.scrollRect = self._tf:Find("frame/frame/scrollrect"):GetComponent("LScrollRect")
	self.scrollRectTF = self._tf:Find("frame/frame/scrollrect")
	self.emptyTF = self._tf:Find("frame/frame/empty")
	self.arr = self._tf:Find("frame/frame/arr")

	setText(self._tf:Find("frame/title/Text"), i18n("courtyard_label_putlist_title"))

	return
end

function BackYardDecorationPutlistPage:OnInit()
	BackYardDecorationPutlistPage.super.OnInit(self)
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)
	onButton(self, self.arr, function()
		self:Hide()

		return
	end, SFX_PANEL)

	local function var_4_0()
		if self.timer then
			self.timer:Stop()

			self.timer = nil
		end

		return
	end

	local function var_4_1(arg_8_0)
		self.timer = Timer.New(arg_8_0, 0.8, 1)

		self.timer:Start()

		return
	end

	local function var_4_2(arg_9_0)
		local var_9_0 = BackYardDecorationPutlistPage.change2ScrPos(self.scrollRectTF:Find("content"), arg_9_0.position)
		local var_9_1

		for iter_9_0, iter_9_1 in pairs(self.cards) do
			local var_9_2 = Vector2(iter_9_1._tf.localPosition.x + iter_9_1._tf.rect.width / 2, iter_9_1._tf.localPosition.y + iter_9_1._tf.rect.height / 2)
			local var_9_3 = Vector2(iter_9_1._tf.localPosition.x + iter_9_1._tf.rect.width / 2, iter_9_1._tf.localPosition.y - iter_9_1._tf.rect.height / 2)

			if var_9_0.x > Vector2(iter_9_1._tf.localPosition.x - iter_9_1._tf.rect.width / 2, iter_9_1._tf.localPosition.y - iter_9_1._tf.rect.height / 2).x and var_9_0.x < var_9_3.x and var_9_0.y > var_9_3.y and var_9_0.y < var_9_2.y then
				var_9_1 = iter_9_1

				break
			end
		end

		return var_9_1
	end

	local var_4_3 = GetOrAddComponent(self.scrollRectTF, typeof(EventTriggerListener))

	var_4_3:AddPointDownFunc(function(arg_10_0, arg_10_1)
		local var_10_0 = var_4_2(arg_10_1)

		self.downPosition = arg_10_1.position

		if var_10_0 then
			var_4_0()
			var_4_1(function()
				self.lock = true

				self.contextData.furnitureDescMsgBox:ExecuteAction("SetUp", var_10_0.furniture, var_10_0._tf.position, true)

				return
			end)
		end

		return
	end)
	var_4_3:AddPointUpFunc(function(arg_12_0, arg_12_1)
		var_4_0()

		if self.lock then
			self.contextData.furnitureDescMsgBox:ExecuteAction("Hide")
			onNextTick(function()
				self.lock = false

				return
			end)
		else
			if Vector2.Distance(arg_12_1.position, self.downPosition) > 1 then
				return
			end

			local var_12_0 = var_4_2(arg_12_1)

			if var_12_0 then
				self:emit(BackYardDecorationMediator.ON_SELECTED_FURNITRUE, var_12_0.furniture.id)
				var_12_0:MarkOrUnMark(self.card.furniture.id)

				self.selectedId = self.card.furniture.id

				self:emit(BackYardDecorationPutlistPage.SELECTED_FURNITRUE)
			end
		end

		return
	end)

	return
end

function BackYardDecorationPutlistPage:ClearMark()
	self.selectedId = nil

	for iter_14_0, iter_14_1 in pairs(self.cards) do
		iter_14_1:MarkOrUnMark(self.selectedId)
	end

	return
end

function BackYardDecorationPutlistPage:Selected(arg_15_1)
	self:ClearMark()

	for iter_15_0, iter_15_1 in pairs(self.cards) do
		if iter_15_1.furniture and iter_15_1.furniture.id == arg_15_1 then
			iter_15_1:MarkOrUnMark(arg_15_1)

			break
		end
	end

	self.selectedId = arg_15_1

	return
end

function BackYardDecorationPutlistPage:change2ScrPos(arg_16_1)
	return (LuaHelper.ScreenToLocal(self:GetComponent("RectTransform"), arg_16_1, (GameObject.Find("UICamera"):GetComponent("Camera"))))
end

function BackYardDecorationPutlistPage:OnInitItem(arg_17_1)
	self.cards[arg_17_1] = BackYardDecorationPutCard.New(arg_17_1)

	return
end

function BackYardDecorationPutlistPage:OnUpdateItem(arg_18_1, arg_18_2)
	if not self.cards[arg_18_2] then
		self:OnInitItem(arg_18_2)
	end

	self.cards[arg_18_2]:Update(self.displays[arg_18_1 + 1], self.selectedId)

	return
end

function BackYardDecorationPutlistPage:OnDisplayList()
	self.displays = {}

	local var_19_0 = self.dorm:GetTheme(getProxy(DormProxy).floor)

	for iter_19_0, iter_19_1 in pairs((var_19_0 or nil) and var_19_0:GetAllFurniture()) do
		table.insert(self.displays, Furniture.New({
			count = 1,
			id = iter_19_1.configId
		}))
	end

	table.sort(self.displays, function(arg_20_0, arg_20_1)
		return arg_20_0:getConfig("type") < arg_20_1:getConfig("type")
	end)
	setActive(self.emptyTF, #self.displays == 0)

	self.scrollRect.enabled = true

	self.scrollRect:SetTotalCount(#self.displays)

	return
end

function BackYardDecorationPutlistPage:Show()
	BackYardDecorationPutlistPage.super.Show(self)
	LeanTween.value(self._bg.gameObject, self._bg.anchoredPosition.x, 0, 0.4):setOnUpdate(System.Action_float(function(arg_22_0)
		setAnchoredPosition(self._bg, {
			x = arg_22_0
		})

		return
	end)):setOnComplete(System.Action(function()
		if self.OnShow then
			self.OnShow(true)
		end

		return
	end))

	if self.OnShowImmediately then
		self.OnShowImmediately()
	end

	return
end

function BackYardDecorationPutlistPage:Hide()
	LeanTween.value(self._bg.gameObject, 0, -self._bg.rect.width, 0.4):setOnUpdate(System.Action_float(function(arg_25_0)
		setAnchoredPosition(self._bg, {
			x = arg_25_0
		})

		return
	end)):setOnComplete(System.Action(function()
		BackYardDecorationPutlistPage.super.Hide(self)

		if self.OnShow then
			self.OnShow(false)
		end

		return
	end))

	for iter_24_0, iter_24_1 in pairs(self.cards) do
		iter_24_1:Clear()
	end

	return
end

function BackYardDecorationPutlistPage:OnDormUpdated()
	self:OnDisplayList()

	return
end

function BackYardDecorationPutlistPage:OnDestroy()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end

	return
end

return BackYardDecorationPutlistPage
