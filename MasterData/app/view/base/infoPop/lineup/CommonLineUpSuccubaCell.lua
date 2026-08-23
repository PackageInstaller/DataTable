local var_0_0 = g.core.const.ConstMgr.PreciousConst
local var_0_1 = g.core.const.ConstMgr.LineUpConst
local var_0_2 = g.core.common.Path
local var_0_3 = g.core.model.User.mulFormationData
local var_0_4 = g.core.model.User.formationData
local var_0_5 = g.core.model.User.fogNightmareData
local CommonLineUpSuccubaCell = class("CommonLineUpSuccubaCell", require("app.fairyGUI.infoPop.UI_CommonLineUpSuccubaCell"))

function CommonLineUpSuccubaCell:ctor()
	self.getSharedTrans(self, "listCrosbandBUiRightIn_cell", "LineUpRightList", self)
	self.m_starComp:initStar({
		gap = 0,
		style = 1,
		index = 3,
		num = 0,
		max = var_0_0.STAR_MAX_NUM
	})

	self._struct = nil

	self.m_toBtn:addClickListener(handler(self, self._onClickToBtn))
end

function CommonLineUpSuccubaCell:updateCell(arg_2_1, arg_2_2)
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
	self.m_lineupController:setSelectedIndex((arg_2_2.formationType == var_0_1.MulTeamType.MAIN and var_0_4:getSuccubaStationPos(arg_2_1:getSid()) > 0 or arg_2_2.formationType == var_0_1.MulTeamType.FOG_NIGHTMARE and var_0_5:getFormationData():isSuccubaLineup(arg_2_1:getSid()) or arg_2_2.formationStruct and arg_2_2.formationStruct:isSuccubaLineUp(arg_2_1:getSid()) or var_0_3:isSuccubaLineUp(arg_2_2.formationType, arg_2_1:getSid())) and 1 or 0)
end

function CommonLineUpSuccubaCell:_onClickToBtn()
	if not self._struct then
		return
	end

	g.core.module.ModuleManager:pushModule(g.view.entrance.SUCUBA_DEV_LAYER, {
		advId = self._struct:getAdvanceId()
	})
end

return CommonLineUpSuccubaCell
