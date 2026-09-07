local SummaryPage1 = class("SummaryPage1", import(".SummaryAnimationPage"))

function SummaryPage1:OnInit()
	setText(findTF(findTF(self._go, "name"), "Text"), self.summaryInfoVO.name)

	local var_1_0 = findTF(self._go, "time_line")
	local var_1_1 = {}

	for iter_1_0 = 1, var_1_0.childCount do
		local var_1_2 = var_1_0:GetChild(iter_1_0 - 1)
		local var_1_3 = var_1_2:Find("texts")

		for iter_1_1 = 1, var_1_3.childCount do
			local var_1_4 = var_1_3:GetChild(iter_1_1 - 1)
			local var_1_5 = go(var_1_4).name

			if var_1_5 == "guildName" then
				local var_1_6 = self.summaryInfoVO.guildName
				local var_1_7 = not self.summaryInfoVO.guildName or var_1_6 == ""

				if not (not self.summaryInfoVO.guildName or var_1_6 == "") then
					setText(var_1_4:Find("text/Text"), "「" .. var_1_6 .. "」")
				end

				setActive(var_1_4:Find("image"), var_1_7)
				setActive(var_1_4:Find("text"), not var_1_7)
			elseif var_1_5 == "days" or var_1_5 == "furnitureCount" or var_1_5 == "furnitureWorth" then
				setText(var_1_4:Find("Text"), self.summaryInfoVO[var_1_5])
			elseif var_1_5 ~= "label" then
				setText(var_1_4:Find("Text"), "「" .. string.gsub(self.summaryInfoVO[var_1_5], "–", "-") .. "」")
			end
		end

		table.insert(var_1_1, var_1_2)
	end

	setPaintingPrefabAsync(findTF(findTF(self._go, "painting"), "mask/painting"), Ship.New({
		configId = self.summaryInfoVO.flagShipId
	}):getPainting(), "chuanwu")
	setActive(self._go, false)

	return
end

return SummaryPage1
