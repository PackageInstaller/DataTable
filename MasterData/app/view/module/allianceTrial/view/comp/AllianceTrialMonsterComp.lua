local var_0_0 = g.core.model.User.allianceTrialData
local AllianceTrialMonsterComp = class("AllianceTrialMonsterComp", require("app.fairyGUI.allianceTrial.UI_AllianceTrialMonsterComp"))

function AllianceTrialMonsterComp:ctor()
	self._monsterList = {}

	self:initView()
end

function AllianceTrialMonsterComp:initView()
	self.m_monsterList:setIniter()
	self.m_monsterList:setItemRenderer(handler(self, self._onRenderMonsterList))
	self:addListen(self.m_monsterList)
end

function AllianceTrialMonsterComp:_onRenderMonsterList(arg_3_1, arg_3_2)
	arg_3_2:updateMonsterInfo(self._monsterList[arg_3_1 + 1], self._bidDict[self._monsterList[arg_3_1 + 1].id])
end

function AllianceTrialMonsterComp:updateView()
	self._bidDict = {}
	self._monsterList = {}

	local var_4_0 = 0

	for iter_4_0, iter_4_1 in ipairs(var_0_0:getCurMonsterInfoList()) do
		if var_0_0:monsterIsDead(iter_4_1.id) then
			var_4_0 = var_4_0 + 1
		end

		self._bidDict[iter_4_1.id] = iter_4_0

		table.insert(self._monsterList, iter_4_1)
	end

	table.sort(self._monsterList, function(arg_5_0, arg_5_1)
		local var_5_0 = var_0_0:monsterIsDead(arg_5_0.id) and 1 or 0
		local var_5_1 = var_0_0:monsterIsDead(arg_5_1.id) and 1 or 0

		if var_5_0 ~= var_5_1 then
			return var_5_0 < var_5_1
		end

		return arg_5_0.id > arg_5_1.id
	end)
	self.m_deadNumText:setText(g.core.lang:get(430402, {
		dead = var_4_0,
		max = #self._monsterList
	}))
	self.m_monsterList:setNumItems(#self._monsterList)
end

return AllianceTrialMonsterComp
