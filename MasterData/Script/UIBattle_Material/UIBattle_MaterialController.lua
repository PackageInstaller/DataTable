local View = require("UIBattle_Material/UIBattle_MaterialView")
local DataModel = require("UIBattle_Material/UIBattle_MaterialDataModel")
local Controller = {}

function Controller:Init()
  Controller:SelectDifficulty(DataModel.LeftIndex)
end

function Controller:SetElementDifficulty(element, elementIndex)
  local row = DataModel.LevelList[elementIndex]
  if row == nil then
    element:SetActive(false)
    return
  end
  element:SetActive(true)
  element.Btn_Selected.Group_Lock:SetActive(not row.unlock)
  element.Btn_Selected.Group_Lock.Txt_Index:SetText(UIConfig.MechanismNum[elementIndex])
  element.Btn_Selected.Group_On.Txt_Index:SetText(UIConfig.MechanismNum[elementIndex])
  element.Btn_Selected.Group_On:SetActive(row.unlock)
  element.Btn_Selected.Img_Selected:SetActive(DataModel.LeftIndex == elementIndex)
  element.Btn_Selected.Group_Lock.Txt_Lv:SetText(string.format(GetText(80601968), row.unlockLv))
  element.Btn_Selected:SetClickParam(elementIndex)
end

function Controller:SelectDifficulty(index)
  local row = DataModel.LevelList[index]
  DataModel.LeftIndex = index
  View.Group_Level.StaticGrid_Level.grid.self:RefreshAllElement()
  View.Group_Right.Group_Details.Txt_Name:SetText(row.levelName)
  View.Group_Right.Group_Details.Txt_Index:SetText(UIConfig.MechanismNum[DataModel.LeftIndex])
  View.Group_Right.Group_Details.Group_Des.Txt_battleDes:SetText(row.description)
  View.Group_Right.Btn_Start.Group_Cost.Txt_Num:SetText("-" .. row.cost)
  View.Group_Right.Group_Skip.Btn_Start.Group_Cost.Txt_Num:SetText("-" .. row.cost)
  View.Group_Right.Group_Skip.Btn_Skip.Group_Cost.Txt_Num:SetText("-" .. row.cost)
  View.Group_Anim.SpineAnimation_Enemy:SetData(row.resDir)
  View.Group_Right.Group_Reward.ScrollGrid_Item.grid.self:SetDataCount(table.count(row.dropList))
  View.Group_Right.Group_Reward.ScrollGrid_Item.grid.self:RefreshAllElement()
  local isPass = PlayerData:GetLevelPassBySelf(row.levelId)
  View.Group_Right.Btn_Start:SetActive(isPass == false)
  View.Group_Right.Group_Skip.self:SetActive(isPass == true)
end

function Controller:startBattle()
  if Controller:CheckCanBattle() == false then
    return
  end
  local row = DataModel.LevelList[DataModel.LeftIndex]
  local levelId = row.levelId
  local levelDifficulty = PlayerData:GetLevelDifficulty(levelId)
  
  local function doSquad()
    local status = {
      Current = "Chapter",
      squadIndex = PlayerData.BattleInfo.squadIndex,
      hasOpenThreeView = false,
      difficulty = levelDifficulty,
      isAutoBattle = false
    }
    local t = {}
    t.activityId = DataModel.activityId
    t.isBattleReturn = true
    t.id = DataModel.LevelConfig.id
    t.maxNum = DataModel.maxNum
    t.currentNum = DataModel.CurrentNum
    t.titleIndex = DataModel.titleIndex
    t.battleLeftIndex = DataModel.battleLeftIndex
    t.leftIndex = DataModel.LeftIndex
    status.extraUIParamData = t
    PlayerData.BattleInfo.battleStageId = levelId
    PlayerData.BattleCallBackPage = "UI/Chapter/Battle_Material/Battle_Material"
    UIManager:Open("UI/Squads/Squads", Json.encode(status))
  end
  
  if not row.isEnemyLvEquilsPlayer and row.recomGrade + row.extraLevelOffset * (levelDifficulty - 1) - PlayerData:GetPlayerLevel() >= 5 then
    local checkTipParam = {}
    checkTipParam.isCheckTip = true
    checkTipParam.checkTipKey = "BattleMaterialLevelTip"
    checkTipParam.checkTipType = 1
    checkTipParam.showDanger = true
    checkTipParam.showSafe = true
    CommonTips.OnPrompt(80601227, nil, nil, doSquad, nil, nil, nil, nil, checkTipParam)
  else
    doSquad()
  end
end

function Controller:ClickSkipWin()
  if Controller:CheckCanBattle() == false then
    return
  end
  local row = DataModel.LevelList[DataModel.LeftIndex]
  local levelId = row.levelId
  local levelDifficulty = PlayerData:GetLevelDifficulty(levelId)
  
  local function doSquad()
    local status = {
      Current = "Chapter",
      squadIndex = PlayerData.BattleInfo.squadIndex,
      hasOpenThreeView = false,
      difficulty = levelDifficulty,
      isAutoBattle = false
    }
    local t = {}
    t.isBattleReturn = true
    t.id = DataModel.LevelConfig.id
    t.maxNum = DataModel.maxNum
    t.currentNum = DataModel.CurrentNum
    t.titleIndex = DataModel.titleIndex
    t.battleLeftIndex = DataModel.battleLeftIndex
    t.leftIndex = DataModel.LeftIndex
    status.extraUIParamData = t
    PlayerData.BattleInfo.battleStageId = levelId
    PlayerData.BattleCallBackPage = "UI/Chapter/Battle_Material/Battle_Material"
    UIManager:Open("UI/Common/BattleSkipTips", Json.encode(status))
  end
  
  doSquad()
end

function Controller:CheckCanBattle()
  if DataModel.maxNum - DataModel.CurrentNum <= 0 then
    CommonTips.OpenTips(80610269)
    return false
  end
  if DataModel:CheckIsActive() == false then
    CommonTips.OpenTips(80610399)
    if DataModel.initParams.isBattleReturn then
      UIManager:Open("UI/StageQuest/StageQuest", Json.encode({
        titleIndex = DataModel.titleIndex,
        battleLeftIndex = DataModel.battleLeftIndex,
        isBattleReturn = true,
        isRefresh = true
      }))
    else
      UIManager:GoBack()
    end
    return false
  end
  local row = DataModel.LevelList[DataModel.LeftIndex]
  if row == nil or row.unlock == false then
    CommonTips.OpenTips(80600050)
    return false
  end
  local levelId = row.levelId
  local levelDifficulty = PlayerData:GetLevelDifficulty(levelId)
  if CommonTips.OpenBuyEnergyTips(levelId, nil, nil, nil, levelDifficulty) then
    return false
  end
  return true
end

return Controller
