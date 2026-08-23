local var_0_0 = g.core.config.gene_info
local var_0_1 = g.core.model.User.bagData
local var_0_2 = g.core.model.User.geneData
local GeneFigureMainLayer = class("GeneFigureMainLayer", require("app.fairyGUI.gene.UI_GeneFigureMainLayer"), function()
	return fgui.GComponent:create({
		resName = "GeneFigureMainLayer",
		pkgPath = "ui/gene/gene",
		isFullScreen = true,
		pkgName = "gene"
	}, ...)
end)

function GeneFigureMainLayer:ctor(arg_2_1)
	self._geneId = arg_2_1

	self:addBg("bg/gene/bg_shengwujiexi_xulie.jpg", nil, nil, 1)
	self.m_topBarComp:setResInfoById(5000001)
	self.m_topBarComp:hidePushGift()
	self:_initRegisterListen()
end

function GeneFigureMainLayer:_initRegisterListen()
	self.m_activateBtn:addClickListener(handler(self, self._onClickActivateBtn))
	self.m_talentBtn:addClickListener(handler(self, self._onClickTalentBtn))
	self.m_titleComp:addClickListener(handler(self, self._onClickTitleComp))
	self.m_leftLoader:addClickListener(handler(self, self._onClickLeft))
	self.m_rightLoader:addClickListener(handler(self, self._onClickRight))
end

function GeneFigureMainLayer:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GENE_ACTIVATEMAP, self._onGeneActivateMap, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GENE_ACTIVATESEGMENT, self._onS2CGeneActivateSegment, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GENE_CHANGEPOSITION, self._onS2CGeneChangePosition, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_GUIDE_FINISH, self._onCheckGeneWeakGuide, self)
	self:_updateMainView()
	self:_playEneterAnim()
end

function GeneFigureMainLayer:_updateMainView()
	self._geneLen = var_0_2:getGeneLen(self._geneId)

	self.m_sizeController:setSelectedIndex(self._geneLen == 7 and 1 or 0)
	self.m_mainComp:setGeneInfo(self._geneId)
	self.m_titleComp:updateTitle(self._geneId)
	self:_updateActivateBtn()
	self:_updateArrowState()
	var_0_2:setSwapInfo(nil)
	var_0_2:setPreGeneAttr(nil)
end

function GeneFigureMainLayer:_onGeneActivateMap(arg_6_1, arg_6_2, arg_6_3)
	if arg_6_3.base_id then
		require("app.view.module.show.ShowFactory"):showGeneActivateFragment(arg_6_3.base_id, handler(self, self._updateActivateMap))
	end
end

function GeneFigureMainLayer:_updateActivateMap()
	self.m_titleComp:updateTitle(self._geneId)
	self:_updateActivateBtn()
	self:_updateArrowState()
end

function GeneFigureMainLayer:_onS2CGeneActivateSegment(arg_8_1, arg_8_2, arg_8_3)
	self:_updateActivateBtn(true)
	self:_updateArrowState()
	self.m_titleComp:updateTitle(self._geneId)
	self.m_mainComp:activateSegment(arg_8_3.base_id)
end

function GeneFigureMainLayer:_onS2CGeneChangePosition(arg_9_1, arg_9_2, arg_9_3)
	self.m_titleComp:updateTitle(self._geneId)

	local var_9_0 = var_0_2:getLinkedFrags(self._geneId, arg_9_3.base_id1)

	for iter_9_0, iter_9_1 in pairs((var_0_2:getLinkedFrags(self._geneId, arg_9_3.base_id2))) do
		var_9_0[iter_9_0] = iter_9_1
	end

	self.m_mainComp:fragmentChangePosition(var_9_0)
end

function GeneFigureMainLayer:_onClickActivateBtn()
	local var_10_0 = var_0_0.get(self._geneId)
	local var_10_1 = var_0_1:getOwnNum(var_10_0.material_type, var_10_0.material_value)

	if var_10_1 < var_10_0.material_size then
		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = var_10_0.material_type,
			value = var_10_0.material_value,
			size = var_10_1
		})
	else
		g.core.network.GameNetProxy:send_C2S_Gene_ActivateMap({
			base_id = self._geneId
		})
	end
end

function GeneFigureMainLayer:_onClickTalentBtn()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.gene.view.GeneTalentAttrPop").new()))
end

function GeneFigureMainLayer:_onClickTitleComp()
	g.core.module.ModuleManager:pushPopup((require("app.view.module.gene.view.GeneFigureAttrPop").new(self._geneId)))
end

function GeneFigureMainLayer:_onClickLeft()
	self._geneId = var_0_2:getPreGene(self._geneId)

	self:_updateMainView()
end

function GeneFigureMainLayer:_onClickRight()
	self._geneId = var_0_2:getNextGene(self._geneId)

	self:_updateMainView()
end

function GeneFigureMainLayer:_updateArrowState()
	local var_15_0 = var_0_2:getNextGene(self._geneId)

	if var_15_0 == 0 then
		self.m_rightLoader:setVisible(false)
	else
		self.m_rightLoader:setVisible(var_0_2:getGeneState(var_15_0) > 0)
	end

	self.m_leftLoader:setVisible(var_0_2:getPreGene(self._geneId) ~= nil)
end

function GeneFigureMainLayer:_updateActivateBtn(arg_16_1)
	local var_16_0 = var_0_2:getGeneFragsCntById(self._geneId) == var_0_2:getActivatedFragsCnt(self._geneId) and not var_0_2:getGeneSrvInfoById(self._geneId).is_activate

	self.m_activateBtn:setVisible(var_16_0)
	self.m_activateBtn:updateCost(self._geneId)

	if var_16_0 then
		self.m_activateBtn:playActivateAnim()

		if arg_16_1 then
			self:_playSweepAnim()
		end
	end
end

function GeneFigureMainLayer:_onCheckGeneWeakGuide()
	self.m_mainComp:checkWeakGuide()
end

function GeneFigureMainLayer:_playEneterAnim()
	self.m_enterTransition:play()
	self.m_titleComp:playEneterAnim()
	self.m_effBg:removeAllEffect()
	self.m_effBg:addEffectSpine({
		anim = "play",
		name = "eff_ui_gene_bg",
		isLoop = true
	})
end

function GeneFigureMainLayer:_playSweepAnim()
	self.m_sweepTransition:play()
	self.m_effSweep:addEffectSpine({
		remove = true,
		name = "eff_ui_gene_sweep",
		isLoop = false,
		anim = self._geneLen == 7 and "play" or "play2"
	})
end

return GeneFigureMainLayer
