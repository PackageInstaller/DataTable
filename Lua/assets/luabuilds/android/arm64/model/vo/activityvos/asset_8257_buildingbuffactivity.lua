local BuildingBuffActivity = class("BuildingBuffActivity", import("model.vo.Activity"))

function BuildingBuffActivity:GetBuildingConfigTable(arg_1_1)
	return pg.activity_event_building[arg_1_1]
end

function BuildingBuffActivity:GetBuildingLevel(arg_2_1)
	return self.data1KeyValueList[2][arg_2_1] or 1
end

function BuildingBuffActivity:SetBuildingLevel(arg_3_1, arg_3_2)
	self.data1KeyValueList[2][arg_3_1] = arg_3_2

	return
end

function BuildingBuffActivity:GetBuildingIds()
	return self:getConfig("config_data")
end

function BuildingBuffActivity:GetMaterialCount(arg_5_1)
	return self.data1KeyValueList[1][arg_5_1] or 0
end

return BuildingBuffActivity
