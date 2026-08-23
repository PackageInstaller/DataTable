local var_0_0 = g.core.model.User.pubgData
local var_0_1 = g.core.const.ConstMgr.PubgConst
local var_0_2 = g.core.const.ConstMgr.PubgConst.map
local PubgMapInfoComp = class("PubgMapInfoComp", require("app.fairyGUI.pubg.UI_PubgMapInfoComp"))
local var_0_4 = {
	g.core.const.ConstMgr.PubgConst.map.BUFF_TYPE.MOVE_SPEED,
	g.core.const.ConstMgr.PubgConst.map.BUFF_TYPE.ATTACK_RANGE,
	g.core.const.ConstMgr.PubgConst.map.BUFF_TYPE.REVIVE
}
local var_0_5 = 3

function PubgMapInfoComp:ctor()
	self._myUser = nil
	self._tpCompDict = {}

	self.m_buff1:setBuffTp(var_0_2.BUFF_TYPE.MOVE_SPEED)

	self._tpCompDict[var_0_2.BUFF_TYPE.MOVE_SPEED] = self.m_buff1

	self.m_buff2:setBuffTp(var_0_2.BUFF_TYPE.ATTACK_RANGE)

	self._tpCompDict[var_0_2.BUFF_TYPE.ATTACK_RANGE] = self.m_buff2

	self.m_buff3:setBuffTp(var_0_2.BUFF_TYPE.REVIVE)

	self._tpCompDict[var_0_2.BUFF_TYPE.REVIVE] = self.m_buff3

	for iter_1_0, iter_1_1 in ipairs(var_0_4) do
		self._tpCompDict[iter_1_1] = self["m_buff" .. iter_1_0]

		self["m_buff" .. iter_1_0]:setBuffTp(iter_1_1)
		self["m_buff" .. iter_1_0]:addClickListener(function()
			self:showDescComp(iter_1_1)
		end)
	end

	for iter_1_2 = 1, var_0_5 do
		local var_1_0 = self["m_airDropBuff" .. iter_1_2]

		self["m_airDropBuff" .. iter_1_2]:addClickListener(function()
			self:showAirDescComp(var_1_0:getBuffAirData())
		end)
	end

	self.m_hpComp:initStar({
		index = 13,
		num = 0,
		style = 2,
		gap = 5,
		max = var_0_0:getParams(var_0_1.Params.INIT_HP)
	})

	self._lastHp = 0
end

function PubgMapInfoComp:onTouchEnd(arg_4_1)
	local var_4_0 = arg_4_1:getInput():getTouch()

	if not var_4_0 then
		return
	end

	if not self.m_descComp:hitTest(var_4_0:getLocation(), cc.Camera:create()) then
		self.m_showDescCompController:setSelectedIndex(0)
	end
end

function PubgMapInfoComp:updateInfoComp()
	self._myUser = self._myUser or var_0_0:getMapData():getMyUser()

	self.m_userIcon:updateAsSelf()
	self.m_hpComp:setStarNum(self._myUser:getHp())

	self._lastHp = self._myUser:getHp()

	self.m_levelTxt:setText(g.core.lang:get(2052, {
		level = self._myUser:getLevel()
	}))
	self.m_levelProgressBar:setValue(self._myUser:getLevelProgress())
	self.m_buff1:updateBuffIcon()
	self.m_buff2:updateBuffIcon()
	self.m_buff3:updateBuffIcon()
	self:updateAirDropBuff()
end

function PubgMapInfoComp:updateBuff(arg_6_1, arg_6_2)
	if self._tpCompDict[arg_6_1] == nil then
		return
	end

	self._tpCompDict[arg_6_1]:updateBuffIcon(arg_6_2)
end

function PubgMapInfoComp:updateAirDropBuff()
	local var_7_0 = table.values(self._myUser:getAirBuffs())

	table.sort(var_7_0, function(arg_8_0, arg_8_1)
		return arg_8_0.airBuffData.time < arg_8_1.airBuffData.time
	end)

	for iter_7_0 = 1, var_0_5 do
		if var_7_0[iter_7_0] then
			self["m_airDropBuff" .. iter_7_0]:updateAirBuffData(var_7_0[iter_7_0].airBuffData)
			self["m_airDropBuff" .. iter_7_0]:setVisible(true)
		else
			self["m_airDropBuff" .. iter_7_0]:setVisible(false)
		end
	end
end

function PubgMapInfoComp:updateLevel()
	self.m_levelTxt:setText(g.core.lang:get(2052, {
		level = self._myUser:getLevel()
	}))
	self:updateExp()
end

function PubgMapInfoComp:updateExp()
	self.m_levelProgressBar:tweenValue(self._myUser:getLevelProgress(), 0.1)
end

function PubgMapInfoComp:updateHp()
	local var_11_0 = self._myUser:getHp()

	self.m_hpComp:setStarNum(var_11_0)

	if self._lastHp ~= var_11_0 then
		if var_11_0 < self._lastHp then
			self.m_hpComp:addEffectToStars(var_11_0 + 1, self._lastHp, {
				isLoop = false,
				remove = true,
				anim = "play_off",
				name = "eff_ui_pubg_life"
			}, nil, true)
		elseif var_11_0 > self._lastHp then
			self.m_hpComp:addEffectToStars(self._lastHp + 1, var_11_0, {
				isLoop = false,
				remove = true,
				anim = "play_on",
				name = "eff_ui_pubg_life"
			}, nil, true)
		end

		self._lastHp = var_11_0
	end
end

function PubgMapInfoComp:showAirDescComp(arg_12_1)
	self.m_showDescCompController:setSelectedIndex(1)
	self.m_descComp:updateAirBuffDescComp(arg_12_1)
end

function PubgMapInfoComp:showDescComp(arg_13_1)
	self.m_showDescCompController:setSelectedIndex(1)
	self.m_descComp:updateDescComp(arg_13_1)
end

return PubgMapInfoComp
