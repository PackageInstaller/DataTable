local BossSingleEnemyData = class("BossSingleEnemyData", import("model.vo.baseVO"))

BossSingleEnemyData.ACTIVIRY_TYPE = {
	OTHERWORLD = 1
}
BossSingleEnemyData.TYPE = {
	EX = 5,
	SP = 4,
	EAST = 1,
	NORMAL = 2,
	HARD = 3
}

function BossSingleEnemyData:bindConfigTable()
	return pg.activity_single_enemy
end

function BossSingleEnemyData:Ctor(arg_2_1)
	self.id = arg_2_1.id
	self.configId = self.id
	self.fleetIdx = arg_2_1.index

	return
end

function BossSingleEnemyData:InTime()
	return pg.TimeMgr.GetInstance():inTime(self:getConfig("time"))
end

function BossSingleEnemyData:GetFleetIdx()
	return self.fleetIdx
end

function BossSingleEnemyData:IsContinuousType()
	return self:GetType() ~= BossSingleEnemyData.TYPE.SP
end

function BossSingleEnemyData:IsOilLimit()
	return self:GetOilLimit()[1] > 0 and self:GetOilLimit()[2] > 0
end

function BossSingleEnemyData:GetActiviryType()
	return self:getConfig("activity_type")
end

function BossSingleEnemyData:GetType()
	return self:getConfig("type")
end

function BossSingleEnemyData:GetExpeditionId()
	return self:getConfig("expedition_id")
end

function BossSingleEnemyData:GetPreChapterId()
	return self:getConfig("pre_chapter")
end

function BossSingleEnemyData:IsGuardianEffective()
	return self:getConfig("guardian_limit") == 1
end

function BossSingleEnemyData:GetCount()
	return self:getConfig("count")
end

function BossSingleEnemyData:GetOilLimit()
	return self:getConfig("use_oil_limit")
end

function BossSingleEnemyData:GetPropertyLimitation()
	return self:getConfig("property_limitation")
end

return BossSingleEnemyData
