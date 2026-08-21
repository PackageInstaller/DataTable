require("custom_nodes_lookup")
require("game_state_id")
require("game_event_type")
GameFsmConfig = {
  [1] = {
    ID = 1,
    Tips = "单机主线模式状态机",
    Type = "CustomLogic",
    Nodes = {
      {
        Type = "FSMNode",
        DefaultState = GameStateID.Loading,
        MaxTransitionsPerFrame = 10,
        Nodes = {
          {
            Type = "GameFsmStateNode",
            Name = "Loading",
            StateID = GameStateID.Loading,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.LoadingFinish,
            NextState = {
              [1] = GameStateID.BattleEnter
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "BattleEnter",
            StateID = GameStateID.BattleEnter,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.BattleEnterFinish,
            NextState = {
              [1] = GameStateID.WaveEnter
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "WaveEnter",
            StateID = GameStateID.WaveEnter,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.WaveEnterFinish,
            NextState = {
              [1] = GameStateID.RoundEnter,
              [2] = GameStateID.FirstWaveEnter
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "FirstWaveEnter",
            StateID = GameStateID.FirstWaveEnter,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.FirstWaveEnterFinish,
            NextState = {
              [1] = GameStateID.RoundEnter
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "RoundEnter",
            StateID = GameStateID.RoundEnter,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.RoundEnterFinish,
            NextState = {
              [1] = GameStateID.WaitInput,
              [2] = GameStateID.RoundResult,
              [3] = GameStateID.WaveResultAward
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "WaitInput",
            StateID = GameStateID.WaitInput,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.WaitInputFinish,
            NextState = {
              [1] = GameStateID.RoleTurn,
              [2] = GameStateID.ActiveSkill,
              [3] = GameStateID.PreviewActiveSkill,
              [4] = GameStateID.MonsterTurn,
              [5] = GameStateID.RoundResult,
              [6] = GameStateID.PreviewChessPet,
              [7] = GameStateID.ChessPetResult,
              [8] = GameStateID.ChessPetMove,
              [9] = GameStateID.ChessPetMoveAndAttack,
              [10] = GameStateID.RoleChangeTeamLeader,
              [11] = GameStateID.PersonaSkill,
              [12] = GameStateID.UnscaledCountDownFinishNotify
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "UnscaledCountDownFinishNotify",
            StateID = GameStateID.UnscaledCountDownFinishNotify,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.UnscaledCountDownFinishNotifyFinish,
            NextState = {
              [1] = GameStateID.WaitInput,
              [2] = GameStateID.RoundResult
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "PickUpActiveSkillTarget",
            StateID = GameStateID.PickUpActiveSkillTarget,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.PickUpActiveSkillTargetFinish,
            NextState = {
              [1] = GameStateID.WaitInput,
              [2] = GameStateID.ActiveSkill,
              [3] = GameStateID.PreviewActiveSkill,
              [4] = GameStateID.PersonaSkill,
              [5] = GameStateID.RoleTurn
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "PreviewActiveSkill",
            StateID = GameStateID.PreviewActiveSkill,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.PreviewActiveSkillFinish,
            NextState = {
              [1] = GameStateID.WaitInput,
              [2] = GameStateID.ActiveSkill,
              [3] = GameStateID.PickUpActiveSkillTarget,
              [4] = GameStateID.PersonaSkill
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "ActiveSkill",
            StateID = GameStateID.ActiveSkill,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.ActiveSkillFinish,
            NextState = {
              [1] = GameStateID.WaitInput,
              [2] = GameStateID.RoundResult,
              [3] = GameStateID.WaitInputChain
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "PersonaSkill",
            StateID = GameStateID.PersonaSkill,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.PersonaSkillFinish,
            NextState = {
              [1] = GameStateID.WaitInput,
              [2] = GameStateID.RoundResult,
              [3] = GameStateID.WaitInputChain
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "RoleTurn",
            StateID = GameStateID.RoleTurn,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.RoleTurnFinish,
            NextState = {
              [1] = GameStateID.PieceRefresh
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "PieceRefresh",
            StateID = GameStateID.PieceRefresh,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.PieceRefreshFinish,
            NextState = {
              [1] = GameStateID.RoleTurnResult
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "RoleTurnResult",
            StateID = GameStateID.RoleTurnResult,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.RoleTurnResultFinish,
            NextState = {
              [1] = GameStateID.ChainAttack,
              [2] = GameStateID.WaitInputChain
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "WaitInputChain",
            StateID = GameStateID.WaitInputChain,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.WaitInputChainFinish,
            NextState = {
              [1] = GameStateID.PickUpChainSkillTarget
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "PickUpChainSkillTarget",
            StateID = GameStateID.PickUpChainSkillTarget,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.PickUpChainSkillTargetFinish,
            NextState = {
              [1] = GameStateID.PreChain,
              [2] = GameStateID.ChainAttack,
              [3] = GameStateID.WaitInput,
              [4] = GameStateID.RoundResult
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "PreChain",
            StateID = GameStateID.PreChain,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.PreChainFinish,
            NextState = {
              [1] = GameStateID.ChainAttack,
              [2] = GameStateID.WaitInput,
              [3] = GameStateID.RoundResult
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "ChainAttack",
            StateID = GameStateID.ChainAttack,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.ChainAttackFinish,
            NextState = {
              [1] = GameStateID.MonsterTurn,
              [2] = GameStateID.WaitInput,
              [3] = GameStateID.RoundResult
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "MonsterTurn",
            StateID = GameStateID.MonsterTurn,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.MonsterTurnFinish,
            NextState = {
              [1] = GameStateID.RoundResult,
              [2] = GameStateID.WaitInputChain,
              [3] = GameStateID.MirageEnter
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "RoundResult",
            StateID = GameStateID.RoundResult,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.RoundResultFinish,
            NextState = {
              [1] = GameStateID.RoundEnter,
              [2] = GameStateID.WaveResult
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "WaveResult",
            StateID = GameStateID.WaveResult,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.WaveResultFinish,
            NextState = {
              [1] = GameStateID.WaveSwitch,
              [2] = GameStateID.BattleResult,
              [3] = GameStateID.WaveResultAward
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "WaveResultAward",
            StateID = GameStateID.WaveResultAward,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.WaveResultAwardFinish,
            NextState = {
              [1] = GameStateID.WaveResultAwardApply
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "WaveResultAwardApply",
            StateID = GameStateID.WaveResultAwardApply,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.WaveResultAwardApplyFinish,
            NextState = {
              [1] = GameStateID.WaveSwitch,
              [2] = GameStateID.WaitInput
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "WaveSwitch",
            StateID = GameStateID.WaveSwitch,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.WaveSwitchFinish,
            NextState = {
              [1] = GameStateID.WaveEnter
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "BattleResult",
            StateID = GameStateID.BattleResult,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.BattleResultFinish,
            NextState = {
              [1] = GameStateID.BattleExit
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "PreviewChessPet",
            StateID = GameStateID.PreviewChessPet,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.PreviewChessPetFinish,
            NextState = {
              [1] = GameStateID.PickUpChessPet,
              [2] = GameStateID.ChessPetResult,
              [3] = GameStateID.WaitInput
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "ChessPetResult",
            StateID = GameStateID.ChessPetResult,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.ChessPetResultFinish,
            NextState = {
              [1] = GameStateID.WaitInput,
              [2] = GameStateID.MonsterTurn,
              [3] = GameStateID.RoundResult
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "PickUpChessPet",
            StateID = GameStateID.PickUpChessPet,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.PickUpChessPetFinish,
            NextState = {
              [1] = GameStateID.ChessPetMove,
              [2] = GameStateID.ChessPetAttack,
              [3] = GameStateID.ChessPetMoveAndAttack,
              [4] = GameStateID.ChessPetResult,
              [5] = GameStateID.WaitInput
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "ChessPetMove",
            StateID = GameStateID.ChessPetMove,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.ChessPetMoveFinish,
            NextState = {
              [1] = GameStateID.ChessPetResult
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "ChessPetAttack",
            StateID = GameStateID.ChessPetAttack,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.ChessPetAttackFinish,
            NextState = {
              [1] = GameStateID.ChessPetResult
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "ChessPetMoveAndAttack",
            StateID = GameStateID.ChessPetMoveAndAttack,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.ChessPetMoveAndAttackFinish,
            NextState = {
              [1] = GameStateID.ChessPetResult
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "RoleChangeTeamLeader",
            StateID = GameStateID.RoleChangeTeamLeader,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.RoleChangeTeamLeaderFinish,
            NextState = {
              [1] = GameStateID.WaitInput
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "MirageEnter",
            StateID = GameStateID.MirageEnter,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.MirageEnterFinish,
            NextState = {
              [1] = GameStateID.MirageWaitInput
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "MirageWaitInput",
            StateID = GameStateID.MirageWaitInput,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.MirageWaitInputFinish,
            NextState = {
              [1] = GameStateID.MirageRoleTurn,
              [2] = GameStateID.MirageEnd
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "MirageRoleTurn",
            StateID = GameStateID.MirageRoleTurn,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.MirageRoleTurnFinish,
            NextState = {
              [1] = GameStateID.MirageMonsterTurn,
              [2] = GameStateID.MirageEnd
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "MirageMonsterTurn",
            StateID = GameStateID.MirageMonsterTurn,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.MirageMonsterTurnFinish,
            NextState = {
              [1] = GameStateID.MirageWaitInput,
              [2] = GameStateID.MirageEnd
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "MirageEnd",
            StateID = GameStateID.MirageEnd,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.MirageEndFinish,
            NextState = {
              [1] = GameStateID.RoundResult
            }
          }
        }
      }
    }
  },
  [2] = {
    ID = 2,
    Tips = "消灭星星模式状态机",
    Type = "CustomLogic",
    Nodes = {
      {
        Type = "FSMNode",
        DefaultState = GameStateID.PopStarLoading,
        MaxTransitionsPerFrame = 10,
        Nodes = {
          {
            Type = "GameFsmStateNode",
            Name = "PopStarLoading",
            StateID = GameStateID.PopStarLoading,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.PopStarLoadingFinish,
            NextState = {
              [1] = GameStateID.PopStarBattleEnter
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "PopStarBattleEnter",
            StateID = GameStateID.PopStarBattleEnter,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.PopStarBattleEnterFinish,
            NextState = {
              [1] = GameStateID.PopStarWaveEnter
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "PopStarWaveEnter",
            StateID = GameStateID.PopStarWaveEnter,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.PopStarWaveEnterFinish,
            NextState = {
              [1] = GameStateID.PopStarRoundEnter
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "PopStarRoundEnter",
            StateID = GameStateID.PopStarRoundEnter,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.PopStarRoundEnterFinish,
            NextState = {
              [1] = GameStateID.WaitInput,
              [2] = GameStateID.PopStarRoundResult
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "WaitInput",
            StateID = GameStateID.WaitInput,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.WaitInputFinish,
            NextState = {
              [1] = GameStateID.PopStarPieceRefresh,
              [2] = GameStateID.ActiveSkill,
              [3] = GameStateID.PreviewActiveSkill,
              [4] = GameStateID.PersonaSkill
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "PopStarPieceRefresh",
            StateID = GameStateID.PopStarPieceRefresh,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.PopStarPieceRefreshFinish,
            NextState = {
              [1] = GameStateID.PopStarTrapTurn
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "ActiveSkill",
            StateID = GameStateID.ActiveSkill,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.ActiveSkillFinish,
            NextState = {
              [1] = GameStateID.WaitInput,
              [2] = GameStateID.PopStarRoundResult
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "PreviewActiveSkill",
            StateID = GameStateID.PreviewActiveSkill,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.PreviewActiveSkillFinish,
            NextState = {
              [1] = GameStateID.WaitInput,
              [2] = GameStateID.ActiveSkill,
              [3] = GameStateID.PickUpActiveSkillTarget,
              [4] = GameStateID.PersonaSkill
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "PersonaSkill",
            StateID = GameStateID.PersonaSkill,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.PersonaSkillFinish,
            NextState = {
              [1] = GameStateID.WaitInput,
              [2] = GameStateID.PopStarRoundResult
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "PickUpActiveSkillTarget",
            StateID = GameStateID.PickUpActiveSkillTarget,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.PickUpActiveSkillTargetFinish,
            NextState = {
              [1] = GameStateID.WaitInput,
              [2] = GameStateID.ActiveSkill,
              [3] = GameStateID.PreviewActiveSkill,
              [4] = GameStateID.PersonaSkill
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "PopStarTrapTurn",
            StateID = GameStateID.PopStarTrapTurn,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.PopStarTrapTurnFinish,
            NextState = {
              [1] = GameStateID.PopStarRoundResult
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "PopStarRoundResult",
            StateID = GameStateID.PopStarRoundResult,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.PopStarRoundResultFinish,
            NextState = {
              [1] = GameStateID.PopStarRoundEnter,
              [2] = GameStateID.PopStarWaveResult
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "PopStarWaveResult",
            StateID = GameStateID.PopStarWaveResult,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.PopStarWaveResultFinish,
            NextState = {
              [1] = GameStateID.PopStarBattleResult
            }
          },
          {
            Type = "GameFsmStateNode",
            Name = "PopStarBattleResult",
            StateID = GameStateID.PopStarBattleResult,
            Enter = GameEventType.ModeStateEnter,
            Event = GameEventType.BattleResultFinish,
            NextState = {
              [1] = GameStateID.BattleExit
            }
          }
        }
      }
    }
  }
}
