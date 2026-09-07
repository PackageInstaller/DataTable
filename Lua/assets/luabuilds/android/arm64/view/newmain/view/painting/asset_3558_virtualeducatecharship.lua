local VirtualEducateCharShip = class("VirtualEducateCharShip", import("model.vo.Ship"))

function VirtualEducateCharShip:Ctor(arg_1_1)
	self.educateCharId = arg_1_1
	self.templateConfig = pg.secretary_special_ship[arg_1_1]

	local var_1_0

	if self.templateConfig.unlock_type == EducateConst.SECRETARY_UNLCOK_TYPE_SHOP then
		var_1_0 = self.templateConfig.unlock[1]
	end

	VirtualEducateCharShip.super.Ctor(self, {
		configId = 999024,
		id = var_1_0 or 99999999
	})

	self.skinId = var_1_0 or self.skinId
	self.name = self.templateConfig.name

	return
end

function VirtualEducateCharShip:getPainting()
	return self.templateConfig.prefab or "tbniang"
end

function VirtualEducateCharShip:getName()
	return self.templateConfig.name or ""
end

function VirtualEducateCharShip:getPrefab()
	return self.templateConfig.head
end

function VirtualEducateCharShip:GetRecordPosKey()
	return self.educateCharId .. "" .. self.id
end

function VirtualEducateCharShip:getSkinId()
	return self.skinId
end

return VirtualEducateCharShip
