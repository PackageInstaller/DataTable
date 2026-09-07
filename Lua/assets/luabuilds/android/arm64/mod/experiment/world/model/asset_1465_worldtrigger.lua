local WorldTrigger = class("WorldTrigger", import("...BaseEntity"))

WorldTrigger.Fields = {
	config = "table",
	progress = "number",
	id = "number",
	maxProgress = "number",
	desc = "string"
}

function WorldTrigger:Setup(arg_1_1)
	self.id = arg_1_1

	return
end

function WorldTrigger:GetProgress()
	return self.progress
end

function WorldTrigger:GetMaxProgress()
	return self.maxProgress
end

function WorldTrigger:GetDesc()
	return string.format("%s(%s/%s)", self.desc, self.progress, self.maxProgress)
end

function WorldTrigger:IsAchieved()
	return self:GetProgress() >= self:GetMaxProgress()
end

return WorldTrigger
