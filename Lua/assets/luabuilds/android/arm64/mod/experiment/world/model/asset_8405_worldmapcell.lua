local WorldMapCell = class("WorldMapCell", import("...BaseEntity"))

WorldMapCell.Fields = {
	inLight = "number",
	row = "number",
	fogLight = "boolean",
	terrain = "number",
	dir = "number",
	column = "number",
	walkable = "boolean",
	terrainDir = "number",
	discovered = "boolean",
	attachments = "table",
	fogSairen = "boolean",
	fog = "boolean",
	terrainStrong = "number",
	infov = "number"
}
WorldMapCell.EventAddAttachment = "WorldMapCell.EventAddAttachment"
WorldMapCell.EventRemoveAttachment = "WorldMapCell.EventRemoveAttachment"
WorldMapCell.EventUpdateInFov = "WorldMapCell.EventUpdateInFov"
WorldMapCell.EventUpdateDiscovered = "WorldMapCell.EventUpdateDiscovered"
WorldMapCell.EventUpdateFog = "WorldMapCell.EventUpdateFog"
WorldMapCell.EventUpdateFogImage = "WorldMapCell.EventUpdateFogImage"
WorldMapCell.EventUpdateTerrain = "WorldMapCell.EventUpdateTerrain"

function WorldMapCell:GetName(arg_1_1)
	return "cell_" .. self .. "_" .. arg_1_1
end

WorldMapCell.TerrainNone = 0
WorldMapCell.TerrainStream = 1
WorldMapCell.TerrainIce = 2
WorldMapCell.TerrainWind = 3
WorldMapCell.TerrainFog = 4
WorldMapCell.TerrainFire = 5
WorldMapCell.TerrainPoison = 6

function WorldMapCell:Build()
	self.attachments = {}
	self.dir = 0
	self.infov = 0
	self.inLight = 0
	self.fog = false
	self.fogLight = false
	self.fogSairen = false

	return
end

function WorldMapCell:Setup(arg_3_1)
	self.row = arg_3_1[1]
	self.column = arg_3_1[2]
	self.walkable = arg_3_1[3]

	return
end

function WorldMapCell:Dispose()
	WPool:ReturnArray(self.attachments)
	self:Clear()

	return
end

function WorldMapCell:AddAttachment(arg_5_1)
	assert(not _.any(self.attachments, function(arg_6_0)
		return arg_6_0.row == arg_5_1.row and arg_6_0.column == arg_5_1.column and arg_6_0.type == arg_5_1.type and arg_6_0.id == arg_5_1.id
	end))
	assert(arg_5_1.row == self.row and arg_5_1.column == self.column)
	assert(WorldMapAttachment.SortOrder[arg_5_1.type], arg_5_1.type .. " : sort order not set.")

	local var_5_0 = #self.attachments + 1

	for iter_5_0, iter_5_1 in ipairs(self.attachments) do
		if WorldMapAttachment.SortOrder[arg_5_1.type] > WorldMapAttachment.SortOrder[iter_5_1.type] then
			var_5_0 = iter_5_0

			break
		end
	end

	table.insert(self.attachments, var_5_0, arg_5_1)
	self:DispatchEvent(WorldMapCell.EventAddAttachment, arg_5_1)

	if not self.discovered and arg_5_1:ShouldMarkAsLurk() then
		arg_5_1:UpdateLurk(true)
	end

	return
end

function WorldMapCell:RemoveAttachment(arg_7_1)
	if arg_7_1 == nil or type(arg_7_1) == "number" then
		arg_7_1 = arg_7_1 or #self.attachments

		assert(arg_7_1 >= 1 and arg_7_1 <= #self.attachments)
		table.remove(self.attachments, arg_7_1)
		self:DispatchEvent(WorldMapCell.EventRemoveAttachment, self.attachments[arg_7_1])
		WPool:Return(self.attachments[arg_7_1])
	elseif arg_7_1.class == WorldMapAttachment then
		for iter_7_0 = #self.attachments, 1, -1 do
			if self.attachments[iter_7_0] == arg_7_1 then
				self:RemoveAttachment(iter_7_0)

				break
			end
		end
	end

	return
end

function WorldMapCell:ContainsAttachment(arg_8_1)
	return _.any(self.attachments, function(arg_9_0)
		return arg_9_0 == arg_8_1
	end)
end

function WorldMapCell:GetInFOV()
	if self.fog then
		return self.fogLight
	else
		return self.infov > 0 or self.inLight > 0
	end

	return
end

function WorldMapCell:UpdateInFov(arg_11_1)
	AfterCheck({
		{
			function()
				return self:GetInFOV()
			end,
			function()
				self:DispatchEvent(WorldMapCell.EventUpdateInFov)

				return
			end
		}
	}, function()
		self.infov = arg_11_1

		return
	end)

	return
end

function WorldMapCell:ChangeInLight(arg_15_1)
	AfterCheck({
		{
			function()
				return self:GetInFOV()
			end,
			function()
				self:DispatchEvent(WorldMapCell.EventUpdateInFov)

				return
			end
		}
	}, function()
		self.inLight = self.inLight + (arg_15_1 and 1 or -1)

		return
	end)

	return
end

function WorldMapCell:InFog()
	if self.fog then
		return not self.fogLight
	else
		return self:GetTerrain() == WorldMapCell.TerrainFog
	end

	return
end

function WorldMapCell:LookSairenFog()
	return self.fogSairen or self:IsTerrainSairenFog()
end

function WorldMapCell:UpdateFog(arg_21_1, arg_21_2, arg_21_3)
	AfterCheck({
		{
			function()
				return self:GetInFOV()
			end,
			function()
				self:DispatchEvent(WorldMapCell.EventUpdateInFov)

				return
			end
		},
		{
			function()
				return self:InFog()
			end,
			function()
				self:DispatchEvent(WorldMapCell.EventUpdateFog)

				return
			end
		},
		{
			function()
				return self:LookSairenFog()
			end,
			function()
				self:DispatchEvent(WorldMapCell.EventUpdateFogImage)

				return
			end
		}
	}, function()
		self.fog = defaultValue(arg_21_1, self.fog)
		self.fogLight = defaultValue(arg_21_2, self.fogLight)
		self.fogSairen = defaultValue(arg_21_3, self.fogSairen)

		return
	end)

	return
end

function WorldMapCell:UpdateDiscovered(arg_29_1)
	if self.discovered ~= arg_29_1 then
		self.discovered = arg_29_1

		self:DispatchEvent(WorldMapCell.EventUpdateDiscovered)
	end

	return
end

function WorldMapCell:GetTerrain()
	return self.terrain or WorldMapCell.TerrainNone
end

function WorldMapCell:UpdateTerrain(arg_31_1, arg_31_2, arg_31_3)
	AfterCheck({
		{
			function()
				return self:InFog()
			end,
			function()
				self:DispatchEvent(WorldMapCell.EventUpdateFog)

				return
			end
		},
		{
			function()
				return self:LookSairenFog()
			end,
			function()
				self:DispatchEvent(WorldMapCell.EventUpdateFogImage)

				return
			end
		}
	}, function()
		self.terrain = arg_31_1

		if self.terrain == WorldMapCell.TerrainStream then
			assert(arg_31_2)

			self.terrainDir = arg_31_2
		elseif self.terrain == WorldMapCell.TerrainWind then
			assert(arg_31_2 and arg_31_3)

			self.terrainDir = arg_31_2
			self.terrainStrong = arg_31_3
		elseif self.terrain == WorldMapCell.TerrainFog then
			self.terrainStrong = arg_31_3
		elseif self.terrain == WorldMapCell.TerrainPoison then
			self.terrainStrong = arg_31_3
		end

		self:DispatchEvent(WorldMapCell.EventUpdateTerrain)

		return
	end)

	return
end

function WorldMapCell:GetAliveAttachments()
	return _.filter(self.attachments, function(arg_38_0)
		return arg_38_0:IsAlive()
	end)
end

function WorldMapCell:GetAliveAttachment()
	return _.detect(self.attachments, function(arg_40_0)
		return arg_40_0:IsAlive()
	end)
end

function WorldMapCell:GetDisplayAttachment()
	return _.detect(self.attachments, function(arg_42_0)
		return arg_42_0:IsAlive() and arg_42_0:IsVisible()
	end)
end

function WorldMapCell:GetInterativeAttachment()
	return _.detect(self.attachments, function(arg_44_0)
		return WorldMapAttachment.IsInteractiveType(arg_44_0.type) and arg_44_0:IsAlive() and arg_44_0:IsVisible()
	end)
end

function WorldMapCell:GetEventAttachment()
	return _.detect(self.attachments, function(arg_46_0)
		return arg_46_0:IsAlive() and arg_46_0.type == WorldMapAttachment.TypeEvent
	end)
end

function WorldMapCell:GetCompassAttachment()
	local var_47_0 = {}

	for iter_47_0, iter_47_1 in ipairs(self.attachments) do
		table.insert(var_47_0, iter_47_0)
	end

	local var_47_1 = _.detect(_.sort(var_47_0, function(arg_48_0, arg_48_1)
		return (self.attachments[arg_48_1].config.compass_index or 0) < (self.attachments[arg_48_0].config.compass_index or 0)
	end), function(arg_49_0)
		if self.attachments[arg_49_0]:ShouldMarkAsLurk() then
			return self.attachments[arg_49_0]:IsAlive() and self.attachments[arg_49_0]:IsVisible() and self.discovered
		elseif self.attachments[arg_49_0].type == WorldMapAttachment.TypeEvent then
			return self.attachments[arg_49_0]:IsAlive() and self.attachments[arg_49_0].config.visuality == 0
		elseif self.attachments[arg_49_0].type ~= WorldMapAttachment.TypeFleet and self.attachments[arg_49_0].type ~= WorldMapAttachment.TypePort then
			return self.attachments[arg_49_0]:IsAlive()
		end

		return
	end)

	return var_47_1 and self.attachments[var_47_1]
end

function WorldMapCell:FindAliveAttachment(arg_50_1)
	assert(arg_50_1 ~= nil)

	return _.detect(self.attachments, function(arg_51_0)
		return arg_51_0:IsAlive() and arg_51_0.type == arg_50_1
	end)
end

function WorldMapCell:IsTerrainSairenFog()
	return self.terrain == WorldMapCell.TerrainFog and self.terrainStrong == 0
end

function WorldMapCell:CanLeave()
	local var_53_0 = self.walkable

	if self.walkable then
		var_53_0 = self:GetTerrainObstacleConfig("leave")
		var_53_0 = var_53_0 and underscore.all(self.attachments, function(arg_54_0)
			return not arg_54_0:IsAlive() or arg_54_0:CanLeave()
		end)
	end

	return var_53_0
end

function WorldMapCell:CanArrive()
	local var_55_0 = self.walkable

	if self.walkable then
		var_55_0 = self:GetTerrainObstacleConfig("arrive")
		var_55_0 = var_55_0 and underscore.all(self.attachments, function(arg_56_0)
			return not arg_56_0:IsAlive() or arg_56_0:CanArrive()
		end)
	end

	return var_55_0
end

function WorldMapCell:CanPass()
	local var_57_0 = self.walkable

	if self.walkable then
		var_57_0 = self:GetTerrainObstacleConfig("pass")
		var_57_0 = var_57_0 and underscore.all(self.attachments, function(arg_58_0)
			return not arg_58_0:IsAlive() or arg_58_0:CanPass()
		end)
	end

	return var_57_0
end

function WorldMapCell:IsSign()
	return _.any(self.attachments, function(arg_60_0)
		return arg_60_0:IsAlive() and arg_60_0:IsSign()
	end)
end

function WorldMapCell:ExistEnemy()
	return tobool(self:GetStageEnemy())
end

function WorldMapCell:GetStageEnemy()
	return _.detect(self.attachments, function(arg_63_0)
		return arg_63_0:IsAlive() and WorldMapAttachment.IsEnemyType(arg_63_0.type)
	end)
end

function WorldMapCell:GetDisplayQuad()
	local var_64_0
	local var_64_1 = self:GetDisplayAttachment()

	if not self:InFog() and var_64_1 then
		if var_64_1.type == WorldMapAttachment.TypeEvent then
			if var_64_1.config.object_icon and #var_64_1.config.object_icon > 0 then
				var_64_0 = var_64_1.config.object_icon
			end
		elseif WorldMapAttachment.IsEnemyType(var_64_1.type) then
			var_64_0 = {
				"cell_red"
			}
		elseif var_64_1.type == WorldMapAttachment.TypePort or var_64_1.type == WorldMapAttachment.TypeBox then
			var_64_0 = {
				"cell_yellow"
			}
		end
	end

	return var_64_0
end

function WorldMapCell:GetEmotion()
	return (self.terrain == WorldMapCell.TerrainPoison or nil) and (WorldConst.PoisonEffect or nil)
end

function WorldMapCell:GetScannerAttachment()
	local var_66_0
	local var_66_1

	for iter_66_0, iter_66_1 in ipairs((self:GetAliveAttachments())) do
		local var_66_2 = iter_66_1:IsScannerAttachment()

		if var_66_2 and (not var_66_0 or var_66_1 < var_66_2) then
			var_66_0 = iter_66_1
			var_66_1 = var_66_2
		end
	end

	return var_66_0
end

WorldMapCell.TerrainObstacleConfig = {
	SairenFog = 4,
	[WorldMapCell.TerrainNone] = 7,
	[WorldMapCell.TerrainStream] = 6,
	[WorldMapCell.TerrainIce] = 6,
	[WorldMapCell.TerrainWind] = 2,
	[WorldMapCell.TerrainFog] = 6,
	[WorldMapCell.TerrainFire] = 7,
	[WorldMapCell.TerrainPoison] = 7
}

function WorldMapCell:GetTerrainObstacleConfig(arg_67_1)
	return bit.band(WorldMapCell.TerrainObstacleConfig[self:IsTerrainSairenFog() and "SairenFog" or self:GetTerrain()], (WorldConst.GetObstacleKey(arg_67_1))) > 0
end

function WorldMapCell:IsMovingTerrain()
	return self == WorldMapCell.TerrainStream or self == WorldMapCell.TerrainIce or self == WorldMapCell.TerrainWind
end

return WorldMapCell
