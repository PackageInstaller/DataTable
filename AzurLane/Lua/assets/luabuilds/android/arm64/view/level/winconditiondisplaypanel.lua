class = var_0_10000

local var_0_0 = "WinConditionDisplayPanel"

BaseSubView = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003)

function var_0_1.getUIName(arg_1_0)
	return "WinConditionDisplayPanel"
end

function var_0_1.OnInit(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.listTF = var_1.Find(var_2_0, "window/bg/awards/awardList")

	local var_2_1 = arg_2_0._tf

	arg_2_0.closeBtn = var_1.Find(var_2_1, "window/top/btnBack")

	local var_2_2 = arg_2_0._tf

	arg_2_0.winCondtitle = var_1.Find(var_2_2, "window/bg/winCond/title/text")
	setText = var_1

	local var_2_3 = arg_2_0.winCondtitle

	i18n = var_4

	var_1(var_2_3, var_4("text_win_condition"))

	local var_2_4 = arg_2_0._tf

	arg_2_0.winCondDesc = var_1.Find(var_2_4, "window/bg/winCond/desc")

	local var_2_5 = arg_2_0._tf

	arg_2_0.loseCondtitle = var_1.Find(var_2_5, "window/bg/loseCond/title/text")
	setText = var_1

	local var_2_6 = arg_2_0.loseCondtitle

	i18n = var_4

	var_1(var_2_6, var_4("text_lose_condition"))

	local var_2_7 = arg_2_0._tf

	arg_2_0.loseCondDesc = var_1.Find(var_2_7, "window/bg/loseCond/desc")

	local var_2_8 = arg_2_0._tf

	arg_2_0.rewardList = var_1.Find(var_2_8, "window/bg/awards")

	local var_2_9 = arg_2_0.rewardList

	arg_2_0.rewardtip = var_1.Find(var_2_9, "text")
	setText = var_1

	local var_2_10 = arg_2_0.rewardtip

	i18n = var_4

	var_1(var_2_10, var_4("desc_defense_reward"))

	local var_2_11 = arg_2_0.rewardList

	arg_2_0.rewardWord = var_1.Find(var_2_11, "desc")
	setText = var_1

	local var_2_12 = arg_2_0.rewardWord

	i18n = var_4

	var_1(var_2_12, var_4("word_reward"))

	local var_2_13 = arg_2_0.rewardList

	arg_2_0.rewardCond = var_1.Find(var_2_13, "cond")
	setText = var_1

	local var_2_14 = arg_2_0.rewardCond

	i18n = var_4

	var_1(var_2_14, var_4("text_rest_HP"))

	onButton = var_1

	local var_2_15 = arg_2_0
	local var_2_16 = arg_2_0._tf

	local function var_2_17()
		local var_3_0 = arg_2_0

		var_0.Hide(var_3_0)

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_15, var_2_16, var_2_17, var_6)

	onButton = var_1

	local var_2_18 = arg_2_0
	local var_2_19 = arg_2_0.closeBtn

	local function var_2_20()
		local var_4_0 = arg_2_0

		var_0.Hide(var_4_0)

		return
	end

	SFX_PANEL = var_6

	var_1(var_2_18, var_2_19, var_2_20, var_6)

	return
end

local var_0_2 = {
	"s",
	"a",
	"b"
}

function var_0_1.UpdateList(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0

	if #arg_5_3 == 3 then
		local var_5_1 = arg_5_0.listTF
		local var_5_2 = var_6.GetChild(var_5_1, 1).gameObject

		var_6.SetActive(var_5_2, true)

		local var_5_3 = arg_5_0.listTF
		local var_5_4 = var_6.GetChild(var_5_3, 2).gameObject

		var_6.SetActive(var_5_4, true)

		local var_5_5 = arg_5_0.listTF
		local var_5_6 = var_6.GetChild(var_5_5, 3).gameObject

		var_6.SetActive(var_5_6, true)

		var_5_0 = {
			3,
			2,
			1
		}
	elseif #arg_5_3 == 2 then
		local var_5_7 = arg_5_0.listTF
		local var_5_8 = var_6.GetChild(var_5_7, 1).gameObject

		var_6.SetActive(var_5_8, true)

		local var_5_9 = arg_5_0.listTF
		local var_5_10 = var_6.GetChild(var_5_9, 2).gameObject

		var_6.SetActive(var_5_10, false)

		local var_5_11 = arg_5_0.listTF
		local var_5_12 = var_6.GetChild(var_5_11, 3).gameObject

		var_6.SetActive(var_5_12, true)

		var_5_0 = {
			3,
			1
		}
	elseif #arg_5_3 == 1 then
		local var_5_13 = arg_5_0.listTF
		local var_5_14 = var_6.GetChild(var_5_13, 1).gameObject

		var_6.SetActive(var_5_14, false)

		local var_5_15 = arg_5_0.listTF
		local var_5_16 = var_6.GetChild(var_5_15, 2).gameObject

		var_6.SetActive(var_5_16, true)

		local var_5_17 = arg_5_0.listTF
		local var_5_18 = var_6.GetChild(var_5_17, 3).gameObject

		var_6.SetActive(var_5_18, false)

		var_5_0 = {
			2
		}
	end

	local var_5_19 = false

	for iter_5_0 = 1, #arg_5_3 do
		local var_5_20 = arg_5_0.listTF
		local var_5_21 = var_11.GetChild(var_5_20, var_5_0[iter_5_0])

		tostring = var_1_10012
		var_1_10012 = var_1_10012(arg_5_2[iter_5_0] - 1)

		if arg_5_2[iter_5_0] - 1 ~= arg_5_2[iter_5_0 + 1] then
			tostring = var_13
			var_1_10012 = var_13(arg_5_2[iter_5_0 + 1]) .. "-" .. var_1_10012
		end

		setText = var_13

		var_13(var_5_21:Find("text"), var_1_10012)

		local var_5_22 = arg_5_3[iter_5_0]

		updateDrop = var_14

		var_14(var_5_21:Find("award"), var_5_22, {
			hideName = true
		})

		onButton = var_14

		local var_5_23 = arg_5_0
		local var_5_24 = var_5_21
		local var_5_25 = var_5_21.Find(var_5_24, "award")

		local function var_5_26()
			local var_6_0 = arg_5_0
			local var_6_1 = var_0.emit

			BaseUI = var_2_10003

			var_6_1(var_6_0, var_2_10003.ON_DROP, var_5_22)

			return
		end

		SFX_PANEL = var_5_24

		var_14(var_5_23, var_5_25, var_5_26, var_5_24)

		local var_5_27 = not var_5_19 and arg_5_4 >= arg_5_2[iter_5_0 + 1]

		var_5_19 = var_5_19 or arg_5_2[iter_5_0 + 1] <= arg_5_4
		setActive = var_15

		var_15(var_5_21:Find("mask"), not var_5_27)
	end

	return
end

function var_0_1.Enter(arg_7_0, arg_7_1)
	setText = var_1_10002

	local var_7_0 = arg_7_0.winCondDesc

	i18n = var_1_10005

	var_1_10002(var_7_0, var_1_10005(arg_7_1:getConfig("win_condition_display")))

	setText = var_1_10002

	local var_7_1 = arg_7_0.loseCondDesc

	i18n = var_5

	var_1_10002(var_7_1, var_5(arg_7_1:getConfig("lose_condition_display")))

	local var_7_2 = arg_7_1:getPlayType()

	ChapterConst = var_1_10003

	local var_7_3 = var_7_2 == var_1_10003.TypeDefence

	setActive = var_3

	var_3(arg_7_0.rewardList, var_7_3)

	if var_7_3 then
		arg_7_0:UpdateRewardList(arg_7_1)
	end

	arg_7_0:Show()

	Canvas = var_3

	var_3.ForceUpdateCanvases()

	return
end

function var_0_1.UpdateRewardList(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.id

	pg = var_1_10003

	if not var_1_10003.chapter_defense[var_8_0] then
		return
	end

	Clone = var_1_10004

	local var_8_1 = var_1_10004(var_3.score)

	table = var_1_10005

	var_1_10005.insert(var_8_1, 1, var_3.port_hp + 1)

	local var_8_2 = {}

	ipairs = var_6

	for iter_8_0, iter_8_1 in var_6(var_0_2) do
		if #var_3["evaluation_display_" .. iter_8_1] > 0 then
			table = var_12

			var_12.insert(var_8_2, {
				type = var_11[1],
				id = var_11[2],
				count = var_11[3]
			})
		end
	end

	arg_8_0:UpdateList(var_3, var_8_1, var_8_2, arg_8_1.BaseHP)

	return
end

return var_0_1
