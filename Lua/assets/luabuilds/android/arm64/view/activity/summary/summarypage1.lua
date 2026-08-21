local var_0_0 = class("SummaryPage1", import(".SummaryAnimationPage"))

function var_0_0.OnInit(arg_1_0)
	setText(findTF(findTF(arg_1_0._go, "name"), "Text"), arg_1_0.summaryInfoVO.name)

	local var_1_0 = findTF(arg_1_0._go, "time_line")

	for iter_1_0 = 1, var_1_0.childCount do
		local var_1_1 = var_1_0:GetChild(iter_1_0 - 1)
		local var_1_2 = var_1_1:Find("texts")

		for iter_1_1 = 1, var_1_2.childCount do
			local var_1_3 = var_1_2:GetChild(iter_1_1 - 1)
			local var_1_4 = go(var_1_3).name

			if var_1_4 == "guildName" then
				local var_1_5 = arg_1_0.summaryInfoVO.guildName
				local var_1_6 = not arg_1_0.summaryInfoVO.guildName or var_1_5 == ""

				if not (not arg_1_0.summaryInfoVO.guildName or var_1_5 == "") then
					setText(var_1_3:Find("text/Text"), "「" .. var_1_5 .. "」")
				end

				setActive(var_1_3:Find("image"), var_1_6)
				setActive(var_1_3:Find("text"), not var_1_6)
			elseif var_1_4 == "days" or var_1_4 == "furnitureCount" or var_1_4 == "furnitureWorth" then
				setText(var_1_3:Find("Text"), arg_1_0.summaryInfoVO[var_1_4])
			elseif var_1_4 ~= "label" then
				setText(var_1_3:Find("Text"), "「" .. string.gsub(arg_1_0.summaryInfoVO[var_1_4], "–", "-") .. "」")
			end
		end

		table.insert({}, var_1_1)
	end

	setPaintingPrefabAsync(findTF(findTF(arg_1_0._go, "painting"), "mask/painting"), Ship.New({
		configId = arg_1_0.summaryInfoVO.flagShipId
	}):getPainting(), "chuanwu")
	setActive(arg_1_0._go, false)

	return
end

return var_0_0
