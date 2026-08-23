local FogNightmareExplorePoolKnightComp = class("FogNightmareExplorePoolKnightComp", require("app.fairyGUI.fogNightmare.UI_FogNightmareExplorePoolKnightComp"))
local var_0_2 = g.core.const.ConstMgr.FogNightmareConst
local PressComp = require("app.view.module.recruit.view.comp.PressComp")

function FogNightmareExplorePoolKnightComp:ctor()
	self.getSharedTrans(self, "listIconUiScaleIn", "ItemBagList", self)
	self.m_addKeepsakeBtn:addClickListener(handler(self, self._onAddKeepsakeBtnClicked))
	self.m_noKeepsakeLoader:addClickListener(handler(self, self._onAddKeepsakeBtnClicked))
	PressComp.bindComp(self.m_keepsakeIcon)
	self.m_keepsakeIcon:addPressListener(handler(self, self._onAddKeepsakeBtnClicked))
	self.m_keepsakeIcon:setClickListener(handler(self, self._onShowKeepSake))
	self.m_keepsakeIcon:setIconClickEnable(false)
end

function FogNightmareExplorePoolKnightComp:updateComp(arg_2_1, arg_2_2, arg_2_3)
	if arg_2_2 == 1 then
		self.m_isFriendController:setSelectedIndex(1)
	else
		self.m_isFriendController:setSelectedIndex(0)
	end

	self._knightStruct = arg_2_1.knight
	self._canSelectKeepsake = false

	if self._knightStruct and arg_2_3 then
		self._canSelectKeepsake = true
	end

	self._hasKeepsake = false
	self._pos = arg_2_2

	self:_updateKnight(self._knightStruct)
	self:_updateKeepStruct(arg_2_1.keepsake)
end

function FogNightmareExplorePoolKnightComp:_updateKnight(arg_3_1)
	self.m_knightComp:updateComp(arg_3_1, self._pos)
	self.m_knightComp:addKnightPress()

	if arg_3_1 then
		if arg_3_1:getKnightState() == g.core.const.ConstMgr.KNIGHT_CONST.SPECIAL_KNIGHT_STATE.DEFEATED then
			self.m_isDeadController:setSelectedIndex(1)
		else
			self.m_isDeadController:setSelectedIndex(0)
		end
	end
end

function FogNightmareExplorePoolKnightComp:_updateKeepStruct(arg_4_1)
	self._hasKeepsake = false
	self._sakeId = 0

	if arg_4_1 then
		self._hasKeepsake = true

		self.m_hasKeepsakeController:setSelectedIndex(2)
		self.m_keepsakeIcon:updateIconBySealId(arg_4_1:getCfg().seal_id)

		self._sakeId = arg_4_1:getCfg().id
	elseif self._canSelectKeepsake then
		self.m_hasKeepsakeController:setSelectedIndex(1)
	else
		self.m_hasKeepsakeController:setSelectedIndex(0)
	end

	if self._knightStruct then
		self._knightStruct:setDevelopStruct(arg_4_1, var_0_2.KNIGHT_DEVELOP_KEY.KEEPSAKE)
	end
end

function FogNightmareExplorePoolKnightComp:_onAddKeepsakeBtnClicked()
	if self._hasKeepsake then
		if self._knightStruct then
			g.core.module.ModuleManager:pushPopup(require("app.view.module.fogNightmare.view.explore.pop.FogNightmareKnightKeepsakeInfoPop").new(self._knightStruct), {
				ignoreTouch = false,
				hideContinue = false,
				touchDisappear = true
			})
			self.m_keepsakeIcon:clearSchedule()
		end

		return
	end

	if not self._canSelectKeepsake then
		g.core.module.ModuleManager:tip(g.core.lang:get(500181))

		return
	end

	g.core.model.User.fogNightmareData:setTempSelectSakeId(self._sakeId)
	self:dispatchCompEvent("clickAddKeepsake", {
		pos = self._pos,
		knightStruct = self._knightStruct
	})
end

function FogNightmareExplorePoolKnightComp:_onShowKeepSake()
	g.core.model.User.fogNightmareData:setTempSelectSakeId(self._sakeId)
	self:dispatchCompEvent("clickAddKeepsake", {
		pos = self._pos,
		knightStruct = self._knightStruct
	})
end

return FogNightmareExplorePoolKnightComp
