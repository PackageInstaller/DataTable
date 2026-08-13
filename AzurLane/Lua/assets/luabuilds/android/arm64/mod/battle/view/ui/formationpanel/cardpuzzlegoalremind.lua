ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleCardPuzzleEvent
local var_0_3 = var_0.Battle.BattleDataFunction
local var_0_4 = var_0.Battle

class = var_0_10005
var_0_4.CardPuzzleGoalRemind = var_0_10005("CardPuzzleGoalRemind")

local var_0_5 = var_0.Battle.CardPuzzleGoalRemind

var_0_5.__name = "CardPuzzleGoalRemind"

function var_0_5.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1

	arg_1_0:init()

	return
end

function var_0_5.SetCardPuzzleComponent(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:GetPuzzleDungeonID()

	arg_2_0._tmp = var_0_3.GetPuzzleDungeonTemplate(var_2_0)
	setText = var_3

	local var_2_1 = arg_2_0._bg

	var_3(var_5.Find(var_2_1, "text"), arg_2_0._tmp.description)

	return
end

function var_0_5.init(arg_3_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.New(arg_3_0)

	arg_3_0._tf = arg_3_0._go.transform

	local var_3_0 = arg_3_0._tf

	arg_3_0._bg = var_1.Find(var_3_0, "bg")
	setText = var_1

	local var_3_1 = arg_3_0._bg
	local var_3_2 = var_3.Find(var_3_1, "label_ch")

	i18n = var_4

	var_1(var_3_2, var_4("card_puzzel_goal_ch"))

	setText = var_1

	local var_3_3 = arg_3_0._bg
	local var_3_4 = var_3.Find(var_3_3, "label_en")

	i18n = var_4

	var_1(var_3_4, var_4("card_puzzel_goal_en"))

	local var_3_5 = arg_3_0._bg

	arg_3_0._arrow = var_1.Find(var_3_5, "arrow")
	arg_3_0._openFlag = 1
	onButton = var_1

	var_1(arg_3_0, arg_3_0._bg, function()
		rtf = var_2_10000

		local var_4_0 = var_2_10000(arg_3_0._bg).rect.height + arg_3_0._openFlag * 22

		rtf = var_2

		local var_4_1 = var_2(arg_3_0._bg)

		Vector2 = var_2_10003
		var_4_1.sizeDelta = var_2_10003(var_0.width, var_4_0)
		arg_3_0._openFlag = arg_3_0._openFlag * -1

		local var_4_2 = arg_3_0._arrow

		Vector3 = var_3
		var_4_2.localScale = var_3(1, arg_3_0._openFlag, 1)

		return
	end)

	return
end

function var_0_5.Dispose(arg_5_0)
	pg = var_1_10001

	var_1_10001.DelegateInfo.Dispose(arg_5_0)

	arg_5_0._arrow = nil
	arg_5_0._bg = nil
	arg_5_0._tf = nil

	return
end

return
