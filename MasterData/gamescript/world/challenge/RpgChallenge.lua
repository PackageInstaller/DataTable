local RpgChallenge, Super = System.NewClass("RpgChallenge", Challenge)

function RpgChallenge:ctor(id, data)
  Super.ctor(self)
  self.id = id
  self.data = data
end

function RpgChallenge:Awake()
  local battleData = self.data.battleData
  if battleData.prize then
    self:ShowPrize()
    return
  end
  EventMgr.Instance.MoveBanned:Dispatch("Loading", true)
  SceneLoader.PrepareLoading(function()
    EventMgr.Instance.MoveBanned:Dispatch("Loading", false)
    BattleManager.Instance:EnterBattle(battleData)
    if not battleData.svrRunBattle then
      BattleManager.Instance:ReqStartBattle()
    end
  end)
end

function RpgChallenge:ShowPrize()
  local battleData = self.data.battleData
  SceneLoader.StartMapLoading(function()
    SceneLoader.EndLoading(function()
      if 0 == battleData.battleRet and ChallengeManager.Instance then
        ChallengeManager.Instance:OnChallengeEnd()
      end
      CopiesDataUtils.ShowBattleSettlePanel(battleData, battleData.battleRet, nil, nil)
    end)
  end)
end

return RpgChallenge
