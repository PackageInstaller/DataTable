local var_0_0 = g.core.config.gene_segment_info
local var_0_1 = g.core.const.ConstMgr.GeneConst
local var_0_2 = g.core.model.User.geneData
local var_0_3 = g.core.common.Path
local var_0_4 = g.core.lang
local var_0_5 = g.core.model.User.bagData
local GeneWaferDetailsPop = class("GeneWaferDetailsPop", require("app.fairyGUI.gene.UI_GeneWaferDetailsPop"), function()
	return fgui.GComponent:create({
		resName = "GeneWaferDetailsPop",
		pkgPath = "ui/gene/gene",
		pkgName = "gene"
	}, ...)
end)

function GeneWaferDetailsPop:ctor(arg_2_1)
	self:showAtCenter()

	self._geneId = arg_2_1.geneId
	self._fragId = arg_2_1.id
	self._x = arg_2_1.x
	self._y = arg_2_1.y

	self.m_activateBtn:addClickListener(handler(self, self._onClickActivateBtn))
end

function GeneWaferDetailsPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GENE_ACTIVATESEGMENT, self._onS2CGeneActivateSegment, self)
	self:_updateDetailsInfo()
end

function GeneWaferDetailsPop:onUnload()
	g.core.event.EventManager:removeListenerWithTarget(self)
end

function GeneWaferDetailsPop:_updateDetailsInfo()
	local var_5_0 = var_0_0.get(self._fragId)

	self.m_waferIconLoader:setURL((var_0_3:getGeneFragIconByType(var_5_0.type, 1)))
	self.m_waferNameTxt:setText(var_0_1.SEGMENT_NAME[var_5_0.type])

	local var_5_1 = var_0_2:getFragAttr(var_5_0.gene_id, var_5_0.type)
	local var_5_2, var_5_3 = var_0_4:getAttr(var_5_1.attribute_type, var_5_1.attribute_value)
	local var_5_4, var_5_5 = var_0_4:getAttr(var_5_1.attribute_1_type, var_5_1.attribute_1_value)
	local var_5_6, var_5_7 = var_0_4:getAttr(var_5_1.attribute_2_type, var_5_1.attribute_2_value)

	self.m_activateNameTxt:setText(var_5_2)
	self.m_activateValueTxt:setText(var_5_3)
	self.m_extraNameTxt1:setText(var_5_4)
	self.m_extraValueTxt1:setText(var_5_5)
	self.m_extraNameTxt2:setText(var_5_6)
	self.m_extraValueTxt2:setText(var_5_7)

	local var_5_8 = var_0_2:getFragActivatedState(self._geneId, self._x, self._y)

	self.m_isActivateController:setSelectedIndex(var_5_8 > 0 and 1 or 0)

	if var_5_8 == 2 then
		self.m_linkStateController:setSelectedIndex(1)
	elseif var_5_8 == 3 then
		self.m_linkStateController:setSelectedIndex(2)
	else
		self.m_linkStateController:setSelectedIndex(0)
	end

	if var_5_8 == 0 then
		local var_5_9 = var_0_2:getActivateFragCostCfg(self._geneId)

		if not var_5_9 then
			return
		end

		local var_5_10 = var_0_5:getOwnNum(var_5_9.material_1_type, var_5_9.material_1_value)

		if var_5_9.material_1_size == 0 then
			self.m_costLoader:setVisible(false)
			self.m_haveCountTxt:setText(g.core.lang:get(409807))
			self.m_costCountTxt:setText("")
		else
			self.m_costLoader:setURL((var_0_3:getIconByTypeValue(var_5_9.material_1_type, var_5_9.material_1_value, true)))
			self.m_costLoader:setVisible(true)
			self.m_haveCountTxt:setText(var_5_10)
			self.m_costCountTxt:setText("/" .. var_5_9.material_1_size)
		end

		self._canActivate = var_5_10 >= var_5_9.material_1_size
	end
end

function GeneWaferDetailsPop:_onClickActivateBtn()
	if self._canActivate then
		var_0_2:setPreGeneAttr((var_0_2:getGeneAttr(var_0_0.get(self._fragId).gene_id)))
		g.core.network.GameNetProxy:send_C2S_Gene_ActivateSegment({
			base_id = self._fragId
		})
	elseif var_0_2:getFragActivatedState(self._geneId, self._x, self._y) == 0 then
		local var_6_0 = var_0_2:getActivateFragCostCfg(self._geneId)

		g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
			type = var_6_0.material_1_type,
			value = var_6_0.material_1_value,
			size = var_0_5:getOwnNum(var_6_0.material_1_type, var_6_0.material_1_value)
		})
	end
end

function GeneWaferDetailsPop:_onS2CGeneActivateSegment(arg_7_1, arg_7_2, arg_7_3)
	self:_onCloseSelf()
end

function GeneWaferDetailsPop:_onCloseSelf()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

return GeneWaferDetailsPop
