local var_0_0 = g.core.config.explore_battle_info
local var_0_1 = g.core.common.Goods
local var_0_2 = 6
local ExploreBattleInfoPop = class("ExploreBattleInfoPop", require("app.fairyGUI.robTreasure.UI_ExploreBattleInfoPop"), function()
	return fgui.GComponent:create({
		resName = "ExploreBattleInfoPop",
		pkgPath = "ui/robTreasure/robTreasure",
		isFullScreen = true,
		pkgName = "robTreasure"
	})
end)
local var_0_4 = g.core.common.GlobalFunc

function ExploreBattleInfoPop:ctor(arg_2_1)
	self._eventInfo = arg_2_1.eventInfo
	self._eventData = arg_2_1.eventData
	self._treasureId = arg_2_1.treasureId
	self._useData = self._eventData.user
	self._useKnights = self._useData.knights
	self._battleInfo = var_0_0.get(arg_2_1.eventInfo.type_id)

	self:_initListener()
	self.m_enterTransition:play()

	local var_2_0 = self.m_effUiAudio:getSize()

	self.m_effUiAudio:addEffectSpine({
		name = "eff_ui_dungeon_audio",
		isLoop = true,
		scale = 1,
		x = var_2_0.width / 2,
		y = var_2_0.height / 2
	})
	self.m_knightList:setVirtual()
	self.m_knightList:setItemRenderer(handler(self, self._onRendererKnight))
end

function ExploreBattleInfoPop:_onRendererKnight(arg_3_1, arg_3_2)
	arg_3_2:updateComp(arg_3_1 + 1, self._useKnights[arg_3_1 + 1] > 0 and {
		baseId = self._useKnights[arg_3_1 + 1]
	} or nil, true, false)
end

function ExploreBattleInfoPop:_initListener()
	self.m_battleBtn:addClickListener(handler(self, self._onClickBattle))
	self.m_lineupBtn:addClickListener(handler(self, self._onClickLineUp))
	self.m_touchBg:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._hideAction))
end

function ExploreBattleInfoPop:_onClickBattle()
	if not self:_checkBattleRes() then
		return
	end

	var_0_4.checkBagBeforeBattle(handler(self, self._startBattle))
end

function ExploreBattleInfoPop:_checkBattleRes()
	if g.core.model.User.bagData:getCountById(self._type, self._value) < 1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(304509))

		return false
	end

	return true
end

function ExploreBattleInfoPop:_startBattle()
	g.core.network.GameNetProxy:send_C2S_ExploreTreasure_BattleEvent_Begin({
		id = self._treasureId,
		explore_id = self._eventData.id
	})
end

function ExploreBattleInfoPop:_onClickLineUp()
	g.core.module.ModuleManager:pushModule(g.view.entrance.FORMATION)
end

function ExploreBattleInfoPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_EXPLORE_TREASURE_BATTLEEVENT_BEGIN, self._onRcvAttackBegin, self)
	self:updateView()
end

function ExploreBattleInfoPop:updateView()
	local var_10_0 = g.core.config.knight_info.fetch(tonumber(self._battleInfo.painted_id))

	if not var_10_0 then
		return
	end

	self.m_nameTxt:setText(var_10_0.name)
	self.m_knightPicComp:updateKnight({
		resId = var_10_0.res_id
	})
	self.m_knightList:setNumItems(var_0_2)
	self:_updateBattleBtnInfo({
		cost = 1,
		type = var_0_1.TYPE_RESOURCE,
		value = var_0_1.RESOURCE.TYPE_ROB_NUM
	})
end

function ExploreBattleInfoPop:_updateBattleBtnInfo(arg_11_1)
	if arg_11_1 then
		self._type = arg_11_1.type or 1
	end

	if arg_11_1 then
		self._value = arg_11_1.value or 1
	end

	if arg_11_1 then
		self._cost = arg_11_1.cost or 1
	end

	self.m_costLoader:setURL((g.core.common.Path:getIconByTypeValue(self._type, self._value, true)))
	self.m_costTxt:setText(self._cost)

	if g.core.model.User.bagData:getCountById(self._type, self._value) < self._cost then
		self.m_costTxt:setColor(g.core.common.Color.top.RED)
	end
end

function ExploreBattleInfoPop:_hideAction()
	self:stopAllFGActions()

	if self.m_backTransition then
		self.m_backTransition:play(function()
			g.core.module.ModuleManager:popModule()
		end)
	else
		g.core.module.ModuleManager:popModule()
	end
end

function ExploreBattleInfoPop:_onRcvAttackBegin(arg_14_1, arg_14_2, arg_14_3)
	self:_hideAction()

	local BattleConst = require("app.view.battle.const.BattleConst")

	g.core.battle.BattleProxy:enterBattle({
		soundType = 1,
		type = BattleConst.TYPE_TREASURE,
		battle_id = arg_14_3.battle_id[1],
		battleType = BattleConst.BATTLE_TYPE.PVE,
		skip = BattleConst.SKIP_TYPE.ACTIVE,
		bgId = g.core.config.explore_treasure_info.get(arg_14_3.id).battle_stage
	})
end

return ExploreBattleInfoPop
