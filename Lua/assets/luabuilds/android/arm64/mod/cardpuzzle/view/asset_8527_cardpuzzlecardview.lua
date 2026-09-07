local CardPuzzleCardView = class("CardPuzzleCardView")

CardPuzzleCardView.AFFIX_TYPE = {
	TAG = 0,
	AFFIX = 2,
	SCHOOL = 1
}
CardPuzzleCardView.CARD_TYPE = {
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

CardPuzzleCardView.TowerCardType2Color = {
	"red",
	"blue",
	"yellow"
}

function CardPuzzleCardView:Ctor(arg_1_1)
	self._tf = tf(arg_1_1)
	self.bgTF = self._tf:Find("BG")
	self.iconBG = self._tf:Find("IconBG")
	self.iconTF = self.iconBG:Find("Icon")
	self.schoolBG = self.iconBG:Find("SchoolBG")
	self.schoolIcon = self.schoolBG:Find("SchoolIcon")
	self.nameTF = self._tf:Find("Name")
	self.descTF = self._tf:Find("Desc")
	self.costTF = self._tf:Find("Cost")
	self.keywordListContainer = self._tf:Find("KeywordList")

	return
end

function CardPuzzleCardView:SetData(arg_2_1)
	self.data = arg_2_1

	return
end

function CardPuzzleCardView:GetSkillIconBG(arg_3_1)
	return "icon_bg_" .. CardPuzzleCardView.TowerCardType2Color[arg_3_1]
end

function CardPuzzleCardView:GetRarityBG(arg_4_1)
	return var_0_1[arg_4_1]
end

function CardPuzzleCardView:GetCardCost()
	return self.data:GetCost()
end

function CardPuzzleCardView:UpdateView()
	setImageSprite(self.iconTF, LoadSprite(self.data:GetIconPath(), ""), true)
	setImageSprite(self.iconBG, LoadSprite("ui/CardTowerCardView_atlas", self:GetSkillIconBG(self.data:GetType())))
	setImageSprite(self.bgTF, LoadSprite("ui/CardTowerCardView_atlas", self:GetRarityBG(self.data:GetRarity())))
	setText(self.nameTF, self.data:GetName())
	setText(self.descTF, self.data:GetDesc())
	setText(self.costTF, self.data:GetCost())

	local var_6_0 = self.data:GetKeywords()
	local var_6_1 = _.filter(var_6_0, function(arg_7_0)
		return arg_7_0.affix_type == CardPuzzleCardView.AFFIX_TYPE.AFFIX and arg_7_0.show == 0
	end)

	UIItemList.StaticAlign(self.keywordListContainer, self.keywordListContainer:GetChild(0), #var_6_1, function(arg_8_0, arg_8_1, arg_8_2)
		if arg_8_0 ~= UIItemList.EventUpdate then
			return
		end

		arg_8_1 = arg_8_1 + 1

		setText(arg_8_2, var_6_1[arg_8_1].name)

		return
	end)

	local var_6_2 = _.detect(var_6_0, function(arg_9_0)
		return arg_9_0.affix_type == CardPuzzleCardView.AFFIX_TYPE.SCHOOL and arg_9_0.show == 0
	end)

	setActive(self.schoolBG, var_6_2)
	setActive(self.schoolIcon, var_6_2)

	if var_6_2 then
		setImageSprite(self.schoolBG, LoadSprite("ui/CardTowerCardView_atlas", "circle_" .. CardPuzzleCardView.TowerCardType2Color[self.data:GetType()]))
		setImageSprite(self.schoolIcon, LoadSprite("ui/RogueCardSchoolIcons_atlas", var_6_2.icon), true)
	end

	TweenItemAlphaAndWhite(go(self._tf))

	return
end

function CardPuzzleCardView:Clear()
	ClearTweenItemAlphaAndWhite(go(self._tf))

	return
end

return CardPuzzleCardView
