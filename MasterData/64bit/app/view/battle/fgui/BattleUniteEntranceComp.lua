local var_0_0 = g.core.const.ConstMgr.SpineConst
local var_0_2 = g.core.common.Path
local BattlePath = require("app.view.battle.BattlePath")
local DrawUniteToken = require("app.view.common.DrawUniteToken")
local BattleUniteEntranceComp = class("BattleUniteEntranceComp", require("app.fairyGUI.battle.UI_BattleUniteEntranceComp"))

function BattleUniteEntranceComp:ctor()
	return
end

function BattleUniteEntranceComp:updateView(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._callback = arg_2_1.callback
	self._uniteId = arg_2_1.uniteId

	local var_2_0 = g.core.config.unite_token_info.get(self._uniteId)

	self._quality = g.core.config.skill_info.get(var_2_0.skill_id).skill_quality

	local var_2_1 = "eff_ui_battle_unite_" .. self._quality + 1
	local var_2_2 = "eff_ui_battle_uniteBg_" .. self._quality + 1

	self.m_qualityController:setSelectedIndex(self._quality - 1)

	if var_2_0.name then
		self.m_nameText1:setText(var_2_0.name)
	end

	if #var_2_0.sound_curtain > 0 then
		g.core.sound.SoundManager:playBattleSound(var_2_0.sound_curtain)
	end

	local var_2_3 = BattlePath.getUniteIconPath(self._uniteId)

	if var_2_3 then
		self.m_iconBg:setURL(var_2_3)
	end

	if DrawUniteToken:showSpineEnable(self._uniteId) then
		local var_2_4 = DrawUniteToken.new({
			loop = false,
			autoIdle = false,
			advId = var_2_0.advance_id,
			anim = var_0_0.UniteTokenAni.SHOW
		})

		var_2_4:getSpineBase():getBaseSpine():setTimeScale(arg_2_1.timeScale or 1)
		self.m_iconSpineDad:removeChildren()
		self.m_iconSpineDad:addChild(var_2_4)
		self.m_icon:setVisible(false)
	elseif var_2_3 then
		self.m_icon:setVisible(true)
		self.m_icon:setURL(var_2_3)
	end

	self.m_enterTransition:setTimeScale(arg_2_1.timeScale or 1)
	self.m_enterTransition:play()
	self.m_enterTransition:setHook("stop", handler(self, self.onDelete))
	self.m_effUnite:addEffectSpine({
		anim = "play",
		scale = 1,
		isLoop = false,
		name = var_2_1
	}):getBaseSpine():setTimeScale(arg_2_1.timeScale or 1)
	self.m_effUniteBg:addEffectSpine({
		anim = "play",
		scale = 1,
		isLoop = false,
		name = var_2_2
	}):getBaseSpine():setTimeScale(arg_2_1.timeScale or 1)
end

function BattleUniteEntranceComp:onDelete()
	if self._callback then
		self._callback()

		self._callback = nil
	end

	if not tolua.isnull(self) then
		self:removeFromParent()
	end
end

function BattleUniteEntranceComp:setIcon(arg_4_1, arg_4_2)
	self:setIconByPath(var_0_2:getKnightIconById(arg_4_1), arg_4_2)
end

function BattleUniteEntranceComp:setIconByPath(arg_5_1, arg_5_2)
	self.m_knightLoader:setURL(arg_5_1, arg_5_2)
end

return BattleUniteEntranceComp
