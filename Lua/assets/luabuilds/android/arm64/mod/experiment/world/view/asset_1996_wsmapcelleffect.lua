local WSMapCellEffect = class("WSMapCellEffect", import(".WSMapEffect"))

WSMapCellEffect.Fields = {
	cell = "table",
	theme = "table"
}
WSMapCellEffect.Listeners = {
	onUpdate = "Update"
}

function WSMapCellEffect:GetName(arg_1_1)
	return "cell_effect_" .. self .. "_" .. arg_1_1
end

function WSMapCellEffect:Setup(arg_2_1, arg_2_2)
	assert(self.cell == nil)

	self.cell = arg_2_1

	self.cell:AddListener(WorldMapCell.EventUpdateInFov, self.onUpdate)
	self.cell:AddListener(WorldMapCell.EventUpdateDiscovered, self.onUpdate)
	self.cell:AddListener(WorldMapCell.EventUpdateFog, self.onUpdate)

	self.theme = arg_2_2

	WSMapCellEffect.super.Setup(self, WorldConst.GetTerrainEffectRes(self.cell:GetTerrain(), self.cell.terrainDir, self.cell.terrainStrong))
	self:Load(function()
		local var_3_0 = self.cell
		local var_3_1 = self.cell:GetTerrain()

		if var_3_1 == WorldMapCell.TerrainStream then
			self:SetModelOrder(WorldConst.LOEffectB, var_3_0.row)
		elseif var_3_1 == WorldMapCell.TerrainWind then
			self:SetModelOrder(WorldConst.LOEffectC, var_3_0.row)
			setActive(self.model:GetChild(0):Find("Xyz/Arrow"), var_3_0.terrainStrong > 0)
			self:UpdateModelScale(WorldConst.GetWindScale(var_3_0.terrainStrong))
		elseif var_3_1 == WorldMapCell.TerrainIce then
			self:SetModelOrder(WorldConst.LOEffectA, var_3_0.row)
		elseif var_3_1 == WorldMapCell.TerrainPoison then
			self:SetModelOrder(WorldConst.LOEffectA, var_3_0.row)
		end

		self:Init()

		return
	end)

	return
end

function WSMapCellEffect:Dispose()
	self.cell:RemoveListener(WorldMapCell.EventUpdateInFov, self.onUpdate)
	self.cell:RemoveListener(WorldMapCell.EventUpdateDiscovered, self.onUpdate)
	self.cell:RemoveListener(WorldMapCell.EventUpdateFog, self.onUpdate)
	WSMapCellEffect.super.Dispose(self)

	return
end

function WSMapCellEffect:Init()
	self.transform.name = WSMapCellEffect.GetName(self.cell.row, self.cell.column)
	self.transform.anchoredPosition3D = self.theme:GetLinePosition(self.cell.row, self.cell.column)

	self:Update()

	return
end

function WSMapCellEffect:Update(arg_6_1)
	if arg_6_1 ~= nil and arg_6_1 ~= WorldMapCell.EventUpdateInFov then
		if arg_6_1 == WorldMapCell.EventUpdateFog then
			setActive(self.transform, self.cell:GetInFOV() and not self.cell:InFog())
		end
	end

	return
end

return WSMapCellEffect
