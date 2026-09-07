local LivingAreaCover = class("LivingAreaCover", import(".BaseVO"))

LivingAreaCover.TYPE_DAY = "day"
LivingAreaCover.TYPE_NIGHT = "night"

function LivingAreaCover:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.unlock = arg_1_1.unlock
	self.isNew = arg_1_1.isNew

	return
end

function LivingAreaCover:bindConfigTable()
	return pg.livingarea_cover
end

function LivingAreaCover:SetUnlock(arg_3_1)
	self.unlock = arg_3_1

	return
end

function LivingAreaCover:IsUnlock()
	return self.unlock
end

function LivingAreaCover:ClearNew()
	self.isNew = false

	return
end

function LivingAreaCover:IsNew()
	return self.isNew
end

function LivingAreaCover:GetDropType()
	return DROP_TYPE_LIVINGAREA_COVER
end

function LivingAreaCover:GetUnlockText()
	return self:getConfig("unlock_text")
end

function LivingAreaCover:GetIcon()
	return "livingareacover/" .. self:getConfig("icon_res")
end

function LivingAreaCover:GetBg(arg_10_1)
	return "livingareaCover/" .. self:getConfig(arg_10_1 .. "time_res")
end

return LivingAreaCover
