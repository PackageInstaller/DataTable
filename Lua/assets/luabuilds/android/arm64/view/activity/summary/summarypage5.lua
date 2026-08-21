local var_0_0 = class("SummaryPage5", import(".SummaryAnimationPage"))

function var_0_0.OnInit(arg_1_0)
	onButton(arg_1_0, findTF(arg_1_0._go, "share"), function()
		if arg_1_0:inAnim() then
			return
		end

		pg.ShareMgr.GetInstance():Share(pg.ShareMgr.TypeSummary)

		return
	end, SFX_PANEL)
	setText(findTF(findTF(arg_1_0._go, "frame/name"), "Text"), arg_1_0.summaryInfoVO.name)

	local var_1_0 = findTF(arg_1_0._go, "frame/texts")

	arg_1_0.textTFs = {}

	for iter_1_0 = 1, var_1_0.childCount do
		local var_1_1 = var_1_0:GetChild(iter_1_0 - 1)
		local var_1_2 = go(var_1_1).name

		if var_1_2 == "list" or var_1_2 == "list1" then
			for iter_1_1 = 1, var_1_1.childCount do
				local var_1_3 = var_1_1:GetChild(iter_1_1 - 1)
				local var_1_4 = go(var_1_3).name

				setActive(var_1_3, (var_1_4 ~= "guildName" or not not arg_1_0.summaryInfoVO:hasGuild()) and (var_1_4 ~= "medalCount" or not not arg_1_0.summaryInfoVO:hasMedal()))

				if go(var_1_3).name ~= "label" then
					if var_1_4 == "guildName" or var_1_4 == "chapterName" then
						setText(var_1_3:Find("image/Text"), "「" .. string.gsub(arg_1_0.summaryInfoVO[go(var_1_3).name] .. "」", "–", "-"))
					else
						setText(var_1_3:Find("image/Text"), arg_1_0.summaryInfoVO[go(var_1_3).name])
					end
				end
			end
		elseif var_1_2 ~= "label" then
			setText(var_1_1:Find("Text"), arg_1_0.summaryInfoVO[var_1_2])
		end

		table.insert(arg_1_0.textTFs, var_1_1)
	end

	setActive(arg_1_0._go, false)

	return
end

function var_0_0.Clear(arg_3_0)
	return
end

return var_0_0
