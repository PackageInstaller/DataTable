local var_0_0 = class("EffectLaser", import("view.miniGame.gameView.RyzaMiniGame.effect.TargetEffect"))

function var_0_0.GetBaseOrder(arg_1_0)
	if arg_1_0.mark == "N" then
		return var_0_0.super.GetBaseOrder(arg_1_0)
	else
		return 500
	end

	return
end

function var_0_0.InitUI(arg_2_0, arg_2_1)
	arg_2_0.mark = arg_2_1.mark

	arg_2_0:UpdatePos(arg_2_0.pos)

	local var_2_0 = arg_2_0._tf:Find("scale/" .. arg_2_0.mark)

	setActive(var_2_0, true)
	var_2_0:Find("base"):GetComponent(typeof(DftAniEvent)):SetEndEvent(function()
		arg_2_0:Destroy()

		return
	end)

	if arg_2_0.responder:CollideRyza(arg_2_0) then
		arg_2_0:Calling("hit", {
			1,
			arg_2_0.realPos
		}, MoveRyza)
	end

	return
end

function var_0_0.GetCollideRange(arg_4_0)
	local var_4_0

	switch(arg_4_0.mark, {
		N = function()
			var_4_0 = {
				{
					-0.5,
					0.5
				},
				{
					-25,
					-0.5
				}
			}

			return
		end,
		S = function()
			var_4_0 = {
				{
					-0.5,
					0.5
				},
				{
					0.5,
					25
				}
			}

			return
		end,
		W = function()
			var_4_0 = {
				{
					-25,
					-0.5
				},
				{
					-0.5,
					0.5
				}
			}

			return
		end,
		E = function()
			var_4_0 = {
				{
					0.5,
					25
				},
				{
					-0.5,
					0.5
				}
			}

			return
		end
	})

	return {
		nil
	}
end

return var_0_0
