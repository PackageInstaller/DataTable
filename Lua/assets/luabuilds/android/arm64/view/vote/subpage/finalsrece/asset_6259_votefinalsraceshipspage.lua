local VoteFinalsRaceShipsPage = class("VoteFinalsRaceShipsPage", import("....base.BaseSubView"))

function VoteFinalsRaceShipsPage:getUIName()
	return "FinalsRaceShips"
end

function VoteFinalsRaceShipsPage:OnLoaded()
	self.num1TF = self._tf:Find("content/head/num1")
	self.num2TF = self._tf:Find("content/head/num2")
	self.num3TF = self._tf:Find("content/head/num3")
	self.UIlist = UIItemList.New(self._tf:Find("content/ships"), self._tf:Find("content/ships/ship_tpl"))

	return
end

function VoteFinalsRaceShipsPage:SetCallBack(arg_3_1)
	self.CallBack = arg_3_1

	return
end

function VoteFinalsRaceShipsPage:Update(arg_4_1, arg_4_2, arg_4_3)
	self.voteGroup = arg_4_1
	self.count = arg_4_3
	self.phase = arg_4_1:GetStage()
	self.displays = {}
	self.topList = {}

	local var_4_0 = arg_4_1:GetRankList()

	for iter_4_0, iter_4_1 in ipairs(arg_4_2) do
		if iter_4_1.group == var_4_0[1].group or iter_4_1.group == var_4_0[2].group or iter_4_1.group == var_4_0[3].group then
			table.insert(self.topList, iter_4_1)
		else
			table.insert(self.displays, iter_4_1)
		end
	end

	self:UpdateTop3(var_4_0[1], var_4_0[2], var_4_0[3])
	self:UpdateShips()
	self:Show()

	return
end

function VoteFinalsRaceShipsPage:UpdateTop3(arg_5_1, arg_5_2, arg_5_3)
	self:UpdateVoteShip(self.num1TF, arg_5_1)
	self:UpdateVoteShip(self.num2TF, arg_5_2)
	self:UpdateVoteShip(self.num3TF, arg_5_3)
	setActive(self.num1TF, _.any(self.topList, function(arg_6_0)
		return arg_6_0.group == arg_5_1.group
	end))
	setActive(self.num2TF, _.any(self.topList, function(arg_7_0)
		return arg_7_0.group == arg_5_2.group
	end))
	setActive(self.num3TF, _.any(self.topList, function(arg_8_0)
		return arg_8_0.group == arg_5_3.group
	end))

	return
end

function VoteFinalsRaceShipsPage:UpdateShips()
	self.UIlist:make(function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_0 == UIItemList.EventUpdate then
			local var_10_0 = VoteShipItem.New(arg_10_2)

			var_10_0:update(self.displays[arg_10_1 + 1])
			onButton(self, var_10_0.go, function()
				if self.CallBack and self.phase == VoteGroup.VOTE_STAGE then
					self.CallBack(var_10_0, var_10_0.voteShip.votes)
				end

				return
			end, SFX_PANEL)
		end

		return
	end)
	self.UIlist:align(math.max(#self.displays, 0))

	return
end

function VoteFinalsRaceShipsPage:contains(arg_12_1, arg_12_2)
	return _.any(arg_12_1, function(arg_13_0)
		return arg_13_0.group == arg_12_2.group
	end)
end

function VoteFinalsRaceShipsPage:UpdateVoteShip(arg_14_1, arg_14_2)
	if not arg_14_2 then
		setActive(arg_14_1, false)

		return
	end

	setText(arg_14_1:Find("name"), shortenString(arg_14_2:getShipName(), 5))
	self:LoadPainting(arg_14_1:Find("mask"), (arg_14_2:getPainting()))
	onButton(self, arg_14_1, function()
		if self.CallBack and self.phase == VoteGroup.VOTE_STAGE then
			self.CallBack({
				voteShip = arg_14_2
			}, arg_14_2.votes)
		end

		return
	end, SFX_PANEL)

	return
end

function VoteFinalsRaceShipsPage:LoadPainting(arg_16_1, arg_16_2)
	LoadSpriteAsync("VoteShips/" .. arg_16_2, function(arg_17_0)
		setImageSprite(arg_16_1:Find("icon"), arg_17_0, false)

		return
	end)

	return
end

function VoteFinalsRaceShipsPage:OnDestroy()
	return
end

return VoteFinalsRaceShipsPage
