require("custom_nodes_lookup")
require("logic_fsm_demo_character")
ConfigDada_MainFSM = {
  [100] = {
    ID = 100,
    Tips = "角色状态机.测试",
    Type = "CustomLogic",
    Nodes = {
      {
        Type = "FSMNode",
        DefaultState = "Idle",
        MaxTransitionsPerFrame = 10,
        Nodes = {
          {
            Type = "CharacterIdleState",
            StateID = CharacterStateID.Idle
          },
          {
            Type = "CharacterMoveState",
            StateID = CharacterStateID.Move
          },
          {
            Type = "CharacterSkillState",
            StateID = CharacterStateID.Skill
          }
        }
      }
    }
  }
}
