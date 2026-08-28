local View, DataModel
local StartBattle = require("UISquads/View_StartBattle")
local autoBattle = require("UIAutoBattle/UIAutoBattleDataModel")
local autoBattleVF = require("UIAutoBattle/UIAutoBattleViewFunction")
local Controller = {}

function Controller:SetUIScript(dataModelStr, viewStr)
  View = require(viewStr)
  DataModel = require(dataModelStr)
end

function Controller:GetUIDataModel()
  return DataModel
end

function Controller:Init()
  PlayerData.BattleInfo.UrEquipData = nil
  DataModel.dragIdx = {}
  DataModel.roleCheckMap = {}
  DataModel.levelRoleList = {
    [1] = {
      -1,
      -1,
      -1,
      -1,
      -1
    },
    [2] = {
      -1,
      -1,
      -1,
      -1,
      -1
    }
  }
  DataModel.levelSquadIndex = {
    [1] = -1,
    [2] = -1
  }
  Controller:InitRoleList()
  self:InitFilterSetting()
  self:RefreshRoleListByFilter()
  DataModel.curSortType = nil
  DataModel.sortReverseMap = {
    [1] = false,
    [2] = false,
    [3] = false
  }
  self:SetRoleSortType(1, true)
  local squads = {}
  for i = 1, #PlayerData.ServerData.squad do
    if #PlayerData.ServerData.squad[i].role_list > 0 then
      squads[#squads + 1] = {
        idx = i,
        header = PlayerData.ServerData.squad[i].header,
        name = PlayerData.ServerData.squad[i].name
      }
      local roleList = {}
      for j = 1, #PlayerData.ServerData.squad[i].role_list do
        local roleId = PlayerData.ServerData.squad[i].role_list[j].id
        if roleId ~= nil then
          roleId = tostring(roleId)
          if roleId == PlayerData.ServerData.squad[i].header and 0 < #roleList then
            local firstId = roleList[1]
            roleList[1] = roleId
            roleList[#roleList + 1] = firstId
          else
            roleList[#roleList + 1] = roleId
          end
        end
      end
      squads[#squads].roleList = roleList
    end
  end
  DataModel.Squads = squads
  DataModel.selectMode = nil
  self:SetSelectMode(1)
  local abyssCA = PlayerData:GetFactoryData(DataModel.abyssId)
  View.Group_Level.StaticGrid_Level.grid.self:SetDataCount(#abyssCA.levelList)
  self:SelectLevel(-1)
  View.Group_Detail.Txt_Title:SetText(abyssCA.abyssName)
  View.Group_Detail.Txt_Des:SetText(abyssCA.abyssDes)
  View.Group_Detail.Txt_T:SetText(abyssCA.abyssIndex)
  local starMap = {
    0,
    0,
    0
  }
  local abyssId = tostring(DataModel.abyssId)
  if PlayerData.ServerData.abyss_level[abyssId] ~= nil then
    starMap = PlayerData.ServerData.abyss_level[abyssId].stars
  end
  for i = 1, 3 do
    local groupStar = View.Group_Star["Group_Star" .. i]
    groupStar.Img_Off:SetActive(starMap[i] == 0)
    groupStar.Img_On:SetActive(starMap[i] ~= 0)
    if i == 3 then
      local timeLimit = abyssCA.timeStar
      local remainTable = TimeUtil:SecondToTable(timeLimit)
      local str = ""
      if 0 >= remainTable.minute then
        str = string.format(GetText(80609059), remainTable.second)
      elseif 0 >= remainTable.second then
        str = string.format(GetText(80609061), remainTable.minute)
      else
        str = string.format(GetText(80609060), remainTable.minute, remainTable.second)
      end
      groupStar.Txt_D:SetText(str)
    end
  end
  local levelCA = PlayerData:GetFactoryData(abyssCA.levelList[1].id)
  local costData = levelCA.itemCost[1]
  local num, iconPath
  local isEnough = true
  if costData then
    num = costData.num
    iconPath = PlayerData:GetFactoryData(costData.id).iconPath
    for i = 1, #levelCA.itemCost do
      local costItemData = levelCA.itemCost[i]
      local cNum = costItemData.num
      local self_num = PlayerData:GetGoodsById(costItemData.id).num
      if cNum > self_num then
        isEnough = false
      end
    end
  else
    local difficulty = DataModel.difficulty or 1
    num = 0
    for i = 1, #abyssCA.levelList do
      local levelCA2 = PlayerData:GetFactoryData(abyssCA.levelList[i].id)
      num = num + levelCA2.energyEnd + levelCA2.extraEnergy * (difficulty - 1)
    end
    local self_num = PlayerData:GetGoodsById(11400006).num
    if num > self_num then
      isEnough = false
    end
  end
  if DataModel.numText then
    local textCA = PlayerData:GetFactoryData(DataModel.numText)
    if textCA ~= nil then
      View.Btn_Battle.Txt_Num:SetText(string.format(GetText(DataModel.numText), num))
    end
  else
    View.Btn_Battle.Txt_Num:SetText(num)
  end
  if not isEnough then
    View.Btn_Battle.Txt_Num:SetColor("#FF0000")
  else
    View.Btn_Battle.Txt_Num:SetColor("#FFFFFF")
  end
  if iconPath ~= nil then
    View.Btn_Battle.Img_Icon:SetSprite(iconPath)
  end
  View.Group_DupesEquip:SetActive(false)
end

function Controller:InitRoleList()
  DataModel.AutoBattleData = {}
  local roleStr = PlayerData:GetAbyssTeam(DataModel.teamKey)
  if roleStr ~= nil and roleStr ~= "" then
    local roleList = string.split(roleStr, ";")
    for i = 1, #roleList do
      local str = roleList[i]
      local curList = string.split(str, ",")
      for j = 1, #curList do
        if tonumber(curList[j]) ~= -1 and next(PlayerData:GetRoleById(curList[j])) ~= nil then
          Controller:AddRoleToTeam(curList[j], i)
        end
      end
    end
  end
  for i = 1, #DataModel.levelRoleList do
    local roleList1 = Controller:GetRoleIdNumberList(i)
    autoBattleVF.SetTeamData("Abyss_" .. i .. "_" .. DataModel.teamKey, roleList1, roleList1[1])
    DataModel.AutoBattleData[i] = autoBattle.CurrentData
    Controller:RefreshUrEquip(i)
  end
end

function Controller:GetRoleIdNumberList(index)
  local roleList1 = {}
  local roleList = DataModel.levelRoleList[index]
  for j = 1, #roleList do
    roleList1[#roleList1 + 1] = tonumber(roleList[j])
  end
  return roleList1
end

function Controller:InitFilterSetting()
  DataModel.FilterMap = {
    Group_Career = {
      maxCount = 0,
      list = {}
    },
    Group_Group = {
      maxCount = 0,
      list = {}
    },
    Group_Rarity = {
      maxCount = 0,
      list = {}
    }
  }
  self:InitCareerGroup()
  self:InitCampGroup()
  self:InitRarityGroup()
end

function Controller:RefreshRoleListByFilter()
  DataModel.Roles = {}
  for k in pairs(PlayerData.ServerData.roles) do
    local roleCA = PlayerData:GetFactoryData(k)
    if (not (table.count(DataModel.FilterMap.Group_Career.list) > 0) or DataModel.FilterMap.Group_Career.list[roleCA.line] == true) and (not (0 < table.count(DataModel.FilterMap.Group_Group.list)) or DataModel.FilterMap.Group_Group.list[PlayerData:SearchRoleCampInt(roleCA.sideId)] == true) and (not (0 < table.count(DataModel.FilterMap.Group_Rarity.list)) or DataModel.FilterMap.Group_Rarity.list[roleCA.qualityInt] == true) then
      table.insert(DataModel.Roles, tostring(k))
    end
  end
  local isFilterOn = false
  for k, v in pairs(DataModel.FilterMap) do
    if table.count(v.list) > 0 then
      isFilterOn = true
    end
  end
  local btnFilter = View.Group_Select.Group_RoleList.Btn_Screen
  btnFilter.Img_N:SetActive(not isFilterOn)
  btnFilter.Img_P:SetActive(isFilterOn)
end

function Controller:InitCareerGroup()
  local config = PlayerData:GetFactoryData(99900017).enumJobList
  local group = View.Screen_Chapter.Group_Career
  for k, v in pairs(group) do
    if k ~= "self" and k ~= "Txt_" and k ~= "Btn_All" then
      v.self:SetActive(false)
    end
  end
  local length = 0
  for k, v in pairs(config) do
    local btn = "Btn_C0" .. k
    local row = PlayerData:GetFactoryData(v.tagId)
    if group[btn] then
      group[btn].self:SetActive(true)
      group[btn].Txt_:SetText(row.tagName)
      group[btn]:SetClickParam(k)
      length = length + 1
    end
  end
  DataModel.FilterMap.Group_Career.maxCount = length
end

function Controller:InitCampGroup()
  local config = PlayerData:GetFactoryData(99900017).enumSideList
  local group = View.Screen_Chapter.Group_Group
  for k, v in pairs(group) do
    if k ~= "self" and k ~= "Txt_" and k ~= "Btn_All" then
      v.self:SetActive(false)
    end
  end
  local length = 0
  for k, v in pairs(config) do
    local btn = "Btn_G0" .. k
    local row = PlayerData:GetFactoryData(v.tagId)
    if group[btn] then
      group[btn].self:SetActive(true)
      group[btn].Txt_:SetText(row.sideName)
      group[btn]:SetClickParam(k)
      length = length + 1
    end
  end
  DataModel.FilterMap.Group_Group.maxCount = length
end

function Controller:InitRarityGroup()
  local group = View.Screen_Chapter.Group_Rarity
  local length = 0
  for k, v in pairs(group) do
    if k ~= "self" and k ~= "Txt_" and k ~= "Btn_All" then
      length = length + 1
    end
  end
  for i = 1, length do
    local btn = "Btn_R0" .. i
    group[btn]:SetClickParam(i)
  end
  DataModel.FilterMap.Group_Rarity.maxCount = length
end

function Controller:AddFilterMap(btn, key, val)
  if DataModel.FilterMap[key].list[val] == true then
    DataModel.FilterMap[key].list[val] = nil
  else
    DataModel.FilterMap[key].list[val] = true
  end
  if table.count(DataModel.FilterMap[key].list) >= DataModel.FilterMap[key].maxCount then
    DataModel.FilterMap[key].list = {}
  end
  self:RefreshFilterBtn(key)
end

function Controller:OnClickBtnAll(key)
  DataModel.FilterMap[key].list = {}
  self:RefreshFilterBtn(key)
end

function Controller:RefreshFilterBtn(key)
  local group = View.Screen_Chapter[key]
  for i = 1, DataModel.FilterMap[key].maxCount do
    local btn
    if key == "Group_Rarity" then
      btn = "Btn_R0" .. i
    elseif key == "Group_Group" then
      btn = "Btn_G0" .. i
    elseif key == "Group_Career" then
      btn = "Btn_C0" .. i
    end
    group[btn].Img_Select:SetActive(DataModel.FilterMap[key].list[i] == true)
  end
  group.Btn_All.Img_Select:SetActive(table.count(DataModel.FilterMap[key].list) == 0)
end

function Controller:OpenRoleFilter()
  local oldFilterMap = {}
  for k, v in pairs(DataModel.FilterMap) do
    oldFilterMap[k] = Clone(v.list)
    self:RefreshFilterBtn(k)
  end
  DataModel.oldFilterMap = oldFilterMap
  View.Screen_Chapter:SetActive(true)
end

function Controller:ExitRoleFilter(isConfirm)
  if isConfirm ~= true then
    for k, v in pairs(DataModel.FilterMap) do
      v.list = DataModel.oldFilterMap[k]
    end
  end
  DataModel.oldFilterMap = nil
  View.Screen_Chapter:SetActive(false)
  self:RefreshRoleListByFilter()
  local sortType = DataModel.curSortType
  DataModel.curSortType = nil
  self:SetRoleSortType(sortType, true)
  local selectMode = DataModel.selectMode
  DataModel.selectMode = nil
  self:SetSelectMode(selectMode)
end

function Controller:SetRoleSortType(bType, isInit)
  if DataModel.curSortType ~= bType then
    DataModel.curSortType = bType
  else
    DataModel.sortReverseMap[bType] = not DataModel.sortReverseMap[bType]
  end
  self:RefreshBtnBySortType(View.Group_Select.Group_RoleList.Btn_Level, 1)
  self:RefreshBtnBySortType(View.Group_Select.Group_RoleList.Btn_Rarity, 2)
  self:RefreshBtnBySortType(View.Group_Select.Group_RoleList.Btn_Time, 3)
  if bType == 1 then
    self:SortRolesByLevel(DataModel.sortReverseMap[bType])
  elseif bType == 2 then
    self:SortRolesByQuality(DataModel.sortReverseMap[bType])
  elseif bType == 3 then
    self:SortRolesByObtainTime(DataModel.sortReverseMap[bType])
  end
  if isInit ~= true then
    View.Group_Select.Group_RoleList.ScrollGrid_RoleList.grid.self:RefreshAllElement()
  end
end

function Controller:RefreshBtnBySortType(btn, btnType)
  local curType = DataModel.curSortType
  btn.Img_DeP.self:SetActive(curType == btnType and not DataModel.sortReverseMap[btnType])
  btn.Img_DeN.self:SetActive(curType ~= btnType and not DataModel.sortReverseMap[btnType])
  btn.Img_AP.self:SetActive(curType == btnType and DataModel.sortReverseMap[btnType])
  btn.Img_AN.self:SetActive(curType ~= btnType and DataModel.sortReverseMap[btnType])
end

function Controller:SortRolesByLevel(isReverse)
  table.sort(DataModel.Roles, function(e1, e2)
    local roleData1 = PlayerData.ServerData.roles[e1]
    local roleData2 = PlayerData.ServerData.roles[e2]
    if roleData1.lv ~= roleData2.lv then
      return roleData1.lv > roleData2.lv
    end
    local roleCA1 = PlayerData:GetFactoryData(e1)
    local roleCA2 = PlayerData:GetFactoryData(e2)
    if roleCA1.qualityInt ~= roleCA2.qualityInt then
      return roleCA1.qualityInt > roleCA2.qualityInt
    end
    return tonumber(e1) > tonumber(e2)
  end)
  if isReverse then
    DataModel.Roles = ReverseTable(DataModel.Roles)
  end
end

function Controller:SortRolesByQuality(isReverse)
  table.sort(DataModel.Roles, function(e1, e2)
    local roleCA1 = PlayerData:GetFactoryData(e1)
    local roleCA2 = PlayerData:GetFactoryData(e2)
    if roleCA1.qualityInt ~= roleCA2.qualityInt then
      return roleCA1.qualityInt > roleCA2.qualityInt
    end
    local roleData1 = PlayerData.ServerData.roles[e1]
    local roleData2 = PlayerData.ServerData.roles[e2]
    if roleData1.lv ~= roleData2.lv then
      return roleData1.lv > roleData2.lv
    end
    return tonumber(e1) > tonumber(e2)
  end)
  if isReverse then
    DataModel.Roles = ReverseTable(DataModel.Roles)
  end
end

function Controller:SortRolesByObtainTime(isReverse)
  table.sort(DataModel.Roles, function(e1, e2)
    local roleData1 = PlayerData.ServerData.roles[e1]
    local roleData2 = PlayerData.ServerData.roles[e2]
    if roleData1.obtain_time ~= roleData2.obtain_time then
      return roleData1.obtain_time > roleData2.obtain_time
    end
    if roleData1.lv ~= roleData2.lv then
      return roleData1.lv > roleData2.lv
    end
    local roleCA1 = PlayerData:GetFactoryData(e1)
    local roleCA2 = PlayerData:GetFactoryData(e2)
    if roleCA1.qualityInt ~= roleCA2.qualityInt then
      return roleCA1.qualityInt > roleCA2.qualityInt
    end
    return tonumber(e1) > tonumber(e2)
  end)
  if isReverse then
    DataModel.Roles = ReverseTable(DataModel.Roles)
  end
end

function Controller:SetSelectMode(mode)
  if DataModel.selectMode == mode then
    return
  end
  local groupCheck = View.Group_Select.Group_Check
  groupCheck.Btn_Role.Group_On.self:SetActive(mode == 1)
  groupCheck.Btn_Role.Group_Off.self:SetActive(mode ~= 1)
  groupCheck.Btn_Team.Group_On.self:SetActive(mode == 2)
  groupCheck.Btn_Team.Group_Off.self:SetActive(mode ~= 2)
  DataModel.selectMode = mode
  if DataModel.selectMode == 1 then
    self:UpdateRoleList()
  elseif DataModel.selectMode == 2 then
    self:UpdateTeamList()
  end
end

function Controller:UpdateRoleList()
  View.Group_Select.Group_RoleList.self:SetActive(true)
  View.Group_Select.Group_TeamList.self:SetActive(false)
  View.Group_Select.Group_RoleList.ScrollGrid_RoleList.grid.self:SetDataCount(#DataModel.Roles)
  View.Group_Select.Group_RoleList.ScrollGrid_RoleList.grid.self:RefreshAllElement()
  View.Group_Select.Group_RoleList.ScrollGrid_RoleList.grid.self:MoveToTop()
end

function Controller:OnSetRoleGrid(element, elementIndex)
  local roleId = DataModel.Roles[elementIndex]
  self:SetRoleGrid(element, roleId)
end

function Controller:SetRoleGrid(element, roleId)
  local roleData = PlayerData.ServerData.roles[roleId]
  if roleData == nil then
    return
  end
  element.Txt_Lv:SetText(string.format(GetText(80601968), roleData.lv))
  local currentSkin = roleData.current_skin[1]
  local viewCA = PlayerData:GetFactoryData(currentSkin, "UnitViewFactory")
  if element.Img_Head == nil then
    element.Img_Mask.Img_Head:SetSprite(viewCA.face)
  else
    element.Img_Head:SetSprite(viewCA.face)
  end
  local roleCA = PlayerData:GetFactoryData(roleId)
  if element.Txt_Name then
    element.Txt_Name:SetText(roleCA.name)
  end
  if DataModel.roleCheckMap[roleId] ~= nil then
    element.Group_InTeam:SetActive(true)
    local teamIdx = DataModel.roleCheckMap[roleId].team
    element.Group_InTeam.Txt_Team:SetText(string.format(GetText(80607584), teamIdx))
    if element.Group_Bg ~= nil then
      element.Group_Bg.Img_1:SetActive(teamIdx == 1)
      element.Group_Bg.Img_2:SetActive(teamIdx == 2)
    end
  else
    element.Group_InTeam:SetActive(false)
    if element.Group_Bg ~= nil then
      element.Group_Bg.Img_1:SetActive(false)
      element.Group_Bg.Img_2:SetActive(false)
    end
  end
  if element.Btn_Click ~= nil then
    element.Btn_Click:SetClickParam(roleId)
  end
end

function Controller:OnClickRoleBtn(roleId, notSave)
  local teamIndex = DataModel.curLevelIndex
  local curRoleTeam = DataModel.roleCheckMap[roleId]
  local curTeamIndex
  if curRoleTeam ~= nil then
    curTeamIndex = curRoleTeam.team
    self:RemoveRoleToTeam(roleId, notSave)
  end
  if teamIndex ~= -1 and curTeamIndex ~= teamIndex then
    self:AddRoleToTeam(roleId, teamIndex, notSave)
  end
  if DataModel.selectMode == 1 then
    View.Group_Select.Group_RoleList.ScrollGrid_RoleList.grid.self:RefreshAllElement()
  elseif DataModel.selectMode == 2 then
    View.Group_Select.Group_TeamList.ScrollGrid_TeamList.grid.self:RefreshAllElement()
  end
  View.Group_Level.StaticGrid_Level.grid.self:RefreshAllElement()
end

function Controller:AddRoleToTeam(roleId, teamIndex, notSave)
  local tRoleList = DataModel.levelRoleList[teamIndex]
  local order
  for i = 1, #tRoleList do
    if tRoleList[i] == -1 then
      tRoleList[i] = roleId
      order = i
      break
    end
  end
  if order == nil then
    return
  end
  DataModel.roleCheckMap[roleId] = {team = teamIndex, idx = order}
  DataModel.levelSquadIndex[teamIndex] = -1
  if DataModel.AutoBattleData ~= nil and DataModel.AutoBattleData[teamIndex] ~= nil then
    autoBattle:AddCardsByUnitId(DataModel.AutoBattleData[teamIndex], tonumber(roleId))
    if notSave ~= true then
      local str = Json.encode(DataModel.AutoBattleData[teamIndex])
      local autoKey = "CardAIDataAbyss_" .. teamIndex .. "_" .. DataModel.teamKey
      PlayerData:SetPlayerPrefs("string", autoKey, str, true)
      local cData = autoBattleVF:GetCloudData(autoKey)
      if cData.is_open and cData.is_open == "1" then
        local rList = Controller:GetRoleIdNumberList(teamIndex)
        local data = Clone(DataModel.AutoBattleData[teamIndex])
        data.roleList = rList
        data.header = rList[1]
        str = Json.encode(data)
        autoBattleVF:SaveCloudData(autoKey, str)
      end
      Controller:RefreshUrEquip(teamIndex)
    end
  end
end

function Controller:RemoveRoleToTeam(roleId, notSave)
  local curTeam = DataModel.roleCheckMap[roleId]
  if curTeam ~= nil then
    local curRoleList = DataModel.levelRoleList[curTeam.team]
    curRoleList[curTeam.idx] = -1
    DataModel.roleCheckMap[roleId] = nil
    DataModel.levelSquadIndex[curTeam.team] = -1
    if DataModel.AutoBattleData ~= nil and DataModel.AutoBattleData[curTeam.team] ~= nil then
      autoBattle:RemoveCardsByUnitId(DataModel.AutoBattleData[curTeam.team], tonumber(roleId))
      if notSave ~= true then
        local str = Json.encode(DataModel.AutoBattleData[curTeam.team])
        local autoKey = "CardAIDataAbyss_" .. curTeam.team .. "_" .. DataModel.teamKey
        PlayerData:SetPlayerPrefs("string", autoKey, str, true)
        local cData = autoBattleVF:GetCloudData(autoKey)
        if cData.is_open and cData.is_open == "1" then
          local rList = Controller:GetRoleIdNumberList(curTeam.team)
          local data = Clone(DataModel.AutoBattleData[curTeam.team])
          data.roleList = rList
          data.header = rList[1]
          str = Json.encode(data)
          autoBattleVF:SaveCloudData(autoKey, str)
        end
        Controller:RefreshUrEquip(curTeam.team)
      end
    end
  end
end

function Controller:ExchangeSingleRole(fromTeam, fromIndex, toTeam, toIndex)
  local fromRoleId = DataModel.levelRoleList[fromTeam][fromIndex]
  local toRoleId = DataModel.levelRoleList[toTeam][toIndex]
  DataModel.levelRoleList[toTeam][toIndex] = fromRoleId
  if fromRoleId ~= -1 then
    DataModel.roleCheckMap[fromRoleId] = {team = toTeam, idx = toIndex}
  end
  DataModel.levelRoleList[fromTeam][fromIndex] = toRoleId
  if toRoleId ~= -1 then
    DataModel.roleCheckMap[toRoleId] = {team = fromTeam, idx = fromIndex}
  end
  DataModel.levelSquadIndex[fromTeam] = -1
  DataModel.levelSquadIndex[toTeam] = -1
  Controller:RefreshUrEquip(fromTeam)
  if fromTeam ~= toTeam then
    Controller:RefreshUrEquip(toTeam)
  end
  if DataModel.selectMode == 1 then
    View.Group_Select.Group_RoleList.ScrollGrid_RoleList.grid.self:RefreshAllElement()
  elseif DataModel.selectMode == 2 then
    View.Group_Select.Group_TeamList.ScrollGrid_TeamList.grid.self:RefreshAllElement()
  end
end

function Controller:UpdateTeamList()
  View.Group_Select.Group_RoleList.self:SetActive(false)
  View.Group_Select.Group_TeamList.self:SetActive(true)
  View.Group_Select.Group_TeamList.ScrollGrid_TeamList.grid.self:SetDataCount(#DataModel.Squads)
  View.Group_Select.Group_TeamList.ScrollGrid_TeamList.grid.self:RefreshAllElement()
  View.Group_Select.Group_TeamList.ScrollGrid_TeamList.grid.self:MoveToTop()
end

function Controller:OnSetTeamGrid(element, elementIndex)
  local teamData = DataModel.Squads[elementIndex]
  if teamData.name == nil or teamData.name == "" then
    local squadTabData = PlayerData:GetFactoryData(99900001, "ConfigFactory").Squad[teamData.idx]
    element.Txt_Name:SetText(squadTabData.defaultSquadName)
  else
    element.Txt_Name:SetText(teamData.name)
  end
  element.StaticGrid_Role.grid.self:SetParentParam(elementIndex)
  element.StaticGrid_Role.grid.self:SetDataCount(#teamData.roleList)
  element.StaticGrid_Role.grid.self:RefreshAllElement()
  element.Btn_Click:SetClickParam(elementIndex)
end

function Controller:OnSetTeamRoleGrid(element, elementIndex)
  local teamData = DataModel.Squads[tonumber(element.ParentParam)]
  local roleId = teamData.roleList[elementIndex]
  self:SetRoleGrid(element, roleId)
end

function Controller:OnClickTeamBtn(str)
  local teamIndex = DataModel.curLevelIndex
  local curSquadIndex = DataModel.levelSquadIndex[teamIndex]
  self:ClearTeamByIndex(teamIndex, true)
  local squadIndex = tonumber(str)
  if curSquadIndex == squadIndex then
    DataModel.levelSquadIndex[teamIndex] = -1
  else
    local teamData = DataModel.Squads[squadIndex]
    for i = 1, #teamData.roleList do
      self:OnClickRoleBtn(teamData.roleList[i], true)
    end
    DataModel.levelSquadIndex[teamIndex] = squadIndex
  end
  local autoKey = "CardAIData" .. DataModel.Squads[squadIndex].idx
  local dataStr = PlayerData:GetPlayerPrefs("string", autoKey, true)
  local cData = autoBattleVF:GetCloudData(autoKey)
  if cData.is_open and cData.is_open == "1" then
    local cStr = autoBattleVF:GetCloudStr(autoKey)
    dataStr = cStr
  end
  if dataStr ~= nil and 1 <= string.getLength(dataStr) then
    local Data = Json.decode(dataStr)
    if Data.discardType == nil then
      Data.discardType = autoBattle.DefaultValue.discardType
    end
    if Data.keepCardNum == nil then
      Data.keepCardNum = autoBattle.DefaultValue.keepCardNum
    end
    if Data.otherCard == nil then
      Data.otherCard = autoBattle.DefaultValue.otherCard
    end
    if Data.cardList == nil then
      Data.cardList = {}
    end
    if Data.cardIdMap == nil then
      Data.cardIdMap = {}
    end
    DataModel.AutoBattleData[teamIndex] = Data
    local autoStr = Json.encode(DataModel.AutoBattleData[teamIndex])
    local tKey = "CardAIDataAbyss_" .. teamIndex .. "_" .. DataModel.teamKey
    PlayerData:SetPlayerPrefs("string", tKey, autoStr, true)
    local cData = autoBattleVF:GetCloudData(tKey)
    if cData.is_open and cData.is_open == "1" then
      local rList = Controller:GetRoleIdNumberList(teamIndex)
      local data = Clone(DataModel.AutoBattleData[teamIndex])
      data.roleList = rList
      data.header = rList[1]
      autoStr = Json.encode(data)
      autoBattleVF:SaveCloudData(tKey, autoStr)
    end
  end
  if DataModel.selectMode == 2 then
    View.Group_Select.Group_TeamList.ScrollGrid_TeamList.grid.self:RefreshAllElement()
  end
  Controller:RefreshUrEquip(teamIndex)
  View.Group_Level.StaticGrid_Level.grid.self:RefreshAllElement()
end

function Controller:ExchangeTeams()
  local levelRoleList = Clone(DataModel.levelRoleList)
  local levelSquadIndex = Clone(DataModel.levelSquadIndex)
  local AutoBattleData = Clone(DataModel.AutoBattleData)
  self:ClearAllTeam(true)
  for i = 1, #levelRoleList[1] do
    self:AddRoleToTeam(levelRoleList[1][i], 2, true)
  end
  for i = 1, #levelRoleList[2] do
    self:AddRoleToTeam(levelRoleList[2][i], 1, true)
  end
  DataModel.levelSquadIndex[1] = levelSquadIndex[2]
  DataModel.levelSquadIndex[2] = levelSquadIndex[1]
  DataModel.AutoBattleData[1] = AutoBattleData[2]
  DataModel.AutoBattleData[2] = AutoBattleData[1]
  local autoStr = Json.encode(DataModel.AutoBattleData[1])
  local autoKey = "CardAIDataAbyss_" .. 1 .. "_" .. DataModel.teamKey
  PlayerData:SetPlayerPrefs("string", autoKey, autoStr, true)
  local cData = autoBattleVF:GetCloudData(autoKey)
  if cData.is_open and cData.is_open == "1" then
    local rList = Controller:GetRoleIdNumberList(1)
    local data = Clone(DataModel.AutoBattleData[1])
    data.roleList = rList
    data.header = rList[1]
    autoStr = Json.encode(data)
    autoBattleVF:SaveCloudData(autoKey, autoStr)
  end
  autoStr = Json.encode(DataModel.AutoBattleData[2])
  autoKey = "CardAIDataAbyss_" .. 2 .. "_" .. DataModel.teamKey
  PlayerData:SetPlayerPrefs("string", autoKey, autoStr, true)
  local cData = autoBattleVF:GetCloudData(autoKey)
  if cData.is_open and cData.is_open == "1" then
    local rList = Controller:GetRoleIdNumberList(2)
    local data = Clone(DataModel.AutoBattleData[2])
    data.roleList = rList
    data.header = rList[1]
    autoStr = Json.encode(data)
    autoBattleVF:SaveCloudData(autoKey, autoStr)
  end
  self:SaveCurLevelRoleList()
  if DataModel.selectMode == 1 then
    View.Group_Select.Group_RoleList.ScrollGrid_RoleList.grid.self:RefreshAllElement()
  elseif DataModel.selectMode == 2 then
    View.Group_Select.Group_TeamList.ScrollGrid_TeamList.grid.self:RefreshAllElement()
  end
  local equip1 = Controller:GetUrEquipData(1)
  local equip2 = Controller:GetUrEquipData(2)
  Controller:SaveUrEquipData(equip2, 1)
  Controller:SaveUrEquipData(equip1, 2)
  View.Group_Level.StaticGrid_Level.grid.self:RefreshAllElement()
end

function Controller:ClearTeamByIndex(teamIndex, notSave)
  local curTeam = DataModel.levelRoleList[teamIndex]
  for i = 1, #curTeam do
    self:RemoveRoleToTeam(curTeam[i], true)
  end
  if notSave ~= true then
    local autoStr = Json.encode(DataModel.AutoBattleData[teamIndex])
    local tKey = "CardAIDataAbyss_" .. teamIndex .. "_" .. DataModel.teamKey
    PlayerData:SetPlayerPrefs("string", tKey, autoStr, true)
    local cData = autoBattleVF:GetCloudData(tKey)
    if cData.is_open and cData.is_open == "1" then
      local rList = Controller:GetRoleIdNumberList(teamIndex)
      local data = Clone(DataModel.AutoBattleData[teamIndex])
      data.roleList = rList
      data.header = rList[1]
      autoStr = Json.encode(data)
      autoBattleVF:SaveCloudData(tKey, autoStr)
    end
    Controller:RefreshUrEquip(teamIndex)
  end
end

function Controller:ClearAllTeam(notSave)
  for i = 1, #DataModel.levelRoleList do
    self:ClearTeamByIndex(i, true)
    if notSave ~= true then
      local autoStr = Json.encode(DataModel.AutoBattleData[i])
      local tKey = "CardAIDataAbyss_" .. i .. "_" .. DataModel.teamKey
      PlayerData:SetPlayerPrefs("string", tKey, autoStr, true)
      local cData = autoBattleVF:GetCloudData(tKey)
      if cData.is_open and cData.is_open == "1" then
        local rList = Controller:GetRoleIdNumberList(i)
        local data = Clone(DataModel.AutoBattleData[i])
        data.roleList = rList
        data.header = rList[1]
        autoStr = Json.encode(data)
        autoBattleVF:SaveCloudData(tKey, autoStr)
      end
      Controller:RefreshUrEquip(1)
      Controller:RefreshUrEquip(2)
    end
  end
end

function Controller:SelectLevel(index)
  DataModel.curLevelIndex = index
  View.Group_Level.StaticGrid_Level.grid.self:RefreshAllElement()
  View.Group_Select.self:SetActive(0 < index)
  View.Group_Level.Img_Mask:SetActive(0 < index)
end

function Controller:OnSetLevelGrid(element, elementIndex)
  element.Group_Off.self:SetActive(DataModel.curLevelIndex > 0 and elementIndex ~= DataModel.curLevelIndex)
  element.Txt_Index:SetText(elementIndex)
  local abyssCA = PlayerData:GetFactoryData(DataModel.abyssId)
  local levelList = abyssCA.levelList
  local levelCA = PlayerData:GetFactoryData(levelList[elementIndex].id)
  local bossCA = PlayerData:GetFactoryData(levelCA.bossId)
  if bossCA then
    local bossViewCA = PlayerData:GetFactoryData(bossCA.viewId, "UnitViewFactory")
    element.Group_Boss.Img_Mask.Spine_Head:SetData(bossViewCA.resDir, "stand")
  end
  local spineScale = levelList[elementIndex].spineScale
  element.Group_Boss.Img_Mask.Spine_Head.transform.localScale = Vector3(spineScale, spineScale, spineScale)
  element.Group_Boss.Img_Mask.Spine_Head:SetLocalPosition(Vector3(levelList[elementIndex].spinePosX, levelList[elementIndex].spinePosY, 0))
  element.StaticGrid_RoleList.grid.self:SetParentParam(elementIndex)
  element.StaticGrid_RoleList.grid.self:SetDataCount(#DataModel.levelRoleList[elementIndex])
  element.StaticGrid_RoleList.grid.self:RefreshAllElement()
  element.Btn_Select:SetClickParam(elementIndex)
  element.Btn_Detail:SetClickParam(levelList[elementIndex].id)
  element.Btn_Auto:SetClickParam(elementIndex)
end

function Controller:OnSetLevelRoleGrid(element, elementIndex)
  local parentParam = element.ParentParam
  local teamIdx = tonumber(parentParam)
  local levelRoleList = DataModel.levelRoleList[teamIdx]
  local roleId = levelRoleList[elementIndex]
  element.Btn_Click:SetClickParam(teamIdx .. ":" .. elementIndex)
  if roleId == -1 or DataModel.isDrag == true and DataModel.dragIdx.team == teamIdx and DataModel.dragIdx.role == elementIndex then
    element.Group_On:SetActive(false)
    element.Group_Off:SetActive(true)
    element.Img_Disable:SetActive(false)
    return
  end
  element.Group_On:SetActive(true)
  element.Group_Off:SetActive(false)
  local roleData = PlayerData.ServerData.roles[roleId]
  local currentSkin = roleData.current_skin[1]
  local viewCA = PlayerData:GetFactoryData(currentSkin, "UnitViewFactory")
  element.Group_On.Spine_Role:SetData(viewCA.resDir, "stand")
  local hasForbidUR = false
  local urequip = Controller:GetUrEquipData(teamIdx)
  if urequip[tostring(roleId)] then
    for i = 1, 3 do
      if urequip[tostring(roleId)][i] and tonumber(urequip[tostring(roleId)][i].id) ~= nil and urequip[tostring(roleId)][i].isUse == false then
        hasForbidUR = true
        break
      end
    end
  end
  element.Img_Disable:SetActive(hasForbidUR)
end

function Controller:TryBattle()
  if DataModel.periodId then
    local curPeriodCA = PlayerData:GetFactoryData(DataModel.periodId)
    if not TimeUtil:IsActive(curPeriodCA.startTime, curPeriodCA.endTime) then
      return
    end
  elseif DataModel.isDoubleTeam ~= true then
    return
  end
  local abyssCA = PlayerData:GetFactoryData(DataModel.abyssId)
  local levelCA = PlayerData:GetFactoryData(abyssCA.levelList[1].id)
  if DataModel.isDoubleTeam ~= true then
    for i = 1, #levelCA.itemCost do
      local costData = levelCA.itemCost[i]
      local num = costData.num
      local self_num = PlayerData:GetGoodsById(costData.id).num
      if num > self_num then
        local function callback()
          local json = {}
          
          json.shops = PlayerData.ServerData.shops
          json.shopId = 80300004
          if PlayerData.RechargeGoods == nil then
            Net:SendProto("shop.info", function(json)
              UIManager:Open("UI/Store/Store", Json.encode(json))
            end)
          else
            UIManager:Open("UI/Store/Store", Json.encode(json))
          end
        end
        
        CommonTips.OnPrompt(80607449, nil, nil, callback)
        return
      end
    end
  else
    local difficulty = DataModel.difficulty or 1
    local num = 0
    for i = 1, #abyssCA.levelList do
      local levelCA2 = PlayerData:GetFactoryData(abyssCA.levelList[i].id)
      num = num + levelCA2.energyEnd + levelCA2.extraEnergy * (difficulty - 1)
    end
    local self_num = PlayerData:GetGoodsById(11400006).num
    if num > self_num then
      CommonTips.OpenTips(80607449)
    end
  end
  local roleCountMap = {}
  for i = 1, #DataModel.levelRoleList do
    for j = 1, #DataModel.levelRoleList[i] do
      local roleId = DataModel.levelRoleList[i][j]
      if roleId == -1 then
        CommonTips.OpenTips(80607586)
        return
      end
      if roleCountMap[roleId] == nil then
        roleCountMap[roleId] = 1
      else
        CommonTips.OpenTips(80607587)
        return
      end
    end
  end
  Controller:SaveCurLevelRoleList()
  local levelList = abyssCA.levelList
  local curSquad = {}
  local roleList1 = {}
  local roleList = DataModel.levelRoleList[1]
  for i = 1, #roleList do
    curSquad[i] = {
      id = roleList[i]
    }
    roleList1[#roleList1 + 1] = tonumber(roleList[i])
  end
  local nextSquad = {}
  roleList = DataModel.levelRoleList[2]
  for i = 1, #roleList do
    nextSquad[i] = {
      id = roleList[i]
    }
  end
  local difficulty = DataModel.difficulty or 1
  PlayerData.BattleInfo.nextLevel = {
    levelId = levelList[2].id,
    squad = nextSquad,
    difficulty = difficulty,
    abyssId = DataModel.teamKey
  }
  if DataModel.isDoubleTeam ~= true then
    PlayerData.Last_Chapter_Parms = {
      id = DataModel.turntableId,
      activityId = DataModel.activityId,
      isBattleReturn = true
    }
  else
    PlayerData.Last_Chapter_Parms = nil
    if DataModel.extraUIParamData ~= nil then
      PlayerData.Last_Chapter_Parms = {}
      for k, v in pairs(DataModel.extraUIParamData) do
        PlayerData.Last_Chapter_Parms[k] = v
      end
    end
  end
  autoBattleVF.SetTeamData("Abyss_1" .. "_" .. DataModel.teamKey, roleList1, roleList1[1])
  PlayerData.BattleInfo.TeamKey = "Abyss_1" .. "_" .. DataModel.teamKey
  PlayerData.BattleCallBackPage = DataModel.battleCallBackPage
  StartBattle:StartAbyssBattle(levelList[1].id, curSquad, difficulty)
  return true
end

function Controller:SaveCurLevelRoleList()
  local roleStr = ""
  local roleList = DataModel.levelRoleList
  for i = 1, #roleList do
    if 1 < i then
      roleStr = roleStr .. ";"
    end
    for j = 1, #roleList[i] do
      if 1 < j then
        roleStr = roleStr .. ","
      end
      roleStr = roleStr .. roleList[i][j]
    end
  end
  PlayerData:SaveAbyssTeam(DataModel.teamKey, roleStr)
end

function Controller:BeginDrag(teamIndex, roleIndex)
  if DataModel.curFrameMouseUp then
    return
  end
  local roleId = DataModel.levelRoleList[teamIndex][roleIndex]
  if roleId == -1 then
    return
  end
  DataModel.isDrag = true
  DataModel.dragIdx = {team = teamIndex, role = roleIndex}
  local pos = Controller:GetMousePos()
  View.Group_RoleTemp.self:SetLocalPosition(pos)
  local roleData = PlayerData.ServerData.roles[roleId]
  local currentSkin = roleData.current_skin[1]
  local viewCA = PlayerData:GetFactoryData(currentSkin, "UnitViewFactory")
  View.Group_RoleTemp.Group_On.Spine_Role:SetData(viewCA.resDir, "stun")
  View.Group_RoleTemp.self:SetActive(true)
  Controller:SelectLevel(-1)
end

function Controller:CalcDragingPos()
  local levelCount = View.Group_Level.StaticGrid_Level.self.DataCount
  local toTeam = -1
  local toIdx = -1
  for i = 1, levelCount do
    local groupLevel = View.Group_Level.StaticGrid_Level.grid[i]
    local groupRoleList = groupLevel.StaticGrid_RoleList
    local pos = groupRoleList.self.transform:InverseTransformPoint(View.Group_RoleTemp.self.transform.position)
    for j = 1, groupRoleList.self.DataCount do
      local gridPos = groupRoleList.grid[j].self.transform.localPosition
      if math.abs(gridPos.x - pos.x) <= 60 and math.abs(gridPos.y - pos.y) <= 100 then
        toTeam = i
        toIdx = j
        break
      end
    end
    if toTeam ~= -1 and toIdx ~= -1 then
      break
    end
  end
  return toTeam, toIdx
end

function Controller:DragEnd()
  local toTeam, toIdx = Controller:CalcDragingPos()
  if toTeam ~= -1 and toIdx ~= -1 and (DataModel.dragIdx.team ~= toTeam or DataModel.dragIdx.role ~= toIdx) then
    Controller:ExchangeSingleRole(DataModel.dragIdx.team, DataModel.dragIdx.role, toTeam, toIdx)
  end
  DataModel.dragIdx = {}
  View.Group_RoleTemp.self:SetActive(false)
  Controller:SelectLevel(-1)
end

function Controller:GetMousePos()
  local minScale = math.min(GameSetting.scaleWidth, GameSetting.scaleHeight)
  local position = Input.mousePosition
  position = Vector3((position.x - Screen.width * 0.5) / minScale, (position.y - Screen.height * 0.5) / minScale, position.z)
  return position
end

function Controller:OnClickReturn()
  local curLevelIndex = DataModel.curLevelIndex
  if curLevelIndex ~= -1 then
    View.self:PlayAnimOnce("Animation_SelectClose", function()
      Controller:SelectLevel(-1)
    end)
    return
  end
  Controller:SaveCurLevelRoleList()
  View.self:PlayAnimOnce("Animation_out", function()
    View.self:SetAlpha(1)
    UIManager:GoBack()
  end)
end

function Controller:OnClickHome()
  local curLevelIndex = DataModel.curLevelIndex
  if curLevelIndex ~= -1 then
    View.self:PlayAnimOnce("Animation_SelectClose", function()
      Controller:SelectLevel(-1)
    end)
    return
  end
  Controller:SaveCurLevelRoleList()
  UIManager:GoHome()
end

function Controller:OnClickSelectLevel(str)
  local curLevelIndex = DataModel.curLevelIndex
  Controller:SelectLevel(tonumber(str))
  if curLevelIndex == -1 then
    View.self:PlayAnimOnce("Animation_SelectOpen")
  end
end

function Controller:OnClickLevelBtn()
  Controller:ClearAllTeam()
  if DataModel.selectMode == 1 then
    View.Group_Select.Group_RoleList.ScrollGrid_RoleList.grid.self:RefreshAllElement()
  elseif DataModel.selectMode == 2 then
    View.Group_Select.Group_TeamList.ScrollGrid_TeamList.grid.self:RefreshAllElement()
  end
  View.Group_Level.StaticGrid_Level.grid.self:RefreshAllElement()
end

function Controller:OnClickBtnAuto(str)
  local roleList = DataModel.levelRoleList[tonumber(str)]
  local aiRoleList = {}
  for i = 1, #roleList do
    aiRoleList[#aiRoleList + 1] = tonumber(roleList[i])
  end
  Controller:SaveCurLevelRoleList()
  UIManager:Open("UI/Battle/AutoBattle/New/AutoBattle", Json.encode({
    teamKey = "Abyss_" .. str .. "_" .. DataModel.teamKey,
    roleList = aiRoleList,
    header = aiRoleList[1]
  }))
end

function Controller:OnClickLevelRole(str)
  local params = string.split(str, ":")
  local teamIndex = tonumber(params[1])
  local roleIndex = tonumber(params[2])
  local curLevelIndex = DataModel.curLevelIndex
  if (curLevelIndex == -1 or DataModel.curLevelIndex == teamIndex) and DataModel.levelRoleList[teamIndex][roleIndex] ~= -1 then
    if curLevelIndex == -1 then
      local roleId = DataModel.levelRoleList[teamIndex][roleIndex]
      local hasForbidUR = false
      local forbidIndex = 1
      local urequip = Controller:GetUrEquipData(teamIndex)
      if urequip[tostring(roleId)] then
        for i = 1, 3 do
          if urequip[tostring(roleId)][i] and tonumber(urequip[tostring(roleId)][i].id) ~= nil and urequip[tostring(roleId)][i].isUse == false then
            hasForbidUR = true
            forbidIndex = i
            break
          end
        end
      end
      if hasForbidUR then
        DataModel.RoleData = PlayerData:GetRoleById(roleId)
        DataModel.DupesIndex = teamIndex
        View.Group_DupesEquip.Group_Main.Group_Slots.self:SetActive(true)
        Controller:RefreshDupesEquip(forbidIndex)
        View.self:SelectPlayAnim(View.Group_DupesEquip.self, "Group_DupesEquip_Show", function()
        end)
      else
        do
          local data = {
            currentRoleId = roleId,
            fromView = EnumDefine.CommonFilterType.SquadView
          }
          Net:SendProto("hero.info", function(json)
            if json.roles then
              Controller:SaveCurLevelRoleList()
              PlayerData.ServerData.roles[roleId] = json.roles[roleId]
              UIManager:Open("UI/CharacterInfo/CharacterInfo", Json.encode(data))
            end
          end, tonumber(roleId))
        end
      end
    else
      Controller:OnClickRoleBtn(DataModel.levelRoleList[teamIndex][roleIndex])
    end
  else
    Controller:SelectLevel(teamIndex)
    if curLevelIndex == -1 then
      View.self:PlayAnimOnce("Animation_SelectOpen")
    end
  end
end

function Controller:GetTeamKey(teamIndex)
  return "Abyss_" .. teamIndex .. "_" .. DataModel.teamKey
end

function Controller:RefreshUrEquip(index)
  local equipData = self:GetUrEquipData(index)
  local hasRoleMap = {}
  local roleList = DataModel.levelRoleList[index]
  for i = 1, #roleList do
    local roleId = roleList[i]
    if next(PlayerData:GetRoleById(roleId)) ~= nil then
      local role = GetPlayerRoleData(roleId)
      if role.unitId ~= nil then
        hasRoleMap[tostring(role.unitId)] = true
        for j = 1, 3 do
          local equipId = role["equip" .. j .. "Id"]
          if equipId and tonumber(equipId) and tonumber(equipId) > 0 then
            if equipData[tostring(role.unitId)] == nil then
              equipData[tostring(role.unitId)] = {}
            end
            if equipData[tostring(role.unitId)][j] == nil then
              equipData[tostring(role.unitId)][j] = {}
            end
            if equipData[tostring(role.unitId)][j].id ~= equipId then
              equipData[tostring(role.unitId)][j].id = equipId
              equipData[tostring(role.unitId)][j].isUse = nil
            end
          else
            if equipData[tostring(role.unitId)] == nil then
              equipData[tostring(role.unitId)] = {}
            end
            equipData[tostring(role.unitId)][j] = {id = "", isUse = false}
          end
        end
      end
    end
  end
  for k, v in pairs(equipData) do
    if hasRoleMap[k] ~= true then
      equipData[k] = nil
    end
  end
  local usingEquip = {}
  for k, v in pairs(equipData) do
    for j = 1, 3 do
      local eData = v[j]
      if eData.isUse == true then
        usingEquip[tostring(eData.id)] = true
      end
    end
  end
  for k, v in pairs(equipData) do
    for j = 1, 3 do
      local eData = v[j]
      if eData.isUse ~= true and usingEquip[tostring(eData.id)] ~= true then
        usingEquip[tostring(eData.id)] = true
        eData.isUse = true
      elseif eData.isUse ~= true then
        local eCA = PlayerData:GetFactoryData(eData.id)
        eData.isUse = eCA and eCA.quality ~= "Orange" or false
      end
    end
  end
  self:SaveUrEquipData(equipData, index)
end

function Controller:CompressData(str)
  local compMs = CS.System.IO.MemoryStream()
  local zipStream = CS.System.IO.Compression.DeflateStream(compMs, CS.System.IO.Compression.CompressionMode.Compress, false)
  local l, byte, byteList = string.getLength(str)
  zipStream:Write(str, 0, byte)
  zipStream:Close()
  local press = compMs:ToArray()
  local str64 = CS.System.Convert.ToBase64String(press)
  return str64
end

function Controller:isBase64(str)
  local base64Chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
  local pattern = "^[" .. base64Chars .. "]*[=]*$"
  local isMatch = string.match(str, pattern)
  if isMatch then
    local len = string.len(str)
    if len % 4 == 0 or len % 4 == 1 and str:sub(-1) == "=" or len % 4 == 2 and str:sub(-2) == "==" then
      return true
    end
  end
  return false
end

function Controller:DeCompressData(str64)
  if str64 == "" or not self:isBase64(str64) then
    return "{}"
  end
  local str
  
  local function decompress()
    str64 = CS.System.Convert.FromBase64String(str64)
    local og = CS.System.IO.MemoryStream(str64)
    local gzi = CS.System.IO.Compression.DeflateStream(og, CS.System.IO.Compression.CompressionMode.Decompress, false)
    local tg = CS.System.IO.MemoryStream()
    gzi:CopyTo(tg)
    str = tg:ToArray()
  end
  
  if pcall(decompress) then
    return str or "{}"
  else
    return "{}"
  end
end

function Controller:GetUrEquipData(index)
  local serverEquip = PlayerData.ServerData.ur_equip or {}
  local teamKey = self:GetTeamKey(index)
  local equipStr = serverEquip[teamKey] or {}
  equipStr = equipStr.code or ""
  equipStr = self:DeCompressData(equipStr)
  local equipData = Json.decode(equipStr)
  return equipData
end

function Controller:SaveUrEquipData(equipData, index)
  local equipStr = Json.encode(equipData)
  equipStr = self:CompressData(equipStr)
  local teamKey = self:GetTeamKey(index)
  if PlayerData.ServerData.ur_equip == nil then
    PlayerData.ServerData.ur_equip = {}
  end
  if PlayerData.ServerData.ur_equip[teamKey] == nil then
    PlayerData.ServerData.ur_equip[teamKey] = {}
  end
  PlayerData.ServerData.ur_equip[teamKey].code = equipStr
  Net:SendProto("deck.deck_equip", function(json)
  end, equipStr, teamKey)
end

function Controller:OnClickSlot(index)
  local eid = DataModel.RoleData.equips[index]
  local equip = type(eid) == "table" and eid or PlayerData:GetEquipByEid(eid)
  local eCA = equip and PlayerData:GetFactoryData(equip.id) or {}
  if eCA.quality ~= "Orange" then
    if index == 1 then
      CommonTips.OpenTips(80612084)
    elseif index == 2 then
      CommonTips.OpenTips(80612085)
    elseif index == 3 then
      CommonTips.OpenTips(80612086)
    end
    return
  end
  Controller:RefreshDupesEquip(index)
end

function Controller:RefreshDupesEquip(index)
  local urequip = Controller:GetUrEquipData(DataModel.DupesIndex)
  CommonTips:OpenDupesEquip(View, DataModel.RoleData, index, urequip)
  for i = 1, 3 do
    if i == index then
      View.Group_DupesEquip.Group_Main.Group_Slots["Group_Slots_0" .. i]:SelectPlayAnim("Group_Slots_Active")
    else
      View.Group_DupesEquip.Group_Main.Group_Slots["Group_Slots_0" .. i]:SelectPlayAnim("Group_Slots_Deactive")
    end
  end
end

function Controller:ClickUrEquipRole(str)
  local param = string.split(str, ":")
  local equipData = Controller:GetUrEquipData(DataModel.DupesIndex)
  if equipData[param[1]][tonumber(param[2])].isUse then
    return
  end
  DataModel.RoleData = PlayerData:GetRoleById(param[1])
  CommonTips:SetNewUrEquip(View, DataModel.RoleData, tonumber(param[2]), equipData, function()
    Controller:SaveUrEquipData(equipData, DataModel.DupesIndex)
  end)
  Controller:RefreshDupesEquip(tonumber(param[2]))
  View.Group_Level.StaticGrid_Level.grid.self:RefreshAllElement()
end

return Controller
