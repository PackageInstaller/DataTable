local var_0_0 = class("CardPuzzleCardView")

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
	arg_1_0._tf = tf(arg_1_1)
	arg_1_0.bgTF = arg_1_0._tf:Find("BG")
	arg_1_0.iconBG = arg_1_0._tf:Find("IconBG")
	arg_1_0.iconTF = arg_1_0.iconBG:Find("Icon")
	arg_1_0.schoolBG = arg_1_0.iconBG:Find("SchoolBG")
	arg_1_0.schoolIcon = arg_1_0.schoolBG:Find("SchoolIcon")
	arg_1_0.nameTF = arg_1_0._tf:Find("Name")
	arg_1_0.descTF = arg_1_0._tf:Find("Desc")
	arg_1_0.costTF = arg_1_0._tf:Find("Cost")
	arg_1_0.keywordListContainer = arg_1_0._tf:Find("KeywordList")

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
	return arg_5_0.data:GetCost()
end

function var_0_0.UpdateView(arg_6_0)
	setImageSprite(arg_6_0.iconTF, LoadSprite(arg_6_0.data:GetIconPath(), ""), true)
	setImageSprite(arg_6_0.iconBG, LoadSprite("ui/CardTowerCardView_atlas", arg_6_0:GetSkillIconBG(arg_6_0.data:GetType())))
	setImageSprite(arg_6_0.bgTF, LoadSprite("ui/CardTowerCardView_atlas", arg_6_0:GetRarityBG(arg_6_0.data:GetRarity())))
	setText(arg_6_0.nameTF, arg_6_0.data:GetName())
	setText(arg_6_0.descTF, arg_6_0.data:GetDesc())
	setText(arg_6_0.costTF, arg_6_0.data:GetCost())

	local var_6_0 = arg_6_0.data:GetKeywords()

	UIItemList.StaticAlign(arg_6_0.keywordListContainer, arg_6_0.keywordListContainer:GetChild(0), #_.filter(var_6_0, function(arg_7_0)
		return arg_7_0.affix_type == var_0_0.AFFIX_TYPE.AFFIX and arg_7_0.show == 0
	end), function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_8_1 = arg_8_1 + 1

		setText(arg_8_2, var_0[arg_8_1].name)

		return
	end)

	local var_6_1 = _.detect(var_6_0, function(arg_9_0)
		return arg_9_0.affix_type == var_0_0.AFFIX_TYPE.SCHOOL and arg_9_0.show == 0
	end)

	setActive(arg_6_0.schoolBG, var_6_1)
	setActive(arg_6_0.schoolIcon, var_6_1)

	if var_6_1 then
		setImageSprite(arg_6_0.schoolBG, LoadSprite("ui/CardTowerCardView_atlas", "circle_" .. var_0_0.TowerCardType2Color[arg_6_0.data:GetType()]))
		setImageSprite(arg_6_0.schoolIcon, LoadSprite("ui/RogueCardSchoolIcons_atlas", var_6_1.icon), true)
	end

	TweenItemAlphaAndWhite(go(arg_6_0._tf))

	return
end

function var_0_0.Clear(arg_10_0)
	ClearTweenItemAlphaAndWhite(go(arg_10_0._tf))

	return
end

return var_0_0
