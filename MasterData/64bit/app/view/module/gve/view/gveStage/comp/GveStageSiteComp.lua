local var_0_0 = g.core.model.User.gveDataMgr
local var_0_1 = g.core.model.User.gveDataMgr:getGveData()
local var_0_2 = g.core.common.Goods
local GveStageSiteComp = class("GveStageSiteComp", require("app.fairyGUI.gve.UI_GveStageSiteComp"))

function GveStageSiteComp:ctor()
	var_0_1 = var_0_0:getGveData()

	self:updateGveSiteInfo()
end

function GveStageSiteComp:onLoad()
	self:updateGveSiteInfo()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDUSERDATAFLUSH, handler(self, self.updateGveSiteInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDSETCELLKNIGHT, handler(self, self.updateGveSiteInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDGIVEUPCELL, handler(self, self.updateGveSiteInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GVE_MY_GRID_CHANGE, handler(self, self.updateGveSiteInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_G_VE_WORLDTIMEAWARD, handler(self, self.updateGveSiteInfo), self)
end

function GveStageSiteComp:updateGveSiteInfo()
	local var_3_0 = var_0_1:getMaxGridNum()
	local var_3_1 = var_0_1:getMyGridNum()

	self.m_siteNumTxt:setText(var_3_1 .. "/" .. var_3_0)

	if var_3_0 <= var_3_1 then
		self.m_fullController:setSelectedIndex(1)
	else
		self.m_fullController:setSelectedIndex(0)
	end

	local var_3_2 = var_0_2:convert({
		type = var_0_2.TYPE_RESOURCE,
		value = var_0_2.RESOURCE.TYPE_GVE_COMMON_RESOURCE
	})

	self.m_rewardNumTxt:setText(var_3_2.size)
	self.m_rewardIcon:setURL(var_3_2.icon_mini)
	self.m_rewardAddTxt:setText(g.core.lang:get(309119, {
		num = math.ceil(var_0_1:getCurResourceRate())
	}))

	local var_3_3 = var_0_1:getMySiteCtrlData()
	local var_3_5 = 0

	if next(var_3_3.big) then
		for iter_3_0, iter_3_1 in ipairs(var_3_3.big) do
			if var_3_5 < iter_3_1.baseCfg.base_level and iter_3_1.baseCfg.if_ruins == 1 then
				var_3_5 = iter_3_1.baseCfg.base_level
			end
		end
	elseif next(var_3_3.middle) then
		for iter_3_2, iter_3_3 in ipairs(var_3_3.middle) do
			if var_3_5 < iter_3_3.baseCfg.base_level and iter_3_3.baseCfg.if_ruins == 1 then
				var_3_5 = iter_3_3.baseCfg.base_level
			end
		end
	else
		for iter_3_4, iter_3_5 in ipairs(var_3_3.small) do
			if var_3_5 < iter_3_5.baseCfg.base_level and iter_3_5.baseCfg.if_ruins == 1 then
				var_3_5 = iter_3_5.baseCfg.base_level
			end
		end
	end

	if var_3_5 > 0 then
		self.m_siteIcon2:setURL((var_0_1:getPosPic2(var_3_5)))
	end
end

return GveStageSiteComp
