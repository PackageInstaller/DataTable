local var_0_0 = g.core.const.ConstMgr.DomainConst
local var_0_1 = g.core.config.domain_stage_info
local DomainStageStruct = require("app.view.module.domain.model.DomainStageStruct")
local DomainDungeonStruct = class("DomainDungeonStruct")

function DomainDungeonStruct:ctor(arg_1_1)
	self._dungeonCfg = arg_1_1
	self._id = arg_1_1.id
	self._curStage = 1
	self._curGrade = 0
	self._newStage = 0
	self._newGrade = 0
	self._maxStageId = 0

	self:_initStageData()
end

function DomainDungeonStruct:_initStageData()
	self._stageStructMap = {}
	self._stageStructArray = {}

	for iter_2_0, iter_2_1 in var_0_1.ipairs() do
		if self._id == iter_2_1.dungeon_id then
			local var_2_0 = DomainStageStruct.new(iter_2_1)

			self._stageStructMap[iter_2_1.stage] = DomainStageStruct.new(iter_2_1)

			table.insert(self._stageStructArray, var_2_0)

			self._maxStageId = iter_2_1.stage
		end
	end
end

function DomainDungeonStruct:getId()
	return self._id
end

function DomainDungeonStruct:getStage(arg_4_1)
	return self._stageStructMap[arg_4_1]
end

function DomainDungeonStruct:updateCurStageData(arg_5_1, arg_5_2, arg_5_3)
	if self._stageStructMap[arg_5_1] then
		if arg_5_2 == var_0_0.GRADE.S and arg_5_1 < self._maxStageId then
			self._curStage = arg_5_1 + 1
			self._curGrade = 0

			if arg_5_3 then
				self._newStage = self._curStage
			end
		else
			self._curStage = arg_5_1

			if arg_5_2 ~= self._curGrade then
				self._curGrade = self._curGrade == 0 and arg_5_2 or math.min(self._curGrade, arg_5_2)

				if arg_5_3 then
					self._newGrade = self._curGrade
				end
			end
		end
	end
end

function DomainDungeonStruct:getNewStageGrade()
	return self._newStage, self._newGrade
end

function DomainDungeonStruct:resetNewStageGrade()
	self._newStage = 0
	self._newGrade = 0
end

function DomainDungeonStruct:getCurStageAndGrade()
	return self._curStage, self._curGrade
end

function DomainDungeonStruct:getMaxStageId()
	return self._maxStageId
end

function DomainDungeonStruct:getStageList()
	local var_10_0 = {}

	if self._curStage - 1 > 0 and not (self._curStage == self._maxStageId and self._curGrade == var_0_0.GRADE.S) then
		table.insert(var_10_0, self._curStage - 1)
	end

	local var_10_1 = self._curStage

	while self:getStage(var_10_1) and #var_10_0 <= var_0_0.STAGE_COUNT do
		table.insert(var_10_0, var_10_1)

		var_10_1 = var_10_1 + 1
	end

	return var_10_0
end

function DomainDungeonStruct:getDungeonLeftTime()
	return (g.core.model.User.shopData:getLeftCount(self._dungeonCfg.dungeon_num))
end

function DomainDungeonStruct:getDungeonFreeLeftTime()
	return (g.core.model.User.shopData:getLeftCount(self._dungeonCfg.free_dungeon_num))
end

function DomainDungeonStruct:getDungeonMaxTime()
	return g.core.config.play_num_info.get(self._dungeonCfg.dungeon_num).reset
end

function DomainDungeonStruct:getName()
	return self._dungeonCfg.dungeon_name
end

function DomainDungeonStruct:getTopResId()
	return self._dungeonCfg.interface
end

function DomainDungeonStruct:getDungeonDescription()
	return self._dungeonCfg.reward_description
end

function DomainDungeonStruct:getSurpriseRate()
	return self._dungeonCfg.surprise_rate
end

function DomainDungeonStruct:getSurpriseMiniNum()
	return self._dungeonCfg.surprise_minimum
end

function DomainDungeonStruct:isDungeonOpen()
	return self._dungeonCfg.is_open == 1
end

function DomainDungeonStruct:getMainReward()
	return self._dungeonCfg.reward_display
end

function DomainDungeonStruct:getFormationType()
	return self._dungeonCfg.formation
end

return DomainDungeonStruct
