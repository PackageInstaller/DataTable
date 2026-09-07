local SummaryPage5 = class("SummaryPage5", import(".SummaryAnimationPage"))

function SummaryPage5:OnInit()
	onButton(self, findTF(self._go, "share"), function()
		if self:inAnim() then
			return
		end

		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeSummary)

		return
	end, SFX_PANEL)
	setText(findTF(findTF(self._go, "frame/name"), "Text"), self.summaryInfoVO.name)

	local var_1_0 = findTF(self._go, "frame/texts")

	self.textTFs = {}

	for iter_1_0 = 1, var_1_0.childCount do
		local var_1_1 = var_1_0:GetChild(iter_1_0 - 1)
		local var_1_2 = go(var_1_1).name

		if var_1_2 == "list" or var_1_2 == "list1" then
			for iter_1_1 = 1, var_1_1.childCount do
				local var_1_3 = var_1_1:GetChild(iter_1_1 - 1)
				local var_1_4 = go(var_1_3).name

				setActive(var_1_3, (var_1_4 ~= "guildName" or not not self.summaryInfoVO:hasGuild()) and (var_1_4 ~= "medalCount" or not not self.summaryInfoVO:hasMedal()))

				if go(var_1_3).name ~= "label" then
					if var_1_4 == "guildName" or var_1_4 == "chapterName" then
						setText(var_1_3:Find("image/Text"), "「" .. string.gsub(self.summaryInfoVO[go(var_1_3).name] .. "」", "–", "-"))
					else
						setText(var_1_3:Find("image/Text"), self.summaryInfoVO[go(var_1_3).name])
					end
				end
			end
		elseif var_1_2 ~= "label" then
			setText(var_1_1:Find("Text"), self.summaryInfoVO[var_1_2])
		end

		table.insert(self.textTFs, var_1_1)
	end

	setActive(self._go, false)

	return
end

function SummaryPage5:Clear()
	return
end

return SummaryPage5
