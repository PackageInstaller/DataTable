local NewBattleResultYumiaMaterialPage = class("NewBattleResultYumiaMaterialPage", import("view.base.BaseSubView"))

NewBattleResultYumiaMaterialPage.YUMIA_MATERIAL_DROP_TYPE_LIST = {
	DROP_TYPE_RYZA_DROP
}

function NewBattleResultYumiaMaterialPage:NeedShowYumiaMaterailDrop()
	if not self then
		return false
	end

	for iter_1_0, iter_1_1 in ipairs(self) do
		if table.contains(NewBattleResultYumiaMaterialPage.YUMIA_MATERIAL_DROP_TYPE_LIST, iter_1_1.type) then
			return true
		end
	end

	return false
end

function NewBattleResultYumiaMaterialPage:getUIName()
	return "NewBattleResultYumiaRewardPages"
end

function NewBattleResultYumiaMaterialPage:OnLoaded()
	self.parentTr = self._tf.parent
	self.itemContainer = self._tf:Find("item/container")
	self.itemTpl = self._tf:Find("item/tpl")
	self.confirmBtn = self._tf:Find("confirm_btn")
	self.lineTxt = self._tf:Find("words/text")

	setText(self.confirmBtn:Find("text"), i18n("word_ok"))

	return
end

function NewBattleResultYumiaMaterialPage:SetUp(arg_4_1)
	self:Show()
	seriesAsync({
		function(arg_5_0)
			self:playAnima("Anim_NewBattleResultYumiaRewardPages_In")
			self:UpdateItem()
			self:UpdateLine()
			self:RegisterEvent(arg_5_0)

			return
		end
	}, function()
		self:Clear()
		self:Destroy()
		arg_4_1()

		return
	end)

	return
end

function NewBattleResultYumiaMaterialPage:Show()
	NewBattleResultYumiaMaterialPage.super.Show(self)

	self.parentTr:GetComponent(typeof(Image)).enabled = false

	SetActive(self.parentTr:Find("Effect"), false)

	return
end

function NewBattleResultYumiaMaterialPage:dropFilter()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(self) do
		if table.contains(NewBattleResultYumiaMaterialPage.YUMIA_MATERIAL_DROP_TYPE_LIST, iter_8_1.type) then
			table.insert(var_8_0, iter_8_1)
		end
	end

	return var_8_0
end

function NewBattleResultYumiaMaterialPage:playAnima(arg_9_1, arg_9_2)
	self._tf:GetComponent(typeof(Animation)):Play(arg_9_1)
	self._tf:GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		arg_9_2()

		return
	end)

	return
end

function NewBattleResultYumiaMaterialPage:UpdateItem(arg_11_1)
	local var_11_0 = self.contextData.drops
	local var_11_1

	if not self.contextData.drops then
		var_11_0 = {}
		var_11_1 = {}
	end

	for iter_11_0, iter_11_1 in ipairs((NewBattleResultYumiaMaterialPage.dropFilter(var_11_0))) do
		for iter_11_2 = 1, iter_11_1.count do
			local var_11_2 = Drop.New({
				count = 1,
				type = iter_11_1.type,
				id = iter_11_1.id
			})
			local var_11_3 = cloneTplTo(self.itemTpl, self.itemContainer)

			setActive(var_11_3, false)
			table.insert(var_11_1, var_11_3)
			updateDrop(var_11_3:Find("IconTpl"), var_11_2)
		end
	end

	local var_11_4 = 1

	self.timer = Timer.New(function()
		setActive(var_11_1[var_11_4], true)
		var_11_1[var_11_4]:GetComponent(typeof(Animation)):Play("Anim_NewBattleResultYumiaRewardPages_Tpl_In")

		var_11_4 = var_11_4 + 1

		return
	end, 0.08, #var_11_1)

	self.timer:Start()

	return
end

function NewBattleResultYumiaMaterialPage:UpdateLine()
	local var_13_1 = NewBattleResultYumiaMaterialPage.dropFilter(self.contextData.drops or {})
	local var_13_2 = AtelierMaterial.New({
		configId = var_13_1[math.random(#var_13_1)].id
	}):GetVoices()

	if var_13_2 and #var_13_2 > 0 then
		local var_13_3 = var_13_2[math.random(#var_13_2)]
		local var_13_4, var_13_5, var_13_6 = ShipWordHelper.GetWordAndCV(var_13_3[1], var_13_3[2], nil, PLATFORM_CODE ~= PLATFORM_US)

		if var_13_5 then
			pg.CriMgr.GetInstance():PlaySoundEffect_V3(var_13_5)
		end

		setText(self.lineTxt, var_13_6)
	end

	return
end

function NewBattleResultYumiaMaterialPage:RegisterEvent(arg_14_1)
	if self.exited then
		return
	end

	local function var_14_0()
		self:playAnima("Anim_NewBattleResultYumiaRewardPages_Out", arg_14_1)

		return
	end

	onButton(self, self._tf, var_14_0, SFX_PANEL)
	onButton(self, self.confirmBtn, var_14_0, SFX_PANEL)

	if self.contextData.autoSkipFlag then
		triggerButton(self._tf)
	end

	return
end

function NewBattleResultYumiaMaterialPage:Clear()
	removeOnButton(self._tf)
	removeOnButton(self.confirmBtn)

	return
end

function NewBattleResultYumiaMaterialPage:OnDestroy()
	self.exited = true

	if self:isShowing() then
		self:Hide()
	end

	if self.timer then
		self.timer:Stop()
	end

	self.parentTr:GetComponent(typeof(Image)).enabled = true

	SetActive(self.parentTr:Find("Effect"), true)

	return
end

return NewBattleResultYumiaMaterialPage
