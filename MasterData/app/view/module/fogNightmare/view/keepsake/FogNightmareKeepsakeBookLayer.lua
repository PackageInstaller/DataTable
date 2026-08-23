local var_0_0 = g.core.module.ModuleManager
local var_0_1 = g.core.common.ServerTime
local FogNightmareKeepsakeBookLayer = class("FogNightmareKeepsakeBookLayer", require("app.fairyGUI.fogNightmare.UI_FogNightmareKeepsakeBookLayer"), function()
	return fgui.GComponent:create({
		resName = "FogNightmareKeepsakeBookLayer",
		pkgPath = "ui/fogNightmare/fogNightmare",
		isFullScreen = true,
		pkgName = "fogNightmare"
	}, ...)
end)
local var_0_3 = g.core.model.User.fogNightmareData

function FogNightmareKeepsakeBookLayer:ctor()
	self.m_topBarComp:setResInfoById(154)

	self._tabSelectIdx = 1
	self._schedule = nil
	self._unlockSealList = var_0_3:getKeepsakeNewData()
	self._unlockSealData = var_0_3:getKeepsakeNewIconData()
	self._unlockSealTabData = var_0_3:getKeepsakeNewTabData()
	self._handBookDataList = var_0_3:getKeepsakeData():getUnlockKeepsakeBookDataList(var_0_3:getFogLevel())

	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabChange))
	self.m_tabList:setVirtual(self)
	self.m_tabList:setItemRenderer(handler(self, self._onTabListItemRender))
	self.m_tabList:setNumItems(#self._handBookDataList)
	self:addBg("bg/fogNightmare/bg_wjmy_tf.jpg")
	self.m_itemList:setVirtual(self)
	self.m_itemList:setItemRenderer(handler(self, self._onItemListItemRender))

	self._curTabKeepsakeData = nil

	self:_initView()
end

function FogNightmareKeepsakeBookLayer:_initView()
	self.m_tabList:setSelectedIndex(0)
	self:_updateListView(self._tabSelectIdx)
	self.m_suitDetailText:getChild("title"):enableRich()
	self.m_tabList:getChildAt(0):getChild("redPointComp"):setVisible(false)
end

function FogNightmareKeepsakeBookLayer:onLoad()
	if self._schedule == nil then
		self._schedule = self:newSchedule(handler(self, self._updateTimeBySchedule), 1)
	end
end

function FogNightmareKeepsakeBookLayer:_updateTimeBySchedule()
	if var_0_1:getTime() > var_0_3:getEndTime() then
		var_0_0:popAllPopup()
		var_0_0:popModule()
	end
end

function FogNightmareKeepsakeBookLayer:_onTabChange()
	local var_6_0 = self.m_tabList:getSelectedIndex() + 1

	if var_6_0 == self._tabSelectIdx then
		return
	end

	local var_6_1 = self.m_tabList:getChildAt((self.m_tabList:itemIndexToChildIndex(var_6_0 - 1)))

	self._tabSelectIdx = var_6_0

	self:_updateListView(self._tabSelectIdx)
	var_6_1:getChild("redPointComp"):setVisible(false)
end

function FogNightmareKeepsakeBookLayer:_onTabListItemRender(arg_7_1, arg_7_2)
	local var_7_0 = self._handBookDataList[arg_7_1 + 1]

	if arg_7_1 > 0 then
		arg_7_2:getController("type"):setSelectedIndex(1)
		arg_7_2:getChild("iconUp"):setURL(g.core.common.Path:getFogNightmareKeepsakeSuitPicRes(var_7_0.suitId .. "_3"))
		arg_7_2:getChild("iconDown"):setURL(g.core.common.Path:getFogNightmareKeepsakeSuitPicRes(var_7_0.suitId .. "_2"))
	else
		arg_7_2:getController("type"):setSelectedIndex(0)
	end

	arg_7_2:setTitle(var_7_0.name)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = arg_7_2,
		customData = {
			suitId = var_7_0.suitId
		}
	})
end

function FogNightmareKeepsakeBookLayer:_onItemListItemRender(arg_8_1, arg_8_2)
	arg_8_2:updateIconBySealId(self._curTabKeepsakeBookData[arg_8_1 + 1].seal_id, true)

	if self._unlockSealData[self._curTabKeepsakeBookData[arg_8_1 + 1].seal_id] == 1 then
		self._unlockSealData[self._curTabKeepsakeBookData[arg_8_1 + 1].seal_id] = 0
		self._unlockSealTabData[self._curTabKeepsakeBookData[arg_8_1 + 1].type] = self._unlockSealTabData[self._curTabKeepsakeBookData[arg_8_1 + 1].type] - 1
	end
end

function FogNightmareKeepsakeBookLayer:_onUpdateSuitTipText()
	local var_9_0 = var_0_3:getKeepsakeData():getSuitInfo(self._handBookDataList[self._tabSelectIdx].suitId)
	local var_9_1 = ""

	for iter_9_0, iter_9_1 in ipairs((var_9_0:getAllEffectInfo())) do
		var_9_1 = var_9_1 .. g.core.lang:get(500233, {
			color = string.format("#%x%x%x", g.core.common.Color.A6.r, g.core.common.Color.A6.g, g.core.common.Color.A6.b),
			str = g.core.lang:get(500234, {
				name = var_9_0:getCfg().name,
				activeNum = iter_9_1.targetNum,
				tip = iter_9_1.desTxt
			})
		})
	end

	self.m_suitDetailText:getChild("title"):setText(var_9_1, true)
end

function FogNightmareKeepsakeBookLayer:_updateListView(arg_10_1)
	if self._handBookDataList[arg_10_1].suitId == 0 then
		self.m_hasSuitController:setSelectedIndex(0)
	else
		self.m_hasSuitController:setSelectedIndex(1)
		self:_onUpdateSuitTipText()
	end

	self._curTabKeepsakeBookData = self._handBookDataList[arg_10_1].data

	self.m_itemList:setNumItems(#self._curTabKeepsakeBookData)
end

function FogNightmareKeepsakeBookLayer:onUnload()
	self._schedule = nil

	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(self._unlockSealList) do
		if self._unlockSealData[iter_11_1.seal_id] ~= 0 then
			table.insert(var_11_0, iter_11_1)
		end
	end

	var_0_3:setKeepsakeNewData(var_11_0)
	g.core.common.Storage:save("fogNightmare_keepsake_new.json", {
		list = var_11_0,
		seasonId = var_0_3:getSeasonId()
	}, true)
end

return FogNightmareKeepsakeBookLayer
