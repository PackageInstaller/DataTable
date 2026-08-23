local FogNightmareExploreMonsterIcon = class("FogNightmareExploreMonsterIcon", require("app.fairyGUI.fogNightmare.UI_FogNightmareExploreMonsterIcon"))

function FogNightmareExploreMonsterIcon:ctor()
	self._monsterStruct = nil

	self.m_hpBar:setMax(100)
	self.getSharedTrans(self, "listIconUiLeftIn", "ItemBagList", self)
end

function FogNightmareExploreMonsterIcon:updateComp(arg_2_1)
	self._monsterStruct = arg_2_1

	if not self._monsterStruct then
		self:_updateEmptyComp()

		return
	end

	local var_2_0 = self._monsterStruct:getHpPercent()

	self.m_knightIcon:updateIcon({
		struct = self._monsterStruct
	})
	self.m_hpBar:setValue(var_2_0)

	if var_2_0 < 1 then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_stateController:setSelectedIndex(0)
	end

	self.m_hasMonsterController:setSelectedIndex(1)
end

function FogNightmareExploreMonsterIcon:_updateEmptyComp()
	self.m_knightIcon:setEmpty()
	self.m_hasMonsterController:setSelectedIndex(0)
end

function FogNightmareExploreMonsterIcon:_onAddBtnClicked()
	self:dispatchCompEvent("clickAddKnight", {
		pos = self._pos
	})
end

return FogNightmareExploreMonsterIcon
