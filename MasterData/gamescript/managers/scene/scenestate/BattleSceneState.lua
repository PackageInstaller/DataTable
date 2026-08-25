local BattleaSceneState, Super = System.NewClass("BattleaSceneState", BaseSceneState)

function BattleaSceneState:ctor()
  Super.ctor(self)
end

function BattleaSceneState:OnInitSceneData()
  Super.OnInitSceneData(self)
end

function BattleaSceneState:OnEnterScene(data)
  Super.OnEnterScene(self, data)
end

function BattleaSceneState:OnExitScene()
  Super.OnExitScene(self)
  if BattleManager.Instance then
    BattleManager.Instance:DisposeCurrentBattle()
  end
end

return BattleaSceneState
