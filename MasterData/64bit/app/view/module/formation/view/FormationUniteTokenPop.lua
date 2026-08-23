local var_0_0 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_1 = g.core.const.ConstMgr.BASE_CONST
local FormationUniteTokenPop = class("FormationUniteTokenPop", require("app.fairyGUI.formation.UI_FormationUniteTokenPop"), function()
	return fgui.GComponent:create({
		pkgName = "formation",
		isFullScreen = true,
		pkgPath = "ui/formation/formation",
		resName = "FormationUniteTokenPop"
	})
end)
local var_0_3 = g.core.model.User

function FormationUniteTokenPop:ctor(arg_2_1)
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_TICK_WEAK_GUIDE_FINISH)

	self._skillPos = arg_2_1.pos or 0
	self._qualitySelectedIndex = 0
	self._tokenList = {}
	self._curTokenList = {}
	self._tabQualitys = var_0_0.TabQuality[var_0_0.NEW_QUALITY_CTRL.UNITETOKEN]

	self:_initComp()
	self:_addListener()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 1)
end

function FormationUniteTokenPop:onLoad()
	self:_addNetWorkListener()

	local var_4_0 = self:getView():getSharedTrans("enter", "CommonRightPanelAnim", self.m_content)

	var_4_0:setHook("listEnter", handler(self, self._updateView))

	if var_4_0 then
		var_4_0:play(function()
			return
		end)
	end
end

function FormationUniteTokenPop:_initComp()
	self:_initUI()
end

function FormationUniteTokenPop:_initUI()
	self.m_tabList:setVirtual()
	self.m_tabList:setItemRenderer(handler(self, self._onTabListItemRender))
	self.m_tabList:setNumItems(table.nums(self._tabQualitys))
	self.m_tabList:setSelectedIndex(self._qualitySelectedIndex)
	self.m_tokenList:setVirtual(self)
	self.m_tokenList:setItemRendererAsync1(handler(self, self._onRenderTokenList))
end

function FormationUniteTokenPop:_addListener()
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabListClickItem))
	self.m_tokenList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTokenListClickItem))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClose))
end

function FormationUniteTokenPop:_addNetWorkListener()
	return
end

function FormationUniteTokenPop:_updateView()
	self._curTokenList = self:_getData()

	if #self._curTokenList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_tokenList:setNumItems(#self._curTokenList)
		self.m_tokenList:transitionShowCells("enter_right", 0.03)
	end
end

function FormationUniteTokenPop:_getData()
	local var_11_0 = self._tabQualitys[self._qualitySelectedIndex].quality or 0

	self._tokenList[var_11_0] = self._tokenList[var_11_0] or var_0_3.uniteTokenData:getTokenListByQuality(var_11_0)

	return self._tokenList[var_11_0]
end

function FormationUniteTokenPop:_onRenderTokenList(arg_12_1, arg_12_2)
	arg_12_2:updateCell({
		tokenData = self._curTokenList[arg_12_1 + 1]
	})
end

function FormationUniteTokenPop:_onBack()
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

function FormationUniteTokenPop:_onTabListClickItem(arg_15_1)
	local var_15_0 = self.m_tabList:getSelectedIndex()

	if var_15_0 == self._qualitySelectedIndex then
		return
	end

	self._qualitySelectedIndex = var_15_0

	self:_updateView()
end

function FormationUniteTokenPop:_onTabListItemRender(arg_16_1, arg_16_2)
	arg_16_2:setTitle(self._tabQualitys[arg_16_1].name or 0)
end

function FormationUniteTokenPop:_onTokenListClickItem()
	local var_17_0 = self._curTokenList[self.m_tokenList:getSelectedIndex() + 1]

	if var_17_0 then
		if var_0_1.HAS_PUT_CHECK and var_17_0:getPut() == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(1159))

			return
		end

		local var_17_1 = var_17_0:getAdvanceId()
		local var_17_2 = self._skillPos == var_17_0:getPos() and 0 or self._skillPos

		if var_17_1 > 0 then
			g.core.network.GameNetProxy:send_C2S_Formation_ChangeFormation({
				tp = 2,
				pos = var_17_2,
				id = var_17_1
			})
			self:_onBack()
		end
	end
end

function FormationUniteTokenPop:_onClose(arg_18_1)
	if not self.m_bgPanel:containPoint((arg_18_1:getInput():getTouch():getLocation())) then
		self:_onBack()
	end
end

function FormationUniteTokenPop:_recvChangeFormation()
	self:_onBack()
end

return FormationUniteTokenPop
