local var_0_0 = g.core.const.ConstMgr.PreciousConst
local var_0_2 = g.core.common.Path
local var_0_5 = g.core.model.User.fogNightmareData
local FogCommonLineUpSuccubaCell = class("FogCommonLineUpSuccubaCell", require("app.fairyGUI.fogNightmare.UI_FogCommonLineUpSuccubaCell"))

function FogCommonLineUpSuccubaCell:ctor()
	self.getSharedTrans(self, "listCrosbandBUiRightIn_cell", "LineUpRightList", self)
	self.m_starComp:initStar({
		gap = 0,
		index = 3,
		style = 1,
		num = 0,
		max = var_0_0.STAR_MAX_NUM
	})

	self._struct = nil

	self.m_toBtn:addClickListener(handler(self, self._onClickToBtn))
end

function FogCommonLineUpSuccubaCell:updateComp(arg_2_1, arg_2_2)
	self._struct = arg_2_1

	self.m_qualityIcon:setURL((var_0_2:getPreciousSuitCellQualityUrl(arg_2_1:getQuality())))
	self.m_succubaIcon:getChild("iconComp"):setIcon(g.core.common.Path:getSuccubaIconById(self._struct:getShowCfg().res))

	local var_2_0 = arg_2_1:getCurCfg()

	self.m_nameTxt:setText(var_2_0.name)
	self.m_levelTxt:setText(g.core.lang:get(2052, {
		level = arg_2_1:getLevel()
	}))
	self.m_starComp:setStarNum(arg_2_1:getStar())
	self.m_skillIcon:updateIcon({
		skillId = var_2_0.skill_id
	})

	local var_2_1 = arg_2_2.curFormation
	local var_2_2, var_2_3

	if not arg_2_2.curFormation then
		var_2_1 = 0
		var_2_2 = var_0_5:getFormationData()
		var_2_3 = arg_2_1
	end

	self.m_lineupController:setSelectedIndex(var_2_2:checkSuccubaInAllFormation(var_2_3, g.core.config.multi_team_formation_info.get(g.core.const.ConstMgr.LineUpConst.MulTeamType.FOG_NIGHTMARE).succuba_repeat == 1 and var_2_1 or nil) and 1 or 0)
end

function FogCommonLineUpSuccubaCell:_onClickToBtn()
	if not self._struct then
		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.SUCUBA_DEV_LAYER, {
		advId = self._struct:getAdvanceId()
	})
end

return FogCommonLineUpSuccubaCell
