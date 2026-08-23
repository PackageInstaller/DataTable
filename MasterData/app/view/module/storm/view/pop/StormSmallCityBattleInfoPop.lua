local StormSmallCityBattleInfoPop = class("StormSmallCityBattleInfoPop", require("app.fairyGUI.storm.UI_StormSmallCityBattleInfoPop"), function()
	return fgui.GComponent:create({
		resName = "StormSmallCityBattleInfoPop",
		pkgPath = "ui/storm/storm",
		pkgName = "storm"
	})
end)

function StormSmallCityBattleInfoPop:ctor(arg_2_1)
	self._stormId = arg_2_1.stormId
	self._cellEventId = arg_2_1.cellEventId
	self._eventInfo = arg_2_1.eventInfo

	self.m_rightBattleInfo:setData(arg_2_1)
	self.m_rightBattleInfo:updateComp()

	self._isEnterBattle = false

	self.m_rightBattleInfo:setSize(display.width, display.height)
	self:addClickListener(handler(self, self._onClose))
	self.m_playTimesComp:initView({
		type = g.core.common.Goods.RESOURCE.TYPE_TIRED,
		getTimesFunc = function()
			return g.core.model.User.bagData:getCountById(1, 24)
		end
	})
end

function StormSmallCityBattleInfoPop:onLoad()
	self:showAction()
	self.m_playTimesComp:updateView()
end

function StormSmallCityBattleInfoPop:showAction()
	return
end

function StormSmallCityBattleInfoPop:_onClose()
	self.m_rightBattleInfo:hideAction()
end

return StormSmallCityBattleInfoPop
