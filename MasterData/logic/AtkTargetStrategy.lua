-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/atktarget/AtkTargetStrategy.lua

module("logic.extensions.mission.view.atktarget.AtkTargetStrategy", package.seeall)

local AtkTargetStrategy = class("AtkTargetStrategy")

function AtkTargetStrategy:ctor()
	self._selfDic = {}
	self._enemyDic = {}

	self:_addSelfList()
	self:_addEnemyList()

	self._default = AtkTargetDefault.New()
end

function AtkTargetStrategy:_addSelfList(name, cls)
	self:_addSelfItem("己方-重伤", AtkTargetSelfZhongShangOne)
	self:_addSelfItem("己方-重伤两位", AtkTargetSelfZhongShangTwo)
	self:_addSelfItem("己方-重伤三位", AtkTargetSelfZhongShangThree)
	self:_addSelfItem("己方-全体", AtkTargetSelfAll)
	self:_addSelfItem("己方-死亡优先", AtkTargetSelfDeathFirst)
	self:_addSelfItem("己方-自己", AtkTargetSelfToMe)
	self:_addSelfItem("己方-自己及身后一只", AtkTargetSelfMeAndAfterMe)
end

function AtkTargetStrategy:_addEnemyList()
	self:_addEnemyItem("敌方-单体", AtkTargetEnemySingle)
	self:_addEnemyItem("敌方-横排最后1只", AtkTargetEnemyRowLast)
	self:_addEnemyItem("敌方-身后一位", AtkTargetEnemyAfterMe)
	self:_addEnemyItem("敌方-正常加身后任意一位", AtkTargetEnemyNormalAndAfterAnyone)
	self:_addEnemyItem("敌方-正常加随机", AtkTargetEnemyNormalAndRandomOne)
	self:_addEnemyItem("敌方-正常加随机2位", AtkTargetEnemyNormalAndRandomTwo)
	self:_addEnemyItem("敌方-正常加随机3位", AtkTargetEnemyNormalAndRandomThree)
	self:_addEnemyItem("敌方-正常加纵向优先相邻一位", AtkTargetEnemyNormalColumn)
	self:_addEnemyItem("敌方-纵向", AtkTargetEnemyColumn)
	self:_addEnemyItem("敌方-最少血", AtkTargetEnemyMinHp)
	self:_addEnemyItem("敌方-横纵相邻", AtkTargetEnemyRowColumn)
end

function AtkTargetStrategy:_addSelfItem(name, cls)
	self._selfDic[name] = cls.New()
end

function AtkTargetStrategy:_addEnemyItem(name, cls)
	self._enemyDic[name] = cls.New()
end

function AtkTargetStrategy:createSelfParam()
	self._selfParam = self._selfParam or AtkTargetSelfParam.New()

	self._selfParam:reset()

	return self._selfParam
end

function AtkTargetStrategy:createEnemyParam()
	self._enemyParam = self._enemyParam or AtkTargetEnemyParam.New()

	self._enemyParam:reset()

	return self._enemyParam
end

function AtkTargetStrategy:getResult(atkTargetParam)
	local targetType = self:_getTargetType(atkTargetParam.dragPetId)

	if iskindof(atkTargetParam, "AtkTargetSelfParam") then
		if self._selfDic[targetType] then
			self._selfDic[targetType]:init(atkTargetParam)

			return self._selfDic[targetType]:getResult()
		elseif type(targetType) == "string" and string.find(targetType, "己方") then
			-- block empty
		end
	elseif iskindof(atkTargetParam, "AtkTargetEnemyParam") then
		if self._enemyDic[targetType] then
			self._enemyDic[targetType]:init(atkTargetParam)

			return self._enemyDic[targetType]:getResult()
		elseif type(targetType) == "string" and string.find(targetType, "敌方") then
			-- block empty
		end
	end

	return self._default:getResult()
end

function AtkTargetStrategy:_getTargetType(petId)
	local targetType = ""
	local bagPetMo = BagPetsController.instance:getPet(petId)

	if not bagPetMo then
		return targetType
	end

	local raceId = bagPetMo:getDefineId()
	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(bagPetMo.curFaceId)

	if not skinCfg then
		return targetType
	end

	local skillId = skinCfg.normalSkillId
	local cfgBtlSkill = BattleConfig.instance:getSkillCo(skillId, bagPetMo.curFaceId)

	if not cfgBtlSkill then
		return targetType
	end

	targetType = cfgBtlSkill.targetType

	return cfgBtlSkill.targetType
end

AtkTargetStrategy.instance = AtkTargetStrategy.New()

return AtkTargetStrategy
