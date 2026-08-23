local var_0_0 = g.core.model.User.wushData
local WushMainBgComp = class("WushMainBgComp", require("app.fairyGUI.wush.UI_WushMainBgComp"))

function WushMainBgComp:ctor()
	self:addMovie(self.m_curBg, 1)
end

function WushMainBgComp:addMovie(arg_2_1, arg_2_2)
	arg_2_1:removeAllCriSprite()
	arg_2_1:addCriSprite({
		x = 0,
		moduleName = "wush",
		isLoop = true,
		y = 0,
		fullScreenState = 2,
		movieName = "shenruheiyuan0" .. arg_2_2 .. "_1334x750_2000"
	})
end

function WushMainBgComp:removeMovie(arg_3_1)
	arg_3_1:removeAllCriSprite()
end

function WushMainBgComp:goToNextFloorTrainstion(arg_4_1)
	local var_4_0 = var_0_0:getCurFloorId()
	local var_4_1 = g.core.config.dead_battle_floor_info.get(var_4_0)

	if var_4_0 > 1 then
		local var_4_2 = g.core.config.dead_battle_floor_info.get(var_4_0 - 1)

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

function WushMainBgComp:playInTransition()
	self:removeMovie(self.m_preBg)
	self:removeMovie(self.m_preDimBg)
	self:removeMovie(self.m_curDimBg)
	self:addMovie(self.m_curBg, g.core.config.dead_battle_floor_info.get((var_0_0:getCurFloorId())).background)
end

function WushMainBgComp:onUnload()
	self.m_curBg:removeAllCriSprite()
	self.m_preBg:removeAllCriSprite()
	self.m_curDimBg:removeAllCriSprite()
	self.m_preDimBg:removeAllCriSprite()
end

return WushMainBgComp
