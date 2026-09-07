local IslandPlayer = class("IslandPlayer", import("model.vo.PlayerAttire"))

function IslandPlayer:Ctor(arg_1_1)
	IslandPlayer.super.Ctor(self, arg_1_1)

	self.id = arg_1_1.id

	self:Flush(arg_1_1)

	self.position = Vector3.zero
	self.rotation = Vector3.zero

	self:InitDressupData(arg_1_1)

	return
end

function IslandPlayer:Flush(arg_2_1)
	IslandPlayer.super.Flush(self, arg_2_1)

	self.name = arg_2_1.name
	self.level = arg_2_1.level
	self.mapId = arg_2_1.map_id

	return
end

function IslandPlayer:GetModelId()
	return 0
end

function IslandPlayer:GetDressByType(arg_4_1)
	return self.currentDressTypeDic[arg_4_1] or 0
end

function IslandPlayer:GetCurrentColorByDressId(arg_5_1)
	return self.dressColorDic[arg_5_1] or 0
end

function IslandPlayer:GetHairFaceBodyDress()
	return self:GetDressByType(IslandShipDressHelperNew.DressType.Hair), self:GetDressByType(IslandShipDressHelperNew.DressType.Face), (self:GetDressByType(IslandShipDressHelperNew.DressType.Body))
end

function IslandPlayer:GetCurCommderId()
	local var_7_0, var_7_1, var_7_2 = self:GetHairFaceBodyDress()

	return (IslandShipDressHelper.GetCurCommanderId(var_7_0, var_7_1, var_7_2))
end

function IslandPlayer:IsSelf()
	return self.id == getProxy(PlayerProxy):getRawData().id
end

function IslandPlayer:GetName()
	return self.name
end

function IslandPlayer:GetLevel()
	return self.level
end

function IslandPlayer:GetIcon()
	return pg.ship_skin_template[self.character].painting
end

function IslandPlayer:GetLoaction()
	if not self.mapId or not pg.island_map[self.mapId] then
		return ""
	end

	return pg.island_map[self.mapId].name
end

function IslandPlayer:SetPosition(arg_13_1)
	self.position = arg_13_1

	return
end

function IslandPlayer:SetRotation(arg_14_1)
	self.rotation = arg_14_1

	return
end

function IslandPlayer:UpdateName(arg_15_1)
	self.name = arg_15_1

	return
end

function IslandPlayer:InitDressupData(arg_16_1)
	self.currentDressTypeDic = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1.cur_dress or {}) do
		self.currentDressTypeDic[iter_16_1.type] = iter_16_1.id
	end

	self.dressColorDic = {}

	for iter_16_2, iter_16_3 in ipairs(arg_16_1.dress_color or {}) do
		self.dressColorDic[iter_16_3.id] = iter_16_3.color
	end

	return
end

function IslandPlayer:ChangeDressupData(arg_17_1, arg_17_2)
	self.currentDressTypeDic = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1 or {}) do
		self.currentDressTypeDic[iter_17_1.type] = iter_17_1.id
	end

	self.dressColorDic = {}

	for iter_17_2, iter_17_3 in ipairs(arg_17_2 or {}) do
		self.dressColorDic[iter_17_3.id] = iter_17_3.color
	end

	return
end

function IslandPlayer:IsInMap(arg_18_1)
	return self.mapId == arg_18_1
end

return IslandPlayer
