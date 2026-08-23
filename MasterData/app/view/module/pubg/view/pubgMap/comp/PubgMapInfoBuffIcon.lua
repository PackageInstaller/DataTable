local var_0_0 = g.core.common.Path
local var_0_1 = g.core.model.User.pubgData
local PubgMapInfoBuffIcon = class("PubgMapInfoBuffIcon", require("app.fairyGUI.pubg.UI_PubgMapInfoBuffIcon"))

function PubgMapInfoBuffIcon:ctor()
	self._buffTp = 0
end

function PubgMapInfoBuffIcon:setBuffTp(arg_2_1)
	self._buffTp = arg_2_1
end

function PubgMapInfoBuffIcon:setBuffIcon(arg_3_1)
	self.m_buffLoader:setURL(var_0_0:getPubgBuff(arg_3_1.icon))
end

function PubgMapInfoBuffIcon:updateBuffIcon(arg_4_1)
	if self._buffTp <= 0 then
		self:setVisible(false)

		return
	end

	local var_4_0 = var_0_1:getMapData()
	local var_4_1 = var_4_0:getMyUser():getBuff(self._buffTp)
	local var_4_2 = ((not var_4_0 or nil) and {}).level or 0

	self:setGrayed(var_4_2 <= 0)

	local var_4_3 = var_0_1:getMapData():getBuffInfo(self._buffTp, var_4_2 <= 0 and 1 or var_4_2)

	if var_4_3 then
		self.m_buffLoader:setURL(var_0_0:getPubgBuff(var_4_3.icon))
	end

	self.m_numTxt:setText(var_4_2)

	if arg_4_1 then
		self.m_eff:addEffectSpine({
			anim = "play",
			name = "eff_ui_pubg_infoBuffYellow",
			remove = true,
			isLoop = false
		})
	end
end

return PubgMapInfoBuffIcon
