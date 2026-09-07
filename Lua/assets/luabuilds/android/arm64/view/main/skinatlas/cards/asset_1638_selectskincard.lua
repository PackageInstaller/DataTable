local SelectSkinCard = class("SelectSkinCard", import(".SkinAtlasCard"))

function SelectSkinCard:Ctor(arg_1_1)
	SelectSkinCard.super.Ctor(self, arg_1_1)

	self.ownTr = self._tf:Find("own")
	self.timeLimitTr = self._tf:Find("timelimit")

	return
end

function SelectSkinCard:Update(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	SelectSkinCard.super.Update(self, arg_2_1, arg_2_2)

	local var_2_0 = isActive(self.usingTr) or isActive(self.unavailableTr)

	setAnchoredPosition(self.timeLimitTr, {
		y = var_2_0 and -40 or 0
	})
	setActive(self.timeLimitTr, arg_2_3)
	setActive(self.ownTr, arg_2_4)

	return
end

return SelectSkinCard
