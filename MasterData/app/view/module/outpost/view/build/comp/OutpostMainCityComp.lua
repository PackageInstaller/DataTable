local OutpostMainCityComp = class("OutpostMainCityComp", require("app.fairyGUI.outpost.UI_OutpostMainCityComp"))

function OutpostMainCityComp:ctor()
	self._buildStruct = nil
	self._buildInfos = nil

	self:_initInfoComp()
end

function OutpostMainCityComp:_initInfoComp()
	self.m_buildList:setVirtual(self)
	self.m_buildList:setItemRenderer(handler(self, self._onBuildItemRender))
end

function OutpostMainCityComp:updateMainCityComp(arg_3_1)
	self._buildStruct = arg_3_1

	local var_3_0 = self._buildStruct:getCfg()
	local var_3_1 = self._buildStruct:getNextCfg() or var_3_0

	self.m_curUpNumTxt:setText(#g.core.model.User.outpostData:getKnightsData():getAllLineUpKnights())
	self.m_maxNumTxt:setText(table.concat({
		"/",
		var_3_0.role_value
	}))
	self.m_knightNumComp:updateAttrComp(var_3_0.role_value, var_3_1.role_value)
	self.m_vitNumComp:updateAttrComp(var_3_0.brawn_level, var_3_1.brawn_level)
	self.m_levelComp:updateAttrComp(var_3_0.knight_level, var_3_1.knight_level)

	self._buildInfos = g.core.model.User.outpostData:getBuildData():getMainCityLimitsInfo()

	self.m_buildList:setNumItems(#self._buildInfos)
end

function OutpostMainCityComp:_onBuildItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateBuild(self._buildInfos[arg_4_1 + 1])
end

function OutpostMainCityComp:playUpEffect()
	self.m_effNode:addEffectSpine({
		remove = true,
		name = "eff_ui_outpost_buildinguptxt",
		isLoop = false
	})
	self.m_buildList:transitionShowCells("enter_scaleOut", 0.03, 1)
end

return OutpostMainCityComp
