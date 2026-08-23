local ProtoHandler = import(".ProtoHandler")

return {
	on_S2C_KSoul_Info = function(arg_1_0, arg_1_1, arg_1_2)
		if ProtoHandler:onMsgProcess(arg_1_1, arg_1_2) then
			g.core.model.User.knightSoulData:updateKnightSoulData(arg_1_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_K_SOUL_INFO, false, arg_1_1, arg_1_2)
		end
	end,
	on_S2C_KSoul_ChapterInfo = function(arg_2_0, arg_2_1, arg_2_2)
		if ProtoHandler:onMsgProcess(arg_2_1, arg_2_2) then
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_K_SOUL_CHAPTERINFO, false, arg_2_1, arg_2_2)
		end
	end,
	on_S2C_KSoul_BookActivate = function(arg_3_0, arg_3_1, arg_3_2)
		if ProtoHandler:onMsgProcess(arg_3_1, arg_3_2) then
			g.core.model.User.knightSoulData:recvBookActivate(arg_3_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_K_SOUL_BOOKACTIVATE, false, arg_3_1, arg_3_2)
		end
	end,
	on_S2C_KSoul_BookUpgrade = function(arg_4_0, arg_4_1, arg_4_2)
		if ProtoHandler:onMsgProcess(arg_4_1, arg_4_2) then
			g.core.model.User.knightSoulData:recvBookStarUp(arg_4_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_K_SOUL_BOOKUPGRADE, false, arg_4_1, arg_4_2)
		end
	end,
	on_S2C_KSoul_HonorAdvance = function(arg_5_0, arg_5_1, arg_5_2)
		if ProtoHandler:onMsgProcess(arg_5_1, arg_5_2) then
			g.core.model.User.knightSoulData:resKSoulHonor(arg_5_2.honor_id)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_K_SOUL_HONORADVANCE, false, arg_5_1, arg_5_2)
		end
	end,
	on_S2C_KSoul_DrawInfo = function(arg_6_0, arg_6_1, arg_6_2)
		if ProtoHandler:onMsgProcess(arg_6_1, arg_6_2) then
			g.core.model.User.knightSoulData:resKSoulRecruitInfo(arg_6_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_K_SOUL_DRAWINFO, false, arg_6_1, arg_6_2)
		end
	end,
	on_S2C_KSoul_Draw = function(arg_7_0, arg_7_1, arg_7_2)
		if ProtoHandler:onMsgProcess(arg_7_1, arg_7_2) then
			g.core.model.User.knightSoulData:resKSoulDraw(arg_7_2)
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NET_S2C_K_SOUL_DRAW, false, arg_7_1, arg_7_2)
		end
	end
}
