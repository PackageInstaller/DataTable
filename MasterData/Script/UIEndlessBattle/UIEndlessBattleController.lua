local View = require("UIEndlessBattle/UIEndlessBattleView")
local DataModel = require("UIEndlessBattle/UIEndlessBattleDataModel")
local CommonItem = require("Common/BtnItem")
local autoBattle = require("UIAutoBattle/UIAutoBattleDataModel")
local autoBattleVF = require("UIAutoBattle/UIAutoBattleViewFunction")
local StartBattle = require("UISquads/View_StartBattle")
local Controller = {}

function Controller:GetDataModel()
  return DataModel
end

function Controller:Init()
  PlayerData.BattleInfo.UrEquipData = nil
  local activityCA = PlayerData:GetFactoryData(DataModel.activityId)
  DataModel.activityCA = activityCA
  Controller:InitRoleSelect()
  Controller:CloseTeamSelect()
  local diff = self:GetDiff()
  if diff > #DataModel.activityCA.endlessLevelList then
    View.Group_Finish:SetActive(true)
  else
    View.Group_Finish:SetActive(false)
  end
  Controller:UpdateLevel()
  local powerRoleList = activityCA.powerRoleList
  DataModel.powerRoleList = powerRoleList
  View.Group_PowerRole.StaticGrid_RoleList.grid.self:SetDataCount(#powerRoleList)
  View.Group_PowerRole.StaticGrid_RoleList.grid.self:RefreshAllElement()
  View.Group_PowerRole.Group_Help:SetActive(false)
  DataModel.isHelpOpen = false
  View.Group_PowerRole.Group_Help.Txt_D:SetText(string.format(GetText(80610693), activityCA.powerLv))
end

function Controller:UpdateLevel()
  local diff = self:GetDiff()
  local showDiff = diff
  if diff > #DataModel.activityCA.endlessLevelList then
    showDiff = #DataModel.activityCA.endlessLevelList
  end
  local levelCA = PlayerData:GetFactoryData(DataModel.activityCA.endlessLevelList[showDiff].id)
  DataModel.curLevel = levelCA
  View.Group_BossInfo.Group_Name.Txt_Name:SetText(levelCA.levelName)
  if showDiff == #DataModel.activityCA.endlessLevelList then
    View.Group_BossInfo.Txt_D:SetText(GetText(80610582))
  else
    View.Group_BossInfo.Txt_D:SetText(showDiff)
  end
  local bossCA = PlayerData:GetFactoryData(levelCA.bossId)
  local bossViewCA = PlayerData:GetFactoryData(bossCA.viewId)
  View.Group_BossInfo.Spine_Role:SetData(bossViewCA.resDir, "stand")
  if diff > #DataModel.activityCA.endlessLevelList then
    View.Group_Finish.Spine_Role:SetData(bossViewCA.resDir, "stand")
  end
  View.Group_BossInfo.Group_Name.Btn_Detail:SetClickParam(levelCA.id)
  local prog = self:GetProg()
  View.Group_BossInfo.Group_Hp.Img_Bar:SetFilledImgAmount(1 - prog)
  local hp = self:GetBossHP()
  View.Group_BossInfo.Group_Hp.Txt_Num:SetText(math.floor(hp * (1 - prog)) .. "/" .. math.floor(hp))
  View.Group_Preview.ScrollGrid_Reward.grid.self:SetDataCount(#levelCA.firstPassAward)
  View.Group_Preview.ScrollGrid_Reward.grid.self:RefreshAllElement()
  View.Group_Preview.ScrollGrid_Reward.grid.self:MoveToTop()
  local roleNum = table.count(PlayerData.ServerData.roles)
  local isAllLose = self:GetLoseTeamNum() >= math.min(4, math.floor(roleNum / 5))
  View.Btn_Start:SetActive(not isAllLose)
  View.Btn_Revive:SetActive(isAllLose)
  if isAllLose then
    local maxReviveNum = DataModel.activityCA.endlessRefresh or 0
    local curCount = DataModel.user_endless.reset_count or 0
    local remainCount = maxReviveNum - curCount
    View.Btn_Revive.Txt_Num:SetText(remainCount .. "/" .. maxReviveNum)
    self:OpenReviveGroup(true)
  else
    self:CloseReviveGroup()
  end
  local diffPre = DataModel.lastDiff
  if diffPre ~= nil and showDiff > diffPre then
    if diffPre < 10 then
      View.Group_Upgrade.Txt_LevelPre:SetText(0 .. diffPre)
    else
      View.Group_Upgrade.Txt_LevelPre:SetText(diffPre)
    end
    if showDiff < 10 then
      View.Group_Upgrade.Txt_Level:SetText(0 .. showDiff)
    else
      View.Group_Upgrade.Txt_Level:SetText(showDiff)
    end
    View.Group_Upgrade:SetActive(true)
    View.self:SelectPlayAnim(View.Group_Upgrade.self, "Animation_Upgrade", function()
      View.Group_Upgrade:SetActive(false)
    end)
    DataModel.lastDiff = nil
  else
    View.Group_Upgrade:SetActive(false)
  end
end

function Controller:OnSetRewardGrid(element, elementIndex)
  CommonItem:SetItem(element.Group_Item, {
    id = DataModel.curLevel.firstPassAward[elementIndex].itemId,
    num = DataModel.curLevel.firstPassAward[elementIndex].num
  })
  element.Group_Item.Btn_Item:SetClickParam(DataModel.curLevel.firstPassAward[elementIndex].itemId)
end

function Controller:OnClickReward(str)
  local itemId = tonumber(str)
  CommonTips.OpenPreRewardDetailTips(itemId)
end

function Controller:UpdateTeam()
  View.Group_TeamGroup.StaticGrid_Team.grid.self:SetDataCount(#DataModel.levelRoleList)
  View.Group_TeamGroup.StaticGrid_Team.grid.self:RefreshAllElement()
end

function Controller:OnSetLevelGrid(element, elementIndex)
  element.Txt_Index:SetText(0 .. elementIndex)
  element.Group_Lose:SetActive(elementIndex <= Controller:GetLoseTeamNum())
  local roleList = DataModel.levelRoleList[elementIndex]
  element.StaticGrid_Role.grid.self:SetParentParam(elementIndex)
  element.StaticGrid_Role.grid.self:SetDataCount(#roleList)
  element.StaticGrid_Role.grid.self:RefreshAllElement()
  element.Group_Selected:SetActive(DataModel.curTeamIndex == elementIndex)
  element.Btn_Edit:SetActive(DataModel.curTeamIndex ~= elementIndex)
  element.Btn_Auto:SetClickParam(elementIndex)
  element.Btn_Edit:SetClickParam(elementIndex)
end

function Controller:OnSetLevelRoleGrid(element, elementIndex)
  local teamIndex = tonumber(element.ParentParam)
  local roleList = DataModel.levelRoleList[teamIndex]
  local roleId = tostring(roleList[elementIndex])
  local roleData = PlayerData.ServerData.roles[roleId]
  element.Img_Captain:SetActive(elementIndex == 1)
  element.Img_Head:SetActive(roleData ~= nil)
  element.Txt_Lv:SetActive(roleData ~= nil)
  if roleData == nil then
    element.Btn_Click:SetClickParam("")
    return
  end
  element.Txt_Lv:SetText(string.format(GetText(80601968), roleData.lv))
  local currentSkin = roleData.current_skin[1]
  local viewCA = PlayerData:GetFactoryData(currentSkin, "UnitViewFactory")
  element.Img_Head:SetSprite(viewCA.face)
  element.Btn_Click:SetClickParam(roleId)
  local hasForbidUR = false
  local urequip = Controller:GetUrEquipData(teamIndex)
  if urequip[tostring(roleId)] then
    for i = 1, 3 do
      if urequip[tostring(roleId)][i] and tonumber(urequip[tostring(roleId)][i].id) ~= nil and urequip[tostring(roleId)][i].isUse == false then
        hasForbidUR = true
        break
      end
    end
  end
  if element.Img_Disable then
    element.Img_Disable:SetActive(hasForbidUR)
  end
end

function Controller:InitRoleSelect()
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
    },
    [3] = {
      -1,
      -1,
      -1,
      -1,
      -1
    },
    [4] = {
      -1,
      -1,
      -1,
      -1,
      -1
    }
  }
  DataModel.levelSquadIndex = {
    [1] = -1,
    [2] = -1,
    [3] = -1,
    [4] = -1
  }
  self:InitRoleList()
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
  self:UpdateTeam()
end

function Controller:InitRoleList()
  DataModel.AutoBattleData = {}
  for i = 1, 4 do
    local roleList = Controller:GetTeamByIndex(i)
    local roleList1 = {}
    for j = 1, #roleList do
      local roleId = tonumber(roleList[j])
      if not self:IsRoleUnlock(roleId) then
        roleId = -1
      end
      roleList1[#roleList1 + 1] = roleId
      Controller:AddRoleToTeam(roleId, i, true)
    end
    Controller:RefreshUrEquip(i)
    autoBattleVF.SetTeamData("Endless_" .. i, roleList1, roleList1[1])
    DataModel.AutoBattleData[i] = autoBattle.CurrentData
  end
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
  for k, v in pairs(PlayerData.ServerData.roles) do
    if v ~= nil and next(v) ~= nil then
      local roleCA = PlayerData:GetFactoryData(k)
      if (not (table.count(DataModel.FilterMap.Group_Career.list) > 0) or DataModel.FilterMap.Group_Career.list[roleCA.line] == true) and (not (0 < table.count(DataModel.FilterMap.Group_Group.list)) or DataModel.FilterMap.Group_Group.list[PlayerData:SearchRoleCampInt(roleCA.sideId)] == true) and (not (0 < table.count(DataModel.FilterMap.Group_Rarity.list)) or DataModel.FilterMap.Group_Rarity.list[roleCA.qualityInt] == true) then
        table.insert(DataModel.Roles, tostring(k))
      end
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
  if DataModel.roleCheckMap[tostring(roleId)] ~= nil then
    element.Group_InTeam:SetActive(true)
    local teamIdx = DataModel.roleCheckMap[tostring(roleId)].team
    element.Group_InTeam.Txt_Team:SetText(string.format(GetText(80607584), teamIdx))
    if element.Group_Bg ~= nil then
      element.Group_Bg.Img_1:SetActive(true)
      element.Group_Bg.Img_2:SetActive(false)
      element.Group_Bg.Img_1:SetSprite(DataModel.RoleBgPath[teamIdx])
    end
  else
    element.Group_InTeam:SetActive(false)
    if element.Group_Bg ~= nil then
      element.Group_Bg.Img_1:SetActive(false)
      element.Group_Bg.Img_2:SetActive(false)
    end
  end
  if element.Img_Defeat then
    element.Img_Defeat:SetActive(self:IsRoleLose(roleId))
  end
  if element.Btn_Click ~= nil then
    element.Btn_Click:SetClickParam(roleId)
  end
end

function Controller:OnClickRoleBtn(roleId, notSave)
  local teamIndex = DataModel.curTeamIndex
  local curRoleTeam = DataModel.roleCheckMap[tostring(roleId)]
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
  View.Group_TeamGroup.StaticGrid_Team.grid.self:RefreshAllElement()
end

function Controller:AddRoleToTeam(roleId, teamIndex, notSave)
  if not self:IsRoleUnlock(roleId) then
    return
  end
  if self:IsRoleLose(roleId) then
    return
  end
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
  DataModel.roleCheckMap[tostring(roleId)] = {team = teamIndex, idx = order}
  DataModel.levelSquadIndex[teamIndex] = -1
  if DataModel.AutoBattleData ~= nil and DataModel.AutoBattleData[teamIndex] ~= nil then
    autoBattle:AddCardsByUnitId(DataModel.AutoBattleData[teamIndex], tonumber(roleId))
    if notSave ~= true then
      local str = Json.encode(DataModel.AutoBattleData[teamIndex])
      local autoKey = "CardAIDataEndless_" .. teamIndex
      PlayerData:SetPlayerPrefs("string", autoKey, str, true)
      local cData = autoBattleVF:GetCloudData(autoKey)
      if cData.is_open and cData.is_open == "1" then
        str = Json.encode(DataModel.AutoBattleData[teamIndex])
        autoBattleVF:SaveCloudData(autoKey, str)
      end
      Controller:RefreshUrEquip(teamIndex)
    end
  end
end

function Controller:RemoveRoleToTeam(roleId, notSave)
  if self:IsRoleLose(roleId) then
    return
  end
  local curTeam = DataModel.roleCheckMap[tostring(roleId)]
  if curTeam ~= nil then
    local curRoleList = DataModel.levelRoleList[curTeam.team]
    curRoleList[curTeam.idx] = -1
    DataModel.roleCheckMap[tostring(roleId)] = nil
    DataModel.levelSquadIndex[curTeam.team] = -1
    if DataModel.AutoBattleData ~= nil and DataModel.AutoBattleData[curTeam.team] ~= nil then
      autoBattle:RemoveCardsByUnitId(DataModel.AutoBattleData[curTeam.team], tonumber(roleId))
      if notSave ~= true then
        local str = Json.encode(DataModel.AutoBattleData[curTeam.team])
        local autoKey = "CardAIDataEndless_" .. curTeam.team
        PlayerData:SetPlayerPrefs("string", autoKey, str, true)
        local cData = autoBattleVF:GetCloudData(autoKey)
        if cData.is_open and cData.is_open == "1" then
          str = Json.encode(DataModel.AutoBattleData[curTeam.team])
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
  if self:IsRoleLose(fromRoleId) or self:IsRoleLose(toRoleId) then
    return
  end
  DataModel.levelRoleList[toTeam][toIndex] = fromRoleId
  if fromRoleId ~= -1 then
    DataModel.roleCheckMap[tostring(fromRoleId)] = {team = toTeam, idx = toIndex}
  end
  DataModel.levelRoleList[fromTeam][fromIndex] = toRoleId
  if toRoleId ~= -1 then
    DataModel.roleCheckMap[tostring(toRoleId)] = {team = fromTeam, idx = fromIndex}
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
  local teamIndex = DataModel.curTeamIndex
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
    local tKey = "CardAIDataEndless_" .. teamIndex
    PlayerData:SetPlayerPrefs("string", tKey, autoStr, true)
    local cData = autoBattleVF:GetCloudData(tKey)
    if cData.is_open and cData.is_open == "1" then
      autoStr = Json.encode(DataModel.AutoBattleData[teamIndex])
      autoBattleVF:SaveCloudData(tKey, autoStr)
    end
  end
  if DataModel.selectMode == 2 then
    View.Group_Select.Group_TeamList.ScrollGrid_TeamList.grid.self:RefreshAllElement()
  end
  Controller:RefreshUrEquip(teamIndex)
  View.Group_TeamGroup.StaticGrid_Team.grid.self:RefreshAllElement()
end

function Controller:ClearTeamByIndex(teamIndex, notSave)
  local curTeam = DataModel.levelRoleList[teamIndex]
  for i = 1, #curTeam do
    self:RemoveRoleToTeam(curTeam[i], true)
  end
  if notSave ~= true then
    local autoStr = Json.encode(DataModel.AutoBattleData[teamIndex])
    local tKey = "CardAIDataEndless_" .. teamIndex
    PlayerData:SetPlayerPrefs("string", tKey, autoStr, true)
    local cData = autoBattleVF:GetCloudData(tKey)
    if cData.is_open and cData.is_open == "1" then
      autoStr = Json.encode(DataModel.AutoBattleData[teamIndex])
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
      local tKey = "CardAIDataEndless_" .. i .. "_" .. DataModel.teamKey
      PlayerData:SetPlayerPrefs("string", tKey, autoStr, true)
      local cData = autoBattleVF:GetCloudData(tKey)
      if cData.is_open and cData.is_open == "1" then
        autoStr = Json.encode(DataModel.AutoBattleData[i])
        autoBattleVF:SaveCloudData(tKey, autoStr)
      end
      Controller:RefreshUrEquip(i)
    end
  end
end

function Controller:OnClickAutoBattle(str)
  local teamIndex = tonumber(str)
  if teamIndex <= self:GetLoseTeamNum() then
    return
  end
end

function Controller:OnClickEditTeam(str)
  local teamIndex = tonumber(str)
  if teamIndex == DataModel.curTeamIndex then
    return
  end
  if teamIndex <= self:GetLoseTeamNum() then
    return
  end
  DataModel.curTeamIndex = teamIndex
  self:OpenTeamSelect()
  View.Group_TeamGroup.StaticGrid_Team.grid.self:RefreshAllElement()
end

function Controller:OpenTeamSelect()
  if DataModel.isTeamSelectShow == true then
    return
  end
  DataModel.isTeamSelectShow = true
  View.Group_Select:SetActive(true)
end

function Controller:CloseTeamSelect()
  DataModel.curTeamIndex = nil
  DataModel.isTeamSelectShow = false
  View.Group_Select:SetActive(false)
  View.Group_TeamGroup.StaticGrid_Team.grid.self:RefreshAllElement()
end

function Controller:TryBattle()
  local diff = self:GetDiff()
  if diff > #DataModel.activityCA.endlessLevelList then
    CommonTips.OpenTips(80610584)
    return
  end
  local curIndex = self:GetLoseTeamNum() + 1
  if 4 < curIndex then
    return
  end
  local roleCountMap = {}
  for j = 1, #DataModel.levelRoleList[curIndex] do
    local roleId = DataModel.levelRoleList[curIndex][j]
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
  
  local function cb()
    local curSquad = {}
    local roleList1 = {}
    local powerRoleMap = {}
    for k, v in pairs(DataModel.activityCA.powerRoleList) do
      powerRoleMap[tostring(v.id)] = true
    end
    local hasPowerRole = false
    local roleList = DataModel.levelRoleList[curIndex]
    for i = 1, #roleList do
      if hasPowerRole == false and powerRoleMap[tostring(roleList[i])] == true then
        hasPowerRole = true
      end
      curSquad[i] = {
        id = roleList[i]
      }
      roleList1[#roleList1 + 1] = tonumber(roleList[i])
    end
    local extraLv = 0
    if hasPowerRole then
      extraLv = DataModel.activityCA.powerLv
    end
    PlayerData.Last_Chapter_Parms = {
      activityId = DataModel.activityId,
      lastDiff = self:GetDiff(),
      isBattleEnd = true
    }
    autoBattleVF.SetTeamData("Endless_" .. curIndex, roleList1, roleList1[1])
    PlayerData.BattleCallBackPage = "UI/Activity/ActivityEndlessBattle/EndlessBattle"
    local prog = self:GetProg()
    PlayerData.BattleInfo.TeamKey = "Endless_" .. curIndex
    StartBattle:StartEndlessBattle(DataModel.curLevel.id, curSquad, DataModel.activityId, prog, extraLv)
  end
  
  Controller:SaveCurLevelRoleList(cb)
  return true
end

function Controller:OpenReviveGroup(isInit)
  local maxReviveNum = DataModel.activityCA.endlessRefresh or 0
  local curCount = DataModel.user_endless.reset_count or 0
  local remainCount = maxReviveNum - curCount
  if remainCount <= 0 then
    if isInit ~= true then
      CommonTips.OpenTips(80610429)
    end
    return
  end
  DataModel.isReceiveOpen = true
  View.Group_Revive:SetActive(true)
  View.Group_Revive.Group_Middle.Txt_Count:SetText(remainCount)
end

function Controller:CloseReviveGroup()
  DataModel.isReceiveOpen = false
  View.Group_Revive:SetActive(false)
end

function Controller:OnClickReviveConfirm()
  local maxReviveNum = DataModel.activityCA.endlessRefresh or 0
  local curCount = DataModel.user_endless.reset_count or 0
  local remainCount = maxReviveNum - curCount
  if remainCount <= 0 then
    Controller:CloseReviveGroup()
    return
  end
  Net:SendProto("endless.rest_fail_team", function(json)
    DataModel.user_endless = json.user_endless
    Controller:Init()
  end, DataModel.activityCA.id)
end

function Controller:GetTeamByIndex(index)
  local rt = DataModel.user_endless.team[tostring(index)] or {}
  for i = 1, #rt do
    local roleId = rt[i]
    if roleId == "" then
      rt[i] = -1
    else
      rt[i] = rt[i]
    end
  end
  return rt
end

function Controller:GetLoseTeamNum()
  local rt = #DataModel.user_endless.fail_team or {}
  return rt
end

function Controller:IsRoleLose(roleId)
  local loseNum = self:GetLoseTeamNum()
  for i = 1, loseNum do
    local team = DataModel.levelRoleList[i]
    for j = 1, #team do
      if roleId ~= -1 and tostring(team[j]) == tostring(roleId) then
        return true
      end
    end
  end
  return false
end

function Controller:GetBossHP()
  local levelCA = DataModel.curLevel
  local waveCA = PlayerData:GetFactoryData(levelCA.enemyWaveList[1].enemyWaveId)
  local bossCA = PlayerData:GetFactoryData(waveCA.enemyList[1].id)
  local rt = bossCA.hp_SN
  local lv = waveCA.lv
  local growthCA = PlayerData:GetFactoryData(bossCA.growthId)
  rt = rt + growthCA.gHp_SN * (lv - 1)
  rt = rt * waveCA.enemyList[1].hpRateSN
  rt = rt * SafeMath.safeNumberTime
  local tGfvo = DataManager.battleConfig.growthAttributeMultiCA.multiList[lv]
  rt = SafeMath.Multiplication(rt, tGfvo.hpMulti_SN)
  return math.floor(rt / SafeMath.safeNumberTime)
end

function Controller:GetDiff()
  local rt = DataModel.user_endless.difficulty_level or 1
  return rt
end

function Controller:GetProg()
  local rt = DataModel.user_endless.difficulty_progress or 0
  return rt
end

function Controller:OnClickReturn()
  local curTeamIndex = DataModel.curTeamIndex
  if curTeamIndex ~= nil then
    Controller:CloseTeamSelect()
    return
  end
  Controller:SaveCurLevelRoleList()
  UIManager:GoBack()
  if DataModel.backToActivity then
    UIManager:Open("UI/Activity/ActivityMain", Json.encode({
      id = DataModel.activityId
    }))
  end
end

function Controller:OnClickHome()
  local curTeamIndex = DataModel.curTeamIndex
  if curTeamIndex ~= nil then
    Controller:CloseTeamSelect()
    return
  end
  Controller:SaveCurLevelRoleList()
  UIManager:GoHome()
end

function Controller:SaveCurLevelRoleList(cb)
  local roleList = DataModel.levelRoleList
  local roleDic = {}
  for i = 1, #roleList do
    roleDic[tostring(i)] = {}
    for j = 1, #roleList[i] do
      if roleList[i][j] ~= -1 then
        roleDic[tostring(i)][j] = tostring(roleList[i][j])
      else
        roleDic[tostring(i)][j] = ""
      end
    end
  end
  local roleJson = Json.encode(roleDic)
  Net:SendProto("endless.save_team", function(json)
    DataModel.user_endless = json.user_endless
    if cb ~= nil then
      cb()
    end
  end, DataModel.activityId, roleJson)
end

function Controller:OnClickBtnAuto(str)
  local roleList = DataModel.levelRoleList[tonumber(str)]
  local aiRoleList = {}
  for i = 1, #roleList do
    aiRoleList[#aiRoleList + 1] = tonumber(roleList[i])
  end
  local usableRoles = {}
  for k, v in pairs(PlayerData.ServerData.roles) do
    if not self:IsRoleLose(k) then
      usableRoles[k] = v
    end
  end
  Controller:SaveCurLevelRoleList()
  UIManager:Open("UI/Battle/AutoBattle/New/AutoBattle", Json.encode({
    teamKey = "Endless_" .. str,
    roleList = aiRoleList,
    header = aiRoleList[1],
    usableRoles = usableRoles
  }))
end

function Controller:IsRoleUnlock(roleId)
  local role = PlayerData:GetRoleById(roleId)
  if role and next(role) ~= nil then
    return true
  end
  return false
end

function Controller:GetTeamKey(teamIndex)
  return "Endless_" .. teamIndex
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
  View.Group_TeamGroup.StaticGrid_Team.grid.self:RefreshAllElement()
end

return Controller
