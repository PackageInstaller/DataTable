local FeastThemeTemplate = class("FeastThemeTemplate", import("model.vo.NewBackYard.BackYardSelfThemeTemplate"))

function FeastThemeTemplate:Ctor(arg_1_1, arg_1_2, arg_1_3)
	FeastThemeTemplate.super.Ctor(self, arg_1_1, arg_1_2)

	self.mapSize = arg_1_3

	return
end

function FeastThemeTemplate:GetMapSize()
	return self.mapSize
end

return FeastThemeTemplate
