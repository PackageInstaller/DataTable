local NewSlgS2AlliRankCell = class("NewSlgS2AlliRankCell")

function NewSlgS2AlliRankCell:ctor()
	self._compRank = self:getChild("Comp_rank")
	self._compGuildIcon = self:getChild("Comp_guildIcon")
	self._compName = self:getChild("Comp_name")
	self._txtAlliName = self:getChild("Txt_alliName")
	self._txtScore = self:getChild("Txt_score")
	self._rankCtrl = self:getController("rank")
	self._inRankCtrl = self:getController("inRank")
end

function NewSlgS2AlliRankCell:updateCell(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	local var_2_0 = arg_2_1

	if arg_2_2 and arg_2_2 < var_2_0.rank then
		self._inRankCtrl:setSelectedIndex(0)
	else
		self._inRankCtrl:setSelectedIndex(1)
		self._compRank:updateRankIndex({
			rank = var_2_0.rank
		})
	end

	local var_2_1 = g.common.GlobalFunc.rankUnit_param(var_2_0.param, "NewSlgAlliRankData", true)

	self._alliId = var_2_1.id

	self._compGuildIcon:update({
		data = var_2_1,
		cb = handler(self, self.onIconClick)
	})
	self._txtAlliName:setText(var_2_1.name)
	self._txtScore:setText(var_2_0.score)

	if var_2_1.leader_user then
		self._compName:updateQualityTxtForce({
			isDark = true,
			text = var_2_1.leader_user.name,
			quality = g.core.common.Goods:convertUserSnapshot({
				snapshot = var_2_1.leader_user
			}).quality
		})
	end
end

function NewSlgS2AlliRankCell:onIconClick()
	if self._alliId then
		g.core.module.ModuleManager:pushModule(g.view.entrance.ALLIANCE_INFO, {
			id = self._alliId
		})
	end
end

return NewSlgS2AlliRankCell
