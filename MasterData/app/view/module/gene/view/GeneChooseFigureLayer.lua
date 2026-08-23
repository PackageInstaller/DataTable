local var_0_0 = g.core.config.gene_info
local var_0_1 = g.core.model.User.geneData
local var_0_2 = g.core.const.ConstMgr.GuideConst
local GeneChooseFigureLayer = class("GeneChooseFigureLayer", require("app.fairyGUI.gene.UI_GeneChooseFigureLayer"), function()
	return fgui.GComponent:create({
		resName = "GeneChooseFigureLayer",
		pkgPath = "ui/gene/gene",
		isFullScreen = true,
		pkgName = "gene"
	}, ...)
end)

function GeneChooseFigureLayer:ctor(arg_2_1)
	if arg_2_1 then
		self._routeGeneId = arg_2_1.route1 or 0
	end

	self:addBg("bg/gene/bg_shengwujiexi_main.jpg")
	self.m_topBarComp:setResInfoById(5000001)
	self.m_topBarComp:hidePushGift()
	self:_initRegisterListen()
end

function GeneChooseFigureLayer:_initRegisterListen()
	self.m_figureList:setVirtual()
	self.m_figureList:doFairyBatching(false)
	self.m_figureList:setItemRenderer(handler(self, self._onFigureListItemRender))
	self.m_figureList:addEventListener(fgui.UIEventType.Scroll, handler(self, self._onListScroll))
	self.m_allAttrBtn:addClickListener(handler(self, self._onAllAttrClick))
	self.m_leftLoader:addClickListener(handler(self, self._onClickLeft))
	self.m_rightLoader:addClickListener(handler(self, self._onClickRight))
end

function GeneChooseFigureLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GENE_GETINFO, self._onGeneGetInfo, self)
	g.core.network.GameNetProxy:send_C2S_Gene_GetInfo({})
	self.m_enterTransition:play()
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.GENE)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.UI_EVENT_ECHOENTER)

	if not g.core.model.User.guideData:getServerDataById(27) then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_CHECK, false, {
			tickType = 6,
			enum = var_0_2.ENUM_TICK.GENE_TICK_GUIDE_FORCE
		})
		g.core.model.User.guideData:setSaveServerData(27)

		return
	end
end

function GeneChooseFigureLayer:_onGeneGetInfo()
	if self._routeGeneId > 0 then
		if self._routeGeneId == 999 then
			g.core.module.ModuleManager:pushModule(g.view.entrance.GENE_FIGURE, var_0_0.indexOf((var_0_1:getCurGeneIndex())).id)
		else
			g.core.module.ModuleManager:pushModule(g.view.entrance.GENE_FIGURE, self._routeGeneId)
		end

		self._routeGeneId = 0
	else
		self:_updateMainView()
	end
end

function GeneChooseFigureLayer:_updateMainView()
	self.m_figureList:setNumItems(var_0_0.getLength())

	self._figureLen = var_0_0.getLength()

	self:_onListScroll()

	local var_6_0 = var_0_1:getCurGeneIndex()

	if var_6_0 > 1 then
		self.m_figureList:scrollToView(var_6_0 - 2, false)
	end

	for iter_6_0, iter_6_1 in ipairs((self.m_figureList:getChildren())) do
		iter_6_1:playEnter()
	end
end

function GeneChooseFigureLayer:_onFigureListItemRender(arg_7_1, arg_7_2)
	arg_7_2:updateFigureCell(arg_7_1 + 1)
end

function GeneChooseFigureLayer:_onListScroll()
	local var_8_0 = self.m_figureList:getScrollPane():getPosX()

	self.m_leftLoader:setVisible(var_8_0 > 0)
	self.m_rightLoader:setVisible(var_8_0 < (self._figureLen - 3) * 388)
end

function GeneChooseFigureLayer:_onAllAttrClick()
	self:addPopup(require("app.view.module.gene.view.GeneAttributeOverviewPop").new())
end

function GeneChooseFigureLayer:_onClickLeft()
	if self.m_figureList:getScrollPane():getPercX() > 0.1 then
		self.m_figureList:getScrollPane():scrollLeft(1, true)
	end
end

function GeneChooseFigureLayer:_onClickRight()
	if self.m_figureList:getScrollPane():getPercX() < 0.9 then
		self.m_figureList:getScrollPane():scrollRight(1, true)
	end
end

return GeneChooseFigureLayer
