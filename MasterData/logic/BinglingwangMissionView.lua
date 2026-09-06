-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/binglingwang/mission/BinglingwangMissionView.lua

module("logic.extensions.mangtower.view.BinglingwangMissionView", package.seeall)

local BinglingwangMissionView = class("BinglingwangMissionView", MissionView)

function BinglingwangMissionView:onEnter()
	self:onEnterInherit()

	self.monsterCfg = self:_getMonsterCo()

	local ruleDesc = self.monsterCfg.WinDesc
	local titleStr = self.monsterCfg.name

	self:_setDescStr(titleStr, nil, ruleDesc)
	self:_setPureValidatorDesc(self.monsterCfg.missionDesc)
end

function BinglingwangMissionView:_getMonsterCo()
	local params = self._viewPresentor:getFirstParam()
	local cCfg

	if params then
		local challengeId = params.challengeId
		local index = params.index
		local infoMo = BinglingwangModel.instance:getChallangeInfoById(challengeId) or {}
		local day = checknumber(infoMo.participateDays)
		local list = BinglingwangConfig.instance:getMonsterCfg(challengeId, day)

		if list then
			if not list[index] then
				return list[index]
			end
		end
	end

	return {}
end

function BinglingwangMissionView:_enterBattle()
	local params = self._viewPresentor:getFirstParam()

	if params then
		local challengeId = params.challengeId
		local index = params.index
		local cfg = TimeLimitedConfig.instance:getCfgById(challengeId)

		if cfg then
			local funcCfg = FuncOpenConfig.instance:getFunctionOpenById(cfg.openFuncId)

			if funcCfg and not string.nilorempty(funcCfg.view) then
				UIJumper.instance:pushOneStack(funcCfg.view, true)
			end
		end

		UIJumper.instance:pushOneStack(ViewName.BinglingwangdetailView, true)

		local cfg = self.monsterCfg
		local ruleDesc = cfg.WinDesc

		MissionModel.instance:setRuleDesc(ruleDesc, self._txtValidatorDesc.text)
		BattleFacade.instance:startBattle(GameEnum.MissionType.BING_LING_WANG)
		BinglingwangModel.instance:setCurrMonsterCfg(cfg)

		local ctrl = BinglingwangController.instance

		BattleFacade.instance:registerResultHandler(GameUtil.handler(ctrl.onBattleEnd, ctrl, challengeId, index))
		BinglingwangController.instance:sendFight(challengeId, index)
	end
end

return BinglingwangMissionView
