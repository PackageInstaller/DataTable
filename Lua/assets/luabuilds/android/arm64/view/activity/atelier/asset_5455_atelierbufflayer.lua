local AtelierBuffLayer = class("AtelierBuffLayer", import("view.base.BaseUI"))

function AtelierBuffLayer:getUIName()
	return "AtelierBuffUI"
end

function AtelierBuffLayer:SetActivity(arg_2_1)
	self.activity = arg_2_1

	local var_2_0 = arg_2_1:GetItems()
	local var_2_1 = AtelierMaterial.bindConfigTable()

	self.buffItems = _.map(_.filter(var_2_1.all, function(arg_3_0)
		return var_2_1[arg_3_0].type == AtelierMaterial.TYPE.STRENGTHEN
	end), function(arg_4_0)
		return var_2_0[arg_4_0] or AtelierMaterial.New({
			configId = arg_4_0
		})
	end)

	return
end

function AtelierBuffLayer:init()
	self.slotTfs = _.map({
		1,
		2,
		3,
		4,
		5
	}, function(arg_6_0)
		return self._tf:Find("Panel"):GetChild(arg_6_0)
	end)
	self.effectList = self._tf:Find("Effects/ScrollView/Viewport/Content")

	setText(self._tf:Find("Items/List"):GetChild(0):Find("Max/Text"), i18n("ryza_tip_control_buff_limit"))
	setText(self._tf:Find("Items/List"):GetChild(0):Find("Min/Text"), i18n("ryza_tip_control_buff_not_obtain"))
	setText(self._tf:Find("Top/Tips"), i18n("ryza_tip_control"))
	setText(self._tf:Find("Effects/Total"), i18n("ryza_tip_control_buff"))

	self.loader = AutoLoader.New()

	return
end

function AtelierBuffLayer:didEnter()
	self.buffItemTFs = CustomIndexLayer.Clone2Full(self._tf:Find("Items/List"), #self.buffItems)

	onButton(self, self._tf:Find("Top/Back"), function()
		self:onBackPressed()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("Top/Home"), function()
		self:quickExitFunc()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("Top/Help"), function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.ryza_control_help_tip.tip
		})

		return
	end, SFX_PANEL)
	table.Foreach(self.slotTfs, function(arg_11_0, arg_11_1)
		onButton(self, arg_11_1, function()
			self.contextData.selectIndex = arg_11_0

			self:UpdateView()

			return
		end, SFX_PANEL)

		return
	end)
	table.Foreach(self.buffItemTFs, function(arg_13_0, arg_13_1)
		onButton(self, arg_13_1, function()
			local var_14_0 = self.buffItems[arg_13_0]

			if not self.contextData.selectIndex then
				self:emit(AtelierMaterialDetailMediator.SHOW_DETAIL, self.buffItems[arg_13_0])

				return
			end

			local var_14_1 = self.activity:GetSlots()

			local function var_14_2(arg_15_0, arg_15_1)
				if arg_15_1 > var_14_0.count then
					pg.TipsMgr.GetInstance():ShowTips(i18n("ryza_tip_control_buff_not_obtain_tip"))

					return
				end

				local var_15_0 = Clone(var_14_1)

				var_15_0[self.contextData.selectIndex][1] = arg_15_0
				var_15_0[self.contextData.selectIndex][2] = arg_15_1

				self:emit(GAME.UPDATE_ATELIER_BUFF, var_15_0)

				return
			end

			if var_14_1[self.contextData.selectIndex][1] == self.buffItems[arg_13_0]:GetConfigID() then
				if var_14_1[self.contextData.selectIndex][2] < #self.buffItems[arg_13_0]:GetBuffs() then
					var_14_2(var_14_1[self.contextData.selectIndex][1], var_14_1[self.contextData.selectIndex][2] + 1)
				end

				return
			end

			if _.detect(var_14_1, function(arg_16_0)
				return arg_16_0[1] == var_14_0:GetConfigID()
			end) then
				return
			end

			var_14_2(self.buffItems[arg_13_0]:GetConfigID(), 1)

			return
		end, SFX_PANEL)

		return
	end)
	self:UpdateView()
	pg.UIMgr.GetInstance():OverlayPanel(self._tf)

	if PlayerPrefs.GetInt("first_enter_ryza_buff_" .. getProxy(PlayerProxy):getRawData().id, 0) == 0 then
		triggerButton(self._tf:Find("Top/Help"))
		PlayerPrefs.SetInt("first_enter_ryza_buff_" .. getProxy(PlayerProxy):getRawData().id, 1)
	end

	return
end

function AtelierBuffLayer:UpdateView()
	local var_17_0 = self.activity:GetSlots()
	local var_17_1 = _.all(var_17_0, function(arg_18_0)
		return arg_18_0[1] > 0
	end)

	setActive(self._tf:Find("Panel/Full"), var_17_1)

	self.slotFull = var_17_1

	table.Foreach(self.slotTfs, function(arg_19_0, arg_19_1)
		self:UpdateSlot(arg_19_1, arg_19_0)

		return
	end)

	local var_17_2 = self.contextData.selectIndex

	if self.contextData.selectIndex then
		var_17_2 = var_17_0[self.contextData.selectIndex]
	end

	table.Foreach(self.buffItems, function(arg_20_0, arg_20_1)
		local var_20_0 = self.buffItemTFs[arg_20_0]
		local var_20_1 = _.detect(var_17_0, function(arg_21_0)
			return arg_21_0[1] == arg_20_1:GetConfigID()
		end)
		local var_20_2 = #arg_20_1:GetBuffs()
		local var_20_3 = var_20_1 and var_20_2 <= var_20_1[2]
		local var_20_4 = arg_20_1.count == 0 or var_20_1 and var_20_2 > var_20_1[2] and var_20_1[2] == arg_20_1.count
		local var_20_5 = var_20_1 and table.indexof(var_17_0, var_20_1) == self.contextData.selectIndex
		local var_20_6 = var_17_2 and not var_20_3 and var_20_1 and not var_20_5
		local var_20_7 = var_17_2 and not var_20_1 and not var_20_4
		local var_20_8

		if not var_20_4 then
			var_20_8 = var_17_2

			if var_17_2 then
				if not var_20_7 or var_17_2[1] ~= 0 then
					if var_20_5 then
						::label_20_0::

						var_20_8 = var_20_2 > var_20_1[2]
					end
				end
			end
		end

		local var_20_9 = var_20_7 or var_20_8

		setActive(var_20_0:Find("Min"), false)

		if var_20_4 then
			setActive(var_20_0:Find("Min"), true)
			setText(var_20_0:Find("Min/Text"), i18n("ryza_tip_control_buff_not_obtain"))
		elseif var_20_6 then
			setActive(var_20_0:Find("Min"), true)
			setText(var_20_0:Find("Min/Text"), i18n("ryza_tip_control_buff_already_active_tip"))
		end

		setActive(var_20_0:Find("Avaliable"), var_20_9)

		if var_20_8 then
			setText(var_20_0:Find("Avaliable/Text"), i18n("ryza_tip_control_buff_upgrade"))
		elseif var_20_7 then
			setText(var_20_0:Find("Avaliable/Text"), i18n("ryza_tip_control_buff_replace"))
		end

		setActive(var_20_0:Find("Max"), var_20_3)
		setScrollText(var_20_0:Find("Name/Text"), arg_20_1:GetName())

		local var_20_10 = arg_20_1.count

		if var_20_1 then
			var_20_10 = var_20_10 - var_20_1[2]
		end

		updateDrop(var_20_0:Find("Icon"), {
			type = DROP_TYPE_RYZA_DROP,
			id = arg_20_1:GetConfigID(),
			count = var_20_10
		})

		return
	end)

	local var_17_3 = _.map(var_17_0, function(arg_22_0)
		if arg_22_0[1] == 0 or arg_22_0[2] == 0 then
			return
		end

		local var_22_0 = self.activity:GetItems()[arg_22_0[1]]

		assert(var_22_0)

		var_22_0 = var_22_0 or AtelierMaterial.New({
			configId = arg_22_0[1]
		})

		local var_22_1 = var_22_0:GetBuffs()
		local var_22_2

		if not var_22_1 then
			do return end

			var_22_2 = {}
		end

		var_22_2.id = var_22_1[math.min(#var_22_1, arg_22_0[2])]

		local var_22_3 = CommonBuff.New(var_22_2)

		return "【" .. var_22_3:getConfig("name") .. "】:" .. var_22_3:getConfig("desc")
	end)

	for iter_17_0, iter_17_1 in ipairs((CustomIndexLayer.Clone2Full(self.effectList, #var_17_3))) do
		setText(iter_17_1, var_17_3[iter_17_0])
	end

	return
end

function AtelierBuffLayer:PlayFullEffect()
	self:LoadingOn()

	return
end

function AtelierBuffLayer:UpdateSlot(arg_24_1, arg_24_2)
	local var_24_0 = self.activity:GetSlots()[arg_24_2]
	local var_24_1 = var_24_0[1]
	local var_24_2 = var_24_0[2]
	local var_24_3 = self.contextData.selectIndex == arg_24_2
	local var_24_4 = var_24_0[1] > 0 or var_24_3

	setActive(arg_24_1:Find("Avaliable"), var_24_0[1] > 0 or var_24_3)
	setActive(arg_24_1:Find("Link"), var_24_4)
	setActive(arg_24_1:Find("LinkActive"), var_24_3)
	setActive(arg_24_1:Find("Diamond"), var_24_1 > 0)

	local var_24_5 = false

	if var_24_4 then
		setActive(arg_24_1:Find("Avaliable/Selecting"), var_24_3)
		setActive(arg_24_1:Find("Avaliable/Item"), var_24_1 > 0)
		setActive(arg_24_1:Find("Avaliable/Image"), var_24_1 == 0)

		if var_24_1 > 0 then
			local var_24_6 = AtelierMaterial.New({
				configId = var_24_1
			})

			if #var_24_6:GetBuffs() ~= var_24_2 then
				var_24_5 = false
			end

			local var_24_7

			do
				var_24_5 = true
				var_24_7 = {}
			end

			var_24_7.id = var_24_6:GetBuffs()[math.min(#var_24_6:GetBuffs(), var_24_2)]

			local var_24_8 = CommonBuff.New(var_24_7)

			self.loader:GetSpriteQuiet(var_24_8:getConfig("icon"), "", arg_24_1:Find("Avaliable/Item/Image"))
			setText(arg_24_1:Find("Avaliable/Item/Name/Text"), var_24_8:getConfig("name"))
		end
	end

	setActive(arg_24_1:Find("Link/3"), var_24_5)
	setActive(arg_24_1:Find("Link/1"), not var_24_5 and var_24_2 > 0)

	return
end

function AtelierBuffLayer:OnUpdateAtelierBuff()
	self:UpdateView()
	self:PlayLevelUpAnim()

	return
end

function AtelierBuffLayer:PlayLevelUpAnim()
	self:CleanTween()

	local var_26_0 = self.slotTfs[self.contextData.selectIndex]:Find("Avaliable/LevelUp/Image")

	setActive(var_26_0.parent, true)

	local var_26_1 = var_26_0.anchoredPosition.y

	setImageAlpha(var_26_0, 0)

	self.tweenId = LeanTween.value(go(self.slotTfs[self.contextData.selectIndex]), 0, 2, 2):setOnUpdate(System.Action_float(function(arg_27_0)
		arg_27_0 = math.clamp(arg_27_0, 0, 1)

		setImageAlpha(var_26_0, arg_27_0)
		setAnchoredPosition(var_26_0, {
			y = var_26_1 + 20 * (arg_27_0 - 1)
		})

		return
	end)):setOnComplete(System.Action(function()
		setAnchoredPosition(var_26_0, {
			y = var_26_1
		})
		setActive(var_26_0.parent, false)

		return
	end)).id

	return
end

function AtelierBuffLayer:CleanTween()
	if not self.tweenId then
		return
	end

	LeanTween.cancel(self.tweenId, true)

	return
end

function AtelierBuffLayer:LoadingOn()
	if self.animating then
		return
	end

	self.animating = true

	pg.UIMgr.GetInstance():LoadingOn(false)

	return
end

function AtelierBuffLayer:LoadingOff()
	if not self.animating then
		return
	end

	pg.UIMgr.GetInstance():LoadingOff()

	self.animating = false

	return
end

function AtelierBuffLayer:willExit()
	self.loader:Clear()
	self:CleanTween()
	self:LoadingOff()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return AtelierBuffLayer
