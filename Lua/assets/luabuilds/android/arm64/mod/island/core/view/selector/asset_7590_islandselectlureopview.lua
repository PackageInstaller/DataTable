local IslandSelectLureOpView = class("IslandSelectLureOpView", import(".IslandSelectableOpView"))

function IslandSelectLureOpView:GetDisplayData()
	return (self:GetIsland():GetInventoryAgency():GetFishingItems())
end

function IslandSelectLureOpView:GetTargetTr()
	return self:GetView():GetSubView(IslandOpView).lureBtn
end

function IslandSelectLureOpView:GetSelectedId()
	return self:GetIsland():GetFishingAgency():GetBaitId()
end

function IslandSelectLureOpView:OnSelected(arg_4_1)
	self:NotifiyMeditor(IslandBaseMediator.EXCHANGE_LURE, arg_4_1, self:GetView():GetSubView(IslandOpView).unitId)

	return
end

function IslandSelectLureOpView:IsShowItemCount()
	return false
end

return IslandSelectLureOpView
