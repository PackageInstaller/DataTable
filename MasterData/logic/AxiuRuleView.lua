-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/axiu/AxiuRuleView.lua

module("logic.extensions.timelimitedchallenge.view.axiu.AxiuRuleView", package.seeall)

local AxiuRuleView = class("AxiuRuleView", PerfectRuleModeRuleView)

function AxiuRuleView:ctor()
	AxiuRuleView.super.ctor(self)
end

function AxiuRuleView:unbindEvents()
	AxiuRuleView.super.unbindEvents(self)
end

function AxiuRuleView:bindEvents()
	AxiuRuleView.super.bindEvents(self)
end

function AxiuRuleView:onExit()
	AxiuRuleView.super.onExit(self)
end

function AxiuRuleView:buildUI()
	AxiuRuleView.super.buildUI(self)
end

function AxiuRuleView:onEnter()
	AxiuRuleView.super.onEnter(self)
end

function AxiuRuleView:_refreshView()
	local curInfo = PerfectRuleModeModel.instance:getInfo(self._challengeId)

	if curInfo then
		local modeId = checkint(curInfo.curModeId)
		local ruleId = checkint(curInfo.curRuleId)

		if modeId > 0 and ruleId > 0 then
			self._modeIcon:SetState(modeId % 10 - 1)
			self._zdlTxt:SetText(PerfectRuleModeModel.instance:getShowZDLByModeId(self._challengeId, modeId))

			local modeCfg = PerfectRuleModeConfig.instance:getModeCfgs(self._challengeId, modeId)

			self._txtMode.text = langPara("%s难度", modeCfg.desc)

			MaterialMgr.clearIcon(self._iconRewards)
			MaterialMgr.clearIcon(self._iconRewardsPerfect)

			local matstr = modeCfg.normalPassScore

			self._txtRewards.text = matstr <= 1 and "" or string.format("%s 积分", matstr)
			matstr = modeCfg.perfectPassScore
			self._txtRewardsPerfect.text = modeCfg.perfectPassScore <= 1 and "" or string.format("%s 积分", matstr)

			local ruleCfg = PerfectRuleModeConfig.instance:getRuleCfgById(self._challengeId, ruleId)

			self._ruleDesc1.text = ruleCfg.buffDes
			self._ruleDesc2.text = langPara("普通通关：击败敌阵\n完美通关：击败敌阵且%s", ruleCfg.perfectDes)
		end
	end
end

return AxiuRuleView
