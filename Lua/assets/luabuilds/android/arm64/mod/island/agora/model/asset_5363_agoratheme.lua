local AgoraTheme = class("AgoraTheme", import(".AgoraBaseTheme"))

function AgoraTheme:Ctor(arg_1_1, arg_1_2)
	AgoraTheme.super.Ctor(self, arg_1_1)
	self:Flush(arg_1_1, arg_1_2)

	return
end

function AgoraTheme:Flush(arg_2_1, arg_2_2)
	for iter_2_0, iter_2_1 in ipairs(arg_2_1:GetPlacedList()) do
		if arg_2_2[iter_2_1.id] then
			local var_2_0 = Clone(arg_2_2[iter_2_1.id])

			var_2_0:FlushDataFromPlacementData(iter_2_1)
			table.insert(self.placedlist, var_2_0)
		end
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_1:GetFloorLayer()) do
		local var_2_1 = AgoraLayerCell.New(iter_2_3.position)

		var_2_1:Fill(iter_2_3.id, iter_2_3.shapeId)
		table.insert(self.floorData, var_2_1)
	end

	for iter_2_4, iter_2_5 in ipairs(arg_2_1:GetTileLayer()) do
		local var_2_2 = AgoraLayerCell.New(iter_2_5.position)

		var_2_2:Fill(iter_2_5.id, iter_2_5.shapeId)
		table.insert(self.tileData, var_2_2)
	end

	return
end

return AgoraTheme
