local var_0_0 = g.core.model.User.preciousData
local var_0_1 = g.core.const.ConstMgr.PreciousConst
local PreciousSuitDevLayer = class("PreciousSuitDevLayer", require("app.fairyGUI.precious.UI_PreciousSuitDevLayer"), function()
	return fgui.GComponent:create({
		pkgName = "precious",
		isFullScreen = true,
		pkgPath = "ui/precious/precious",
		resName = "PreciousSuitDevLayer"
	}, ...)
end)

function PreciousSuitDevLayer:ctor(arg_2_1)
	self._defaultGroup = arg_2_1 and arg_2_1.group
	self._curSelIndex = 0
	self._suitList = {}
	self._curSuitStruct = nil

	self:_initListView()
	self:_initBtn()
	self:_initView()
end

function PreciousSuitDevLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PRECIOUS_SUITACTIVATE, self._onSuitAdvanceRec, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_PRECIOUS_SUITSTARUP, self._onSuitAdvanceRec, self)
	self.m_enterTransition:play()
end

function PreciousSuitDevLayer:onUnload()
	return
end

function PreciousSuitDevLayer:_initBtn()
	self.m_activeBtn:addClickListener(handler(self, self._onActiveClick))
	self.m_advanceBtn:addClickListener(handler(self, self._onAdvanceClick))
end

function PreciousSuitDevLayer:_initView()
	self:addBg("bg/precious/bg_gzp_guizhongpinbg.jpg", nil, nil, 1)
	self.m_topBar:setResInfoById(var_0_1.PRECIOUS_HELP_ID)
	self:updateSuitList()
end

function PreciousSuitDevLayer:updateSuitList()
	self._suitList = var_0_0:getAllSuitList()

	self.m_suitList:setNumItems(#self._suitList)

	if self._defaultGroup then
		for iter_7_0 = 1, #self._suitList do
			if self._suitList[iter_7_0]:getSuitGroup() == self._defaultGroup then
				self._curSelIndex = iter_7_0 - 1

				break
			end
		end
	end

	self.m_suitList:setSelectedIndex(self._curSelIndex)
	self.m_suitList:scrollToView(self._curSelIndex, true)
	self:updateSuitDevComp()
end

function PreciousSuitDevLayer:_initListView()
	self.m_suitList:setVirtual()
	self.m_suitList:setItemRenderer(handler(self, self._onRenderSuitList))
	self.m_suitList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickSuitItem))
end

function PreciousSuitDevLayer:_onRenderSuitList(arg_9_1, arg_9_2)
	arg_9_2:updateSuitIconCell(self._suitList[arg_9_1 + 1])
end

function PreciousSuitDevLayer:_onClickSuitItem(arg_10_1)
	local var_10_0 = self.m_suitList:getSelectedIndex()

	if var_10_0 == self._curSelIndex then
		return
	end

	self._curSelIndex = var_10_0

	self:updateSuitDevComp()
end

function PreciousSuitDevLayer:updateSuitDevComp()
	local var_11_0 = self._suitList[self._curSelIndex + 1]

	self._curSuitStruct = self._suitList[self._curSelIndex + 1]
	self._defaultGroup = var_11_0:getSuitGroup()

	self.m_suitNameText:setText(var_11_0:getCfg().name)

	local var_11_1 = 0

	if var_11_0:isMaxStar() then
		var_11_1 = 2
	elseif var_11_0:isActivate() then
		var_11_1 = 1
	end

	self.m_isActiveController:setSelectedIndex(var_11_1)
	self.m_activeBtn:setGrayed(not self._curSuitStruct:isCanActivate())
	self.m_advanceBtn:setGrayed(not self._curSuitStruct:isCanStarUp())
	self.m_suitComp:updateMainCell(var_11_0, {
		ignoreRedPoint = true,
		clickOpenInfoPop = true
	})
	self.m_devComp:updateSuitStarUpComp(var_11_0)
end

function PreciousSuitDevLayer:_onSuitAdvanceRec(arg_12_1, arg_12_2, arg_12_3)
	if arg_12_3.suit then
		local var_12_0 = var_0_0:getPreciousSuitByGroup(arg_12_3.suit.group)

		if var_12_0 then
			g.core.module.ModuleManager:pushModule(g.view.entrance.PRECIOUS_SUIT_SUCCESS, var_12_0)
		end
	end

	self:updateSuitList()
end

function PreciousSuitDevLayer:_onActiveClick()
	if not self._curSuitStruct then
		return
	end

	if self._curSuitStruct:isCanActivate() then
		g.core.network.GameNetProxy:send_C2S_Precious_SuitActivate({
			base_id = self._curSuitStruct:getId()
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(421203))
	end
end

function PreciousSuitDevLayer:_onAdvanceClick()
	if not self._curSuitStruct then
		return
	end

	if self._curSuitStruct:isCanStarUp() then
		g.core.network.GameNetProxy:send_C2S_Precious_SuitStarUp({
			suit_group = self._curSuitStruct:getSuitGroup()
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(421204))
	end
end

return PreciousSuitDevLayer
