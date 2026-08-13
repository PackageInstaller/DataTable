class = var_0_10000

local var_0_0 = var_0_10000("CardPuzzleCardView")

var_0_0.AFFIX_TYPE = {
	TAG = 0,
	AFFIX = 2,
	SCHOOL = 1
}
var_0_0.CARD_TYPE = {
	ATTACK = 1,
	ABILITY = 3,
	TACTIC = 2
}

local var_0_1 = {
	[0] = "cardBG_white",
	"cardBG_white",
	"cardBG_blue",
	"cardBG_purple",
	"cardBG_yellow"
}

var_0_0.TowerCardType2Color = {
	"red",
	"blue",
	"yellow"
}

function var_0_0.Ctor(arg_1_0, arg_1_1)
	tf = var_1_10002
	arg_1_0._tf = var_1_10002(arg_1_1)

	local var_1_0 = arg_1_0._tf

	arg_1_0.bgTF = var_2.Find(var_1_0, "BG")

	local var_1_1 = arg_1_0._tf

	arg_1_0.iconBG = var_2.Find(var_1_1, "IconBG")

	local var_1_2 = arg_1_0.iconBG

	arg_1_0.iconTF = var_2.Find(var_1_2, "Icon")

	local var_1_3 = arg_1_0.iconBG

	arg_1_0.schoolBG = var_2.Find(var_1_3, "SchoolBG")

	local var_1_4 = arg_1_0.schoolBG

	arg_1_0.schoolIcon = var_2.Find(var_1_4, "SchoolIcon")

	local var_1_5 = arg_1_0._tf

	arg_1_0.nameTF = var_2.Find(var_1_5, "Name")

	local var_1_6 = arg_1_0._tf

	arg_1_0.descTF = var_2.Find(var_1_6, "Desc")

	local var_1_7 = arg_1_0._tf

	arg_1_0.costTF = var_2.Find(var_1_7, "Cost")

	local var_1_8 = arg_1_0._tf

	arg_1_0.keywordListContainer = var_2.Find(var_1_8, "KeywordList")

	return
end

function var_0_0.SetData(arg_2_0, arg_2_1)
	arg_2_0.data = arg_2_1

	return
end

function var_0_0.GetSkillIconBG(arg_3_0, arg_3_1)
	return "icon_bg_" .. var_0_0.TowerCardType2Color[arg_3_1]
end

function var_0_0.GetRarityBG(arg_4_0, arg_4_1)
	return var_0_1[arg_4_1]
end

function var_0_0.GetCardCost(arg_5_0)
	local var_5_0 = arg_5_0.data

	return var_1.GetCost(var_5_0)
end

function var_0_0.UpdateView(arg_6_0)
	setImageSprite = var_1_10001

	local var_6_0 = arg_6_0.iconTF

	LoadSprite = var_1_10004

	local var_6_1 = arg_6_0.data

	var_1_10001(var_6_0, var_1_10004(var_6.GetIconPath(var_6_1), ""), true)

	setImageSprite = var_1_10001

	local var_6_2 = arg_6_0.iconBG

	LoadSprite = var_4

	local var_6_3 = "ui/CardTowerCardView_atlas"
	local var_6_4 = arg_6_0
	local var_6_5 = arg_6_0.GetSkillIconBG
	local var_6_6 = arg_6_0.data

	var_1_10001(var_6_2, var_4(var_6_3, var_6_5(var_6_4, var_10.GetType(var_6_6))))

	setImageSprite = var_1_10001

	local var_6_7 = arg_6_0.bgTF

	LoadSprite = var_4

	local var_6_8 = "ui/CardTowerCardView_atlas"
	local var_6_9 = arg_6_0
	local var_6_10 = arg_6_0.GetRarityBG
	local var_6_11 = arg_6_0.data

	var_1_10001(var_6_7, var_4(var_6_8, var_6_10(var_6_9, var_10.GetRarity(var_6_11))))

	setText = var_1_10001

	local var_6_12 = arg_6_0.nameTF
	local var_6_13 = arg_6_0.data

	var_1_10001(var_6_12, var_4.GetName(var_6_13))

	setText = var_1_10001

	local var_6_14 = arg_6_0.descTF
	local var_6_15 = arg_6_0.data

	var_1_10001(var_6_14, var_4.GetDesc(var_6_15))

	setText = var_1_10001

	local var_6_16 = arg_6_0.costTF
	local var_6_17 = arg_6_0.data

	var_1_10001(var_6_16, var_4.GetCost(var_6_17))

	local var_6_18 = arg_6_0.data
	local var_6_19 = var_1.GetKeywords(var_6_18)

	_ = var_1_10002

	local var_6_20 = var_1_10002.filter(var_6_19, function(arg_7_0)
		return arg_7_0.affix_type == var_0_0.AFFIX_TYPE.AFFIX and arg_7_0.show == 0
	end)

	UIItemList = var_6_18

	local var_6_21 = var_6_18.StaticAlign
	local var_6_22 = arg_6_0.keywordListContainer
	local var_6_23 = arg_6_0.keywordListContainer

	var_6_21(var_6_22, var_6.GetChild(var_6_23, 0), #var_6_20, function(arg_8_0, arg_8_1, arg_8_2)
		UIItemList = var_2_10003

		if arg_8_0 ~= var_2_10003.EventUpdate then
			return
		end

		arg_8_1 = arg_8_1 + 1
		setText = var_3

		var_3(arg_8_2, var_6_20[arg_8_1].name)

		return
	end)

	_ = var_6_21

	local var_6_24 = var_6_21.detect(var_6_19, function(arg_9_0)
		return arg_9_0.affix_type == var_0_0.AFFIX_TYPE.SCHOOL and arg_9_0.show == 0
	end)

	setActive = var_4

	var_4(arg_6_0.schoolBG, var_6_24)

	setActive = var_4

	var_4(arg_6_0.schoolIcon, var_6_24)

	local var_6_25

	if var_6_24 then
		setImageSprite = var_4
		var_6_25 = arg_6_0.schoolBG
		LoadSprite = var_7

		local var_6_26 = "ui/CardTowerCardView_atlas"
		local var_6_27 = "circle_"
		local var_6_28 = var_0_0.TowerCardType2Color
		local var_6_29 = arg_6_0.data

		var_4(var_6_25, var_7(var_6_26, var_6_27 .. var_6_28[var_12.GetType(var_6_29)]))

		setImageSprite = var_4
		var_6_25 = arg_6_0.schoolIcon
		LoadSprite = var_7

		var_4(var_6_25, var_7("ui/RogueCardSchoolIcons_atlas", var_6_24.icon), true)
	end

	TweenItemAlphaAndWhite = var_4
	go = var_6_25

	var_4(var_6_25(arg_6_0._tf))

	return
end

function var_0_0.Clear(arg_10_0)
	ClearTweenItemAlphaAndWhite = var_1_10001
	go = var_1_10003

	var_1_10001(var_1_10003(arg_10_0._tf))

	return
end

return var_0_0
