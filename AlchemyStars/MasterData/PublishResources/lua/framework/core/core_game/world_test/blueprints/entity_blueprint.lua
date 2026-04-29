EntityBlueprints = {
  [10001] = {
    ID = 10001,
    Tips = "LocalCharacter",
    Components = {
      {
        Type = "Asset",
        NativePrefabPath = "KH_a_103.prefab"
      },
      {
        Type = "Location",
        Pos = {
          -1,
          0,
          -2
        },
        Dir = {
          0,
          0,
          -1
        }
      }
    }
  },
  [10002] = {
    ID = 10002,
    Tips = "LocalCharacter",
    Components = {
      {Type = "Asset", NativePrefabPath = "LogicTest1"},
      {
        Type = "Location",
        Pos = {
          1,
          0,
          1
        },
        Dir = {
          0,
          0,
          1
        }
      }
    }
  }
}

function Entity:ApplyBlueprint(blueprintID)
  local blueprint = EntityBlueprints[blueprintID]
  local cmpts = blueprint.Components
  for i = 1, #cmpts do
    local cmptCfg = cmpts[i]
    local ApplyFunc = ComponentsBlueprintApplyDic[cmptCfg.Type]
    ApplyFunc(cmptCfg, self)
  end
end
