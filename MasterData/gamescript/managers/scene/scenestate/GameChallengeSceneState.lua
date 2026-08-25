local GameChallengeScene, Super = System.NewClass("GameChallengeScene", BaseSceneState)

function GameChallengeScene:ctor()
  Super.ctor(self)
end

function GameChallengeScene:OnInitSceneData()
  Super.OnInitSceneData(self)
end

function GameChallengeScene:OnEnterScene(data)
  Super.OnEnterScene(self, data)
  if not data.worldType or data.worldType == "Tower" then
    DataCenter.playerData.DRole.uid = data.role.uid
    DataCenter.playerData.DRole.tid = 2101
    DataCenter.playerData.DRole.hp = data.role.hp
    DataCenter.playerData.DRole.max_hp = data.role.max_hp
    DataCenter.playerData.DRole.max_hp_source = data.role.max_hp_source
    AwakerDataUtils.UpdateAwakerAttrs(data.role.roleAttrsList or {})
    DataCenter.playerData.DRole.dieNum = data.role.deathNum
    CardDataUtils.RemoveAllCard()
    for _, value in ipairs(data.cards) do
      CardDataUtils.AddCard(value)
    end
  end
  ChallengeManager.Instance:EnterChallenge(data.level, data)
end

function GameChallengeScene:OnExitScene()
  Super.OnExitScene(self)
  ChallengeManager.Instance:ExitChallenge()
end

return GameChallengeScene
