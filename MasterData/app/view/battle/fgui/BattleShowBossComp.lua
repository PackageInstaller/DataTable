local DrawKnight = require("app.view.common.DrawKnight")
local BattlePath = require("app.view.battle.BattlePath")
local BattleConst = require("app.view.battle.const.BattleConst")
local KnightSkillDescTip = require("app.view.module.tip.view.KnightSkillDescTip")
local BattleShowBossComp = class("BattleShowBossComp", require("app.fairyGUI.battle.UI_BattleShowBossComp"), function()
	return fgui.GComponent:create({
		resName = "BattleShowBossComp",
		pkgPath = "ui/battle/battle",
		isFullScreen = true,
		pkgName = "battle"
	})
end)

function BattleShowBossComp:ctor(arg_2_1)
	self.m_bg:setSize(display.width, display.height)

	self._battleLayer = arg_2_1.battleLayer
	self._teamInfo = arg_2_1.teamData
	self._monsterTeamInfo = arg_2_1.teamInfo
	self._cacheId = arg_2_1.id
	self._rebelId = arg_2_1.rebelId
	self._type = arg_2_1.type
	self._callback = arg_2_1.callback

	self:_initView()
	self.m_enterTransition:play()
end

function BattleShowBossComp:_initView()
	self:addClickListener(handler(self, self._onClickBossView))

	local var_3_0
	local var_3_1

	if self._type == BattleConst.TYPE_REBEL then
		local var_3_2 = g.core.config.rebel_info.get(self._rebelId)

		var_3_1 = g.core.config.knight_info.get(var_3_2.res)
		self._monsterId = var_3_2.res
		self._star = 1
		var_3_0 = var_3_1.name
	else
		self._monsterId = self._monsterTeamInfo["monster_" .. self._monsterTeamInfo.show_monster]
		self._star = 1
		var_3_1 = g.core.config.monster_info.get(self._monsterTeamInfo["monster_" .. self._monsterTeamInfo.show_monster])
		var_3_0 = var_3_1.name
	end

	self.m_bossNameText:setText(var_3_0)
	self.m_spinePlaceHolder:addChild((DrawKnight.new({
		baseId = var_3_1.res_id
	})))

	local var_3_3 = g.core.config.knight_info.get(var_3_1.advance_id)
	local var_3_4 = var_3_3.tactics or ""

	self.m_locationText:setText(var_3_3.feature or "")
	self.m_strategyText:setText(var_3_4)

	self._commonId = var_3_1.common_id
	self._activeSkillId = var_3_1.active_skill_id
	self._passiveSkill = self._type == BattleConst.TYPE_REBEL and self:getPassiveSkillIdById(self._monsterId) or var_3_1.passive_skill

	self.m_skillIcon1:addClickListener(handler(self, self._onClickIcon1))
	self.m_skillIcon2:addClickListener(handler(self, self._onClickIcon2))
	self.m_skillIcon3:addClickListener(handler(self, self._onClickIcon3))
	self.m_skillIcon1:updateIcon({
		skillId = self._commonId
	})
	self.m_skillIcon2:updateIcon({
		skillId = self._activeSkillId
	})

	if self._passiveSkill ~= 0 then
		self.m_skillIcon3:setVisible(true)
		self.m_skillIcon3:updateIcon({
			skillId = g.core.config.passive_skill_info.get(self._passiveSkill).passive_skill_value
		})
	else
		self.m_skillIcon3:setVisible(false)
	end

	if self._type ~= BattleConst.TYPE_REBEL then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_START)
	end
end

function BattleShowBossComp:_onClickIcon1()
	g.core.module.ModuleManager:pushPopup(KnightSkillDescTip.new({
		isForceStyle = true,
		star = 0,
		skillId = self._commonId,
		knightAdvId = self._monsterId
	}), {
		touchDisappear = true
	})
end

function BattleShowBossComp:_onClickIcon2()
	g.core.module.ModuleManager:pushPopup(KnightSkillDescTip.new({
		isForceStyle = true,
		star = 0,
		skillId = self._activeSkillId,
		knightAdvId = self._monsterId
	}), {
		touchDisappear = true
	})
end

function BattleShowBossComp:_onClickIcon3()
	g.core.module.ModuleManager:pushPopup(KnightSkillDescTip.new({
		isForceStyle = true,
		star = 0,
		skillId = self._passiveSkill,
		knightAdvId = self._monsterId
	}), {
		touchDisappear = true
	})
end

function BattleShowBossComp:_onClickBossView()
	if self._type == BattleConst.TYPE_REBEL then
		if self._callback then
			self._callback()
		else
			self:_onCloseLayer()
		end
	else
		if g.core.battle.BattleProxy:getBattleLayer() ~= nil then
			local var_7_0 = g.core.common.Storage:load("show_boss_detail.json") or {}

			var_7_0[tostring(self._cacheId)] = true

			g.core.common.Storage:save("show_boss_detail.json", var_7_0)
		end

		self:_onCloseLayer()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_TOUCH_END)
	end
end

function BattleShowBossComp:_onCloseLayer()
	if self._battleLayer._playAttacks then
		self._battleLayer:_playAttacks()
	end

	self._battleLayer:showActorClickNode(true)
	self:removeFromParent()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_GUIDE_CHANGE_UI_STATE, false, {
		show = true
	})
end

function BattleShowBossComp:getPassiveSkillIdById(arg_9_1)
	local var_9_0 = 0
	local var_9_1 = g.core.config.knight_info.get(arg_9_1)

	for iter_9_0 = 1, g.core.const.ConstMgr.KNIGHT_CONST.TRAIN_MAX do
		if var_9_0 > 0 then
			var_9_0 = var_9_1["promote_passive_" .. iter_9_0 .. "_1"]
		end
	end

	return var_9_0
end

return BattleShowBossComp
