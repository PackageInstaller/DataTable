local CoreAwardTemplatePage = class("CoreAwardTemplatePage", import("view.activity.CorePage.CoreActivityPage"))

CoreAwardTemplatePage.DropType2Name = {
	[DROP_TYPE_EQUIP] = "equip",
	[DROP_TYPE_FURNITURE] = "furniture",
	[DROP_TYPE_EQUIPMENT_SKIN] = "equip_skin",
	[DROP_TYPE_SPWEAPON] = "special_weapon"
}

function CoreAwardTemplatePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.btnList = self.bg:Find("btn_list")
	self.itemPanel = self.bg:Find("item_panel")
	self.togglesTF = self.itemPanel:Find("toggles")
	self.content = self.itemPanel:Find("item_list/content")
	self.itemList = UIItemList.New(self.content, self.content:Find("tpl"))

	setText(self.content:Find("tpl/owner/title"), i18n("collect_page_got"))

	self.boxTF = self._tf:Find("Box")
	self.boxBG = self.boxTF:Find("BG")
	self.panel = self.boxTF:Find("Panel")
	self.infoTF = self.panel:Find("Info")
	self.boxCloseBtn = self.infoTF:Find("CloseBtn")
	self.Title = self.infoTF:Find("Title")
	self.boxIconTF = self.infoTF:Find("Icon/Mask/IconTpl")
	self.boxNameText = self.infoTF:Find("NameText")
	self.boxNumTF = self.infoTF:Find("Num")
	self.boxNumTip = self.boxNumTF:Find("Text")
	self.boxNumText = self.boxNumTF:Find("NumText")
	self.boxDescText = self.infoTF:Find("DescText")
	self.boxSrcText = self.infoTF:Find("SrcText")
	self.boxSrcContent = self.panel:Find("Content")
	self.boxSrcTpl = self.boxSrcContent:Find("SrcTpl")

	onButton(self, self.boxBG, function()
		self:showBoxPanel(false)

		return
	end, SFX_PANEL)
	onButton(self, self.boxCloseBtn, function()
		self:showBoxPanel(false)

		return
	end, SFX_PANEL)

	return
end

function CoreAwardTemplatePage:OnDataSetting()
	self.guideConfig = pg.activity_limit_item_guide

	self:BuildDatas()

	return
end

function CoreAwardTemplatePage:BuildDatas()
	self.dataList = {}

	for iter_5_0, iter_5_1 in ipairs(pg.activity_limit_item_guide.get_id_list_by_activity[self.activity.id] or {}) do
		local var_5_1 = {
			id = iter_5_1
		}

		var_5_1.config = self.guideConfig[var_5_1.id]
		var_5_1.count = self.activity:getKVPList(1, var_5_1.id)

		if var_5_1.config.count_storage == 1 then
			var_5_1.count = Drop.New({
				type = var_5_1.config.type,
				id = var_5_1.config.drop_id
			}):getOwnedCount()
		end

		table.insert(self.dataList, var_5_1)
	end

	return
end

function CoreAwardTemplatePage:GetTogglesDropTypes()
	return {
		DROP_TYPE_EQUIP,
		DROP_TYPE_FURNITURE,
		DROP_TYPE_EQUIPMENT_SKIN,
		DROP_TYPE_SPWEAPON
	}
end

function CoreAwardTemplatePage:OnFirstFlush()
	self.itemList:make(function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 == UIItemList.EventUpdate then
			self:OnUpdateItem(arg_8_1, arg_8_2)
		end

		return
	end)
	self:AddTogglesListener()
	self:AddSpecialBtnListener()

	self.curPage = self.curPage or self:GetTogglesDropTypes()[1]

	triggerToggle(self.toggles[self.curPage], true)

	return
end

function CoreAwardTemplatePage:OnUpdateFlush()
	self:BuildDatas()
	self:UpdatePage(self.curPage)

	return
end

function CoreAwardTemplatePage:AddTogglesListener()
	self.toggles = {}

	local var_10_0 = self:GetTogglesDropTypes()

	assert(#var_10_0 == self.togglesTF.childCount, "dropType数量与togglesTF子节点数不匹配")

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = self.togglesTF:Find(CoreAwardTemplatePage.DropType2Name[iter_10_1])

		onToggle(self, var_10_1, function(arg_11_0)
			if arg_11_0 then
				self:UpdatePage(iter_10_1)
			end

			return
		end, SFX_PANEL)

		self.toggles[iter_10_1] = var_10_1
	end

	return
end

function CoreAwardTemplatePage:AddSpecialBtnListener()
	local var_12_0 = self.activity:getConfig("config_client")

	self.furnitureThemeBtn = self.btnList:Find("furniture_theme")

	if self.furnitureThemeBtn and var_12_0.furniture_theme_link then
		onButton(self, self.furnitureThemeBtn, function()
			self:DoSkip(var_12_0.furniture_theme_link[1], var_12_0.furniture_theme_link[2])

			return
		end, SFX_PANEL)
	end

	self.medalBtn = self.btnList:Find("medal")

	if self.medalBtn and var_12_0.medal_link then
		onButton(self, self.medalBtn, function()
			self:DoSkip(var_12_0.medal_link[1], var_12_0.medal_link[2])

			return
		end, SFX_PANEL)
	end

	self.equipSkinBoxBtn = self.btnList:Find("equip_skin_box")

	if self.equipSkinBoxBtn and var_12_0.equipskin_box_link then
		local var_12_1 = Drop.New({
			type = var_12_0.equipskin_box_link.drop_type,
			id = var_12_0.equipskin_box_link.drop_id
		}):getOwnedCount()

		onButton(self, self.equipSkinBoxBtn, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_LIKN_COLLECT_GUIDE,
				show_type = Msgbox4LinkCollectGuide.SHOW_TYPE_NORMAL,
				drop_type = var_12_0.equipskin_box_link.drop_type,
				drop_id = var_12_0.equipskin_box_link.drop_id,
				count = var_12_1,
				skipable_list = var_12_0.equipskin_box_link.list
			})

			return
		end, SFX_PANEL)
	end

	return
end

function CoreAwardTemplatePage:OnUpdateItem(arg_16_1, arg_16_2)
	local var_16_0 = self.showDataList[arg_16_1 + 1]
	local var_16_1 = arg_16_2:Find("icon_mask/icon")

	updateDrop(var_16_1, {
		type = self.showDataList[arg_16_1 + 1].config.type,
		id = self.showDataList[arg_16_1 + 1].config.drop_id
	})
	onButton(self, var_16_1, function()
		self:OnClickItem(var_16_0)

		return
	end, SFX_PANEL)
	changeToScrollText(arg_16_2:Find("name_mask/name"), Drop.New({
		type = var_16_0.config.type,
		id = var_16_0.config.drop_id
	}):getName())
	self:RefreshCountText(var_16_0, arg_16_2)

	GetOrAddComponent(arg_16_2:Find("owner"), typeof(CanvasGroup)).alpha = var_16_0.count == var_16_0.config.count and 0.5 or 1

	setActive(arg_16_2:Find("got"), var_16_0.count == var_16_0.config.count)
	setActive(arg_16_2:Find("new"), var_16_0.config.is_new == "1")

	return
end

function CoreAwardTemplatePage:RefreshCountText(arg_18_1, arg_18_2)
	setText(arg_18_2:Find("owner/number"), arg_18_1.count .. "/" .. arg_18_1.config.count)

	return
end

function CoreAwardTemplatePage:OnClickItem(arg_19_1)
	self:updateBoxPanel({
		type = MSGBOX_TYPE_LIKN_COLLECT_GUIDE,
		show_type = Msgbox4LinkCollectGuide.SHOW_TYPE_LIMIT,
		drop_type = arg_19_1.config.type,
		drop_id = arg_19_1.config.drop_id,
		count = arg_19_1.count,
		count_limit = arg_19_1.config.count,
		skipable_list = arg_19_1.config.link_params
	})
	self:showBoxPanel(true)

	return
end

function CoreAwardTemplatePage:UpdatePage(arg_20_1)
	self.curPage = arg_20_1
	self.showDataList = {}

	for iter_20_0, iter_20_1 in ipairs(self.dataList) do
		if self.guideConfig[iter_20_1.id].type == arg_20_1 then
			table.insert(self.showDataList, iter_20_1)
		end
	end

	table.sort(self.showDataList, CompareFuncs({
		function(arg_21_0)
			return arg_21_0.count < arg_21_0.config.count and 0 or 1
		end,
		function(arg_22_0)
			return arg_22_0.config.order
		end,
		function(arg_23_0)
			return arg_23_0.id
		end
	}))
	self.itemList:align(#self.showDataList)

	return
end

function CoreAwardTemplatePage:updateBoxPanel(arg_24_1)
	local var_24_0 = Drop.New({
		type = arg_24_1.drop_type,
		id = arg_24_1.drop_id
	})

	updateDrop(self.boxIconTF, var_24_0)
	changeToScrollText(self.boxNameText, var_24_0.cfg.name)
	setText(self.boxDescText, SwitchSpecialChar(var_24_0.desc))
	setText(self.boxNumTip, i18n("collect_page_got"))

	if arg_24_1.show_type == Msgbox4LinkCollectGuide.SHOW_TYPE_NORMAL then
		setText(self.boxNumText, arg_24_1.count)
	elseif arg_24_1.show_type == Msgbox4LinkCollectGuide.SHOW_TYPE_LIMIT then
		setText(self.boxNumText, string.format("%s<color=#735d54>/%s</color>", arg_24_1.count, arg_24_1.count_limit or 0))
	end

	UIItemList.StaticAlign(self.boxSrcContent, self.boxSrcTpl, #arg_24_1.skipable_list, function(arg_25_0, arg_25_1, arg_25_2)
		if arg_25_0 == UIItemList.EventUpdate then
			local var_25_0 = arg_24_1.skipable_list[arg_25_1 + 1][1]
			local var_25_1 = arg_24_1.skipable_list[arg_25_1 + 1][2]

			changeToScrollText(arg_25_2:Find("SrcText"), arg_24_1.skipable_list[arg_25_1 + 1][3])

			local var_25_2 = arg_25_2:Find("GoBtn")

			setText(var_25_2:Find("go"), i18n("brs_reward_tip_2"))
			onButton(self, var_25_2, function()
				self:DoSkip(var_25_0, var_25_1)
				self:showBoxPanel(false)

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function CoreAwardTemplatePage:showBoxPanel(arg_27_1)
	setActive(self.boxTF, arg_27_1)

	if arg_27_1 == true then
		pg.UIMgr.GetInstance():BlurPanel(self.boxTF)
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(self.boxTF)
	end

	return
end

function CoreAwardTemplatePage:DoSkip(arg_28_1, arg_28_2)
	if arg_28_1 == Msgbox4LinkCollectGuide.SKIP_TYPE_SCENE then
		pg.m02:sendNotification(GAME.GO_SCENE, arg_28_2[1], arg_28_2[2] or {})
	elseif arg_28_1 == Msgbox4LinkCollectGuide.SKIP_TYPE_SCENE then
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = arg_28_2
		})
	end

	return
end

return CoreAwardTemplatePage
