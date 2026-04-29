require("custom_nodes_lookup")
require("player_action_state_id")
require("game_event_type")
ConfigData_PlayerActionFSM = {
  [1] = {
    ID = 1,
    Tips = "玩家行动状态机",
    Type = "CustomLogic",
    Nodes = {
      {
        Type = "FSMNode",
        DefaultState = PlayerActionStateID.Idle,
        MaxTransitionsPerFrame = 10,
        Nodes = {
          {
            Type = "GameFsmStateNode",
            Name = "Idle",
            StateID = PlayerActionStateID.Idle,
            Enter = GameEventType.PlayerActionEnter,
            Event = GameEventType.IdleEnd,
            NextState = {
              [1] = PlayerActionStateID.Move,
              [2] = PlayerActionStateID.ChainSkillAttack,
              [3] = PlayerActionStateID.PlayHitBack,
              [4] = PlayerActionStateID.NormalAttack
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "Move",
            StateID = PlayerActionStateID.Move,
            Enter = GameEventType.PlayerActionEnter,
            Event = GameEventType.MoveFinish,
            NextState = {
              [1] = PlayerActionStateID.NormalAttack,
              [2] = PlayerActionStateID.Idle,
              [3] = PlayerActionStateID.ChainSkillAttack
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "NormalAttack",
            StateID = PlayerActionStateID.NormalAttack,
            Enter = GameEventType.PlayerActionEnter,
            Event = GameEventType.NormalAttackFinish,
            NextState = {
              [1] = PlayerActionStateID.Move
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "ChainSkillAttack",
            StateID = PlayerActionStateID.ChainSkillAttack,
            Enter = GameEventType.PlayerActionEnter,
            Event = GameEventType.ChainSkillAttackFinish,
            NextState = {
              [1] = PlayerActionStateID.Idle
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "PlayerHitBack",
            StateID = PlayerActionStateID.PlayHitBack,
            Enter = GameEventType.PlayerActionEnter,
            Event = GameEventType.PlayerHitBackFinish,
            NextState = {
              [1] = PlayerActionStateID.Idle
            }
          }
        }
      }
    }
  }
}
