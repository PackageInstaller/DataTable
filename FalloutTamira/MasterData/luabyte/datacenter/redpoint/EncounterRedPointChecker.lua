local M = BaseClass("EncounterRedPointChecker", require("DataCenter.RedPoint.BaseRedPointChecker"))

function M:Check()
    self.checkResult = 0
    self.isChecking = true
    EncounterConfMgr:GetInstance():LoadData(Bind(self, self._OnResponseEnterEncounter))
end

function M:_OnResponseEnterEncounter(teams, encounteData)
    self.isChecking = false
    local list = encounteData:GetZoneDatas()
    local alreadyGain = 0
    for i = 1, #list do
        if list[i]:CanGainReward(EncountConst.EEncountTeamType.ETeamA) then
            self.checkResult = 1
            return
        end
        if list[i]:CanGainReward(EncountConst.EEncountTeamType.EteamB) then
            self.checkResult = 1
            return
        end
    end
    self.checkResult = 0
end

return M
