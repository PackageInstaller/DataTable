local DataModel = require("UISettlement/UISettlementDataModel")
local Controller = {}
local StartBattle = require("UISquads/View_StartBattle")
local View = require("UISettlement/UISettlementView")

function Controller:OpenCharacter(...)
  local roleId = DataModel:GetMinRoleLvData()
  if roleId == nil then
    CommonTips.OpenLoading(nil, "", "", function()
      CBus:ChangeScene("Main", function()
        UIManager:Open("UI/MainUI/MainUI")
        local status = {btn = "Member", roleId = ""}
        UIManager:Open("UI/CharacterList/CharacterList", Json.encode(status))
      end)
    end)
    return
  end
  local data = {
    sortType = {
      pluckList = {},
      isIncr = false
    },
    currentRoleId = roleId,
    fromView = EnumDefine.CommonFilterType.SettlementView
  }
  CommonTips.OpenLoading(nil, "", "", function()
    CBus:ChangeScene("Main", function()
      UIManager:Open("UI/MainUI/MainUI")
      UIManager:Open("UI/CharacterInfo/CharacterInfo", Json.encode(data))
    end)
  end)
end

function Controller:OpenCharacterResonance(...)
  local roleId = DataModel:GetMinRoleResonanceData()
  if roleId == nil then
    CommonTips.OpenLoading(nil, "", "", function()
      CBus:ChangeScene("Main", function()
        UIManager:Open("UI/MainUI/MainUI")
        local status = {btn = "Member", roleId = ""}
        UIManager:Open("UI/CharacterList/CharacterList", Json.encode(status))
      end)
    end)
    return
  end
  local data = {
    index = 3,
    sortType = {
      pluckList = {},
      isIncr = false
    },
    currentRoleId = roleId,
    fromView = EnumDefine.CommonFilterType.SettlementView
  }
  CommonTips.OpenLoading(nil, "", "", function()
    CBus:ChangeScene("Main", function()
      UIManager:Open("UI/MainUI/MainUI")
      UIManager:Open("UI/CharacterInfo/CharacterInfo", Json.encode(data))
    end)
  end)
end

function Controller:TryAutoNext()
  if PlayerData.BattleInfo.nextLevel == nil then
    return
  end
  local levelId = PlayerData.BattleInfo.nextLevel.levelId
  local curSquad = PlayerData.BattleInfo.nextLevel.squad
  local difficulty = PlayerData.BattleInfo.nextLevel.difficulty
  local abyssId = PlayerData.BattleInfo.nextLevel.abyssId
  PlayerData.BattleInfo.UrEquipData = nil
  PlayerData.BattleInfo.nextLevel = nil
  DataModel.isAutoNext = true
  local roleList = {}
  for i = 1, #curSquad do
    roleList[i] = tonumber(curSquad[i].id)
  end
  local autoBattle = require("UIAutoBattle/UIAutoBattleViewFunction")
  autoBattle.SetTeamData("Abyss_2" .. "_" .. abyssId, roleList, roleList[1])
  PlayerData.BattleInfo.TeamKey = "Abyss_2" .. "_" .. abyssId
  StartBattle:StartAbyssBattle(levelId, curSquad, difficulty)
end

function Controller.SetOpenSettlementCamera()
  if not PlayerData.BattleInfo.BattleResult.isWin then
    return
  end
  local cam = DataModel:GetSettlementCamera()
  if cam == nil then
    return
  end
  DataModel.cameraMask = cam.cullingMask
  if DataModel.isSpine2 then
    cam.enabled = false
  else
    if cam:GetComponent(typeof(CS.DepthTexureManager)) == nil then
      local depthManager = cam.gameObject:AddComponent(typeof(CS.DepthTexureManager))
      depthManager.useRGUber = true
      View.self:StartC(LuaUtil.cs_generator(function()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        cam.clearFlags = CS.UnityEngine.CameraClearFlags.Nothing
        cam.cullingMask = 0
      end))
      return
    end
    cam.clearFlags = CS.UnityEngine.CameraClearFlags.Nothing
    cam.cullingMask = 0
  end
end

function Controller.SetCloseSettlementCamera()
  if not PlayerData.BattleInfo.BattleResult.isWin then
    return
  end
  local cam = DataModel:GetSettlementCamera()
  if cam == nil then
    return
  end
  if DataModel.isSpine2 then
    cam.enabled = true
  else
    cam.clearFlags = CS.UnityEngine.CameraClearFlags.Skybox
    cam.cullingMask = DataModel.cameraMask
  end
end

function Controller:OpenWiki()
  CS.UnityEngine.Application.OpenURL("https://wiki.biligame.com/resonance/?curid=6078")
end

return Controller
