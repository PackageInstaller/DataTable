local SecondSummaryPage4 = class("SecondSummaryPage4", import(".SummaryAnimationPage"))

SecondSummaryPage4.PerPageCount = 6
SecondSummaryPage4.PageTypeFurniture = 1
SecondSummaryPage4.PageTypeIconFrame = 2

function SecondSummaryPage4:OnInit()
	local var_1_0 = self.summaryInfoVO.pageType

	setActive(self._tf:Find("tip"), self.summaryInfoVO.pageType == SecondSummaryPage4.PageTypeFurniture)
	setActive(self._tf:Find("tip_2"), var_1_0 == SecondSummaryPage4.PageTypeIconFrame)

	local var_1_1

	if var_1_0 == SecondSummaryPage4.PageTypeFurniture then
		var_1_1 = self.summaryInfoVO.medalList
	elseif var_1_0 == SecondSummaryPage4.PageTypeIconFrame then
		var_1_1 = self.summaryInfoVO.iconFrameList
	else
		assert(false, "page type error")
	end

	local var_1_2 = {}

	for iter_1_0 = SecondSummaryPage4.PerPageCount * (self.summaryInfoVO.samePage - 1) + 1, math.min(SecondSummaryPage4.PerPageCount * (self.summaryInfoVO.samePage - 1) + 1 + SecondSummaryPage4.PerPageCount - 1, #var_1_1) do
		table.insert(var_1_2, var_1_1[iter_1_0])
	end

	local var_1_3 = getProxy(AttireProxy)
	local var_1_4 = UIItemList.New(self._tf:Find("scroll_rect/content"), self._tf:Find("scroll_rect/content/item_tpl"))

	var_1_4:make(function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_0 == UIItemList.EventUpdate then
			setActive(arg_2_2:Find("icon/Image"), var_1_0 == SecondSummaryPage4.PageTypeFurniture)
			setActive(arg_2_2:Find("icon/frame"), var_1_0 == SecondSummaryPage4.PageTypeIconFrame)
			setActive(arg_2_2:Find("date"), var_1_0 == SecondSummaryPage4.PageTypeFurniture)
			setText(arg_2_2:Find("date"), i18n("player_summary_data"))
			setText(arg_2_2:Find("from"), i18n("player_summary_from"))

			if self.summaryInfoVO.pageType == SecondSummaryPage4.PageTypeFurniture then
				GetImageSpriteFromAtlasAsync("furnitureicon/" .. pg.furniture_data_template[var_1_2[arg_2_1 + 1]].icon, "", arg_2_2:Find("icon/Image"), true)
				setText(arg_2_2:Find("controll/name/Text"), pg.furniture_data_template[var_1_2[arg_2_1 + 1]].name)
				setText(arg_2_2:Find("from/Text"), pg.furniture_data_template[var_1_2[arg_2_1 + 1]].gain_by)
				setText(arg_2_2:Find("date/Text"), self.summaryInfoVO.furnitures[var_1_2[arg_2_1 + 1]] and self.summaryInfoVO.furnitures[var_1_2[arg_2_1 + 1]]:getDate() or i18n("summary_page_un_rearch"))
			elseif self.summaryInfoVO.pageType == SecondSummaryPage4.PageTypeIconFrame then
				local var_2_0, var_2_1 = unpack(var_1_2[arg_2_1 + 1])
				local var_2_2 = var_1_3:getAttireFrame(AttireConst.TYPE_ICON_FRAME, var_2_0)

				setLocalScale(arg_2_2:Find("icon/frame"), Vector3(var_2_1, var_2_1, var_2_1))
				PoolMgr.GetInstance():GetPrefab(var_2_2:getIcon(), var_2_2:getConfig("id"), true, function(arg_3_0)
					setParent(arg_3_0, arg_2_2:Find("icon/frame"), false)

					return
				end)
				setText(arg_2_2:Find("controll/name/Text"), var_2_2:getConfig("name"))
				setText(arg_2_2:Find("from/Text"), var_2_2:getConfig("gain_by"))
			else
				assert(false, "logic error")
			end
		end

		return
	end)
	var_1_4:align(#var_1_2)

	return
end

return SecondSummaryPage4
