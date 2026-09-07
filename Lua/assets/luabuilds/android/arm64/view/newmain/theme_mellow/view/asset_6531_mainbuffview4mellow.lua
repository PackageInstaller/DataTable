local MainBuffView4Mellow = class("MainBuffView4Mellow", import("...theme_classic.view.MainBuffView"))

function MainBuffView4Mellow:Ctor(arg_1_1, arg_1_2)
	MainBuffView4Mellow.super.Ctor(self, arg_1_1, arg_1_2)

	self.buffOffsetX = 6
	self.noTagStartPos = 130
	self.hasTagStartPos = 290
	self.tagPos = Vector3(-170, -2.5, 0)

	return
end

function MainBuffView4Mellow:GetDirection()
	return Vector2.zero
end

return MainBuffView4Mellow
