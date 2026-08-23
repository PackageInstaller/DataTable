local var_0_0 = g.core.const.ConstMgr.ThemeConst
local ThemeExploreBattleInfoRightComp = class("ThemeExploreBattleInfoRightComp", require("app.fairyGUI.summerTheme.UI_ThemeExploreBattleInfoRightComp"))

function ThemeExploreBattleInfoRightComp:ctor()
	self._monsterTeam = {}

	self.m_enemyList:setVirtual()
	self.m_enemyList:setItemRenderer(handler(self, self._onEnemyListRenderer))
	self.m_battleBtn:addClickListener(handler(self, self._onBattleBtnClick))
	self.m_lineupBtn:addClickListener(handler(self, self._onLineUpBtnClick))
end

function ThemeExploreBattleInfoRightComp:onLoad()
	self.m_enterTransition:play()
end

function ThemeExploreBattleInfoRightComp:setCLoseFunc(arg_3_1)
	self._closeFunc = arg_3_1
end

function ThemeExploreBattleInfoRightComp:updateInfo(arg_4_1)
	self._params = arg_4_1

	local var_4_0 = arg_4_1.objCfg

	self._battleClickFunc = arg_4_1.callback

	local var_4_1 = arg_4_1.battleCfg
	local var_4_2

	if arg_4_1 then
		var_4_2 = arg_4_1.themeValue or var_0_0.THEME_VALUE.GRYPH
	end

	self._activeThemeType = var_0_0.THEME_TYPE
	self._activeThemeValue = var_4_2
	self._chapter = arg_4_1.chapter

	local var_4_3 = arg_4_1.content.monster_hp or {}

	self.m_nameTxt:setText(var_4_0.name)
	self.m_descComp:setTitle(var_4_0.des)
	self.m_fightValueTxt:setText(var_4_1.monster_power)
	self.m_costTxt:setText(var_4_1.power)

	if var_4_0.operation and var_4_0.operation ~= "" then
		self.m_battleBtn:setText(var_4_0.operation)
	end

	if g.core.model.User.resourceData:getVit() < var_4_1.power then
		self.m_lackController:setSelectedIndex(1)
	else
		self.m_lackController:setSelectedIndex(0)
	end

	self.m_costLoader:setURL(g.core.common.Goods:convert({
		type = g.core.common.Goods.TYPE_RESOURCE,
		value = g.core.common.Goods.RESOURCE.TYPE_STAMINA
	}).icon_mini)

	local var_4_4 = g.core.config.monster_team_info.get(var_4_1.monster_team_id, 1)

	for iter_4_0 = 1, 6 do
		if var_4_4["monster_" .. iter_4_0] and var_4_4["monster_" .. iter_4_0] > 0 then
			local var_4_5 = {
				info = g.core.config.knight_info.get(g.core.config.monster_info.get(var_4_4["monster_" .. iter_4_0]).advance_id)
			}

			var_4_5.hpTh = var_4_3[iter_4_0] or 1000

			table.insert(self._monsterTeam, var_4_5)
		end
	end

	self.m_enemyList:setNumItems(#self._monsterTeam)
	self.m_knightPicComp:updateKnight({
		resId = var_4_0.res
	})
	self.m_knightPicComp:setAlphaRect(g.core.const.ConstMgr.SpineConst.MASK_TYPE.HORIZON, cc.rect(-250, 0, 500, 0), 150)
end

function ThemeExploreBattleInfoRightComp:_checkBattleRes()
	if g.core.model.User.resourceData:getVit() < self._params.battleCfg.power then
		g.core.module.ModuleManager:pushPopup(require("app.view.base.infoPop.BaseUseBuyPop").new({
			type = g.core.common.Goods.TYPE_ITEM,
			value = g.core.common.Goods.ITEM.TYPE_STAMINA_PILL,
			shopId = g.core.const.ConstMgr.ShopConst.SHOP_ITEM_ID.STAMINA_PILL
		}), {
			touchDisappear = true
		})

		return false
	end

	return true
end

function ThemeExploreBattleInfoRightComp:_onEnemyListRenderer(arg_6_1, arg_6_2)
	arg_6_2:updateHpIcon(self._monsterTeam[arg_6_1 + 1])
end

function ThemeExploreBattleInfoRightComp:_onBattleBtnClick()
	local var_7_0 = true
	local var_7_1 = g.core.model.User.knightsData:getFormation()
	local var_7_2 = g.core.model.User.themeData:getThemeData(self._activeThemeValue):getExploreData():getChapterSelfHpPer(self._chapter)

	for iter_7_0 = 1, 6 do
		if var_7_1[iter_7_0] > 0 and var_7_2[iter_7_0] > 0 then
			var_7_0 = false

			break
		end
	end

	if var_7_0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(405739))

		return
	end

	if not self:_checkBattleRes() then
		return
	end

	if self._battleClickFunc then
		self._battleClickFunc()
	end

	if self._closeFunc then
		self._closeFunc()
	else
		self:getParent():removeSelf()
	end
end

function ThemeExploreBattleInfoRightComp:_onLineUpBtnClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION, {
		posHpList = g.core.model.User.themeData:getThemeData(self._activeThemeValue):getExploreData():getChapterSelfHpPer(self._chapter)
	})
end

function ThemeExploreBattleInfoRightComp:onClosePnl(arg_9_1)
	if arg_9_1 then
		self.m_backTransition:play(arg_9_1)
	else
		self.m_backTransition:play()
	end
end

return ThemeExploreBattleInfoRightComp
