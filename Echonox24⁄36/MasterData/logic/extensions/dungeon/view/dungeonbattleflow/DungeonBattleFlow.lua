-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/dungeonbattleflow/DungeonBattleFlow.lua

module("logic.extensions.dungeon.view.dungeonbattleflow.DungeonBattleFlow", package.seeall)

local M = class("DungeonBattleFlow")

function M:ctor()
	self._compList = {}
	self._workingWork = false

	self:_registerComponents()
end

function M:enter(info)
	PlayerAttributeGainTipsController.instance:freeze("battle")
	self.model:setInfo(info)

	local work = self:_createWork()

	work:setDoneCaller(self._onEnterFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkShowLoading.New(true))
	sequence:addChild(WorkInterval.New(0.53))
	sequence:addChild(DungeonBattleWorkLeaveDungeon.New())
	sequence:addChild(DungeonBattleWorkShowPlotBeforeBattle.New())
	sequence:addChild(WorkInterval.New(0.1))

	if self.model:getIsPlotDungeon() then
		sequence:addChild(DungeonBattleWorkShowPlotReward.New())
	else
		sequence:addChild(DungeonBattleWorkStartBattle.New())
	end

	sequence:addChild(DungeonBattleWorkReturnDungeon.New())
	work:addChild(sequence)
	work:start(self)
end

function M:exit()
	self:_destroyWork()
	DungeonController.instance:clearDungeonBattleFlow()
	PlayerAttributeGainTipsController.instance:unfreeze("battle", 0.2)
end

function M:_registerComponents()
	self:_addComponent("model", DungeonBattleModel)
end

function M:_onEnterFinish(result)
	if result ~= WorkResult.Succeed then
		printError("enterDungeonBattlefalse")
	end

	self:exit()
end

function M:_createWork()
	self:_destroyWork()

	self._workingWork = WorkFlow.New()

	return self._workingWork
end

function M:_destroyWork()
	if self._workingWork then
		self._workingWork:destroy()

		self._workingWork = false
	end
end

function M:_notifyComponents(functionName)
	for _, component in pairs(self._compList) do
		local func = component[functionName]

		if func then
			func(component)
		end
	end
end

function M:_addComponent(compName, compClass)
	local compInst = compClass.New()

	self[compName] = compInst
	compInst.flow = self

	table.insert(self._compList, compInst)
end

function M:_removeComponent(compName)
	local compInst = self[compName]

	if compInst then
		self[compName] = nil

		table.removebyvalue(self._compList, compInst, true)
	end
end

function M:internal_NotifyComponent(functionName)
	self:_notifyComponents(functionName)
end

return M
