local CourtYardCanPutFurnitureModule = class("CourtYardCanPutFurnitureModule", import(".CourtYardFurnitureModule"))
local var_0_1 = false

function CourtYardCanPutFurnitureModule:Ctor(arg_1_1, arg_1_2)
	CourtYardCanPutFurnitureModule.super.Ctor(self, arg_1_1, arg_1_2)

	self.childModules = {}

	return
end

function CourtYardCanPutFurnitureModule:OnInit()
	CourtYardCanPutFurnitureModule.super.OnInit(self)

	if var_0_1 then
		self.mapDebug = CourtYardMapDebug.New(self.data.placeableArea, Color.New(1, 0, 0))
		GetOrAddComponent(self:GetParentTF(), typeof(CanvasGroup)).alpha = 0.3
	end

	self:RefreshDepth()

	return
end

function CourtYardCanPutFurnitureModule:AddChild(arg_3_1)
	self:CancelPuddingAnim()
	arg_3_1:CancelPuddingAnim()

	self.childModules[arg_3_1.data:GetDeathType() .. arg_3_1.data.id] = arg_3_1

	arg_3_1._tf:SetParent(self.childsTF)

	return
end

function CourtYardCanPutFurnitureModule:RemoveChild(arg_4_1)
	self.childModules[arg_4_1.data:GetDeathType() .. arg_4_1.data.id] = nil

	arg_4_1._tf:SetParent(self:GetParentTF())

	return
end

function CourtYardCanPutFurnitureModule:AddListeners()
	CourtYardCanPutFurnitureModule.super.AddListeners(self)
	self:AddAreaListener(CourtYardEvent.REMOVE_ITEM, self.OnRemoveItem)
	self:AddAreaListener(CourtYardEvent.ADD_ITEM, self.OnAddItem)

	return
end

function CourtYardCanPutFurnitureModule:RemoveListeners()
	CourtYardCanPutFurnitureModule.super.RemoveListeners(self)
	self:RemoveAreaListener(CourtYardEvent.REMOVE_ITEM, self.OnRemoveItem)
	self:RemoveAreaListener(CourtYardEvent.ADD_ITEM, self.OnAddItem)

	return
end

function CourtYardCanPutFurnitureModule:AddAreaListener(arg_7_1, arg_7_2)
	local function var_7_0(arg_8_0, arg_8_1, ...)
		arg_7_2(self, ...)

		return
	end

	self.callbacks[arg_7_2] = var_7_0

	self.data.placeableArea:AddListener(arg_7_1, var_7_0)

	return
end

function CourtYardCanPutFurnitureModule:RemoveAreaListener(arg_9_1, arg_9_2)
	if self.callbacks[arg_9_2] then
		self.data.placeableArea:RemoveListener(arg_9_1, self.callbacks[arg_9_2])

		self.callbacks[self.callbacks[arg_9_2]] = nil
	end

	return
end

function CourtYardCanPutFurnitureModule:OnRemoveItem(arg_10_1)
	self.childModules[arg_10_1:GetDeathType() .. arg_10_1.id]._tf:SetParent(self:GetParentTF())

	if var_0_1 then
		self.mapDebug:Flush()
	end

	return
end

function CourtYardCanPutFurnitureModule:OnAddItem(arg_11_1)
	local var_11_0 = self.childModules[arg_11_1:GetDeathType() .. arg_11_1.id]

	var_11_0._tf:SetParent(self.childsTF)

	var_11_0._tf.localPosition = var_11_0._tf.localPosition + arg_11_1:GetOffset()

	self:RefreshDepth()

	if var_0_1 then
		self.mapDebug:Flush()
	end

	return
end

function CourtYardCanPutFurnitureModule:RefreshDepth()
	for iter_12_0, iter_12_1 in ipairs(self.data.placeableArea:GetItems()) do
		self.childModules[iter_12_1:GetDeathType() .. iter_12_1.id]:SetSiblingIndex(iter_12_0 - 1)
	end

	return
end

function CourtYardCanPutFurnitureModule:BlocksRaycasts(arg_13_1)
	if (self.data:CanClickWhenExitEditMode() or #self.data:GetUsingSlots() > 0 or table.getCount(self.childModules) > 0) and arg_13_1 == false then
		return
	end

	self.cg.blocksRaycasts = arg_13_1

	return
end

function CourtYardCanPutFurnitureModule:Dispose()
	CourtYardCanPutFurnitureModule.super.Dispose(self)

	if var_0_1 then
		self.mapDebug:Dispose()

		GetOrAddComponent(self:GetParentTF(), typeof(CanvasGroup)).alpha = 1
	end

	return
end

return CourtYardCanPutFurnitureModule
