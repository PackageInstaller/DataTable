local CourtYardFurnitureSlot = class("CourtYardFurnitureSlot", import(".CourtYardFurnitureBaseSlot"))

function CourtYardFurnitureSlot:OnInit(arg_1_1)
	self.actionName = arg_1_1[1]
	self.offset = arg_1_1[2] and Vector3(arg_1_1[2][1], arg_1_1[2][2], 0) or Vector3.zero
	self.scale = arg_1_1[3] and Vector3(arg_1_1[3][1], arg_1_1[3][2], 1) or Vector3.one
	self.mask = arg_1_1[4]

	local var_1_0 = arg_1_1[6]

	if arg_1_1[6] then
		var_1_0 = {}
		var_1_0.offset = arg_1_1[6][1] and Vector2(arg_1_1[6][1][1], arg_1_1[6][1][2]) or Vector3.zero
		var_1_0.size = arg_1_1[6][2] and Vector2(arg_1_1[6][2][1], arg_1_1[6][2][2]) or Vector3.zero
		var_1_0.img = arg_1_1[6][3]
	end

	self.bodyMask = var_1_0

	return
end

function CourtYardFurnitureSlot:OnInitCombine(arg_2_1)
	self.combineData = arg_2_1

	return
end

function CourtYardFurnitureSlot:GetMask()
	if self.mask == "" then
		return nil
	end

	return self.mask
end

function CourtYardFurnitureSlot:OnStart()
	local var_4_0 = self:GetCombineFurnitureAnimator()

	if var_4_0 then
		return var_4_0[2] or self.defaultAction
	end

	self.user:UpdateInteraction({
		action = self.actionName
	})

	return
end

return CourtYardFurnitureSlot
