ys = ys or {}

local var_0_2 = ys.Battle.BattleDataFunction

ys.Battle.CardPuzzleGoalRemind = class("CardPuzzleGoalRemind")
ys.Battle.CardPuzzleGoalRemind.__name = "CardPuzzleGoalRemind"

function ys.Battle.CardPuzzleGoalRemind:Ctor(arg_1_1)
	self._go = arg_1_1

	self:init()

	return
end

function ys.Battle.CardPuzzleGoalRemind:SetCardPuzzleComponent(arg_2_1)
	self._tmp = var_0_2.GetPuzzleDungeonTemplate((arg_2_1:GetPuzzleDungeonID()))

	setText(self._bg:Find("text"), self._tmp.description)

	return
end

function ys.Battle.CardPuzzleGoalRemind:init()
	pg.DelegateInfo.New(self)

	self._tf = self._go.transform
	self._bg = self._tf:Find("bg")

	setText(self._bg:Find("label_ch"), i18n("card_puzzel_goal_ch"))
	setText(self._bg:Find("label_en"), i18n("card_puzzel_goal_en"))

	self._arrow = self._bg:Find("arrow")
	self._openFlag = 1

	onButton(self, self._bg, function()
		local var_4_0 = rtf(self._bg).rect

		rtf(self._bg).sizeDelta = Vector2(var_4_0.width, var_4_0.height + self._openFlag * 22)
		self._openFlag = self._openFlag * -1
		self._arrow.localScale = Vector3(1, self._openFlag, 1)

		return
	end)

	return
end

function ys.Battle.CardPuzzleGoalRemind.Dispose(arg_5_0)
	pg.DelegateInfo.Dispose(arg_5_0)

	arg_5_0._arrow = nil
	arg_5_0._bg = nil
	arg_5_0._tf = nil

	return
end

return
