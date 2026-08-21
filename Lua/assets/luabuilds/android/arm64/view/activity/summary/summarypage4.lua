local var_0_0 = class("SummaryPage4", import(".SummaryAnimationPage"))

function var_0_0.OnInit(arg_1_0)
	local var_1_0 = findTF(arg_1_0._go, "content")
	local var_1_1 = {}

	for iter_1_0 = 1, var_1_0.childCount do
		local var_1_2 = var_1_0:GetChild(iter_1_0 - 1)
		local var_1_3 = findTF(var_1_2, "info")
		local var_1_4 = tonumber(go(var_1_2).name)
		local var_1_5 = arg_1_0.summaryInfoVO.furnitures[var_1_4]

		triggerToggle(var_1_3, arg_1_0.summaryInfoVO.furnitures[var_1_4])

		local var_1_6 = pg.furniture_data_template[var_1_4]
		local var_1_8 = var_1_3:Find("from/Text")

		if var_1_5 then
			setText(var_1_3:Find("from/Text"), var_1_5:getConfig("gain_by"))

			goto label_1_0
		end

		::label_1_0::

		if pg.furniture_data_template[var_1_4] then
			local var_1_10

			do
				local var_1_9 = var_1_6.gain_by or "--：--:--"

				var_1_7(var_1_8, var_1_9)

				var_1_10 = var_1_5 and var_1_5:getDate() or i18n("summary_page_un_rearch")
			end

			setText(var_1_3:Find("date/Text"), var_1_10)
			table.insert(var_1_1, var_1_3)
		end
	end

	setActive(arg_1_0._go, false)

	return
end

function var_0_0.Clear(arg_2_0)
	return
end

return var_0_0
