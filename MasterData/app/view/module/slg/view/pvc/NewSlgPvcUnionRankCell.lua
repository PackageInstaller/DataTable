local NewSlgPvcUnionRankCell = class("NewSlgPvcUnionRankCell")

function NewSlgPvcUnionRankCell:ctor()
	self._rankController = self:getController("rank")
	self._effHolder = self:getChild("Comp_Eff")
end

function NewSlgPvcUnionRankCell:updateNewSlgPvcUnionRankCell(arg_2_1, arg_2_2)
	if self._effHolder then
		self._effHolder:removeAllEffect()

		if arg_2_1.rank == 2 then
			self._effHolder:addEffect({
				name = "effect_wdzy_dierming"
			})
		elseif arg_2_1.rank == 3 then
			self._effHolder:addEffect({
				name = "effect_wdzy_disanming"
			})
		end
	end

	self:getChild("Comp_rank"):updateRankIndex({
		rank = arg_2_1.rank
	})

	if self._rankController then
		if arg_2_1.rank < 4 then
			self:setCtrlState("rank", {
				index = arg_2_1.rank - 2
			})
		else
			self:setCtrlState("rank", {
				index = 2
			})
		end
	end

	local var_2_0 = g.core.common.GlobalFunc.rankUnit_param(arg_2_1.param, "NewSlgAlliRankData", true)

	self:getChild("Txt_score"):setText(var_2_0.score)
	self:getChild("Txt_Unionname"):setText(var_2_0.name)
	self:getChild("Txt_name"):updateQualityTxtForce({
		quality = g.core.common.Goods:convert({
			type = g.core.common.Goods.TYPE_KNIGHT,
			value = var_2_0.leader_user.base_id
		}).quality,
		text = var_2_0.leader_user.name,
		isDark = not arg_2_2
	})
	self:getChild("Icon_rank"):update({
		data = var_2_0,
		cb = handler(self, self.onIconClick)
	})

	self._alliId = var_2_0.id
end

function NewSlgPvcUnionRankCell:onIconClick()
	if self._alliId then
		g.core.module.ModuleManager:pushModule(g.view.entrance.ALLIANCE_INFO, {
			id = self._alliId
		})
	end
end

return NewSlgPvcUnionRankCell
