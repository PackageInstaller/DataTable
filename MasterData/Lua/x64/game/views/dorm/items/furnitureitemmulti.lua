FurnitureItem = import("game.views.dorm.items.FurnitureItem")

local FurnitureItemMulti = class("FurnitureItemMulti", FurnitureItem)

function FurnitureItemMulti:InitUI()
	FurnitureItemMulti.super.InitUI(self)
	self:AddBtnListener(self.cancelBtn_, nil, function()
		if self.cancelFunc_ then
			self.cancelFunc_(self.id)
		end
	end)
end

function FurnitureItemMulti:RefreshCntText(arg_3_1, arg_3_2)
	if arg_3_1 == 0 and not arg_3_2 then
		self.selectController:SetSelectedState("normal")
	else
		self.cntText_.text = arg_3_1

		if arg_3_2 then
			if arg_3_1 == 0 then
				self.selectController:SetSelectedState("selectNull")
			else
				self.selectController:SetSelectedState("select")
			end
		else
			self.selectController:SetSelectedState("selected")
		end

		self.furNumController:SetSelectedState("two")
	end
end

function FurnitureItemMulti:OnCancelDown(arg_4_1)
	self.cancelFunc_ = arg_4_1
end

return FurnitureItemMulti
