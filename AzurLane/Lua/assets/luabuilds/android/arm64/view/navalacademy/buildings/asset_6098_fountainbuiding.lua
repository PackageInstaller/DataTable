class = var_0_10000

local var_0_0 = "FountainBuiding"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NavalAcademyBuilding"))

function var_0_1.GetGameObjectName(arg_1_0)
	return "fountain"
end

function var_0_1.GetTitle(arg_2_0)
	i18n = var_1_10001

	return var_1_10001("school_title_shoucang")
end

function var_0_1.OnClick(arg_3_0)
	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.emit

	NavalAcademyMediator = var_1_10004

	var_3_1(var_3_0, var_1_10004.ON_OPEN_COLLECTION)

	return
end

function var_0_1.IsTip(arg_4_0)
	getProxy = var_1_10001
	CollectionProxy = var_1_10003

	local var_4_0 = var_1_10001(var_1_10003)

	if var_1.unclaimTrophyCount(var_4_0) > 0 then
		return true
	else
		getProxy = var_1
		LoveLetterProxy = var_4_0

		local var_4_1 = var_1(var_4_0)
		local var_4_2

		if not var_1.IsTipLevelUp(var_4_1) then
			var_4_2 = var_1:IsTipAllLevelReward()
		end

		return var_4_2
	end

	return
end

return var_0_1
