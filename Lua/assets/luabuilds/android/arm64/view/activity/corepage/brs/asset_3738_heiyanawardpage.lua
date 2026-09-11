local HeiYanAwardPage = class("HeiYanAwardPage", import("view.activity.CorePage.CoreActivityPage"))

function HeiYanAwardPage:OnInit()
	self.AD = self._tf:Find("AD")
	self.table_Top = {
		self.AD:Find("tabs/top_1"),
		self.AD:Find("tabs/top_2"),
		self.AD:Find("tabs/top_3"),
		self.AD:Find("tabs/top_4")
	}
	self.bg_1 = self.AD:Find("bg_1")
	self.bg_2 = self.AD:Find("bg_2")
	self.boxTF = self._tf:Find("Box")
	self.boxBG = self.boxTF:Find("BG")
	self.panel = self.boxTF:Find("Panel")
	self.infoTF = self.panel:Find("Info")
	self.boxCloseBtn = self.infoTF:Find("CloseBtn")
	self.Title = self.infoTF:Find("Title")

	setText(self.Title, i18n("brs_reward_tip_1"))

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
	pg.UIMgr.GetInstance():OverlayPanel(self.boxTF)

	return
end

function HeiYanAwardPage:OnDataSetting()
	self.guideConfig = pg.activity_limit_item_guide

	self:BuildDatas()

	return
end

function HeiYanAwardPage:BuildDatas()
	assert(pg.activity_limit_item_guide.get_id_list_by_activity[self.activity.id], "activity_limit_item_guide not exist activity id: " .. self.activity.id)

	self.dataList = {}

	for iter_5_0, iter_5_1 in ipairs(pg.activity_limit_item_guide.get_id_list_by_activity[self.activity.id]) do
		local var_5_0 = {
			id = iter_5_1
		}

		var_5_0.config = self.guideConfig[var_5_0.id]
		var_5_0.count = self.activity:getKVPList(1, var_5_0.id)

		if var_5_0.config.count_storage == 1 then
			var_5_0.count = Drop.New({
				type = var_5_0.config.type,
				id = var_5_0.config.drop_id
			}):getOwnedCount()
		end

		table.insert(self.dataList, var_5_0)
	end

	return
end

function HeiYanAwardPage:OnFirstFlush()
	self:InitData()

	return
end

function HeiYanAwardPage:OnUpdateFlush()
	self:UpdateView()

	return
end

function HeiYanAwardPage:InitData()
	for iter_8_0, iter_8_1 in ipairs(self.table_Top) do
		onToggle(self, iter_8_1, function(arg_9_0)
			if arg_9_0 then
				self.pageIndex = iter_8_0

				SetActive(self.bg_1, iter_8_0 == 1)
				SetActive(self.bg_2, iter_8_0 ~= 1)
				self:DataList(iter_8_0)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function HeiYanAwardPage:UpdateView()
	for iter_10_0 = 1, #self.table_Top do
		setText(self.table_Top[iter_10_0]:Find("Label"), self:OnGetCount(iter_10_0) .. "/" .. self:OnCount(iter_10_0))
	end

	triggerToggle(self.table_Top[self.pageIndex or 1], true)

	return
end

function HeiYanAwardPage:DataList(arg_11_1)
	self.showDataList = {}

	for iter_11_0, iter_11_1 in ipairs(self.dataList) do
		if self.guideConfig[iter_11_1.id].type == 4 and arg_11_1 == 1 then
			table.insert(self.showDataList, iter_11_1)
		elseif self.guideConfig[iter_11_1.id].type == 5 and arg_11_1 == 2 then
			table.insert(self.showDataList, iter_11_1)
		elseif self.guideConfig[iter_11_1.id].type == 9 and arg_11_1 == 3 then
			table.insert(self.showDataList, iter_11_1)
		elseif self.guideConfig[iter_11_1.id].type == 21 and arg_11_1 == 4 then
			table.insert(self.showDataList, iter_11_1)
		end
	end

	table.sort(self.showDataList, CompareFuncs({
		function(arg_12_0)
			return arg_12_0.config.order
		end,
		function(arg_13_0)
			return arg_13_0.id
		end
	}))

	if arg_11_1 == 1 then
		self:ShowSitePage()
	elseif arg_11_1 == 2 or arg_11_1 == 3 or arg_11_1 == 4 then
		self:ShowCharaPage()
	end

	return
end

function HeiYanAwardPage:OnCount(arg_14_1)
	local var_14_0 = {}

	for iter_14_0, iter_14_1 in ipairs(self.dataList) do
		if self.guideConfig[iter_14_1.id].type == 4 and arg_14_1 == 1 then
			table.insert(var_14_0, iter_14_1)
		elseif self.guideConfig[iter_14_1.id].type == 5 and arg_14_1 == 2 then
			table.insert(var_14_0, iter_14_1)
		elseif self.guideConfig[iter_14_1.id].type == 9 and arg_14_1 == 3 then
			table.insert(var_14_0, iter_14_1)
		elseif self.guideConfig[iter_14_1.id].type == 21 and arg_14_1 == 4 then
			table.insert(var_14_0, iter_14_1)
		end
	end

	return #var_14_0
end

function HeiYanAwardPage:OnGetCount(arg_15_1)
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in ipairs(self.dataList) do
		if self.guideConfig[iter_15_1.id].type == 4 and arg_15_1 == 1 then
			if tobool(getProxy(CollectionProxy):getShipGroup(pg.ship_data_template[Drop.New({
				type = iter_15_1.config.type,
				id = iter_15_1.config.drop_id
			}).id].group_type)) then
				var_15_0 = var_15_0 + 1
			end
		elseif self.guideConfig[iter_15_1.id].type == 5 and arg_15_1 == 2 then
			if iter_15_1.count == iter_15_1.config.count then
				var_15_0 = var_15_0 + 1
			end
		elseif self.guideConfig[iter_15_1.id].type == 9 and arg_15_1 == 3 then
			if iter_15_1.count == iter_15_1.config.count then
				var_15_0 = var_15_0 + 1
			end
		elseif self.guideConfig[iter_15_1.id].type == 21 and arg_15_1 == 4 and iter_15_1.count == iter_15_1.config.count then
			var_15_0 = var_15_0 + 1
		end
	end

	return var_15_0
end

function HeiYanAwardPage:ShowSitePage()
	local var_16_1 = self.bg_1:Find("Role_left")
	local var_16_2 = var_16_1:Find("get")
	local var_16_3 = var_16_1:Find("notget")

	setText(var_16_2:Find("Text"), i18n("word_got"))
	setText(var_16_3:Find("Text"), i18n("word_not_get"))

	local var_16_4 = Drop.New({
		type = self.showDataList[1].config.type,
		id = self.showDataList[1].config.drop_id
	})
	local var_16_5 = tobool(getProxy(CollectionProxy):getShipGroup(pg.ship_data_template[var_16_4.id].group_type))

	setText(var_16_1:Find("name"):Find("Text"), (var_16_4:getName()))
	SetActive(var_16_1:Find("lock_bg"), not var_16_5)
	SetActive(var_16_2, var_16_5)
	SetActive(var_16_3, not var_16_5)

	local var_16_6 = self.bg_1:Find("Role_right")
	local var_16_7 = var_16_6:Find("get")
	local var_16_8 = var_16_6:Find("notget")

	setText(var_16_7:Find("Text"), i18n("word_got"))
	setText(var_16_8:Find("Text"), i18n("word_not_get"))

	local var_16_10 = Drop.New({
		type = self.showDataList[2].config.type,
		id = self.showDataList[2].config.drop_id
	})
	local var_16_11 = tobool(getProxy(CollectionProxy):getShipGroup(pg.ship_data_template[var_16_10.id].group_type))

	setText(var_16_6:Find("name"):Find("Text"), (var_16_10:getName()))
	SetActive(var_16_8, not var_16_11)
	SetActive(var_16_7, var_16_11)
	SetActive(var_16_6:Find("lock_bg"), not var_16_11)

	return
end

function HeiYanAwardPage:ShowCharaPage()
	self.award = self.bg_2:Find("tpl")
	self.count = self.bg_2:Find("count")
	self.tabsList = UIItemList.New(self.count, self.award)

	self.tabsList:make(function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_0 == UIItemList.EventUpdate then
			self:OnUpdateItem(arg_18_1, arg_18_2, data)
		end

		return
	end)
	self.tabsList:align(#self.showDataList)

	return
end

function HeiYanAwardPage:OnUpdateItem(arg_19_1, arg_19_2)
	local var_19_0 = self.showDataList[arg_19_1 + 1]
	local var_19_1 = arg_19_2:Find("icon_mask/icon")

	updateDrop(var_19_1, {
		type = self.showDataList[arg_19_1 + 1].config.type,
		id = self.showDataList[arg_19_1 + 1].config.drop_id
	})
	onButton(self, var_19_1, function()
		self:updateBoxPanel({
			type = MSGBOX_TYPE_LIKN_COLLECT_GUIDE,
			show_type = Msgbox4LinkCollectGuide.SHOW_TYPE_LIMIT,
			drop_type = var_19_0.config.type,
			drop_id = var_19_0.config.drop_id,
			count = var_19_0.count,
			count_limit = var_19_0.config.count,
			skipable_list = var_19_0.config.link_params
		})
		self:showBoxPanel(true)

		return
	end, SFX_PANEL)
	changeToScrollText(arg_19_2:Find("name_mask/name"), Drop.New({
		type = var_19_0.config.type,
		id = var_19_0.config.drop_id
	}):getName())
	setText(arg_19_2:Find("owner/number"), var_19_0.count .. "/" .. var_19_0.config.count)

	GetOrAddComponent(arg_19_2:Find("owner"), typeof(CanvasGroup)).alpha = var_19_0.count == var_19_0.config.count and 0.5 or 1

	setActive(arg_19_2:Find("got"), var_19_0.count == var_19_0.config.count)

	return
end

function HeiYanAwardPage:updateBoxPanel(arg_21_1)
	local var_21_0 = Drop.New({
		type = arg_21_1.drop_type,
		id = arg_21_1.drop_id
	})

	updateDrop(self.boxIconTF, var_21_0)
	changeToScrollText(self.boxNameText, var_21_0.cfg.name)
	setText(self.boxDescText, SwitchSpecialChar(var_21_0.desc))
	setText(self.boxNumTip, i18n("word_got"))

	if arg_21_1.show_type == Msgbox4LinkCollectGuide.SHOW_TYPE_NORMAL then
		setText(self.boxNumText, arg_21_1.count)
	elseif arg_21_1.show_type == Msgbox4LinkCollectGuide.SHOW_TYPE_LIMIT then
		setText(self.boxNumText, arg_21_1.count .. "/" .. (arg_21_1.count_limit or 0))
	end

	UIItemList.StaticAlign(self.boxSrcContent, self.boxSrcTpl, #arg_21_1.skipable_list, function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_0 == UIItemList.EventUpdate then
			local var_22_0 = arg_21_1.skipable_list[arg_22_1 + 1][1]
			local var_22_1 = arg_21_1.skipable_list[arg_22_1 + 1][2]

			changeToScrollText(arg_22_2:Find("SrcText"), arg_21_1.skipable_list[arg_22_1 + 1][3])

			local var_22_2 = arg_22_2:Find("GoBtn")

			setText(var_22_2:Find("go"), i18n("brs_reward_tip_2"))
			onButton(self, var_22_2, function()
				if var_22_0 == Msgbox4LinkCollectGuide.SKIP_TYPE_SCENE then
					pg.m02:sendNotification(GAME.GO_SCENE, var_22_1[1], var_22_1[2] or {})
				elseif var_22_0 == Msgbox4LinkCollectGuide.SKIP_TYPE_ACTIVITY then
					self:emit(ActivityMediator.SELECT_ACTIVITY, var_22_1)
				end

				self:showBoxPanel(false)

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function HeiYanAwardPage:showBoxPanel(arg_24_1)
	setActive(self.boxTF, arg_24_1)

	return
end

function HeiYanAwardPage:OnDestroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.boxTF)
	HeiYanAwardPage.super.OnDestroy(self)

	return
end

return HeiYanAwardPage
