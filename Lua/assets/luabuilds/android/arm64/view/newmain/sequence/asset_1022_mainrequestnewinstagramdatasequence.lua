local MainRequestNewInstagramDataSequence = class("MainRequestNewInstagramDataSequence")

function MainRequestNewInstagramDataSequence:Execute(arg_1_1)
	if getProxy(InstagramProxy):IsReqNewInstagramData() then
		arg_1_1()

		return
	end

	local var_1_0 = getProxy(InstagramProxy)

	pg.m02:sendNotification(GAME.REQ_NEW_INSTAGRAM_DATA, {
		idList = var_1_0:GetNewInstagramIds(),
		callback = arg_1_1
	})

	return
end

return MainRequestNewInstagramDataSequence
