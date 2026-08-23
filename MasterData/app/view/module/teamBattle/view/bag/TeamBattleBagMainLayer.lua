local var_0_0 = g.core.config.team_battle_parameter_info
local var_0_1 = g.core.const.ConstMgr.TeamBattleConst
local TeamBattleBagMainLayer = class("TeamBattleBagMainLayer", require("app.fairyGUI.teamBattle.UI_TeamBattleBagMainLayer"), function()
	return fgui.GComponent:create({
		resName = "TeamBattleBagMainLayer",
		pkgPath = "ui/teamBattle/teamBattle",
		isFullScreen = true,
		pkgName = "teamBattle"
	}, ...)
end)

function TeamBattleBagMainLayer:ctor()
	self._formationData = g.core.model.User.teamBattleData:getFormationData()
	self._showCardList = {}

	self:initView()
	self.m_enterTransition:play()
end

function TeamBattleBagMainLayer:initView()
	self:addBg("bg/exploration/bg_slmj_cangku.jpg", false, nil, 1)
	self.m_topBarComp:setResInfoById(g.core.const.ConstMgr.HelpConst.HELP_TYPE.TEAM_BATTLE)

	local var_3_0 = cc.Director:getInstance():getSafeAreaRect()
	local var_3_1 = self.m_showList:getWidth() * (display.width / CC_DESIGN_RESOLUTION.width)

	if var_3_0.x > 0 then
		var_3_1 = var_3_1 - var_3_0.x * 2
	end

	self.m_showList:setWidth(var_3_1)
	self.m_showList:setVirtual(self)
	self.m_showList:doFairyBatching(true)
	self.m_showList:setItemRenderer(handler(self, self._onRenderShowCardList))
end

function TeamBattleBagMainLayer:_onRenderShowCardList(arg_4_1, arg_4_2)
	arg_4_2:updateItem(self._showCardList[arg_4_1 + 1])
end

function TeamBattleBagMainLayer:onLoad()
	self:_updateBagView()
end

function TeamBattleBagMainLayer:_updateBagView()
	self:updateShowList()
end

function TeamBattleBagMainLayer:updateShowList()
	self._showCardList = self:getShowList()

	self.m_showList:setNumItems(#self._showCardList)
	self.m_isEmptyController:setSelectedIndex(#self._showCardList == 0 and 1 or 0)

	local var_7_0 = var_0_0.get(var_0_1.PARAMETER_ID.BAG_MAX_ID).parameter

	self.m_curNumText:setText(#self._showCardList)
	self.m_maxText:setText(g.core.lang:get(201028, {
		num = var_7_0
	}))

	if var_7_0 <= #self._showCardList then
		self.m_isMaxController:setSelectedIndex(1)

		local var_7_1 = g.core.lang:get(427141)

		self.m_maxTipText:setText(g.core.lang:get(420652, {
			name1 = var_7_1,
			name2 = var_7_1
		}))
	else
		self.m_isMaxController:setSelectedIndex(0)
	end
end

function TeamBattleBagMainLayer:getShowList()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(self._formationData:getAllKnightList()) do
		if not self._formationData:isSelfKnight(iter_8_1:getServerId()) then
			table.insert(var_8_0, iter_8_1)
		end
	end

	table.sort(var_8_0, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0:getQuality()
		local var_9_1 = arg_9_1:getQuality()

		if var_9_0 ~= var_9_1 then
			return var_9_1 < var_9_0
		end

		local var_9_2 = arg_9_0:getAdvanceId()
		local var_9_3 = arg_9_1:getAdvanceId()

		if var_9_2 ~= var_9_3 then
			return var_9_3 < var_9_2
		end

		return arg_9_0:getStarLv() > arg_9_1:getStarLv()
	end)

	return var_8_0
end

return TeamBattleBagMainLayer
