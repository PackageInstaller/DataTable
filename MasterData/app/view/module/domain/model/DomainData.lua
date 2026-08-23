local DomainDungeonStruct = require("app.view.module.domain.model.DomainDungeonStruct")
local var_0_2 = g.core.config.domain_dungeon_info
local DomainData = class("DomainData")

function DomainData:ctor()
	self:initData()
end

function DomainData:initData()
	self._actions = {}
	self._isHaveSurprise = false
	self._isChange = false
	self._surprise = {}

	self:_initDungeonData()
end

function DomainData:_initDungeonData()
	self._dungeonDict = {}
	self._dungeonList = {}

	for iter_3_0, iter_3_1 in var_0_2.ipairs() do
		local var_3_0 = DomainDungeonStruct.new(iter_3_1)

		self._dungeonDict[iter_3_1.id] = var_3_0

		table.insert(self._dungeonList, var_3_0)
	end
end

function DomainData:onS2CDomainGetInfo(arg_4_1)
	if arg_4_1.domain then
		for iter_4_0, iter_4_1 in ipairs(arg_4_1.domain.dungeons or {}) do
			self:getDungeon(iter_4_1.id):updateCurStageData(iter_4_1.stage, iter_4_1.grade)
		end

		self:updateStageAction(arg_4_1.domain.actions)
	end
end

function DomainData:onS2CDomainChallengeFinish(arg_5_1)
	if arg_5_1.id then
		local var_5_0 = self:getDungeon(arg_5_1.id)
		local var_5_1, var_5_2 = var_5_0:getCurStageAndGrade()
		local var_5_3 = arg_5_1.grade or var_5_2

		if arg_5_1.is_win then
			self._isChange = var_5_3 < var_5_2
		end

		var_5_0:updateCurStageData(var_5_1, var_5_3, true)
	end

	if arg_5_1.surprise then
		self._isHaveSurprise = true
		self._surprise = arg_5_1.surprise
	end
end

function DomainData:onS2CDomainSweep(arg_6_1)
	if arg_6_1.surprise then
		self._isHaveSurprise = true
		self._surprise = arg_6_1.surprise
	end
end

function DomainData:onS2CActionStatusFlush(arg_7_1)
	self:updateActionsValue(arg_7_1.status)
end

function DomainData:isShowEntrance()
	if not g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.DOMAIN) then
		return false
	end

	return true
end

function DomainData:getDungeon(arg_9_1)
	return self._dungeonDict[arg_9_1]
end

function DomainData:getDungeonList()
	return self._dungeonList
end

function DomainData:isStageChange()
	return self._isChange
end

function DomainData:resetStageState()
	self._isChange = false
end

function DomainData:updateStageAction(arg_13_1)
	self._actions = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_1 or {}) do
		self._actions[iter_13_1.key .. "_" .. iter_13_1.type] = iter_13_1.value
	end
end

function DomainData:updateActionsValue(arg_14_1)
	self._actions[arg_14_1.key .. "_" .. arg_14_1.id] = arg_14_1.status
end

function DomainData:getActionsValue(arg_15_1, arg_15_2)
	return self._actions[arg_15_1 .. "_" .. arg_15_2] or 0
end

function DomainData:resetSurprise()
	self._isHaveSurprise = false
	self._surprise = {}
end

function DomainData:isHaveSurprise()
	return self._isHaveSurprise
end

function DomainData:getSurprise()
	return self._surprise
end

function DomainData:awardSummary(arg_19_1)
	g.core.module.ModuleManager:pushModule(g.view.entrance.DOMAIN_AWARD_POP, {
		award = arg_19_1.award,
		autoDisappear = arg_19_1.isAuto,
		callBack = arg_19_1.callBack,
		dungeonId = arg_19_1.dungeonId
	})
end

function DomainData:isDungeonHasLeftTime(arg_20_1)
	if arg_20_1.dungeonId then
		return self:getDungeon(arg_20_1.dungeonId):getDungeonLeftTime() > 0
	else
		for iter_20_0, iter_20_1 in ipairs(self._dungeonList) do
			if iter_20_1:isDungeonOpen() and iter_20_1:getDungeonLeftTime() > 0 then
				return true
			end
		end
	end

	return false
end

function DomainData:getDungeonResource(arg_21_1, arg_21_2)
	return (table.concat({
		"pic/domain/",
		arg_21_1,
		"/",
		arg_21_2
	}))
end

return DomainData
