local var_0_0 = class("WinConditionDisplayPanel", BaseSubView)

function var_0_0.getUIName(arg_1_0)
	return "WinConditionDisplayPanel"
end

function var_0_0.OnInit(arg_2_0)
	arg_2_0.listTF = arg_2_0._tf:Find("window/bg/awards/awardList")
	arg_2_0.closeBtn = arg_2_0._tf:Find("window/top/btnBack")
	arg_2_0.winCondtitle = arg_2_0._tf:Find("window/bg/winCond/title/text")

	setText(arg_2_0.winCondtitle, i18n("text_win_condition"))

	arg_2_0.winCondDesc = arg_2_0._tf:Find("window/bg/winCond/desc")
	arg_2_0.loseCondtitle = arg_2_0._tf:Find("window/bg/loseCond/title/text")

	setText(arg_2_0.loseCondtitle, i18n("text_lose_condition"))

	arg_2_0.loseCondDesc = arg_2_0._tf:Find("window/bg/loseCond/desc")
	arg_2_0.rewardList = arg_2_0._tf:Find("window/bg/awards")
	arg_2_0.rewardtip = arg_2_0.rewardList:Find("text")

	setText(arg_2_0.rewardtip, i18n("desc_defense_reward"))

	arg_2_0.rewardWord = arg_2_0.rewardList:Find("desc")

	setText(arg_2_0.rewardWord, i18n("word_reward"))

	arg_2_0.rewardCond = arg_2_0.rewardList:Find("cond")

	setText(arg_2_0.rewardCond, i18n("text_rest_HP"))
	onButton(arg_2_0, arg_2_0._tf, function()
		arg_2_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_2_0, arg_2_0.closeBtn, function()
		arg_2_0:Hide()

		return
	end, SFX_PANEL)

	return
end

local var_0_1 = {
	"s",
	"a",
	"b"
}

function var_0_0.UpdateList(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0

	if #arg_5_3 == 3 then
		arg_5_0.listTF:GetChild(1).gameObject:SetActive(true)
		arg_5_0.listTF:GetChild(2).gameObject:SetActive(true)
		arg_5_0.listTF:GetChild(3).gameObject:SetActive(true)

		var_5_0 = {
			3,
			2,
			1
		}
	elseif #arg_5_3 == 2 then
		arg_5_0.listTF:GetChild(1).gameObject:SetActive(true)
		arg_5_0.listTF:GetChild(2).gameObject:SetActive(false)
		arg_5_0.listTF:GetChild(3).gameObject:SetActive(true)

		var_5_0 = {
			3,
			1
		}
	elseif #arg_5_3 == 1 then
		arg_5_0.listTF:GetChild(1).gameObject:SetActive(false)
		arg_5_0.listTF:GetChild(2).gameObject:SetActive(true)
		arg_5_0.listTF:GetChild(3).gameObject:SetActive(false)

		var_5_0 = {
			2
		}
	end

	local var_5_1 = false

	for iter_5_0 = 1, #arg_5_3 do
		local var_5_2 = arg_5_0.listTF:GetChild(var_5_0[iter_5_0])
		local var_5_3 = tostring(arg_5_2[iter_5_0] - 1)

		if arg_5_2[iter_5_0] - 1 ~= arg_5_2[iter_5_0 + 1] then
			var_5_3 = tostring(arg_5_2[iter_5_0 + 1]) .. "-" .. var_5_3
		end

		setText(var_5_2:Find("text"), var_5_3)
		updateDrop(var_5_2:Find("award"), arg_5_3[iter_5_0], {
			hideName = true
		})
		onButton(arg_5_0, var_5_2:Find("award"), function()
			arg_5_0:emit(BaseUI.ON_DROP, var_0)

			return
		end, SFX_PANEL)

		local var_5_4 = not var_5_1 and arg_5_4 >= arg_5_2[iter_5_0 + 1]

		var_5_1 = var_5_1 or arg_5_4 >= arg_5_2[iter_5_0 + 1]

		setActive(var_5_2:Find("mask"), not var_5_4)
	end

	return
end

function var_0_0.Enter(arg_7_0, arg_7_1)
	setText(arg_7_0.winCondDesc, i18n(arg_7_1:getConfig("win_condition_display")))
	setText(arg_7_0.loseCondDesc, i18n(arg_7_1:getConfig("lose_condition_display")))

	local var_7_0 = arg_7_1:getPlayType() == ChapterConst.TypeDefence

	setActive(arg_7_0.rewardList, var_7_0)

	if var_7_0 then
		arg_7_0:UpdateRewardList(arg_7_1)
	end

	arg_7_0:Show()
	Canvas.ForceUpdateCanvases()

	return
end

function var_0_0.UpdateRewardList(arg_8_0, arg_8_1)
	if not pg.chapter_defense[arg_8_1.id] then
		return
	end

	local var_8_0 = Clone(pg.chapter_defense[arg_8_1.id].score)

	table.insert(var_8_0, 1, pg.chapter_defense[arg_8_1.id].port_hp + 1)

	for iter_8_0, iter_8_1 in ipairs(var_0_1) do
		if #pg.chapter_defense[arg_8_1.id]["evaluation_display_" .. iter_8_1] > 0 then
			table.insert({}, {
				type = pg.chapter_defense[arg_8_1.id]["evaluation_display_" .. iter_8_1][1],
				id = pg.chapter_defense[arg_8_1.id]["evaluation_display_" .. iter_8_1][2],
				count = pg.chapter_defense[arg_8_1.id]["evaluation_display_" .. iter_8_1][3]
			})
		end
	end

	arg_8_0:UpdateList(pg.chapter_defense[arg_8_1.id], var_8_0, {}, arg_8_1.BaseHP)

	return
end

return var_0_0
