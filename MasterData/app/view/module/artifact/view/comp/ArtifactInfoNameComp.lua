local ArtifactConst = require("app.view.module.artifact.const.ArtifactConst")
local ArtifactInfoNameComp = class("ArtifactInfoNameComp", require("app.fairyGUI.artifact.UI_ArtifactInfoNameComp"))

function ArtifactInfoNameComp:ctor()
	self:_initBtn()
end

function ArtifactInfoNameComp:onLoad()
	self:updateView()
end

function ArtifactInfoNameComp:_initBtn()
	self.m_touchRect:addClickListener(handler(self, self._onAddPieceClick))
	self.m_pieceAddBtn:addClickListener(handler(self, self._onAddPieceClick))
end

function ArtifactInfoNameComp:setData(arg_4_1)
	self._artifactData = arg_4_1

	self:updateView()
end

function ArtifactInfoNameComp:updateView()
	if not self._artifactData then
		return
	end

	local var_5_0 = self._artifactData:getCfg()

	self.m_nameComp:updateNameComp({
		name = self._artifactData:getArtifactName(),
		quality = self._artifactData:getQuality(),
		maxStar = self._artifactData:getMaxStar(),
		curStar = self._artifactData:getStar()
	})

	if self._artifactData:isMaxStar() then
		self.m_maxController:setSelectedIndex(1)
	else
		self.m_maxController:setSelectedIndex(0)

		if self._artifactData:isOwn() then
			local var_5_1, var_5_2, var_5_3 = self._artifactData:canStarUp()

			self.m_haveNumTxt:setText(var_5_3)
			self.m_needNumTxt:setText("/" .. var_5_2)
			self.m_pieceProgBar:setMax(var_5_2)
			self.m_pieceProgBar:setValue(var_5_3)
		else
			local var_5_4, var_5_5, var_5_6 = self._artifactData:canCompose()

			self.m_haveNumTxt:setText(var_5_6)
			self.m_needNumTxt:setText("/" .. var_5_5)
			self.m_pieceProgBar:setMax(var_5_5)
			self.m_pieceProgBar:setValue(var_5_6)
		end

		self.m_fragIcon:setURL((g.core.common.Path:getIconByTypeValue(g.core.common.Goods.TYPE_FRAGMENT, var_5_0.fragment_id)))
		self.m_fragName:setText(g.core.config.fragment_info.get(var_5_0.fragment_id).name)
	end
end

function ArtifactInfoNameComp:_onAddPieceClick()
	local var_6_0 = self._artifactData:getCfg()

	g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
		type = g.core.common.Goods.TYPE_FRAGMENT,
		value = var_6_0.fragment_id,
		size = g.core.model.User.fragmentsData:getFragmentNumById(var_6_0.fragment_id)
	})
end

return ArtifactInfoNameComp
