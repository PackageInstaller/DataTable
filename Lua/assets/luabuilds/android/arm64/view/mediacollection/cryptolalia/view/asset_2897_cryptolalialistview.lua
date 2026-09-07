local CryptolaliaListView = class("CryptolaliaListView", import("view.base.BaseSubView"))

function CryptolaliaListView:getUIName()
	return "CryptolaliaListui"
end

function CryptolaliaListView:OnLoaded()
	self.cards = {}
	self.scrollrect = self._tf:Find("frame/view"):GetComponent("LScrollRect")

	function self.scrollrect.onInitItem(arg_3_0)
		self:OnInitItem(arg_3_0)

		return
	end

	function self.scrollrect.onUpdateItem(arg_4_0, arg_4_1)
		self:onUpdateItem(arg_4_0, arg_4_1)

		return
	end

	self.frameTr = self._tf:Find("frame")
	self.subTitleTxt = self._tf:Find("frame/subtitle"):GetComponent(typeof(Text))

	setText(self._tf:Find("frame/title"), i18n("cryptolalia_list_title"))

	return
end

function CryptolaliaListView:OnInit()
	return
end

function CryptolaliaListView:OnInitItem(arg_6_1)
	local function var_6_0()
		if not self.cryptolaliaId then
			return
		end

		for iter_7_0, iter_7_1 in pairs(self.cards) do
			if iter_7_1.cryptolalia.id == self.cryptolaliaId then
				iter_7_1:Update(iter_7_1.cryptolalia, self.langType, false)
			end
		end

		return
	end

	local var_6_1 = CryptolaliaCard.New(arg_6_1)

	onButton(self, var_6_1._go, function()
		if self:CanSwitch() then
			var_6_0()

			self.cryptolaliaId = var_6_1.cryptolalia.id

			var_6_1:Update(var_6_1.cryptolalia, self.langType, true)
			self:SelectCard(self.cryptolaliaId)
		end

		return
	end, SFX_PANEL)

	self.cards[arg_6_1] = var_6_1

	return
end

function CryptolaliaListView:CanSwitch()
	return not self.scrollRect.inAnimation
end

function CryptolaliaListView:onUpdateItem(arg_10_1, arg_10_2)
	local var_10_0 = self.cards[arg_10_2]
	local var_10_1

	if not self.cards[arg_10_2] then
		self:OnInitItem(arg_10_2)

		var_10_0 = self.cards[arg_10_2]
		var_10_1 = self.displays[arg_10_1 + 1].id == self.cryptolaliaId
	end

	var_10_0:Update(self.displays[arg_10_1 + 1], self.langType, var_10_1)

	return
end

function CryptolaliaListView:Show(arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	self.scrollRect = arg_11_4

	CryptolaliaListView.super.Show(self)
	seriesAsync({
		function(arg_12_0)
			self:EnterAnimation(arg_12_0)

			return
		end,
		function(arg_13_0)
			self:InitList(arg_11_1, arg_11_2, arg_11_3)
			self:RegisterEvent()
			arg_13_0()

			return
		end
	})

	return
end

function CryptolaliaListView:EnterAnimation(arg_14_1)
	LeanTween.value(self._tf.gameObject, self.frameTr.sizeDelta.x, 0, 0.3):setOnUpdate(System.Action_float(function(arg_15_0)
		self._tf.localPosition = Vector3(arg_15_0, self._tf.localPosition.y, 0)

		return
	end)):setFrom(self.frameTr.sizeDelta.x):setEase(LeanTweenType.easeInOutSine):setOnComplete(System.Action(arg_14_1))

	return
end

function CryptolaliaListView:InitList(arg_16_1, arg_16_2, arg_16_3)
	self.cryptolaliaId = arg_16_3
	self.langType = arg_16_2
	self.displays = arg_16_1

	self.scrollrect:SetTotalCount(#self.displays)

	self.subTitleTxt.text = i18n("cryptolalia_list_subtitle", #self.displays)

	return
end

function CryptolaliaListView:RegisterEvent()
	onButton(self, self._tf, function()
		self:Hide()

		return
	end, SFX_PANEL)

	return
end

function CryptolaliaListView:Hide()
	CryptolaliaListView.super.Hide(self)
	removeOnButton(self._tf)

	if LeanTween.isTweening(self._tf.gameObject) then
		LeanTween.cancel(self._tf.gameObject)
	end

	return
end

function CryptolaliaListView:SelectCard(arg_20_1)
	self:emit(CryptolaliaScene.ON_SELECT, arg_20_1)

	return
end

function CryptolaliaListView:OnDestroy()
	for iter_21_0, iter_21_1 in pairs(self.cards) do
		iter_21_1:Dispose()
	end

	self.cards = {}

	ClearLScrollrect(self.scrollrect)

	return
end

return CryptolaliaListView
