local CommonKnight = require("app.view.common.CommonKnight")
local BattleConst = require("app.view.battle.const.BattleConst")
local ElderBossRoleComp = class("ElderBossRoleComp", require("app.fairyGUI.elderBoss.UI_ElderBossRoleComp"))

function ElderBossRoleComp:updateRoleComp(arg_1_1)
	if arg_1_1 then
		local var_1_0 = g.core.model.User.snapShotCacheData:getSnapShot(g.core.const.ConstMgr.SnapShotCacheConst.SNAP_SHOT_KEY.USER, arg_1_1)

		if var_1_0 then
			self._userSnap = var_1_0

			local var_1_1, var_1_2 = g.core.common.GlobalFunc.checkAndGetRobotData(var_1_0)
			local var_1_3 = not var_1_1 and g.core.common.GlobalFunc.getRoleSkinParamsBySnapShot(self._userSnap) or {
				snapshot = var_1_0
			}

			var_1_3.showMainRole = true

			if not self._player then
				self._player = CommonKnight.new(var_1_3)

				self.m_placeHolderComp:removeChildren()
				self.m_placeHolderComp:addChild(self._player)
				self:_updateRoleMoveAction(self._player)
			end

			self.m_emptyPosController:setSelectedIndex(0)
		end
	else
		self._player = nil

		self.m_placeHolderComp:removeChildren()
		self.m_emptyPosController:setSelectedIndex(1)
	end
end

function ElderBossRoleComp:setEmpty()
	self._player = nil

	self.m_placeHolderComp:removeChildren()
	self.m_emptyPosController:setSelectedIndex(1)
end

function ElderBossRoleComp:playAttack()
	if self._player then
		self._player:playAction(BattleConst.SPINE_ACTION_TYPE.ATTACK)
	end
end

function ElderBossRoleComp:_updateRoleMoveAction(arg_4_1)
	local var_4_0 = 1

	if math.random(1, 4) % 2 == 0 then
		var_4_0 = -1
	end

	arg_4_1:playAction(BattleConst.SPINE_ACTION_TYPE.IDLE)
	arg_4_1:setScaleX(var_4_0)
	arg_4_1:runFGAction(fgui.FRepeatForever:create(fgui.FSequence:create({
		fgui.FDelayTime:create(math.random(3, 5)),
		fgui.FCallFunc:create(function()
			arg_4_1:playAction(BattleConst.SPINE_ACTION_TYPE.RUN)
			self.m_footBg:setVisible(false)
			arg_4_1:setScaleX(var_4_0)
		end),
		fgui.FMoveBy:create(0.8, cc.p(var_4_0 * 100, 0)),
		fgui.FCallFunc:create(function()
			arg_4_1:playAction(BattleConst.SPINE_ACTION_TYPE.IDLE)
		end),
		fgui.FDelayTime:create(math.random(3, 5)),
		fgui.FCallFunc:create(function()
			arg_4_1:playAction(BattleConst.SPINE_ACTION_TYPE.RUN)
			arg_4_1:setScaleX(-var_4_0)
		end),
		fgui.FMoveBy:create(0.8, cc.p(var_4_0 * -100, 0)),
		fgui.FCallFunc:create(function()
			self.m_footBg:setVisible(true)
			arg_4_1:playAction(BattleConst.SPINE_ACTION_TYPE.IDLE)
			arg_4_1:setScaleX(-var_4_0)
		end)
	})))
end

return ElderBossRoleComp
