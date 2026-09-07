ys = ys or {}
ys.Battle.CardPuzzleCommonHPBar = class("CardPuzzleCommonHPBar")
ys.Battle.CardPuzzleCommonHPBar.__name = "CardPuzzleCommonHPBar"

function ys.Battle.CardPuzzleCommonHPBar:Ctor(arg_1_1)
	self._go = arg_1_1
	self._tf = self._go.transform
	self._hpTF = self._tf:Find("fleetBlood/blood")
	self._hpProgress = self._hpTF:GetComponent(typeof(Image))

	return
end

function ys.Battle.CardPuzzleCommonHPBar.SetCardPuzzleComponent(arg_2_0, arg_2_1)
	arg_2_0._info = arg_2_1

	return
end

function ys.Battle.CardPuzzleCommonHPBar:Update()
	self:updateHPBar()

	return
end

function ys.Battle.CardPuzzleCommonHPBar:updateHPBar()
	self._hpProgress.fillAmount = self._info:GetCurrentCommonHP() / self._info:GetTotalCommonHP()

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
