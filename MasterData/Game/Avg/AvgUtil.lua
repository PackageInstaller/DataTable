local AvgUtil = {}
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
AvgUtil.contentSpliter = "<|>"

function AvgUtil.ChangeUltSkillOrder(change)
  local window = UIManager:GetWindow(UIWindowTypeID.BattleSkillModule)
  if window ~= nil then
    window.ultSkillNode:ChangeUltSkillUIOrder(change)
  end
end

function AvgUtil.ShowMainCamera(active)
  local sceneName = CS.GSceneManager.Instance.curSceneName
  if string.IsNullOrEmpty(sceneName) then
    return
  end
  local MainCamera = UIManager:GetMainCamera()
  if IsNull(MainCamera) then
    local camCtrl
    if string.contains(sceneName, "Arena") then
      camCtrl = CS.CameraController.Instance
    elseif sceneName == Consts.SceneName.Main then
      camCtrl = CS.OasisCameraController.Instance
    end
    if not IsNull(camCtrl) then
      MainCamera = camCtrl.MainCamera
    end
  end
  if not IsNull(MainCamera) then
    local lowerCameraName = string.lower(MainCamera.name)
    if string.contains(lowerCameraName, "main") and MainCamera.enabled ~= active then
      MainCamera.enabled = active
    end
  end
end

function AvgUtil.GetConditionText(id, param1, param2)
  local str
  if id == CheckerTypeId.CompleteStage then
    local stageCfg = ConfigData.sector_stage[param1]
    if stageCfg == nil then
      error("Cant't find sector_stage cfg,id = " .. tostring(param1))
    end
    local diffstr
    local difficult = stageCfg.difficulty
    if difficult == ExplorationEnum.eDifficultType.Normal then
      diffstr = ConfigData:GetTipContent(TipContent.DifficultyName_1)
    elseif difficult == ExplorationEnum.eDifficultType.Hard then
      diffstr = ConfigData:GetTipContent(TipContent.DifficultyName_2)
    else
      diffstr = ConfigData:GetTipContent(TipContent.DifficultyName_3)
    end
    local showSectorId = ConfigData:GetSectorIdShow(stageCfg.sector)
    local newDesc = string.format(ConfigData:GetTipContent(TipContent.LockTip_Sector), tostring(showSectorId), tostring(showSectorId), tostring(stageCfg.num), diffstr)
    str = AvgUtil.__AddDecription(str, newDesc, false)
  elseif id == CheckerTypeId.CompleteDungeon then
    local stageCfg = ConfigData.battle_dungeon[param1]
    if stageCfg == nil then
      error("Cant't find battleDungeon cfg,id = " .. tostring(param1))
    end
    local newDesc = string.format(ConfigData:GetTipContent(TipContent.FunctionUnlockDescription_BattleDungeon), LanguageUtil.GetLocaleText(stageCfg.name))
    str = AvgUtil.__AddDecription(str, newDesc, false)
    str = string.format(LanguageUtil.GetLocaleText(str), tostring(param1))
  elseif id == CheckerTypeId.PlayerLevel then
    local newDesc = string.format(ConfigData:GetTipContent(TipContent.FunctionUnlockDescription_Level), tostring(param1))
    str = AvgUtil.__AddDecription(str, newDesc, false)
  end
  return str
end

function AvgUtil.__AddDecription(oldDesc, newDesc, lineWrap)
  if string.IsNullOrEmpty(oldDesc) then
    return newDesc
  end
  if lineWrap then
    oldDesc = oldDesc .. ",\n" .. newDesc
  else
    oldDesc = oldDesc .. "," .. newDesc
  end
  return oldDesc
end

function AvgUtil.GetAvgContentShow(content)
  if string.IsNullOrEmpty(content) then
    return content
  end
  local hasSplit = string.find(content, AvgUtil.contentSpliter)
  if hasSplit then
    content = string.gsub(content, AvgUtil.contentSpliter, "")
  end
  return content
end

function AvgUtil.GetAvgContentSplitStr(content, splitIdx)
  if string.IsNullOrEmpty(content) then
    return content
  end
  local contentList = string.split(content, AvgUtil.contentSpliter)
  local newContent = ""
  for i = 1, splitIdx do
    local str = contentList[i]
    if str ~= nil then
      newContent = newContent .. str
    end
  end
  return newContent
end

return AvgUtil
