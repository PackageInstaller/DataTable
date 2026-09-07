pg = pg or {}

local var_0_0 = pg
local var_0_1 = singletonClass("NewStyleMsgboxMgr")

pg.NewStyleMsgboxMgr = var_0_1
var_0_1.TYPE_MSGBOX = 1
var_0_1.TYPE_DROP = 2
var_0_1.TYPE_DROP_CLIENT = 3
var_0_1.TYPE_COMMON_MSGBOX = 4
var_0_1.TYPE_COMMON_HELP = 5
var_0_1.TYPE_COMMON_DROP = 6
var_0_1.TYPE_COMMON_ITEMS = 7
var_0_1.TYPE_SHIP_PREVIEW = 8
var_0_1.TYPE_COMMON_SHOPPING = 9
var_0_1.TYPE_LOVE_LETTER_LEVEL_REWARD = 10
var_0_1.UI_NAME_DIC = {
	[var_0_1.TYPE_MSGBOX] = "DormStyleMsgboxUI",
	[var_0_1.TYPE_DROP] = "DormStyleDropMsgboxUI",
	[var_0_1.TYPE_DROP_CLIENT] = "DormStyleDropMsgboxUI",
	[var_0_1.TYPE_COMMON_MSGBOX] = "NewStyleMsgboxUI",
	[var_0_1.TYPE_COMMON_HELP] = "NewStyleHelpMsgboxUI",
	[var_0_1.TYPE_COMMON_DROP] = "NewStyleDropMsgboxUI",
	[var_0_1.TYPE_COMMON_ITEMS] = "NewStyleItemsMsgboxUI",
	[var_0_1.TYPE_SHIP_PREVIEW] = "ShipPreviewUI",
	[var_0_1.TYPE_COMMON_SHOPPING] = "NewStyleShoppingMsgboxUI",
	[var_0_1.TYPE_LOVE_LETTER_LEVEL_REWARD] = "NewStyleLoveLetterRewardMsgboxUI"
}
var_0_1.BUTTON_TYPE = {
	blue = "btn_confirm",
	shopping = "btn_shopping",
	gray = "btn_cancel",
	confirm = "btn_confirm",
	cancel = "btn_cancel"
}
var_0_1.RES_LIST = {
	diamond = {
		"ui/commonui_atlas",
		"res_diamond"
	},
	gold = {
		"ui/commonui_atlas",
		"res_gold"
	},
	res_oil = {
		"ui/commonui_atlas",
		"res_oil"
	},
	guildicon = {
		"ui/share/msgbox_atlas",
		"res_guildicon"
	},
	world_money = {
		"ui/share/world_common_atlas",
		"res_Whuobi"
	},
	port_money = {
		"ui/share/world_common_atlas",
		"res_Wzhaungbeibi"
	},
	world_boss = {
		"props/100000",
		""
	}
}
var_0_1.COLOR_MAP = {
	["#[Ff][Ff][Dd][Ee]38"] = "#ffa944",
	["#92[Ff][Cc]63"] = "#238c40",
	["#6[Dd][Dd]329"] = "#238c40"
}

function var_0_1.Init(arg_1_0, arg_1_1)
	print("initializing new style msgbox manager...")

	arg_1_0.showList = {}
	arg_1_0.rtDic = {}
	arg_1_0.richTextSprites = {}

	local var_1_0 = {}

	for iter_1_0, iter_1_1 in pairs(var_0_1.RES_LIST) do
		table.insert(var_1_0, function(arg_2_0)
			LoadSpriteAtlasAsync(iter_1_1[1], iter_1_1[2], function(arg_3_0)
				arg_1_0.richTextSprites[iter_1_0] = arg_3_0

				arg_2_0()

				return
			end)

			return
		end)
	end

	seriesAsync(var_1_0, function()
		existCall(arg_1_1)

		return
	end)

	return
end

function var_0_1:Show(...)
	table.insert(self.showList, packEx(...))

	if #self.showList == 1 then
		self:DoShow(unpackEx(self.showList[1]))
	end

	return
end

function var_0_1:DeepShow(...)
	if #self.showList == 0 then
		self:Show(...)
	else
		table.insert(self.showList, 1, packEx(...))
		self:Hide(true)
	end

	return
end

function var_0_1:DoShow(arg_7_1, arg_7_2)
	local var_7_0 = {}

	if not self.rtDic[arg_7_1] then
		table.insert(var_7_0, function(arg_8_0)
			var_0_0.UIMgr.GetInstance():LoadingOn()
			PoolMgr.GetInstance():GetUI(var_0_1.UI_NAME_DIC[arg_7_1], true, function(arg_9_0)
				setParent(arg_9_0, var_0_0.UIMgr.GetInstance().OverlayMain, false)

				self.rtDic[arg_7_1] = arg_9_0.transform

				var_0_0.UIMgr.GetInstance():LoadingOff()
				arg_8_0()

				return
			end)

			return
		end)
	end

	seriesAsync(var_7_0, function()
		self._tf = self.rtDic[arg_7_1]

		if arg_7_1 == var_0_1.TYPE_SHIP_PREVIEW then
			var_0_0.DelegateInfo.New(self)
		else
			self:CommonSetting(arg_7_2)
		end

		self:DisplaySetting(arg_7_1, arg_7_2)
		var_0_0.UIMgr.GetInstance():BlurPanel(self._tf)
		setActive(self._tf, true)

		return
	end)

	return
end

function var_0_1:Hide(arg_11_1)
	if self.previewer then
		self.previewer:Destroy()

		self.previewer = nil

		return
	end

	if not self._tf then
		return
	end

	setActive(self._tf, false)
	self:Clear()
	var_0_0.UIMgr.GetInstance():UnOverlayPanel(self._tf, var_0_0.UIMgr.GetInstance().OverlayMain)

	self._tf = nil

	if not arg_11_1 then
		table.remove(self.showList, 1)
	end

	if #self.showList > 0 then
		self:DoShow(unpackEx(self.showList[1]))
	end

	return
end

function var_0_1:CommonSetting(arg_12_1)
	var_0_0.DelegateInfo.New(self)
	setText(self._tf:Find("window/top/title"), arg_12_1.title or i18n("words_information"))

	function self.hideCall()
		self.hideCall = nil

		existCall(arg_12_1.onClose)

		return
	end

	onButton(self, self._tf:Find("bg"), function()
		existCall(self.hideCall)
		self:Hide()

		return
	end, SFX_CANCEL)
	onButton(self, self._tf:Find("window/top/btn_close"), function()
		existCall(self.hideCall)
		self:Hide()

		return
	end, SFX_CANCEL)

	function self.confirmCall()
		self.confirmCall = nil

		existCall(arg_12_1.onConfirm)

		return
	end

	local var_12_0 = arg_12_1.btnList or {
		{
			type = var_0_1.BUTTON_TYPE.cancel,
			name = i18n("msgbox_text_cancel"),
			func = function()
				existCall(self.hideCall)

				return
			end,
			sound = SFX_CANCEL
		},
		{
			type = var_0_1.BUTTON_TYPE.confirm,
			name = i18n("msgbox_text_confirm"),
			func = function()
				existCall(self.confirmCall)

				return
			end,
			sound = SFX_CONFIRM
		}
	}
	local var_12_1 = self._tf:Find("window/bottom/button_container")

	eachChild(var_12_1, function(arg_19_0)
		setActive(arg_19_0, false)

		return
	end)

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_2 = var_12_1:Find(iter_12_1.type)

		if var_12_2:GetSiblingIndex() < var_12_1.childCount - iter_12_0 + 1 then
			var_12_2:SetAsLastSibling()
			setActive(var_12_2, true)
		else
			var_12_2 = cloneTplTo(var_12_2, var_12_1, var_12_2.name)
		end

		setText(var_12_2:Find("Text"), iter_12_1.name)
		onButton(self, var_12_2, function()
			existCall(iter_12_1.func)
			self:Hide()

			return
		end, iter_12_1.sound or SFX_CONFIRM)
	end

	return
end

function var_0_1.Clear(arg_21_0)
	var_0_0.DelegateInfo.Dispose(arg_21_0)

	arg_21_0.hideCall = nil
	arg_21_0.confirmCall = nil

	return
end

function var_0_1.DisplaySetting(arg_22_0, arg_22_1, arg_22_2)
	switch(arg_22_1, {
		[var_0_1.TYPE_MSGBOX] = function(arg_23_0)
			setText(arg_22_0._tf:Find("window/middle/content"), arg_23_0.contentText)

			return
		end,
		[var_0_1.TYPE_DROP] = function(arg_24_0)
			local var_24_0 = arg_22_0._tf:Find("window/middle")

			updateCustomDrop(var_24_0:Find("Dorm3dIconTpl"), arg_24_0.drop, {
				style = arg_24_0.style
			})
			setText(var_24_0:Find("info/name"), arg_24_0.drop:getName())
			setText(var_24_0:Find("info/scroll/desc"), cancelColorRich(arg_24_0.drop.desc))

			local var_24_1, var_24_2 = arg_24_0.drop:getOwnedCount()

			setActive(var_24_0:Find("info/count"), var_24_2)

			if var_24_2 then
				setText(var_24_0:Find("info/count"), i18n("dorm3d_item_num") .. string.format("<color=#39bfff>%d</color>", var_24_1))
			end

			return
		end,
		[var_0_1.TYPE_DROP_CLIENT] = function(arg_25_0)
			local var_25_0 = arg_22_0._tf:Find("window/middle")

			Dorm3dIconHelper.UpdateDorm3dIcon(var_25_0:Find("Dorm3dIconTpl"), arg_25_0.data)
			setActive(var_25_0:Find("info/count"), false)
			setActive(var_25_0:Find("Dorm3dIconTpl/count"), false)

			local var_25_1 = Dorm3dIconHelper.Data2Config(arg_25_0.data)

			setText(var_25_0:Find("info/name"), var_25_1.name)
			setText(var_25_0:Find("info/scroll/desc"), var_25_1.desc)

			return
		end,
		[var_0_1.TYPE_COMMON_MSGBOX] = function(arg_26_0)
			local var_26_0 = arg_22_0._tf:Find("window/middle/content")

			arg_22_0:InitRichText(var_26_0)
			setTextInNewStyleBox(var_26_0, arg_26_0.contentText)

			return
		end,
		[var_0_1.TYPE_COMMON_HELP] = function(arg_27_0)
			setActive(arg_22_0._tf:Find("window/bottom"), false)

			local var_27_0 = arg_22_0._tf:Find("window/middle/content")
			local var_27_1 = UIItemList.New(var_27_0, var_27_0:Find("tpl"))

			var_27_1:make(function(arg_28_0, arg_28_1, arg_28_2)
				arg_28_1 = arg_28_1 + 1

				if arg_28_0 == UIItemList.EventUpdate then
					setActive(arg_28_2:Find("line"), arg_27_0.helps[arg_28_1].line)
					setTextInNewStyleBox(arg_28_2:Find("Text"), HXSet.hxLan(arg_27_0.helps[arg_28_1].info and SwitchSpecialChar(arg_27_0.helps[arg_28_1].info, true) or ""))
				end

				return
			end)
			var_27_1:align(#arg_27_0.helps)

			return
		end,
		[var_0_1.TYPE_COMMON_DROP] = function(arg_29_0)
			local var_29_0 = arg_29_0.drop
			local var_29_1 = arg_22_0._tf:Find("window/middle")

			updateDrop(var_29_1:Find("left/IconTpl"), arg_29_0.drop)
			setText(var_29_1:Find("info/name_container/name/Text"), arg_29_0.drop:getConfig("name"))

			local var_29_2 = var_29_1:Find("info/desc/Text")

			arg_22_0:InitRichText(var_29_2)
			arg_29_0.drop:MsgboxIntroSet(arg_29_0, var_29_2)
			setTextInNewStyleBox(var_29_2, var_29_2:GetComponent(typeof(Text)).text)
			UpdateOwnDisplay(var_29_1:Find("left/own"), arg_29_0.drop)
			setText(var_29_1:Find("left/detail/Text"), i18n("technology_detail"))
			RegisterNewStyleDetailButton(arg_22_0, var_29_1:Find("left/detail"), arg_29_0.drop)

			local var_29_3 = arg_29_0.drop.type == DROP_TYPE_SHIP
			local var_29_4 = var_29_1:Find("info/name_container/shiptype")
			local var_29_5 = var_29_1:Find("extra_info/ship")

			setActive(var_29_4, arg_29_0.drop.type == DROP_TYPE_SHIP)
			setActive(var_29_5, var_29_3)

			if var_29_3 then
				GetImageSpriteFromAtlasAsync("shiptype", shipType2print(arg_29_0.drop:getConfig("type")), var_29_4)

				local var_29_6 = tobool(getProxy(CollectionProxy):getShipGroup(var_0_0.ship_data_template[arg_29_0.drop.id].group_type))

				setActive(var_29_5:Find("unlock"), var_29_6)
				setText(var_29_5:Find("unlock/Text"), i18n("tag_ship_unlocked"))
				setActive(var_29_5:Find("lock"), not var_29_6)
				setText(var_29_5:Find("lock/Text"), i18n("tag_ship_locked"))
			end

			local var_29_7 = arg_29_0.drop.type == DROP_TYPE_EQUIPMENT_SKIN
			local var_29_8 = var_29_1:Find("extra_info/equip_skin")

			setActive(var_29_8, arg_29_0.drop.type == DROP_TYPE_EQUIPMENT_SKIN)
			setActive(var_29_1:Find("left/placeholder"), var_29_7)

			if var_29_7 then
				setTextInNewStyleBox(var_29_1:Find("info/desc/Text"), arg_29_0.drop:getConfig("desc"))

				local var_29_9 = var_0_0.equip_skin_template[arg_29_0.drop.id]

				setScrollText(var_29_8:Find("tag/mask/Text"), i18n("word_fit") .. ":" .. table.concat(underscore.map(var_0_0.equip_skin_template[arg_29_0.drop.id].equip_type, function(arg_30_0)
					return EquipType.Type2Name2(arg_30_0)
				end), ","))
				onButton(arg_22_0, var_29_8:Find("play"), function()
					local var_31_0 = var_0_0.NewStyleMsgboxMgr.TYPE_SHIP_PREVIEW
					local var_31_1 = {
						shipVO = Ship.New({
							id = var_29_9.ship_config_id,
							configId = var_29_9.ship_config_id,
							skin_id = var_29_9.ship_skin_id
						})
					}

					var_31_1.weaponIds = var_29_9.ship_skin_id == 0 and Clone(var_29_9.weapon_ids) or {}

					if var_29_9.ship_skin_id == 0 then
						var_31_1.equipSkinId = var_29_0.id or 0
					end

					arg_22_0:DeepShow(var_31_0, var_31_1)

					return
				end, SFX_PANEL)
			end

			local var_29_10 = arg_29_0.drop.type == DROP_TYPE_COMBAT_UI_STYLE
			local var_29_11 = var_29_1:Find("extra_info/combat_skin")

			setActive(var_29_11, arg_29_0.drop.type == DROP_TYPE_COMBAT_UI_STYLE)
			setActive(var_29_1:Find("left/placeholder"), var_29_10)

			if var_29_10 then
				local var_29_12 = var_0_0.item_data_battleui[arg_29_0.drop.id].rare_display
				local var_29_13 = UIItemList.New(var_29_1:Find("extra_info/combat_skin/elementList"), var_29_1:Find("extra_info/combat_skin/elementList/main"))

				var_29_13:make(function(arg_32_0, arg_32_1, arg_32_2)
					if arg_32_0 == UIItemList.EventUpdate then
						GetImageSpriteFromAtlasAsync("ui/combatskinrare", CombatSkinConst.TYPE_ICON_NAME[var_29_12[arg_32_1 + 1]], arg_32_2:Find("icon"), true)
						setScrollText(arg_32_2:Find("TextMask/Text"), i18n("battleui_display" .. var_29_12[arg_32_1 + 1]))
					end

					return
				end)
				var_29_13:align(#var_0_0.item_data_battleui[arg_29_0.drop.id].rare_display)
				onButton(arg_22_0, var_29_11:Find("play"), function()
					arg_22_0.previewer = CombatPreviewLayer.New(var_0_0.UIMgr.GetInstance().OverlayMain)

					arg_22_0.previewer:ExecuteAction("Show", var_29_0.id, function()
						arg_22_0.previewer:Destroy()

						arg_22_0.previewer = nil

						return
					end)

					return
				end, SFX_PANEL)
			end

			return
		end,
		[var_0_1.TYPE_COMMON_ITEMS] = function(arg_35_0)
			local var_35_0 = arg_22_0._tf:Find("window/middle")

			setActive(var_35_0:Find("info/Text"), arg_35_0.content)
			setTextInNewStyleBox(var_35_0:Find("info/Text"), arg_35_0.content or "")

			local var_35_1 = arg_35_0.items
			local var_35_2 = arg_35_0.itemFunc
			local var_35_3 = var_35_0:Find("scrollview/content")

			UIItemList.StaticAlign(var_35_3, var_35_3:Find("item"), #arg_35_0.items, function(arg_36_0, arg_36_1, arg_36_2)
				arg_36_1 = arg_36_1 + 1

				if arg_36_0 == UIItemList.EventUpdate then
					local var_36_0 = var_35_1[arg_36_1]

					updateDrop(arg_36_2:Find("IconTpl"), var_35_1[arg_36_1], {
						anonymous = var_35_1[arg_36_1].anonymous,
						hideName = var_35_1[arg_36_1].hideName
					})

					local var_36_1 = arg_36_2:Find("IconTpl/name")

					setText(var_36_1, shortenString(getText(var_36_1), 6))
					setActive(arg_36_2:Find("own"), arg_35_0.showOwn)

					if arg_35_0.showOwn then
						setText(arg_36_2:Find("own/Text"), i18n("equip_skin_detail_count") .. var_35_1[arg_36_1]:getOwnedCount())
					end

					onButton(arg_22_0, arg_36_2, function()
						if var_36_0.anonymous then
							return
						elseif var_35_2 then
							var_35_2(var_36_0)
						end

						return
					end, SFX_UI_CLICK)
				end

				return
			end)

			return
		end,
		[var_0_1.TYPE_SHIP_PREVIEW] = function(arg_38_0)
			local var_38_0 = arg_22_0._tf:Find("left_panel")
			local var_38_1 = var_38_0:Find("sea"):GetComponent("RawImage")

			setActive(var_38_1, false)

			local var_38_2 = GameObject.Find("BarrageCamera"):GetComponent("Camera")

			var_38_2.enabled = true
			var_38_2.targetTexture = var_38_1.texture

			local var_38_3 = arg_22_0._tf:Find("resources/heal")

			var_38_3.transform.localPosition = Vector3(-360, 50, 40)

			setActive(var_38_3, false)
			var_38_3:GetComponent("DftAniEvent"):SetEndEvent(function()
				setActive(var_38_3, false)
				setText(var_38_3:Find("text"), "")

				return
			end)

			local var_38_4 = var_38_0:Find("bg/loading")
			local var_38_5

			onButton(arg_22_0, var_38_4, function()
				if not var_38_5 then
					var_38_5 = WeaponPreviewer.New(var_38_1)

					var_38_5:configUI(var_38_3)
					var_38_5:setDisplayWeapon(arg_38_0.weaponIds, arg_38_0.equipSkinId, true)
					var_38_5:load(40000, arg_38_0.shipVO, arg_38_0.weaponIds, function()
						setActive(var_38_4, false)

						return
					end)
				end

				return
			end)
			setActive(var_38_4, true)
			onButton(arg_22_0, arg_22_0._tf, function()
				setActive(var_38_4, false)

				if var_38_5 then
					var_38_5:clear()

					var_38_5 = nil
				end

				arg_22_0:Hide()

				return
			end, SFX_PANEL)

			return
		end,
		[var_0_1.TYPE_COMMON_SHOPPING] = function(arg_43_0)
			local var_43_0 = arg_22_0._tf:Find("window/middle")

			updateDrop(var_43_0:Find("IconTpl"), arg_43_0.drop)
			setText(var_43_0:Find("info/name/Text"), arg_43_0.drop:getConfig("name"))
			setText(var_43_0:Find("IconTpl/own"), i18n("equip_skin_detail_count") .. arg_43_0.drop:getOwnedCount())

			local var_43_1 = var_43_0:Find("info/desc/Text")

			arg_22_0:InitRichText(var_43_1)

			local var_43_2 = arg_22_0._tf:Find("window/bottom/button_container/btn_shopping/price/Text")
			local var_43_3 = arg_22_0._tf:Find("window/bottom/count")
			local var_43_4 = PageUtil.New(var_43_3:Find("reduce"), var_43_3:Find("increase"), var_43_3:Find("max"), var_43_3:Find("Text"))
			local var_43_5 = arg_43_0.price
			local var_43_6 = arg_43_0.numUpdate
			local var_43_7 = arg_43_0.addNum or 1
			local var_43_8 = arg_43_0.maxNum or -1
			local var_43_9 = arg_43_0.defaultNum or 1

			var_43_4:setNumUpdate(function(arg_44_0)
				if var_43_6 ~= nil then
					var_43_6(var_43_1, arg_44_0)
				end

				setText(var_43_2, "x" .. arg_44_0 * var_43_5)

				return
			end)
			var_43_4:setAddNum(var_43_7)
			var_43_4:setMaxNum(var_43_8)
			var_43_4:setDefaultNum(var_43_9)

			return
		end,
		[var_0_1.TYPE_LOVE_LETTER_LEVEL_REWARD] = function(arg_45_0)
			setText(arg_22_0._tf:Find("window/top/title"), i18n("loveactivity_ui_20"))

			local var_45_0 = getProxy(LoveLetterProxy)
			local var_45_1 = var_45_0:GetAllLevel()
			local var_45_2 = underscore.first(var_0_0.lover_reward.all, var_45_0:GetAllLevelAwardDisplayIndex())
			local var_45_3 = var_45_0:GetAllLevelRewardMarkDic()
			local var_45_4 = arg_22_0._tf:Find("window/middle/view/content")

			UIItemList.StaticAlign(var_45_4, var_45_4:Find("tpl"), math.max(#var_45_2, 3), function(arg_46_0, arg_46_1, arg_46_2)
				arg_46_1 = arg_46_1 + 1

				if arg_46_0 == UIItemList.EventUpdate then
					local var_46_0 = var_45_2[arg_46_1]

					setActive(arg_46_2:Find("on"), var_45_2[arg_46_1])
					setActive(arg_46_2:Find("empty"), not var_46_0)

					if not var_46_0 then
						return
					end

					arg_46_2 = arg_46_2:Find("on")

					local var_46_1 = var_0_0.lover_reward[var_46_0]

					setActive(arg_46_2:Find("active_bg"), not var_45_3[var_46_0] and var_45_1 >= var_46_1.total_level)
					setActive(arg_46_2:Find("lock"), var_45_1 < var_46_1.total_level)
					setText(arg_46_2:Find("mark/Text"), var_46_1.total_level)

					local var_46_2 = underscore.map(var_46_1.show_reward, function(arg_47_0)
						return Drop.Create(arg_47_0)
					end)

					UIItemList.StaticAlign(arg_46_2:Find("awards"), arg_46_2:Find("awards/tpl"), #var_46_2, function(arg_48_0, arg_48_1, arg_48_2)
						arg_48_1 = arg_48_1 + 1

						if arg_46_0 == UIItemList.EventUpdate then
							local var_48_0 = var_46_2[arg_48_1]

							updateDrop(arg_48_2:Find("mask/IconTpl"), var_46_2[arg_48_1])
							onButton(arg_22_0, arg_48_2, function()
								arg_22_0:emit(BaseUI.ON_DROP, var_48_0)

								return
							end, SFX_PANEL)
							setActive(arg_48_2:Find("got"), var_45_3[var_46_0])
						end

						return
					end)
				end

				return
			end)

			local var_45_5 = var_45_0:GetAllLevelNextAwardIndex()

			if var_45_5 then
				scrollToIndex(var_45_4, var_45_5)
			else
				scrollToBottom(var_45_4)
			end

			return
		end
	}, nil, arg_22_2)

	return
end

function var_0_1:InitRichText(arg_50_1)
	local var_50_0 = arg_50_1:GetComponent("RichText")

	for iter_50_0, iter_50_1 in pairs(self.richTextSprites) do
		var_50_0:AddSprite(iter_50_0, iter_50_1)
	end

	return
end

function var_0_1:emit(arg_51_1, ...)
	self.analogyMediator = self.analogyMediator or {
		addSubLayers = function(arg_52_0, arg_52_1)
			local var_52_0 = {}

			var_52_0.parentContext = getProxy(ContextProxy):getCurrentContext()
			var_52_0.context = arg_52_1

			var_0_0.m02:sendNotification(GAME.LOAD_LAYERS, var_52_0)

			return
		end,
		sendNotification = function(arg_53_0, ...)
			var_0_0.m02:sendNotification(...)

			return
		end,
		viewComponent = self
	}

	return ContextMediator.CommonBindDic[arg_51_1](self.analogyMediator, arg_51_1, ...)
end

function var_0_1:closeView()
	self:hide()

	return
end

return var_0_1
