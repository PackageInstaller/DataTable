local VotePreRaceShipPage = class("VotePreRaceShipPage", import("....base.BaseSubView"))

function VotePreRaceShipPage:getUIName()
	return "PreRaceShips"
end

function VotePreRaceShipPage:OnInit()
	self.scrollRect = self._tf:GetComponent("LScrollRect")
	self.voteItems = {}

	function self.scrollRect.onInitItem(arg_3_0)
		self:onInitItem(arg_3_0)

		return
	end

	function self.scrollRect.onUpdateItem(arg_4_0, arg_4_1)
		self:onUpdateItem(arg_4_0, arg_4_1)

		return
	end

	function self.scrollRect.onReturnItem(arg_5_0, arg_5_1)
		self:onReturnItem(arg_5_0, arg_5_1)

		return
	end

	self._tf:SetAsFirstSibling()

	return
end

function VotePreRaceShipPage:onInitItem(arg_6_1)
	local var_6_0 = VoteShipItem.New(arg_6_1)

	onButton(self, var_6_0.go, function()
		if self.phase == VoteGroup.VOTE_STAGE then
			self.CallBack(var_6_0)
		end

		return
	end, SFX_PANEL)

	self.voteItems[arg_6_1] = var_6_0

	return
end

function VotePreRaceShipPage:SetCallBack(arg_8_1)
	self.CallBack = arg_8_1

	return
end

function VotePreRaceShipPage:onUpdateItem(arg_9_1, arg_9_2)
	local var_9_0 = self.voteItems[arg_9_2]

	if not self.voteItems[arg_9_2] then
		self:onInitItem(arg_9_2)

		var_9_0 = self.voteItems[arg_9_2]
	end

	self:UpdateShip(arg_9_1, var_9_0, self.displays[arg_9_1 + 1])

	return
end

function VotePreRaceShipPage:UpdateShip(arg_10_1, arg_10_2, arg_10_3)
	if self.phase ~= VoteGroup.VOTE_STAGE then
		local var_10_0 = self.voteGroup:GetRank(arg_10_3)
		local var_10_1, var_10_2 = self.voteGroup:CanRankToNextTurn(var_10_0)

		arg_10_2:update(arg_10_3, {
			rank = var_10_0,
			riseFlag = var_10_1,
			resurgenceFlag = var_10_2
		})
	else
		arg_10_2:update(arg_10_3, nil)
	end

	return
end

function VotePreRaceShipPage:onReturnItem(arg_11_1, arg_11_2)
	if self.exited then
		return
	end

	if self.voteItems[arg_11_2] then
		self.voteItems[arg_11_2]:clear()
	end

	return
end

function VotePreRaceShipPage:Update(arg_12_1, arg_12_2)
	self.voteGroup = arg_12_1
	self.phase = arg_12_1:GetStage()
	self.displays = arg_12_2

	self:UpdateShips()
	self:Show()

	return
end

function VotePreRaceShipPage:UpdateShips()
	if self.phase == VoteGroup.VOTE_STAGE then
		shuffle(self.displays)
	end

	self.scrollRect:SetTotalCount(#self.displays)

	return
end

function VotePreRaceShipPage:OnDestroy()
	return
end

return VotePreRaceShipPage
