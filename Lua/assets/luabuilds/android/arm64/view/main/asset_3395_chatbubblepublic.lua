local ChatBubblePublic = class("ChatBubblePublic")

function ChatBubblePublic:Ctor(arg_1_1)
	self.tf = tf(arg_1_1)
	self.richText = findTF(self.tf, "text"):GetComponent("RichText")

	local var_1_0 = findTF(self.tf, "channel")

	if not IsNil(var_1_0) then
		self.channel = var_1_0:GetComponent("Image")
	end

	return
end

function ChatBubblePublic:update(arg_2_1)
	if self.data == arg_2_1 then
		return
	end

	self.data = arg_2_1
	self.richText.supportRichText = true

	ChatProxy.InjectPublic(self.richText, arg_2_1)
	self.richText:AddListener(function(arg_3_0, arg_3_1)
		self:clickItem(arg_3_0, arg_3_1)

		return
	end)

	if self.channel then
		self.channel.sprite = GetSpriteFromAtlas("channel", ChatConst.GetChannelSprite(arg_2_1.type) .. "_1920")

		self.channel:SetNativeSize()
	end

	return
end

function ChatBubblePublic:clickItem(arg_4_1, arg_4_2)
	if arg_4_1 == "clickPlayer" then
		print("click player : ")
	elseif arg_4_1 == "clickShip" then
		print("click ship : ")
	end

	return
end

function ChatBubblePublic:dispose()
	self.richText:RemoveAllListeners()

	return
end

return ChatBubblePublic
