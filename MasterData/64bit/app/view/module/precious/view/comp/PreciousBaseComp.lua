local var_0_0 = g.core.common.Path
local PreciousBaseComp = class("PreciousBaseComp", require("app.fairyGUI.precious.UI_PreciousBaseComp"))

function PreciousBaseComp:updatePrecious(arg_1_1)
	self.m_nameTxt:setText(arg_1_1:getCfg().name)
	self.m_icon:setURL(var_0_0:getPreciousIconByResId(arg_1_1:getCfg().res_id))
	self.m_starComp:initStar({
		style = 2,
		index = 3,
		gap = -2,
		max = arg_1_1:getMaxStarCfg().star,
		num = arg_1_1:getStar()
	})
	self.m_qualityLoader:setURL(var_0_0:getPreciousQualityUrl(arg_1_1:getQuality()))
	self.m_isOwnController:setSelectedIndex(arg_1_1:isOwn() and 1 or 0)

	self._upgradeInfo = arg_1_1:getUpgradeInfo()

	self.m_stageTxt:setText(g.core.lang:get(421211, {
		num1 = self._upgradeInfo.stage,
		num2 = self._upgradeInfo.node
	}))
end

function PreciousBaseComp:setSelected(arg_2_1)
	self.m_isSelectController:setSelectedIndex(arg_2_1 and 1 or 0)
end

return PreciousBaseComp
