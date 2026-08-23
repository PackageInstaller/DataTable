local TeamBattleConst = require("app.view.module.teamBattle.const.TeamBattleConst")
local var_0_1 = g.core.model.User.teamBattleData
local TeamBattleKnightBagLayer = class("TeamBattleKnightBagLayer", require("app.fairyGUI.teamBattle.UI_TeamBattleKnightBagLayer"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleKnightBagLayer",
		pkgPath = "ui/teamBattle/teamBattle",
		isFullScreen = true,
		pkgName = "teamBattle"
	}, ...)
end)

function TeamBattleKnightBagLayer:ctor()
	self._knightList = var_0_1:getFormationData():getAllKnightList()

	table.sort(self._knightList, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_3_0:getHpRatio() > 0

		if var_3_0 ~= (arg_3_1:getHpRatio() > 0) then
			return var_3_0
		end

		local var_3_1 = arg_3_0:getQuality()
		local var_3_2 = arg_3_1:getQuality()

		if var_3_1 ~= var_3_2 then
			return var_3_2 < var_3_1
		end

		local var_3_3 = arg_3_0:getStarLv()
		local var_3_4 = arg_3_1:getStarLv()

		if var_3_3 ~= var_3_4 then
			return var_3_4 < var_3_3
		end

		return arg_3_0:getAdvanceId() > arg_3_1:getAdvanceId()
	end)
	self:_initView()
end

function TeamBattleKnightBagLayer:_initView()
	self.m_knightList:setVirtual(self)
	self.m_knightList:setItemRenderer(handler(self, self._onRenderAttrList))
	self.m_knightList:doFairyBatching(false)
	self:addBg("bg/teamBattle/bg_hjtj_beibao.jpg", false, nil, 1)
	self.m_curTxt:setText(#self._knightList)

	self._maxNum = g.core.config.team_battle_parameter_info.get(TeamBattleConst.PARAMETER_ID.BAG_MAX_ID).parameter

	self.m_maxTxt:setText(g.core.lang:get(201028, {
		num = self._maxNum
	}))
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.TEAM_BATTLE)
end

function TeamBattleKnightBagLayer:onLoad()
	self:_updateView()
end

function TeamBattleKnightBagLayer:_updateView()
	self.m_knightList:setNumItems(#self._knightList)
	self.m_isMaxController:setSelectedIndex(#self._knightList >= self._maxNum and 1 or 0)
end

function TeamBattleKnightBagLayer:_onRenderAttrList(arg_7_1, arg_7_2)
	arg_7_2:updateItem(self._knightList[arg_7_1 + 1])
end

return TeamBattleKnightBagLayer
