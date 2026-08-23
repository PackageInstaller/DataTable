local NewSlgFarmInfoComp = class("NewSlgFarmInfoComp")
local var_0_1 = g.core.const.ConstMgr.NewSlgConst
local var_0_2 = {
	{
		index = 1,
		icon = "ui://newSlg/icon_zhengduo",
		show = function(self)
			return self.isAttacking
		end,
		title = g.core.lang:get(429688),
		countDown = function(arg_2_0)
			return 0
		end,
		clickFunc = function(arg_3_0)
			g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_FARM_TEAM_POP, {
				tp = var_0_1.FARM_TEAM_POP_TYPE.ATK,
				id = arg_3_0
			})
		end
	},
	{
		index = 2,
		icon = "ui://newSlg/icon_zhanling_01",
		show = function(arg_4_0)
			return (g.core.model.User.newSlgData:isOccupying(arg_4_0))
		end,
		title = g.core.lang:get(429689),
		countDown = function(arg_5_0)
			local var_5_0, var_5_1 = g.core.model.User.newSlgData:isOccupying(arg_5_0)

			return var_5_1
		end,
		clickFunc = function(arg_6_0)
			g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_FARM_TEAM_POP, {
				tp = var_0_1.FARM_TEAM_POP_TYPE.OCC,
				id = arg_6_0
			})
		end
	}
}

function NewSlgFarmInfoComp:ctor()
	self._compTop = self:getChild("Comp_top")

	self:addListen(self._compTop)

	self._compBottom = self:getChild("Comp_bottom")

	self:addListen(self._compBottom)

	self._compBtnPlace = self:getChild("Comp_btnPlace")
	self.m_tipsComp = self:getChild("tipsComp")
	self._btnComps = {}
end

function NewSlgFarmInfoComp:receiveCompEvent(arg_8_1, arg_8_2)
	if arg_8_1 == "CLICK_TIPS_SLG_FARM" then
		self:_onCompAdditionClick()
	end
end

function NewSlgFarmInfoComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_SCHEDULE_NOTIFY_NEW, handler(self, self._onSchedule), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_FARMMAPSHOWNTF, handler(self, self._onFarmShowNtf), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_USEFARMTOKEN, handler(self, self._useFarmToken), self)
	g.core.utils.Tools.newSlgFunc.addSchedule({
		key = "NewSlgFarmInfoComp_updateTime"
	})
end

function NewSlgFarmInfoComp:_onFarmShowNtf(arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if not self._params then
		return
	end

	if arg_10_4.farm_map_shows and arg_10_4.farm_map_shows.farm_id == self._params.farmId then
		self:updateView(self._params, true)
	end
end

function NewSlgFarmInfoComp:_onSchedule(arg_11_1, arg_11_2, arg_11_3)
	if arg_11_3.key == "NewSlgFarmInfoComp_updateTime" and self:isVisible() then
		self._compTop:updateTime()
		self._compBottom:updateTime()
		self:updateTime()
	end
end

function NewSlgFarmInfoComp:updateTime()
	return
end

function NewSlgFarmInfoComp:updateView(arg_13_1, arg_13_2)
	if not arg_13_1 then
		return
	end

	self.m_tipsComp:setVisible(false)

	self._params = arg_13_1
	self._farmId = arg_13_1.farmId

	self._compTop:updateView(arg_13_1)

	self._data = g.core.model.User.newSlgData:getFarmDataById(self._farmId)

	self._compBottom:updateView(arg_13_1)
	self:_updateBtn()

	if not arg_13_2 then
		self:getTransition("enter"):play()
	end
end

function NewSlgFarmInfoComp:_updateBtn()
	for iter_14_0, iter_14_1 in ipairs(self._btnComps) do
		iter_14_1:setVisible(false)
	end
end

function NewSlgFarmInfoComp:_useFarmToken(arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	self:updateView(self._params, true)
	g.core.module.ModuleManager:awardSummary(arg_15_4.awards or {})
end

function NewSlgFarmInfoComp:_onCompAdditionClick()
	self._isAddVisible = not self._isAddVisible

	if self._isAddVisible then
		self:_setSafeShowPos()
	end

	self.m_tipsComp:setVisible(self._isAddVisible)
	self.m_tipsComp:updateFarmView()
end

function NewSlgFarmInfoComp:_setSafeShowPos()
	if self:localToGlobal(cc.p(0, 0)).x > display.cx then
		self.m_tipsComp:setX(-self.m_tipsComp:getWidth())
	else
		self.m_tipsComp:setX(self:getWidth())
	end
end

return NewSlgFarmInfoComp
