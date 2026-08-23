local var_0_0 = g.core.const.ConstMgr.NewSlgConst
local var_0_1 = g.core.model.User.newSlgData
local NewSlgPvcLastDayUserRankComp = class("NewSlgPvcLastDayUserRankComp")

function NewSlgPvcLastDayUserRankComp:ctor()
	self._rankList = self:getChild("List_rank")

	self._rankList:setVirtual()
	self._rankList:setItemRenderer(handler(self, self._onRankItemRender))
	self:getChild("Btn_look"):addClickListener(handler(self, self.onRankClick))
end

function NewSlgPvcLastDayUserRankComp:updateRankView(arg_2_1, arg_2_2)
	self._rankUnits = arg_2_1.rank_units

	if arg_2_1.rank_units and #arg_2_1.rank_units > 0 then
		self._rankList:setNumItems(#arg_2_1.rank_units)
		self:setCtrlState("empty", {
			index = 1
		})
	else
		self:setCtrlState("empty", {
			index = 0
		})
	end

	local var_2_0 = arg_2_1.self_unit
	local var_2_1 = arg_2_1.self_unit.rank > 0 and var_2_0.rank < var_0_1:getNewSlgParamsValueById(arg_2_2)

	self:getController("inRank"):setSelectedIndex(var_2_1 and 1 or 0)

	if var_2_1 then
		self:getChild("rankTxt"):setText(g.core.lang:get(420661, {
			rank = var_2_0.rank
		}))
	else
		self:getChild("rankTxt"):setText(g.core.lang:get(302501))
	end

	self:getChild("Txt_score"):setText(var_2_0.score)
	self:getChild("Txt_commandValue"):setText(var_2_0.param or 0)
end

function NewSlgPvcLastDayUserRankComp:_onRankItemRender(arg_3_1, arg_3_2)
	arg_3_2:updateNewSlgPvcRankCell(self._rankUnits[arg_3_1 + 1], arg_3_1)
end

function NewSlgPvcLastDayUserRankComp:onRankClick()
	g.core.module.ModuleManager:pushModule(g.view.entrance.NEW_SLG_RANK, {
		rankType = var_0_0.RANK_TYPE.PERSONAL_ALL
	})
end

return NewSlgPvcLastDayUserRankComp
