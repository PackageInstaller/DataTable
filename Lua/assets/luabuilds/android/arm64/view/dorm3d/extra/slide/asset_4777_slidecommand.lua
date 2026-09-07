local SlideCommand = class("SlideCommand", import("model.vo.BaseVO"))

function SlideCommand:Ctor(arg_1_1, arg_1_2)
	SlideCommand.super.Ctor(self, pg.dorm3d_slide_command[arg_1_1])

	self.id = arg_1_1
	self.type = pg.dorm3d_slide_command[arg_1_1].type
	self.target = pg.dorm3d_slide_command[arg_1_1].target
	self.anim = pg.dorm3d_slide_command[arg_1_1].anim
	self.time = pg.dorm3d_slide_command[arg_1_1].time
	self.fade_in_time = pg.dorm3d_slide_command[arg_1_1].fade_in_time
	self.effect = pg.dorm3d_slide_command[arg_1_1].effect
	self.wet = pg.dorm3d_slide_command[arg_1_1].wet

	if self.target and self.target ~= "" then
		self.target = arg_1_2:Find(self.target)
	end

	return
end

function SlideCommand:GetFadeInTime()
	if self.fade_in_time and self.fade_in_time ~= 0 then
		return self.fade_in_time
	else
		return DormConst.DEFAULT_ANIM_FADE_IN_TIME
	end

	return
end

function SlideCommand:HasEffect()
	return self.effect and self.effect ~= ""
end

function SlideCommand:HasWet()
	return self.wet and self.wet ~= ""
end

function SlideCommand:GetEffect()
	if self:HasEffect() then
		return self.effect[1], self.effect[2]
	end

	return
end

function SlideCommand:GetWet()
	if self:HasWet() then
		return self.wet[1], self.wet[2]
	end

	return
end

return SlideCommand
