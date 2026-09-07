local MainServerNoticeSequence = class("MainServerNoticeSequence", import(".MainSublayerSequence"))

function MainServerNoticeSequence:Execute(arg_1_1)
	local var_1_0 = getProxy(ServerNoticeProxy)

	if #var_1_0:getServerNotices(false) > 0 and var_1_0:needAutoOpen() then
		self:AddSubLayers(Context.New({
			mediator = NewBulletinBoardMediator,
			viewComponent = NewBulletinBoardLayer,
			onRemoved = arg_1_1
		}))
	else
		arg_1_1()
	end

	return
end

return MainServerNoticeSequence
