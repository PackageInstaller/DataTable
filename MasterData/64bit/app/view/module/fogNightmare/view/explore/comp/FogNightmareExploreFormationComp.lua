local var_0_0 = g.core.common.Path
local var_0_1 = g.core.const.ConstMgr.KNIGHT_CONST
local FogNightmareExploreFormationComp = class("FogNightmareExploreFormationComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreFormationComp"))

function FogNightmareExploreFormationComp:ctor()
	self._formationIndex = 0
	self._formationStruct = nil
	self._selectedComp = nil
	self._moveComp = {}
	self._movePos = nil
	self._moveCompKey = nil
	self._touchIndex = 0
	self._knightStrcut = nil

	self.m_haloBtn:addClickListener(handler(self, self._onHaloBtnClick))
end

function FogNightmareExploreFormationComp:updateComp(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	self._formationStruct = arg_2_1
	self._formationIndex = arg_2_2
	self._touchIndex = arg_2_4 or 0

	self:updateView()

	if arg_2_3 then
		self.m_enterTransition:play()
	end
end

function FogNightmareExploreFormationComp:_updateLineUpHaloCount(arg_3_1)
	local var_3_0 = arg_3_1.group or 0
	local var_3_1 = arg_3_1.count or 0
	local var_3_2 = self.m_haloBtn:getChild("lineUpHaloBar")
	local var_3_3 = math.clamp(var_3_1, 0, 6)

	var_3_2:setFillAmount(var_3_3 / 6)

	var_3_0 = var_3_0 > 0 and var_3_0 or var_0_1.GROUP_TYPE.LIN_DONG

	local var_3_4 = self.m_haloBtn:getChild("haloImg")
	local var_3_5 = var_0_0:getCampURL(var_3_0, 4)
	local var_3_6 = self.m_haloBtn:getChild("effectHolder")

	var_3_6:removeAllEffect()

	if var_3_3 >= 6 then
		var_3_6:addEffectSpine({
			scale = 1,
			anim = "play2",
			name = "eff_ui_formation_gain",
			isLoop = true
		})

		var_3_5 = var_3_0 == var_0_1.GROUP_TYPE.JIAO_GUO and "ui://fogNightmare/icon_bz_jiaoguo" or var_3_0 == var_0_1.GROUP_TYPE.LI_JIN and "ui://fogNightmare/icon_bz_lijin" or var_3_0 == var_0_1.GROUP_TYPE.DONG_XI and "ui://fogNightmare/icon_bz_dongxi" or "ui://fogNightmare/icon_bz_lindong"
	elseif var_3_3 >= 2 then
		var_3_6:addEffectSpine({
			scale = 1,
			anim = "play1",
			name = "eff_ui_formation_gain",
			isLoop = true
		})
	end

	var_3_4:setURL(var_3_5)
end

function FogNightmareExploreFormationComp:_onHaloBtnClick()
	local var_4_0 = self._formationStruct:getGroupHaloInfo()
	local var_4_1 = self._formationStruct:getKnightPosList()
	local var_4_2 = {}

	for iter_4_0 = 1, 6 do
		if var_4_1[iter_4_0] then
			var_4_2[#var_4_2 + 1] = var_4_1[iter_4_0]
		end
	end

	local var_4_3 = {}

	var_4_3.curCnt = var_4_0.count or 0
	var_4_3.group = var_4_0.group
	var_4_3.knights = var_4_2

	g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareLineUpHaloPop").new(var_4_3), {
		touchDisappear = true
	})
end

function FogNightmareExploreFormationComp:checkPosInComp(arg_5_1, arg_5_2, arg_5_3)
	for iter_5_0 = 1, var_0_1.LINEUP_MAX do
		if self["m_knight" .. iter_5_0] and self["m_knight" .. iter_5_0]:containPoint(arg_5_1) then
			if arg_5_3 then
				self["m_knight" .. iter_5_0]:setCompTouch(false)
			end

			local var_5_0, var_5_1 = self["m_knight" .. iter_5_0]:checkCompPos(arg_5_1)

			if arg_5_2 or self._formationStruct:getKnight(iter_5_0) then
				return iter_5_0, var_5_1, var_5_0
			else
				return 0
			end
		end
	end

	return 0
end

function FogNightmareExploreFormationComp:getKnightComp(arg_6_1)
	return self["m_knight" .. arg_6_1]
end

function FogNightmareExploreFormationComp:getArtifactPositionInComp(arg_7_1)
	return self["m_knight" .. arg_7_1]:getPosition()
end

function FogNightmareExploreFormationComp:updateView()
	if not self._formationStruct then
		return
	end

	for iter_8_0 = 1, var_0_1.LINEUP_MAX do
		local var_8_0 = self._formationStruct:getKnight(iter_8_0)

		if self._touchIndex == iter_8_0 then
			self["m_knight" .. iter_8_0]:updateComp(nil, self._touchIndex)
		else
			self["m_knight" .. iter_8_0]:updateComp(var_8_0, iter_8_0)
		end
	end

	self:_updateLineUpHaloCount(self._formationStruct:getGroupHaloInfo())
end

function FogNightmareExploreFormationComp:setPlusUIEnable(arg_9_1)
	for iter_9_0 = 1, var_0_1.LINEUP_MAX do
		self["m_knight" .. iter_9_0]:setPlusUIEnable(arg_9_1)
	end
end

function FogNightmareExploreFormationComp:checkCompEffect(arg_10_1, arg_10_2)
	for iter_10_0 = 1, var_0_1.LINEUP_MAX do
		if self["m_knight" .. iter_10_0]:containPoint(arg_10_1) then
			if arg_10_2 then
				self["m_knight" .. iter_10_0]:playCompMovingEffect()
			else
				self["m_knight" .. iter_10_0]:closeCompMovingEffect()
			end
		else
			self["m_knight" .. iter_10_0]:closeCompMovingEffect()
		end
	end
end

function FogNightmareExploreFormationComp:playCompDownEffect(arg_11_1)
	if self["m_knight" .. arg_11_1] then
		self["m_knight" .. arg_11_1]:touchEndEffect()
	end
end

return FogNightmareExploreFormationComp
