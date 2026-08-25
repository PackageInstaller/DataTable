local ChallengeManager, Super = System.NewClass("ChallengeManager", Manager, IUpdater)

function ChallengeManager:ctor()
  Super.ctor(self)
  self.lastWorldType = nil
end

function ChallengeManager:Awake(binder)
  Super.Awake(self)
end

function ChallengeManager:OnDestroy()
  Super.OnDestroy(self)
  self:ExitChallenge()
  self:RemoveEvent()
end

function ChallengeManager:Update()
  if self.Challenge ~= nil then
    self.Challenge:Update()
  end
end

function ChallengeManager:EnterChallenge(ChallengeId, data)
  self:ExitChallenge()
  self.lastWorldType = data.worldType
  if data.worldType == "Tower" then
    self.Challenge = Challenge(ChallengeId, data)
    self.Challenge:Awake()
  else
    self.Challenge = RpgChallenge(0, data)
    self.Challenge:Awake()
  end
end

function ChallengeManager:RegisterEvent()
  EventMgr.Instance.EnterMainCity:RegisterEvent(System.fn(self, self.OpenChallengeUI))
end

function ChallengeManager:RemoveEvent()
  EventMgr.Instance.EnterMainCity:RemoveEvent(System.fn(self, self.OpenChallengeUI))
  EventMgr.Instance.EnterMainCity:RemoveAllEvents()
end

function ChallengeManager:ExitChallenge()
  if self.Challenge ~= nil then
    self.Challenge:Destroy()
  end
  self.Challenge = nil
end

function ChallengeManager:OpenChallengeUI()
  self:RemoveEvent()
end

function ChallengeManager:OpenRpgChallengeUI()
  UIManager.Instance:Reopen(Urls.BattleRpgEntryPanel, true)
end

function ChallengeManager:ReqEnterRpgChallenge(battleTid, awakerList, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnEnterRpgChallenge", function(data)
    if callback then
      callback()
    end
    if SceneMgr.Instance then
      SceneMgr.Instance:EnterChallenge(data)
    end
  end, nil, battleTid, awakerList)
end

function ChallengeManager:ReqEnterMoneyChallenge(levelTid, awakerList, callback)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("GameRequest", "OnEnterMoneyChallenge", function(data)
    if callback then
      callback()
    end
    if SceneMgr.Instance then
      SceneMgr.Instance:EnterChallenge(data)
    end
  end, nil, levelTid, awakerList)
end

function ChallengeManager:OnChallengeEnd()
  ProtoManager.Instance:ReqServer("WorldRequest", "OnGiveupNode", function()
    Logger.Info("OnChallengeEnd")
  end, nil, 0)
end

function ChallengeManager:OnExitBattle()
  ProtoManager.Instance:ReqServer("WorldRequest", "ExitBattle", function()
    Logger.Info("ExitBattle")
  end, nil)
end

return ChallengeManager
