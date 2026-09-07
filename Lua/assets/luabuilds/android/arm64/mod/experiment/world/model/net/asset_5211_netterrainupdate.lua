local NetTerrainUpdate = class("NetTerrainUpdate", import("....BaseEntity"))

NetTerrainUpdate.Fields = {
	row = "number",
	terrain = "number",
	terrainDir = "number",
	column = "number",
	terrainStrong = "number"
}

function NetTerrainUpdate:DebugPrint()
	return "{" .. self.row .. "," .. self.column .. "} " .. self.terrain
end

function NetTerrainUpdate:Setup(arg_2_1)
	self.row = arg_2_1.pos.row
	self.column = arg_2_1.pos.column
	self.terrain = arg_2_1.type

	if self.terrain == WorldMapCell.TerrainStream then
		self.terrainDir = WorldConst.ParseConfigDir(arg_2_1.dir.row - 1, arg_2_1.dir.column - 1)
	elseif self.terrain == WorldMapCell.TerrainWind then
		self.terrainDir = WorldConst.ParseConfigDir(arg_2_1.dir.row - 1, arg_2_1.dir.column - 1)
		self.terrainStrong = arg_2_1.distance
	elseif self.terrain == WorldMapCell.TerrainFog then
		self.terrainStrong = arg_2_1.distance
	elseif self.terrain == WorldMapCell.TerrainPoison then
		self.terrainStrong = arg_2_1.distance
	end

	return
end

function NetTerrainUpdate:GetTerrain()
	return self.terrain
end

return NetTerrainUpdate
