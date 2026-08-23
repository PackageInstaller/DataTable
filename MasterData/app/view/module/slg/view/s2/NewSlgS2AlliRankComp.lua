local NewSlgS2AlliRankComp = class("NewSlgS2AlliRankComp")

function NewSlgS2AlliRankComp:ctor()
	self._listRank = self:getChild("List_rank")

	self._listRank:setVirtual(self)
	self._listRank:setItemRenderer(handler(self, self._onRenderListRankCell))

	self._inRankCtrl = self:getController("inRank")
	self._emptyCtrl = self:getController("empty")
	self._compSelf = self:getChild("Comp_self")
end

function NewSlgS2AlliRankComp:updateView(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._selfRank = arg_2_1.selfRank
	self._rankUnits = arg_2_1.rankUnits

	self:_updateList()
	self:_updateSelf()
end

function NewSlgS2AlliRankComp:_updateSelf()
	if not g.core.model.User.allianceData:hasAlliance() then
		self._inRankCtrl:setSelectedIndex(3)

		return
	end

	local var_3_0 = #self._rankUnits

	if #self._rankUnits == 0 then
		self._inRankCtrl:setSelectedIndex(2)

		return
	end

	if not self._selfRank then
		self._inRankCtrl:setSelectedIndex(2)

		return
	end

	if self._selfRank.rank ~= 0 and var_3_0 >= self._selfRank.rank then
		self._inRankCtrl:setSelectedIndex(1)
	else
		self._inRankCtrl:setSelectedIndex(0)
	end

	self._compSelf:updateCell(self._selfRank, var_3_0)
end

function NewSlgS2AlliRankComp:_updateList()
	if #self._rankUnits > 1 then
		self._emptyCtrl:setSelectedIndex(1)
		self._listRank:setNumItems(#self._rankUnits - 1)
	else
		self._emptyCtrl:setSelectedIndex(0)
	end
end

function NewSlgS2AlliRankComp:_onRenderListRankCell(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._rankUnits[arg_5_1 + 2])
end

return NewSlgS2AlliRankComp
