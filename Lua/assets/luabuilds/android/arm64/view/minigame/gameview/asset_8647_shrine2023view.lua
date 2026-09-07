local Shrine2023View = class("Shrine2023View", import(".Shrine2022View"))

function Shrine2023View.IsNeedShowTipWithoutActivityFinalReward()
	return Shrine2022View.IsNeedShowTipWithoutActivityFinalReward()
end

return Shrine2023View
