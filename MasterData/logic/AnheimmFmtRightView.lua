-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/mission/AnheimmFmtRightView.lua

module("logic.extensions.timelimitedchallenge.view.mission.AnheimmFmtRightView", package.seeall)

local AnheimmFmtRightView = class("AnheimmFmtRightView", FormationRightView)

function AnheimmFmtRightView:_setJobLabelStr()
	self._jobLabelStr = nil

	local ruleId = AnheimmModel.instance:getCurRuleId()
	local ruleCfg = AnheimmConfig.instance:getRuleCfgById(ruleId)
	local formConditionId = checknumber(ruleCfg.formConditionId)

	if formConditionId > 0 then
		local cfg = FormationValidatorConfig.instance:getFormationAllValidatorCfg(formConditionId)

		if cfg and not string.nilorempty(cfg.label) then
			self._jobLabelStr = cfg.label
		end

		return
	end

	local perfectWinId = checknumber(ruleCfg.perfectWinId)

	if perfectWinId > 0 then
		local cfg = AnheimmConfig.instance:getPerfectWinOpCfg(perfectWinId)

		if cfg and not string.nilorempty(cfg.label) then
			self._jobLabelStr = cfg.label
		end
	end
end

return AnheimmFmtRightView
