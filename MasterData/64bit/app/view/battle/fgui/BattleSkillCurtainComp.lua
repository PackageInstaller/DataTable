local var_0_0 = g.core.common.Path
local BattleConst = require("app.view.battle.const.BattleConst")
local DrawKnight = require("app.view.common.DrawKnight")
local BattleSkillCurtainComp = class("BattleSkillCurtainComp", require("app.fairyGUI.battle.UI_BattleSkillCurtainComp"))

function BattleSkillCurtainComp:ctor()
	self:setSize(display.width, display.height)
end

function BattleSkillCurtainComp:updateView(arg_2_1)
	arg_2_1 = arg_2_1 or {}
	self._callback = arg_2_1.callback

	local var_2_0 = arg_2_1.actor
	local var_2_1 = arg_2_1.skillName or ""

	self.m_skillNameText1:setText(var_2_1 or "")

	local var_2_2 = var_2_0:getSkin()

	self.m_weaponSkilllNameText1:setText(var_2_1 or "")

	if arg_2_1.knightInfo and arg_2_1.knightInfo.id then
		local var_2_3 = arg_2_1.isMonster and g.core.config.monster_info.get(arg_2_1.knightInfo.id).res_id or g.core.config.knight_info.get(arg_2_1.knightInfo.id).res_id

		self.m_knightPicComp:updateKnight({
			useMidKnight = true,
			resId = var_2_2 ~= 0 and var_2_2 or var_2_3
		})
		self.m_knightPicComp:setAlphaLRDistance(300)
		self.m_knightPicComp:setScale(0.8)
		self.m_knightPicComp:setImageColor(cc.BLACK)

		if arg_2_1.isMonster then
			self.m_elementalController:setSelectedIndex(0)
		else
			self.m_elementalController:setSelectedIndex(arg_2_1.knightInfo.classical)
		end
	else
		self.m_elementalController:setSelectedIndex(0)
	end

	self.m_sideTypeController:setSelectedIndex(arg_2_1.identity - 1)

	local var_2_4 = var_2_0:getArtifactId()

	if var_2_4 and var_2_4 ~= 0 and g.core.model.User.artifactData:isRelatedByIdAndKnightAdvId(var_2_4, (var_2_0:getKnightAdvanceId())) then
		self.m_enterBTransition:setHook("end", handler(self, self.onDelete))
		self.m_weaponController:setSelectedIndex(1)
		self.m_effRoleSkill:addEffectSpine({
			name = "eff_ui_battle_ArtifactSkill"
		})
		self.m_effBG:addEffectSpine({
			anim = "play2",
			name = "eff_ui_battle_roleSkillBG"
		})
		self.m_effBG:addEffectSpine({
			name = "eff_ui_battle_roleSkillBG"
		})
		self.m_effLightingup:addEffectSpine({
			isLoop = false,
			name = "eff_ui_battle_lightingup"
		})
		self.m_effLightingdown:addEffectSpine({
			isLoop = false,
			name = "eff_ui_battle_lightingdown"
		})
		self.m_effArmsDi:addEffectSpine({
			name = "eff_ui_battle_armsDi"
		})
		self.m_artifactComp:setIcon((var_0_0:getArtifactImg(g.core.config.artifact_info.get(var_2_4).res_id)))
		self.m_enterBTransition:play()
		self.m_enterBTransition:setTimeScale(arg_2_1.timeScale or 1)
	else
		self.m_weaponController:setSelectedIndex(0)
		self.m_enterTransition:setHook("end", handler(self, self.onDelete))
		self.m_effRoleSkill:addEffectSpine({
			name = "eff_ui_battle_roleSkill"
		})
		self.m_effBG:addEffectSpine({
			name = "eff_ui_battle_roleSkillBG"
		})
		self.m_enterTransition:play()
		self.m_enterTransition:setTimeScale(arg_2_1.timeScale or 1)
	end
end

function BattleSkillCurtainComp:onDelete()
	if self._callback then
		self._callback()
	end

	self:removeFromParent()
end

function BattleSkillCurtainComp:setIcon(arg_4_1, arg_4_2)
	self:setIconByPath(var_0_0:getKnightIconById(arg_4_1), arg_4_2)
end

function BattleSkillCurtainComp:setIconByPath(arg_5_1, arg_5_2)
	self.m_knightLoader:setURL(arg_5_1, arg_5_2)
end

function BattleSkillCurtainComp:onLoad()
	return
end

function BattleSkillCurtainComp:onUnload()
	return
end

return BattleSkillCurtainComp
