local var_0_0 = {}
local var_0_1 = {
	[HeroRaiseTrackConst.CustomScene.Cowboy] = "manager/heroRaiseTrack/customScene/cowboyControl/CowboyController",
	[HeroRaiseTrackConst.CustomScene.Cowboy_Prepare] = "manager/heroRaiseTrack/customScene/cowboyControl/CowboyPrepareController"
}
local var_0_2
local var_0_3

function var_0_0.Inject(arg_1_0, arg_1_1)
	function arg_1_1.DisposeCustomScene(arg_2_0)
		if var_0_2 then
			var_0_2:Dispose()

			var_0_2 = nil
		end

		var_0_3 = nil
	end

	function arg_1_1.SetCustomScene(arg_3_0, arg_3_1)
		if arg_3_1 ~= var_0_3 then
			var_0_3 = arg_3_1

			if var_0_3 == nil then
				if var_0_2 then
					var_0_2:Dispose()

					var_0_2 = nil
				end
			else
				if var_0_2 then
					var_0_2:Dispose()

					var_0_2 = nil
				end

				local var_3_0 = var_0_1[arg_3_1]

				var_0_2 = require(var_3_0).New()
			end
		end
	end

	function arg_1_1.GetCurrentCustomSceneController(arg_4_0)
		return var_0_2
	end

	function arg_1_1.GetCurrentCustomSceneType(arg_5_0)
		return var_0_3
	end
end

return var_0_0
