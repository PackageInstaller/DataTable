local LotteryProbabilityTitleCtrl = BaseClass("LotteryProbabilityTitleCtrl",UIBaseComponent)
local M = LotteryProbabilityTitleCtrl

local qualityImgePath = {
    "Assets/LoadableResources/UI/SpritePics/common/ui_common_rank_1.png",
    "Assets/LoadableResources/UI/SpritePics/common/ui_common_rank_2.png",
    "Assets/LoadableResources/UI/SpritePics/common/ui_common_rank_3.png",
    "Assets/LoadableResources/UI/SpritePics/common/ui_common_rank_4.png",
}

function M:Init(rare,quality)
    self._view.qualityImge:SetPic(qualityImgePath[rare])
    local number = tonumber(quality)
    number = number / 100
    local qualityStr = tostring(number) .. "%";
    self._view.qualityText:SetText(qualityStr)
    self._view.gameObject:SetActive(true)
end


return LotteryProbabilityTitleCtrl
