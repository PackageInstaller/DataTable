local MainCheckTrackerSequence = class("MainCheckTrackerSequence")
local var_0_1

function MainCheckTrackerSequence:Execute(arg_1_1)
	if var_0_1 ~= pg.proxyRegister.loginMark then
		var_0_1 = pg.proxyRegister.loginMark

		PlayerConst.CheckMedalAllCollectionTrack()
		Apartment.CheckAllCollectionTrack()
		EducateConst.CheckAllCollectionTrack()
	end

	arg_1_1()

	return
end

return MainCheckTrackerSequence
