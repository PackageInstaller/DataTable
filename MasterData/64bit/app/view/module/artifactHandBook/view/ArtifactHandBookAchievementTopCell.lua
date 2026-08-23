local var_0_0 = g.core.config.artifact_compose_score_info
local var_0_1 = g.core.model.User.artifactHandBookData
local ArtifactHandBookAchievementTopCell = class("ArtifactHandBookAchievementTopCell", require("app.fairyGUI.artifactHandbook.UI_ArtifactHandBookAchievementTopCell"))

function ArtifactHandBookAchievementTopCell:ctor()
	self._bookAttr = {}
	self._scoreAttr = {}
	self._curLevel = 0

	self.m_attrLevelAddList:setVirtual()
	self.m_attrLevelAddList:setItemRenderer(handler(self, self._onBookValueAttrListRender))
	self.m_attrAddList:setVirtual()
	self.m_attrAddList:setItemRenderer(handler(self, self._onBookAttrAddListRender))
end

function ArtifactHandBookAchievementTopCell:_updateAttrData()
	self._bookAttr = var_0_1:getTotalURArtifactBookAttr()
	self._scoreAttr = var_0_1:getTotalBookActivateAttr()

	if #self._bookAttr > 0 then
		self.m_attrAddList:setNumItems(#self._bookAttr)
		self.m_attrAddList:setHeight(math.ceil(#self._bookAttr / 2) * 33 + 10)
		self.m_hadAdditionController:setSelectedIndex(1)
	else
		self.m_hadAdditionController:setSelectedIndex(0)
	end

	local var_2_0 = #self._scoreAttr

	if #self._scoreAttr > 0 then
		self.m_attrLevelAddList:setNumItems(var_2_0)
		self.m_attrLevelAddList:setHeight(math.ceil(var_2_0 / 2) * 33 + 10)
		self.m_valueAdditionController:setSelectedIndex(1)
	else
		self.m_valueAdditionController:setSelectedIndex(0)
	end
end

function ArtifactHandBookAchievementTopCell:updateArtifactAchievementCell()
	self:_setProgressShow()
	self:_updateAdditionList()
	self:_updateAttrData()
end

function ArtifactHandBookAchievementTopCell:_onBookAttrAddListRender(arg_4_1, arg_4_2)
	arg_4_2:setWidth(248)
	arg_4_2:updateAttr({
		isAll = true,
		type = self._bookAttr[arg_4_1 + 1].attrId,
		value = self._bookAttr[arg_4_1 + 1].attrValue
	})
end

function ArtifactHandBookAchievementTopCell:_onBookValueAttrListRender(arg_5_1, arg_5_2)
	arg_5_2:setWidth(248)
	arg_5_2:updateAttr({
		isAll = true,
		type = self._scoreAttr[arg_5_1 + 1].attrId,
		value = self._scoreAttr[arg_5_1 + 1].attrValue
	})
end

function ArtifactHandBookAchievementTopCell:_setProgressShow()
	local var_6_0 = var_0_1:getURHandBookScore()
	local var_6_1 = var_0_1:getCurAndNextScoreInfo()
	local var_6_2 = 0
	local var_6_3 = 0
	local var_6_4 = 0

	if not var_6_1.cur then
		var_6_4 = 0
		var_6_3 = var_6_0
		var_6_2 = var_6_1.next.score
	elseif not var_6_1.next then
		var_6_4 = var_6_1.cur.id
		var_6_3 = var_6_1.cur.score
		var_6_2 = var_6_1.cur.score
	else
		var_6_4 = var_6_1.cur.id
		var_6_3 = var_6_0 - var_6_1.cur.score
		var_6_2 = var_6_1.next.score - var_6_1.cur.score
	end

	self.m_levelTxt:setText(var_6_4)

	self._curLevel = var_6_4

	self.m_processTxt:setText(g.core.lang:get(111510, {
		frontNum = var_6_3,
		behindNum = var_6_2
	}))
	self.m_processBar:setMax(var_6_2)
	self.m_processBar:setValue(var_6_3)
end

function ArtifactHandBookAchievementTopCell:_updateAdditionList()
	if var_0_0.getLength() < self._curLevel + 1 then
		self.m_stateController:setSelectedIndex(1)
	else
		self.m_nextAddComp:updateNextAttrShow()
		self.m_stateController:setSelectedIndex(0)
	end
end

return ArtifactHandBookAchievementTopCell
