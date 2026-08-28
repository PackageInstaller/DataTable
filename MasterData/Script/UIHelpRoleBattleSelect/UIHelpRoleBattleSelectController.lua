local View = require("UIHelpRoleBattleSelect/UIHelpRoleBattleSelectView")
local DataModel = require("UIHelpRoleBattleSelect/UIHelpRoleBattleSelectDataModel")
local CommonItem = require("Common/BtnItem")
local Controller = {}

function Controller:Init()
  DataModel.RoleResConfig = PlayerData:GetFactoryData(99900021)
  DataModel.maxRefreshTime = PlayerData:GetFactoryData(99900217).helpBattleCd
  DataModel.curSelectedIndex = -1
  DataModel.curHelpSelectedIndex = -1
  DataModel:RefreshRoleList()
  DataModel:SortAllRoles("Level")
  DataModel.sortType.Level = true
  DataModel.sortType.Rarity = true
  DataModel.sortType.Time = true
  View.Common_Filter.Group_TabBtn.Btn_Level.Img_bg.Img_Arrow:SetRotate(180)
  View.Common_Filter.Group_TabBtn.Btn_Rarity.Img_bg.Img_Arrow:SetRotate(180)
  View.Common_Filter.Group_TabBtn.Btn_Time.Img_bg.Img_Arrow:SetRotate(180)
  View.Common_Filter.Group_TabBtn.Btn_Level.Img_bg:SetSprite("UI/Common/left_on")
  View.Common_Filter.Group_TabBtn.Btn_Rarity.Img_bg:SetSprite("UI/Common/left_off")
  View.Common_Filter.Group_TabBtn.Btn_Rarity.Img_bg.Txt_Content:SetColor("#646464")
  View.Common_Filter.Group_TabBtn.Btn_Rarity.Img_bg.Img_Arrow:SetColor("#646464")
  View.Common_Filter.Group_TabBtn.Btn_Time.Img_bg:SetSprite("UI/Common/left_off")
  View.Common_Filter.Group_TabBtn.Btn_Time.Img_bg.Txt_Content:SetColor("#646464")
  View.Common_Filter.Group_TabBtn.Btn_Time.Img_bg.Img_Arrow:SetColor("#646464")
  View.ScrollGrid_CharacterList.grid.self:SetDataCount(#DataModel.SortRoles)
  View.ScrollGrid_CharacterList.grid.self:MoveToTop()
  View.ScrollGrid_CharacterList.grid.self:RefreshAllElement()
  View.Group_Detail:SetActive(false)
  if PlayerData.helpSquadIndex ~= nil and PlayerData.helpSquadIndex == DataModel.curSquadsIndex then
    DataModel.curHelpRoles = PlayerData.curHelpRoles or {}
    DataModel.curHelpBattlePage = PlayerData.curHelpBattlePage or 0
  else
    DataModel.curHelpRoles = {}
    if PlayerData.curHelpRoles then
      for i = 1, #PlayerData.curHelpRoles do
        local cloneData = Clone(PlayerData.curHelpRoles[i])
        cloneData.squads_index = 0
        table.insert(DataModel.curHelpRoles, cloneData)
      end
      DataModel.curHelpBattlePage = PlayerData.curHelpBattlePage or 0
    else
      DataModel.curHelpBattlePage = 0
    end
  end
  local helpBattleConfig = PlayerData:GetFactoryData(99900217)
  DataModel.helpBattleMax = helpBattleConfig.helpBattleMax
  DataModel.isLoading = false
  DataModel.isLoadAll = false
  View.ScrollGrid_HelpRoleList.grid.self:SetActive(PlayerData.helpSquadIndex ~= nil)
  View.ScrollGrid_HelpRoleList.grid.self:SetDataCount(DataModel.helpBattleMax)
  View.ScrollGrid_HelpRoleList.grid.self:MoveToTop()
  View.ScrollGrid_HelpRoleList.grid.self:RefreshAllElement()
end

function Controller:SetHelpRoleElement(element, elementIndex)
  local data = DataModel.curHelpRoles[elementIndex]
  if data == nil then
    Controller:TryGetHelpRoleData()
    return
  else
    element.Btn_Item:SetClickParam(elementIndex)
    data.mask = element.Group_InTeam
    data.selected = element.Img_Selected
    data.isHelpRole = true
    Controller:SetRoleElementByData(element, data)
    element.Group_Player.Txt_Name:SetText(data.name)
    element.Group_Player.Txt_LVNum:SetText(data.userLv)
    element.Group_Player.Txt_Uid:SetText(data.playerId)
    element.Group_InTeam:SetActive(data.squads_index > 0)
    local index_img = "Img_Index"
    for i = 1, 5 do
      element.Group_InTeam[index_img .. i]:SetActive(false)
    end
    if element.Group_InTeam[index_img .. data.squads_index] then
      element.Group_InTeam[index_img .. data.squads_index]:SetActive(true)
    end
    data.selected:SetActive(DataModel.curHelpSelectedIndex == elementIndex)
    local avatarCA = PlayerData:GetFactoryData(data.avatar)
    if avatarCA then
      element.Group_Player.Img_Head.Img_Mask.Img_Character:SetSprite(avatarCA.imagePath)
      CommonTips:SetPlayerHeadShader(element.Group_Player.Img_Head.Img_Mask.Img_spAdd, avatarCA)
    else
      element.Group_Player.Img_Head.Img_Mask.Img_Character:SetSprite("")
    end
    DataModel.curLoadData = data
    element.Group_Equip.StaticGrid_Equip.grid.self:RefreshAllElement()
    element.Group_Player.Img_Icon:SetActive(data.isFriend == 1)
  end
end

function Controller:OnSetHelpRoleEquipGrid(element, elementIndex)
  local equip = DataModel.curLoadData.equips[elementIndex]
  element.Btn_Item:SetClickParam(tonumber(elementIndex))
  element.Group_Equipment.Btn_Item:SetClickParam(tonumber(elementIndex))
  element.Btn_Item:SetActive(true)
  element.Group_Equipment.Img_Select:SetActive(false)
  if equip == nil or equip == "" or next(equip) == nil then
    element.Group_Equipment:SetActive(false)
  else
    local list = {}
    list.data = PlayerData:GetFactoryData(equip.id)
    list.server = equip
    element.Group_Equipment:SetActive(true)
    CommonItem:SetEquipment(element.Group_Equipment, list, false)
  end
end

function Controller:TryGetHelpRoleData()
  if DataModel.isLoading then
    return
  end
  DataModel.isLoading = true
  DataModel.curHelpBattlePage = DataModel.curHelpBattlePage + 1
  if DataModel.curHelpBattlePage == 1 then
    DataModel.refreshTime = DataModel.maxRefreshTime
  end
  Net:SendProto("battle.help_list", function(json)
    if DataModel.isLoadAll then
      return
    end
    local roles = json.roles
    if roles == nil or table.count(roles) <= 0 then
      DataModel.isLoadAll = true
      DataModel.isLoading = false
      View.ScrollGrid_HelpRoleList.grid.self:SetDataCount(#DataModel.curHelpRoles)
      View.ScrollGrid_HelpRoleList.grid.self:RefreshAllElement()
      return
    end
    local curDataList = {}
    for k, v in pairs(roles) do
      local keys = string.split(k, ":")
      local data = v.heros[keys[3]]
      data.playerId = keys[2]
      data.id = keys[3]
      data.squads_index = 0
      data.name = v.username
      data.userLv = v.lv
      data.avatar = v.avatar
      data.isFriend = v.is_friend
      curDataList[#curDataList + 1] = data
    end
    table.sort(curDataList, function(e1, e2)
      return e1.userLv > e2.userLv
    end)
    for i = 1, #curDataList do
      DataModel.curHelpRoles[#DataModel.curHelpRoles + 1] = curDataList[i]
      if PlayerData.curHelpRoles then
        PlayerData.curHelpRoles[#PlayerData.curHelpRoles + 1] = curDataList[i]
        PlayerData.curHelpBattlePage = DataModel.curHelpBattlePage
      end
    end
    if table.count(roles) < 3 then
      DataModel.isLoadAll = true
      View.ScrollGrid_HelpRoleList.grid.self:SetDataCount(#DataModel.curHelpRoles)
    end
    DataModel.isLoading = false
    View.ScrollGrid_HelpRoleList.grid.self:RefreshAllElement()
    View.ScrollGrid_HelpRoleList.grid.self:SetActive(true)
  end, 3, DataModel.curHelpBattlePage)
end

function Controller:SetRoleElement(element, index)
  DataModel.SortRoles[index].mask = element.Group_InTeam
  DataModel.SortRoles[index].selected = element.Img_Selected
  element.Btn_Item:SetClickParam(index)
  local data = DataModel.SortRoles[index]
  Controller:SetRoleElementByData(element, data)
  element.Group_InTeam:SetActive(DataModel.SortRoles[index].squads_index > 0)
  local index_img = "Img_Index"
  for i = 1, 5 do
    element.Group_InTeam[index_img .. i]:SetActive(false)
  end
  if element.Group_InTeam[index_img .. data.squads_index] then
    element.Group_InTeam[index_img .. data.squads_index]:SetActive(true)
  end
  local id = data.id
  local buff = PlayerData:GetCurStationStoreBuff(tostring(id), EnumDefine.HomeSkillEnum.AddTrust)
  local groupTrust = element.Group_Trust
  groupTrust:SetActive(buff ~= nil)
  if buff ~= nil then
    groupTrust.Txt_TrustNum:SetText(string.format(GetText(80601584), math.floor(buff.param * 100)))
    local curTime = TimeUtil:GetServerTimeStamp()
    local remainTime = math.max(buff.endTime - curTime, 0)
    local buffCA = PlayerData:GetFactoryData(buff.id, "HomeBuffFactory")
    groupTrust.Group_Icon.Img_TrustTime:SetFilledImgAmount(remainTime / buffCA.continueTime)
  end
  element.Img_Selected:SetActive(DataModel.curSelectedIndex == index)
  if element.Img_InSquad then
    if data.isLevelRole then
      element.Img_InSquad:SetActive(true)
    else
      element.Img_InSquad:SetActive(false)
    end
  end
end

function Controller:SetRoleElementByData(element, data)
  data.element = element
  DataModel.Break_Role = data
  local id = data.id
  local ca = PlayerData:GetFactoryData(id)
  if element.Img_Bottom then
    element.Img_Bottom:SetSprite(UIConfig.CharacterBottom[ca.qualityInt])
  end
  local server = data
  if server ~= nil and server.current_skin ~= nil then
    local portraitId = server.current_skin[1]
    local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
    element.Img_Mask.Img_Character:SetSprite(portrailData.roleListResUrl)
    if server.current_skin[2] == 1 and ca.isSpine2 == 1 then
      element.Img_Mask.Img_Character:SetSprite(portrailData.State2RoleListRes)
    end
  elseif data.skin_list then
    for k in pairs(data.skin_list) do
      server.current_skin = {
        [1] = k
      }
      local portraitId = server.current_skin[1]
      local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
      element.Img_Mask.Img_Character:SetSprite(portrailData.roleListResUrl)
      break
    end
  else
    local portraitId = ca.viewId
    local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
    element.Img_Mask.Img_Character:SetSprite(portrailData.roleListResUrl)
  end
  if data.isHelpRole then
    element.Img_Decorate:SetSprite(DataModel.RoleResConfig.helpRoleBoxPath[ca.qualityInt].path)
  else
    element.Img_Decorate:SetSprite(UIConfig.CharacterDecorate[ca.qualityInt])
  end
  element.Txt_Name:SetText(data.name)
  element.Txt_LVNum:SetText(data.lv)
  if element.Img_Rarity then
    element.Img_Rarity:SetSprite(UIConfig.TipConfig[ca.qualityInt + 1])
  end
  local awakeLv = data.awake_lv
  for i = 1, 5 do
    element.Group_Break.StaticGrid_BK.grid[i].Img_On:SetActive(i <= awakeLv)
    element.Group_Break.StaticGrid_BK.grid[i].Img_Off:SetActive(i > awakeLv)
  end
  element.Group_Awake.Img_Awake:SetSprite(UIConfig.AwakeCommon[data.resonance_lv + 1])
  local isFinalSkillUnlock = PlayerData:IsRoleFinalSkillUnlock(data.id)
  if isFinalSkillUnlock then
    element.Group_Awake.Img_Awake:SetColor("#FFE266")
  else
    element.Group_Awake.Img_Awake:SetColor("#FFFFFF")
  end
  local ca = PlayerData:GetFactoryData(data.id, "UnitFactory")
  local Group_SkillColor = element.Group_SkillColor
  local cardList = PlayerData:GetRoleCardList(ca.id)
  for i = 1, table.count(cardList) do
    local obj = "Group_SkillColor" .. i
    local cardCA = PlayerData:GetFactoryData(cardList[table.count(cardList) - i + 1].id)
    local color = cardCA.color
    Group_SkillColor[obj].Img_Color:SetSprite(UIConfig.CharacterSkillColor[color])
  end
  local Group_Locate = Group_SkillColor.Group_Locate
  Group_Locate.Img_Line:SetSprite(UIConfig.CharacterLine[ca.line])
end

function Controller:OnClickRole(index)
  local data = DataModel.SortRoles[index]
  local lastIndex = DataModel.curSelectedIndex
  if lastIndex ~= nil and 0 < lastIndex and DataModel.SortRoles[lastIndex].selected ~= nil then
    DataModel.SortRoles[lastIndex].selected:SetActive(false)
  end
  if DataModel.curHelpSelectedIndex and 0 < DataModel.curHelpSelectedIndex and DataModel.curHelpRoles[DataModel.curHelpSelectedIndex] and DataModel.curHelpRoles[DataModel.curHelpSelectedIndex].selected then
    DataModel.curHelpRoles[DataModel.curHelpSelectedIndex].selected:SetActive(false)
  end
  DataModel.curHelpSelectedIndex = -1
  DataModel.curSelectedIndex = index
  data.selected:SetActive(true)
  Controller:RefreshGroupDetail(data)
  local curRoleIndex = data.squads_index
  if 0 < curRoleIndex then
    data.squads_index = 0
    data.mask:SetActive(false)
    DataModel.curSelectedRoles[curRoleIndex] = ""
  else
    local flag = 0
    if DataModel.curSelectedHelpRole ~= nil and DataModel.curSelectedHelpRole.id == data.id then
      flag = 1
    else
      for i = 1, DataModel.maxNum do
        if DataModel.curSelectedRoles[i] ~= nil and DataModel.curSelectedRoles[i] == data.id then
          flag = 1
          break
        end
      end
      if not (0 < flag) then
        for i = 1, DataModel.maxNum do
          if DataModel.curSelectedRoles[i] == nil or DataModel.curSelectedRoles[i] == "" then
            DataModel.curSelectedRoles[i] = data.id
            data.squads_index = i
            data.mask:SetActive(true)
            local index_img = "Img_Index"
            for i = 1, 5 do
              data.mask[index_img .. i]:SetActive(false)
            end
            if data.mask[index_img .. data.squads_index] then
              data.mask[index_img .. data.squads_index]:SetActive(true)
            end
            flag = 2
            break
          end
        end
      end
    end
    if flag == 1 then
      CommonTips.OpenTips(80611652)
    end
  end
end

function Controller:OnClickHelpRole(index)
  local data = DataModel.curHelpRoles[index]
  if data == nil then
    return
  end
  if DataModel.curSelectedIndex and DataModel.curSelectedIndex > 0 then
    local selectedData = DataModel.SortRoles[DataModel.curSelectedIndex]
    selectedData.selected:SetActive(false)
    DataModel.curSelectedIndex = -1
  end
  if DataModel.curHelpSelectedIndex and 0 < DataModel.curHelpSelectedIndex and DataModel.curHelpRoles[DataModel.curHelpSelectedIndex] and DataModel.curHelpRoles[DataModel.curHelpSelectedIndex].selected then
    DataModel.curHelpRoles[DataModel.curHelpSelectedIndex].selected:SetActive(false)
  end
  data.selected:SetActive(true)
  DataModel.curHelpSelectedIndex = index
  Controller:RefreshGroupDetail(data)
  local curRoleIndex = data.squads_index or 0
  if 0 < curRoleIndex then
    data.squads_index = 0
    data.mask:SetActive(false)
    DataModel.curSelectedRoles[curRoleIndex] = ""
    DataModel.curSelectedHelpRole = nil
  elseif DataModel.curSelectedHelpRole == nil then
    local flag = 0
    for i = 1, DataModel.maxNum do
      if DataModel.curSelectedRoles[i] == data.id then
        flag = 1
      end
    end
    if flag == 0 then
      for i = 1, DataModel.maxNum do
        if DataModel.curSelectedRoles[i] == nil or DataModel.curSelectedRoles[i] == "" then
          DataModel.curSelectedRoles[i] = data.id
          data.squads_index = i
          DataModel.curSelectedHelpRole = data
          data.mask:SetActive(true)
          local index_img = "Img_Index"
          for i = 1, 5 do
            data.mask[index_img .. i]:SetActive(false)
          end
          if data.mask[index_img .. data.squads_index] then
            data.mask[index_img .. data.squads_index]:SetActive(true)
          end
          flag = 2
          break
        end
      end
    end
    if flag == 1 then
      CommonTips.OpenTips(80611652)
    end
  end
end

function Controller:RefreshGroupDetail(data)
  DataModel.RoleCA = PlayerData:GetFactoryData(data.id)
  View.Group_Detail:SetActive(true)
  View.Group_Detail.Group_Card.StaticGrid_Card.grid.self:RefreshAllElement()
end

function Controller:OnsetRoleCardGrid(element, elementIndex)
  element.Btn_Skill:SetClickParam(tostring(elementIndex))
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
end

function Controller:OnClickBtnRole()
  local data = {
    currentRoleId = DataModel.RoleCA.id,
    fromView = EnumDefine.CommonFilterType.SquadView,
    current = "MainUI",
    IsSquad = true,
    SquadsRoleList = {}
  }
  UIManager:Open("UI/CharacterInfo/CharacterInfo", Json.encode(data))
end

function Controller:OnClickSort(sortType)
  local preType = DataModel.curSortType
  if preType == sortType then
    DataModel.sortType[sortType] = not DataModel.sortType[sortType]
    View.Common_Filter.Group_TabBtn["Btn_" .. sortType].Img_bg.Img_Arrow:SetRotate(DataModel.sortType[sortType] and 180 or 0)
  else
    View.Common_Filter.Group_TabBtn["Btn_" .. preType].Img_bg:SetSprite("UI/Common/left_off")
    View.Common_Filter.Group_TabBtn["Btn_" .. preType].Img_bg.Txt_Content:SetColor("#646464")
    View.Common_Filter.Group_TabBtn["Btn_" .. preType].Img_bg.Img_Arrow:SetColor("#646464")
    View.Common_Filter.Group_TabBtn["Btn_" .. sortType].Img_bg:SetSprite("UI/Common/left_on")
    View.Common_Filter.Group_TabBtn["Btn_" .. sortType].Img_bg.Txt_Content:SetColor("#000000")
    View.Common_Filter.Group_TabBtn["Btn_" .. sortType].Img_bg.Img_Arrow:SetColor("#000000")
  end
  DataModel:SortAllRoles(sortType)
  View.ScrollGrid_CharacterList.grid.self:RefreshAllElement()
end

function Controller:OnSetHelpSquad()
  local autoBattleVF = require("UIAutoBattle/UIAutoBattleViewFunction")
  if DataModel.curSelectedHelpRole == nil then
    PlayerData.helpSquadIndex = nil
    PlayerData.helpRoleList = nil
    PlayerData.curSelectedHelpRole = nil
    PlayerData.curHelpRoles = nil
    PlayerData.curHelpBattlePage = nil
    PlayerData:SetPlayerPrefs("string", "CardAIDataHelpRole", "", true)
    autoBattleVF:SaveCloudData("CardAIDataHelpRole", "")
    return
  end
  local squad = {}
  for i = 1, #DataModel.curSelectedRoles do
    local roleId = DataModel.curSelectedRoles[i]
    if roleId == DataModel.curSelectedHelpRole.id then
      squad[#squad + 1] = GetRoleInfoByData(DataModel.curSelectedHelpRole, true)
      squad[#squad].isHelpRole = true
    else
      squad[#squad + 1] = GetPlayerRoleData(roleId)
    end
  end
  for i = #squad + 1, 5 do
    squad[i] = {}
  end
  if PlayerData.curSelectedHelpRole ~= nil then
    PlayerData:SetPlayerPrefs("string", "CardAIDataHelpRole", "", true)
    autoBattleVF = require("UIAutoBattle/UIAutoBattleViewFunction")
    autoBattleVF:SaveCloudData("CardAIDataHelpRole", "")
  end
  PlayerData.helpRoleList = squad
  PlayerData.helpSquadIndex = DataModel.curSquadsIndex
  PlayerData.curSelectedHelpRole = DataModel.curSelectedHelpRole
  PlayerData.curHelpRoles = DataModel.curHelpRoles
  PlayerData.curHelpBattlePage = DataModel.curHelpBattlePage
end

function Controller:UpDateBtnRefresh()
  if DataModel.refreshTime == nil then
    return
  end
  DataModel.refreshTime = DataModel.refreshTime - 0.02
  if DataModel.refreshTime <= 0 then
    DataModel.refreshTime = nil
    View.Btn_Refresh.Txt_Time:SetActive(false)
    View.Btn_Refresh.Img_Mask:SetActive(false)
  else
    View.Btn_Refresh.Txt_Time:SetActive(true)
    View.Btn_Refresh.Img_Mask:SetActive(true)
    View.Btn_Refresh.Txt_Time:SetText(math.ceil(DataModel.refreshTime))
    View.Btn_Refresh.Img_Mask:SetFilledImgAmount(DataModel.refreshTime / DataModel.maxRefreshTime)
  end
end

function Controller:OnClickBtnRefresh()
  if DataModel.refreshTime ~= nil then
    return
  end
  DataModel.curHelpRoles = {}
  DataModel.curHelpBattlePage = 0
  if DataModel.curSelectedHelpRole then
    DataModel.curSelectedRoles[DataModel.curSelectedHelpRole.squads_index] = ""
    DataModel.curSelectedHelpRole = nil
  end
  if PlayerData.helpRoleList ~= nil then
    PlayerData.helpSquadIndex = nil
    PlayerData.helpRoleList = nil
    PlayerData.curSelectedHelpRole = nil
    PlayerData.curHelpRoles = nil
    PlayerData.curHelpBattlePage = nil
    PlayerData:SetPlayerPrefs("string", "CardAIDataHelpRole", "", true)
    local autoBattleVF = require("UIAutoBattle/UIAutoBattleViewFunction")
    autoBattleVF:SaveCloudData("CardAIDataHelpRole", "")
  end
  View.ScrollGrid_HelpRoleList.grid.self:MoveToTop()
  DataModel.isLoading = false
  DataModel.isLoadAll = false
  Controller:TryGetHelpRoleData()
end

return Controller
