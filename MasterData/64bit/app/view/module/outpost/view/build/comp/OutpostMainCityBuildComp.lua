local OutpostMainCityBuildComp = class("OutpostMainCityBuildComp", require("app.fairyGUI.outpost.UI_OutpostMainCityBuildComp"))

function OutpostMainCityBuildComp:ctor()
	self.getSharedTrans(self, "enter_scaleOut", "CommonCardCellList", self)
end

function OutpostMainCityBuildComp:updateBuild(arg_2_1)
	self.m_buildIcon:setURL((g.core.common.Path:getOutpostSmallBuildIcon(arg_2_1.res)))
	self.m_nameTxt:setText(arg_2_1.name)
	self.m_beforeTxt:setText(g.core.lang:get(2052, {
		level = arg_2_1.curLv
	}))
	self.m_afterTxt:setText(g.core.lang:get(2052, {
		level = arg_2_1.nextLv
	}))

	if arg_2_1.curLv == arg_2_1.nextLv then
		self.m_singleLvController:setSelectedIndex(1)
	end
end

return OutpostMainCityBuildComp
