local var_0_0 = class("EffectFire", import("view.miniGame.gameView.RyzaMiniGame.effect.TargetEffect"))

function var_0_0.GetBaseOrder(arg_1_0)
	return "floor"
end

local var_0_1 = {
	"S",
	"E",
	"N",
	"W"
}

function var_0_0.InitUI(arg_2_0, arg_2_1)
	arg_2_0.power = arg_2_1.power

	eachChild(arg_2_0._tf, function(arg_3_0)
		setActive(arg_3_0, arg_3_0.name == "C")

		return
	end)

	local var_2_0 = arg_2_0._tf:Find("C/Image"):GetComponent(typeof(DftAniEvent))

	var_2_0:SetTriggerEvent(function()
		arg_2_0.triggerCount = defaultValue(arg_2_0.triggerCount, 0) + 1

		switch(arg_2_0.triggerCount, {
			function()
				local var_5_0, var_5_1, var_5_2 = arg_2_0.responder:GetCrossFire(arg_2_0.pos, arg_2_0.power)

				for iter_5_0, iter_5_1 in ipairs(var_5_0) do
					local var_5_3 = arg_2_0._tf:Find(var_0_1[iter_5_0])

					for iter_5_2 = var_5_3.childCount + 1, iter_5_1 do
						local var_5_4 = cloneTplTo(var_5_3:Find("7"), var_5_3, iter_5_2)

						if iter_5_0 < 3 then
							var_5_4:SetAsLastSibling()
						end
					end

					for iter_5_3 = 1, var_5_3.childCount do
						setActive(var_5_3:Find(iter_5_3), iter_5_3 <= iter_5_1)
					end

					setActive(var_5_3, true)
				end

				arg_2_0:Calling("burn", {}, var_5_1)

				arg_2_0.lenList = var_5_0

				arg_2_0:Register("move", function(arg_6_0)
					arg_2_0:Calling("burn", {}, arg_6_0)

					return
				end, var_5_1)

				for iter_5_4, iter_5_5 in pairs(var_5_2) do
					arg_2_0:Calling("block", {
						iter_5_5[2]
					}, iter_5_5[1])
				end

				return
			end,
			function()
				arg_2_0.lenList = nil

				arg_2_0:Deregister("move")

				return
			end
		})

		return
	end)
	var_2_0:SetEndEvent(function()
		arg_2_0:Destroy()

		return
	end)
	pg.CriMgr.GetInstance():PlaySoundEffect_V3("ui-ryza-minigame-bomb")

	return
end

function var_0_0.GetCollideRange(arg_9_0)
	if arg_9_0.lenList then
		return {
			{
				{
					-0.5 - arg_9_0.lenList[4],
					0.5 + arg_9_0.lenList[2]
				},
				{
					-0.5,
					0.5
				}
			},
			{
				{
					-0.5,
					0.5
				},
				{
					-0.5 - arg_9_0.lenList[3],
					0.5 + arg_9_0.lenList[1]
				}
			}
		}
	else
		return {}
	end

	return
end

return var_0_0
