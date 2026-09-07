local MonopolyCar2026PickPage = class("MonopolyCar2026PickPage", import("..MonopolyCar2024.MonopolyCar2024PickPage"))

function MonopolyCar2026PickPage:getUIName()
	return "MonopolyCar2026PickUI"
end

function MonopolyCar2026PickPage:UpdateList()
	MonopolyCar2026PickPage.super.UpdateList(self)

	local var_2_0 = #self.banList == 0 and self.turnCnt <= 1

	for iter_2_0 = 2, #self.items do
		setActive(self.items[iter_2_0], not var_2_0)
	end

	return
end

return MonopolyCar2026PickPage
