local InstagramNpcComment = class("InstagramNpcComment", import(".InstagramComment"))
local var_0_1 = pg.activity_ins_ship_group_template

function InstagramNpcComment:Ctor(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	InstagramNpcComment.super.Ctor(self, arg_1_1, arg_1_2, arg_1_3, arg_1_4)

	self.configId = self.id

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.npc_reply) do
		assert(self.allReply[iter_1_1], iter_1_1)
		table.insert(self.replyList, InstagramNpcComment.New(self.allReply[iter_1_1], arg_1_2, self.level + 1, self))
	end

	self.config = var_0_1[self:getConfig("ship_group")]

	return
end

function InstagramNpcComment:bindConfigTable()
	return pg.activity_ins_npc_template
end

function InstagramNpcComment:GetName()
	return self.config.name
end

function InstagramNpcComment:GetPainting()
	return self.config.sculpture
end

function InstagramNpcComment:GetType()
	return Instagram.TYPE_NPC_COMMENT
end

return InstagramNpcComment
