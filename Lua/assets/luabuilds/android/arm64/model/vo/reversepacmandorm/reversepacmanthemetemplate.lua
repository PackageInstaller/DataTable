local ReversePacmanThemeTemplate = class("ReversePacmanThemeTemplate", import("model.vo.NewBackYard.BackYardSelfThemeTemplate"))

function ReversePacmanThemeTemplate:Ctor(arg_1_1, arg_1_2, arg_1_3)
	ReversePacmanThemeTemplate.super.Ctor(self, arg_1_1, arg_1_2)

	self.mapSize = arg_1_3

	return
end

function ReversePacmanThemeTemplate:GetMapSize()
	return self.mapSize
end

function ReversePacmanThemeTemplate:InitFurnitures(arg_3_1)
	arg_3_1.skipCheck = true

	return RawData2ThemeConvertor.New():GenFurnitures(arg_3_1)
end

return ReversePacmanThemeTemplate
