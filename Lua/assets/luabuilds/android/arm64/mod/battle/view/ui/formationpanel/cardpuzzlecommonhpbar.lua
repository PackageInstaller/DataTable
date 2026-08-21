ys = ys or {}
ys.Battle.CardPuzzleCommonHPBar = class("CardPuzzleCommonHPBar")
ys.Battle.CardPuzzleCommonHPBar.__name = "CardPuzzleCommonHPBar"

function ys.Battle.CardPuzzleCommonHPBar.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tf = arg_1_0._go.transform
	arg_1_0._hpTF = arg_1_0._tf:Find("fleetBlood/blood")
	arg_1_0._hpProgress = arg_1_0._hpTF:GetComponent(typeof(Image))

	return
end

function ys.Battle.CardPuzzleCommonHPBar.SetCardPuzzleComponent(arg_2_0, arg_2_1)
	arg_2_0._info = arg_2_1

	return
end

function ys.Battle.CardPuzzleCommonHPBar.Update(arg_3_0)
	arg_3_0:updateHPBar()

	return
end

function ys.Battle.CardPuzzleCommonHPBar.updateHPBar(arg_4_0)
	arg_4_0._hpProgress.fillAmount = arg_4_0._info:GetCurrentCommonHP() / arg_4_0._info:GetTotalCommonHP()

	return
end

function ys.Battle.CardPuzzleCommonHPBar.Dispose(arg_5_0)
	arg_5_0._hpProgress = nil
	arg_5_0._hpTF = nil
	arg_5_0._tf = nil
	arg_5_0._go = nil

	return
end

function ys.Battle.CardPuzzleCommonHPBar.updateResource(arg_6_0)
	return
end

return
