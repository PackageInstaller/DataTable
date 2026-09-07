local InstagramPlayerComment = class("InstagramPlayerComment", import(".InstagramComment"))

function InstagramPlayerComment:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	InstagramPlayerComment.super.Ctor(self, arg_1_1, arg_1_2, arg_1_3, arg_1_4)

	if type(arg_1_1.npc_reply) == "table" then
		for iter_1_0, iter_1_1 in ipairs(arg_1_1.npc_reply) do
			table.insert(self.replyList, (InstagramNpcComment.New(self.allReply[iter_1_1], arg_1_2, self.level + 1, self)))
		end
	elseif arg_1_1.npc_reply ~= 0 then
		table.insert(self.replyList, (InstagramNpcComment.New(self.allReply[arg_1_1.npc_reply], arg_1_2, self.level + 1, self)))
	end

	return
end

function InstagramPlayerComment:GetName()
	return getProxy(PlayerProxy):getData().name
end

function InstagramPlayerComment:GetPainting()
	return "ui/InstagramUI_atlas", "txdi_3"
end

function InstagramPlayerComment:GetType()
	return Instagram.TYPE_PLAYER_COMMENT
end

return InstagramPlayerComment
