local var_0_0 = g.core.const.ConstMgr.PreciousConst
local var_0_1 = g.core.const.ConstMgr.LineUpConst
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.model.User.mulFormationData
local var_0_4 = g.core.model.User.formationData
local var_0_5 = g.core.model.User.fogNightmareData
local CommonLineUpPreciousSuitCell = class("CommonLineUpPreciousSuitCell", require("app.fairyGUI.infoPop.UI_CommonLineUpPreciousSuitCell"))

function CommonLineUpPreciousSuitCell:ctor()
	self.getSharedTrans(self, "listCrosbandBUiRightIn_cell", "LineUpRightList", self)
	self.m_starComp:initStar({
		gap = 0,
		style = 1,
		index = 3,
		num = 0,
		max = var_0_0.STAR_MAX_NUM
	})

	self._struct = nil

	self.m_skillIcon:addClickListener(handler(self, self._onClickSkillIcon))
end

function CommonLineUpPreciousSuitCell:updateCell(arg_2_1, arg_2_2)
	self._struct = arg_2_1

	local var_2_0 = arg_2_1:getCfg()

	self.m_qualityIcon:setURL((var_0_2:getPreciousSuitCellQualityUrl(arg_2_1:getQuality())))
	self.m_skillIcon:updateIcon({
		isPassive = true,
		skillId = var_2_0.passive_skill_id
	})
	self.m_nameTxt:setText(var_2_0.name)
	self.m_starComp:setStarNum(arg_2_1:getStar())
	self.m_gotoComp:updateGotoComp(arg_2_1)
	self.m_lineupController:setSelectedIndex((arg_2_2.formationType == var_0_1.MulTeamType.MAIN and var_0_4:getPreciousSuitStationPos(var_2_0.suit_group) > 0 or arg_2_2.formationType == var_0_1.MulTeamType.FOG_NIGHTMARE and var_0_5:getFormationData():isPreciousSuitLineup(arg_2_1:getSuitGroup()) or var_0_3:isPreciousSuitLineup(arg_2_2.formationType, arg_2_1:getSuitGroup())) and 1 or 0)
end

function CommonLineUpPreciousSuitCell:_onClickSkillIcon()
	if not self._struct then
		return
	end

	local var_3_0 = self._struct:getMaxPassiveSkillList()
	local var_3_1 = {}

	for iter_3_0 = 1, #var_3_0 do
		table.insert(var_3_1, {
			state = self._struct:getStar() >= var_3_0[iter_3_0].star and 0 or 1,
			title = g.core.lang:get(421210, {
				lv = var_3_0[iter_3_0].lv,
				star = var_3_0[iter_3_0].star
			}),
			desc = var_3_0[iter_3_0].desc
		})
	end

	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.CommonSkillPop").new({
		isPassive = true,
		skillId = self._struct:getCfg().passive_skill_id,
		descList = var_3_1,
		tipsText = g.core.lang:get(421209)
	}), {
		touchDisappear = true
	})
end

return CommonLineUpPreciousSuitCell
