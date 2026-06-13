local EncounteProcessCtrl = BaseClass("EncounteProcessCtrl")
local M = EncounteProcessCtrl

function M:SetInfo(encounteZoneData)
    self.view:SetActive(true)
    local rewardState = encounteZoneData:ZoneGainRewardState()
    local state = encounteZoneData:ZoneState()
    local isAllGainReward = rewardState == EncountConst.EEncountZoneState.EAllPass
    self.view.trans_clear:SetActive(isAllGainReward)
    self.view.trans_unclear:SetActive(not isAllGainReward)
    if not isAllGainReward then
        self.view.trans_leftPass:SetActive(state == EncountConst.EEncountZoneState.EFirstPass)
        self.view.trans_righPass:SetActive(state == EncountConst.EEncountZoneState.ESecondPass)
    end
end

function M:OnDispose()
    if self.view then
        self.view:OnDispose()
        self.view = nil
    end
end

return EncounteProcessCtrl
