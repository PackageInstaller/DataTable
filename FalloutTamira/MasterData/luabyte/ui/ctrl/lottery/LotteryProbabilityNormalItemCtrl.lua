local LotteryProbabilityNormalItemCtrl = BaseClass("LotteryProbabilityNormalItemCtrl",UIBaseComponent)
local M = LotteryProbabilityNormalItemCtrl

function M:Init(itemIds)
    local showStr = ""
    for i = 1, #itemIds do
        local itemData = ConfigHelper.GetCfg("item",itemIds[i])
        if itemData ~= nil then
            if i > 1 then
                showStr = showStr.."/"
            end

            showStr = showStr..ConfigHelper.GetLocalString(itemData.name)
        end
    end
    self._view.text:SetText(showStr)
    self._view.gameObject:SetActive(true)
end


return M
