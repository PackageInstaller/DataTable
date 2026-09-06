-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/angelpowerclg/model/AngelPowerClgModel.lua

module("logic.extensions.angelpowerclg.view.AngelPowerClgModel", package.seeall)

local AngelPowerClgModel = class("AngelPowerClgModel", BaseModel)

AngelPowerClgModel.RedFlag = "AngelPowerClgModel.RedFlag"

function AngelPowerClgModel:ctor()
	return
end

function AngelPowerClgModel:onInit()
	self:onReset()
end

function AngelPowerClgModel:onReset()
	self.infos = {}
	self._fmtMo = nil
end

function AngelPowerClgModel:getCurrActId()
	local actId = false
	local cfgs = ActivityDefineConfig.instance:getCfgByActivityTypeId(GameEnum.ActivityType.AngelPowerClg)

	if not cfgs then
		printError("t_activity_define 不存在配置 类型:", GameEnum.ActivityType.AngelPowerClg)

		return false
	end

	for i, v in pairs(cfgs) do
		if ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.AngelPowerClg, v.activityId) then
			local cfg = AngelPowerClgConfig.instance:getActivityCfg(v.activityId)

			if cfg then
				actId = cfg.activityId

				break
			end

			printError("====t_liu_dao_activity no cfg, id = " .. v, activityId)

			break
		end
	end

	return actId
end

function AngelPowerClgModel:setInfo(msg)
	self.infos[msg.activityId] = GameUtil.pbToTable(msg)
end

function AngelPowerClgModel:getPassStage(activityId)
	local info = self.infos[activityId]

	return (info or nil) and (info.passedStageId or 0)
end

function AngelPowerClgModel:setStageInfo(msg)
	if msg.win then
		local info = self.infos[msg.activityId]

		if not info then
			self.infos[msg.activityId] = {}
			info = self.infos[msg.activityId]
		end

		info.activityId = msg.activityId
		info.passedStageId = msg.stageId
	end
end

function AngelPowerClgModel:getFmtMo()
	self._fmtMo = self._fmtMo or AngelPowerClgFmtMo.New()

	return self._fmtMo
end

function AngelPowerClgModel:resetBattleInfo()
	self._battleInfo = {}
end

function AngelPowerClgModel:addBattleDamageInfo(petId, attr, damage)
	self._battleInfo[petId] = self._battleInfo[petId] or {}
	self._battleInfo[petId][attr] = damage + (self._battleInfo[petId][attr] or 0)
end

function AngelPowerClgModel:getBattleMaxAttr(petId)
	self._battleInfo[petId] = self._battleInfo[petId] or {}

	local attrType = GameEnum.RaceTxt[GameEnum.RaceType.Cao]
	local maxDamage = 0

	for i, v in pairs(self._battleInfo[petId]) do
		if v < maxDamage then
			maxDamage = v
			attrType = i
		end
	end

	return attrType
end

AngelPowerClgModel.instance = AngelPowerClgModel.New()

return AngelPowerClgModel
