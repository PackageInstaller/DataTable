-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/view/BattleWorldBossView.lua

module("logic.extensions.worldboss.view.BattleWorldBossView", package.seeall)

local BattleWorldBossView = class("BattleWorldBossView")

function BattleWorldBossView:ctor(go, view, bloodBar)
	self._view = view
	self.mainGO = go
	self._bloodBar = bloodBar
end

function BattleWorldBossView:destroyUI()
	return
end

function BattleWorldBossView:onExit()
	return
end

function BattleWorldBossView:buildUI()
	return
end

function BattleWorldBossView:setActive(active)
	goutil.setActive(self.mainGO, active)
end

function BattleWorldBossView:onEnter()
	if not BattleModel.instance.worldBossId then
		local bossId = 1
		local bossCfg = WorldBossConfig.instance:getWorldBossChallengePrize(bossId)

		self._cfgs = {}

		for k, v in pairs(bossCfg) do
			if checknumber(v.processorSection) > 0 then
				table.insert(self._cfgs, {
					interval = v.processorSection * BattleModel.instance:getTeamSpeed(1)
				})
			end
		end

		table.sort(self._cfgs, function(a, b)
			return a.interval < b.interval
		end)
	end
end

function BattleWorldBossView:updateValue(cur, total, isForce)
	local value = total - cur

	if self._cfgs == nil then
		return
	end

	value = checknumber(value)
	value = math.max(0, value)
	self._value = checknumber(self._value)
	self._value = math.max(0, self._value)

	local targetCfg, targetIdx = self:_getCurCfgAndNeed(value)

	self._bloodBar:setTextProgress(string.format("总伤害：%s/%s", value, targetCfg.interval))

	local sliderValue = targetIdx - 1 + value / targetCfg.interval

	self._bloodBar:setProgress(sliderValue, isForce)

	self._value = value
end

function BattleWorldBossView:_getCurCfgAndNeed(value)
	local idx

	for i = 1, #self._cfgs do
		if value < self._cfgs[i].interval then
			idx = i

			break
		end
	end

	idx = idx or #self._cfgs

	local cfg = self._cfgs[idx]

	return cfg, idx
end

return BattleWorldBossView
