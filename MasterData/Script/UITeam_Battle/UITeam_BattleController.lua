local View = require("UITeam_Battle/UITeam_BattleView")
local DataModel
local autoBattle = require("UIAutoBattle/UIAutoBattleDataModel")
local autoBattleVF = require("UIAutoBattle/UIAutoBattleViewFunction")
local RogueController = require("UICubeRogueMain/UICubeRoguewMainController")
local Controller = {}

function Controller:SetDataModel(modelStr)
  DataModel = require(modelStr)
end

function Controller:GetDataModel()
  return DataModel
end

function Controller:Init(isReopen)
  View.Img_Title:SetSprite(GetResPath(88300175))
  View.Btn_Battle:SetSprite(GetResPath(88300191))
  if isReopen ~= true then
    DataModel.curLevelIndex = -1
    DataModel.dragIdx = {}
    DataModel.roleCheckMap = {}
    DataModel.levelRoleList = {
      -1,
      -1,
      -1,
      -1,
      -1
    }
    DataModel.levelSquadIndex = -1
  end
  DataModel.AutoBattleData = nil
  if DataModel.mode ~= "InitCube" then
    local isRemoveRole = false
    Controller:ClearAllTeam(true)
    local roleList = PlayerData.TempCache.CubeRogueData.deck
    for k in pairs(roleList) do
      local hp = RogueController:GetRoleHpPercent(k)
      if 0 < hp then
        Controller:AddRoleToTeam(k, true)
      else
        isRemoveRole = true
      end
    end
    for i = 2, #DataModel.levelRoleList do
      local roleId = DataModel.levelRoleList[i]
      if roleList[roleId] ~= nil and roleList[roleId].header == 1 then
        Controller:ExchangeSingleRole(1, 1, 1, i, true)
        break
      end
    end
    if isRemoveRole then
      DataModel.isDataChange = true
      Controller:SaveCubeDeck()
    end
  end
  local roleList1 = Controller:GetRoleIdNumberList()
  autoBattleVF.SetTeamData("Cube", roleList1, roleList1[1])
  DataModel.AutoBattleData = autoBattle.CurrentData
  self:InitFilterSetting()
  self:RefreshRoleListByFilter()
  DataModel.curSortType = nil
  DataModel.sortReverseMap = {
    [1] = false,
    [2] = false,
    [3] = false
  }
  self:SetRoleSortType(1, true)
  DataModel.selectMode = nil
  self:SetSelectMode(1)
  Controller:OnClickSelectLevel(1)
  Controller:OnSetLevelGrid(View.Group_Team, 1)
  local isBattleShow = DataModel.mode == "InitCube" or DataModel.levelId ~= nil
  View.Btn_Battle:SetActive(isBattleShow)
  if isBattleShow then
    View.ScrollGrid_RoleList.grid.self:SetWidth(1435)
  else
    View.ScrollGrid_RoleList.grid.self:SetWidth(1920)
  end
end

function Controller:GetRoleIdNumberList()
  local roleList1 = {}
  local roleList = DataModel.levelRoleList
  for j = 1, #roleList do
    roleList1[#roleList1 + 1] = tonumber(roleList[j])
  end
  return roleList1
end

function Controller:InitFilterSetting()
  DataModel.FilterMap = {
    Group_Group = {
      maxCount = 0,
      list = {}
    },
    Group_Rarity = {
      maxCount = 0,
      list = {}
    }
  }
  DataModel.SpecialTag = {
    All = {
      maxCount = 0,
      list = {}
    },
    Occupation = {
      maxCount = 0,
      list = {}
    },
    Hit = {
      maxCount = 0,
      list = {}
    },
    Technology = {
      maxCount = 0,
      list = {}
    }
  }
  DataModel.SpecialTagMap = {}
end

function Controller:RefreshRoleListByFilter()
  DataModel.Roles = {}
  local roles = PlayerData.ServerData.roles
  if DataModel.mode ~= "InitCube" then
    roles = PlayerData.TempCache.CubeRogueData.roles
  end
  for k in pairs(roles) do
    local roleCA = PlayerData:GetFactoryData(k)
    if roleCA ~= nil and (not (table.count(DataModel.FilterMap.Group_Group.list) > 0) or DataModel.FilterMap.Group_Group.list[PlayerData:SearchRoleCampInt(roleCA.sideId)] == true) and (not (0 < table.count(DataModel.FilterMap.Group_Rarity.list)) or DataModel.FilterMap.Group_Rarity.list[roleCA.qualityInt] == true) and self:CheckTagFilter(roleCA) and k ~= "" then
      table.insert(DataModel.Roles, tostring(k))
    end
  end
  local isFilterOn = false
  for k, v in pairs(DataModel.FilterMap) do
    if table.count(v.list) > 0 then
      isFilterOn = true
    end
  end
end

function Controller:InitCampGroup()
  local config = PlayerData:GetFactoryData(99900017).enumSideList
  local group = View.Screen_Chapter_New.Group_Group
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
      group[btn].Txt_:SetText(row.sideName)
      group[btn]:SetClickParam(k)
      length = length + 1
    end
  end
  DataModel.FilterMap.Group_Group.maxCount = length
end

function Controller:InitRarityGroup()
  local group = View.Screen_Chapter_New.Group_Rarity
  local length = 0
  for k, v in pairs(group) do
    if k ~= "self" and k ~= "Txt_" and k ~= "Btn_All" then
      length = length + 1
    end
  end
  for i = 1, length do
    local btn = "Btn_G0" .. i
    group[btn]:SetClickParam(i)
  end
  DataModel.FilterMap.Group_Rarity.maxCount = length
end

function Controller:InitSpecialTagGroup()
  local config = PlayerData:GetFactoryData(80304554)
  local curList = config.occList
  local length = #curList
  for i = 1, length do
    local tag = curList[i].tagOcc
    table.insert(DataModel.SpecialTag.All.list, tag)
    table.insert(DataModel.SpecialTag.Occupation.list, tag)
  end
  DataModel.SpecialTag.Occupation.maxCount = length
  curList = config.hitList
  length = #curList
  for i = 1, length do
    local tag = curList[i].tagHit
    table.insert(DataModel.SpecialTag.All.list, tag)
    table.insert(DataModel.SpecialTag.Hit.list, tag)
  end
  DataModel.SpecialTag.Hit.maxCount = length
  curList = config.tecList
  length = #curList
  for i = 1, length do
    local tag = curList[i].tagTec
    table.insert(DataModel.SpecialTag.All.list, tag)
    table.insert(DataModel.SpecialTag.Technology.list, tag)
  end
  DataModel.SpecialTag.Technology.maxCount = length
  DataModel.specialTagType = nil
end

function Controller:SetSpecialTagType(spType)
  if DataModel.specialTagType == spType then
    return
  end
  if DataModel.specialTagType ~= nil and View.Screen_Chapter_New.Group_Tag["Btn_" .. DataModel.specialTagType] ~= nil then
    View.Screen_Chapter_New.Group_Tag["Btn_" .. DataModel.specialTagType].Img_Select:SetActive(false)
  end
  DataModel.specialTagType = spType
  View.Screen_Chapter_New.Group_Tag["Btn_" .. spType].Img_Select:SetActive(true)
  View.Screen_Chapter_New.Group_Tag.Img_Bg.ScrollGrid_Tag.grid.self:SetDataCount(#DataModel.SpecialTag[spType])
  View.Screen_Chapter_New.Group_Tag.Img_Bg.ScrollGrid_Tag.grid.self:RefreshAllElement()
  View.Screen_Chapter_New.Group_Tag.Img_Bg.ScrollGrid_Tag.grid.self:MoveToTop()
end

function Controller:OnSetSpecialTagGrid(element, elementIndex)
  local spType = DataModel.specialTagType
  local tagList = DataModel.SpecialTag[spType]
  local tagId = tagList[elementIndex]
  element.Btn_Tag:SetClickParam(tagId)
  local isSelected = DataModel.SpecialTagMap[tagId] ~= nil
  element.Btn_Tag.Group_Off:SetActive(not isSelected)
  element.Btn_Tag.Group_On:SetActive(isSelected)
  local group
  if isSelected then
    group = element.Btn_Tag.Group_On
  else
    group = element.Btn_Tag.Group_Off
  end
  local tagCA = PlayerData:GetFactoryData(tagId)
  group.Img_Icon:SetSprite(tagCA.icon)
  group.Txt_Name:SetText(tagCA.tagName)
end

function Controller:AddTagFilterMap(val)
  if DataModel.SpecialTagMap[val] == true then
    DataModel.SpecialTagMap[val] = nil
  else
    DataModel.SpecialTagMap[val] = true
  end
  View.Screen_Chapter_New.Group_Tag.Img_Bg.ScrollGrid_Tag.grid.self:RefreshAllElement()
end

function Controller:CheckTagFilter(roleCA)
  if table.count(DataModel.SpecialTagMap) <= 0 then
    return true
  end
  local occList = roleCA.careerList
  for i = 1, #occList do
    if DataModel.SpecialTagMap[occList[i].des] == true then
      return true
    end
  end
  local classifyList = roleCA.classifyList
  for i = 1, #classifyList do
    if DataModel.SpecialTagMap[classifyList[i].des] == true then
      return true
    end
  end
  return true
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
  local group = View.Screen_Chapter_New[key]
  for i = 1, DataModel.FilterMap[key].maxCount do
    local btn
    if key == "Group_Rarity" then
      btn = "Btn_G0" .. i
    elseif key == "Group_Group" then
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
  local oldTagFilterMap = Clone(DataModel.SpecialTagMap)
  DataModel.oldTagFilterMap = oldTagFilterMap
  self:SetSpecialTagType("All")
  View.Screen_Chapter_New:SetActive(true)
end

function Controller:ExitRoleFilter(isConfirm)
  if isConfirm ~= true then
    for k, v in pairs(DataModel.FilterMap) do
      v.list = DataModel.oldFilterMap[k]
    end
    DataModel.SpecialTagMap = DataModel.oldTagFilterMap
  end
  DataModel.oldFilterMap = nil
  DataModel.oldTagFilterMap = nil
  View.Screen_Chapter_New:SetActive(false)
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
  if bType == 1 then
    self:SortRolesByLevel(DataModel.sortReverseMap[bType])
  elseif bType == 2 then
    self:SortRolesByQuality(DataModel.sortReverseMap[bType])
  elseif bType == 3 then
    self:SortRolesByObtainTime(DataModel.sortReverseMap[bType])
  end
  if isInit ~= true then
    View.ScrollGrid_RoleList.grid.self:RefreshAllElement()
  end
end

function Controller:RefreshBtnBySortType(btn, btnType)
  local curType = DataModel.curSortType
  btn.Img_Off:SetActive(curType ~= btnType or not DataModel.sortReverseMap[btnType])
  btn.Img_On:SetActive(curType == btnType and DataModel.sortReverseMap[btnType])
end

function Controller:SortRolesByLevel(isReverse)
  table.sort(DataModel.Roles, function(e1, e2)
    local roleData1 = RogueController:GetRoleExLv(e1)
    local roleData2 = RogueController:GetRoleExLv(e1)
    if roleData1 ~= roleData2 then
      return roleData1 > roleData2
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
  DataModel.selectMode = mode
  if DataModel.selectMode == 1 then
    self:UpdateRoleList()
  end
end

function Controller:UpdateRoleList()
  View.ScrollGrid_RoleList.grid.self:SetDataCount(#DataModel.Roles)
  View.ScrollGrid_RoleList.grid.self:RefreshAllElement()
  View.ScrollGrid_RoleList.grid.self:MoveToTop()
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
  local lvStr = PlayerData.GetCubeRoleLv() + RogueController:GetRoleExLv(roleId)
  element.Group_Lv.Txt_Num:SetText(math.floor(lvStr))
  local currentSkin = roleData.current_skin[1]
  local viewCA = PlayerData:GetFactoryData(currentSkin, "UnitViewFactory")
  element.Img_Face.Img_Face:SetSprite(viewCA.face)
  local roleCA = PlayerData:GetFactoryData(roleId)
  if element.Txt_Name then
    element.Txt_Name:SetText(roleCA.name)
  end
  local qualityInt = roleCA.qualityInt
  local bgPath = DataModel.RoleQualityPath[qualityInt]
  local maskPath = DataModel.RoleQualityMaskPath[qualityInt]
  element.Img_Quality:SetSprite(bgPath)
  element.Img_Mask:SetSprite(maskPath)
  if DataModel.roleCheckMap[roleId] ~= nil then
    if element.Group_Ready then
      element.Group_Ready:SetActive(true)
    end
  elseif element.Group_Ready then
    element.Group_Ready:SetActive(false)
  end
  element.Img_HealthBar:SetActive(true)
  local hp = RogueController:GetRoleHpPercent(roleId)
  local hpStatus = 1
  if hp < 0.6 and 0.2 <= hp then
    hpStatus = 2
    element.Img_HealthBar.Group_Num.Txt_Num:SetColor("#FF8A34")
    element.Img_HealthBar.Group_Num.Txt_0:SetColor("#FF8A34")
    element.Img_HealthBar.Img_Bar.Img_OrangeBar:SetFilledImgAmount(hp)
  elseif hp < 0.2 then
    hpStatus = 3
    element.Img_HealthBar.Group_Num.Txt_Num:SetColor("#FF4848")
    element.Img_HealthBar.Group_Num.Txt_0:SetColor("#FF4848")
    element.Img_HealthBar.Img_Bar.Img_RedBar:SetFilledImgAmount(hp)
  else
    element.Img_HealthBar.Group_Num.Txt_Num:SetColor("#44DD5E")
    element.Img_HealthBar.Group_Num.Txt_0:SetColor("#44DD5E")
    element.Img_HealthBar.Img_Bar.Img_GreenBar:SetFilledImgAmount(hp)
  end
  element.Img_HealthBar.Img_Bar.Img_GreenBar:SetActive(hpStatus == 1)
  element.Img_HealthBar.Img_Bar.Img_OrangeBar:SetActive(hpStatus == 2)
  element.Img_HealthBar.Img_Bar.Img_RedBar:SetActive(hpStatus == 3)
  element.Img_HealthBar.Group_Num.Txt_Num:SetText(math.ceil(hp * 100))
  if element.Btn_Click ~= nil then
    element.Btn_Click:SetClickParam(roleId)
  end
end

function Controller:OnClickRoleBtn(roleId, notSave)
  local hp = RogueController:GetRoleHpPercent(roleId)
  if hp <= 0 then
    return
  end
  local teamIndex = DataModel.curLevelIndex
  local curRoleTeam = DataModel.roleCheckMap[roleId]
  local curTeamIndex
  if curRoleTeam ~= nil then
    curTeamIndex = curRoleTeam.team
    self:RemoveRoleToTeam(roleId, notSave)
  end
  if teamIndex ~= -1 and curTeamIndex ~= teamIndex then
    self:AddRoleToTeam(roleId, notSave)
  end
  if DataModel.selectMode == 1 then
    View.ScrollGrid_RoleList.grid.self:RefreshAllElement()
  elseif DataModel.selectMode == 2 then
  end
  Controller:OnSetLevelGrid(View.Group_Team, 1)
end

function Controller:AddRoleToTeam(roleId, notSave)
  local tRoleList = DataModel.levelRoleList
  for i = 1, #tRoleList do
    if tRoleList[i] == roleId then
      return
    end
  end
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
  if notSave ~= true then
    DataModel.isDataChange = true
  end
  DataModel.roleCheckMap[roleId] = {team = 1, idx = order}
  DataModel.levelSquadIndex = -1
  if DataModel.AutoBattleData ~= nil then
    autoBattle:AddCardsByUnitId(DataModel.AutoBattleData, tonumber(roleId))
    if notSave ~= true then
      local str = Json.encode(DataModel.AutoBattleData)
      local autoKey = "CardAIDataCube"
      PlayerData:SetPlayerPrefs("string", autoKey, str, true)
      local cData = autoBattleVF:GetCloudData(autoKey)
      if cData.is_open and cData.is_open == "1" then
        autoBattleVF:SaveCloudData(autoKey, str)
      end
    end
  end
end

function Controller:RemoveRoleToTeam(roleId, notSave)
  local curTeam = DataModel.roleCheckMap[roleId]
  if curTeam ~= nil then
    DataModel.isDataChange = true
    local curRoleList = DataModel.levelRoleList
    curRoleList[curTeam.idx] = -1
    DataModel.roleCheckMap[roleId] = nil
    DataModel.levelSquadIndex = -1
    if DataModel.AutoBattleData ~= nil then
      autoBattle:RemoveCardsByUnitId(DataModel.AutoBattleData, tonumber(roleId))
      if notSave ~= true then
        local str = Json.encode(DataModel.AutoBattleData)
        local autoKey = "CardAIDataCube"
        PlayerData:SetPlayerPrefs("string", autoKey, str, true)
        local cData = autoBattleVF:GetCloudData(autoKey)
        if cData.is_open and cData.is_open == "1" then
          autoBattleVF:SaveCloudData(autoKey, str)
        end
      end
    end
  end
end

function Controller:ExchangeSingleRole(fromTeam, fromIndex, toTeam, toIndex, notSave)
  local fromRoleId = DataModel.levelRoleList[fromIndex]
  local toRoleId = DataModel.levelRoleList[toIndex]
  if fromRoleId ~= -1 and toRoleId ~= -1 and notSave ~= true then
    DataModel.isDataChange = true
  else
    DataModel.isDataChange = false
  end
  DataModel.levelRoleList[toIndex] = fromRoleId
  if fromRoleId ~= -1 then
    DataModel.roleCheckMap[fromRoleId] = {team = toTeam, idx = toIndex}
  end
  DataModel.levelRoleList[fromIndex] = toRoleId
  if toRoleId ~= -1 then
    DataModel.roleCheckMap[toRoleId] = {team = fromTeam, idx = fromIndex}
  end
  DataModel.levelSquadIndex = -1
  if DataModel.selectMode == 1 then
    View.ScrollGrid_RoleList.grid.self:RefreshAllElement()
  elseif DataModel.selectMode == 2 then
  end
end

function Controller:ClearTeamByIndex(notSave)
  local curTeam = DataModel.levelRoleList
  for i = 1, #curTeam do
    self:RemoveRoleToTeam(curTeam[i], true)
  end
  if notSave ~= true then
    local autoStr = Json.encode(DataModel.AutoBattleData)
    local tKey = "CardAIDataCube"
    PlayerData:SetPlayerPrefs("string", tKey, autoStr, true)
    local cData = autoBattleVF:GetCloudData(tKey)
    if cData.is_open and cData.is_open == "1" then
      autoBattleVF:SaveCloudData(tKey, autoStr)
    end
  end
end

function Controller:ClearAllTeam(notSave)
  self:ClearTeamByIndex(notSave)
end

function Controller:SelectLevel(index)
  DataModel.curLevelIndex = index
  Controller:OnSetLevelGrid(View.Group_Team, 1)
end

function Controller:OnSetLevelGrid(element, elementIndex)
  element.StaticGrid_RoleList.grid.self:SetParentParam(elementIndex)
  element.StaticGrid_RoleList.grid.self:SetDataCount(#DataModel.levelRoleList)
  element.StaticGrid_RoleList.grid.self:RefreshAllElement()
end

function Controller:OnSetLevelRoleGrid(element, elementIndex, isTemp)
  local levelRoleList = DataModel.levelRoleList
  local roleId = levelRoleList[elementIndex]
  element.Btn_Click:SetClickParam(elementIndex)
  if roleId == -1 or DataModel.isDrag == true and DataModel.dragIdx.role == elementIndex and isTemp ~= true then
    element.Group_Info:SetActive(false)
    element.Group_Empty:SetActive(true)
    return
  end
  element.Group_Info:SetActive(true)
  element.Group_Empty:SetActive(false)
  local roleData = PlayerData.ServerData.roles[roleId]
  local currentSkin = roleData.current_skin[1]
  local viewCA = PlayerData:GetFactoryData(currentSkin, "UnitViewFactory")
  element.Group_Info.Img_Role.Img_Role:SetSprite(viewCA.roleListResUrl)
  element.Group_Info.Group_LV.Txt_Num:SetText(math.floor(PlayerData.GetCubeRoleLv() + RogueController:GetRoleExLv(roleId)))
  local roleCA = PlayerData:GetFactoryData(roleId)
  element.Group_Info.Txt_Name:SetText(roleCA.name)
  local awakeLv = (roleData.awake_lv or 1) + (PlayerData.TempCache.CubeRogueData.roles[tostring(roleId)].awake_lv or 0)
  element.Group_Info.Group_Break.StaticGrid_BK.grid.self:SetDataCount(5)
  for i = 0, 4 do
    element.Group_Info.Group_Break.StaticGrid_BK.grid[i + 1].Img_On:SetActive(awakeLv >= i + 1)
  end
  local qualityInt = roleCA.qualityInt
  local bgPath = DataModel.RoleQualityBigPath[qualityInt]
  local maskPath = DataModel.RoleQualityBigMaskPath[qualityInt]
  element.Group_Info.Img_Quality:SetSprite(bgPath)
  element.Group_Info.Img_Mask:SetSprite(maskPath)
  local hp = RogueController:GetRoleHpPercent(roleId)
  local hpStatus = 1
  if hp < 0.6 and 0.2 <= hp then
    hpStatus = 2
  elseif hp < 0.2 then
    hpStatus = 3
  end
  element.Group_Info.Group_Health.Group_Num.Txt_Num:SetText(100 * hp)
  element.Group_Info.Group_Health.Img_Bar.Img_Red:SetActive(hpStatus == 3)
  element.Group_Info.Group_Health.Img_Bar.Img_Orange:SetActive(hpStatus == 2)
  element.Group_Info.Group_Health.Img_Bar.Img_Green:SetActive(hpStatus == 1)
  if hpStatus == 1 then
    element.Group_Info.Group_Health.Img_Bar.Img_Green:SetFilledImgAmount(hp)
  elseif hpStatus == 2 then
    element.Group_Info.Group_Health.Img_Bar.Img_Orange:SetFilledImgAmount(hp)
  elseif hpStatus == 3 then
    element.Group_Info.Group_Health.Img_Bar.Img_Red:SetFilledImgAmount(hp)
  end
end

function Controller:OnBtnBattle()
  if DataModel.mode == "InitCube" then
    self:TryBattle()
  elseif DataModel.levelId ~= nil then
    for j = 1, #DataModel.levelRoleList do
      local roleId = DataModel.levelRoleList[j]
      if roleId == -1 then
        CommonTips.OpenTips(80610391)
        return
      end
    end
    if DataModel.isDataChange == true then
      Controller:SaveCubeDeck(function()
        RogueController:StartBattle(DataModel.levelId, DataModel.isReStart)
      end)
    else
      RogueController:StartBattle(DataModel.levelId, DataModel.isReStart)
    end
  end
end

function Controller:TryBattle()
  local roleCountMap = {}
  for j = 1, #DataModel.levelRoleList do
    local roleId = DataModel.levelRoleList[j]
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
  PlayerData.TempCache.RogueCache.roleList = DataModel.levelRoleList
  local ridStr = self:GetCurRidStr()
  Net:SendProto("cube.deck", function(json)
    Net:SendProto("cube.info", function(json)
      PlayerData.TempCache.CubeRogueData = json.cube
      PlayerData.TempCache.CubeRogueData.reward = json.reward
      CBus:ChangeScene("RubikCube", function()
        UIManager:Open("UI/CubeRogue/Main/CubeRogueMain")
      end)
    end)
  end, ridStr, tostring(DataModel.levelRoleList[1]))
  return true
end

function Controller:GetCurRidStr()
  local ridStr = ""
  for i = 1, #DataModel.levelRoleList do
    local rid = DataModel.levelRoleList[i]
    if tonumber(rid) ~= -1 then
      if ridStr ~= "" then
        ridStr = ridStr .. ","
      end
      ridStr = ridStr .. rid
    end
  end
  return ridStr
end

function Controller:SaveCubeDeck(cb)
  if DataModel.mode == "InitCube" or DataModel.isDataChange ~= true then
    return false
  end
  DataModel.isDataChange = false
  local ridStr = self:GetCurRidStr()
  local leaderId = DataModel.levelRoleList[1]
  for i = 1, #DataModel.levelRoleList do
    local rid = DataModel.levelRoleList[i]
    if tonumber(rid) ~= -1 then
      leaderId = DataModel.levelRoleList[i]
      break
    end
  end
  Net:SendProto("cube.deck", function(json)
    Net:SendProto("cube.info", function(json)
      PlayerData.TempCache.CubeRogueData = json.cube
      PlayerData.TempCache.CubeRogueData.reward = json.reward
      if cb ~= nil then
        cb()
      end
    end)
  end, ridStr, tostring(leaderId))
  return true
end

function Controller:UpdateCubeDeckCache()
  PlayerData.TempCache.CubeRogueData.deck = {}
  for i = 1, #DataModel.levelRoleList do
    local roleId = tostring(DataModel.levelRoleList[i])
    PlayerData.TempCache.CubeRogueData.deck[roleId] = PlayerData.TempCache.CubeRogueData.roles[roleId]
  end
end

function Controller:BeginDrag(teamIndex, roleIndex)
  if DataModel.curFrameMouseUp then
    return
  end
  local roleId = DataModel.levelRoleList[roleIndex]
  if roleId == -1 then
    return
  end
  DataModel.isDrag = true
  DataModel.dragIdx = {team = teamIndex, role = roleIndex}
  local pos = Controller:GetMousePos()
  View.Group_RoleTemp.self:SetLocalPosition(pos)
  View.Group_RoleTemp:SetActive(true)
  Controller:OnSetLevelRoleGrid(View.Group_RoleTemp, roleIndex, true)
  Controller:OnSetLevelGrid(View.Group_Team, 1)
end

function Controller:CalcDragingPos()
  local toIdx = -1
  local groupLevel = View.Group_Team
  local groupRoleList = groupLevel.StaticGrid_RoleList
  local pos = groupRoleList.self.transform:InverseTransformPoint(View.Group_RoleTemp.self.transform.position)
  for j = 1, groupRoleList.self.DataCount do
    local gridPos = groupRoleList.grid[j].self.transform.localPosition
    if math.abs(gridPos.x - pos.x) <= 60 and math.abs(gridPos.y - pos.y) <= 100 then
      toIdx = j
      break
    end
  end
  return 1, toIdx
end

function Controller:DragEnd()
  local toTeam, toIdx = Controller:CalcDragingPos()
  if toTeam ~= -1 and toIdx ~= -1 and (DataModel.dragIdx.team ~= toTeam or DataModel.dragIdx.role ~= toIdx) then
    Controller:ExchangeSingleRole(DataModel.dragIdx.team, DataModel.dragIdx.role, toTeam, toIdx)
  end
  DataModel.dragIdx = {}
  View.Group_RoleTemp.self:SetActive(false)
  Controller:OnSetLevelGrid(View.Group_Team, 1)
end

function Controller:GetMousePos()
  local minScale = math.min(GameSetting.scaleWidth, GameSetting.scaleHeight)
  local position = Input.mousePosition
  position = Vector3((position.x - Screen.width * 0.5) / minScale, (position.y - Screen.height * 0.5) / minScale, position.z)
  return position
end

function Controller:OnClickReturn()
  Controller:SaveCubeDeck()
  if DataModel.levelId then
    RogueController.cacheLevelId = DataModel.levelId
    if DataModel.isReStart ~= true then
      RogueController.OnOtherPanelClose(RogueController.Enum_Continue.OpenSquadPanel)
    end
  end
  UIManager:GoBack(false)
end

function Controller:OnClickHome()
  Controller:SaveCubeDeck()
  local curLevelIndex = DataModel.curLevelIndex
  if curLevelIndex ~= -1 then
    View.self:PlayAnimOnce("Animation_SelectClose", function()
      Controller:SelectLevel(-1)
    end)
    return
  end
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
    View.ScrollGrid_RoleList.grid.self:RefreshAllElement()
  elseif DataModel.selectMode == 2 then
  end
  Controller:OnSetLevelGrid(View.Group_Team, 1)
end

function Controller:OnClickBtnAuto()
  Controller:SaveCubeDeck()
  local roleList = DataModel.levelRoleList
  local aiRoleList = {}
  for i = 1, #roleList do
    aiRoleList[#aiRoleList + 1] = tonumber(roleList[i])
  end
  local roles = PlayerData.ServerData.roles
  if DataModel.mode ~= "InitCube" then
    roles = PlayerData.TempCache.CubeRogueData.roles
  end
  UIManager:Open("UI/Battle/AutoBattle/New/AutoBattle", Json.encode({
    teamKey = "Cube",
    roleList = aiRoleList,
    header = aiRoleList[1],
    usableRoles = roles,
    isHideHome = true
  }))
end

function Controller:OnClickLevelRole(str)
  local roleIndex = tonumber(str)
  Controller:OnClickRoleBtn(DataModel.levelRoleList[roleIndex])
end

return Controller
