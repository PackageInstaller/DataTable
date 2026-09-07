local ItemCell = class("ItemCell", import("view.level.cell.LevelCellView"))

function ItemCell:Ctor(arg_1_1, arg_1_2, arg_1_3)
	ItemCell.super.Ctor(self)

	self.go = arg_1_1
	self.tf = self.go.transform
	self.line = {
		row = arg_1_2,
		column = arg_1_3
	}
	self.assetName = nil

	self:OverrideCanvas()
	self:ResetCanvasOrder()

	return
end

function ItemCell:Init(arg_2_1)
	if not arg_2_1 then
		return
	end

	self.info = CreateShell(arg_2_1)

	return
end

function ItemCell:GetInfo()
	return self.info
end

function ItemCell:GetOriginalInfo()
	local var_4_0 = self.info and getmetatable(self.info)

	return var_4_0 and var_4_0.__index
end

function ItemCell:Update()
	local var_5_0 = self.info

	self.loader:GetPrefabBYStopLoading("chapter/" .. self.info.item, self.info.item, function(arg_6_0)
		arg_6_0.transform.name = var_5_0.item

		arg_6_0.transform:SetParent(self.go, false)

		arg_6_0.transform.anchoredPosition3D = var_5_0.itemOffset

		self:RecordCanvasOrder(arg_6_0.transform)
		self:AddCanvasOrder(arg_6_0.transform, self:GetCurrentOrder())

		return
	end, "ChapterItem" .. self.line.row .. "_" .. self.line.column)

	return
end

function ItemCell:UpdateAsset(arg_7_1)
	if not self.info or not arg_7_1 or arg_7_1 == rawget(self.info, "item") then
		return
	end

	self.info.item = arg_7_1

	self:Update()

	return
end

function ItemCell:ClearLoader()
	return
end

function ItemCell:Clear()
	self.loader:ClearRequest("ChapterItem" .. self.line.row .. "_" .. self.line.column)
	ItemCell.super.Clear(self)

	return
end

function ItemCell:TransformItemAsset(arg_10_1)
	if type(arg_10_1) ~= "string" then
		return
	end

	local var_10_0 = self:getConfig("ItemTransformPattern")

	if type(var_10_0) ~= "table" then
		return arg_10_1
	end

	_.each(self:getExtraFlags(), function(arg_11_0)
		if var_10_0[arg_11_0] and (function()
			local var_12_0 = var_10_0[arg_11_0][3]

			if not var_10_0[arg_11_0][3] then
				return true
			end

			return var_12_0 >= math.random()
		end)() then
			arg_10_1 = string.gsub(arg_10_1, var_10_0[arg_11_0][1], var_10_0[arg_11_0][2])
		end

		return
	end)

	return arg_10_1
end

return ItemCell
