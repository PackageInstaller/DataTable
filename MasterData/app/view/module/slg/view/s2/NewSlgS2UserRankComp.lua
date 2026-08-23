local NewSlgS2UserRankComp = class("NewSlgS2UserRankComp")

function NewSlgS2UserRankComp:ctor()
	self._listRank = self:getChild("List_rank")

	self._listRank:setVirtual(self)
	self._listRank:setItemRenderer(handler(self, self._onRenderListRankCell))

	self._compRank = self:getChild("Comp_rank")
	self._compUserIcon = self:getChild("Icon_rank")
	self._txtName = self:getChild("Txt_Name")
	self._txtCommandValue = self:getChild("Txt_commandValue")
	self._txtScore = self:getChild("Txt_score")
	self._inRankCtrl = self:getController("inRank")
	self._emptyCtrl = self:getController("empty")
end

function NewSlgS2UserRankComp:updateView(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._selfRank = arg_2_1.selfRank
	self._rankUnits = arg_2_1.rankUnits

	self:_updateList()
	self:_updateSelf()
end

function NewSlgS2UserRankComp:_updateList()
	if #self._rankUnits > 1 then
		self._emptyCtrl:setSelectedIndex(1)
		self._listRank:setNumItems(#self._rankUnits - 1)
	else
		self._emptyCtrl:setSelectedIndex(0)
	end
end

function NewSlgS2UserRankComp:_updateSelf()
	if not g.core.model.User.allianceData:hasAlliance() then
		self._inRankCtrl:setSelectedIndex(3)

		return
	end

	local var_4_0 = #self._rankUnits

	if #self._rankUnits == 0 then
		self._inRankCtrl:setSelectedIndex(2)

		return
	end

	if not self._selfRank then
		self._inRankCtrl:setSelectedIndex(2)

		return
	end

	if self._selfRank.rank ~= 0 and var_4_0 >= self._selfRank.rank then
		self._inRankCtrl:setSelectedIndex(1)
		self._compRank:updateRankIndex({
			rank = self._selfRank.rank
		})
	else
		self._inRankCtrl:setSelectedIndex(0)
	end

	local var_4_1 = self._selfRank.user

	self._compUserIcon:updateAsUser(self._selfRank.user)
	self._txtName:updateQualityTxtForce({
		isDark = true,
		quality = g.core.common.Goods:convertUserSnapshot({
			snapshot = self._selfRank.user
		}).quality,
		text = var_4_1.name
	})
	self._txtScore:setText(self._selfRank.score)
	self._txtCommandValue:setText(self._selfRank.param)
end

function NewSlgS2UserRankComp:_onRenderListRankCell(arg_5_1, arg_5_2)
	arg_5_2:updateNewSlgPvcRankCell(self._rankUnits[arg_5_1 + 2])
end

return NewSlgS2UserRankComp
