class = var_0_10000

local var_0_0 = "CardPuzzleCardDetailLayer"

BaseUI = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003)

function var_0_1.getUIName(arg_1_0)
	return "CardTowerCardDetailUI"
end

function var_0_1.init(arg_2_0)
	CardPuzzleCardView = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0._tf

	arg_2_0.cardView = var_2_0(var_3.Find(var_2_1, "CardTowerCard"))

	local var_2_2 = arg_2_0._tf

	arg_2_0.keywordList = var_1.Find(var_2_2, "KeywordList")

	return
end

local var_0_2 = {
	168,
	220
}

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0._tf
	local var_3_2 = var_4.Find(var_3_1, "BG")

	local function var_3_3()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_3_1

	var_1_10001(var_3_0, var_3_2, var_3_3, var_3_1)

	local var_3_4 = arg_3_0.cardView

	var_1.SetData(var_3_4, arg_3_0.contextData.cardData)

	local var_3_5 = arg_3_0.cardView

	var_1.UpdateView(var_3_5)

	setAnchoredPosition = var_1

	local var_3_6 = arg_3_0.keywordList
	local var_3_7 = {}
	local var_3_8 = var_0_2

	showPreview = var_3_1
	var_3_7.x = var_3_8[var_3_1 and 2 or 1]

	var_1(var_3_6, var_3_7)

	_ = var_1

	local var_3_9 = var_1.filter
	local var_3_10 = arg_3_0.contextData.cardData
	local var_3_11 = var_3_9(var_3.GetKeywords(var_3_10), function(arg_5_0)
		local var_5_0 = arg_5_0.affix_type

		CardPuzzleCardView = var_2_10002

		local var_5_2

		if var_5_0 ~= var_2_10002.AFFIX_TYPE.SCHOOL then
			local var_5_1 = arg_5_0.affix_type

			CardPuzzleCardView = var_2

			if var_5_1 ~= var_2.AFFIX_TYPE.AFFIX or arg_5_0.show ~= 0 then
				var_5_2 = false

				goto label_5_0
			end
		end

		var_5_2 = true

		::label_5_0::

		return var_5_2
	end)

	UIItemList = var_1_10002

	local var_3_12 = var_1_10002.StaticAlign
	local var_3_13 = arg_3_0.keywordList
	local var_3_14 = arg_3_0.keywordList

	var_3_12(var_3_13, var_5.GetChild(var_3_14, 0), #var_3_11, function(arg_6_0, arg_6_1, arg_6_2)
		UIItemList = var_2_10003

		if arg_6_0 ~= var_2_10003.EventUpdate then
			return
		end

		local var_6_0 = var_3_11[arg_6_1 + 1]
		local var_6_1 = arg_6_2

		setText = var_2_10005

		var_2_10005(var_6_1:Find("Title"), var_6_0.name)

		setText = var_2_10005

		var_2_10005(var_6_1:Find("Text"), var_6_0.discript)

		setText = var_2_10005

		var_2_10005(var_6_1:Find("Title/EN"), var_6_0.name_EN)

		return
	end)

	pg = var_3_12

	local var_3_15 = var_3_12.UIMgr.GetInstance()

	var_2.BlurPanel(var_3_15, arg_3_0._tf)

	return
end

function var_0_1.willExit(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_7_0, arg_7_0._tf)

	return
end

return var_0_1
