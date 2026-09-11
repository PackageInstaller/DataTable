local GotoJump = class("GotoJump", BaseGoto)

function GotoJump:Go(arg_1_1, ...)
	JumpTools.JumpToPage2(...)
end

return GotoJump
