local var_0_0 = g.core.model.User.wushTowerData
local var_0_1 = g.core.config.dead_tower_zone_info
local WushTowerMainBgComp = class("WushTowerMainBgComp", require("app.fairyGUI.wushTower.UI_WushTowerMainBgComp"))

function WushTowerMainBgComp:ctor()
	self._floorId = 1

	self:addMovie(self.m_curBg, 1)
end

function WushTowerMainBgComp:addMovie(arg_2_1, arg_2_2)
	arg_2_1:removeAllCriSprite()
	arg_2_1:addCriSprite({
		fullScreenState = 2,
		isLoop = true,
		y = 0,
		moduleName = "wush",
		x = 0,
		movieName = "shenruheiyuan0" .. arg_2_2 .. "_1334x750_2000"
	})
end

function WushTowerMainBgComp:removeMovie(arg_3_1)
	arg_3_1:removeAllCriSprite()
end

function WushTowerMainBgComp:goToNextFloorTrainstion(arg_4_1)
	local var_4_0 = var_0_0:getZoneId()
	local var_4_1 = var_0_1.get(var_4_0, self._floorId)

	if var_4_0 > 1 then
		local var_4_2 = var_0_1.get(var_4_0 - 1, self._floorId)

		self:addMovie(self.m_preBg, var_4_2.background)
		self:addMovie(self.m_preDimBg, var_4_2.background)
		self:addMovie(self.m_curBg, var_4_1.background)
		self:addMovie(self.m_curDimBg, var_4_1.background)
	else
		self:removeMovie(self.m_preBg)
		self:removeMovie(self.m_preDimBg)
		self:addMovie(self.m_curBg, var_4_1.background)
		self:addMovie(self.m_curDimBg, var_4_1.background)
	end

	self.m_enterTransition:play(function()
		if arg_4_1 then
			arg_4_1()
		end
	end)
end

function WushTowerMainBgComp:playInTransition()
	self:removeMovie(self.m_preBg)
	self:removeMovie(self.m_preDimBg)
	self:removeMovie(self.m_curDimBg)
	self:addMovie(self.m_curBg, var_0_1.get(var_0_0:getZoneId(), self._floorId).background)
end

function WushTowerMainBgComp:onUnload()
	self.m_curBg:removeAllCriSprite()
	self.m_preBg:removeAllCriSprite()
	self.m_curDimBg:removeAllCriSprite()
	self.m_preDimBg:removeAllCriSprite()
end

return WushTowerMainBgComp
