local GuildFightConst = require("app.view.module.guildFight.const.GuildFightConst")
local var_0_2 = g.core.model.User.GuildFightData
local DrawKnight = require("app.view.common.DrawKnight")
local BattleConst = require("app.view.battle.const.BattleConst")
local GuildFightPlayerComp = class("GuildFightPlayerComp", require("app.fairyGUI.guildFight.UI_GuildFightPlayerComp"))

function GuildFightPlayerComp:ctor(arg_1_1)
	self._originX = self.m_knightPic:getX()
	self._playerData = nil
	self._canTouch = false
	self._playerId = 0
	self._showType = 0
	self._battleIndex = 0
	self._scale = 1
	self._remainLeft = 0
	self._knightAni = nil
	self._attackCallBack = nil
	self._deadCallBack = nil
	self._winCallBack = nil
	self._hitCallBack = nil
end

function GuildFightPlayerComp:updatePlayer(arg_2_1)
	self._playerData = arg_2_1.data or {}
	self._battleIndex = arg_2_1.index or 0
	self._playerId = var_0_2:getPlayerIdByData(self._playerData)

	self:updateKnight(self._playerData.user)
	self:updateHpBar()
end

function GuildFightPlayerComp:setCompVisible(arg_3_1)
	self.m_isVisibleController:setSelectedIndex(arg_3_1 and 0 or 1)
end

function GuildFightPlayerComp:updateKnight(arg_4_1)
	if not arg_4_1 then
		return
	end

	if self._knightAni then
		self._knightAni:removeFromParent()

		self._knightAni = nil
	end

	if g.core.model.User.knightsData:getKnight({
		base_id = arg_4_1.base_id
	}) then
		local var_4_0 = g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot(arg_4_1)

		var_4_0.base = true
		var_4_0.breath = true
		var_4_0.listener = handler(self, self._onSpineEvent)

		local var_4_1 = require("app.view.battle.BattleKnight").new(var_4_0)

		self.m_knightPic:addNode(var_4_1)
		self.m_knightPic:setScale(-self._scale, self._scale)

		if self:_isSelf() and self._battleIndex < 1 then
			self.m_knightPic:setX(self._originX + 30)
			self.m_knightPic:setScale(self._scale, self._scale)
		else
			self.m_knightPic:setX(self._originX - 35)
			self.m_knightPic:setScale(-self._scale, self._scale)
		end

		local var_4_2 = g.core.utils.String.transRobotName(arg_4_1)

		if arg_4_1.robot_type and arg_4_1.robot_type ~= 0 then
			var_4_2 = var_4_2 .. g.core.lang:get(302042)
		end

		self.m_nameLabel:setText(var_4_2)
		self.m_powerLabel:setText((g.core.utils.Number.transTextNumFormationKBM(arg_4_1.fight_value)))

		self._knightAni = var_4_1
	end
end

function GuildFightPlayerComp:_isSelf()
	if g.core.model.User:getId() == self._playerData.user.id then
		return true
	end
end

function GuildFightPlayerComp:updateHpBar(arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1 and arg_6_1 or self._playerData.left

	self._remainLeft = arg_6_1 and arg_6_1 or self._playerData.left or 0

	if not arg_6_2 then
		self.m_hpBar:setPercent({
			max = 100,
			cur = var_6_0 or 0
		})
	end
end

function GuildFightPlayerComp:run()
	if self._knightAni then
		self._knightAni:setAnimation(0, "run", true)
	end
end

function GuildFightPlayerComp:show(arg_8_1)
	if self._knightAni then
		self._knightAni:setAnimation(0, "show", false)

		if arg_8_1 then
			self._winCallBack = arg_8_1
		end
	end
end

function GuildFightPlayerComp:idle()
	if self._knightAni then
		self._knightAni:setAnimation(0, "idle", true)
	end
end

function GuildFightPlayerComp:attack(arg_10_1)
	if self._knightAni then
		self._knightAni:setAnimation(0, "attack", false)

		if arg_10_1 then
			self._attackCallBack = arg_10_1
		end
	end
end

function GuildFightPlayerComp:doDead(arg_11_1)
	if self._knightAni then
		self._knightAni:setAnimation(0, "dead", false)

		if arg_11_1 then
			self._deadCallBack = arg_11_1
		end
	end
end

function GuildFightPlayerComp:doHit(arg_12_1)
	if self._knightAni then
		self._knightAni:setAnimation(0, "hit", false)

		if arg_12_1 then
			self._hitCallBack = arg_12_1
		end
	end
end

function GuildFightPlayerComp:_onSpineEvent(arg_13_1)
	if arg_13_1.type == BattleConst.SPINE_EVENT.COMPLETE then
		if arg_13_1.animation == BattleConst.SPINE_ACTION_TYPE.WIN and self._winCallBack then
			self._winCallBack()

			self._winCallBack = nil
		elseif arg_13_1.animation == BattleConst.SPINE_ACTION_TYPE.DEAD and self._deadCallBack then
			self._deadCallBack()

			self._deadCallBack = nil
		elseif arg_13_1.animation == BattleConst.SPINE_ACTION_TYPE.HIT and self._hitCallBack then
			self._hitCallBack()

			self._hitCallBack = nil
		elseif arg_13_1.animation == BattleConst.SPINE_ACTION_TYPE.ATTACK and self._attackCallBack then
			self._attackCallBack()

			self._attackCallBack = nil
		end
	end
end

function GuildFightPlayerComp:getCurLeft()
	return self._remainLeft
end

return GuildFightPlayerComp
