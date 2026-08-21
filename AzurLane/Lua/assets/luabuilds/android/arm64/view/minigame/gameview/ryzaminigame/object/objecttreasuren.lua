local var_0_0 = class("ObjectTreasureN", import("view.miniGame.gameView.RyzaMiniGame.object.ObjectBreakable"))

function var_0_0.InitRegister(arg_1_0, arg_1_1)
	var_0_0.super.InitRegister(arg_1_0, arg_1_1)
	arg_1_0:Register("touch", function()
		arg_1_0:DeregisterAll()
		arg_1_0._tf:Find("Image"):GetComponent(typeof(Animator)):Play("Open")

		return
	end, {
		{
			0,
			0
		}
	})

	return
end

return var_0_0
