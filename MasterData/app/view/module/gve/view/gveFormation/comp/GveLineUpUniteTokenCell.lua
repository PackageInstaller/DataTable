local var_0_0 = g.core.model.User.uniteTokenData
local var_0_1 = g.core.model.User.gveDataMgr
local var_0_2 = g.core.config.skill_range_info
local GveLineUpUniteTokenCell = class("GveLineUpUniteTokenCell", require("app.fairyGUI.gve.UI_GveLineUpUniteTokenCell"))

function GveLineUpUniteTokenCell:ctor()
	self._formationData = var_0_1:getGveFormationData()
	self._skillInfo = nil
	self._skillTip = {}
	self._skillIcon = self.m_skillComp:getChild("skillIcon")

	self._skillIcon:addClickListener(handler(self, self._clickIcon))
	self.getSharedTrans(self, "enter_right", "CommonShortCellList", self)
end

function GveLineUpUniteTokenCell:updateCell(arg_2_1, arg_2_2)
	local var_2_0 = arg_2_1:getSkillId()

	self._skillInfo = var_0_0:getTokenBaseInfo(var_2_0).skillInfo
	self._skillTip = {
		skillId = var_2_0,
		star = arg_2_1:getStarLevel(),
		uniteTokenAdvId = arg_2_1:getAdvanceId()
	}

	self._skillIcon:updateIcon({
		skillId = var_2_0
	})
	self.m_nameText:setText(arg_2_1:getName())
	self.m_featureText:setText(var_0_2.get(self._skillInfo.cfg.skill_range_info).name)
	self.m_qualityController:setSelectedIndex(arg_2_1:getQuality() - 1)

	local var_2_1 = arg_2_1:getAdvanceId()

	self.m_stateController:setSelectedIndex((arg_2_2 and arg_2_2.formationStruct:isUniteTokenLineUp(var_2_1) or self._formationData:checkUniteIsLineUp(var_2_1)) and 1 or 0)
end

function GveLineUpUniteTokenCell:_clickIcon()
	if self._skillInfo then
		g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.UniteTokenSkillPop").new(self._skillInfo), {
			touchDisappear = true
		})
	end
end

return GveLineUpUniteTokenCell
