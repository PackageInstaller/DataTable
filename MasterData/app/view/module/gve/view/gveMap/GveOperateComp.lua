local var_0_0 = g.core.const.ConstMgr.GveConst
local var_0_1 = g.core.model.User.gveDataMgr
local GveCommon = require("app.view.module.gve.common.GveCommon")
local GveOperateComp = class("GveOperateComp", require("app.fairyGUI.gve.UI_GveOperateComp"))

function GveOperateComp:ctor()
	self:addListen(self.m_ctrlComp)
	self:addListen(self.m_bossComp)
end

function GveOperateComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GVE_GRID_WARN, handler(self, self._onWarnGridPoints), self)
end

function GveOperateComp:updateCtrlComp(arg_3_1)
	if arg_3_1 then
		local var_3_0 = var_0_1:getGveData()

		if not var_3_0:isCurSiteCanClick(arg_3_1.x, arg_3_1.y) or var_3_0:isCurPosInFogCloud(arg_3_1) then
			return
		end

		if var_3_0:isPosHasBoss(arg_3_1.x, arg_3_1.y) then
			local var_3_1, var_3_2 = var_3_0:getPosNowBossCfg(arg_3_1.x, arg_3_1.y)

			if var_3_2 and var_3_2.boss_type == var_0_0.GVE_BOSS_TYPE.NORMAL then
				self.m_ctrlComp:setVisible(true)

				local var_3_3, var_3_4 = self:getOpeCompShowPos(var_3_2.x, var_3_2.y, var_3_2.range)

				self.m_ctrlComp:setPosition(var_3_3, var_3_4)
				self.m_ctrlComp:updateByPos(arg_3_1)
			end

			return
		end

		if not self:checkPosIsOperateAble(arg_3_1) then
			g.core.module.ModuleManager:tip(g.core.lang:get(309001))
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GVE_GRID_WARN, false, {
				points = {
					arg_3_1
				}
			})
			self.m_ctrlComp:setVisible(false)

			return
		end

		local var_3_5 = var_3_0:getBuildDataByPos(arg_3_1)
		local var_3_6, var_3_7 = self:getOpeCompShowPos(var_3_5.cfg.x, var_3_5.cfg.y, var_3_0:getBaseCfgByPos(arg_3_1).base_type)

		self.m_ctrlComp:setVisible(true)
		self.m_ctrlComp:setPosition(var_3_6, var_3_7)
		self.m_ctrlComp:updateByPos(arg_3_1)
	else
		self.m_ctrlComp:setVisible(false)
	end

	self.m_bossComp:setVisible(false)
end

function GveOperateComp:updateAliveBoss(arg_4_1, arg_4_2, arg_4_3)
	self:updateBoss(arg_4_1, arg_4_2, arg_4_3, false)
end

function GveOperateComp:updateBoss(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if var_0_1:getGveData():isCurPosInFogCloud({
		x = arg_5_1,
		y = arg_5_2
	}) then
		return
	end

	self._isDead = arg_5_4

	self.m_ctrlComp:setVisible(false)
	self.m_bossComp:setVisible(true)
	self.m_bossComp:updateBoss(arg_5_3, arg_5_4)

	local var_5_0, var_5_1 = self:getOpeCompShowPos(arg_5_3.x, arg_5_3.y, arg_5_3.range)

	self.m_bossComp:setPosition(var_5_0, var_5_1)
end

function GveOperateComp:updateDeadBoss(arg_6_1, arg_6_2, arg_6_3)
	self:updateBoss(arg_6_1, arg_6_2, arg_6_3, true)
end

function GveOperateComp:getOpeCompShowPos(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0, var_7_1 = GveCommon.coordToCompPos(arg_7_1, arg_7_2)

	if arg_7_3 == 1 then
		return var_7_0, var_7_1
	elseif arg_7_3 == 2 then
		local var_7_2, var_7_3 = GveCommon.coordToCompPos(arg_7_1, arg_7_2 + 1)

		return (var_7_0 + var_7_2) / 2, (var_7_1 + var_7_3) / 2
	elseif arg_7_3 == 3 then
		local var_7_4, var_7_5 = GveCommon.coordToCompPos(arg_7_1 + 1, arg_7_2)

		return (var_7_0 + var_7_4) / 2, (var_7_1 + var_7_5) / 2
	elseif arg_7_3 == 4 then
		local var_7_6, var_7_7 = GveCommon.coordToCompPos(arg_7_1 + 1, arg_7_2 + 1)

		return (var_7_0 + var_7_6) / 2, (var_7_1 + var_7_7) / 2
	elseif arg_7_3 == 5 then
		local var_7_8, var_7_9 = GveCommon.coordToCompPos(arg_7_1 + 2, arg_7_2 + 2)

		return (var_7_0 + var_7_8) / 2, (var_7_1 + var_7_9) / 2
	end
end

function GveOperateComp:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "Stage_ctrl_ope_finish" then
		self.m_ctrlComp:setVisible(false)
		self.m_bossComp:setVisible(false)
	end
end

function GveOperateComp:checkPosIsOperateAble(arg_9_1)
	return var_0_1:getGveData():getBuildDataByPos(arg_9_1)
end

function GveOperateComp:_onWarnGridPoints(arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3.points and arg_10_3.points[1] then
		for iter_10_0, iter_10_1 in ipairs(arg_10_3.points) do
			local var_10_0, var_10_1 = GveCommon.coordToCompPos(iter_10_1.x, iter_10_1.y)

			self:addEffectSpine({
				anim = "play",
				name = "eff_ui_gve_warn",
				isLoop = false,
				remove = true,
				x = var_10_0,
				y = display.height - var_10_1
			})
		end
	end
end

return GveOperateComp
