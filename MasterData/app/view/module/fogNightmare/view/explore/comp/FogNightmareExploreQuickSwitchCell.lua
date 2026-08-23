local var_0_0 = g.core.model.User.fogNightmareData
local FogNightmareExploreQuickSwitchCell = class("FogNightmareExploreQuickSwitchCell", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreQuickSwitchCell"))

function FogNightmareExploreQuickSwitchCell:ctor()
	self._formationData = var_0_0:getFormationData()
	self._spine = nil
	self._knightList = {}

	self.m_knightList:setIniter()
	self.m_knightList:setItemRenderer(handler(self, self._onKnightIconRenderer))
end

function FogNightmareExploreQuickSwitchCell:_onKnightIconRenderer(arg_2_1, arg_2_2)
	arg_2_2:updateComp(self._knightList[arg_2_1 + 1])
end

function FogNightmareExploreQuickSwitchCell:updateComp(arg_3_1, arg_3_2)
	local var_3_0 = arg_3_1 or 0

	if (arg_3_1 or 0) > 0 then
		self.m_titleText:setText(g.core.lang:get(500142, {
			num = var_3_0
		}))
	end

	if not arg_3_2 then
		self._knightList = {}

		self.m_stateController:setSelectedIndex(0)
	else
		self._knightList = arg_3_2:getKnightPosList()

		self.m_stateController:setSelectedIndex(self._formationData:isUsedFormation(arg_3_2:getFormationIdx()) and 1 or 0)
	end

	self.m_knightList:setNumItems(6)
end

function FogNightmareExploreQuickSwitchCell:playCompEffect()
	if not self._spine or tolua.isnull(self._spine) then
		self._spine = self.m_effectNode:addEffectSpine({
			anim = "play",
			name = "eff_ui_fogNightmare_list",
			isLoop = true
		})
	else
		self._spine:setAnimation(0, "play", true)
	end

	self.m_effectNode:setVisible(true)
end

function FogNightmareExploreQuickSwitchCell:closeCompEffect()
	self.m_effectNode:setVisible(false)
end

function FogNightmareExploreQuickSwitchCell:onUnload()
	self.m_effectNode:setVisible(false)
end

return FogNightmareExploreQuickSwitchCell
