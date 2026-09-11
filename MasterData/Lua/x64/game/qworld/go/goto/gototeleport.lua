local GotoJump = class("GotoJump", BaseGoto)

function GotoJump:Go(arg_1_1, arg_1_2, arg_1_3)
	QWorldTeleport(arg_1_2[1])
end

return GotoJump
