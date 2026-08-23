local BattleEditorData = require("app.view.module.debug.model.BattleEditorData")
local BattleEditorUniteTokenPop = class("BattleEditorUniteTokenPop", require("app.fairyGUI.debug.UI_BattleEditorUniteTokenPop"), function()
	return fgui.GComponent:create({
		pkgName = "formation",
		pkgPath = "ui/formation/formation",
		resName = "FormationUniteTokenPop",
		isFullScreen = true
	})
end)
local var_0_3 = {
	[0] = 0,
	3,
	2,
	1
}

function BattleEditorUniteTokenPop:ctor(arg_2_1)
	self._skillPos = arg_2_1.pos or 0
	self._identity = arg_2_1.identity
	self._qualitySelectedIndex = 0
	self._tokenList = {}
	self._curTokenList = {}

	self:_initComp()
	self:_addListener()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 1)
end

function BattleEditorUniteTokenPop:onLoad()
	self:_addNetWorkListener()

	local var_4_0 = self:getView():getSharedTrans("enter", "CommonRightPanelAnim", self.m_content)

	var_4_0:setHook("listEnter", handler(self, self._updateView))

	if var_4_0 then
		var_4_0:play(function()
			return
		end)
	end
end

function BattleEditorUniteTokenPop:_initComp()
	self:_initUI()
end

function BattleEditorUniteTokenPop:_initUI()
	self.m_tabList:setSelectedIndex(self._qualitySelectedIndex)
	self.m_runnerBanner:init({
		target = self.m_tabList
	})
	self.m_tokenList:setVirtual(self)
	self.m_tokenList:setItemRendererAsync1(handler(self, self._onRenderTokenList))
end

function BattleEditorUniteTokenPop:_addListener()
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabListClickItem))
	self.m_tokenList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTokenListClickItem))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClose))
end

function BattleEditorUniteTokenPop:_addNetWorkListener()
	return
end

function BattleEditorUniteTokenPop:_updateView()
	print("BattleEditorUniteTokenPop:_updateView")

	self._curTokenList = self:_getData()

	if #self._curTokenList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_tokenList:setNumItems(#self._curTokenList)
		self.m_tokenList:transitionShowCells("enter_right", 0.03)
	end
end

function BattleEditorUniteTokenPop:_getData()
	local var_11_0 = var_0_3[self._qualitySelectedIndex] or 0

	self._tokenList[var_11_0] = self._tokenList[var_11_0] or BattleEditorData.getInstance():getAllUnitSkillInfos(self._identity, var_11_0)

	return self._tokenList[var_11_0]
end

function BattleEditorUniteTokenPop:_onRenderTokenList(arg_12_1, arg_12_2)
	arg_12_2:updateCell({
		tokenData = self._curTokenList[arg_12_1 + 1]
	})
end

function BattleEditorUniteTokenPop:_onBack()
	if not self._isOnBack then
		self._isOnBack = true

		local var_13_0 = self:getView():getSharedTrans("back", "CommonRightPanelAnim", self.m_content)

		if var_13_0 then
			var_13_0:play(function()
				g.core.module.ModuleManager:popComponent()
			end)
		end
	end
end

function BattleEditorUniteTokenPop:_onTabListClickItem(arg_15_1)
	local var_15_0 = self.m_tabList:getSelectedIndex()

	if var_15_0 == self._qualitySelectedIndex then
		return
	end

	self._qualitySelectedIndex = var_15_0

	self:_updateView()
end

function BattleEditorUniteTokenPop:_onTokenListClickItem()
	local var_16_0 = self._curTokenList[self.m_tokenList:getSelectedIndex() + 1]

	print("BattleEditorUniteTokenPop:_onTokenListClickItem")

	if var_16_0 then
		BattleEditorData.getInstance():useTokenById(var_16_0:getBaseId(), self._skillPos, self._identity)
		self:_onBack()
		print("EVENT_CHANGE_UNITE")
		g.core.event.EventManager:dispatchEvent("EVENT_CHANGE_UNITE", false)
	end
end

function BattleEditorUniteTokenPop:_onClose(arg_17_1)
	if not self.m_bgPanel:containPoint((arg_17_1:getInput():getTouch():getLocation())) then
		self:_onBack()
	end
end

return BattleEditorUniteTokenPop
