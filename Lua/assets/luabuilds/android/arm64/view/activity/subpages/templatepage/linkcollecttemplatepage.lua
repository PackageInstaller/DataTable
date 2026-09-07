local LinkCollectTemplatePage = class("LinkCollectTemplatePage", import("view.base.BaseActivityPage"))

LinkCollectTemplatePage.DropType2Name = {
	[DROP_TYPE_EQUIP] = "equip",
	[DROP_TYPE_FURNITURE] = "furniture",
	[DROP_TYPE_EQUIPMENT_SKIN] = "equip_skin",
	[DROP_TYPE_SPWEAPON] = "special_weapon"
}

function LinkCollectTemplatePage:OnInit()
	self.bg = self._tf:Find("AD")
	self.btnList = self.bg:Find("btn_list")
	self.itemPanel = self.bg:Find("item_panel")
	self.togglesTF = self.itemPanel:Find("toggles")
	self.content = self.itemPanel:Find("item_list/content")
	self.itemList = UIItemList.New(self.content, self.content:Find("tpl"))

	setText(self.content:Find("tpl/owner/title"), i18n("collect_page_got"))

	return
end

function LinkCollectTemplatePage:OnDataSetting()
	self.guideConfig = pg.activity_limit_item_guide

	self:BuildDatas()

	return
end

function LinkCollectTemplatePage:BuildDatas()
	self.dataList = {}

	for iter_3_0, iter_3_1 in ipairs(pg.activity_limit_item_guide.get_id_list_by_activity[self.activity.id] or {}) do
		local var_3_1 = {
			id = iter_3_1
		}

		var_3_1.config = self.guideConfig[var_3_1.id]
		var_3_1.count = self.activity:getKVPList(1, var_3_1.id)

		if var_3_1.config.count_storage == 1 then
			var_3_1.count = Drop.New({
				type = var_3_1.config.type,
				id = var_3_1.config.drop_id
			}):getOwnedCount()
		end

		table.insert(self.dataList, var_3_1)
	end

	return
end

function LinkCollectTemplatePage:GetTogglesDropTypes()
	return {
		DROP_TYPE_EQUIP,
		DROP_TYPE_FURNITURE,
		DROP_TYPE_EQUIPMENT_SKIN,
		DROP_TYPE_SPWEAPON
	}
end

function LinkCollectTemplatePage:OnFirstFlush()
	self.itemList:make(function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 == UIItemList.EventUpdate then
			self:OnUpdateItem(arg_6_1, arg_6_2)
		end

		return
	end)
	self:AddTogglesListener()
	self:AddSpecialBtnListener()

	self.curPage = self.curPage or self:GetTogglesDropTypes()[1]

	triggerToggle(self.toggles[self.curPage], true)

	return
end

function LinkCollectTemplatePage:OnUpdateFlush()
	self:BuildDatas()
	self:UpdatePage(self.curPage)

	return
end

function LinkCollectTemplatePage:AddTogglesListener()
	self.toggles = {}

	local var_8_0 = self:GetTogglesDropTypes()

	assert(#var_8_0 == self.togglesTF.childCount, "dropType数量与togglesTF子节点数不匹配")

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_1 = self.togglesTF:Find(LinkCollectTemplatePage.DropType2Name[iter_8_1])

		onToggle(self, var_8_1, function(arg_9_0)
			if arg_9_0 then
				self:UpdatePage(iter_8_1)
			end

			return
		end, SFX_PANEL)

		self.toggles[iter_8_1] = var_8_1
	end

	return
end

function LinkCollectTemplatePage:AddSpecialBtnListener()
	local var_10_0 = self.activity:getConfig("config_client")

	self.furnitureThemeBtn = self.btnList:Find("furniture_theme")

	if self.furnitureThemeBtn and var_10_0.furniture_theme_link then
		onButton(self, self.furnitureThemeBtn, function()
			self:DoSkip(var_10_0.furniture_theme_link[1], var_10_0.furniture_theme_link[2])

			return
		end, SFX_PANEL)
	end

	self.medalBtn = self.btnList:Find("medal")

	if self.medalBtn and var_10_0.medal_link then
		onButton(self, self.medalBtn, function()
			self:DoSkip(var_10_0.medal_link[1], var_10_0.medal_link[2])

			return
		end, SFX_PANEL)
	end

	self.equipSkinBoxBtn = self.btnList:Find("equip_skin_box")

	if self.equipSkinBoxBtn and var_10_0.equipskin_box_link then
		local var_10_1 = Drop.New({
			type = var_10_0.equipskin_box_link.drop_type,
			id = var_10_0.equipskin_box_link.drop_id
		}):getOwnedCount()

		onButton(self, self.equipSkinBoxBtn, function()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				type = MSGBOX_TYPE_LIKN_COLLECT_GUIDE,
				show_type = Msgbox4LinkCollectGuide.SHOW_TYPE_NORMAL,
				drop_type = var_10_0.equipskin_box_link.drop_type,
				drop_id = var_10_0.equipskin_box_link.drop_id,
				count = var_10_1,
				skipable_list = var_10_0.equipskin_box_link.list
			})

			return
		end, SFX_PANEL)
	end

	return
end

function LinkCollectTemplatePage:OnUpdateItem(arg_14_1, arg_14_2)
	local var_14_0 = self.showDataList[arg_14_1 + 1]
	local var_14_1 = arg_14_2:Find("icon_mask/icon")

	updateDrop(var_14_1, {
		type = self.showDataList[arg_14_1 + 1].config.type,
		id = self.showDataList[arg_14_1 + 1].config.drop_id
	})
	onButton(self, var_14_1, function()
		self:OnClickItem(var_14_0)

		return
	end, SFX_PANEL)
	changeToScrollText(arg_14_2:Find("name_mask/name"), Drop.New({
		type = var_14_0.config.type,
		id = var_14_0.config.drop_id
	}):getName())
	setText(arg_14_2:Find("owner/number"), var_14_0.count .. "/" .. var_14_0.config.count)

	GetOrAddComponent(arg_14_2:Find("owner"), typeof(CanvasGroup)).alpha = var_14_0.count == var_14_0.config.count and 0.5 or 1

	setActive(arg_14_2:Find("got"), var_14_0.count == var_14_0.config.count)
	setActive(arg_14_2:Find("new"), var_14_0.config.is_new == "1")

	return
end

function LinkCollectTemplatePage:OnClickItem(arg_16_1)
	pg.MsgboxMgr.GetInstance():ShowMsgBox({
		type = MSGBOX_TYPE_LIKN_COLLECT_GUIDE,
		show_type = Msgbox4LinkCollectGuide.SHOW_TYPE_LIMIT,
		drop_type = arg_16_1.config.type,
		drop_id = arg_16_1.config.drop_id,
		count = arg_16_1.count,
		count_limit = arg_16_1.config.count,
		skipable_list = arg_16_1.config.link_params
	})

	return
end

function LinkCollectTemplatePage:UpdatePage(arg_17_1)
	self.curPage = arg_17_1
	self.showDataList = {}

	for iter_17_0, iter_17_1 in ipairs(self.dataList) do
		if self.guideConfig[iter_17_1.id].type == arg_17_1 then
			table.insert(self.showDataList, iter_17_1)
		end
	end

	table.sort(self.showDataList, CompareFuncs({
		function(arg_18_0)
			return arg_18_0.count < arg_18_0.config.count and 0 or 1
		end,
		function(arg_19_0)
			return arg_19_0.config.order
		end,
		function(arg_20_0)
			return arg_20_0.id
		end
	}))
	self.itemList:align(#self.showDataList)

	return
end

function LinkCollectTemplatePage:DoSkip(arg_21_1, arg_21_2)
	if arg_21_1 == 2 then
		pg.m02:sendNotification(GAME.GO_SCENE, arg_21_2[1], arg_21_2[2] or {})
	elseif arg_21_1 == 3 then
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = arg_21_2
		})
	end

	return
end

return LinkCollectTemplatePage
