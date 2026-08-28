local View = require("UISquads/UISquadsView")
local StartBattle = require("UISquads/View_StartBattle")
local SquadElement = require("UISquads/Model_Element")
local SquadController = require("UISquads/Controller_Squad")
local DataModel = require("UISquads/UISquadsDataModel")
local DataDetail = require("UISquads/UISquadsDetail")
local DataController = require("UISquads/UISquadsDataController")
local CharacterSelectController = require("UISquads/UISquadsCharacterSelectController")
local CardPollController = require("UISquads/UISquadsCardPoolController")
local SquadLevelChain = require("UISquads/UISquadsLevelChain")
local EquipSelected = require("UISquads/SquadEquipSelected")
local CommonItem = require("Common/BtnItem")
local isQuickTeam = 0
local teamIndex = 1
local lastSelectIndex = 1

local function OnClickRole(str)
  isQuickTeam = 0
  local index = tonumber(str)
  teamIndex = index
  local role = DataModel.curSquad[index]
  if role.isHelpRole then
  end
  if role.isBlocked == true then
    CommonTips.OpenTips(80600675)
    return
  end
  if View.StaticGrid_List.grid[teamIndex].Img_Selected.IsActive then
    DOTweenTools.DOLocalMoveYCallback(View.Group_Detail.transform, -600, 0.25, nil, function()
      if View.StaticGrid_List.grid[teamIndex].Img_Selected.IsActive == false then
        DataDetail:CloseDetail()
      else
        UIManager:LoadSplitPrefab(View, "UI/Squads/Squads", "Group_Detail")
        View.Group_Detail.self:SetActive(true)
        if DataModel.isUseLevelRole then
          View.Group_Detail.Btn_Captain.self:SetActive(false)
        else
          View.Group_Detail.Btn_Captain.self:SetActive(true)
        end
        View.Btn_Mask:SetActive(true)
      end
    end)
    View.StaticGrid_List.grid[teamIndex].Img_Selected:SetActive(false)
    return
  end
  DataModel.curSelectIndex = index
  
  local function callBack()
    View.StaticGrid_List.grid[lastSelectIndex].Img_Selected:SetActive(false)
    lastSelectIndex = index
    DataDetail:OpenRoleDetail(View.StaticGrid_List.grid[index].self, index, role)
    View.StaticGrid_List.grid[index].Img_Selected:SetActive(true)
  end
  
  if DataModel.RoleData and DataModel.RoleData.Squads then
    SquadController:GetDefault_Send(DataModel.curSelectIndex, callBack)
  else
    callBack()
  end
  View.Group_Detail.Group_Card.StaticGrid_Card.grid.self:RefreshAllElement()
end

local function ClickUrEquip(str)
  local param = string.split(str, ":")
  local equipData = DataModel:GetUrEquipData()
  if equipData[param[1]][tonumber(param[2])].isUse then
    return
  end
  for i = 1, #DataModel.curSquad do
    if DataModel.curSquad[i].unitId == param[1] then
      local roleData
      if PlayerData.curSelectedHelpRole ~= nil and tonumber(param[1]) == tonumber(PlayerData.curSelectedHelpRole.id) then
        roleData = PlayerData.curSelectedHelpRole
      else
        roleData = PlayerData:GetRoleById(param[1]) or {
          equips = {
            [1] = "",
            [2] = "",
            [3] = ""
          }
        }
      end
      local equipData = DataModel:GetUrEquipData()
      CommonTips:SetNewUrEquip(View.Group_Detail, roleData, tonumber(param[2]), equipData, function()
        DataModel:SaveUrEquipData(equipData)
      end)
      if param[1] ~= DataModel.RoleData.id then
        OnClickRole(i)
      else
        View.Group_Detail.Group_Equip.StaticGrid_Equip.grid.self:RefreshAllElement()
      end
      SquadController:RefreshRoles()
      return
    end
  end
end

local function GetSkillMain(index)
  local skillMin = PlayerData:GetFactoryData(DataModel.RoleData.id).skillMin
  local current_num = 0
  for i = 1, 2 do
    current_num = current_num + DataModel.RoleData.Squads.skill_list[i]
  end
  if index then
    local defult_num = 0
    for k, v in pairs(DataModel.RoleData.skill_list[index]) do
      defult_num = defult_num + v
    end
    if skillMin >= defult_num then
      return false
    end
  elseif skillMin >= current_num then
    return false
  end
  return true
end

local function CloseChangeNameWindow()
  View.Group_ChangeName.InputField_ChangeName.self:SetText("")
  View.Group_ChangeName.self:SetActive(false)
end

local function GetResidueNum()
  local count = 0
  for k, v in pairs(DataModel.RoleData.equips) do
    if v ~= "" then
      count = count + 1
    end
  end
  return count
end

local function GetNowCaptain()
  return DataModel:GetNowCaptain()
end

local mainSlotCount = 5
local CharacterSelector = {
  Open = function(self, squadIdx, SelectIdxInSquad, state)
    DataModel.curDetailIndex = 2
    DataModel.header = GetNowCaptain()
    DataModel.InitRoleList = {}
    if DataModel.isUseLevelRole ~= true then
      for k, v in pairs(PlayerData.ServerData.squad[DataModel.curSquadIndex].role_list) do
        DataModel.InitRoleList[k] = v.id or ""
      end
    else
      for k, v in pairs(DataModel.currentSquad) do
        DataModel.InitRoleList[k] = v.id or ""
      end
    end
    DataModel.state = state
    CharacterSelectController:OpenView(true, SelectIdxInSquad, state, true)
    View.Group_CharacterSelect.Common_Filter.Group_TabBtn.Btn_Level.Img_bg:SetSprite("UI/Common/left_on")
    View.Group_CharacterSelect.Common_Filter.Group_TabBtn.Btn_Time.Img_bg:SetSprite("UI/Common/right_off")
    View.Group_CharacterSelect.Common_Filter.Group_TabBtn.Btn_Rarity.Img_bg:SetSprite("UI/Common/center_off")
  end
}

local function SetCaptain()
  local squad = DataModel.Squads[DataModel.curSquadIndex]
  if DataModel.isUseLevelRole == true then
    squad = DataModel.currentSquad
  end
  local count = table.count(squad)
  for i = 1, count do
    if squad[i] and squad[i].id and squad[i].id ~= "" then
      DataModel.header = squad[i].id
      return
    end
  end
end

local function RemoveCaptain()
  SetCaptain()
end

local function SetDefaultEquipment(data, element, index, defult_num)
  if data == nil then
    local eid = DataModel.RoleData.equips[defult_num][index]
    if index == 2 then
      element.Img_Ban:SetActive(false)
      if eid ~= nil and eid ~= "" then
        local equip_server = PlayerData:GetEquipByEid(eid)
        local equip_ca = PlayerData:GetFactoryData(equip_server.id)
        if equip_server.weight > equip_ca.overweight then
          element.Img_Ban:SetActive(true)
        end
      end
    end
    element.Group_Equipment.Img_Bottom:SetActive(false)
    element.Group_Equipment.Img_Mask:SetActive(false)
    element.Group_Equipment.Img_Item:SetActive(false)
    element.Group_Equipment.Group_EType:SetActive(false)
  else
    element.Group_Equipment.Img_Item:SetActive(true)
    element.Group_Equipment.Img_Bottom:SetActive(true)
    element.Group_Equipment.Img_Mask:SetActive(true)
    element.Group_Equipment.Group_EType:SetActive(true)
    local index = PlayerData:GetTypeInt("enumEquipTypeList", data.equipTagId)
    element.Group_Equipment.Group_EType.Img_Icon:SetSprite(UIConfig.EquipmentTypeMark[index])
    element.Group_Equipment.Group_EType.Img_IconBg:SetSprite(UIConfig.EquipmentTypeMarkBg[data.qualityInt])
    element.Group_Equipment.Img_Bottom:SetSprite(UIConfig.BottomConfig[data.qualityInt + 1])
    element.Group_Equipment.Img_Mask:SetSprite(UIConfig.MaskConfig[data.qualityInt + 1])
    element.Group_Equipment.Img_Item:SetSprite(data.iconPath)
  end
end

local function SetEquipment(data, element, index)
  if data == nil then
    local eid = DataModel.RoleData.equips[1]
    if index == 2 then
      element.Img_Ban:SetActive(false)
      if eid ~= nil and eid ~= "" then
        local equip_server = PlayerData:GetEquipByEid(eid)
      end
    end
    element.Img_Bottom:SetActive(false)
    element.Img_Mask:SetActive(false)
    element.Img_Item:SetActive(false)
    element.Group_EType:SetActive(false)
  else
    element.Img_Item:SetActive(true)
    element.Img_Bottom:SetActive(true)
    element.Img_Mask:SetActive(true)
    element.Group_EType:SetActive(true)
    local index = PlayerData:GetTypeInt("enumEquipTypeList", data.equipTagId)
    element.Group_EType.Img_Icon:SetSprite(UIConfig.EquipmentTypeMark[index])
    element.Group_EType.Img_IconBg:SetSprite(UIConfig.EquipmentTypeMarkBg[data.qualityInt])
    element.Img_Bottom:SetSprite(UIConfig.BottomConfig[data.qualityInt + 1])
    element.Img_Mask:SetSprite(UIConfig.MaskConfig[data.qualityInt + 1])
    element.Img_Item:SetSprite(data.iconPath)
  end
end

local function SetCard(element, index, row, numList)
  local data = row
  local card = element.Card
  local skillCA = PlayerData:GetFactoryData(data.id)
  local cardCA = PlayerData:GetFactoryData(skillCA.cardID)
  local bg = PlayerData:GetFactoryData(DataModel.RoleData.current_skin[1], "UnitViewFactory").roleListResUrl
  local battleConfig = PlayerData:GetFactoryData(99900008, "ConfigFactory")
  local numCA = PlayerData:GetFactoryData(battleConfig.cardCostNormalID, "BattleInfoFactory")
  card.Group_Front.Img_MaskCharacter.Img_Character:SetSprite(bg)
  card.Group_Front.Img_MaskSkill.Img_Skill:SetSprite(cardCA.iconPath)
  if cardCA.color == "Red" then
    card.Group_Front.Img_CardType:SetSprite(battleConfig.cardTypeRedPath)
  elseif cardCA.color == "Yellow" then
    card.Group_Front.Img_CardType:SetSprite(battleConfig.cardTypeYellowPath)
  elseif cardCA.color == "Green" then
    card.Group_Front.Img_CardType:SetSprite(battleConfig.cardTypeGreenPath)
  elseif cardCA.color == "Blue" then
    card.Group_Front.Img_CardType:SetSprite(battleConfig.cardTypeBluePath)
  elseif cardCA.color == "Purple" then
    card.Group_Front.Img_CardType:SetSprite(battleConfig.cardTypePurplePath)
  elseif cardCA.color == "Black" then
    card.Group_Front.Img_CardType:SetSprite(battleConfig.cardTypeBlackPath)
  end
  local tWidth = 0
  local cost = cardCA.cost_SN
  if 99 < cost then
    cost = 99
  end
  if cost < 0 then
    cost = 0
  end
  local cost1 = math.floor(cost / 10)
  local cost2 = math.floor(cost % 10)
  local numTextCA = GetNumRes(cost2, numCA)
  tWidth = numTextCA.width
  card.Group_Front.Group_Cost.Img_Cost2:SetSprite(numTextCA.resStr)
  if cost1 < 1 then
    card.Group_Front.Group_Cost.Img_Cost2:SetLocalPositionX(0)
    card.Group_Front.Group_Cost.Img_Cost1:SetActive(false)
  else
    card.Group_Front.Group_Cost.Img_Cost1:SetActive(true)
    numTextCA = GetNumRes(cost1, numCA)
    tWidth = tWidth + numTextCA.width + numCA.interval
    card.Group_Front.Group_Cost.Img_Cost1:SetSprite(numTextCA.resStr)
    card.Group_Front.Group_Cost.Img_Cost1:SetLocalPositionX(numTextCA.width / 2 - tWidth / 2)
    card.Group_Front.Group_Cost.Img_Cost2:SetLocalPositionX(tWidth / 2 - numTextCA.width / 2)
  end
  card.Group_Front.Img_LeaderCardSign:SetActive(data.isLeaderCard ~= nil and data.isLeaderCard or false)
  card.Group_Front.Img_Cooldown:SetActive(false)
  element.Group_Lv.Txt_Lv:SetText(data.lv)
  local unitCA = PlayerData:GetFactoryData(DataModel.RoleData.id).skillList
  local maxNum = unitCA[index].num
  local nowNum = maxNum
  if numList and numList[index] then
    nowNum = numList[index] or nowNum
  else
    nowNum = row.num and row.num or nowNum
  end
  element.Group_Num.Txt_Num:SetText(nowNum .. "/" .. maxNum)
  card.Group_Front.Img_MaskSkill.Img_Skill:SetColor(Color.white)
  if cardCA.color == "Red" then
    card.Group_Front.Img_MaskSkill.Img_Skill:SetColor(GameSetting.redCardColor)
  end
  if index == 3 then
    element.Btn_Add:SetActive(false)
    element.Btn_Reduce:SetActive(false)
  else
    element.Btn_Add:SetActive(true)
    element.Btn_Reduce:SetActive(true)
  end
  element.Btn_Add:SetActive(false)
  element.Btn_Reduce:SetActive(false)
end

local function SaveDefault_Send(index, callBack)
  local now_skill = DataModel.RoleData.Squads.skill_list
  local now_equip = DataModel.RoleData.Squads.equips
  local num_s, row_s = table:Difference(DataModel.RoleData.skill_list[index], now_skill)
  local num_e, row_e = table:Difference(DataModel.RoleData.equips[index], now_equip)
  if 0 < num_s or 0 < num_e then
    DataModel.RoleData.skill_list[index] = {}
    for k, v in pairs(now_skill) do
      table.insert(DataModel.RoleData.skill_list[index], v)
    end
    PlayerData:GetRoleById(DataModel.RoleData.id).skill_list[index] = DataModel.RoleData.skill_list[index]
    DataModel.RoleData.equips[index] = {}
    for k, v in pairs(now_equip) do
      table.insert(DataModel.RoleData.equips[index], v)
    end
    PlayerData:GetRoleById(DataModel.RoleData.id).equips[index] = DataModel.RoleData.equips[index]
    callBack()
  end
end

local function GetDefault_One()
  local row_equip = DataModel.RoleData.equips[1]
  local row_card = DataModel.RoleData.skill_list[1]
  local count_equip = 0
  DataModel.RoleData.Squads.equips = {}
  for k, v in pairs(row_equip) do
    if v ~= nil and v ~= "" then
      count_equip = count_equip + 1
      table.insert(DataModel.RoleData.Squads.equips, v)
    end
  end
  local count_card = 0
  DataModel.RoleData.Squads.skill_list = {}
  for k, v in pairs(row_card) do
    if v ~= nil and v ~= "" then
      count_card = count_card + 1
      DataModel.RoleData.skills[k].num = v
      table.insert(DataModel.RoleData.Squads.skill_list, v)
    end
  end
  if count_equip == 0 then
    DataModel.RoleData.Squads.equips = row_equip
  end
  if 0 < count_equip then
    View.Group_Detail.Group_Equip.StaticGrid_Equip.grid.self:RefreshAllElement()
  end
  if count_card == 0 then
    DataModel.RoleData.Squads.skill_list = row_card
  end
  if 0 < count_card then
    View.Group_Detail.Group_Card.StaticGrid_Card.grid.self:RefreshAllElement()
  end
end

local function GetDefault_Two()
  local row_equip = DataModel.RoleData.equips[2]
  local row_card = DataModel.RoleData.skill_list[2]
  local count_equip = 0
  DataModel.RoleData.Squads.equips = {}
  for k, v in pairs(row_equip) do
    if v ~= nil and v ~= "" then
      count_equip = count_equip + 1
      table.insert(DataModel.RoleData.Squads.equips, v)
    end
  end
  local count_card = 0
  DataModel.RoleData.Squads.skill_list = {}
  for k, v in pairs(row_card) do
    if v ~= nil and v ~= "" then
      count_card = count_card + 1
      DataModel.RoleData.skills[k].num = v
      table.insert(DataModel.RoleData.Squads.skill_list, v)
    end
  end
  if count_equip == 0 then
    DataModel.RoleData.Squads.equips = row_equip
  end
  if 0 < count_equip then
    View.Group_Detail.Group_Equip.StaticGrid_Equip.grid.self:RefreshAllElement()
  end
  if count_card == 0 then
    DataModel.RoleData.Squads.skill_list = row_card
  end
  if 0 < count_card then
    View.Group_Detail.Group_Card.StaticGrid_Card.grid.self:RefreshAllElement()
  end
end

local function GetDefault_Three()
  local row_equip = DataModel.RoleData.equips[3]
  local row_card = DataModel.RoleData.skill_list[3]
  local count_equip = 0
  DataModel.RoleData.Squads.equips = {}
  for k, v in pairs(row_equip) do
    if v ~= nil and v ~= "" then
      count_equip = count_equip + 1
      table.insert(DataModel.RoleData.Squads.equips, v)
    end
  end
  local count_card = 0
  DataModel.RoleData.Squads.skill_list = {}
  for k, v in pairs(row_card) do
    if v ~= nil and v ~= "" then
      count_card = count_card + 1
      DataModel.RoleData.skills[k].num = v
      table.insert(DataModel.RoleData.Squads.skill_list, v)
    end
  end
  if count_equip == 0 then
    DataModel.RoleData.Squads.equips = row_equip
  end
  if 0 < count_equip then
    View.Group_Detail.Group_Equip.StaticGrid_Equip.grid.self:RefreshAllElement()
  end
  if count_card == 0 then
    DataModel.RoleData.Squads.skill_list = row_card
  end
  if 0 < count_card then
    View.Group_Detail.Group_Card.StaticGrid_Card.grid.self:RefreshAllElement()
  end
end

local ViewFunction = {
  Squads_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.self:PlayAnim("Out")
    DataDetail:CloseDetail()
    if PlayerData.TempCache.EventIndex ~= nil then
      PlayerData.TempCache.EventIndex = nil
      PlayerData.TempCache.AreaId = nil
      PlayerData.TempCache.ActivityId = nil
    end
    PlayerData.SetIsTest()
    if PlayerData.SquadsTempData.IsReStart then
      CommonTips.OpenArbitrarilyUI(PlayerData.BattleCallBackPage, PlayerData.Last_Chapter_Parms)
      return
    end
    PlayerData.helpSquadIndex = nil
    PlayerData.helpRoleList = nil
    PlayerData.curSelectedHelpRole = nil
    PlayerData.curHelpRoles = nil
    PlayerData.curHelpBattlePage = nil
    PlayerData:SetPlayerPrefs("string", "CardAIDataHelpRole", "", true)
    local autoBattleVF = require("UIAutoBattle/UIAutoBattleViewFunction")
    autoBattleVF:SaveCloudData("CardAIDataHelpRole", "")
    UIManager:GoBack()
  end,
  Squads_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    PlayerData.SetIsTest()
    View.self:PlayAnim("Out")
    if PlayerData.TempCache.EventIndex ~= nil then
      PlayerData.TempCache.EventIndex = nil
      PlayerData.TempCache.AreaId = nil
      PlayerData.TempCache.ActivityId = nil
    end
    if PlayerData.SquadsTempData.IsReStart then
      CommonTips.OpenArbitrarilyUI(PlayerData.BattleCallBackPage, PlayerData.Last_Chapter_Parms)
      return
    end
    PlayerData.helpSquadIndex = nil
    PlayerData.helpRoleList = nil
    PlayerData.curSelectedHelpRole = nil
    PlayerData.curHelpRoles = nil
    PlayerData.curHelpBattlePage = nil
    PlayerData:SetPlayerPrefs("string", "CardAIDataHelpRole", "", true)
    local autoBattleVF = require("UIAutoBattle/UIAutoBattleViewFunction")
    autoBattleVF:SaveCloudData("CardAIDataHelpRole", "")
    CommonCoachData.GoHome()
  end,
  Squads_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Squads_StaticGrid_List_SetGrid = function(element, elementIndex)
    if tonumber(elementIndex) == 6 then
      element.self:SetActive(false)
      return
    end
    element.Img_Selected:SetActive(false)
    element.Btn_Null.self:SetClickParam(elementIndex)
    element.Btn_Character.self:SetClickParam(elementIndex)
    if elementIndex <= mainSlotCount then
      element.Group_Alternate.self:SetActive(false)
    end
    local row = PlayerData.ServerData.squad[DataModel.curSquadIndex]
    if DataModel.isUseLevelRole or PlayerData.curSelectedHelpRole ~= nil then
      element.Btn_Character.Img_Captain:SetActive(tonumber(DataModel.curSquad[elementIndex].unitId) == tonumber(GetNowCaptain()))
    elseif row.header and row.header ~= "" and row.role_list[elementIndex] and row.role_list[elementIndex].id and tonumber(row.role_list[elementIndex].id) == tonumber(row.header) then
      element.Btn_Character.Img_Captain:SetActive(true)
      PlayerData.BattleInfo.header = row.role_list[elementIndex].id
    else
      element.Btn_Character.Img_Captain:SetActive(false)
    end
    if DataModel.curSquad[elementIndex] then
      element.Img_Remind:SetActive(PlayerData:GetAllRoleAwakeRedID(DataModel.curSquad[elementIndex].unitId))
    end
    if DataModel.hasLevelRole == true then
      element.Img_Remind:SetActive(false)
    end
    SquadController.SetSquadElemet(element, DataModel.curSquad[elementIndex] or {})
    local groupTrust = element.Group_Trust
    if row.role_list[elementIndex] == nil then
      groupTrust:SetActive(false)
      return
    end
    local buff = PlayerData:GetCurStationStoreBuff(tostring(DataModel.curSquad[elementIndex].unitId), EnumDefine.HomeSkillEnum.AddTrust)
    groupTrust:SetActive(buff ~= nil)
    if buff ~= nil then
      groupTrust.Txt_TrustNum:SetText(string.format(GetText(80601584), math.floor(buff.param * 100)))
      local curTime = TimeUtil:GetServerTimeStamp()
      local remainTime = math.max(buff.endTime - curTime, 0)
      local buffCA = PlayerData:GetFactoryData(buff.id, "HomeBuffFactory")
      groupTrust.Group_Icon.Img_TrustTime:SetFilledImgAmount(remainTime / buffCA.continueTime)
    end
  end,
  Squads_Btn_Clear_Click = function(btn, str)
    if DataModel.isUseLevelRole then
      CommonTips.OpenTips(80600676)
      return
    end
    if SquadController:GetSquadsNum() == 0 then
      CommonTips.OpenTips(80602389)
      return
    end
    
    local function clearCallback()
      DataController:ClearSquad()
    end
    
    CommonTips.OnPrompt("80600109", "80600068", "80600067", clearCallback, nil)
  end,
  Squads_Group_Tab_Btn_Tab_01_Click = function(index)
    local function callBack()
      SquadController.SetTabElement(1 + 4 * (DataModel.TopColumn - 1), DataController)
      
      DataDetail:CloseDetail()
    end
    
    if DataModel.RoleData and DataModel.RoleData.Squads then
      SquadController:GetDefault_Send(DataModel.curSelectIndex, callBack)
    else
      callBack()
    end
  end,
  Squads_Group_Tab_Btn_Tab_01_Group_On_Btn_Change_Click = function(index)
    SquadController.ModifyNameBtn(1)
  end,
  Squads_Group_Tab_Btn_Tab_02_Click = function(index)
    local function callBack()
      SquadController.SetTabElement(2 + 4 * (DataModel.TopColumn - 1), DataController)
      
      DataDetail:CloseDetail()
    end
    
    if DataModel.RoleData and DataModel.RoleData.Squads then
      SquadController:GetDefault_Send(DataModel.curSelectIndex, callBack)
    else
      callBack()
    end
  end,
  Squads_Group_Tab_Btn_Tab_02_Group_On_Btn_Change_Click = function(index)
    SquadController.ModifyNameBtn(2)
  end,
  Squads_Group_Tab_Btn_Tab_03_Click = function(index)
    local function callBack()
      SquadController.SetTabElement(3 + 4 * (DataModel.TopColumn - 1), DataController)
      
      DataDetail:CloseDetail()
    end
    
    if DataModel.RoleData and DataModel.RoleData.Squads then
      SquadController:GetDefault_Send(DataModel.curSelectIndex, callBack)
    else
      callBack()
    end
  end,
  Squads_Group_Tab_Btn_Tab_03_Group_On_Btn_Change_Click = function(index)
    SquadController.ModifyNameBtn(3)
  end,
  Squads_Group_Tab_Btn_Tab_04_Click = function(index)
    local function callBack()
      SquadController.SetTabElement(4 + 4 * (DataModel.TopColumn - 1), DataController)
      
      DataDetail:CloseDetail()
    end
    
    if DataModel.RoleData and DataModel.RoleData.Squads then
      SquadController:GetDefault_Send(DataModel.curSelectIndex, callBack)
    else
      callBack()
    end
  end,
  Squads_Group_Tab_Btn_Tab_04_Group_On_Btn_Change_Click = function(index)
    SquadController.ModifyNameBtn(4)
  end,
  Squads_Btn_Start_Click = function(btn, str)
    if #DataModel.curSquad == 0 then
      CommonTips.OpenTips(80600066)
      return false
    end
    local levelId = PlayerData.BattleInfo.battleStageId
    if DataModel.Current == DataModel.Enum.College then
      levelId = DataModel.curLevelId
    end
    local levelCA = PlayerData:GetFactoryData(levelId)
    local levelType = 1
    local index = -1
    if DataModel.hasLevelRole == true or PlayerData.curSelectedHelpRole ~= nil then
      levelType = 0
      local nowCaptainId = GetNowCaptain()
      for k, v in pairs(DataModel.curSquad) do
        if next(v) ~= nil then
          v.squadIndex = k
        end
        if tonumber(v.unitId) == tonumber(nowCaptainId) then
          index = k
        end
      end
    else
      for k, v in pairs(DataModel.curSquad) do
        if next(v) ~= nil then
          v.squadIndex = k
        end
        if tonumber(v.unitId) == tonumber(PlayerData.ServerData.squad[DataModel.curSquadIndex].header) then
          index = k
        end
      end
    end
    if -1 < index then
      local row = DataModel.curSquad[index]
      table.remove(DataModel.curSquad, index)
      table.insert(DataModel.curSquad, 1, row)
    end
    if SquadController:GetNewSquadsNum() < levelCA.minRoleNum then
      CommonTips.OpenTips(string.format(GetText(80601995), levelCA.minRoleNum))
      return false
    end
    if next(DataModel.curSquad[1]) == nil then
      CommonTips.OpenTips(80600176)
      return false
    end
    local is_line_fail
    if DataModel.level_key then
      local uid = string.split(DataModel.level_key, ":")[1]
      if uid ~= PlayerData:GetUserInfo().uid then
        is_line_fail = true
      end
    end
    if CommonTips.OpenBuyEnergyTips(levelId, nil, nil, is_line_fail) then
      return false
    end
    
    local function callBack()
      DataDetail:CloseDetail()
      local weatherIdList
      local weatherRateSN = -1
      local bgId = -1
      local minEnemyLevel = DataModel.minEnemyLevel
      local enemyLevelOffset
      local secondWeatherList = {}
      local secondWeatherRateSN = -1
      if levelCA.saleLevelType == "Line" or levelCA.saleLevelType == "LineClick" then
        bgId = DataModel.bgId
        weatherIdList = DataModel.lineWeatherIdList
        weatherRateSN = DataModel.lineWeatherRateSN
      elseif levelCA.saleLevelType == "pollute" or levelCA.saleLevelType == "twig" or levelCA.saleLevelType == "buoy" then
        bgId = DataModel.bgId
        weatherIdList = DataModel.lineWeatherIdList
        weatherRateSN = DataModel.lineWeatherRateSN
        local areaId = DataModel.areaId
        if areaId == nil then
          if DataModel.secondWeatherList ~= nil then
            secondWeatherList = DataModel.secondWeatherList
            secondWeatherRateSN = SafeMath.safeNumberTime
          end
          if DataModel.enemyLevelOffset ~= nil then
            enemyLevelOffset = DataModel.enemyLevelOffset
          end
        else
          local polluteData = PlayerData.pollute_areas[tostring(areaId)]
          local polluteNum = -1
          if polluteData and polluteData.po_curIndex ~= nil then
            polluteNum = math.ceil(polluteData.po_curIndex)
          end
          local areaCA = PlayerData:GetFactoryData(areaId)
          if areaCA then
            local polluteLvList = areaCA.polluteLvList[polluteNum + 1]
            if polluteLvList then
              minEnemyLevel = polluteLvList.polluteLvMin
              enemyLevelOffset = math.random(polluteLvList.polluteLvOffsetMin, polluteLvList.polluteLvOffsetMax)
              enemyLevelOffset = math.floor(enemyLevelOffset)
            end
            if polluteLvList ~= nil or levelCA.saleLevelType == "pollute" then
              for i = 1, #areaCA.RnWtList do
                secondWeatherList[#secondWeatherList + 1] = areaCA.RnWtList[i].RnWtId
              end
              secondWeatherRateSN = areaCA.polluteWeatherRate * SafeMath.safeNumberTime
            end
          end
        end
      elseif PlayerData.SquadsTempData.IsReStart then
        bgId = PlayerData.BattleInfo.bgId
      else
        bgId = levelCA.bgIdList[math.random(1, #levelCA.bgIdList)].id
      end
      local correspondId = levelCA.CorrespondingList
      local correspondList = PlayerData:GetFactoryData(correspondId, "ListFactory")
      if correspondList ~= nil then
        local levelList
        if levelCA.saleLevelType == "Side" then
          levelList = correspondList.sideQuestList
        elseif levelCA.saleLevelType == "Daily" then
          levelList = correspondList.dayQuestList
        end
        for i = 1, #levelList do
          if levelList[i].id == levelCA.id then
            DataModel.enemyLevel = levelList[i].lv
          end
        end
      end
      local secondWeatherCount = secondWeatherList ~= nil and #secondWeatherList or 0
      if DataModel.headerExtraSkill ~= nil then
        local curSkills = DataModel.curSquad[1].extraSkills
        if curSkills ~= nil then
          curSkills = curSkills .. "|"
        end
        DataModel.curSquad[1].extraSkills = curSkills .. DataModel.headerExtraSkill
      end
      if levelType == 0 then
        PlayerData.BattleInfo.rids = ""
        for i = 1, #DataModel.curSquad do
          if PlayerData.BattleInfo.rids ~= "" then
            PlayerData.BattleInfo.rids = PlayerData.BattleInfo.rids .. ","
          end
          if DataModel.curSquad[i] and DataModel.curSquad[i].unitId ~= nil then
            PlayerData.BattleInfo.rids = PlayerData.BattleInfo.rids .. DataModel.curSquad[i].unitId
          end
        end
      end
      StartBattle:StartBattle(levelId, levelType, DataModel.curSquad, DataModel.curSquadIndex, nil, false, DataModel.eventId, DataModel.level_key, nil, nil, minEnemyLevel, DataModel.difficulty, bgId, DataModel.enemyLevel, DataModel.enemyRn, weatherIdList, weatherRateSN, enemyLevelOffset, secondWeatherList, secondWeatherRateSN, secondWeatherCount, DataModel.enemy_ids, DataModel.trainWeaponSkill, DataModel.ttbSid, DataModel.ttbIndex, DataModel.ttbId, DataModel.dialogId, DataModel.friendId, DataModel.gridId, DataModel.csActivityId, DataModel.csIndex)
    end
    
    if DataModel.RoleData and DataModel.RoleData.Squads then
      SquadController:GetDefault_Send(DataModel.curSelectIndex, callBack)
    else
      callBack()
    end
    local internal = CS.FRef.getProperty(TrainManager, "InternalTrainManager")
    CS.FRef.setProperty(internal, "IsInTrainMap", false)
    return true
  end,
  Squads_Group_CardYard_Open_Btn_CardYard_Click = function(btn, str)
    if DataModel.Current == DataModel.Enum.College then
      CommonTips.OpenTips(80600148)
      return
    end
    CardPollController:OpenView(true)
  end,
  Squads_Btn_Test_Click = function(btn, str)
    SquadController:EnterTest()
  end,
  Squads_Btn_StartChain_Click = function(btn, str)
    if table.count(PlayerData.ServerData.squad[DataModel.curSquadIndex].role_list) == 0 then
      CommonTips.OpenTips(80600066)
      return
    end
    if PlayerData.ServerData.squad[DataModel.curSquadIndex].header == nil then
      CommonTips.OpenTips(80600176)
      return
    end
    SquadLevelChain.StartDiscover()
  end,
  Squads_Btn_Team_Click = function(btn, str)
    if PlayerData.selectedRightIndex ~= nil and PlayerData.selectedRightIndex == 3 then
      return
    end
    if DataModel.isHighChallenge and DataModel.isHighChallenge == true then
      CommonTips.OpenTips("\233\171\152\233\154\190/\232\128\131\230\160\184\229\133\179\229\141\161 \230\151\160\230\179\149\230\155\180\230\141\162\232\167\146\232\137\178 \239\188\129\239\188\129\239\188\129")
      return
    end
    if SquadController:GetSquadsNum() >= table.count(PlayerData:GetRoles()) then
      return
    end
    CharacterSelector:Open(DataModel.curSquadIndex, SquadController:GetSquadsNum(), 0)
    View.Group_CharacterSelect.ScrollGrid_CharacterList.grid.self.ScrollRect.verticalNormalizedPosition = 1
  end,
  Squads_Btn_Mask_Click = function(btn, str)
    local function callBack()
      DOTweenTools.DOLocalMoveYCallback(View.Group_Detail.transform, -600, 0.25, nil, function()
        DataDetail:CloseDetail()
      end)
    end
    
    if DataModel.RoleData and DataModel.RoleData.Squads then
      SquadController:GetDefault_Send(DataModel.curSelectIndex, callBack)
    else
      callBack()
    end
    View.StaticGrid_List.grid[teamIndex].Img_Selected:SetActive(false)
  end,
  Squads_Btn_QuickFormation_Click = function(btn, str)
    local levelData = PlayerData:GetFactoryData(DataModel.curLevelId)
    if DataModel.isUseLevelRole and levelData and levelData.roleNumOffSet >= 5 then
      CommonTips.OpenTips(80600675)
      return
    end
    isQuickTeam = 1
    teamIndex = 1
    DataDetail:CloseDetail()
    if PlayerData.helpRoleList ~= nil then
      CommonTips.OnPrompt(GetText(80611653), "80600068", "80600067", function()
        CharacterSelector:Open(DataModel.curSquadIndex, 1, 3)
        View.Group_CharacterSelect.ScrollGrid_CharacterList.grid.self.ScrollRect.verticalNormalizedPosition = 1
      end)
    else
      CharacterSelector:Open(DataModel.curSquadIndex, 1, 3)
      View.Group_CharacterSelect.ScrollGrid_CharacterList.grid.self.ScrollRect.verticalNormalizedPosition = 1
    end
  end,
  Squads_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Squads_Group_Slot_Btn_Null_Click = function(btn, str)
  end,
  Squads_Group_Slot_Btn_Character_Click = function(btn, str)
  end,
  Squads_Group_Slot_Btn_Character_LongPress = function(btn, str)
  end,
  Squads_Group_Slot_Btn_Character_Group_Break_StaticGrid_BK_SetGrid = function(element, elementIndex)
  end,
  Squads_StaticGrid_List_Group_Slot_Btn_Null_Click = function(btn, str)
    isQuickTeam = 0
    if SquadController:GetSquadsNum() >= table.count(PlayerData:GetRoles()) then
      CommonTips.OpenTips(80600758)
      return
    end
    local index = tonumber(str)
    teamIndex = index
    local role = DataModel.curSquad[index]
    if role.isBlocked == true or role.isLevelRole == true then
      CommonTips.OpenTips(80600675)
      return
    end
    DataDetail:CloseDetail()
    if PlayerData.helpRoleList ~= nil then
      CommonTips.OnPrompt(GetText(80611653), "80600068", "80600067", function()
        CharacterSelector:Open(DataModel.curSquadIndex, index, 0)
        View.Group_CharacterSelect.ScrollGrid_CharacterList.grid.self.ScrollRect.verticalNormalizedPosition = 1
      end)
    else
      CharacterSelector:Open(DataModel.curSquadIndex, index, 0)
      View.Group_CharacterSelect.ScrollGrid_CharacterList.grid.self.ScrollRect.verticalNormalizedPosition = 1
    end
  end,
  Squads_StaticGrid_List_Group_Slot_Btn_Character_Click = function(btn, str)
    isQuickTeam = 0
    local index = tonumber(str)
    teamIndex = index
    local role = DataModel.curSquad[index]
    if role.isHelpRole then
    end
    if role.isBlocked == true then
      CommonTips.OpenTips(80600675)
      return
    end
    if View.StaticGrid_List.grid[teamIndex].Img_Selected.IsActive then
      DOTweenTools.DOLocalMoveYCallback(View.Group_Detail.transform, -600, 0.25, nil, function()
        if View.StaticGrid_List.grid[teamIndex].Img_Selected.IsActive == false then
          DataDetail:CloseDetail()
        else
          UIManager:LoadSplitPrefab(View, "UI/Squads/Squads", "Group_Detail")
          View.Group_Detail.self:SetActive(true)
          if DataModel.isUseLevelRole then
            View.Group_Detail.Btn_Captain.self:SetActive(false)
          else
            View.Group_Detail.Btn_Captain.self:SetActive(true)
          end
          View.Btn_Mask:SetActive(true)
        end
      end)
      View.StaticGrid_List.grid[teamIndex].Img_Selected:SetActive(false)
      return
    end
    DataModel.curSelectIndex = index
    
    local function callBack()
      View.StaticGrid_List.grid[lastSelectIndex].Img_Selected:SetActive(false)
      lastSelectIndex = index
      DataDetail:OpenRoleDetail(View.StaticGrid_List.grid[index].self, index, role)
      View.StaticGrid_List.grid[index].Img_Selected:SetActive(true)
    end
    
    if DataModel.RoleData and DataModel.RoleData.Squads then
      SquadController:GetDefault_Send(DataModel.curSelectIndex, callBack)
    else
      callBack()
    end
    View.Group_Detail.Group_Card.StaticGrid_Card.grid.self:RefreshAllElement()
  end,
  Squads_StaticGrid_List_Group_Slot_Btn_Character_LongPress = function(btn, str)
    OnClickRole(str)
  end,
  Squads_StaticGrid_List_Group_Slot_Btn_Character_Group_Break_StaticGrid_BK_SetGrid = function(element, elementIndex)
    if elementIndex <= DataModel.curRefreshElement.current.BreakThroughLv then
      element.Img_Off:SetActive(false)
      element.Img_On:SetActive(true)
    else
      element.Img_Off:SetActive(true)
      element.Img_On:SetActive(false)
    end
  end,
  Squads_Group_CardYard_Open_Btn_BattleBuff_Click = function(btn, str)
    View.Group_BuffTips.self:SetActive(true)
  end,
  Squads_Group_BuffTips_Btn__Click = function(btn, str)
    View.Group_BuffTips.self:SetActive(false)
  end,
  Squads_Group_Tab_Btn_Expand_Click = function(btn, str)
    SquadController:ClickTopExpand()
  end,
  Squads_Btn_Close_Click = function(btn, str)
    SquadController:ClickTopExpand()
  end,
  Squads_Img_Base_ScrollGrid_Btn_SetGrid = function(element, elementIndex)
    SquadController:RefreshGridTab(element, tonumber(elementIndex))
  end,
  Squads_Img_Base_ScrollGrid_Btn_Group_Item_Btn_Tab_Click = function(btn, str)
    local function callBack()
      SquadController:ClickTopGridIndex(tonumber(str))
      
      SquadController.SetTabElement(tonumber(str), DataController)
      DataDetail:CloseDetail()
    end
    
    if DataModel.RoleData and DataModel.RoleData.Squads then
      SquadController:GetDefault_Send(DataModel.curSelectIndex, callBack)
    else
      callBack()
    end
  end,
  Squads_Group_CardYard_Open_Btn_CardAI_Click = function(btn, str)
    local curTeamIndex = DataModel.curSquadIndex
    local squad = PlayerData.ServerData.squad[DataModel.curSquadIndex]
    local roleList = {}
    local header = GetNowCaptain()
    local isHeaderChange = true
    for i = 1, #DataModel.curSquad do
      if DataModel.curSquad[i].unitId ~= nil then
        roleList[#roleList + 1] = tonumber(DataModel.curSquad[i].unitId)
      else
        roleList[#roleList + 1] = -1
      end
      if DataModel.curSquad[i].unitId == header then
        isHeaderChange = false
      end
    end
    if isHeaderChange and PlayerData.curSelectedHelpRole then
      header = PlayerData.curSelectedHelpRole.id
    end
    local teamKey = DataModel.hasLevelRole and "LevelRoleList_" .. DataModel.curLevelId or curTeamIndex
    if curTeamIndex == PlayerData.helpSquadIndex then
      teamKey = "HelpRole"
    end
    UIManager:Open("UI/Battle/AutoBattle/New/AutoBattle", Json.encode({
      teamKey = teamKey,
      roleList = roleList,
      header = tonumber(header)
    }))
  end,
  Squads_Group_CardYard_Open_Btn_HelpBattle_Click = function(btn, str)
    local curRoles = {}
    local curLevelRoles = {}
    for c, d in pairs(DataModel.levelRoleMap) do
      local cloneV = BuildRole(d.unitId)
      cloneV.isLevelRole = true
      cloneV.awake_lv = d.awakeLv
      cloneV.lv = d.lv
      cloneV.resonance_lv = d.resonanceLv
      cloneV.squads_index = 0
      curLevelRoles[tostring(d.unitId)] = cloneV
    end
    for i = 1, #DataModel.curSquad do
      if not DataModel.curSquad[i].isHelpRole and not DataModel.curSquad[i].isLevelRole then
        curRoles[#curRoles + 1] = DataModel.curSquad[i].unitId
      else
        curRoles[#curRoles + 1] = ""
        if DataModel.curSquad[i].isLevelRole then
          curLevelRoles[tostring(DataModel.curSquad[i].unitId)].squads_index = i
        end
      end
    end
    UIManager:Open("UI/Friends/HelpRoleBattleSelect", Json.encode({
      curSelectedRoles = curRoles,
      curSquadsIndex = DataModel.curSquadIndex,
      levelRoleMap = curLevelRoles
    }))
  end,
  Squads_Group_ChangeName_Btn_Confirm_Click = function()
    SquadController:ModifyName(30)
    CloseChangeNameWindow()
  end,
  Squads_Group_ChangeName_Btn_Cancel_Click = function()
    CloseChangeNameWindow()
  end,
  Squads_Group_ChangeName_Btn_Close_Click = function(btn, str)
    CloseChangeNameWindow()
  end,
  Squads_Group_CardYard_Btn_Close_Click = function(btn, str)
    CardPollController:OpenView(false)
  end,
  Squads_Group_CardYard_ScrollGrid_CardYard_SetGrid = function(element, elementIndex)
    element.Btn_Item:SetClickParam(elementIndex)
    CardPollController:SetElement(element, elementIndex)
  end,
  Squads_Group_CharacterSelect_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    View.Group_CharacterSelect.ScrollGrid_CharacterList.grid.self:MoveToTop()
    UIManager:GoHome()
  end,
  Squads_Group_CharacterSelect_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Squads_Group_CharacterSelect_ScrollGrid_CharacterList_SetGrid = function(element, elementIndex)
    element.Btn_Mask:SetActive(false)
    element.Btn_Item:SetClickParam(elementIndex)
    element.Btn_Mask:SetClickParam(elementIndex)
    CharacterSelectController:SetElement(element, elementIndex)
  end,
  Squads_Group_CharacterSelect_Group_Bottom_Btn_Support_Click = function(btn, str)
  end,
  Squads_Group_CharacterSelect_Group_Bottom_Btn_Cancel_Click = function(btn, str)
    DataController:SetSquad(PlayerData.currentSquad, #View.StaticGrid_List.grid)
    DataModel:RefreshSquadsInit()
    CharacterSelectController:OpenView(false)
  end,
  Squads_Group_CharacterSelect_Group_Bottom_Btn_Confirm_Click = function(btn, str)
    CharacterSelectController:ConfirmBtn()
  end,
  Squads_Group_CardYard_ScrollGrid_CardYard_Group_Item_Btn_Item_Click = function(btn, str)
    CardPollController:CardBtn(btn, tonumber(str))
  end,
  Squads_Group_CharacterSelect_Common_Filter_Group_Filter_Btn_BG_Click = function(btn, str)
    CommonFilter.OpenFilter(false)
  end,
  Squads_Group_CharacterSelect_Common_Filter_Group_Filter_StaticGrid_Title_SetGrid = function(element, elementIndex)
    CommonFilter.FilterElementTitle(element, elementIndex)
  end,
  Squads_Group_CharacterSelect_Common_Filter_Group_Filter_StaticGrid_1_SetGrid = function(element, elementIndex)
    element.Btn_Item:SetClickParam(elementIndex)
    CommonFilter.FilterElementBtn(1, element, elementIndex)
  end,
  Squads_Group_CharacterSelect_Common_Filter_Group_Filter_StaticGrid_1_Group_BtnT_Btn_Item_Click = function(btn, str)
    CommonFilter.FilterBtn(1, tonumber(str))
  end,
  Squads_Group_CharacterSelect_Common_Filter_Group_Filter_StaticGrid_2_SetGrid = function(element, elementIndex)
    element.Btn_Item:SetClickParam(elementIndex)
    CommonFilter.FilterElementBtn(2, element, elementIndex)
  end,
  Squads_Group_CharacterSelect_Common_Filter_Group_Filter_StaticGrid_2_Group_BtnT_Btn_Item_Click = function(btn, str)
    CommonFilter.FilterBtn(2, tonumber(str))
  end,
  Squads_Group_CharacterSelect_Common_Filter_Group_Filter_StaticGrid_3_SetGrid = function(element, elementIndex)
    element.Btn_Item:SetClickParam(elementIndex)
    CommonFilter.FilterElementBtn(3, element, elementIndex)
  end,
  Squads_Group_CharacterSelect_Common_Filter_Group_Filter_StaticGrid_3_Group_BtnT_Btn_Item_Click = function(btn, str)
    CommonFilter.FilterBtn(3, tonumber(str))
  end,
  Squads_Group_CharacterSelect_Common_Filter_Group_Filter_Btn_OK_Click = function(btn, str)
    CommonFilter.ConfirmBtn()
  end,
  Squads_Group_CardYard_Btn_CardYard_Click = function(btn, str)
  end,
  Squads_Group_CardYard_Btn_CardCemetery_Click = function(btn, str)
  end,
  Squads_Group_CharacterSelect_Common_Filter_Group_TabBtn_Btn_Level_Click = function(btn, str)
    DataModel.isRefreshRoleData = true
    CommonFilter.SortBtn(1)
    View.Group_CharacterSelect.Common_Filter.Group_TabBtn.Btn_Level.Img_bg:SetSprite("UI/Common/left_on")
    View.Group_CharacterSelect.Common_Filter.Group_TabBtn.Btn_Time.Img_bg:SetSprite("UI/Common/right_off")
    View.Group_CharacterSelect.Common_Filter.Group_TabBtn.Btn_Rarity.Img_bg:SetSprite("UI/Common/center_off")
  end,
  Squads_Group_CharacterSelect_Common_Filter_Group_TabBtn_Btn_Rarity_Click = function(btn, str)
    DataModel.isRefreshRoleData = true
    CommonFilter.SortBtn(2)
    View.Group_CharacterSelect.Common_Filter.Group_TabBtn.Btn_Level.Img_bg:SetSprite("UI/Common/left_off")
    View.Group_CharacterSelect.Common_Filter.Group_TabBtn.Btn_Rarity.Img_bg:SetSprite("UI/Common/center_on")
    View.Group_CharacterSelect.Common_Filter.Group_TabBtn.Btn_Time.Img_bg:SetSprite("UI/Common/right_off")
  end,
  Squads_Group_CharacterSelect_Common_Filter_Group_TabBtn_Btn_Time_Click = function(btn, str)
    DataModel.isRefreshRoleData = true
    CommonFilter.SortBtn(3)
    View.Group_CharacterSelect.Common_Filter.Group_TabBtn.Btn_Level.Img_bg:SetSprite("UI/Common/left_off")
    View.Group_CharacterSelect.Common_Filter.Group_TabBtn.Btn_Rarity.Img_bg:SetSprite("UI/Common/center_off")
    View.Group_CharacterSelect.Common_Filter.Group_TabBtn.Btn_Time.Img_bg:SetSprite("UI/Common/right_on")
  end,
  Squads_Group_CharacterSelect_Common_Filter_Group_TabBtn_Btn_Screen_Click = function(btn, str)
    DataModel.isRefreshRoleData = true
    CommonFilter.SortBtn(4)
  end,
  Squads_Group_CharacterSelect_Common_Filter_Group_Filter_Btn_Cancel_Click = function(btn, str)
    CommonFilter.OpenFilter(false)
  end,
  Squads_Group_Detail_Btn_Role_Click = function(btn, str)
    UISquadsGlobalData:SetSelectSquadIndex(DataModel:GetCurSquadIndex())
    DataModel.hasOpenThreeView = true
    if DataModel.curDetailIndex == 1 then
      DataDetail:CloseDetail()
    end
    if DataModel.curDetailIndex == 2 then
      DataDetail:CloseChooseDetail()
    end
    local data = {
      currentRoleId = DataModel.RoleData.id,
      fromView = EnumDefine.CommonFilterType.SquadView,
      current = DataModel.Current,
      IsSquad = true,
      SquadsRoleList = PlayerData.currentSquad
    }
    UIManager:Open("UI/CharacterInfo/CharacterInfo", Json.encode(data))
  end,
  Squads_Group_Detail_Btn_Captain_Click = function(btn, str)
    if DataModel.curDetailIndex == 2 then
      return
    end
    local squad = PlayerData.ServerData.squad[DataModel.curSquadIndex]
    if DataModel.isUseLevelRole == true then
      local autoBattle = require("UIAutoBattle/UIAutoBattleDataModel")
      autoBattle.header = DataModel.RoleData.id
      PlayerData:SaveLevelRoleCaptain(DataModel.curLevelId, DataModel.RoleData.id)
      DataModel.header = DataModel.RoleData.id
      for i = 1, table.count(DataModel.curSquad) do
        if tonumber(DataModel.curSquad[i].unitId) == tonumber(DataModel.RoleData.id) then
          View.StaticGrid_List.grid[i].Btn_Character.Img_Captain:SetActive(true)
          PlayerData.BattleInfo.header = DataModel.RoleData.id
        else
          View.StaticGrid_List.grid[i].Btn_Character.Img_Captain:SetActive(false)
        end
      end
      return
    elseif PlayerData.helpSquadIndex ~= nil and DataModel.curSquadIndex == PlayerData.helpSquadIndex then
      local autoBattle = require("UIAutoBattle/UIAutoBattleDataModel")
      autoBattle.header = DataModel.RoleData.id
      DataModel.header = DataModel.RoleData.id
      for i = 1, table.count(DataModel.curSquad) do
        if tonumber(DataModel.curSquad[i].unitId) == tonumber(DataModel.RoleData.id) then
          View.StaticGrid_List.grid[i].Btn_Character.Img_Captain:SetActive(true)
          PlayerData.BattleInfo.header = DataModel.RoleData.id
        else
          View.StaticGrid_List.grid[i].Btn_Character.Img_Captain:SetActive(false)
        end
      end
      return
    end
    if DataModel.RoleData.id == squad.header then
      return
    end
    Net:SendProto("deck.set_deck", function(res)
      local autoBattle = require("UIAutoBattle/UIAutoBattleDataModel")
      autoBattle.header = DataModel.RoleData.id
      squad.header = DataModel.RoleData.id
      DataModel.header = DataModel.RoleData.id
      PlayerData.ServerData.squad[DataModel.curSquadIndex].header = DataModel.header
      for i = 1, table.count(squad.role_list) do
        if tonumber(squad.role_list[i].id) == tonumber(DataModel.RoleData.id) then
          View.StaticGrid_List.grid[i].Btn_Character.Img_Captain:SetActive(true)
          PlayerData.BattleInfo.header = DataModel.RoleData.id
        else
          View.StaticGrid_List.grid[i].Btn_Character.Img_Captain:SetActive(false)
        end
      end
      SquadController.ShowDetail(DataModel.curSquadIndex)
    end, DataModel.curSquadIndex - 1, nil, DataModel.RoleData.id)
  end,
  Squads_Group_Detail_Btn_Check_Click = function(btn, str)
    if PlayerData.selectedRightIndex ~= nil and PlayerData.selectedRightIndex == 3 then
      return
    end
    
    local function callBack()
      View.Group_Detail.Btn_Save.Txt_T:SetText(GetText(80606252))
      CharacterSelector:Open(DataModel.curSquadIndex, DataDetail.Last_Index, 1)
      DataDetail:CloseDetail()
    end
    
    local function callBack1()
      if DataModel.RoleData and DataModel.RoleData.Squads then
        SquadController:GetDefault_Send(DataModel.curSelectIndex, callBack)
      else
        callBack()
      end
    end
    
    if PlayerData.helpRoleList ~= nil then
      CommonTips.OnPrompt(GetText(80611653), "80600068", "80600067", function()
        callBack1()
      end)
    else
      callBack1()
    end
  end,
  Squads_Group_Detail_Btn_InTeam_Click = function(btn, str)
    if SquadController:GetSquadsNumMax() == true then
      CommonTips.OpenTips(80600128)
      return
    end
    if SquadController:GetSquadsNum() == 0 then
      DataModel.header = DataModel.RoleData.id
    end
    local Index = CharacterSelectController:SearchFirstPlace()
    DataModel.Squads[DataModel.curSquadIndex][Index] = DataModel.RoleData.id
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
    DataModel.curSquad = DataController:GetRoleDataList(currentSquad)
    DataModel.currentSquad = DataModel.Squads[DataModel.curSquadIndex]
    local connect = "|"
    local string_value = ""
    local squad = DataModel.Squads[DataModel.curSquadIndex]
    for i = 1, table.count(squad) do
      local v = squad[i]
      string_value = string_value .. v .. connect
    end
    string_value = string.sub(string_value, 1, string.len(string_value) - 1)
    Net:SendProto("deck.set_deck", function(res)
      if GetNowCaptain() == "" then
        SetCaptain()
      end
      PlayerData.ServerData.squad[DataModel.curSquadIndex].role_list = Clone(DataModel.Squads[DataModel.curSquadIndex])
      PlayerData.currentSquad = currentSquad
      DataModel.SortRoles[DataDetail.Last_Index].squads_index = Index
      CharacterSelectController:ClickRoleElement(DataDetail.Last_Index)
      DataDetail:CloseChooseDetail()
    end, DataModel.curSquadIndex - 1, string_value, PlayerData.ServerData.squad[DataModel.curSquadIndex].header)
  end,
  Squads_Group_Detail_Btn_OutTeam_Click = function(btn, str)
    local connect = "|"
    local string_value = ""
    local squad = PlayerData.ServerData.squad[DataModel.curSquadIndex]
    local temp_index = 0
    for i = 1, table.count(squad.role_list) do
      local v = squad.role_list[i] and squad.role_list[i].id or ""
      if tonumber(v) == tonumber(DataModel.RoleData.id) then
        squad.role_list[i].id = ""
        temp_index = i
      end
    end
    for i = 1, table.count(squad.role_list) do
      local v = squad.role_list[i] and squad.role_list[i].id or ""
      string_value = string_value .. v .. connect
    end
    string_value = string.sub(string_value, 1, string.len(string_value) - 1)
    if tonumber(DataModel.RoleData.id) == tonumber(GetNowCaptain()) then
      RemoveCaptain()
      PlayerData.ServerData.squad[DataModel.curSquadIndex].header = DataModel.header
    end
    Net:SendProto("deck.set_deck", function(res)
      DataModel.curSquad[temp_index] = {}
      DataModel.Squads[DataModel.curSquadIndex][temp_index] = ""
      DataModel.HaveSquads[DataModel.RoleData.id] = nil
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
      PlayerData.ServerData.squad[DataModel.curSquadIndex].role_list = Clone(DataModel.Squads[DataModel.curSquadIndex])
      if DataModel.curDetailIndex == 1 then
        DataDetail:CloseDetail()
        SquadController.RefreshRoles()
      end
      if DataModel.curDetailIndex == 2 then
        DataModel.SortRoles[DataDetail.Last_Index].squads_index = 0
        CharacterSelectController:ClickRoleElement(DataDetail.Last_Index)
        DataDetail:CloseChooseDetail()
      end
    end, DataModel.curSquadIndex - 1, string_value, PlayerData.ServerData.squad[DataModel.curSquadIndex].header)
  end,
  Squads_Group_Detail_Group_Property_Btn_Attribute_Click = function(btn, str)
  end,
  Squads_Group_Detail_Group_Attribute_StaticGrid_Item_SetGrid = function(element, elementIndex)
  end,
  Squads_Group_CharacterSelect_ScrollGrid_CharacterList_Group_Character_Btn_Item_Click = function(btn, str)
    local lastIndex = DataModel.curSelectIndex
    local index = tonumber(str)
    local data = DataModel.SortRoles[index]
    if DataModel.curSelectIndex ~= nil and DataModel.curSelectIndex ~= index then
      DataDetail:ShowLeftDetail(index, data)
    end
    if DataModel.isUseLevelRole then
      local levelData = PlayerData:GetFactoryData(DataModel.curLevelId)
      if levelData and data.squads_index > 0 and data.squads_index <= levelData.roleNumOffSet then
        return
      end
    end
    if isQuickTeam == 1 then
      if data.squads_index == 0 then
        local squads = DataModel.Squads[DataModel.curSquadIndex]
        if DataModel.isUseLevelRole == true then
          squads = DataModel.currentSquad
        end
        for i = 1, 5 do
          local temp = {}
          temp = squads[i]
          if temp and temp.id == data.id then
            for j = 1, #DataModel.SortRoles do
              if DataModel.SortRoles[j].id == data.id and DataModel.SortRoles[j].squads_index == i then
                squads[i] = {}
                DataModel.SortRoles[j].squads_index = 0
                CharacterSelectController:ClickRoleElement(j)
              end
            end
          end
        end
        if SquadController:GetSquadsNumMax() == true then
          CommonTips.OpenTips(80600128)
          return
        end
        if SquadController:GetSquadsNum() == 0 then
          DataModel.header = data.id
        end
        local Index = CharacterSelectController:SearchFirstPlace()
        squads[Index] = {}
        squads[Index].id = data.id
        squads[Index].equips = {
          [1] = "",
          [2] = ""
        }
        squads[Index].skill_list = {
          [1] = "",
          [2] = "",
          [3] = ""
        }
        squads[Index].isLevelRole = data.isLevelRole
        local currentSquad = {}
        local curRoleList = squads
        for i = 1, 5 do
          local temp = {}
          temp = curRoleList[i]
          if temp and temp.id == "" then
            temp.id = nil
          end
          table.insert(currentSquad, temp)
        end
        DataModel.curSquad = DataController:GetRoleDataList(currentSquad)
        DataModel.currentSquad = squads
        PlayerData.currentSquad = currentSquad
        DataModel.SortRoles[index].squads_index = Index
        CharacterSelectController:ClickRoleElement(index)
        DataModel.LastRoleIndex = Index
      else
        local squad = DataModel.Squads[DataModel.curSquadIndex]
        if DataModel.isUseLevelRole == true then
          squad = DataModel.currentSquad
        end
        local temp_index = 0
        local id = data.id
        local count = table.count(squad)
        for i = 1, count do
          local v = squad[i] and squad[i].id or ""
          if tonumber(v) == tonumber(id) then
            squad[i].id = ""
            temp_index = i
          end
        end
        if tonumber(id) == tonumber(GetNowCaptain()) or tonumber(id) == tonumber(DataModel.header) then
          RemoveCaptain()
        end
        DataModel.curSquad[temp_index] = {}
        squad[temp_index] = {}
        local currentSquad = {}
        local curRoleList = squad
        for i = 1, 5 do
          local temp = {}
          temp = curRoleList[i]
          if temp and temp.id == "" then
            temp.id = nil
          end
          table.insert(currentSquad, temp)
        end
        PlayerData.currentSquad = currentSquad
        DataModel.SortRoles[index].squads_index = 0
        CharacterSelectController:ClickRoleElement(index)
        if DataModel.LastRoleIndex and DataModel.LastRoleIndex == temp_index then
          DataModel.LastRoleIndex = nil
        end
      end
      DataModel.currentSortSquad = {}
      local Sort_List = {}
      local select = 0
      for k, v in pairs(DataModel.SortRoles) do
        v.squads_index = 0
        if v.isLevelRole == false then
          v.isLevelRole = nil
        end
        for c, d in pairs(DataModel.currentSquad) do
          if d.isLevelRole == false then
            d.isLevelRole = nil
          end
          if tonumber(v.id) == tonumber(d.id) and v.isLevelRole == d.isLevelRole then
            v.squads_index = c
            select = select + 1
            table.insert(DataModel.currentSortSquad, v)
          end
        end
      end
      for c, d in pairs(DataModel.SortRoles) do
        if d.squads_index == 0 then
          table.insert(Sort_List, d)
        end
      end
      CommonFilter:SetRoleData(Sort_List)
    else
      local id
      if lastIndex ~= index then
        local data = DataModel.SortRoles[index]
        data.element.Group_InTeam:SetActive(true)
        if DataModel.SortRoles[lastIndex] and DataModel.SortRoles[lastIndex].element then
          DataModel.SortRoles[lastIndex].element.Group_InTeam:SetActive(false)
        end
        for i = 1, 5 do
          data.element.Group_InTeam["Img_Index" .. i]:SetActive(false)
        end
        data.element.Group_InTeam["Img_Index" .. teamIndex]:SetActive(true)
        id = tostring(DataModel.SortRoles[index].id)
        DataModel.SortRoles[index].squads_index = teamIndex
      elseif DataModel.SortRoles[index].squads_index ~= 0 then
        id = nil
        DataModel.SortRoles[index].squads_index = 0
        DataModel.SortRoles[index].element.Group_InTeam:SetActive(false)
      else
        DataModel.SortRoles[index].squads_index = teamIndex
        id = tostring(DataModel.SortRoles[index].id)
        DataModel.SortRoles[index].element.Group_InTeam:SetActive(true)
        data.element.Group_InTeam["Img_Index" .. teamIndex]:SetActive(true)
      end
      local squads = DataModel.Squads[DataModel.curSquadIndex]
      if DataModel.isUseLevelRole == true then
        squads = DataModel.currentSquad
      end
      if DataModel.SortRoles[index].squads_index ~= 0 then
        squads[teamIndex] = {}
        squads[teamIndex].id = tonumber(id)
        squads[teamIndex].equips = {
          [1] = "",
          [2] = ""
        }
        squads[teamIndex].skill_list = {
          [1] = "",
          [2] = "",
          [3] = ""
        }
        squads[teamIndex].isLevelRole = data.isLevelRole
        if SquadController:GetSquadsNum() == 1 then
          DataModel.header = data.id
        end
        if DataModel.SortRoles[lastIndex].id == tonumber(DataModel.header) then
          DataModel.header = data.id
        end
        if lastIndex ~= index then
          DataModel.SortRoles[lastIndex].squads_index = 0
        end
        DataModel.currentSortSquad[teamIndex] = DataModel.SortRoles[index]
      else
        squads[teamIndex] = ""
        if SquadController:GetSquadsNum() == 0 then
          DataModel.header = nil
        end
        if tonumber(data.id) == tonumber(GetNowCaptain()) or tonumber(data.id) == tonumber(DataModel.header) then
          RemoveCaptain()
        end
      end
      local currentSquad = {}
      local curRoleList = squads
      for i = 1, 5 do
        local temp = {}
        temp = curRoleList[i]
        if temp and temp.id == "" then
          temp.id = nil
        end
        table.insert(currentSquad, temp)
      end
      PlayerData.currentSquad = currentSquad
      local Sort_List = {}
      for c, d in pairs(DataModel.SortRoles) do
        if d.squads_index == 0 and not d.isLevelRole then
          table.insert(Sort_List, d)
        end
      end
      CommonFilter:SetRoleData(Sort_List)
    end
  end,
  Squads_Group_CharacterSelect_Group_Detail_Btn_Confirm_Click = function(btn, str)
    local connect = "|"
    local string_value = ""
    local squads = DataModel.Squads[DataModel.curSquadIndex]
    local squad
    if DataModel.isUseLevelRole == true then
      squads = DataModel.currentSquad
      squad = {role_list = squads}
    else
      PlayerData.ServerData.squad[DataModel.curSquadIndex].role_list = Clone(squads)
      squad = PlayerData.ServerData.squad[DataModel.curSquadIndex]
    end
    local now_role_list = {}
    local isHeader = false
    for i = 1, table.count(squad.role_list) do
      local v = squad.role_list[i] and squad.role_list[i].id or ""
      string_value = string_value .. v .. connect
      now_role_list[i] = squad.role_list[i].id or ""
      if tonumber(v) == tonumber(DataModel.header) then
        isHeader = true
      end
    end
    if isHeader == false then
      SetCaptain()
    end
    if DataModel.isUseLevelRole ~= true then
      if DataModel.header then
        PlayerData.ServerData.squad[DataModel.curSquadIndex].header = DataModel.header
      end
      if SquadController:GetSquadsNum() == 0 then
        string_value = ""
        PlayerData.ServerData.squad[DataModel.curSquadIndex].header = nil
      end
    elseif DataModel.curLevelId ~= nil then
      PlayerData:SaveLevelRoleCaptain(DataModel.curLevelId, DataModel.header)
    end
    string_value = string.sub(string_value, 1, string.len(string_value) - 1)
    local a, v, nowV = table:Difference(now_role_list, DataModel.InitRoleList)
    
    local function callBack()
      DataController:SetSquad(PlayerData.currentSquad, #View.StaticGrid_List.grid, DataModel.isUseLevelRole)
      DataModel:RefreshSquadsInit()
      CharacterSelectController:OpenView(false)
      DataModel.curDetailIndex = 1
      DataModel:RefreshUrEquip()
      SquadController.RefreshRoles()
      SquadController.ShowDetail(DataModel.curSquadIndex)
      DataModel:SetEquipHaveList()
      if DataModel.LastRoleIndex then
        DataModel.curSelectIndex = DataModel.LastRoleIndex
        local role = DataModel.curSquad[DataModel.curSelectIndex]
        DataModel.LastRoleIndex = nil
        if not role or table.count(role) ~= 0 then
        end
      end
    end
    
    if DataModel.isUseLevelRole == true then
      local autoBattle = require("UIAutoBattle/UIAutoBattleDataModel")
      local autoBattleVF = require("UIAutoBattle/UIAutoBattleViewFunction")
      for i = 1, #v do
        autoBattle:RemoveCardsByUnitId(autoBattle.CurrentData, tonumber(v[i]))
      end
      for i = 1, #nowV do
        autoBattle:AddCardsByUnitId(autoBattle.CurrentData, tonumber(nowV[i]))
      end
      autoBattleVF.SaveData(true)
      callBack()
      DataModel.RoleData = nil
      return
    end
    if 0 < a then
      Net:SendProto("deck.set_deck", function(res)
        local autoBattle = require("UIAutoBattle/UIAutoBattleDataModel")
        local autoBattleVF = require("UIAutoBattle/UIAutoBattleViewFunction")
        for i = 1, #v do
          autoBattle:RemoveCardsByUnitId(autoBattle.CurrentData, tonumber(v[i]))
        end
        for i = 1, #nowV do
          autoBattle:AddCardsByUnitId(autoBattle.CurrentData, tonumber(nowV[i]))
        end
        autoBattleVF.SaveData(true)
        print_r(res)
        callBack()
      end, DataModel.curSquadIndex - 1, string_value, PlayerData.ServerData.squad[DataModel.curSquadIndex].header)
    else
      callBack()
      DataModel.RoleData = nil
    end
  end,
  Squads_Group_CharacterSelect_ScrollGrid_CharacterList_Group_Character_Group_Break_StaticGrid_BK_SetGrid = function(element, elementIndex)
    element.Img_On:SetActive(false)
    if elementIndex <= DataModel.Break_Role.awake_lv then
      element.Img_On:SetActive(true)
    end
  end,
  Squads_Group_CharacterSelect_ScrollGrid_CharacterList_Group_Character_Btn_Mask_Click = function(btn, str)
    DataDetail:CloseChooseDetail()
  end,
  Squads_Group_CharacterSelect_Group_Detail_Btn_Role_Click = function(btn, str)
    DataModel.hasOpenThreeView = true
    DataModel.isRefreshRoleData = false
    local data = {
      currentRoleId = DataModel.RoleData.id,
      fromView = EnumDefine.CommonFilterType.SquadView,
      current = DataModel.Current,
      IsSquad = true,
      SquadsRoleList = PlayerData.currentSquad
    }
    UIManager:Open("UI/CharacterInfo/CharacterInfo", Json.encode(data))
  end,
  Squads_Group_CharacterSelect_Group_Detail_Btn_Captain_Click = function(btn, str)
    if SquadController:GetSquadsNumMax() == true then
      CommonTips.OpenTips(80600128)
      return
    end
    if SquadController:GetSquadsNum() == 0 then
      DataModel.header = DataModel.RoleData.id
    end
    local Index = CharacterSelectController:SearchFirstPlace()
    DataModel.Squads[DataModel.curSquadIndex][Index] = DataModel.RoleData.id
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
    DataModel.curSquad = DataController:GetRoleDataList(currentSquad)
    DataModel.currentSquad = DataModel.Squads[DataModel.curSquadIndex]
    PlayerData.ServerData.squad[DataModel.curSquadIndex].role_list = Clone(DataModel.Squads[DataModel.curSquadIndex])
    PlayerData.currentSquad = currentSquad
    local squad = PlayerData.ServerData.squad[DataModel.curSquadIndex]
    squad.header = DataModel.RoleData.id
    DataModel.SortRoles[DataModel.curSelectIndex].squads_index = Index
    CharacterSelectController:ClickRoleElement(DataModel.curSelectIndex)
    DataDetail:RefreshBottomState(DataModel.SortRoles[DataModel.curSelectIndex])
  end,
  Squads_Group_CharacterSelect_Group_Detail_Btn_Check_Click = function(btn, str)
  end,
  Squads_Group_CharacterSelect_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if View.Group_CardDesCharacter.self.IsActive == true then
      View.Group_CharacterSelect.Group_Detail.Group_Card.Btn_Close_Des.self:SetActive(false)
      DataModel.CloseCardDes()
      return
    end
    if DataModel.isUseLevelRole then
      PlayerData.currentSquad = PlayerData.currentSquad or {}
    else
      PlayerData.currentSquad = PlayerData.ServerData.squad[DataModel.curSquadIndex].role_list
    end
    DataController:SetSquad(PlayerData.currentSquad, #View.StaticGrid_List.grid)
    DataModel:RefreshSquadsInit()
    CharacterSelectController:OpenView(false)
    DataModel.curDetailIndex = 1
    SquadController.RefreshRoles()
    DataModel:SetEquipHaveList()
    if DataModel.LastRoleIndex then
      DataModel.curSelectIndex = DataModel.LastRoleIndex
      local role = DataModel.curSquad[DataModel.curSelectIndex]
      DataModel.LastRoleIndex = nil
      if role.id ~= nil then
      end
    end
  end,
  Squads_Group_CharacterSelect_Group_Detail_Btn_InTeam_Click = function(btn, str)
    if SquadController:GetSquadsNumMax() == true then
      CommonTips.OpenTips(80600128)
      return
    end
    if SquadController:GetSquadsNum() == 0 then
      DataModel.header = DataModel.RoleData.id
    end
    local Index = CharacterSelectController:SearchFirstPlace()
    DataModel.Squads[DataModel.curSquadIndex][Index] = DataModel.RoleData.id
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
    DataModel.curSquad = DataController:GetRoleDataList(currentSquad)
    DataModel.currentSquad = DataModel.Squads[DataModel.curSquadIndex]
    if GetNowCaptain() == "" then
      SetCaptain()
    end
    PlayerData.ServerData.squad[DataModel.curSquadIndex].role_list = Clone(DataModel.Squads[DataModel.curSquadIndex])
    PlayerData.currentSquad = currentSquad
    DataModel.SortRoles[DataModel.curSelectIndex].squads_index = Index
    CharacterSelectController:ClickRoleElement(DataModel.curSelectIndex)
    DataDetail:RefreshBottomState(DataModel.SortRoles[DataModel.curSelectIndex])
  end,
  Squads_Group_CharacterSelect_Group_Detail_Btn_OutTeam_Click = function(btn, str)
    local connect = "&"
    local string_value = ""
    local squad = PlayerData.ServerData.squad[DataModel.curSquadIndex]
    local temp_index = 0
    for i = 1, table.count(squad.role_list) do
      local v = squad.role_list[i] and squad.role_list[i].id or ""
      if tonumber(v) == tonumber(DataModel.RoleData.id) then
        squad.role_list[i].id = ""
        temp_index = i
      end
    end
    if tonumber(DataModel.RoleData.id) == tonumber(GetNowCaptain()) then
      RemoveCaptain()
    end
    DataModel.curSquad[temp_index] = {}
    DataModel.Squads[DataModel.curSquadIndex][temp_index] = ""
    DataModel.HaveSquads[DataModel.RoleData.id] = nil
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
    PlayerData.ServerData.squad[DataModel.curSquadIndex].role_list = Clone(DataModel.Squads[DataModel.curSquadIndex])
    if DataModel.curDetailIndex == 1 then
      SquadController.RefreshRoles()
    end
    if DataModel.curDetailIndex == 2 then
      DataModel.SortRoles[DataModel.curSelectIndex].squads_index = 0
      CharacterSelectController:ClickRoleElement(DataModel.curSelectIndex)
    end
    DataDetail:RefreshBottomState(DataModel.SortRoles[DataModel.curSelectIndex])
  end,
  Squads_Group_CharacterSelect_Group_Detail_Group_Card_StaticGrid_Card_SetGrid = function(element, elementIndex)
    element.Btn_Skill:SetClickParam(tostring(elementIndex))
    element.Txt_SkillLV.Txt_Num:SetText(DataModel.RoleData.skills[elementIndex].lv or 1)
    local skillId = DataModel.RoleCA.skillList[tonumber(elementIndex)].skillId
    local data = PlayerData:GetFactoryData(skillId, "SkillFactory")
    element.Txt_Name:SetText(data.name)
    element.Img_Icon:SetSprite(data.iconPath)
    local cardCA = PlayerData:GetFactoryData(data.cardID)
    element.Img_Icon:SetColor(Color.white)
    if cardCA.color == "Red" then
      element.Img_Icon:SetColor(GameSetting.redCardColor)
    end
    element.Group_Cost.Txt_Num:SetText(math.ceil(cardCA.cost_SN))
  end,
  Squads_Group_CharacterSelect_Group_Detail_Group_Property_Btn_Attribute_Click = function(btn, str)
  end,
  Squads_Group_CharacterSelect_Group_Detail_Group_Attribute_StaticGrid_Item_SetGrid = function(element, elementIndex)
  end,
  Squads_Group_CharacterSelect_Group_Detail_Group_Card_StaticGrid_Card_Group_IconSkill_Btn_Skill_Click = function(btn, str)
    local row = DataModel.SortRoles[DataModel.curSelectIndex].skillList[tonumber(str)]
    local aa = {}
    aa.id = row.id
    aa.type = tonumber(str) + 4
    aa.description = row.des
    View.Group_CharacterSelect.Group_Detail.Group_Card.Btn_Close_Des.self:SetActive(true)
    DataModel.OpenCardDes(aa)
  end,
  Squads_Group_Detail_Btn_Close_Click = function(btn, str)
    local function callBack()
      if DataModel.curSelectIndex then
        View.StaticGrid_List.grid[DataModel.curSelectIndex].Img_Selected:SetActive(false)
      end
      DOTweenTools.DOLocalMoveYCallback(View.Group_Detail.transform, -600, 0.5, nil, function()
        DataDetail:CloseDetail()
      end)
    end
    
    if DataModel.RoleData and DataModel.RoleData.Squads then
      SquadController:GetDefault_Send(DataModel.curSelectIndex, callBack)
    else
      callBack()
    end
  end,
  Squads_Group_EquipSelected_ScrollGrid_Equipment_SetGrid = function(element, elementIndex)
    local equip = DataModel.Equipments[elementIndex]
    element.Btn_Item:SetClickParam(tostring(elementIndex))
    CommonItem:SetEquipment(element, equip.data, equip.owner ~= nil, equip.type)
  end,
  Squads_Group_EquipSelected_ScrollGrid_Equipment_Group_Equipment_Btn_Item_Click = function(btn, str)
    local equip = DataModel.Equipments[tonumber(str)]
    if equip.owner ~= nil then
      CommonTips.OpenTips(80600135)
      return
    end
    if equip.type == false then
      CommonTips.OpenTips(80600142)
      return
    end
    if equip.iscross == false and equip.isweight == true then
      CommonTips.OpenTips(80600047)
      return
    end
    if equip.isLock == true then
      CommonTips.OpenTips("80600048")
      return
    end
    if equip.iscross == true and equip.isweight == true then
      EquipSelected:AddEquip(equip)
    end
    if DataModel.SquadEquip.IsCompare then
      local params = {
        Index = DataModel.Index,
        ReplaceEid = equip.eid,
        RoleId = DataModel.RoleId
      }
      UIManager:Open("UI/Equipment/EquipCompare", Json.encode(params))
    else
      EquipSelected:AddEquip(equip)
    end
  end,
  Squads_Group_EquipSelected_Group_TopLeft_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    View.Group_EquipSelected.self:SetActive(false)
  end,
  Squads_Group_EquipSelected_Group_TopLeft_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  Squads_Group_EquipSelected_Group_TopLeft_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Squads_Group_EquipSelected_Group_TopLeft_Btn_TabEquipment_Click = function(btn, str)
  end,
  Squads_Group_EquipSelected_Group_TopRight_Btn_Decompose_Click = function(btn, str)
  end,
  Squads_Group_EquipSelected_Group_TopRight_Btn_Rarity_Click = function(btn, str)
  end,
  Squads_Group_EquipSelected_Group_TopRight_Btn_Screen_Click = function(btn, str)
  end,
  Squads_Group_EquipSelected_Group_TopRight_Btn_Time_Click = function(btn, str)
  end,
  Squads_Group_ProvingGround_Group_Enemy_ScrollGrid_Face_SetGrid = function(element, elementIndex)
    local curInfo = DataModel.ChallengeInfo[elementIndex]
    element.Btn_tubiao.Group_Select.Img_FaceSelect:SetSprite(curInfo.faceRes)
    element.Btn_tubiao.Group_Unselect.Img_Face:SetSprite(curInfo.faceRes)
    element.Btn_tubiao.Group_Unselect.Img_Lock:SetActive(not curInfo.isUnlock)
    local isSelected = elementIndex == DataModel.curShowIdx
    element.Btn_tubiao.Group_Select.self:SetActive(isSelected)
    element.Btn_tubiao.Group_Unselect.self:SetActive(not isSelected)
    local scale = isSelected and 1.2 or 1
    element.Btn_tubiao.self:SetLocalScale(Vector3(scale, scale, scale))
    element.Btn_tubiao:SetClickParam(elementIndex)
    element.Btn_tubiao.Txt_:SetText(curInfo.serialNumber)
  end,
  Squads_Group_ProvingGround_Group_Enemy_ScrollGrid_Face_Group_Item_Btn_tubiao_Click = function(btn, str)
    local idx = tonumber(str)
    DataController:ShowChallengeDetail(idx)
    View.Group_ProvingGround.Group_Enemy.ScrollGrid_Face.grid.self:SetSacleIndex(idx - 1, 1.2)
    View.Group_ProvingGround.Group_Enemy.ScrollGrid_Face.grid.self:RefreshAllElement()
  end,
  Squads_Group_ProvingGround_Group_Challenge_Btn_Start_Click = function(btn, str)
    local info = DataModel.ChallengeInfo[DataModel.curShowIdx]
    local index = -1
    for k, v in pairs(DataModel.curSquad) do
      if next(v) ~= nil then
        v.squadIndex = k
      end
      if tonumber(v.unitId) == tonumber(PlayerData.ServerData.squad[DataModel.curSquadIndex].header) then
        index = k
      end
    end
    if -1 < index then
      local row = DataModel.curSquad[index]
      table.remove(DataModel.curSquad, index)
      table.insert(DataModel.curSquad, 1, row)
    end
    local levelCA = PlayerData:GetFactoryData(info.levelId)
    if SquadController:GetNewSquadsNum() < levelCA.minRoleNum then
      CommonTips.OpenTips(string.format(GetText(80601995), levelCA.minRoleNum))
      return
    end
    if next(DataModel.curSquad[1]) == nil then
      CommonTips.OpenTips(80600176)
      return
    end
    if info and LevelCheck.AllCheck(info.levelId, true) then
      PlayerData.BattleCallBackPage = "UI/Squads/Squads"
      local status = {
        Current = "MainUI",
        hasOpenThreeView = false,
        squadIndex = PlayerData.BattleInfo.squadIndex,
        enterTest = true
      }
      PlayerData.Last_Chapter_Parms = status
      StartBattle:StartBattle(info.levelId, 1, DataModel.curSquad, DataModel.curSquadIndex, nil, true, nil, function(info, isPrologue)
        local res = Json.decode(info)
        PlayerData.BattleInfo.BattleResult = res
        local survivor = res.survivor or 0
        if res.isWin or survivor == 0 then
          CommonTips.OpenSettlement()
        else
          CommonTips.OpenArbitrarilyUI(PlayerData.BattleCallBackPage, PlayerData.Last_Chapter_Parms)
        end
      end)
    end
  end,
  Squads_Group_ProvingGround_Group_Challenge_Group_Reward_StaticGrid_Reward_SetGrid = function(element, elementIndex)
    local info = DataModel.ChallengeInfo[DataModel.curShowIdx]
    local reward = info.firstPassAward[elementIndex]
    local isEmpty = reward == nil
    element.Group_Item.self:SetActive(not isEmpty)
    element.Img_Seleted.self:SetActive(not isEmpty)
    element.Img_Null:SetActive(isEmpty)
    if isEmpty then
      return
    end
    local complete = PlayerData:GetLevelPass(info.levelId)
    local factoryName = DataManager:GetFactoryNameById(reward.itemId)
    local dataCA = PlayerData:GetFactoryData(reward.itemId, factoryName)
    local iconPath = dataCA.iconPath
    if not complete and reward.itemId == 10000741 then
      iconPath = "UI\\Squads\\Silhouette"
    elseif factoryName == "UnitFactory" then
      local unitViewCA = PlayerData:GetFactoryData(tonumber(dataCA.viewId), "UnitViewFactory")
      iconPath = unitViewCA.face
    end
    element.Img_Seleted.self:SetActive(complete)
    CommonItem:SetItem(element.Group_Item, dataCA)
    element.Group_Item.Btn_Item:SetClickParam(elementIndex)
  end,
  Squads_Group_ProvingGround_Group_Challenge_Group_Reward_StaticGrid_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local idx = tonumber(str)
    local info = DataModel.ChallengeInfo[DataModel.curShowIdx]
    local reward = info.firstPassAward[idx]
    local complete = PlayerData:GetLevelPass(info.levelId)
    if not complete and reward.itemId == 10000741 then
      CommonTips.OpenTips(80600321)
      return
    end
    local param = {}
    param.itemId = reward.itemId
    local factoryName = DataManager:GetFactoryNameById(reward.itemId)
    if factoryName == "UnitFactory" then
      CommonTips.OpenUnitDetail({
        id = reward.itemId
      })
      return
    else
      CommonTips.OpenItem(param)
    end
  end,
  Squads_Group_ProvingGround_Group_Challenge_Group_Reward_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  Squads_Group_ProvingGround_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    if PlayerData.SquadsTempData and PlayerData.SquadsTempData.enterTest then
      PlayerData.SquadsTempData.enterTest = nil
    end
    View.Group_ProvingGround.self:SetActive(false)
    PlayerData.SetIsTest()
  end,
  Squads_Group_ProvingGround_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
    PlayerData.SetIsTest()
  end,
  Squads_Group_ProvingGround_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
    PlayerData.SetIsTest()
  end,
  Squads_Group_Detail_Btn_Save_Click = function(btn, str)
  end,
  Squads_Group_CardYard_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    CardPollController:OpenView(false)
  end,
  Squads_Group_CardYard_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
  end,
  Squads_Group_CardYard_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Squads_Group_CardYard_Btn_Close_Skill_Click = function(btn, str)
    DataModel.CloseCardDes()
  end,
  Squads_Group_CardYard_Btn_Dictionary_Click = function(btn, str)
    UIManager:Open("UI/Dictionary/Dictionary")
  end,
  Squads_Group_Detail_Group_Card_StaticGrid_Card_SetGrid = function(element, elementIndex)
    element.Txt_SkillLV.Txt_Num:SetText(DataModel.RoleData.skills[elementIndex].lv or 1)
    local skillId = DataModel.RoleCA.skillList[tonumber(elementIndex)].skillId
    element.Btn_Skill:SetClickParam(tonumber(elementIndex))
    local data = PlayerData:GetFactoryData(skillId, "SkillFactory")
    element.Txt_Name:SetText(data.name)
    element.Img_Icon:SetSprite(data.iconPath)
    local cardCA = PlayerData:GetFactoryData(data.cardID)
    element.Img_Icon:SetColor(Color.white)
    if cardCA.color == "Red" then
      element.Img_Icon:SetColor(GameSetting.redCardColor)
    end
    element.Group_Cost.Txt_Num:SetText(math.ceil(cardCA.cost_SN))
  end,
  Squads_Group_Detail_Group_Card_StaticGrid_Card_Group_IconSkill_Btn_Skill_Click = function(btn, str)
    local aa = {}
    local row = DataModel.SkillList[DataModel.curSquadIndex][DataModel.curSelectIndex][tonumber(str)]
    if DataModel.isUseLevelRole or DataModel.RoleData.isHelpRole then
      row = PlayerData:GetCardDes(DataModel.RoleData.id)[tonumber(str)]
    end
    aa.id = row.id
    aa.type = tonumber(str) + 4
    aa.description = row.des
    View.Group_Detail.Group_Card.Btn_Close_Des.self:SetActive(true)
    DataModel.OpenCardDes(aa)
  end,
  Squads_Group_CharacterSelect_Group_Detail_Group_Equip_StaticGrid_Equip_SetGrid = function(element, elementIndex)
  end,
  Squads_Group_CharacterSelect_Group_Detail_Group_Equip_StaticGrid_Equip_Group_Equip_Btn_Equip_Click = function(btn, str)
  end,
  Squads_Group_Detail_Group_Equip_StaticGrid_Equip_SetGrid = function(element, elementIndex)
    local eid = DataModel.RoleData.equips[elementIndex]
    element.Btn_Item:SetClickParam(tonumber(elementIndex))
    element.Group_Equipment.Btn_Item:SetClickParam(tonumber(elementIndex))
    element.Btn_Item:SetActive(true)
    local equip = type(eid) == "table" and eid or PlayerData:GetEquipByEid(eid)
    element.Img_Disable:SetActive(false)
    element.Group_Equipment.Img_NoType:SetActive(false)
    element.Group_Equipment.Img_Select:SetActive(false)
    element.Group_Tip:SetActive(false)
    local tagID = DataModel.RoleCA.equipmentSlotList[elementIndex].tagID
    local index = PlayerData:GetFactoryData(tagID).typeID
    element.Btn_Item.Img_Type:SetSprite(UIConfig.EquipBgType[index])
    if equip == nil then
      element.Group_Equipment:SetActive(false)
    else
      local list = {}
      list.data = PlayerData:GetFactoryData(equip.id)
      list.server = equip
      element.Group_Equipment:SetActive(true)
      CommonItem:SetEquipment(element.Group_Equipment, list, false)
      element.Group_Equipment.Group_Face:SetActive(false)
      element.Group_Equipment.Img_Lock:SetActive(false)
      local equipTipLv = PlayerData:GetFactoryData("99900007").equipTipLv
      local equipTipMaxLv = PlayerData:GetFactoryData("99900007").equipTipMax
      local isShowBelow = equipTipMaxLv <= DataModel.RoleData.lv and equipTipLv > equip.lv
      element.Group_Tip:SetActive(isShowBelow)
      local equipData = DataModel:GetUrEquipData()
      local curRole = equipData[tostring(DataModel.RoleData.id)] or {}
      local curEquip = curRole[elementIndex] or {}
      element.Img_Disable:SetActive(curEquip.isUse ~= true)
    end
  end,
  Squads_Group_Detail_Group_Equip_StaticGrid_Equip_Group_Equipment_Group_Equipment_Btn_Item_Click = function(btn, str)
    if DataModel.RoleData.isHelpRole then
      return
    end
    local equipData = DataModel:GetUrEquipData()
    local curRole = equipData[tostring(DataModel.RoleData.id)] or {}
    local curEquip = curRole[tonumber(str)] or {}
    if curEquip.isUse ~= true then
      CommonTips:OpenDupesEquip(View.Group_Detail, DataModel.RoleData, tonumber(str), equipData)
      View.self:SelectPlayAnim(View.Group_Detail.Group_DupesEquip.self, "Group_DupesEquip_Show", function()
      end)
      return
    end
    local residueNum = GetResidueNum()
    local typeInt = PlayerData:GetTypeInt("enumEquipTypeList", DataModel.RoleCA.equipmentSlotList[tonumber(str)].tagID)
    local params = {
      Type = typeInt,
      RoleId = DataModel.RoleData.id,
      Index = tonumber(str),
      ResidueNum = residueNum,
      RoleCA = DataModel.RoleCA,
      IsSquad = true,
      RoleList = PlayerData.currentSquad
    }
    CommonTips.OpenGroupWeapon(params)
  end,
  Squads_Group_Detail_Group_Equip_Group_Equipment_Btn_Item_Click = function(btn, str)
    local eid = DataModel.RoleData.equips[tonumber(str)]
    local residueNum = GetResidueNum()
    local typeInt = PlayerData:GetTypeInt("enumEquipTypeList", DataModel.RoleCA.equipmentSlotList[tonumber(str)].tagID)
    local params = {
      Type = typeInt,
      RoleId = DataModel.RoleData.id,
      Index = tonumber(str),
      ResidueNum = residueNum,
      RoleCA = DataModel.RoleCA,
      IsSquad = true,
      RoleList = PlayerData.currentSquad
    }
    CommonTips.OpenGroupWeapon(params)
  end,
  Squads_Group_Detail_Group_Equip_StaticGrid_Equip_Group_Equipment_Btn_Item_Click = function(btn, str)
    if DataModel.RoleData.isHelpRole then
      return
    end
    local residueNum = GetResidueNum()
    local typeInt = PlayerData:GetTypeInt("enumEquipTypeList", DataModel.RoleCA.equipmentSlotList[tonumber(str)].tagID)
    local params = {
      Type = typeInt,
      RoleId = DataModel.RoleData.id,
      Index = tonumber(str),
      ResidueNum = residueNum,
      RoleCA = DataModel.RoleCA,
      IsSquad = true,
      RoleList = PlayerData.currentSquad
    }
    CommonTips.OpenGroupWeapon(params)
  end,
  Squads_Group_CardYard_Group_Left_ScrollGrid__SetGrid = function(element, elementIndex)
    local tagConfig = PlayerData:GetFactoryData(DataModel.skillTagList[elementIndex])
    element.Img_:SetSprite(tagConfig.icon)
    element.Txt_TagName:SetText(tagConfig.tagName)
    local _desc = string.gsub(tagConfig.detail, "\\n", "\227\128\130")
    element.Txt_TagDesc:SetText(_desc)
  end,
  Squads_Group_Detail_Btn_LevelUp_Click = function(btn, str)
    DataModel.CloseCardDes()
    UIManager:Open("UI/CharacterInfo/Group_TabLevelUp", Json.encode({
      roleId = DataModel.RoleData.id,
      ui = "squad",
      squad = DataModel.curSquad
    }))
  end,
  Squads_Group_CharacterSelect_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Squads_Group_Detail_Group_Equip_Group_Equipment_Group_Equipment_Btn_Item_Click = function(btn, str)
  end,
  Squads_Group_EquipSelected_Group_TopLeft_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Squads_Group_ProvingGround_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Squads_Group_CardYard_StaticGrid_Left_SetGrid = function(element, elementIndex)
    local row = DataModel.CardColorData[elementIndex]
    element:SetText(row.des)
  end,
  Squads_Group_Detail_Group_Card_Btn_Close_Des_Click = function(btn, str)
    View.Group_Detail.Group_Card.Btn_Close_Des.self:SetActive(false)
    DataModel.CloseCardDes()
  end,
  Squads_Group_CharacterSelect_Group_Detail_Group_Card_Btn_Close_Des_Click = function(btn, str)
    View.Group_CharacterSelect.Group_Detail.Group_Card.Btn_Close_Des.self:SetActive(false)
    DataModel.CloseCardDes()
  end,
  Squads_Group_CardDesCharacter_Btn_Close_Click = function(btn, str)
    DataModel.CloseCardDes()
  end,
  Squads_Group_CardYard_Group_CardDesCharacter_Btn_Close_Click = function(btn, str)
    DataModel.CloseCardDes()
  end,
  Squads_Group_Tab_ScrollGrid_Tab_SetGrid = function(element, elementIndex)
    SquadController:RefreshGridTab(element, tonumber(elementIndex))
  end,
  Squads_Group_Tab_ScrollGrid_Tab_Group_Item_Btn_Tab_Click = function(btn, str)
    local function callBack()
      SquadController.SetTabElement(tonumber(str), DataController)
      
      DataDetail:CloseDetail()
    end
    
    if DataModel.RoleData and DataModel.RoleData.Squads then
      SquadController:GetDefault_Send(DataModel.curSelectIndex, callBack)
    else
      callBack()
    end
  end,
  Squads_Group_Tab_ScrollGrid_Tab_Group_Item_Btn_Tab_Group_On_Btn_Change_Click = function(btn, str)
    SquadController.ModifyNameBtn(tonumber(str))
  end,
  Squads_Group_Detail_Btn_Reso_Click = function(btn, str)
    UISquadsGlobalData:SetSelectSquadIndex(DataModel:GetCurSquadIndex())
    DataModel.hasOpenThreeView = true
    if DataModel.curDetailIndex == 1 then
      DataDetail:CloseDetail()
    end
    if DataModel.curDetailIndex == 2 then
      DataDetail:CloseChooseDetail()
    end
    local data = {
      currentRoleId = DataModel.RoleData.id,
      fromView = EnumDefine.CommonFilterType.SquadView,
      current = DataModel.Current,
      IsSquad = true,
      SquadsRoleList = PlayerData.currentSquad,
      index = 3
    }
    UIManager:Open("UI/CharacterInfo/CharacterInfo", Json.encode(data))
  end,
  Squads_Group_Detail_Group_DupesEquip_Btn_Blose_Click = function(btn, str)
    View.self:SelectPlayAnim(View.Group_Detail.Group_DupesEquip.self, "Group_DupesEquip_Hide", function()
      CommonTips:CloseDupesEquip(View.Group_Detail)
    end)
  end,
  Squads_Group_Detail_Group_DupesEquip_Group_Main_Group_Equipt_Btn_Change_Click = function(btn, str)
    if DataModel.RoleData.isHelpRole then
      return
    end
    local residueNum = GetResidueNum()
    local typeInt = PlayerData:GetTypeInt("enumEquipTypeList", DataModel.RoleCA.equipmentSlotList[tonumber(str)].tagID)
    local params = {
      Type = typeInt,
      RoleId = DataModel.RoleData.id,
      Index = tonumber(str),
      ResidueNum = residueNum,
      RoleCA = DataModel.RoleCA,
      IsSquad = true,
      RoleList = PlayerData.currentSquad
    }
    CommonTips.OpenGroupWeapon(params)
  end,
  Squads_Group_Detail_Group_DupesEquip_Group_Main_Group_Slots_Group_Slots_01_Btn_Slots_Click = function(btn, str)
  end,
  Squads_Group_Detail_Group_DupesEquip_Group_Main_Group_Slots_Group_Slots_02_Btn_Slots_Click = function(btn, str)
  end,
  Squads_Group_Detail_Group_DupesEquip_Group_Main_Group_Slots_Group_Slots_03_Btn_Slots_Click = function(btn, str)
  end,
  Squads_Group_Detail_Group_DupesEquip_Group_Main_Group_Characters_Group_Character_001_Btn_Enable_001_Click = function(btn, str)
    ClickUrEquip(str)
  end,
  Squads_Group_Detail_Group_DupesEquip_Group_Main_Group_Characters_Group_Character_002_Btn_Enable_001_Click = function(btn, str)
    ClickUrEquip(str)
  end,
  Squads_Group_Detail_Group_DupesEquip_Group_Main_Group_Characters_Group_Character_003_Btn_Enable_001_Click = function(btn, str)
    ClickUrEquip(str)
  end,
  Squads_Group_Detail_Group_DupesEquip_Group_Main_Group_Characters_Group_Character_004_Btn_Enable_001_Click = function(btn, str)
    ClickUrEquip(str)
  end,
  Squads_Group_Detail_Group_DupesEquip_Group_Main_Group_Characters_Group_Character_005_Btn_Enable_001_Click = function(btn, str)
    ClickUrEquip(str)
  end
}
return ViewFunction
