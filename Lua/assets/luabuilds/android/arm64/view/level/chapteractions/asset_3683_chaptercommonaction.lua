local ChapterCommonAction = class("ChapterCommonAction")

function ChapterCommonAction:Ctor(arg_1_1)
	self.command = setmetatable({}, ChapterOpCommand)

	self.command:initData(arg_1_1.op, arg_1_1.data, arg_1_1.chapter)

	return
end

function ChapterCommonAction:applyTo(arg_2_1, arg_2_2)
	if arg_2_2 then
		return true
	end

	self.command.chapter = arg_2_1

	self.command:doMapUpdate()
	self.command:doAIUpdate()
	self.command:doShipUpdate()
	self.command:doBuffUpdate()
	self.command:doCellFlagUpdate()
	self.command:doExtraFlagUpdate()

	return true, self.command.flag, self.command.extraFlag
end

function ChapterCommonAction:PlayAIAction(arg_3_1, arg_3_2, arg_3_3)
	existCall(arg_3_3)

	return
end

return ChapterCommonAction
