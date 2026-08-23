local NewSlgEndShowRankCell = class("NewSlgEndShowRankCell")
local var_0_1 = g.core.common.Goods

function NewSlgEndShowRankCell:ctor()
	self._txtTitle = self:getChild("Txt_title")
	self._txtTips = self:getChild("Txt_tips")
	self._compRank = self:getChild("Comp_rank")
	self._compRes = self:getChild("Comp_res")
	self._compMileage = self:getChild("Comp_mileage")
	self._compLoss = self:getChild("Comp_loss")
	self._listReward = self:getChild("List_reward")

	self._listReward:setVirtual(self)
	self._listReward:setItemRenderer(handler(self, self._onRenderListRewardCell))

	self._imgIcon = self:getChild("Img_icon")

	self._imgIcon:setURL(g.core.common.Path:getIconByTypeValue(var_0_1.TYPE_ITEM, 11010, true))

	self._rankCtrl = self:getController("rank")
	self._typeCtrl = self:getController("type")
end

function NewSlgEndShowRankCell:updateCell(arg_2_1)
	self._rankData = arg_2_1.rankData

	self._txtTitle:setText(arg_2_1.title)
	self._compRank:updateRankIndex({
		rank = self._rankData.rank
	})

	if arg_2_1.typeCtrl == 1 then
		self._compMileage:updateView({
			num = self._rankData.num
		})
		self._compLoss:updateView({
			num = self._rankData.num2
		})
	else
		self._compRes:updateView({
			num = self._rankData.num
		})
	end

	self._awardArr = arg_2_1.awardArr

	self._listReward:setNumItems(#self._awardArr)

	if arg_2_1.icon then
		self._imgIcon:setURL(arg_2_1.icon)
	end

	self._rankCtrl:setSelectedIndex(self._rankData.rank > 0 and 0 or 1)
	self._typeCtrl:setSelectedIndex(arg_2_1.typeCtrl)
end

function NewSlgEndShowRankCell:_onRenderListRewardCell(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awardArr[arg_3_1 + 1])
end

return NewSlgEndShowRankCell
