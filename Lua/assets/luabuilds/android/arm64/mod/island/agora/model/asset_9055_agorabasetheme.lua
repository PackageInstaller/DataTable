local AgoraBaseTheme = class("AgoraBaseTheme")

function AgoraBaseTheme:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.name = arg_1_1.name
	self.placedlist = {}
	self.floorData = {}
	self.tileData = {}

	return
end

function AgoraBaseTheme:GetPlacedData()
	return self.placedlist
end

function AgoraBaseTheme:GetSeparatedPlacedData()
	local var_3_0 = {}
	local var_3_1

	for iter_3_0, iter_3_1 in ipairs(self.placedlist) do
		if iter_3_1:IsFoundationType() then
			var_3_1 = iter_3_1
		else
			local var_3_2

			if iter_3_1:IsBuildingType() then
				var_3_2 = iter_3_1
			else
				table.insert(var_3_0, iter_3_1)
			end
		end
	end

	return var_3_0, var_3_1, nil
end

function AgoraBaseTheme:GetFloorData()
	return self.floorData
end

function AgoraBaseTheme:GetTileData()
	return self.tileData
end

return AgoraBaseTheme
