local ActivityBossBuff = class("ActivityBossBuff", import("model.vo.BaseVO"))

function ActivityBossBuff:bindConfigTable()
	return pg.worldboss_bufflist
end

function ActivityBossBuff:GetConfigID()
	return self.configId
end

function ActivityBossBuff:GetIcon()
	return self:getConfig("buff_icon")
end

function ActivityBossBuff:GetIconPath()
	return "activitybossbuff/" .. self:getConfig("buff_icon")
end

function ActivityBossBuff:GetName()
	return self:getConfig("name")
end

function ActivityBossBuff:GetDesc()
	return self:getConfig("desc")
end

function ActivityBossBuff:CastOnEnemy()
	return self:getConfig("buff_target") == 1
end

function ActivityBossBuff:GetBuffID()
	return self:getConfig("lua_id")
end

function ActivityBossBuff:GetBonus()
	return tonumber(self:getConfig("bonus"))
end

function ActivityBossBuff:GetBonusText()
	return math.floor(self:GetBonus() * 100) .. "%"
end

return ActivityBossBuff
