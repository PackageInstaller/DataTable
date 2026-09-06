-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/view/BattleTaskView.lua

module("logic.extensions.battle.view.BattleTaskView", package.seeall)

local BattleTaskView = class("BattleTaskView", ViewComponent)
local HandleMaps = {
	[BattleTaskCaculator.MyPetAttrType] = {
		"_handleMyPetArrType",
		"_myPetAttrType"
	},
	[BattleTaskCaculator.MyInitPos] = {
		"_handleMyInitPos",
		"_myInitPos"
	},
	[BattleTaskCaculator.MyAttackCount] = {
		"_handleDefault",
		"_myAttackCount"
	},
	[BattleTaskCaculator.MyCriticalCount] = {
		"_handleDefault",
		"_myCriticalCount"
	},
	[BattleTaskCaculator.MyActiveRoundCount] = {
		"_handleDefault",
		"_myActiveRoundCount"
	},
	[BattleTaskCaculator.MyUltCount] = {
		"_handleDefault",
		"_myUltCount"
	}
}

function BattleTaskView:buildUI()
	BattleTaskView.super.buildUI(self)

	self._taskConditions = self:getGo("taskConditions")
	self._caculator = BattleTaskCaculator.New()
end

function BattleTaskView:onEnter()
	BattleTaskView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.BattleHurtData, self._onBattleHurtData, self)
	GlobalDispatcher:addListener(GlobalNotify.BattleRoundStart, self._onBattleRoundStart, self)
	GlobalDispatcher:addListener(GlobalNotify.OnBattleRoundStart, self._popupAction, self)
	GlobalDispatcher:addListener(GlobalNotify.OnSkillStart, self._onUseSkillStart, self)
	self:_clearDatas()
	self._caculator:initData(BattleModel.instance.battleTaskIds)
	self:_initConditions()

	if self._caculator:hasTaskType(BattleTaskCaculator.MyPetAttrType) then
		self:_updateOneCondition(BattleTaskCaculator.MyPetAttrType)
	end

	if self._caculator:hasTaskType(BattleTaskCaculator.MyInitPos) then
		self:_updateOneCondition(BattleTaskCaculator.MyInitPos)
	end
end

function BattleTaskView:_initConditions()
	self._conditions = {}

	local parent = self._taskConditions.transform
	local childCount = parent.childCount
	local firstChild = parent:GetChild(0).gameObject

	for k = 1, childCount do
		parent:GetChild(k - 1).gameObject:SetActive(false)
	end

	local taskTypeMap = self._caculator:getTaskTypeMap()
	local i = 1

	for taskType, taskConf in pairs(taskTypeMap) do
		local obj = {}
		local go = i < childCount and parent:GetChild(i).gameObject or goutil.cloneAndSetParent(firstChild, parent)

		go:SetActive(true)

		obj.taskType = taskType
		obj.go = go
		obj.taskConf = taskConf
		self._conditions[taskType] = obj

		self:_updateOneCondition(taskType, obj)

		i = i + 1
	end
end

function BattleTaskView:onExit()
	BattleTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.BattleHurtData, self._onBattleHurtData, self)
	GlobalDispatcher:removeListener(GlobalNotify.BattleRoundStart, self._onBattleRoundStart, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnBattleRoundStart, self._popupAction, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnSkillStart, self._onUseSkillStart, self)
	self:_clearDatas()
end

function BattleTaskView:_clearDatas()
	self._caculator:clear()

	self._lastResult = nil

	local parent = self._taskConditions.transform
	local firstChild = parent:GetChild(0).gameObject

	firstChild:SetActive(false)

	if self._conditions then
		for k, v in pairs(self._conditions) do
			goutil.destroy(v.go)
		end
	end

	self._conditions = nil
	self._ruleCfg = nil
end

function BattleTaskView:_onBattleHurtData(hurtData)
	return
end

function BattleTaskView:_onUseSkillStart(unit, skill)
	if skill and unit.teamId == BattleModel.instance.myTeamId then
		if self._caculator:hasTaskType(BattleTaskCaculator.MyUltCount) then
			local skillCo = skill.skillCo
			local type = GameEnum.SkillNameToType[skillCo.type]

			if type == GameEnum.SkillRaceType.Ult and (skill._attackCount == nil or skill._attackCount == 1) then
				self._caculator:increaseMyUltCount()
				self:_updateOneCondition(BattleTaskCaculator.MyUltCount)
			end
		end

		if self._caculator:hasTaskType(BattleTaskCaculator.MyCriticalCount) then
			local targets = skill:getSkillTargets()

			if targets then
				for _, target in pairs(targets) do
					if target and target.result and target.result.isCritical then
						self._caculator:increaseMyCriticalCount()
						self:_updateOneCondition(BattleTaskCaculator.MyCriticalCount)

						break
					end
				end
			end
		end
	end
end

function BattleTaskView:_popupAction(round)
	return
end

function BattleTaskView:_onBattleRoundStart(roundNum)
	if self._caculator:hasTaskType(BattleTaskCaculator.MyActiveRoundCount) then
		self._caculator:setRound(roundNum)
		self:_updateOneCondition(BattleTaskCaculator.MyActiveRoundCount)
	end
end

function BattleTaskView:_updateOneCondition(taskType)
	local obj = self._conditions[taskType]

	if obj == nil then
		return
	end

	local go = obj.go

	if HandleMaps[taskType] then
		local params = HandleMaps[taskType]
		local bSuccess, achieved, text = pcall(self[params[1]], self, self._caculator:getValueByString(params[2]), obj.taskConf)

		if bSuccess then
			goutil.setActive(go, true)

			local trueObj = goutil.findChild(go, "true")
			local falseObj = goutil.findChild(go, "false")
			local txtCondition = goutil.findChildTextComponent(go, "txtCondition")

			goutil.setActive(trueObj, achieved)
			goutil.setActive(falseObj, not achieved)

			local prefix = obj.taskConf.prefix

			txtCondition.text = not string.nilorempty(text) and string.format("%s%s", prefix, text) or prefix
		else
			goutil.setActive(go, false)
		end
	else
		goutil.setActive(go, false)
	end
end

function BattleTaskView:_handleMyPetArrType(value, cfg)
	local request = checknumber(cfg.params)

	return request <= value, nil
end

function BattleTaskView:_handleMyInitPos(value, cfg)
	local requestArray = string.splitToNumber(cfg.params, ",")
	local bSuccess = true

	for _, posId in pairs(requestArray) do
		if not value[posId] then
			bSuccess = false

			break
		end
	end

	return bSuccess, nil
end

function BattleTaskView:_handleDefault(value, cfg)
	local request = checknumber(cfg.params)

	return request <= value, string.format("%s/%s", tostring(value), tostring(request))
end

return BattleTaskView
