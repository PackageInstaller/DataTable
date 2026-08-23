local NewSlgBountyTaskRewardCell = class("NewSlgBountyTaskRewardCell")

function NewSlgBountyTaskRewardCell:ctor()
	self._iconComp = self:getChild("iconComp")
	self._isGetReward = self:getController("isGetReward")
end

function NewSlgBountyTaskRewardCell:updateIcon(arg_2_1, arg_2_2)
	if not arg_2_1 then
		return
	end

	self._iconComp:updateIcon(arg_2_1)
	self._isGetReward:setSelectedIndex(arg_2_2 and 1 or 0)
end

return NewSlgBountyTaskRewardCell
