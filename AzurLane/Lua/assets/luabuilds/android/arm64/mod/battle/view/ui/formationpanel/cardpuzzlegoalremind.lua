ys = ys or {}

local var_0_2 = ys.Battle.BattleDataFunction

ys.Battle.CardPuzzleGoalRemind = class("CardPuzzleGoalRemind")
ys.Battle.CardPuzzleGoalRemind.__name = "CardPuzzleGoalRemind"

function ys.Battle.CardPuzzleGoalRemind.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1

	arg_1_0:init()

	return
end

function ys.Battle.CardPuzzleGoalRemind.SetCardPuzzleComponent(arg_2_0, arg_2_1)
	arg_2_0._tmp = var_0_2.GetPuzzleDungeonTemplate((arg_2_1:GetPuzzleDungeonID()))

	setText(arg_2_0._bg:Find("text"), arg_2_0._tmp.description)

	return
end

function ys.Battle.CardPuzzleGoalRemind.init(arg_3_0)
	pg.DelegateInfo.New(arg_3_0)

	arg_3_0._tf = arg_3_0._go.transform
	arg_3_0._bg = arg_3_0._tf:Find("bg")

	setText(arg_3_0._bg:Find("label_ch"), i18n("card_puzzel_goal_ch"))
	setText(arg_3_0._bg:Find("label_en"), i18n("card_puzzel_goal_en"))

	arg_3_0._arrow = arg_3_0._bg:Find("arrow")
	arg_3_0._openFlag = 1

	onButton(arg_3_0, arg_3_0._bg, function()
		local var_4_0 = rtf(arg_3_0._bg).rect

		rtf(arg_3_0._bg).sizeDelta = Vector2(var_4_0.width, var_4_0.height + arg_3_0._openFlag * 22)
		arg_3_0._openFlag = arg_3_0._openFlag * -1
		arg_3_0._arrow.localScale = Vector3(1, arg_3_0._openFlag, 1)

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
