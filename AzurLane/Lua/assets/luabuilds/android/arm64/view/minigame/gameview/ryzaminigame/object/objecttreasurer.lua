local var_0_0 = class("ObjectTreasureR", import("view.miniGame.gameView.RyzaMiniGame.object.TargetObject"))

function var_0_0.FirePassability(arg_1_0)
	return 2
end

function var_0_0.InitUI(arg_2_0, arg_2_1)
	arg_2_0._tf:Find("Image"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		arg_2_0:TryDrop(arg_2_1.drop, "Drop_Treasure_R")
		arg_2_0:Destroy()

		return
	end)

	return
end

function var_0_0.InitRegister(arg_4_0, arg_4_1)
	arg_4_0:Register("touch", function()
		arg_4_0:DeregisterAll()
		arg_4_0._tf:Find("Image"):GetComponent(typeof(Animator)):Play("Open")

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
