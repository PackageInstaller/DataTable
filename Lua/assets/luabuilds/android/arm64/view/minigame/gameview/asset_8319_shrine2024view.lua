local Shrine2024View = class("Shrine2024View", import(".Shrine2022View"))

function Shrine2024View.IsNeedShowTipWithoutActivityFinalReward()
	return Shrine2022View.IsNeedShowTipWithoutActivityFinalReward()
end

return Shrine2024View
