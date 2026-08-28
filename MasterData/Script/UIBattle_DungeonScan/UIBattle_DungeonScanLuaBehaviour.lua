local View = require("UIBattle_DungeonScan/UIBattle_DungeonScanView")
local DataModel = require("UIBattle_DungeonScan/UIBattle_DungeonScanDataModel")
local ViewFunction = require("UIBattle_DungeonScan/UIBattle_DungeonScanViewFunction")
local Luabehaviour = {
  serialize = function()
    local t = {
      activityId = DataModel.ActivityId,
      areaId = DataModel.AreaId,
      eventId = DataModel.EventId,
      eventIndex = DataModel.EventIndex,
      type = DataModel.Type
    }
    return Json.encode(t)
  end,
  deserialize = function(initParams)
    if initParams then
      local json = Json.decode(initParams)
      print_r(json)
      if json.isIn == false then
        View.self:PlayAnim("Animation_DungeonStay")
      end
      if json.isAuto == true then
        DataModel.IsAutoDungeon = 1
      else
        DataModel.IsAutoDungeon = 0
      end
      DataModel.ActivityId = json.activityId
      DataModel.AreaId = json.areaId
      DataModel.EventId = json.eventId
      DataModel.EventIndex = json.eventIndex
      DataModel.Type = json.type
      DataModel.NeedLv = nil
      DataModel.AutoStep = 180
      local event = PlayerData:GetFactoryData(DataModel.EventId, "AFKEventFactory")
      View.Group_Right.Group_Title.Txt_Text:SetText(event.name)
      View.Group_Right.Group_Des.Txt_Desc:SetText(event.eventDescribe)
      local user_info = PlayerData:GetUserInfo()
      local initConfig = PlayerData:GetFactoryData(99900007, "ConfigFactory")
      local maxEnergy = user_info.max_energy or initConfig.energyMax
      local currEnergy = user_info.energy or 0
      View.Group_Right.Btn_Energy.Txt_Num:SetText(currEnergy .. "/" .. maxEnergy)
      local recomGrade, levelId
      if DataModel.Type == "pollute" then
        levelId = event.levelId
        View.Group_Right.Group_Progress.self:SetActive(true)
        View.Group_Right.Group_Progress.Txt_NumP.self:SetActive(true)
        View.Group_Right.Group_Progress.Txt_Num.self:SetActive(false)
        local cfg = PlayerData:GetFactoryData(DataModel.AreaId, "AreaFactory")
        local serverData = PlayerData.pollute_areas[tostring(DataModel.AreaId)]
        local currIndex = serverData.po_curIndex and tonumber(serverData.po_curIndex) + 1 or 1
        local basicCfg = PlayerData:GetFactoryData(99900056, "ConfigFactory")
        local show = serverData.pollute_num
        local total = cfg.polluteList[currIndex].num * basicCfg.pollutePlayerNum
        local ratio = show / total
        View.Group_Right.Group_Progress.Txt_NumP:SetText(show)
        View.Group_Right.Group_Progress.Img_Bar:SetFilledImgAmount(ratio)
        local parentWidth = View.Group_Right.Group_Progress.self.Rect.sizeDelta.x
        View.Group_Right.Group_Progress.Img_Point:SetAnchoredPosition(Vector2(ratio * parentWidth, 0))
        local currLv = serverData.po_curIndex and tonumber(serverData.po_curIndex) or 0
        local maxLv = serverData.po_index and tonumber(serverData.po_index) or 0
        if 0 < maxLv then
          View.Group_Right.Group_Progress.Txt_NumP.Txt_Lv:SetText(currLv .. "/" .. maxLv)
        else
          View.Group_Right.Group_Progress.Txt_NumP.Txt_Lv:SetText("")
        end
        local level = PlayerData:GetFactoryData(levelId, "LevelFactory")
        if recomGrade == nil then
          local user_lv = PlayerData:GetUserInfo().lv
          if level.isEnemyLvEquilsPlayer then
            recomGrade = user_lv + level.enemyLvOffset
          else
            recomGrade = level.recomGrade
          end
        end
        DataModel.LevelId = levelId
        local equalList = level.equalList
        local stageList = level.stageList
        local allItem = {}
        for i, v in ipairs(equalList) do
          if v.id then
            allItem[v.id] = 1
          end
        end
        for _, v in ipairs(stageList) do
          if v.id then
            local cfg = PlayerData:GetFactoryData(v.id, "ListFactory")
            if cfg.leveldropList then
              for _, a in ipairs(cfg.leveldropList) do
                if a.id then
                  allItem[a.id] = 2
                end
              end
            end
          end
        end
        DataModel.ChooseRewardList = {}
        for id, v in pairs(allItem) do
          local cfg = PlayerData:GetFactoryData(id)
          local quality = cfg.qualityInt == nil and 1 or cfg.qualityInt + 1
          table.insert(DataModel.ChooseRewardList, {
            type = v,
            id = id,
            quality = quality
          })
        end
        table.sort(DataModel.ChooseRewardList, function(a, b)
          if a.type == b.type then
            if a.quality == b.quality then
              return a.id < b.id
            else
              return a.quality > b.quality
            end
          end
          return a.type < b.type
        end)
        View.Group_Right.Group_Drop.ScrollGrid_Item.grid.self:SetDataCount(#DataModel.ChooseRewardList)
        View.Group_Right.Group_Drop.ScrollGrid_Item.grid.self:RefreshAllElement()
        View.Group_Right.Group_Drop.ScrollGrid_Item.grid.self:MoveToTop()
        View.Group_Right.Group_Fight.Group_RecoLevel.Txt_RecoLevel:SetText(string.format(GetText(80601819), recomGrade))
        View.Group_Right.Group_Fight.Group_Energy.Txt_Cost:SetText("-" .. level.energyEnd)
        View.Group_Right.Group_Auto.self:SetActive(true)
        if currEnergy < level.energyEnd and DataModel.IsAutoDungeon == 1 then
          CommonTips.OpenTips(80606882)
          DataModel.IsAutoDungeon = 0
        end
        View.Group_Right.Group_Auto.Btn_Auto.Group_On.self:SetActive(DataModel.IsAutoDungeon == 1)
        View.Group_Right.Group_Auto.Txt_Time:SetActive(DataModel.IsAutoDungeon == 1)
      elseif DataModel.Type == "dungeon" then
        View.Group_Right.Group_Progress.self:SetActive(true)
        View.Group_Right.Group_Progress.Txt_NumP.self:SetActive(false)
        View.Group_Right.Group_Progress.Txt_Num.self:SetActive(true)
        local num = PlayerData:GetDungeonNum(DataModel.AreaId, DataModel.EventIndex)
        local index = 1
        for i, v in ipairs(event.levelList) do
          if num >= v.count then
            index = i
          end
        end
        local remainCount = event.countMax - num
        local ratio = 1 - remainCount / event.countMax
        local percent = MathEx.roundToDecimalPlaces(ratio * 100)
        View.Group_Right.Group_Progress.Txt_Num:SetText(percent .. "%")
        View.Group_Right.Group_Progress.Img_Bar:SetFilledImgAmount(ratio)
        levelId = event.levelList[index].id
        local tempIndex = index > #event.levelList2 and #event.levelList2 or index
        local lvListId = event.levelList2[tempIndex].id
        if lvListId == nil then
          print_r("EventFactory id\239\188\154" .. DataModel.EventId .. "\230\178\161\230\156\137eventList2\231\154\132\231\180\162\229\188\149\228\184\186" .. tempIndex .. "\230\149\176\230\141\174")
        end
        local list = PlayerData:GetFactoryData(lvListId, "ListFactory")
        if list == nil then
          print_r("ListFactory\230\178\161\230\156\137\230\173\164id\239\188\154" .. lvListId)
        end
        local lvList = list.lvList
        local completeNum = PlayerData:GetDungeonCompleteNum(DataModel.EventId)
        local lvIndex = completeNum + 1
        recomGrade = lvList[lvIndex > #lvList and #lvList or lvIndex].lv
        DataModel.NeedLv = recomGrade
        local parentWidth = View.Group_Right.Group_Progress.self.Rect.sizeDelta.x
        View.Group_Right.Group_Progress.Img_Point:SetAnchoredPosition(Vector2(ratio * parentWidth, 0))
        local level = PlayerData:GetFactoryData(levelId, "LevelFactory")
        DataModel.LevelId = levelId
        local dropTableList = level.dropTableList
        local dropListCA = PlayerData:GetFactoryData(dropTableList[1].listId, "ListFactory")
        local dropListNew = dropListCA.leveldropList
        local state = PlayerData:GetLevelPass(levelId)
        local firstPassAward = level.firstPassAward
        DataModel.ChooseRewardList = {}
        for i = 1, 20 do
          if firstPassAward[i] then
            local id = firstPassAward[i].itemId
            local cfg = PlayerData:GetFactoryData(id)
            local quality = cfg.qualityInt == nil and 1 or cfg.qualityInt + 1
            table.insert(DataModel.ChooseRewardList, {
              num = firstPassAward[i].num,
              id = id,
              quality = quality,
              type = 1,
              isFinish = state
            })
          end
          if dropListNew[i] then
            local id = dropListNew[i].id
            local cfg = PlayerData:GetFactoryData(id)
            local quality = cfg.qualityInt == nil and 1 or cfg.qualityInt + 1
            table.insert(DataModel.ChooseRewardList, {
              num = dropListNew[i].num,
              id = id,
              quality = quality,
              type = 2
            })
          end
        end
        if state == true then
          table.sort(DataModel.ChooseRewardList, function(a, b)
            if a.type == b.type then
              if a.quality == b.quality then
                return a.id < b.id
              else
                return a.quality > b.quality
              end
            end
            return a.type > b.type
          end)
        else
          table.sort(DataModel.ChooseRewardList, function(a, b)
            if a.type == b.type then
              if a.quality == b.quality then
                return a.id < b.id
              else
                return a.quality > b.quality
              end
            end
            return a.type < b.type
          end)
        end
        View.Group_Right.Group_Drop.ScrollGrid_Item.grid.self:SetDataCount(#DataModel.ChooseRewardList)
        View.Group_Right.Group_Drop.ScrollGrid_Item.grid.self:RefreshAllElement()
        View.Group_Right.Group_Drop.ScrollGrid_Item.grid.self:MoveToTop()
        View.Group_Right.Group_Fight.Group_RecoLevel.Txt_RecoLevel:SetText(string.format(GetText(80601819), recomGrade))
        View.Group_Right.Group_Fight.Group_Energy.Txt_Cost:SetText("-" .. level.energyEnd)
        if ratio < 0 then
          DataModel.IsAutoDungeon = 0
        end
        View.Group_Right.Group_Auto.self:SetActive(true)
        View.Group_Right.Group_Auto.Btn_Auto.Group_On.self:SetActive(DataModel.IsAutoDungeon == 1)
        View.Group_Right.Group_Auto.Txt_Time:SetActive(DataModel.IsAutoDungeon == 1)
      elseif DataModel.Type == "resident" then
        levelId = event.levelId
        DataModel.LevelId = levelId
        local level = PlayerData:GetFactoryData(levelId, "LevelFactory")
        View.Group_Right.Group_Progress.self:SetActive(false)
        DataModel.ChooseRewardList = {}
        DataModel:SetDropList(level)
        View.Group_Right.Group_Drop.ScrollGrid_Item.grid.self:SetDataCount(#DataModel.ChooseRewardList)
        View.Group_Right.Group_Drop.ScrollGrid_Item.grid.self:RefreshAllElement()
        View.Group_Right.Group_Drop.ScrollGrid_Item.grid.self:MoveToTop()
        local t = string.split(DataModel.EventIndex, ":")
        local areaCA = PlayerData:GetFactoryData(DataModel.AreaId, "AreaFactory")
        if areaCA.ClickLevelList and table.count(areaCA.ClickLevelList) then
          for k, v in pairs(areaCA.ClickLevelList) do
            if tonumber(v.id) == tonumber(t[1]) then
              recomGrade = math.floor((v.levelLvMax + v.levelLvMin) / 2)
              break
            end
          end
        end
        View.Group_Right.Group_Fight.Group_RecoLevel.Txt_RecoLevel:SetText(string.format(GetText(80601819), recomGrade))
        View.Group_Right.Group_Fight.Group_Energy.Txt_Cost:SetText("-" .. level.energyEnd)
        View.Group_Right.Group_Auto.self:SetActive(DataModel.IsAutoDungeon == 1)
        View.Group_Right.Group_Auto.Btn_Auto.Group_On.self:SetActive(DataModel.IsAutoDungeon == 1)
        View.Group_Right.Group_Auto.Txt_Time:SetActive(DataModel.IsAutoDungeon == 1)
      else
        levelId = event.levelId
        DataModel.LevelId = levelId
        local level = PlayerData:GetFactoryData(levelId, "LevelFactory")
        View.Group_Right.Group_Progress.self:SetActive(false)
        DataModel.ChooseRewardList = {}
        DataModel:SetDropList(level)
        View.Group_Right.Group_Drop.ScrollGrid_Item.grid.self:SetDataCount(#DataModel.ChooseRewardList)
        View.Group_Right.Group_Drop.ScrollGrid_Item.grid.self:RefreshAllElement()
        View.Group_Right.Group_Drop.ScrollGrid_Item.grid.self:MoveToTop()
        local polluteCfg = PlayerData:GetFactoryData(99900056, "ConfigFactory")
        local clickList = polluteCfg.ClickHiddenEventList
        for i = 1, #clickList do
          if clickList[i].id == DataModel.EventId then
            recomGrade = math.floor((clickList[i].enemyLvMin + clickList[i].enemyLvMax) / 2)
            DataModel.NeedLv = math.floor(math.random(clickList[i].enemyLvMin, clickList[i].enemyLvMax))
            break
          end
        end
        View.Group_Right.Group_Fight.Group_RecoLevel.Txt_RecoLevel:SetText(string.format(GetText(80601819), recomGrade))
        View.Group_Right.Group_Fight.Group_Energy.Txt_Cost:SetText("-" .. level.energyEnd)
        View.Group_Right.Group_Auto.self:SetActive(DataModel.IsAutoDungeon == 1)
        View.Group_Right.Group_Auto.Btn_Auto.Group_On.self:SetActive(DataModel.IsAutoDungeon == 1)
        View.Group_Right.Group_Auto.Txt_Time:SetActive(DataModel.IsAutoDungeon == 1)
      end
    else
      print_r("\230\178\161\230\156\137\230\149\176\230\141\174\228\188\160\229\133\165battle_dungeon\239\188\140\232\175\183\230\159\165\231\156\139\230\151\165\229\191\151\233\135\140\233\157\162\231\154\132\230\149\176\230\141\174")
    end
  end,
  awake = function()
  end,
  start = function()
  end,
  perupdate = function()
  end,
  update = function()
    if TrainManager.CurrTrainState == TrainState.Arrive or TrainManager.CurrTrainState == TrainState.Arriving then
      View.self:Close()
      return
    end
    if DataModel.IsAutoDungeon == 1 then
      DataModel.AutoStep = DataModel.AutoStep - 1
      View.Group_Right.Group_Auto.Txt_Time:SetText(string.format(GetText(80606883), math.ceil(DataModel.AutoStep / 60 >= 0 and DataModel.AutoStep / 60 or 0)))
      if DataModel.AutoStep <= 0 then
        ViewFunction.Battle_DungeonScan_Group_Right_Group_Fight_Btn_StartFight_Click()
      end
    end
  end,
  ondestroy = function()
  end,
  enable = function()
  end,
  disenable = function()
  end
}
return {
  Luabehaviour,
  View,
  ViewFunction
}
