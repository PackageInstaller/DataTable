local var_0_0 = g.core.model.User.illustrationData
local IllustrationTabCfg = require("app.view.module.illustration.const.IllustrationTabCfg")
local IllustrationMainLayer = class("IllustrationMainLayer", require("app.fairyGUI.illustration.UI_IllustrationMainLayer"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/illustration/illustration",
		resName = "IllustrationMainLayer",
		pkgName = "illustration",
		isFullScreen = true
	}, ...)
end)

function IllustrationMainLayer:ctor()
	self._selectTagIndex = 0
	self._curShowData = {}
	self._changePage = false

	self:_init()
end

function IllustrationMainLayer:onLoad()
	self:_addListener()
end

function IllustrationMainLayer:_init()
	self:addBg("bg/illustration/bg_cls_huiyiliebiao.jpg")
	var_0_0:updateData()
	self.m_itemCellList:setVirtual()
	self.m_itemCellList:doFairyBatching(false)
	self.m_itemCellList:setItemRenderer(handler(self, self._onItemRenderer))
	self.m_tabBtnController:setSelectedIndex(self._selectTagIndex)
	self:_onTabChange()
end

function IllustrationMainLayer:_addListener()
	self.m_tabBtnController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabChange))
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_ILLUSTRATION_NEW_READ, self._onNewIllustrationRead, self)
end

function IllustrationMainLayer:_onTabChange()
	if self._changePage then
		self.m_itemCellList:setNumItems(#self._curShowData)
		self.m_itemCellList:transitionShowCells("listReplayUiDownOut01", 0)

		if self._scheduleAnimId then
			g.core.common.Scheduler:cancelSchedule(self._scheduleAnimId)

			self._scheduleAnimId = nil
		end

		self._scheduleAnimId = g.core.common.Scheduler:newScheduleOnce(handler(self, self._onPlayEnterAnim), 0.25)
	else
		self:_onPlayEnterAnim()
	end

	self._changePage = true
end

function IllustrationMainLayer:_onPlayEnterAnim()
	self._selectTagIndex = self.m_tabBtnController:getSelectedIndex()
	self._curShowData = var_0_0:getIllustrationData(IllustrationTabCfg[self._selectTagIndex + 1].typeID)

	self.m_itemCellList:setNumItems(#self._curShowData)
	self.m_itemCellList:transitionShowCells("listReplayUiDownIn01", 0.06)
end

function IllustrationMainLayer:_onItemRenderer(arg_8_1, arg_8_2)
	if arg_8_1 >= #self._curShowData then
		return
	end

	arg_8_2:setData(self._curShowData[arg_8_1 + 1], self._selectTagIndex + 1)
end

function IllustrationMainLayer:_onNewIllustrationRead()
	self._curShowData = var_0_0:getIllustrationData(IllustrationTabCfg[self._selectTagIndex + 1].typeID)

	self.m_itemCellList:setNumItems(#self._curShowData)
end

return IllustrationMainLayer
