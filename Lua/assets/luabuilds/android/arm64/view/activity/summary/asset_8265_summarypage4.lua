local SummaryPage4 = class("SummaryPage4", import(".SummaryAnimationPage"))

function SummaryPage4:OnInit()
	local var_1_0 = findTF(self._go, "content")
	local var_1_1 = {}

	for iter_1_0 = 1, var_1_0.childCount do
		local var_1_2 = var_1_0:GetChild(iter_1_0 - 1)
		local var_1_3 = findTF(var_1_2, "info")
		local var_1_4 = tonumber(go(var_1_2).name)
		local var_1_5 = self.summaryInfoVO.furnitures[var_1_4]

		triggerToggle(var_1_3, self.summaryInfoVO.furnitures[var_1_4])

		if var_1_5 then
			setText(var_1_3:Find("from/Text"), var_1_5:getConfig("gain_by"))
		end

		local var_1_8

		do
			setText(var_1_3:Find("from/Text"), (pg.furniture_data_template[var_1_4] or nil) and (pg.furniture_data_template[var_1_4].gain_by or "--：--:--"))

			var_1_8 = var_1_5 and var_1_5:getDate() or i18n("summary_page_un_rearch")
		end

		setText(var_1_3:Find("date/Text"), var_1_8)
		table.insert(var_1_1, var_1_3)
	end

	setActive(self._go, false)

	return
end

function SummaryPage4:Clear()
	return
end

return SummaryPage4
