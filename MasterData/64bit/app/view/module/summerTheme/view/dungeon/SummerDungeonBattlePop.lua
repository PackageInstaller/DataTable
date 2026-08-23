local var_0_0 = g.core.common.GlobalFunc
local DebugCommon = require("app.view.module.debug.common.DebugCommon")
local var_0_2 = g.core.model.User.themeData
local var_0_3 = g.core.const.ConstMgr.ThemeConst
local var_0_4 = g.core.const.ConstMgr.ActivityConst.ACTIVITY_SOURCE_TYPE
local BattleConst = require("app.view.battle.const.BattleConst")
local var_0_6 = g.core.config.activity_theme_dungeon_stage_info
local var_0_7 = g.core.config.activity_theme_dungeon_monster_info
local SummerDungeonBattlePop = class("SummerDungeonBattlePop", require("app.fairyGUI.summerTheme.UI_SummerDungeonBattlePop"), function()
	local var_1_1 = {
		pkgPath = "ui/summerTheme/summerTheme",
		pkgName = "summerTheme"
	}

	var_1_1.resName = var_0_3.THEME_ACTIVITY_DUNGEON_BAT_POP[({
		...
	})[1].themeValue or var_0_3.THEME_VALUE.GRYPH] or var_0_3.THEME_ACTIVITY_DUNGEON_BAT_POP[1]

	return fgui.GComponent:create(var_1_1, ...)
end)

function SummerDungeonBattlePop:ctor(arg_2_1)
	local var_2_0

	if arg_2_1 then
		var_2_0 = arg_2_1.themeValue or var_0_3.THEME_VALUE.GRYPH
	end

	self._activeThemeType = var_0_3.THEME_TYPE
	self._activeThemeValue = var_2_0

	self:showAtCenter()

	self._stageId = arg_2_1.id
	self._chapterId = 0
	self._awards = {}
	self._dungeonData = var_0_2:getThemeData(self._activeThemeValue):getDungeonData()

	self:_initRegisterUIListen()
	self:_updateMainView()
	self.m_enterTransition:play()
end

function SummerDungeonBattlePop:_initRegisterUIListen()
	self.m_battleBtn:addClickListener(handler(self, self._onClickBattleBtn))
	self.m_formationBtn:addClickListener(handler(self, self._onClickFormationBtn))
	self.m_awardsList:setVirtual()
	self.m_awardsList:setItemRenderer(handler(self, self._onAwardItemRender))
end

function SummerDungeonBattlePop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_THEME_DUNGEON_BEGINCHALLENGE, self._onThemeDungeonBeginChallenge, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ITEM_USE, self._updateResourceCostInfo, self)
end

function SummerDungeonBattlePop:_updateMainView()
	local var_5_0 = var_0_6.get(self._stageId)
	local var_5_1 = var_0_7.get(self._stageId)

	self._chapterId = var_5_0.chapter_id

	self.m_stageIdTxt:setText(var_5_0.stage_id)
	self.m_stageNameTxt:setText(var_5_0.name)
	self.m_recommendTxt:setText(g.core.lang:get(405712, {
		num = var_5_1.recommend
	}))
	self.m_isReachController:setSelectedIndex(g.core.model.User:getFightValue() >= var_5_1.recommend and 1 or 0)

	self._awards = self._dungeonData:getStagePreviewAwards(self._stageId)

	self.m_awardsList:setNumItems(#self._awards)
	self.m_typeController:setSelectedIndex(math.max(0, self._activeThemeValue - 1 <= self.m_typeController:getPageCount() and self._activeThemeValue - 1 or 1))

	for iter_5_0 = 1, var_0_3.DUNGEON_FINISH_STAR do
		if self["m_cond" .. iter_5_0] then
			self["m_cond" .. iter_5_0]:setText(g.core.config.battle_rating_info.get(var_5_1["star_rating_" .. iter_5_0]).name)
		end
	end

	self._stageData = self._dungeonData:getStage(self._stageId)

	if self._stageData then
		local var_5_2 = self._stageData:getStageFinish()

		self.m_starComp:initStar({
			style = 1,
			index = 3,
			max = var_0_3.DUNGEON_FINISH_STAR,
			num = self._stageData:getStageStar()
		})
		self.m_isFinishController:setSelectedIndex(var_5_2 and 1 or 0)
	end

	self:_updateResourceCostInfo()
end

function SummerDungeonBattlePop:_updateResourceCostInfo()
	self._cost = var_0_7.get(self._stageId).cost

	self.m_costLoader:setURL((g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.TYPE_STAMINA, true)))
	self.m_costTxt:setText(self._cost)

	if g.core.model.User.bagData:getCountById(g.core.common.Goods.TYPE_RESOURCE, g.core.common.Goods.RESOURCE.TYPE_STAMINA) < self._cost then
		self.m_costTxt:setColor(g.core.common.Color.A4)
	else
		self.m_costTxt:setColor(g.core.common.Color.A1)
	end
end

function SummerDungeonBattlePop:_onAwardItemRender(arg_7_1, arg_7_2)
	arg_7_2:updateIcon(self._awards[arg_7_1 + 1])
end

function SummerDungeonBattlePop:_onClickBattleBtn()
	if not self:_checkBattleRes() then
		return
	end

	var_0_0.checkBagBeforeBattle(handler(self, self._startBattle))
end

function SummerDungeonBattlePop:_checkBattleRes()
	if g.core.model.User.resourceData:getVit() < g.core.config.activity_theme_dungeon_monster_info.get(self._stageId).cost then
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

function SummerDungeonBattlePop:_startBattle()
	g.core.network.GameNetProxy:send_C2S_ThemeDungeon_BeginChallenge({
		recruit_type = self._dungeonData:getDungeonActivitySourceType() == var_0_4.CONFIG_TABLE and 1 or 0,
		act_id = self._activeThemeValue,
		chapter_id = self._chapterId,
		stage_id = self._stageId
	})
end

function SummerDungeonBattlePop:_onThemeDungeonBeginChallenge(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = var_0_7.get(self._stageId)

	if not var_11_0 then
		return
	end

	if DebugCommon.getDebugGlobalValueByKey("theme_dungeon_skip_battle") then
		g.core.battle.BattleShowResult:disableAll()
		g.core.battle.BattleProxy:fastBattle(arg_11_3.battle_id)

		local var_11_1 = self._dungeonData

		g.core.common.Scheduler:newScheduleOnce(function()
			var_11_1:resetNewStageId()
			var_11_1:requestThemeDungeonInfo()
			g.core.battle.BattleShowResult:enableAll()
			g.core.module.ModuleManager:tip("debug battle end")
		end, 1)
		self:removeSelf()

		return
	end

	g.core.battle.BattleProxy:enterBattle({
		soundType = 4,
		type = BattleConst.TYPE_THEME_DUNGEON,
		battle_id = arg_11_3.battle_id,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		battleType = BattleConst.BATTLE_TYPE.PVE,
		typeQuality = var_11_0.quality,
		bgId = var_11_0.res,
		bgm = var_11_0.battle_music
	})
	self:removeSelf()
end

function SummerDungeonBattlePop:_onClickFormationBtn()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

return SummerDungeonBattlePop
