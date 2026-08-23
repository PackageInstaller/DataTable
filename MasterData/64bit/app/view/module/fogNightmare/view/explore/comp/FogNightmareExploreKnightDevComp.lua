local var_0_0 = g.core.common.Path
local var_0_1 = g.core.const.ConstMgr.FogNightmareConst
local FogNightmareExploreKnightDevComp = class("FogNightmareExploreKnightDevComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreKnightDevComp"))

function FogNightmareExploreKnightDevComp:ctor()
	self._developStruct = nil
	self._knightStruct = nil
	self._effectSpine = nil
	self._isTouch = false

	self.m_addBtn:addClickListener(handler(self, self._onAddBtnClicked))
	self.m_icon:addClickListener(handler(self, self._onAddBtnClicked))
	self.m_noneUILoader:addClickListener(handler(self, self._onAddBtnClicked))
end

function FogNightmareExploreKnightDevComp:updateComp(arg_2_1, arg_2_2)
	self._knightStruct = arg_2_1
	self._developStruct = (arg_2_1 and arg_2_1:getDevelopStructs() or {})[var_0_1.KNIGHT_DEVELOP_KEY.ARTIFACT]
	self._devKey = var_0_1.KNIGHT_DEVELOP_KEY.ARTIFACT
	self._pos = arg_2_2

	local var_2_0 = 0

	if not self._developStruct then
		self:_updateEmptyComp()
	else
		var_2_0 = 1

		self:_updateDevComp()
	end

	self.m_hasController:setSelectedIndex(var_2_0)
end

function FogNightmareExploreKnightDevComp:_updateEmptyComp()
	self.m_qualityLoader:setURL("ui://base_new/pic_wjmy_bz_yht_r_1")
	self.m_isEffectController:setSelectedIndex(0)
end

function FogNightmareExploreKnightDevComp:_updateDevComp()
	self.m_icon:setURL((var_0_0:getArtifactRebornImg(self._developStruct:getCfg().res_id)))
	self.m_starText:setText((self._developStruct:getStar()))
	self.m_qualityLoader:setURL(var_0_0:getMulTeamArtifactQualityBgURL((self._developStruct:getQuality())))

	local var_4_0 = self._developStruct:getBelongToKnightAvdIdIncludingMainRole() == self._knightStruct:getAdvanceId()

	if var_4_0 then
		self:addSpine()
	end

	self.m_isEffectController:setSelectedIndex(var_4_0 and 1 or 0)

	if self._developStruct:isHasWeaponSpirit() and self._developStruct:getSpiritStage() > 0 then
		self.m_spiritComp:updateCurWeapon(self._developStruct)
		self.m_urStageAddController:setSelectedIndex(1)
	else
		self.m_urStageAddController:setSelectedIndex(0)
	end
end

function FogNightmareExploreKnightDevComp:addSpine()
	if self._effectSpine == nil or tolua.isnull(self._effectSpine) then
		self._effectSpine = self.m_effArtifact:addEffectSpine({
			isLoop = true,
			name = "eff_ui_fogNightmare_artifactElect",
			anim = "play"
		})
	end
end

function FogNightmareExploreKnightDevComp:_onAddBtnClicked()
	if self._isTouch then
		return
	end

	self:dispatchCompEvent("clickAddDev", {
		pos = self._pos,
		devKey = self._devKey
	})
end

function FogNightmareExploreKnightDevComp:isCanMove()
	return self._developStruct ~= nil
end

function FogNightmareExploreKnightDevComp:setCompTouch(arg_8_1)
	self._isTouch = arg_8_1 == true
end

function FogNightmareExploreKnightDevComp:showMoveBg()
	return
end

return FogNightmareExploreKnightDevComp
