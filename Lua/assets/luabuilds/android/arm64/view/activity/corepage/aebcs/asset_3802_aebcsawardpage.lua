local AEBCSAwardPage = class("AEBCSAwardPage", import("view.activity.CorePage.BRS.HeiYanAwardPage"))

function AEBCSAwardPage:InitData()
	for iter_1_0, iter_1_1 in ipairs(self.table_Top) do
		onToggle(self, iter_1_1, function(arg_2_0)
			if arg_2_0 then
				self.pageIndex = iter_1_0

				SetActive(self.bg_1, iter_1_0 == 1)
				SetActive(self.bg_2, iter_1_0 ~= 1)
				self:OnAnimation(iter_1_0)
				self:DataList(iter_1_0)
			end

			return
		end, SFX_PANEL)
	end

	return
end

function AEBCSAwardPage:OnAnimation(arg_3_1)
	if arg_3_1 ~= 1 then
		self.bg_2:GetComponent(typeof(Animation)):Play("AEBCSAwardPage_list_in")
	end

	return
end

function AEBCSAwardPage:OnUpdateItem(arg_4_1, arg_4_2)
	local var_4_0 = self.showDataList[arg_4_1 + 1]
	local var_4_1 = arg_4_2:Find("icon_mask/icon")

	updateDrop(var_4_1, {
		type = self.showDataList[arg_4_1 + 1].config.type,
		id = self.showDataList[arg_4_1 + 1].config.drop_id
	})
	onButton(self, var_4_1, function()
		local var_5_0 = {
			type = MSGBOX_TYPE_LIKN_COLLECT_GUIDE,
			show_type = Msgbox4LinkCollectGuide.SHOW_TYPE_LIMIT,
			drop_type = var_4_0.config.type,
			drop_id = var_4_0.config.drop_id,
			count = var_4_0.count,
			count_limit = var_4_0.config.count,
			skipable_list = var_4_0.config.link_params
		}

		self:selectBoxbg(var_5_0)
		self:updateBoxPanel(var_5_0)
		self:showBoxPanel(true)

		return
	end, SFX_PANEL)
	self.super.OnUpdateItem(self, arg_4_1, arg_4_2)

	return
end

function AEBCSAwardPage:UpdateView()
	for iter_6_0 = 1, #self.table_Top do
		setText(self.table_Top[iter_6_0]:Find("Label"), self:OnGetCount(iter_6_0) .. "/" .. self:OnCount(iter_6_0))
		setText(self.table_Top[iter_6_0]:Find("type_image/name"), i18n("danmachi_award_" .. iter_6_0))
	end

	triggerToggle(self.table_Top[self.pageIndex or 1], true)

	return
end

function AEBCSAwardPage:selectBoxbg(arg_7_1)
	if table.getCount(arg_7_1.skipable_list) > 1 then
		setImageSprite(self.boxTF:Find("Panel/BG"), LoadSprite("ui/AEBCSAwardPage_atlas", "box_bg1"), true)
	elseif table.getCount(arg_7_1.skipable_list) == 1 then
		setImageSprite(self.boxTF:Find("Panel/BG"), LoadSprite("ui/AEBCSAwardPage_atlas", "box_bg2"), true)
	end

	return
end

function AEBCSAwardPage:RefreshCountText(arg_8_1, arg_8_2)
	setText(arg_8_2:Find("owner/number"), arg_8_1.count .. "/" .. arg_8_1.config.count)

	return
end

function AEBCSAwardPage:showBoxPanel(arg_9_1)
	setActive(self.boxTF, arg_9_1)

	if arg_9_1 == true then
		pg.UIMgr.GetInstance():BlurPanel(self.boxTF)
	else
		pg.UIMgr.GetInstance():UnOverlayPanel(self.boxTF, self._tf)
	end

	return
end

function AEBCSAwardPage:OnDestroy()
	self:showBoxPanel(false)

	return
end

return AEBCSAwardPage
