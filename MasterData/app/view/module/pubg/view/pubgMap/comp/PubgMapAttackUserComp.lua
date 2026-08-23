local var_0_0 = g.core.model.User.pubgData
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.const.ConstMgr.PubgConst
local PubgMapAttackUserComp = class("PubgMapAttackUserComp", require("app.fairyGUI.pubg.UI_PubgMapAttackUserComp"))

function PubgMapAttackUserComp:ctor()
	self._data = nil
	self._floorComp = nil

	self:addClickListener(handler(self, self.onClick))
end

function PubgMapAttackUserComp:onClick()
	local var_2_0 = var_0_0:getMapData()

	if not var_2_0:checkInMapTime() then
		return
	end

	local var_2_1 = var_2_0:getMyUser()

	if var_2_1:isDead() then
		return
	end

	if var_2_1:getAttackCd() > 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(430931))

		return
	end

	if self._data and not self._data:isInvincible() then
		if self._data.isDead and self._data:isDead() then
			return
		end

		g.core.network.GameNetProxy:send_C2S_Pubg_Challenge({
			tp = self._data:getType() == var_0_2.map.itemType.knight and 2 or 1,
			id = self._data:getUid()
		})
		var_2_0:getMyUser():startAttack()
	end
end

function PubgMapAttackUserComp:setData(arg_3_1)
	if self._data and self._data:getUid() == arg_3_1:getUid() then
		return
	end

	self._data = arg_3_1

	self.m_userName:setText(self._data:getName())

	if self._data:getType() == var_0_2.map.itemType.knight then
		self:updateWithUser(self._data)
	elseif self._data:getType() == var_0_2.map.itemType.monster then
		self:updateWithMonster(self._data)
	end
end

function PubgMapAttackUserComp:refreshComp()
	if self._data then
		self.m_userName:setText(self._data:getName())

		if self._data:getType() == var_0_2.map.itemType.knight then
			self:updateWithUser(self._data)
		elseif self._data:getType() == var_0_2.map.itemType.monster then
			self:updateWithMonster(self._data)
		end
	end
end

function PubgMapAttackUserComp:updateWithUser(arg_5_1)
	self.m_userIcon:getChild("icon"):updateAsUser(arg_5_1:getSnapShot())
	self.m_fightValue:setText(arg_5_1:getFightValue())
end

function PubgMapAttackUserComp:updateWithMonster(arg_6_1)
	self.m_userIcon:getChild("icon"):justSetIcon(var_0_1:getRoleHeadIcon(g.core.config.knight_base_info.get(arg_6_1:getMonsterCfg().knight_base).icon_id))
	self.m_fightValue:setText(arg_6_1:getMonsterCfg().power)
end

return PubgMapAttackUserComp
