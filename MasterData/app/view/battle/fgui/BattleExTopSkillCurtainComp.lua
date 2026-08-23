local var_0_0 = g.core.const.ConstMgr.QUALITY_TYPE
local CriSprite = require("app.view.common.CriSprite")
local var_0_2 = g.core.common.Path
local BattleConst = require("app.view.battle.const.BattleConst")
local BattleExTopSkillCurtainComp = class("BattleExTopSkillCurtainComp", require("app.fairyGUI.battle.UI_BattleExTopSkillCurtainComp"))

function BattleExTopSkillCurtainComp:ctor()
	self._isDelete = false
	self._criEnd = false
	self._tranEnd = false

	self:setSize(display.width, display.height)
	self.m_enterMrTransition:setHook("iconShow", handler(self, self.iconShowEffect))
end

function BattleExTopSkillCurtainComp:iconShowEffect(arg_2_1)
	self.m_efficon:addEffectSpine({
		anim = "play",
		name = "eff_ui_battle_mrskilltxt",
		remove = true,
		isLoop = false
	})
end

function BattleExTopSkillCurtainComp:updateView(arg_3_1)
	arg_3_1 = arg_3_1 or {}
	self._callback = arg_3_1.callback

	local var_3_0 = arg_3_1.knightInfo

	self.m_skillNameText:setText(arg_3_1.skillName or "")
	self.m_iconLoader:setURL(var_0_2:getSkillIconById(arg_3_1.skillInfo.icon))
	self.m_sideTypeController:setSelectedIndex(arg_3_1.identity - 1)

	local var_3_1 = "UI_superskill_1334x750_2000"

	if var_3_0.quality == var_0_0.MR then
		var_3_1 = "UI_superskillMR_1334x750_2000"

		if var_3_0.is_element_leader > 0 and arg_3_1.skillInfo.curtain == 40 then
			var_3_1 = "UI_superskillMRLeader_1334x750_2000"
		end

		self.m_enterMrTransition:play(handler(self, self.tranEnd))
	else
		self.m_enterTransition:play(handler(self, self.tranEnd))
	end

	if arg_3_1.isMonster then
		self.m_elementalController:setSelectedIndex(0)
	else
		self.m_elementalController:setSelectedIndex(var_3_0.classical)
	end

	if var_3_0.is_element_leader > 0 and arg_3_1.skillInfo.curtain == 40 then
		self.m_is_leaderController:setSelectedIndex(1)
	else
		self.m_is_leaderController:setSelectedIndex(0)
	end

	local var_3_2 = CriSprite.new({
		fullScreenState = 1,
		height = 750,
		moduleName = "battle",
		width = 1334,
		movieName = var_3_1,
		listener = handler(self, self.criSpriteEvent)
	})

	self.m_criSprite:addNode(var_3_2)
	var_3_2:setPlaySpeed(arg_3_1.timeScale or 1)
	self:newScheduleOnce(handler(self, self.scheduleEnd), var_3_2:getTotalTime() * 0.001 + 0.2)
end

function BattleExTopSkillCurtainComp:scheduleEnd()
	if not self._criEnd then
		self._criEnd = true

		if self._tranEnd then
			self:onDelete()
		end
	end
end

function BattleExTopSkillCurtainComp:tranEnd()
	self._tranEnd = true

	if self._criEnd then
		self:onDelete()
	end
end

function BattleExTopSkillCurtainComp:criSpriteEvent(arg_6_1)
	if arg_6_1 == BattleConst.SPINE_EVENT.COMPLETE then
		self._criEnd = true

		if self._tranEnd then
			self:onDelete()
		end
	end
end

function BattleExTopSkillCurtainComp:onDelete()
	if self._isDelete then
		return
	end

	self._isDelete = true

	if self._callback then
		self._callback()
	end

	self:removeFromParent()
end

return BattleExTopSkillCurtainComp
