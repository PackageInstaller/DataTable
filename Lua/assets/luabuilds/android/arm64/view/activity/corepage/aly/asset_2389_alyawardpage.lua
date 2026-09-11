local ALYAwardPage = class("ALYAwardPage", import("..CoreActivityPage"))

function ALYAwardPage:OnInit()
	self.AD = self._tf:Find("AD")
	self.table_Top = {
		self.AD:Find("tabs/top_1"),
		self.AD:Find("tabs/top_2"),
		self.AD:Find("tabs/top_3"),
		self.AD:Find("tabs/top_4")
	}
	self.btn = self.AD:Find("btn")
	self.furmiturebtn = self.btn:Find("furmiturebtn")
	self.commemoratebtn = self.btn:Find("commemoratebtn")
	self.equipmentbtn = self.btn:Find("equipmentbtn")

	self.furmiturebtn:Find("left/Title"):GetComponent(typeof(Image)):SetNativeSize()
	self.commemoratebtn:Find("left/Title"):GetComponent(typeof(Image)):SetNativeSize()
	self.equipmentbtn:Find("left/Title"):GetComponent(typeof(Image)):SetNativeSize()

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

	return
end

function ALYAwardPage:BuildDatas()
	assert(pg.activity_limit_item_guide.get_id_list_by_activity[self.activity.id], "activity_limit_item_guide not exist activity id: " .. self.activity.id)

	self.dataList = {}

	for iter_4_0, iter_4_1 in ipairs(pg.activity_limit_item_guide.get_id_list_by_activity[self.activity.id]) do
		local var_4_0 = {
			id = iter_4_1
		}

		var_4_0.config = self.guideConfig[var_4_0.id]
		var_4_0.count = self.activity:getKVPList(1, var_4_0.id)

		if var_4_0.config.count_storage == 1 then
			var_4_0.count = Drop.New({
				type = var_4_0.config.type,
				id = var_4_0.config.drop_id
			}):getOwnedCount()
		end

		table.insert(self.dataList, var_4_0)
	end

	return
end

function ALYAwardPage:OnDataSetting()
	self.guideConfig = pg.activity_limit_item_guide

	self:BuildDatas()

	return
end

function ALYAwardPage:OnFirstFlush()
	self:InitData()

	local var_6_0 = self.activity:getConfig("config_client")

	onButton(self, self.furmiturebtn, function()
		self:DoSkip(var_6_0.furniture_theme_link[1], var_6_0.furniture_theme_link[2])

		return
	end, SFX_PANEL)
	onButton(self, self.commemoratebtn, function()
		self:DoSkip(var_6_0.medal_link[1], var_6_0.medal_link[2])

		return
	end, SFX_PANEL)
	onButton(self, self.equipmentbtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_LIKN_COLLECT_GUIDE,
			show_type = Msgbox4LinkCollectGuide.SHOW_TYPE_NORMAL,
			drop_type = var_6_0.equipskin_box_link.drop_type,
			drop_id = var_6_0.equipskin_box_link.drop_id,
			count = count,
			skipable_list = var_6_0.equipskin_box_link.list
		})

		return
	end, SFX_PANEL)

	return
end

function ALYAwardPage:OnUpdateFlush()
	triggerToggle(self.table_Top[self.pageIndex or 1], true)

	return
end

function ALYAwardPage:ResetTop()
	for iter_11_0 = 1, #self.table_Top do
		setText(self.AD:Find("tabs/top_" .. iter_11_0 .. "/Label"), i18n("yumia_award_" .. iter_11_0))
		setTextColor(self.AD:Find("tabs/top_" .. iter_11_0 .. "/Label"), Color.NewHex("cfcfcf"))
	end

	return
end

function ALYAwardPage:InitData()
	for iter_12_0, iter_12_1 in ipairs(self.table_Top) do
		onToggle(self, iter_12_1, function(arg_13_0)
			if arg_13_0 then
				self.pageIndex = iter_12_0

				onDelayTick(function()
					self:DataList(iter_12_0)

					return
				end, 0.08)
				self:ResetTop()
				setTextColor(self.AD:Find("tabs/top_" .. iter_12_0 .. "/Label"), Color.NewHex("0a2e31"))
			end

			return
		end, SFX_PANEL)
	end

	return
end

function ALYAwardPage:DataList(arg_15_1)
	self.showDataList = {}

	for iter_15_0, iter_15_1 in ipairs(self.dataList) do
		if self.guideConfig[iter_15_1.id].type == 3 and arg_15_1 == 1 then
			table.insert(self.showDataList, iter_15_1)
		elseif self.guideConfig[iter_15_1.id].type == 5 and arg_15_1 == 2 then
			table.insert(self.showDataList, iter_15_1)
		elseif self.guideConfig[iter_15_1.id].type == 9 and arg_15_1 == 3 then
			table.insert(self.showDataList, iter_15_1)
		elseif self.guideConfig[iter_15_1.id].type == 21 and arg_15_1 == 4 then
			table.insert(self.showDataList, iter_15_1)
		end
	end

	table.sort(self.showDataList, CompareFuncs({
		function(arg_16_0)
			return arg_16_0.count < arg_16_0.config.count and 0 or 1
		end,
		function(arg_17_0)
			return arg_17_0.config.order
		end,
		function(arg_18_0)
			return arg_18_0.id
		end
	}))
	self:ShowCharaPage()

	return
end

function ALYAwardPage:ShowCharaPage()
	self.award = self.AD:Find("tpl")
	self.count = self.AD:Find("item_list/content")
	self.tabsList = UIItemList.New(self.count, self.award)

	self.tabsList:make(function(arg_20_0, arg_20_1, arg_20_2)
		if arg_20_0 == UIItemList.EventUpdate then
			self:OnUpdateItem(arg_20_1, arg_20_2)
		end

		return
	end)
	self.tabsList:align(#self.showDataList)

	return
end

function ALYAwardPage:OnUpdateItem(arg_21_1, arg_21_2)
	local var_21_0 = self.showDataList[arg_21_1 + 1]
	local var_21_1 = arg_21_2:Find("icon_mask/icon")

	updateDrop(var_21_1, {
		type = self.showDataList[arg_21_1 + 1].config.type,
		id = self.showDataList[arg_21_1 + 1].config.drop_id
	})
	onButton(self, var_21_1, function()
		self:updateBoxPanel({
			type = MSGBOX_TYPE_LIKN_COLLECT_GUIDE,
			show_type = Msgbox4LinkCollectGuide.SHOW_TYPE_LIMIT,
			drop_type = var_21_0.config.type,
			drop_id = var_21_0.config.drop_id,
			count = var_21_0.count,
			count_limit = var_21_0.config.count,
			skipable_list = var_21_0.config.link_params
		})
		self:showBoxPanel(true)

		return
	end, SFX_PANEL)
	changeToScrollText(arg_21_2:Find("name_mask/name"), Drop.New({
		type = var_21_0.config.type,
		id = var_21_0.config.drop_id
	}):getName())
	setText(arg_21_2:Find("owner/title"), i18n("collect_page_got"))
	setText(arg_21_2:Find("owner/Text"), var_21_0.count)
	setText(arg_21_2:Find("owner/number"), "/" .. var_21_0.config.count)

	GetOrAddComponent(arg_21_2:Find("owner"), typeof(CanvasGroup)).alpha = var_21_0.count == var_21_0.config.count and 0.5 or 1

	setActive(arg_21_2:Find("got"), var_21_0.count == var_21_0.config.count)

	return
end

function ALYAwardPage:updateBoxPanel(arg_23_1)
	local var_23_0 = Drop.New({
		type = arg_23_1.drop_type,
		id = arg_23_1.drop_id
	})

	updateDrop(self.boxIconTF, var_23_0)
	changeToScrollText(self.boxNameText, var_23_0.cfg.name)
	setText(self.boxDescText, SwitchSpecialChar(var_23_0.desc))
	setText(self.boxNumTip, i18n("word_got") .. "：")

	if arg_23_1.show_type == Msgbox4LinkCollectGuide.SHOW_TYPE_NORMAL then
		setText(self.boxNumText, "<color=#FCFCE8>" .. arg_23_1.count .. "</color>")
	elseif arg_23_1.show_type == Msgbox4LinkCollectGuide.SHOW_TYPE_LIMIT then
		setText(self.boxNumText, "<color=#FCFCE8>" .. arg_23_1.count .. "</color>/" .. (arg_23_1.count_limit or 0))
	end

	UIItemList.StaticAlign(self.boxSrcContent, self.boxSrcTpl, #arg_23_1.skipable_list, function(arg_24_0, arg_24_1, arg_24_2)
		if arg_24_0 == UIItemList.EventUpdate then
			local var_24_0 = arg_23_1.skipable_list[arg_24_1 + 1][1]
			local var_24_1 = arg_23_1.skipable_list[arg_24_1 + 1][2]

			changeToScrollText(arg_24_2:Find("SrcText"), arg_23_1.skipable_list[arg_24_1 + 1][3])

			local var_24_2 = arg_24_2:Find("GoBtn")

			setText(var_24_2:Find("go"), i18n("brs_reward_tip_2"))
			onButton(self, var_24_2, function()
				self:DoSkip(var_24_0, var_24_1)
				self:showBoxPanel(false)

				return
			end, SFX_PANEL)
		end

		return
	end)

	return
end

function ALYAwardPage:DoSkip(arg_26_1, arg_26_2)
	if arg_26_1 == Msgbox4LinkCollectGuide.SKIP_TYPE_SCENE then
		pg.m02:sendNotification(GAME.GO_SCENE, arg_26_2[1], arg_26_2[2] or {})
	elseif arg_26_1 == Msgbox4LinkCollectGuide.SKIP_TYPE_ACTIVITY then
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = arg_26_2
		})
	end

	return
end

function ALYAwardPage:showBoxPanel(arg_27_1)
	setActive(self.boxTF, arg_27_1)

	if arg_27_1 == true then
		pg.UIMgr.GetInstance():BlurPanel(self.boxTF)
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(self.boxTF, self._tf)
	end

	return
end

function ALYAwardPage:OnDestroy()
	pg.UIMgr.GetInstance():UnOverlayPanel(self.boxTF, self._tf)
	ALYAwardPage.super.OnDestroy(self)

	return
end

return ALYAwardPage
