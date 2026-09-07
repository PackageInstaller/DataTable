local FeastShip = class("FeastShip", import("model.vo.Ship"))

FeastShip.BUBBLE_TYPE_EMPTY = 0
FeastShip.BUBBLE_TYPE_GREET = 1
FeastShip.BUBBLE_TYPE_DRINK = 2
FeastShip.BUBBLE_TYPE_EAT = 3
FeastShip.BUBBLE_TYPE_DANCE = 4
FeastShip.BUBBLE_TYPE_SLEEP = 5
FeastShip.CHAT_BUBBLE_TYPE_EMPTY = 0
FeastShip.CHAT_BUBBLE_TYPE_1 = 1
FeastShip.CHAT_BUBBLE_TYPE_2 = 2

function FeastShip:Ctor(arg_1_1)
	self.tid = arg_1_1.tid

	FeastShip.super.Ctor(self, {
		id = self.tid,
		configId = ShipGroup.getDefaultShipConfig(self.tid).id,
		skin_id = self:FilterSkinId(ShipGroup.getSkinList(self.tid))
	})

	self.bubble = arg_1_1.bubble or 0
	self.speechBubble = arg_1_1.speech_bubble or 0
	self.isSpecial = false

	return
end

function FeastShip:SetSkinId(arg_2_1)
	self.skinId = arg_2_1

	self:SetIsSpecial(true)

	return
end

function FeastShip:FilterSkinId(arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		if ShipSkin.GetShopTypeIdBySkinId(iter_3_1.id, var_3_0) == 7 then
			return iter_3_1.id
		end
	end

	if #arg_3_1 > 0 then
		return arg_3_1[math.random(1, #arg_3_1)].id
	else
		return 0
	end

	return
end

function FeastShip:UpdateBubble(arg_4_1)
	self.bubble = arg_4_1

	return
end

function FeastShip:ClearBubble()
	self.bubble = 0

	return
end

function FeastShip:GetBubble()
	return self.bubble
end

function FeastShip:HasBubble()
	return self.bubble ~= 0
end

function FeastShip:UpdateSpeechBubble(arg_8_1)
	self.speechBubble = arg_8_1

	return
end

function FeastShip:SetIsSpecial(arg_9_1)
	self.isSpecial = arg_9_1

	return
end

function FeastShip:IsSpecial()
	return self.isSpecial
end

return FeastShip
