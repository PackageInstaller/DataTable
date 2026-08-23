local BattleConst = require("app.view.battle.const.BattleConst")
local BattleVSLayer = class("BattleVSLayer", require("app.fairyGUI.battle.UI_BattleVSLayer"), function()
	return fgui.GComponent:create({
		isFullScreen = true,
		pkgPath = "ui/battle/battle",
		resName = "BattleVSLayer",
		pkgName = "battle"
	})
end)

function BattleVSLayer:ctor(arg_2_1, arg_2_2)
	self._battleLayer = arg_2_1
	self._endCallback = arg_2_2
	self.m_lUserInfoComp, self.m_rUserInfoComp = nil

	self:_initView()
end

function BattleVSLayer:onLoad()
	self:_updateView()
	self:play()
end

function BattleVSLayer:_initView()
	self.m_lUserInfoCompDad:removeChildren()
	self.m_rUserInfoCompDad:removeChildren()

	if g.core.battle.BattleProxy:getType() == BattleConst.TYPE_PEAK_ARENA_PVP then
		self.m_lUserInfoComp = fgui.UIPackage:createObject("battle", "BattleVSPeakArenaLeftUserInfoComp")
		self.m_rUserInfoComp = fgui.UIPackage:createObject("battle", "BattleVSPeakArenaRightUserInfoComp")
	else
		self.m_lUserInfoComp = fgui.UIPackage:createObject("battle", "BattleVSUserInfoComp")
		self.m_rUserInfoComp = fgui.UIPackage:createObject("battle", "BattleVSUserInfoComp")
	end

	self.m_lUserInfoCompDad:addChild(self.m_lUserInfoComp)
	self.m_rUserInfoCompDad:addChild(self.m_rUserInfoComp)
end

function BattleVSLayer:_updateView()
	local var_5_0 = self:_getUserInfo(BattleConst.IDENTITY.MYSELF)
	local var_5_1 = self:_getUserInfo(BattleConst.IDENTITY.ENEMY)

	self.m_leftKnightComp:updateKnight(var_5_0)
	self.m_rightKnightComp:updateKnight(var_5_1)
	self.m_lUserInfoComp:updateComp(true, var_5_0)
	self.m_rUserInfoComp:updateComp(false, var_5_1)
	self.m_firstFightController:setSelectedIndex((self:_getFirstFightCtrlIdx(var_5_0.fight_num, var_5_1.fight_num)))
end

function BattleVSLayer:_getUserInfo(arg_6_1)
	local var_6_0 = self._battleLayer:getTeamInfoWithIndex(arg_6_1, 1)
	local var_6_1 = g.core.utils.Number.transFightValue(var_6_0.fight_value)

	if var_6_0.user then
		return {
			name = g.core.utils.String.transRobotName({
				checkStr = true,
				name = var_6_0.user.name
			}),
			serverName = var_6_0.user.server_name,
			rank = var_6_0.user.rank,
			score = var_6_0.user.param,
			fightValue = var_6_1,
			fight_num = var_6_0.fight_value,
			snapshot = var_6_0.user
		}
	else
		local var_6_2 = self:_getMainActor(arg_6_1)
		local var_6_3 = var_6_2:getName()
		local var_6_4

		if var_6_0.monster_team_id then
			var_6_3 = self:_getMonsterNameByTeamId(var_6_0.monster_team_id)
			var_6_4 = {
				score = 0,
				rank = 0,
				serverName = ""
			}
		end

		var_6_4.name = g.core.utils.String.transRobotName({
			checkStr = true,
			name = var_6_3
		})
		var_6_4.fightValue = var_6_1
		var_6_4.fight_num = var_6_0.fight_value
		var_6_4.resId = var_6_2:getOrgResId()

		return var_6_4
	end
end

function BattleVSLayer:_getMonsterNameByTeamId(arg_7_1)
	for iter_7_0 = 1, g.core.config.robot_info.getLength() do
		local var_7_0 = g.core.config.robot_info.indexOf(iter_7_0)

		if var_7_0 and var_7_0.monster_team_id == arg_7_1 then
			return var_7_0.name
		end
	end
end

function BattleVSLayer:_getMainActor(arg_8_1)
	local var_8_0 = self._battleLayer:getActors(arg_8_1)

	for iter_8_0 = 1, 6 do
		if var_8_0[iter_8_0] then
			local var_8_1 = var_8_0[iter_8_0]:getOrgKnightInfo().toObject()

			if var_8_1.type then
				if var_8_1.type == 1 then
					return var_8_0[iter_8_0]
				end
			elseif g.core.config.knight_info.get(var_8_1.advance_id).type == 1 then
				return var_8_0[iter_8_0]
			end
		end
	end

	return var_8_0[1]
end

function BattleVSLayer:_getFirstFightCtrlIdx(arg_9_1, arg_9_2)
	local var_9_0 = g.core.battle.BattleProxy:getType()

	if var_9_0 == BattleConst.TYPE_GUILDFIGHT_PVP or var_9_0 == BattleConst.TYPE_GUILDFIGHT_BOSS_PVP then
		return BattleConst.FIRST_CONTROL.NONE
	elseif arg_9_1 < arg_9_2 then
		return BattleConst.FIRST_CONTROL.RIGHT
	else
		return BattleConst.FIRST_CONTROL.LEFT
	end
end

function BattleVSLayer:play()
	self.m_effBg:addEffectSpine({
		name = "eff_ui_battle_arenaBg",
		isLoop = false,
		remove = true
	})
	self.m_enterTransition:setHook("play", handler(self, self._playFirstAttackEff))
	self.m_enterTransition:play(handler(self, function()
		if self._endCallback then
			self._endCallback()
		end
	end))
	self.m_effVS:addEffectSpine({
		name = "eff_ui_battle_arenaVS",
		remove = true,
		isLoop = false
	})
end

function BattleVSLayer:_playFirstAttackEff()
	if self.m_firstFightController:getSelectedIndex() == BattleConst.FIRST_CONTROL.RIGHT then
		-- block empty
	end

	self.m_effLineRight:addEffectSpine({
		name = "eff_ui_battle_arenaLine",
		remove = true,
		isLoop = false
	})
end

return BattleVSLayer
