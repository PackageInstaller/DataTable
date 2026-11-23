




TeaTastSipHelper = {}
TeaTastSipHelper.TeaTastSipHelperTabInit = function()
    local data = ConfigMgr.Config.FourInLineVicMap
    local GetRewardTab = DataMgr.Player.fourInLine.award
    local totolRewardNum = 0
    local AlreadyGet = 0
    for index, value in pairs(data) do
        totolRewardNum = totolRewardNum + 1
        local RewardTag = tostring(value.VicType) .. "_" .. tostring(value.VicCount)
        local CompletedNum = GetRewardTab[RewardTag] ~= nil and 1 or 0
        AlreadyGet = AlreadyGet + CompletedNum
    end
    return AlreadyGet == totolRewardNum
end

return TeaTastSipHelper