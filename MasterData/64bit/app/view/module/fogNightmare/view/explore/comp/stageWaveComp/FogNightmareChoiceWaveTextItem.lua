local var_0_4 = g.core.event.EventManager
local FogNightmareChoiceWaveTextItem = class("FogNightmareChoiceWaveTextItem", require("app.fairyGUI.fogNightmare.UI_FogNightmareChoiceWaveTextItem"), function()
	return fgui.GComponent:create({
		isFullScreen = false,
		pkgPath = "ui/fogNightmare/fogNightmare",
		resName = "FogNightmareChoiceWaveTextItem",
		pkgName = "fogNightmare"
	}, ...)
end)

function FogNightmareChoiceWaveTextItem:ctor()
	self._effectStruct = nil
	self._selectIdx = -1
	self._choiceItems = {}
	self._selectItem = nil
	self._otherEvents = {}
	self._compList = {}

	self:_initView()
end

function FogNightmareChoiceWaveTextItem:_initView()
	self.m_list:setVirtual(self)
	self.m_list:doFairyBatching(false)
	self.m_list:setItemRenderer(handler(self, self._onRendererChoiceItem))
	self.m_list:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onSelectChoiceItem))
end

function FogNightmareChoiceWaveTextItem:_onRendererChoiceItem(arg_4_1, arg_4_2)
	arg_4_2:updateComp(self._choiceItems[arg_4_1 + 1])
end

function FogNightmareChoiceWaveTextItem:_onSelectChoiceItem()
	local var_5_0 = self.m_list:getSelectedIndex()

	if not self._choiceItems[var_5_0 + 1]:getRealEffect():canChoice() then
		self.m_list:setSelectedIndex(self._selectIdx)

		return
	end

	self._selectIdx = var_5_0
end

function FogNightmareChoiceWaveTextItem:onLoad()
	var_0_4:addEventListener(g.core.event.enum.EVENT_NET_S2C_FOG_MAKECHOICE, self._onChoiceProcess, self)
end

function FogNightmareChoiceWaveTextItem:_addOtherCustomEvent(arg_7_1)
	var_0_4:addEventListener(arg_7_1, self._onChoiceProcess, self)

	self._otherEvents[arg_7_1] = true
end

function FogNightmareChoiceWaveTextItem:_clearOtherCustomEvent()
	for iter_8_0, iter_8_1 in pairs(self._otherEvents) do
		var_0_4:removeListenerWithEvent(self, iter_8_0)
	end

	self._otherEvents = {}
end

function FogNightmareChoiceWaveTextItem:updateComp(arg_9_1)
	self._effectStruct = arg_9_1
	self._choiceItems = arg_9_1:getSubEffects()

	self.m_list:setNumItems(#self._choiceItems)

	self._selectIdx = -1

	self.m_list:setSelectedIndex(self._selectIdx)
end

function FogNightmareChoiceWaveTextItem:_doClickAction(arg_10_1)
	if not self._selectIdx or self._selectIdx == -1 then
		g.core.module.ModuleManager:tip(g.core.lang:get(500191))

		return
	end

	self._selectItem = self._choiceItems[self._selectIdx + 1]

	self:_makeChoice(arg_10_1)
end

function FogNightmareChoiceWaveTextItem:_makeChoice(arg_11_1)
	local var_11_0, var_11_1 = self._selectItem:getRealEffect():onChoice(arg_11_1)
	local var_11_2 = self._selectItem:getRealEffect():getCompName()
	local var_11_3 = 0

	if not var_11_0 and var_11_2 and #var_11_2 > 0 then
		if not self._compList[var_11_2] then
			local var_11_4 = require("app.view.module.fogNightmare.view.explore.comp.stageWaveComp." .. var_11_2).new()

			self.m_childNode:addChild(var_11_4)

			self._compList[var_11_2] = var_11_4
		end

		self._compList[var_11_2]:updateComp(self._selectItem)

		var_11_3 = 1
	elseif var_11_1.call then
		var_11_1.call(self._selectItem:getRealEffect())
	elseif var_11_1.listenerEvent then
		self:_clearOtherCustomEvent()
		self:_addOtherCustomEvent(var_11_1.listenerEvent)
		var_11_1.netFunc(var_11_1.netParam)
	else
		local var_11_5 = var_11_1.netParam

		var_11_5.choice_id = self._selectItem:getCfg().id

		g.core.network.GameNetProxy:send_C2S_Fog_MakeChoice(var_11_5)
	end

	self.m_hasChildCompController:setSelectedIndex(var_11_3)
end

function FogNightmareChoiceWaveTextItem:doClickCancelAction(arg_12_1)
	return
end

function FogNightmareChoiceWaveTextItem:_onChoiceProcess(arg_13_1, arg_13_2, arg_13_3)
	if self._selectItem:isFinish() then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_CHECK_FLOOR_STATE, false)
	else
		self:_makeChoice(arg_13_3)
	end
end

function FogNightmareChoiceWaveTextItem:onUnload()
	if self._selectItem then
		self._selectItem:getRealEffect():resetData(nil)
	end
end

return FogNightmareChoiceWaveTextItem
