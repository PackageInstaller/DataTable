local var_0_0 = class("MainCheckTrackerSequence")
local var_0_1

function var_0_0.Execute(arg_1_0, arg_1_1)
	if var_0_1 ~= pg.proxyRegister.loginMark then
		var_0_1 = pg.proxyRegister.loginMark

		PlayerConst.CheckMedalAllCollectionTrack()
		Apartment.CheckAllCollectionTrack()
		EducateConst.CheckAllCollectionTrack()
	end

	arg_1_1()

	return
end

return var_0_0
