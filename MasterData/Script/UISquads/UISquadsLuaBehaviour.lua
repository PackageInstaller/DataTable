local View = require("UISquads/UISquadsView")
local ViewFunction = require("UISquads/UISquadsViewFunction")
local DataController = require("UISquads/UISquadsDataController")
local CharacterSelectController = require("UISquads/UISquadsCharacterSelectController")
local CardPollController = require("UISquads/UISquadsCardPoolController")
local DataModel = require("UISquads/UISquadsDataModel")
local LevelChainController = require("UISquads/UISquadsLevelChain")
local SquadController = require("UISquads/Controller_Squad")
local DataDetail = require("UISquads/UISquadsDetail")
local Luabehaviour = {
  serialize = function()
    DataController:ClearGridProperty(View.StaticGrid_List.grid)
    DataModel.hasOpenThreeView = false
    local status = {}
    if PlayerData.SquadsTempData then
      status = PlayerData.SquadsTempData
    end
    status.curSquadIndex = DataModel.curSquadIndex
    if DataModel.curLevelId ~= nil then
      local levelCA = PlayerData:GetFactoryData(DataModel.curLevelId)
      if levelCA ~= nil and levelCA.paragraphId > 0 then
        status.dialogueEnd = true
      end
    end
    return Json.encode(status)
  end,
  deserialize = function(initParams)
    DataController:ClearGridProperty(View.StaticGrid_List.grid)
    local MainDataModel = require("UIMainUI/UIMainUIDataModel")
    if MainDataModel.TrainEventId then
      local event = PlayerData:GetFactoryData(MainDataModel.TrainEventId, "AFKEventFactory")
      if event.isStoryStart then
        View.Group_CommonTopLeft.self:SetActive(false)
      else
        View.Group_CommonTopLeft.self:SetActive(true)
      end
    else
      View.Group_CommonTopLeft.self:SetActive(true)
      View.Btn_Start.Img_Icon:SetSprite(GetResPath(88300013))
    end
    View.Group_Detail.self:SetActive(false)
    View.Group_EquipSelected.self:SetActive(false)
    View.Group_ProvingGround.self:SetActive(false)
    View.Img_Base.self:SetActive(false)
    View.Btn_Close:SetActive(false)
    View.Btn_Mask:SetActive(false)
    DataModel.RoleExpList = PlayerData:GetFactoryData(99900003, "ConfigFactory").expList
    DataModel.LastRoleIndex = nil
    DataModel.ConfigFactory = PlayerData:GetFactoryData(99900001, "ConfigFactory")
    print_r("table.count(PlayerData.ServerData.squad)", table.count(PlayerData.ServerData.squad), table.count(DataModel.ConfigFactory.Squad))
    DataModel.DefalutSquadsTabCount = table.count(DataModel.ConfigFactory.Squad) > table.count(PlayerData.ServerData.squad) and table.count(PlayerData.ServerData.squad) or table.count(DataModel.ConfigFactory.Squad)
    local status
    PlayerData.currentSquad = {}
    PlayerData.SquadsTempData = nil
    PlayerData.BattleInfo.TeamKey = nil
    PlayerData.BattleInfo.UrEquipData = nil
    DataModel.InitParams = {}
    if initParams ~= nil and initParams ~= "" then
      status = Json.decode(initParams)
      DataModel.InitParams = status
      DataModel.InitParams.NextDistance = PlayerData.TempCache.NextDistance or status.NextDistance
      DataModel.InitParams.Sid = PlayerData.TempCache.Sid or status.Sid
      DataModel.dialogId = status.dialogId
      DataModel.friendId = status.friendId
      DataModel.gridId = status.gridId
      DataModel.csActivityId = status.csActivityId
      DataModel.csIndex = status.csIndex
      PlayerData.SquadsTempData = DataModel.InitParams
    end
    if status ~= nil and status.levelId ~= nil then
      PlayerData.BattleInfo.battleStageId = status.levelId
    end
    if status ~= nil and status.callbackPage ~= nil then
      PlayerData.BattleCallBackPage = status.callbackPage
    end
    DataModel.curSelectIndex = status ~= nil and status.curSelectIndex or 1
    DataController:Deserialize(status)
    DataModel.curSquadIndex = status ~= nil and status.curSquadIndex or PlayerData.BattleInfo.squadIndex or 1
    if DataModel.curSquadIndex == 0 then
      DataModel.curSquadIndex = 1
    end
    if UISquadsGlobalData:GetSelectSquadIndex() ~= 1 then
      DataModel:SetCurSquadIndex(UISquadsGlobalData:GetResetSelectSquadIndex())
    end
    DataModel.AllEquips = {}
    local list = PlayerData:GetEquips()
    if table.count(list) > 0 then
      for k, v in pairs(list) do
        local equipCA = PlayerData:GetFactoryData(v.id)
        local eid = k
        local tagCA = PlayerData:GetFactoryData(equipCA.equipTagId)
        local row = {}
        row.eid = eid
        row.equipCA = equipCA
        row.tagCA = tagCA
        row.server = v
        local typeInt = PlayerData:GetTypeInt("enumEquipTypeList", equipCA.equipTagId)
        if DataModel.AllEquips[typeInt] then
          table.insert(DataModel.AllEquips[typeInt], row)
        else
          DataModel.AllEquips[typeInt] = {}
          DataModel.AllEquips[typeInt][1] = row
        end
      end
    end
    if DataModel.curLevelId ~= nil and type(status) == "table" and status.dialogueEnd ~= true then
      local levelCA = PlayerData:GetFactoryData(DataModel.curLevelId)
      if levelCA ~= nil and 0 < levelCA.paragraphId then
        View.self:SetActive(false)
        UIManager:Open(UIPath.UIDialog, Json.encode({
          id = levelCA.paragraphId
        }))
        return
      end
    end
    if status == nil or status.curDetailIndex ~= 2 then
      View.self:PlayAnim("In")
    end
    if DataModel.Current == DataModel.Enum.LevelChain then
      LevelChainController.LevelChainRefreshAll(status.levelChainId or DataModel.levelChainId)
    else
      DataController:RefreshAll(true)
    end
    if DataModel.hasOpenThreeView ~= true then
      CharacterSelectController:Init()
      CardPollController:OpenView(false)
      View.Group_ChangeName.self:SetActive(false)
    else
      CharacterSelectController:OpenView(true)
    end
    DataModel.hasOpenThreeView = false
    if DataModel.curDetailIndex == 2 then
      DataModel.curDetailIndex = 2
      CharacterSelectController:OpenView(true, DataModel.currentIndex, DataModel.state, false)
      for k, v in pairs(DataModel.Squads[DataModel.curSquadIndex]) do
        if v.id then
          local id = tonumber(v.id)
          DataModel.HaveSquads[id] = id
        end
      end
      local currentSquad = {}
      local curRoleList = DataModel.Squads[DataModel.curSquadIndex]
      for i = 1, 5 do
        local temp = {}
        temp = curRoleList[i]
        if temp and temp.id == "" then
          temp.id = nil
        end
        table.insert(currentSquad, temp)
      end
      PlayerData.currentSquad = currentSquad
    else
      DataModel.Squads = {}
      DataModel:RefreshSquadsInit()
    end
    if DataModel.curSquadIndex ~= 1 and DataModel.curDetailIndex ~= 2 then
      SquadController.SetTabElement(DataModel.curSquadIndex, DataController)
    end
    View.Btn_Start.Group_Clarity.self:SetActive(false)
    if DataModel.curLevelId ~= "" and DataModel.curLevelId ~= nil then
      local levelCA = PlayerData:GetFactoryData(DataModel.curLevelId, "LevelFactory")
      View.Btn_Start.Group_Clarity.self:SetActive(true)
      local difficulty = DataModel.difficulty
      local costEnergyNum = levelCA.energyStart + levelCA.energyEnd + levelCA.extraEnergy * (difficulty - 1)
      if DataModel.level_key then
        local uid = string.split(DataModel.level_key, ":")[1]
        if uid ~= PlayerData:GetUserInfo().uid then
          costEnergyNum = PlayerData:GetFactoryData(99900014).shareEnergyEnd
        end
      end
      View.Btn_Start.Group_Clarity.Txt_Num:SetText("-" .. costEnergyNum)
      if levelCA then
        View.Group_CardYard_Open.Btn_HelpBattle.self:SetActive(levelCA.isCanHelp)
      else
        View.Group_CardYard_Open.Btn_HelpBattle.self:SetActive(false)
      end
    end
    DataModel.extraUIParamData = nil
    if status ~= nil then
      if status.extraUIParamData then
        DataModel.extraUIParamData = status.extraUIParamData
        PlayerData.Last_Chapter_Parms = {}
        for k, v in pairs(status.extraUIParamData) do
          PlayerData.Last_Chapter_Parms[k] = v
        end
      end
      if status.isBattleCenter then
        PlayerData.Last_Chapter_Parms = {}
        for k, v in pairs(status) do
          PlayerData.Last_Chapter_Parms[k] = v
        end
      end
    end
    DataModel.CloseCardDes()
    if status and status.enterTest then
      SquadController:EnterTest()
    end
    local showHomeBtn = not MapNeedleEventData.scene and not WitchData.inWitchMap
    View.Group_CommonTopLeft.Btn_Home:SetActive(showHomeBtn)
    local buff = PlayerData:GetCurStationStoreBuff(EnumDefine.HomeSkillEnum.HomeBattleBuff)
    DataModel.ramenBuff = buff
    if buff ~= nil then
      local buffCA = PlayerData:GetFactoryData(buff.id, "HomeBuffFactory")
      local name = buffCA.name
      View.Group_BuffTips.Group_Des.Group_Battle.Txt_Tips1:SetText(name)
      local desc = buffCA.desc
      local skillCA = PlayerData:GetFactoryData(buffCA.battleBuff, "SkillFactory")
      if skillCA ~= nil then
        desc = skillCA.description
        local skillParam = skillCA.desParamList[1]
        if skillParam ~= nil then
          if skillParam.isPercent then
            desc = string.format(desc, PlayerData:GetPreciseDecimalFloor(skillParam.param * 100, 1))
          else
            desc = string.format(desc, PlayerData:GetPreciseDecimalFloor(skillParam.param, 1))
          end
        end
      end
      View.Group_BuffTips.Group_Des.Group_Battle.Txt_Dec:SetText(string.format(GetText(80606871), desc))
    end
    if MainDataModel.TrainEventId and DataModel.Current == DataModel.Enum.Chapter then
      local DungeonDataModel = require("UIBattle_Dungeon/UIBattle_DungeonDataModel")
      local eventCA = PlayerData:GetFactoryData(MainDataModel.TrainEventId, "AFKEventFactory")
      if eventCA.mod == "\230\177\161\230\159\147\231\130\185\229\135\187\228\186\139\228\187\182" and DungeonDataModel.IsAutoDungeon == 1 and 0 >= DungeonDataModel.AutoStep then
        ViewFunction.Squads_Btn_Start_Click()
      end
      if eventCA.mod == "\231\130\185\229\135\187\229\137\175\230\156\172\228\186\139\228\187\182" and DungeonDataModel.IsAutoDungeon == 1 and 0 >= DungeonDataModel.AutoStep then
        ViewFunction.Squads_Btn_Start_Click()
      end
      if eventCA.mod == "\229\133\179\229\141\161\228\186\139\228\187\182" and PlayerData:GetHomeInfo().drive_setup.bar == 1 then
        ViewFunction.Squads_Btn_Start_Click()
      end
      local DungeonScanDataModel = require("UIBattle_DungeonScan/UIBattle_DungeonScanDataModel")
      if eventCA.mod == "\230\177\161\230\159\147\231\130\185\229\135\187\228\186\139\228\187\182" and DungeonScanDataModel.IsAutoDungeon == 1 and 0 >= DungeonScanDataModel.AutoStep then
        ViewFunction.Squads_Btn_Start_Click()
      elseif eventCA.mod == "\231\130\185\229\135\187\229\137\175\230\156\172\228\186\139\228\187\182" and DungeonScanDataModel.IsAutoDungeon == 1 and 0 >= DungeonScanDataModel.AutoStep then
        ViewFunction.Squads_Btn_Start_Click()
      elseif eventCA.mod == "\231\130\185\229\135\187\229\133\179\229\141\161" and DungeonScanDataModel.IsAutoDungeon == 1 and 0 >= DungeonScanDataModel.AutoStep then
        ViewFunction.Squads_Btn_Start_Click()
      elseif eventCA.mod == "\233\154\144\232\151\143\230\137\171\230\143\143\228\186\139\228\187\182" and DungeonScanDataModel.IsAutoDungeon == 1 and 0 >= DungeonScanDataModel.AutoStep then
        ViewFunction.Squads_Btn_Start_Click()
      end
    end
    if status and status.isAutoBattle then
      local success = ViewFunction.Squads_Btn_Start_Click()
      if success == false then
        PlayerData.TempCache.MonsterLevelAutoBattle = false
      end
    end
    if PlayerData.helpRoleList ~= nil and PlayerData.helpSquadIndex ~= nil then
      DataController:SetHelpRoleList()
    end
    if View.Group_Detail and View.Group_Detail.Group_DupesEquip then
      View.Group_Detail.Group_DupesEquip:SetActive(false)
    end
  end,
  awake = function()
    DataModel.playAni = true
  end,
  start = function()
  end,
  update = function()
    local buff = DataModel.ramenBuff
    if buff ~= nil then
      View.Group_CardYard_Open.Btn_BattleBuff.self:SetActive(true)
      if buff.endTime and buff.endTime > 0 then
        View.Group_CardYard_Open.Btn_BattleBuff.Txt_:SetActive(true)
        View.Group_BuffTips.Group_Des.Group_Battle.Img_1:SetActive(true)
        View.Group_BuffTips.Group_Des.Group_Battle.Img_:SetActive(true)
        View.Group_BuffTips.Group_Des.Group_Battle.Txt_Time:SetActive(true)
        local remainTime = buff.endTime - TimeUtil:GetServerTimeStamp()
        if 0 < remainTime then
          local timeStr = string.format(GetText(80600773), math.ceil(remainTime / 60))
          View.Group_CardYard_Open.Btn_BattleBuff.Txt_:SetText(timeStr)
          View.Group_BuffTips.Group_Des.Group_Battle.Txt_Time:SetText(timeStr)
        else
          DataModel.ramenBuff = nil
        end
      else
        View.Group_CardYard_Open.Btn_BattleBuff.Txt_:SetActive(false)
        View.Group_BuffTips.Group_Des.Group_Battle.Img_1:SetActive(false)
        View.Group_BuffTips.Group_Des.Group_Battle.Img_:SetActive(false)
        View.Group_BuffTips.Group_Des.Group_Battle.Txt_Time:SetActive(false)
      end
    else
      View.Group_CardYard_Open.Btn_BattleBuff.self:SetActive(false)
      View.Group_BuffTips.self:SetActive(false)
    end
  end,
  ondestroy = function()
    DataController:ClearGridProperty(View.StaticGrid_List.grid)
    DataModel.levelChainId = nil
    DataModel.curSquadIndex = 1
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
