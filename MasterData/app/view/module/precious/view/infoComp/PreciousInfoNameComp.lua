local PreciousInfoNameComp = class("PreciousInfoNameComp", require("app.fairyGUI.precious.UI_PreciousInfoNameComp"))

function PreciousInfoNameComp:ctor()
	self:_initBtn()
end

function PreciousInfoNameComp:onLoad()
	self:updateView()
end

function PreciousInfoNameComp:_initBtn()
	self.m_touchRect:addClickListener(handler(self, self._onAddPieceClick))
	self.m_pieceAddBtn:addClickListener(handler(self, self._onAddPieceClick))
end

function PreciousInfoNameComp:setData(arg_4_1)
	self._preciousData = arg_4_1

	self:updateView()
end

function PreciousInfoNameComp:updateView()
	if not self._preciousData then
		return
	end

	local var_5_0 = self._preciousData:getCfg()

	self.m_nameComp:updateNameComp({
		maxStar = 7,
		name = var_5_0.name,
		quality = var_5_0.quality,
		curStar = self._preciousData:getStar()
	})
	self.m_nameComp:setStarVisible(self._preciousData:isOwn())

	if self._preciousData:isMaxStar() then
		self.m_maxController:setSelectedIndex(1)
	else
		self.m_maxController:setSelectedIndex(0)

		if self._preciousData:isOwn() then
			local var_5_1 = g.core.model.User.fragmentsData:getFragmentNumById(var_5_0.fragment_id)

			self.m_haveNumTxt:setText(var_5_1)
			self.m_needNumTxt:setText("/" .. var_5_0.next_star_num)
			self.m_pieceProgBar:setMax(var_5_0.next_star_num)
			self.m_pieceProgBar:setValue(var_5_1)
		else
			local var_5_2 = g.core.model.User.fragmentsData:getFragmentNumById(var_5_0.fragment_id)
			local var_5_3 = g.core.config.fragment_info.get(var_5_0.fragment_id).combine_num

			self.m_haveNumTxt:setText(var_5_2)
			self.m_needNumTxt:setText("/" .. var_5_3)
			self.m_pieceProgBar:setMax(var_5_3)
			self.m_pieceProgBar:setValue(var_5_2)
		end

		self.m_fragIcon:setURL((g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_FRAGMENT, var_5_0.fragment_id, true)))
		self.m_fragName:setText(g.core.config.fragment_info.get(var_5_0.fragment_id).name)
	end
end

function PreciousInfoNameComp:_onAddPieceClick()
	local var_6_0 = self._preciousData:getCfg()

	g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
		type = g.core.common.Goods.TYPE_FRAGMENT,
		value = var_6_0.fragment_id,
		size = g.core.model.User.bagData:getOwnNum(g.core.common.Goods.TYPE_FRAGMENT, var_6_0.fragment_id)
	})
end

return PreciousInfoNameComp
