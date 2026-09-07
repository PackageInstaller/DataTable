local CourtYardPaper = class("CourtYardPaper")

function CourtYardPaper:Ctor(arg_1_1, arg_1_2)
	self.id = arg_1_2.id
	self.configId = arg_1_2.configId or self.id
	self.config = pg.furniture_data_template[self.configId]

	return
end

function CourtYardPaper:IsDirty()
	return true
end

function CourtYardPaper:UnDirty()
	return
end

function CourtYardPaper:GetObjType()
	if self.config.spine ~= nil then
		return CourtYardConst.OBJ_TYPE_SPINE
	else
		return CourtYardConst.OBJ_TYPE_COMMOM
	end

	return
end

function CourtYardPaper:GetPicture()
	return self.config.picture
end

function CourtYardPaper:GetSpineNameAndAction()
	return self.config.spine[1][1], self.config.spine[1][2]
end

function CourtYardPaper:GetType()
	return self.config.type
end

function CourtYardPaper:ToTable()
	return {
		parent = 0,
		y = 0,
		dir = 1,
		x = 0,
		id = self.id,
		configId = self.configId,
		position = Vector2(0, 0),
		child = {}
	}
end

return CourtYardPaper
