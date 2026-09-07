local VoteShipItem = class("VoteShipItem")

function VoteShipItem:Ctor(arg_1_1)
	self.go = arg_1_1
	self.tf = arg_1_1.transform
	self.icon = findTF(self.tf, "mask/icon")
	self.name = findTF(self.tf, "name/Text"):GetComponent("ScrollText")
	self.rank = findTF(self.tf, "Text"):GetComponent("RichText")
	self.riseNext = findTF(self.tf, "rise_next")
	self.riseResurgence = findTF(self.tf, "rise_resurgence")

	ClearTweenItemAlphaAndWhite(self.go)

	return
end

function VoteShipItem:update(arg_2_1, arg_2_2)
	TweenItemAlphaAndWhite(self.go)

	if self.voteShip ~= arg_2_1 then
		self.voteShip = arg_2_1

		self:flush()
	end

	self.rank.text = self:wrapRankTxt(arg_2_2 and arg_2_2.rank)

	if not IsNil(self.riseNext) then
		setActive(self.riseNext, arg_2_2 and arg_2_2.riseFlag)
	end

	if not IsNil(self.riseResurgence) then
		setActive(self.riseResurgence, arg_2_2 and arg_2_2.resurgenceFlag)
	end

	return
end

function VoteShipItem:flush()
	LoadSpriteAsync("ShipYardIcon/" .. self.voteShip:getPainting(), function(arg_4_0)
		if IsNil(self.icon) then
			return
		end

		setImageSprite(self.icon, arg_4_0, false)

		return
	end)

	if PLATFORM_CODE == PLATFORM_US then
		self.name:SetText(self.voteShip:getShipName())
	else
		setText(go(self.name), shortenString(self.voteShip:getShipName(), 5))
	end

	return
end

local var_0_1 = {
	"st",
	"nd",
	"rd"
}

function VoteShipItem:wrapRankTxt(arg_5_1)
	if arg_5_1 and arg_5_1 <= 3 then
		return string.format("<material=gradient from=#FF8c1c to=#ff0000 x=0 y=-1>%s<size=30>%s</size></material>", arg_5_1, var_0_1[arg_5_1])
	else
		return ""
	end

	return
end

function VoteShipItem:clear()
	ClearTweenItemAlphaAndWhite(self.go)

	return
end

return VoteShipItem
