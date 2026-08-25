local Challenge, Super = System.NewClass("Challenge", Entity)

function Challenge:ctor(id, data)
  Super.ctor(self)
  self.id = id
  self.data = data
end

function Challenge:Awake()
  if self.data.battleData.prize then
    SceneLoader.StartMapLoading(function()
      SceneLoader.EndLoading(function()
        CopiesDataUtils.ShowBattleSettlePanel(self.data.battleData, 1, nil, nil)
      end)
    end)
    return
  end
  EventMgr.Instance.MoveBanned:Dispatch("Loading", true)
  SceneLoader.PrepareLoading(function()
    EventMgr.Instance.MoveBanned:Dispatch("Loading", false)
    BattleManager.Instance:EnterBattle(self.data.battleData)
    if not self.data.battleData.svrRunBattle then
      BattleManager.Instance:ReqStartBattle()
    end
  end)
end

function Challenge:GetType()
  return self.data.worldType
end

function Challenge:Destroy()
  Super.Destroy(self)
end

return Challenge
