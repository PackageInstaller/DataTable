local DALAwardPage = class("DALAwardPage", import("view.activity.CorePage.BRS.HeiYanAwardPage"))

function DALAwardPage:OnInit()
	DALAwardPage.super.OnInit(self)

	self.AD = self._tf:Find("AD")
	self.furmiturebtn = self.AD:Find("btn/furmiturebtn")
	self.commemoratebtn = self.AD:Find("btn/commemoratebtn")
	self.equipmentbtn = self.AD:Find("btn/equipmentbtn")

	return
end

function DALAwardPage:OnFirstFlush()
	self:InitData()

	local var_2_0 = self.activity:getConfig("config_client")

	onButton(self, self.furmiturebtn, function()
		self:DoSkip(var_2_0.furniture_theme_link[1], var_2_0.furniture_theme_link[2])

		return
	end, SFX_PANEL)
	onButton(self, self.commemoratebtn, function()
		self:DoSkip(var_2_0.medal_link[1], var_2_0.medal_link[2])

		return
	end, SFX_PANEL)
	onButton(self, self.equipmentbtn, function()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_LIKN_COLLECT_GUIDE,
			show_type = Msgbox4LinkCollectGuide.SHOW_TYPE_NORMAL,
			drop_type = var_2_0.equipskin_box_link.drop_type,
			drop_id = var_2_0.equipskin_box_link.drop_id,
			count = Drop.New({
				type = var_2_0.equipskin_box_link.drop_type,
				id = var_2_0.equipskin_box_link.drop_id
			}):getOwnedCount(),
			skipable_list = var_2_0.equipskin_box_link.list
		})

		return
	end, SFX_PANEL)

	return
end

function DALAwardPage:InitData()
	for iter_6_0, iter_6_1 in ipairs(self.table_Top) do
		onToggle(self, iter_6_1, function(arg_7_0)
			if arg_7_0 then
				self.pageIndex = iter_6_0

				SetActive(self.bg_1, false)
				SetActive(self.bg_2, true)
				self:DataList(iter_6_0 + 1)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function DALAwardPage:DataList(arg_8_1)
	self.showDataList = {}

	for iter_8_0, iter_8_1 in ipairs(self.dataList) do
		if self.guideConfig[iter_8_1.id].type == 3 and arg_8_1 == 2 then
			table.insert(self.showDataList, iter_8_1)
		elseif self.guideConfig[iter_8_1.id].type == 21 and arg_8_1 == 3 then
			table.insert(self.showDataList, iter_8_1)
		end
	end

	table.sort(self.showDataList, CompareFuncs({
		function(arg_9_0)
			return arg_9_0.config.order
		end,
		function(arg_10_0)
			return arg_10_0.id
		end
	}))
	self:ShowCharaPage()

	return
end

function DALAwardPage:OnAnimation(arg_11_1)
	return
end

function DALAwardPage:OnUpdateItem(arg_12_1, arg_12_2)
	local var_12_0 = self.showDataList[arg_12_1 + 1]
	local var_12_1 = arg_12_2:Find("icon_mask/icon")

	updateDrop(var_12_1, {
		type = self.showDataList[arg_12_1 + 1].config.type,
		id = self.showDataList[arg_12_1 + 1].config.drop_id
	})
	onButton(self, var_12_1, function()
		local var_13_0 = {
			type = MSGBOX_TYPE_LIKN_COLLECT_GUIDE,
			show_type = Msgbox4LinkCollectGuide.SHOW_TYPE_LIMIT,
			drop_type = var_12_0.config.type,
			drop_id = var_12_0.config.drop_id,
			count = var_12_0.count,
			count_limit = var_12_0.config.count,
			skipable_list = var_12_0.config.link_params
		}

		self:selectBoxbg(var_13_0)
		self:updateBoxPanel(var_13_0)
		self:showBoxPanel(true)

		return
	end, SFX_PANEL)
	changeToScrollText(arg_12_2:Find("name_mask/name"), Drop.New({
		type = var_12_0.config.type,
		id = var_12_0.config.drop_id
	}):getName())
	setText(arg_12_2:Find("owner/number"), var_12_0.count .. "/" .. var_12_0.config.count)

	GetOrAddComponent(arg_12_2:Find("owner"), typeof(CanvasGroup)).alpha = var_12_0.count == var_12_0.config.count and 0.5 or 1

	setActive(arg_12_2:Find("got"), var_12_0.count == var_12_0.config.count)

	return
end

function DALAwardPage:UpdateView()
	for iter_14_0 = 1, #self.table_Top do
		if iter_14_0 == 1 then
			setText(self.table_Top[iter_14_0]:Find("type_image/name"), i18n("yumia_award_1"))
			setText(self.table_Top[iter_14_0]:Find("on/name"), i18n("yumia_award_1"))
			setText(self.table_Top[iter_14_0]:Find("on/name2"), i18n("dal_AwardPage_name_1"))
		elseif iter_14_0 == 2 then
			setText(self.table_Top[iter_14_0]:Find("type_image/name"), i18n("yumia_award_4"))
			setText(self.table_Top[iter_14_0]:Find("on/name"), i18n("yumia_award_4"))
			setText(self.table_Top[iter_14_0]:Find("on/name2"), i18n("dal_AwardPage_name_2"))
		end
	end

	triggerToggle(self.table_Top[self.pageIndex or 1], true)

	return
end

function DALAwardPage:selectBoxbg(arg_15_1)
	if table.getCount(arg_15_1.skipable_list) > 1 then
		setImageSprite(self.boxTF:Find("Panel/BG"), LoadSprite("ui/DALAwardPage_atlas", "box_bg2"), true)
	elseif table.getCount(arg_15_1.skipable_list) == 1 then
		setImageSprite(self.boxTF:Find("Panel/BG"), LoadSprite("ui/DALAwardPage_atlas", "box_bg1"), true)
	end

	return
end

function DALAwardPage:RefreshCountText(arg_16_1, arg_16_2)
	setText(arg_16_2:Find("owner/number"), arg_16_1.count .. "/" .. arg_16_1.config.count)

	return
end

function DALAwardPage:showBoxPanel(arg_17_1)
	setActive(self.boxTF, arg_17_1)

	if arg_17_1 == true then
		pg.UIMgr.GetInstance():BlurPanel(self.boxTF)
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(self.boxTF, self._tf)
	end

	return
end

function DALAwardPage:DoSkip(arg_18_1, arg_18_2)
	if arg_18_1 == Msgbox4LinkCollectGuide.SKIP_TYPE_SCENE then
		pg.m02:sendNotification(GAME.GO_SCENE, arg_18_2[1], arg_18_2[2] or {})
	elseif arg_18_1 == Msgbox4LinkCollectGuide.SKIP_TYPE_ACTIVITY then
		pg.m02:sendNotification(GAME.GO_SCENE, SCENE.ACTIVITY, {
			id = arg_18_2
		})
	end

	return
end

function DALAwardPage:OnDestroy()
	self:showBoxPanel(false)

	return
end

return DALAwardPage
