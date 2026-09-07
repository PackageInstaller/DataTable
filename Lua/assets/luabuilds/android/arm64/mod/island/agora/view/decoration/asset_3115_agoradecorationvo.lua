local AgoraDecorationVO = class("AgoraDecorationVO")

function AgoraDecorationVO:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_1
	self.list = {}
	self.agora = arg_1_2.agora
	self.contoller = arg_1_2:GetController()

	return
end

function AgoraDecorationVO:IsPlaced(arg_2_1)
	return self.agora:IsUsing(arg_2_1) or self.contoller.selectedData and self.contoller.selectedData.id == arg_2_1
end

function AgoraDecorationVO:IsUsing()
	return _.all(self.list, function(arg_4_0)
		return self:IsPlaced(arg_4_0.id)
	end)
end

function AgoraDecorationVO:IsNew()
	return _.any(self.list, function(arg_6_0)
		return arg_6_0:IsNew()
	end)
end

function AgoraDecorationVO:Read()
	return self:GetFirstItem():Read()
end

function AgoraDecorationVO:GetRarity()
	return self:GetFirstItem():GetRarity()
end

function AgoraDecorationVO:AddItem(arg_9_1)
	table.insert(self.list, arg_9_1)

	return
end

function AgoraDecorationVO:GetFirstItem()
	return self.list[1]
end

function AgoraDecorationVO:GetAvailableItem()
	for iter_11_0, iter_11_1 in ipairs(self.list) do
		if not self:IsPlaced(iter_11_1.id) then
			return iter_11_1
		end
	end

	return nil
end

function AgoraDecorationVO:GetAvailableCnt()
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in ipairs(self.list) do
		if not self:IsPlaced(iter_12_1.id) then
			var_12_0 = var_12_0 + 1
		end
	end

	return var_12_0
end

function AgoraDecorationVO:GetMaxCnt()
	return #self.list
end

function AgoraDecorationVO:Contains(arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(self.list) do
		if iter_14_1.id == arg_14_1 then
			return true
		end
	end

	return false
end

function AgoraDecorationVO:IsSame(arg_15_1)
	return self.id == arg_15_1
end

function AgoraDecorationVO:IsType(arg_16_1)
	return self:GetFirstItem():GetType() == arg_16_1
end

function AgoraDecorationVO:IsMatchSearch(arg_17_1)
	if not arg_17_1 or arg_17_1 == "" then
		return true
	end

	return self:GetFirstItem():Match(arg_17_1)
end

function AgoraDecorationVO:GetSortValue(arg_18_1, arg_18_2)
	local var_18_0 = 0

	var_18_0 = arg_18_1 == AgoraFurnitureType.SORT_RARITY and self:GetFirstItem():GetRarity() or arg_18_1 == AgoraFurnitureType.SORT_TIME and self:GetFirstItem():GetTime() or arg_18_1 == AgoraFurnitureType.SORT_CAPACITY and self:GetFirstItem():GetCost() or self:GetFirstItem().id

	return arg_18_2 == 1 and var_18_0 or -1 * var_18_0
end

function AgoraDecorationVO:IsOptionalShapeType()
	return self:GetFirstItem():IsOptionalShapeType()
end

function AgoraDecorationVO:IsBuilding()
	return self:GetFirstItem():IsBuildingType()
end

function AgoraDecorationVO:IsFoundation()
	return self:GetFirstItem():IsFoundationType()
end

function AgoraDecorationVO:GetThemeName()
	local var_22_0 = self:GetFirstItem()

	for iter_22_0, iter_22_1 in ipairs((self.agora:GetSystemThemes())) do
		if iter_22_1:Belong(var_22_0) then
			return iter_22_1.name
		end
	end

	return i18n("agora_belong_theme_none")
end

return AgoraDecorationVO
