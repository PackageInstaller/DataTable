local var_0_0 = g.core.const.ConstMgr.PreciousConst
local PreciousSuitItemComp = class("PreciousSuitItemComp", require("app.fairyGUI.precious.UI_PreciousSuitItemComp"))

function PreciousSuitItemComp:ctor()
	return
end

function PreciousSuitItemComp:updateSuitComp(arg_2_1)
	if not arg_2_1 then
		return
	end

	self.m_suitNameText:setText(arg_2_1:getCfg().name)
	self.m_qualityLoader:setURL(g.core.common.Path:getNameQualityBg(arg_2_1:getQuality()))
	self.m_suitComp:updateMainCell(arg_2_1, {
		clickOpenInfoPop = true,
		ignoreRedPoint = true
	})
	self.m_starComp:initStar({
		gap = 4,
		style = 2,
		index = 3,
		max = var_0_0.SUIT_MAX_STAR_NUM,
		num = arg_2_1:getStar()
	})
end

return PreciousSuitItemComp
