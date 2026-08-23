local var_0_0 = g.core.const.ConstMgr.TeamPvpConst
local var_0_1 = g.core.model.User.teamPvpData
local TeamPvpTowerComp = class("TeamPvpTowerComp", require("app.fairyGUI.teamPVP.UI_TeamPvpTowerComp"))

function TeamPvpTowerComp:ctor()
	self._hpNumber = var_0_0.MAX_HP
	self._isDestroy = false
	self._camp = 0
	self._index = 0
	self._towerType = var_0_0.EXTRAID
end

function TeamPvpTowerComp:_addBuildEffect()
	local var_2_0 = var_0_1:getMapId()
	local var_2_1 = self._camp == 0 and "_red" or "_blue"
	local var_2_2

	if var_2_0 == var_0_0.MAP_TYPE.DESERT then
		var_2_2 = "map_3_" .. self._index or "map_" .. var_2_0

		if var_2_0 == var_0_0.MAP_TYPE.DESERT and self._towerType == var_0_0.EXTRAID then
			var_2_2 = "map_3_2"
		end
	end

	for iter_2_0 = 1, var_0_0.MAX_TOWER do
		local var_2_3 = display.newSprite("bg/teamPVP/build/" .. var_2_2 .. var_2_1 .. ".png")

		var_2_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_2_3:setScaleX(self._camp == 0 and 1 or -1)

		local var_2_4 = self:getChild("buildPos" .. iter_2_0)

		if var_2_4 then
			var_2_4:removeAllEffect()

			self["_buildSpine" .. iter_2_0] = var_2_4:addEffectSpine({
				isLoop = true,
				name = "eff_ui_teamPvp_build",
				anim = "idle"
			})

			self["_buildSpine" .. iter_2_0]:getNodeForSlot("slot"):addChild(var_2_3)
		end
	end
end

function TeamPvpTowerComp:updateTower(arg_3_1)
	local var_3_0, var_3_1

	if arg_3_1 then
		var_3_0 = arg_3_1.max or 1

		if arg_3_1 then
			var_3_1 = arg_3_1.curhp or 1
		end
	end

	self._hpNumber = var_3_1

	if arg_3_1 then
		self._camp = arg_3_1.camp or 0
	end

	if arg_3_1 then
		self._towerType = arg_3_1.type or var_0_0.EXTRAID
	end

	if arg_3_1 then
		self._index = arg_3_1.index or 1
	end

	self.m_hpBar:setValue(math.max(0, self._hpNumber))
	self.m_hpBar:setMax(var_3_0)
	self:_addBuildEffect()
end

function TeamPvpTowerComp:getCamp()
	return self._camp
end

function TeamPvpTowerComp:beAttack(arg_5_1)
	self._hpNumber = self._hpNumber - 1

	self.m_hpBar:setValue(math.max(0, self._hpNumber))

	if self._hpNumber < 1 and not self._isDestroy then
		self:destroyTower()

		if arg_5_1 then
			arg_5_1()
		end
	end
end

function TeamPvpTowerComp:destroyTower()
	self._isDestroy = true

	self:dispatchCompEvent("CHECK_TOWER_STATE")

	local var_6_0 = var_0_1:getMapId()

	if var_6_0 == var_0_0.MAP_TYPE.SNOW or var_6_0 == var_0_0.MAP_TYPE.SEA or var_6_0 == var_0_0.MAP_TYPE.FIVE then
		self:dispatchCompEvent("UPDATE_SCORE_BOARD", {
			isEnemy = self._camp == 1
		})
	end

	self:playBoomEffect()
end

function TeamPvpTowerComp:isDestroy()
	return self._isDestroy
end

function TeamPvpTowerComp:getRestHp()
	return self._hpNumber
end

function TeamPvpTowerComp:playBoomEffect()
	for iter_9_0 = 1, var_0_0.MAX_TOWER do
		if self["_buildSpine" .. iter_9_0] then
			self["_buildSpine" .. iter_9_0]:setAnimation(0, "hit", false)
		end
	end

	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_CRYSTALCOLLAPSE)
end

return TeamPvpTowerComp
