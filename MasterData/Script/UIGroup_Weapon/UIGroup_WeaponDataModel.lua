local View = require("UIGroup_Weapon/UIGroup_WeaponView")
local DataModel = {
  InfoInitPos = {
    isRecord = true,
    x = 0,
    y = 0,
    scale = 1,
    offsetX = 0,
    offsetY = 1
  },
  IsSquad = false,
  SquadRoleList = {},
  SquadRoleListData = {},
  RoleSeverEquip = {},
  CenterSquadsIndex = nil,
  RoleCA = {},
  RoleId = nil,
  RoleSeverData = {},
  RoleEquipIndex = nil,
  RoleEquipType = nil,
  RoleList = {},
  RoleListIndex = 1,
  SortType = {},
  GroupLeftPositionX = 0,
  GroupRightPositionX = 0,
  GroupCenterPositionX = 0,
  LeftTopTagName = {},
  OldEquipData = {},
  LeftTopTagIndex = nil,
  EquipIndex = nil,
  AllEquip = {},
  RawNowList = {},
  FilterCampList = {},
  FilterGroup = {
    [0] = true
  },
  FilterRarity = {
    [0] = true
  },
  FilterState = {
    [0] = true
  },
  live2D = false
}
DataModel.LeftTopTag = {
  [1] = 1,
  [2] = 2,
  [3] = 3
}
DataModel.LeftTopTagName = {
  [1] = "\230\173\166\229\153\168",
  [2] = "\230\138\164\231\148\178",
  [3] = "\233\165\176\229\147\129"
}
DataModel.EquipTypeIcon = {
  [1] = "UI\\CharacterInfo\\weapon\\Weapon",
  [2] = "UI\\CharacterInfo\\weapon\\Armor",
  [3] = "UI\\CharacterInfo\\weapon\\Ornament"
}
DataModel.PropertyBase = {
  [1] = {
    growthType = "gAtk_SN",
    type = "attack_SN",
    icon = "UI\\CharacterInfo\\Characterinfo_icon_att_attack",
    name = GetText(80607458)
  },
  [2] = {
    growthType = "gHp_SN",
    type = "healthPoint_SN",
    icon = "UI\\CharacterInfo\\Characterinfo_icon_att_health",
    name = GetText(80607459)
  },
  [3] = {
    growthType = "gDef_SN",
    type = "defence_SN",
    icon = "UI\\CharacterInfo\\Characterinfo_icon_att_defense",
    name = GetText(80607460)
  }
}
DataModel.EntryMaxNum = {
  [1] = "Weapon",
  [2] = "Armor",
  [3] = "Ornaments"
}

local function Clear()
  if DataModel.AffixList_1 then
    for k, v in pairs(DataModel.AffixList_1) do
      Object.Destroy(v)
    end
  end
end

function DataModel:Clear_Center()
  if DataModel.AffixList_2 then
    for k, v in pairs(DataModel.AffixList_2) do
      Object.Destroy(v)
    end
  end
end

function DataModel:Clear_Detail()
  if DataModel.AffixList_Detail then
    for k, v in pairs(DataModel.AffixList_Detail) do
      Object.Destroy(v)
    end
  end
end

function DataModel:RefreshRole(roleId)
  local params = {
    RoleId = roleId,
    Index = tonumber(DataModel.RoleEquipIndex),
    RoleCA = PlayerData:GetFactoryData(roleId),
    IsSquad = false,
    RoleList = DataModel.RoleList,
    RoleListIndex = DataModel.RoleListIndex,
    sortType = DataModel.SortType
  }
  DataModel:InitDta(params)
end

function DataModel:RefreshSquadsRole(roleId)
  local params = {
    RoleId = roleId,
    Index = tonumber(DataModel.RoleEquipIndex),
    RoleCA = PlayerData:GetFactoryData(roleId),
    IsSquad = true,
    RoleList = DataModel.SquadRoleList
  }
  DataModel:InitDta(params)
end

function DataModel:InitDta(param)
  DataModel.LeftTopTagName = {}
  DataModel.RoleCA = param.RoleCA
  DataModel.RoleId = tostring(param.RoleId)
  DataModel.RoleSeverData = PlayerData:GetRoleById(DataModel.RoleId)
  DataModel.RoleEquipIndex = param.Index or 1
  DataModel.IsSquad = param.IsSquad
  DataModel.SquadRoleList = param.RoleList
  DataModel.RoleList = param.RoleList
  DataModel.RoleListIndex = param.RoleListIndex
  DataModel.SortType = param.sortType
  DataModel.IsCanDrag = false
  DataModel.GroupLeftPositionX = View.Group_Left.self.transform.localPosition.x
  DataModel.GroupRightPositionX = View.Group_Right.self.transform.localPosition.x
  DataModel.GroupCenterPositionX = View.Group_Center.self.transform.localPosition.x
  if param.RoleList and table.count(param.RoleList) > 0 and DataModel.IsSquad == false then
    DataModel.IsCanDrag = true
  end
  local EquipTypeList = PlayerData:GetFactoryData(99900027).EquipTypeList
  for k, v in pairs(EquipTypeList) do
    local ca = PlayerData:GetFactoryData(v.id)
    table.insert(DataModel.LeftTopTagName, ca.Name)
  end
  DataModel.OldEquipData = {}
  DataModel.LeftTopTagIndex = nil
  DataModel.EquipIndex = nil
  DataModel:SetRoleEquip()
end

function DataModel:SetRoleEquip()
  DataModel.RoleSeverEquip = {}
  for k, v in pairs(DataModel.RoleSeverData.equips) do
    local row = {}
    row.eid = v
    local equip = PlayerData:GetEquipByEid(v)
    if equip then
      local tagID = DataModel.RoleCA.equipmentSlotList[k].tagID
      row.index = PlayerData:GetFactoryData(tagID).typeID
      local list = {}
      list.data = PlayerData:GetFactoryData(equip.id)
      list.server = equip
      row.list = list
    end
    table.insert(DataModel.RoleSeverEquip, row)
  end
end

function DataModel:InitFilter()
  DataModel.FilterCampList = {}
  local filterCampMap = {}
  local filterConfig = PlayerData:GetFactoryData(99900017) or {}
  local enumList = filterConfig.bookEquipmentEnumList or {}
  for i, v in ipairs(enumList) do
    local ca = PlayerData:GetFactoryData(v.id)
    if ca then
      local key = tostring(ca.sideName or ca.id)
      local data = filterCampMap[key]
      if data == nil then
        data = {
          id = ca.id,
          ids = {},
          name = ca.sideName
        }
        filterCampMap[key] = data
        table.insert(DataModel.FilterCampList, data)
      end
      data.ids[tostring(ca.id)] = true
    end
  end
  for _, data in ipairs(DataModel.FilterCampList) do
    if data.name == nil or data.name == "" then
      local ca = PlayerData:GetFactoryData(data.id)
      data.name = ca and ca.sideName or tostring(data.id)
    end
  end
  DataModel.FilterGroup = {
    [0] = true
  }
  for i = 1, #DataModel.FilterCampList do
    DataModel.FilterGroup[i] = false
  end
  DataModel.FilterRarity = {
    [0] = true
  }
  for i = 1, 5 do
    DataModel.FilterRarity[i] = false
  end
  DataModel.FilterState = {
    [0] = true
  }
  for i = 1, 2 do
    DataModel.FilterState[i] = false
  end
end

local function IsMeetGroup(row)
  if DataModel.FilterGroup[0] then
    return true
  end
  for i, isSelect in ipairs(DataModel.FilterGroup) do
    local campData = DataModel.FilterCampList[i]
    if isSelect and campData and campData.ids and campData.ids[tostring(row.equipCA.campTagId)] then
      return true
    end
  end
  return false
end

local function IsMeetRarity(row)
  if DataModel.FilterRarity[0] then
    return true
  end
  return DataModel.FilterRarity[(row.equipCA.qualityInt or 0) + 1] == true
end

local function IsMeetState(row)
  if DataModel.FilterState[0] then
    return true
  end
  local isEquipped = row.server.hid ~= nil and row.server.hid ~= ""
  return DataModel.FilterState[1] and isEquipped or DataModel.FilterState[2] and not isEquipped
end

function DataModel:ApplyFilter()
  DataModel.NowList = {}
  for _, row in ipairs(DataModel.RawNowList or {}) do
    if IsMeetGroup(row) and IsMeetRarity(row) and IsMeetState(row) then
      table.insert(DataModel.NowList, row)
    end
  end
end

function DataModel:SortNowList()
  table.sort(DataModel.NowList, function(a, b)
    if a.index == b.index then
      if a.equipCA.qualityInt == b.equipCA.qualityInt then
        if a.server.lv == b.server.lv then
          if DataModel.SortDown == false then
            return a.equipCA.id > b.equipCA.id
          end
          return a.equipCA.id < b.equipCA.id
        end
        if DataModel.SortDown == false then
          return a.server.lv < b.server.lv
        end
        return a.server.lv > b.server.lv
      end
      if DataModel.SortDown == false then
        return a.equipCA.qualityInt < b.equipCA.qualityInt
      end
      return a.equipCA.qualityInt > b.equipCA.qualityInt
    end
    return a.index < b.index
  end)
end

function DataModel:RefreshFilterList()
  DataModel:Clear_Center()
  DataModel.ShowNowList = {}
  DataModel.OldEquipData = {}
  DataModel.EquipIndex = nil
  DataModel:ApplyFilter()
  DataModel:SortNowList()
  View.Group_Left.ScrollGrid_Item.grid.self:SetDataCount(table.count(DataModel.NowList))
  View.Group_Left.ScrollGrid_Item.grid.self:RefreshAllElement()
  View.Group_Left.ScrollGrid_Item.grid.self:MoveToTop()
  DataModel:ChooseEquip(1)
end

local baseDesHight = 24

local function SetDownAffix(obj, row, index)
  local v1 = obj.transform:Find("Txt_Entry_1")
  local v2 = v1.transform:GetComponent(typeof(CS.Seven.UITxt))
  v2:SetText(row.descriptionShow)
  obj.transform:Find("Img_"):GetComponent(typeof(CS.Seven.UIImg)):SetColor(UIConfig.EntryColor[row.rarityColor])
  local hight_des = obj.transform:Find("Txt_Entry_1").transform:GetComponent(typeof(CS.Seven.UITxt)):GetHeight()
  local Hight = 0
  if hight_des > baseDesHight then
    Hight = hight_des - baseDesHight
  end
  return Hight
end

local function SetDownAllAffix(Content, AffixList, index)
  local lastY = 0
  local img_desc_y = 70
  local top_des_height = img_desc_y
  local lastY_1 = -60
  local lastY_1_Bg = 0
  local count = 1
  local baseViewSpace = 668
  local space = 0
  Content.self:SetLocalPositionY(0)
  local Parent = Content.transform
  local Group_Entry = "UI/CharacterInfo/weapon/Group_Entry_Weapon"
  space = top_des_height
  DataModel["AffixList_" .. index] = {}
  local random_affix = AffixList
  if 0 < table.count(random_affix) then
    for i = 0, table.count(random_affix) - 1 do
      local talentCA = {}
      talentCA = PlayerData:GetFactoryData(random_affix[tostring(i)].id)
      if random_affix[tostring(i)].value > -1 then
        talentCA.descriptionShow = string.format(talentCA.description, PlayerData:GetPreciseDecimalFloor(tonumber(random_affix[tostring(i)].value * talentCA.CommonNum), talentCA.floatNum))
      else
        talentCA.descriptionShow = talentCA.description
      end
      local obj = View.self:GetRes(Group_Entry, Parent.transform)
      local name = obj.name
      local hight = obj.transform.sizeDelta.y
      local lastPosY = obj.transform.localPosition.y
      local lastPosX = obj.transform.localPosition.x
      local offest = 0
      hight = 47
      if count ~= 1 then
        lastY = lastY - hight + offest - lastY_1_Bg
      else
        lastY = lastY_1
      end
      obj.name = name .. "_" .. count
      obj.transform.localPosition = Vector3(lastPosX, lastY, 0)
      obj:SetActive(true)
      table.insert(DataModel["AffixList_" .. index], obj)
      local hight_des = SetDownAffix(obj, talentCA, count)
      lastY_1_Bg = hight_des
      space = space + hight_des + hight
      count = count + 1
      if baseViewSpace < space then
        View.Group_Right.ScrollView_Content:SetContentHeight(space)
      end
    end
  end
end

function DataModel:RefreshChooseRoleEquip(now_equip)
  DataModel.AllEquip = {}
  local list = PlayerData:GetEquips()
  if table.count(list) > 0 then
    for k, v in pairs(list) do
      local equipCA = PlayerData:GetFactoryData(v.id)
      local eid = k
      local tagCA = PlayerData:GetFactoryData(equipCA.equipTagId)
      if v.hid == DataModel.RoleId then
        v.hid = ""
        for c, d in pairs(now_equip) do
          if d == k then
            v.hid = DataModel.RoleId
          end
        end
      end
      local row = {}
      row.eid = eid
      row.equipCA = equipCA
      row.tagCA = tagCA
      row.server = v
      local typeInt = PlayerData:GetTypeInt("enumEquipTypeList", equipCA.equipTagId)
      if DataModel.AllEquip[typeInt] then
        table.insert(DataModel.AllEquip[typeInt], row)
      else
        DataModel.AllEquip[typeInt] = {}
        DataModel.AllEquip[typeInt][1] = row
      end
    end
  end
end

function DataModel:RefreshAllRoleData()
  DataModel.AllEquip = {}
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
      if DataModel.AllEquip[typeInt] then
        table.insert(DataModel.AllEquip[typeInt], row)
      else
        DataModel.AllEquip[typeInt] = {}
        DataModel.AllEquip[typeInt][1] = row
      end
    end
  end
end

function DataModel.NextRole(isNext)
  local index = DataModel.RoleListIndex
  local count = table.count(DataModel.RoleList)
  index = index + (isNext and 1 or -1)
  if count < index then
    index = 1
  elseif index == 0 then
    index = count
  end
  DataModel.RoleListIndex = index
end

function DataModel.GetPortraitPos(isSpine2)
  local portrailData = PlayerData:GetFactoryData(DataModel.RoleSeverData.current_skin[1], "UnitViewFactory")
  local pos = DataModel.InfoInitPos
  if isSpine2 then
    pos = Vector3(portrailData.offsetX2, portrailData.offsetY2, 0)
  end
  View.Group_Middle.transform.localPosition = pos
  return View.Group_Middle.transform.localPosition.x
end

function DataModel.GetSpinePortraitPos()
  View.Group_Middle.transform.localPosition = Vector3(0, 0, 0)
  return View.Group_Middle.transform.localPosition.x
end

function DataModel:RefreshCenterNoEquipRoleView()
  local propertyList = PlayerData:GetRoleEquipProperty()
  local Group_Center = View.Group_Center
  Group_Center.Img_Hp:SetSprite(propertyList.healthPoint_SN.icon)
  Group_Center.Img_Hp.Txt_Hp:SetText(propertyList.healthPoint_SN.num)
  Group_Center.Img_Atk:SetSprite(propertyList.attack_SN.icon)
  Group_Center.Img_Atk.Txt_Atk:SetText(propertyList.attack_SN.num)
  Group_Center.Img_Def:SetSprite(propertyList.defence_SN.icon)
  Group_Center.Img_Def.Txt_Def:SetText(propertyList.defence_SN.num)
  Group_Center.Txt_Name:SetText(DataModel.RoleCA.name)
  Group_Center.Txt_EnglishName:SetText("")
  Group_Center.Btn_Compare.Img_Close:SetActive(false)
  Group_Center.Btn_Compare.Img_Open:SetActive(false)
  Group_Center.Btn_Compare.Img_Using:SetActive(false)
end

function DataModel:RefreshCenterRoleView()
  local propertyList = {}
  local count = 0
  for k, v in pairs(DataModel.RoleSeverData.equips) do
    if v ~= "" then
      count = count + 1
      local equip = PlayerData:GetEquipById(v)
      local equipCA = PlayerData:GetFactoryData(equip.id)
      local list = {}
      list = PlayerData:GetRoleEquipProperty(equipCA, equip.lv)
      local pro, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp = PlayerData:GetBreakMainAttr(equipCA, equip.lv, 0, equip.bk_lv or 0)
      for c, d in pairs(list) do
        if propertyList[c] == nil then
          local row = {}
          row.type = d.type
          row.index = d.index
          if c == pro.type then
            row.num = curNum
          else
            row.num = d.num
          end
          row.icon = d.icon
          propertyList[c] = row
        else
          local num = d.num
          if c == pro.type then
            num = curNum
          end
          propertyList[c].num = propertyList[c].num + num
        end
      end
    end
  end
  if count == 0 then
    propertyList = PlayerData:GetRoleEquipProperty()
  end
  local Group_Center = View.Group_Center
  Group_Center.Img_Hp:SetSprite(propertyList.healthPoint_SN.icon)
  Group_Center.Img_Hp.Txt_Hp:SetText(propertyList.healthPoint_SN.num)
  Group_Center.Img_Atk:SetSprite(propertyList.attack_SN.icon)
  Group_Center.Img_Atk.Txt_Atk:SetText(propertyList.attack_SN.num)
  Group_Center.Img_Def:SetSprite(propertyList.defence_SN.icon)
  Group_Center.Img_Def.Txt_Def:SetText(propertyList.defence_SN.num)
  Group_Center.Txt_Name:SetText(DataModel.RoleCA.name)
  Group_Center.Txt_EnglishName:SetText("")
  Group_Center.Btn_Compare.Img_Close:SetActive(false)
  Group_Center.Btn_Compare.Img_Open:SetActive(false)
  Group_Center.Btn_Compare.Img_Using:SetActive(false)
  if DataModel.NowChooseEquip.server.hid == DataModel.RoleId then
    Group_Center.Btn_Compare.Img_Using:SetActive(true)
  else
    local now_equip = DataModel.RoleSeverData.equips[DataModel.LeftTopTagIndex]
    if now_equip ~= "" then
      if Group_Center.Group_Compare.self.IsActive == false then
        Group_Center.Btn_Compare.Img_Close:SetActive(true)
      else
        Group_Center.Btn_Compare.Img_Open:SetActive(true)
      end
    end
  end
end

function DataModel:RefreshRightDownContent(Group, index)
  local pro, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp = PlayerData:GetBreakMainAttr(DataModel.NowChooseEquip.equipCA, DataModel.NowChooseEquip.server.lv, 0, DataModel.NowChooseEquip.server.bk_lv)
  local max = PlayerData:GetFactoryData(99900027)[DataModel.EntryMaxNum[DataModel.LeftTopTagIndex]] + math.floor(extraSkill)
  if index == 1 then
    local ScrollView_Content = Group.ScrollView_Content
    ScrollView_Content.Viewport.Content.Txt_EntryNumber:SetText(string.format(GetText(80600501), table.count(DataModel.NowChooseEquip.server.random_affix), max))
    SetDownAllAffix(ScrollView_Content.Viewport.Content, DataModel.NowChooseEquip.server.random_affix, 1)
  else
    local eid = PlayerData:GetRoleById(DataModel.RoleId).equips[DataModel.RoleEquipIndex]
    local now_equip = PlayerData:GetEquipById(eid)
    Group.ScrollView_Content.Viewport.Content.Txt_EntryNumber:SetText(string.format(GetText(80600501), table.count(now_equip.random_affix), max))
    SetDownAllAffix(Group.ScrollView_Content.Viewport.Content, now_equip.random_affix, index)
  end
end

function DataModel:ChooseLeftTop(index, isRefresh)
  if index == DataModel.LeftTopTagIndex and isRefresh == nil then
    return
  end
  DataModel:Clear_Center()
  DataModel.RawNowList = {}
  DataModel.NowList = {}
  DataModel.ShowNowList = {}
  DataModel.RoleEquipIndex = index
  DataModel.OldEquipData = {}
  local tagID = DataModel.RoleCA.equipmentSlotList[tonumber(index)].tagID
  local typeInt = PlayerData:GetFactoryData(tagID).typeID
  DataModel.RoleEquipType = typeInt
  local tagType = DataModel.LeftTopTag[index]
  if type(tagType) == "table" then
    for k, v in pairs(tagType) do
      if DataModel.AllEquip[v] then
        for c, d in pairs(DataModel.AllEquip[v]) do
          local row = d
          if v == DataModel.RoleEquipType then
            row.index = 1
            if row.server.hid ~= "" and row.server.hid == DataModel.RoleId then
              row.index = 0
            end
          else
            row.index = 2
          end
          table.insert(DataModel.RawNowList, row)
        end
      end
    end
  elseif DataModel.AllEquip[tagType] then
    for c, d in pairs(DataModel.AllEquip[tagType]) do
      local row = d
      if tagType == DataModel.RoleEquipType then
        row.index = 1
        if row.server.hid ~= "" and row.server.hid == DataModel.RoleId then
          row.index = 0
        end
      else
        row.index = 2
      end
      table.insert(DataModel.RawNowList, row)
    end
  end
  DataModel.LeftTopTagIndex = index
  DataModel.MySelfEquip = {}
  DataModel.MySelfEquip.eid = PlayerData:GetRoleById(DataModel.RoleId).equips[DataModel.RoleEquipIndex]
  DataModel.MySelfEquip.equipCA = PlayerData:GetEquipById(DataModel.MySelfEquip.eid) ~= nil and PlayerData:GetFactoryData(PlayerData:GetEquipById(DataModel.MySelfEquip.eid).id) or {}
  DataModel.MySelfEquip.server = PlayerData:GetEquipById(DataModel.MySelfEquip.eid)
  DataModel.MySelfEquip.old_locked = DataModel.MySelfEquip.server and DataModel.MySelfEquip.server.is_locked or 0
  DataModel.SendLockList = {}
  DataModel.SortDown = true
  DataModel:ApplyFilter()
  DataModel:SortNowList()
  DataModel.EquipIndex = nil
  if View.Group_Center.Group_Compare.self.IsActive == true then
    DataModel:OpenEquipCompare(true)
  end
  View.Group_Left.Btn_Sort.Img_Down:SetActive(true)
  View.Group_Left.Btn_Sort.Img_Up:SetActive(false)
  View.Group_Left.StaticGrid_Item.self:RefreshAllElement()
  View.Group_Left.ScrollGrid_Item.grid.self:SetDataCount(table.count(DataModel.NowList))
  View.Group_Left.ScrollGrid_Item.grid.self:RefreshAllElement()
  View.Group_Left.ScrollGrid_Item.grid.self:MoveToTop()
  DataModel:ChooseEquip(1)
end

function DataModel.RefreshRightContent(Group, index)
  local List = {}
  if index == 1 then
    List = DataModel.NowChooseEquip
    Clear()
    if View.Group_Center.Group_Compare.self.IsActive == true and DataModel.NowChooseEquip.server.hid == DataModel.RoleId then
      local Group_Right = View.Group_Right
      Group_Right.self:SetActive(false)
      return
    end
  else
    List = DataModel.MySelfEquip
  end
  DataModel:RefreshCenterRoleView()
  local Group_Right = Group
  Group_Right.self:SetActive(true)
  Group_Right.Img_Quailty:SetSprite(UIConfig.WeaponQuality[List.equipCA.qualityInt + 1])
  Group_Right.Img_Quailty:SetNativeSize()
  Group_Right.Group_NameLevel.Txt_EquipmentName:SetText(List.equipCA.name)
  Group_Right.Group_NameLevel.Txt_EquipmentLevel:SetText(string.format(GetText(80600474), List.server.lv))
  if List.server.hid == "" then
    Group_Right.Txt_EquipmentCharacter:SetActive(false)
  else
    Group_Right.Txt_EquipmentCharacter:SetActive(true)
    local name = PlayerData:GetFactoryData(List.server.hid).name
    Group_Right.Txt_EquipmentCharacter:SetText(string.format(GetText(80600429), name))
  end
  Group_Right.Btn_Lock.Img_Lock:SetActive(false)
  Group_Right.Btn_Lock.Img_Unlock:SetActive(false)
  if DataModel.SendLockList[List.eid] == nil then
    local row = {}
    row.is_locked = List.server.is_locked
    row.isChange = 0
    row.old_locked = List.server.is_locked
    DataModel.SendLockList[List.eid] = row
  end
  if DataModel.SendLockList[List.eid].is_locked == 1 then
    Group_Right.Btn_Lock.Img_Lock:SetActive(true)
  else
    Group_Right.Btn_Lock.Img_Unlock:SetActive(true)
  end
  Group_Right.Img_Property.self:SetActive(false)
  Group_Right.Img_Property.self:SetActive(false)
  local pro, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp = PlayerData:GetBreakMainAttr(List.equipCA, List.server.lv, 0, List.server.bk_lv or 0)
  Group_Right.Img_Property:SetSprite(pro.icon)
  Group_Right.Img_Property.Txt_Atk:SetText(pro.name .. " <color='#FFB800'>+ " .. PlayerData:GetPreciseDecimalFloor(curNum, 0) .. "</color>")
  Group_Right.Img_Property.self:SetActive(true)
  Group_Right.Group_BreakLv:SetActive(true)
  Group_Right.Group_BreakLv.Txt_EquipmentCharacter:SetText(string.format(GetText(80612235), List.server.bk_lv or 0))
  if index == 1 then
    Group_Right.Btn_Use:SetActive(false)
    Group_Right.Btn_Removing:SetActive(false)
    local now_equip = DataModel.RoleSeverData.equips[DataModel.LeftTopTagIndex]
    DataModel.SendRoleID = nil
    DataModel.SendRoleIsSelf = false
    if List.server.hid == DataModel.RoleId then
      DataModel.SendRoleID = DataModel.RoleId
      DataModel.SendRoleIsSelf = true
      if now_equip == "" or now_equip == nil then
        Group_Right.Btn_Use:SetActive(true)
      else
        Group_Right.Btn_Removing:SetActive(true)
      end
    else
      if List.server.hid == "" then
        DataModel.SendRoleIsSelf = true
      else
        DataModel.SendRoleIsSelf = false
      end
      DataModel.SendRoleID = List.server.hid
      Group_Right.Btn_Use:SetActive(true)
    end
  end
  DataModel:RefreshRightDownContent(Group, index)
  if DataModel.isPresets == true then
    View.Group_Right.Btn_Use:SetActive(false)
    View.Group_Right.Btn_Removing:SetActive(false)
    View.Group_Right.Btn_Strengthen.self:SetActive(false)
  else
    View.Group_Right.Btn_Strengthen.self:SetActive(true)
  end
end

function DataModel:OpenEquipCompare(state, callback)
  local Group_Center = View.Group_Center
  if Group_Center.Btn_Compare.Img_Using.self.IsActive == true then
    return
  end
  if DataModel.MySelfEquip.eid == "" and state == nil then
    return
  end
  Group_Center.Btn_Compare.Img_Open:SetActive(false)
  Group_Center.Btn_Compare.Img_Close:SetActive(false)
  if Group_Center.Group_Compare.self.IsActive == false then
    Group_Center.Btn_Compare.Img_Open:SetActive(true)
    DataModel:Clear_Center()
    Group_Center.Group_Compare.self:SetActive(true)
    DataModel.RefreshRightContent(View.Group_Center.Group_Compare, 2)
    View.self:PlayAnim("In_Compare")
  else
    local callback = function()
      View.self:PlayAnim("Out_Compare", function()
        if DataModel.MySelfEquip.eid ~= "" then
          Group_Center.Btn_Compare.Img_Close:SetActive(true)
        end
        Group_Center.Group_Compare.self:SetActive(false)
        if View.Group_Right.self.IsActive == false then
          local index = DataModel.EquipIndex
          DataModel.EquipIndex = nil
          DataModel:ChooseEquip(index)
        end
        if callback then
          callback()
        end
      end)
    end
    DataModel:SendMyselfEquipLockData(callback)
  end
end

function DataModel:ChooseEquip(index)
  if View.Group_Left.self.IsActive == false then
    return
  end
  if index == DataModel.EquipIndex then
    return
  end
  DataModel.NowChooseEquip = {}
  local Group_Right = View.Group_Right
  if index and DataModel.ShowNowList[index] then
    if DataModel.EquipIndex and View.Group_Left.ScrollGrid_Item.grid.self:GetElementByIndex(DataModel.EquipIndex - 1) then
      View.Group_Left.ScrollGrid_Item.grid.self:GetElementByIndex(DataModel.EquipIndex - 1).Group_Equipment.Img_Select:SetActive(false)
    end
    DataModel.EquipIndex = index
    DataModel.NowChooseEquip = DataModel.NowList[index]
    local element = View.Group_Left.ScrollGrid_Item.grid.self:GetElementByIndex(index - 1)
    if element then
      element.Group_Equipment.Img_Select:SetActive(true)
    end
    DataModel.RefreshRightContent(View.Group_Right, 1)
  else
    Group_Right.self:SetActive(false)
    DataModel:RefreshCenterNoEquipRoleView()
    return
  end
end

function DataModel:ChoosePresetEquip(index)
  DataModel.NowChooseEquip = {}
  if index == DataModel.EquipIndex then
    return
  end
  if index and DataModel.NowPresetList[index] then
    DataModel.EquipIndex = index
    DataModel.NowChooseEquip = DataModel.NowPresetList[index]
    DataModel.RefreshRightContent(View.Group_Right, 1)
  else
    local Group_Right = View.Group_Right
    Group_Right.self:SetActive(false)
    return
  end
end

function DataModel:SendEquipLockData(callback)
  local isChange = false
  local str_lock = ""
  local str_unlock = ""
  local changeList = {}
  if table.count(DataModel.SendLockList) > 0 then
    for k, v in pairs(DataModel.SendLockList) do
      if v.isChange == 1 then
        if v.is_locked == 1 then
          str_lock = str_lock .. k .. ";"
        else
          str_unlock = str_unlock .. k .. ";"
        end
        isChange = true
        table.insert(changeList, {
          eid = k,
          is_locked = v.is_locked
        })
      end
    end
    str_lock = string.sub(str_lock, 1, string.len(str_lock) - 1)
    str_unlock = string.sub(str_unlock, 1, string.len(str_unlock) - 1)
  else
    isChange = false
  end
  if isChange == false then
    if callback then
      callback()
    end
    return
  end
  if isChange == true then
    Net:SendProto("equip.lock", function(json)
      print_r(json)
      for k, v in pairs(changeList) do
        PlayerData:GetEquipById(v.eid).is_locked = v.is_locked
      end
      if callback then
        callback()
      end
    end, str_lock, str_unlock)
  end
end

function DataModel:SendMyselfEquipLockData(callback)
  local isChange = false
  local str_lock = ""
  local str_unlock = ""
  local changeList = {}
  if DataModel.MySelfEquip.isChange and DataModel.MySelfEquip.isChange == 1 then
    if DataModel.MySelfEquip.server.is_locked == 1 then
      str_lock = str_lock .. DataModel.MySelfEquip.eid .. ";"
    else
      str_unlock = str_unlock .. DataModel.MySelfEquip.eid .. ";"
    end
    isChange = true
    table.insert(changeList, {
      eid = DataModel.MySelfEquip.eid,
      is_locked = DataModel.MySelfEquip.server.is_locked
    })
  end
  str_lock = string.sub(str_lock, 1, string.len(str_lock) - 1)
  str_unlock = string.sub(str_unlock, 1, string.len(str_unlock) - 1)
  if isChange == false then
    callback()
    return
  end
  if isChange == true then
    Net:SendProto("equip.lock", function(json)
      print_r(json)
      for k, v in pairs(changeList) do
        PlayerData:GetEquipById(v.eid).is_locked = v.is_locked
      end
      DataModel.MySelfEquip.server = PlayerData:GetEquipById(DataModel.MySelfEquip.eid)
      DataModel.MySelfEquip.isChange = 0
      callback()
    end, str_lock, str_unlock)
  end
end

function DataModel:SortButton()
  DataModel.SortDown = not DataModel.SortDown
  if table.count(DataModel.NowList) == 0 then
    return
  end
  if DataModel.SortDown == true then
    View.Group_Left.Btn_Sort.Img_Down:SetActive(true)
    View.Group_Left.Btn_Sort.Img_Up:SetActive(false)
    table.sort(DataModel.NowList, function(a, b)
      if a.index == b.index then
        if a.equipCA.qualityInt == b.equipCA.qualityInt then
          if a.server.lv == b.server.lv then
            return a.equipCA.id < b.equipCA.id
          end
          return a.server.lv > b.server.lv
        end
        return a.equipCA.qualityInt > b.equipCA.qualityInt
      end
      return a.index < b.index
    end)
  else
    View.Group_Left.Btn_Sort.Img_Down:SetActive(false)
    View.Group_Left.Btn_Sort.Img_Up:SetActive(true)
    table.sort(DataModel.NowList, function(a, b)
      if a.index == b.index then
        if a.equipCA.qualityInt == b.equipCA.qualityInt then
          if a.server.lv == b.server.lv then
            return a.equipCA.id > b.equipCA.id
          end
          return a.server.lv < b.server.lv
        end
        return a.equipCA.qualityInt < b.equipCA.qualityInt
      end
      return a.index > b.index
    end)
  end
  DataModel.EquipIndex = nil
  View.Group_Left.ScrollGrid_Item.grid.self:SetDataCount(table.count(DataModel.NowList))
  View.Group_Left.ScrollGrid_Item.grid.self:RefreshAllElement()
  View.Group_Left.ScrollGrid_Item.grid.self:MoveToTop()
  DataModel:ChooseEquip(1)
end

function DataModel:OpenPresets(index)
  DataModel.PresetList = {}
  DataModel.isPresets = true
  View.Group_Left.self:SetActive(false)
  View.Group_Left_Presets.self:SetActive(true)
  View.Group_Detail.self:SetActive(true)
  DataModel:ClickDetail()
  View.Group_Center.Btn_Detail.self:SetActive(false)
  View.Group_Center.Btn_Presets.self:SetActive(false)
  View.Group_Center.Btn_Compare.self:SetActive(false)
  View.Group_Right.Btn_Use:SetActive(false)
  View.Group_Right.Btn_Removing:SetActive(false)
  View.Group_Right.Btn_Strengthen.self:SetActive(false)
  DataModel.SendLockList = {}
  DataModel.PresetIndex = index or nil
  DataModel.PresetListElementData = {}
  table.insert(DataModel.PresetListElementData, DataModel.RoleSeverData.equips)
  for k, v in pairs(DataModel.RoleSeverData.pre_equips) do
    local row = {}
    for c, d in pairs(v) do
      local t_v = d
      if d ~= "" and PlayerData:GetEquipById(d) == nil then
        t_v = ""
      end
      table.insert(row, t_v)
    end
    table.insert(DataModel.PresetListElementData, row)
  end
  View.Group_Left_Presets.ScrollGrid_Presets.grid.self:SetDataCount(table.count(DataModel.PresetListElementData))
  View.Group_Left_Presets.ScrollGrid_Presets.grid.self:RefreshAllElement()
  View.Group_Left_Presets.ScrollGrid_Presets.grid.self:MoveToTop()
  local Group_Right = View.Group_Right
  Group_Right.self:SetActive(false)
  DataModel:ChoosePresetsGroup(DataModel.PresetIndex or 1)
  View.self:PlayAnim("In_Presets")
end

function DataModel:SetEquipElement(element, elementIndex, index)
  local eid = DataModel.PresetListElementData[elementIndex][index]
  local Group_Equipment = element["Group_Equipment_" .. index]
  local Group_Info = Group_Equipment.Group_Info
  Group_Equipment.Img_Defect:SetActive(false)
  Group_Equipment.Img_NoType:SetActive(false)
  Group_Info:SetActive(false)
  local typeInt = PlayerData:GetTypeInt("enumEquipTypeList", DataModel.RoleCA.equipmentSlotList[tonumber(index)].tagID)
  if eid ~= "" and PlayerData:GetEquipById(eid) then
    local equipSever = PlayerData:GetEquipById(eid)
    Group_Info:SetActive(true)
    local equipCA = PlayerData:GetFactoryData(equipSever.id)
    Group_Info.Btn_Item:SetClickParam(elementIndex)
    Group_Info.Img_Item:SetSprite(equipCA.iconPath)
    Group_Info.Img_Mask:SetSprite(UIConfig.MaskConfig[equipCA.qualityInt + 1])
    Group_Info.Img_Bottom:SetSprite(UIConfig.BottomConfig[equipCA.qualityInt + 1])
    Group_Info.Txt_EquipmentLevel:SetText(string.format(GetText(80600474), equipSever.lv))
    Group_Info.Img_Select:SetActive(false)
    Group_Info.Img_Character:SetActive(false)
    if equipSever.hid ~= "" then
      Group_Info.Img_Character:SetActive(true)
      Group_Info.Img_Character.Img_Face:SetSprite(PlayerData:GetFactoryData(PlayerData:GetFactoryData(equipSever.hid).viewId).face)
    end
    Group_Info.Img_Lock:SetActive(false)
    if equipSever.is_locked == 1 then
      Group_Info.Img_Lock:SetActive(true)
    end
    local equipType = PlayerData:GetTypeInt("enumEquipTypeList", equipCA.equipTagId)
    if typeInt ~= equipType then
      Group_Info.Img_NoType:SetActive(true)
    end
  elseif typeInt ~= 0 then
    Group_Equipment.Img_Waepon:SetActive(true)
    Group_Equipment.Img_Waepon:SetSprite(DataModel.EquipTypeIcon[typeInt])
  else
    Group_Equipment.Img_Waepon:SetActive(false)
  end
end

function DataModel:ChoosePresetsGroup(str)
  if DataModel.PresetIndex and tonumber(str) == DataModel.PresetIndex then
    return
  end
  if DataModel.PresetIndex ~= nil then
    local Btn_Presets = View.Group_Left_Presets.ScrollGrid_Presets.grid.self:GetElementByIndex(DataModel.PresetIndex - 1).Btn_Presets
    Btn_Presets.Img_Select:SetActive(false)
    Btn_Presets.Group_Equipment_1.Group_Info.Img_Select:SetActive(false)
    Btn_Presets.Group_Equipment_2.Group_Info.Img_Select:SetActive(false)
    Btn_Presets.Group_Equipment_3.Group_Info.Img_Select:SetActive(false)
  end
  DataModel.PresetIndex = tonumber(str)
  View.Group_Left_Presets.ScrollGrid_Presets.grid.self:GetElementByIndex(DataModel.PresetIndex - 1).Btn_Presets.Img_Select:SetActive(true)
  local count = 0
  DataModel.NowPresetList = {}
  for k, v in pairs(DataModel.PresetListElementData[tonumber(str)]) do
    local severEquip = PlayerData:GetEquipById(v)
    local equipCA = {}
    if severEquip then
      equipCA = PlayerData:GetFactoryData(severEquip.id)
      count = count + 1
    end
    local eid = v
    local tagCA = PlayerData:GetFactoryData(equipCA.equipTagId)
    local row = {}
    row.eid = eid
    row.equipCA = equipCA
    row.tagCA = tagCA
    row.server = severEquip
    table.insert(DataModel.NowPresetList, row)
  end
  local eid = DataModel.NowPresetList[1].eid
  if eid ~= "" and DataModel.NowPresetList[1].server then
    DataModel.EquipIndex = nil
    DataModel:ChoosePresetEquip(1)
    View.Group_Left_Presets.ScrollGrid_Presets.grid.self:GetElementByIndex(DataModel.PresetIndex - 1).Btn_Presets.Group_Equipment_1.Group_Info.Img_Select:SetActive(true)
  else
    local Group_Right = View.Group_Right
    Group_Right.self:SetActive(false)
  end
  local Group_Left_Presets = View.Group_Left_Presets
  Group_Left_Presets.Btn_Save.Img_Close:SetActive(true)
  Group_Left_Presets.Btn_Delete.Img_Close:SetActive(true)
  if DataModel.PresetIndex == 1 then
    Group_Left_Presets.Btn_Save.Img_Open:SetActive(false)
    Group_Left_Presets.Btn_Delete.Img_Open:SetActive(false)
  else
    Group_Left_Presets.Btn_Save.Img_Open:SetActive(true)
    if count ~= 0 then
      Group_Left_Presets.Btn_Delete.Img_Open:SetActive(true)
    else
      Group_Left_Presets.Btn_Delete.Img_Open:SetActive(false)
    end
  end
  if View.Group_Detail.self.IsActive == true then
    DataModel:OpenDetail()
  end
end

function DataModel:UsePresets(index)
  local choose_equip = DataModel.PresetListElementData[DataModel.PresetIndex]
  local now_equip = DataModel.PresetListElementData[1]
  local num, row = table:Difference(choose_equip, now_equip)
  local new_equip = {}
  if 0 < num then
    local notmyselfCount = 0
    local notequipCount = 0
    for k, v in pairs(choose_equip) do
      new_equip[k] = v
      if v ~= "" then
        local equip = PlayerData:GetEquipById(v)
        if equip == nil then
          notequipCount = notequipCount + 1
          new_equip[k] = ""
        end
        if equip.hid ~= "" and equip.hid ~= DataModel.RoleId then
          notmyselfCount = notmyselfCount + 1
        end
      end
    end
    
    local function callback()
      Net:SendProto("hero.load", function(json)
        print_r(json)
        for k, v in pairs(new_equip) do
          local equip = PlayerData:GetEquipById(v)
          if equip ~= nil then
            if equip.hid ~= "" then
              PlayerData:GetRoleById(tonumber(equip.hid)).equips[k] = ""
            end
            equip.hid = DataModel.RoleId
          elseif now_equip[k] ~= "" then
            PlayerData:GetEquipById(now_equip[k]).hid = ""
          end
        end
        PlayerData:GetRoleById(DataModel.RoleId).equips = new_equip
        DataModel:RefreshChooseRoleEquip(new_equip)
        DataModel.PresetListElementData[1] = new_equip
        DataModel.RoleSeverData = PlayerData:GetRoleById(DataModel.RoleId)
        DataModel:SetRoleEquip()
        View.Group_Center.StaticGrid_Equipment.grid.self:RefreshAllElement()
        View.Group_Left_Presets.ScrollGrid_Presets.grid.self:SetDataCount(table.count(DataModel.RoleSeverData.pre_equips) + 1)
        View.Group_Left_Presets.ScrollGrid_Presets.grid.self:RefreshAllElement()
      end, DataModel.RoleId, DataModel.PresetIndex - 2)
    end
    
    if 0 < notmyselfCount then
      CommonTips.OnPrompt(80600472, nil, nil, callback)
      return
    end
    if 0 < notequipCount then
      CommonTips.OnPrompt(80600473, nil, nil, callback)
      return
    end
    local count = 0
    for k, v in pairs(now_equip) do
      if v ~= "" then
        count = count + 1
      end
    end
    if count == 0 then
      callback()
    else
      CommonTips.OnPrompt(80600532, nil, nil, callback)
    end
  end
end

local baseDetailDesHight = 26

local function SetDetailAffix(obj, row)
  obj.transform:Find("Txt_Entry_Detail").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.descriptionShow)
  local hight_des = obj.transform:Find("Txt_Entry_Detail").transform:GetComponent(typeof(CS.Seven.UITxt)):GetHeight()
  if 24 < hight_des then
    obj.transform:Find("Img_Line").transform:GetComponent(typeof(CS.Seven.UIImg)):SetPos(45, -hight_des + 35)
  else
    obj.transform:Find("Img_Line").transform:GetComponent(typeof(CS.Seven.UIImg)):SetPos(45, -2)
  end
  local Hight = 0
  if hight_des > baseDetailDesHight then
    Hight = hight_des - baseDetailDesHight
  end
  return Hight
end

function DataModel:SetDetailAllAffix(AffixList)
  local lastY = 0
  local img_desc_y = 70
  local top_des_height = img_desc_y
  local lastY_1 = -10
  local lastY_1_Bg = 0
  local count = 1
  local baseViewSpace = 794
  local space = 0
  View.Group_Detail.Group_Detail.ScrollView_Content.self:SetLocalPositionY(-112)
  space = top_des_height
  DataModel.AffixList_Detail = {}
  local random_affix = AffixList or {}
  if 0 < table.count(random_affix) then
    for i = 1, table.count(random_affix) do
      local talentCA = PlayerData:GetFactoryData(random_affix[i].id)
      if random_affix[i].value > -1 then
        talentCA.descriptionShow = string.format(talentCA.description, PlayerData:GetPreciseDecimalFloor(tonumber(random_affix[i].value * talentCA.CommonNum), talentCA.floatNum))
      else
        talentCA.descriptionShow = talentCA.description
      end
      local Group_Entry_Detail = "UI/CharacterInfo/weapon/Group_Entry_Weapon_Detail"
      local Parent = View.Group_Detail.Group_Detail.ScrollView_Content.Viewport.Content.transform
      local obj = View.self:GetRes(Group_Entry_Detail, Parent.transform)
      local name = obj.name
      local hight = obj.transform.sizeDelta.y
      local lastPosY = obj.transform.localPosition.y
      local lastPosX = obj.transform.localPosition.x
      local offest = 0
      hight = 55
      if count ~= 1 then
        lastY = lastY - hight + offest - lastY_1_Bg
      else
        lastY = lastY_1
      end
      obj.name = name .. "_" .. count
      obj.transform.localPosition = Vector3(lastPosX, lastY, 0)
      obj:SetActive(true)
      table.insert(DataModel.AffixList_Detail, obj)
      local hight_des = SetDetailAffix(obj, talentCA)
      lastY_1_Bg = hight_des
      space = space + hight_des + hight
      count = count + 1
      if baseViewSpace < space then
        View.Group_Detail.Group_Detail.ScrollView_Content:SetContentHeight(space)
      end
    end
  end
end

function DataModel:OpenDetail()
  local Group_Addition = View.Group_Detail.Group_Detail.Group_Addition
  local propertyList = {}
  local affixList = {}
  local count = 0
  for k, v in pairs(DataModel.NowPresetList) do
    if v.server then
      count = count + 1
      local list = {}
      list = PlayerData:GetRoleEquipProperty(v.equipCA, v.server.lv)
      local pro, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp = PlayerData:GetBreakMainAttr(v.equipCA, v.server.lv, 0, v.server.bk_lv or 0)
      for c, d in pairs(list) do
        if propertyList[c] == nil then
          local row = {}
          row.type = d.type
          row.index = d.index
          if c == pro.type then
            row.num = curNum
          else
            row.num = d.num
          end
          row.icon = d.icon
          propertyList[c] = row
        else
          local num = d.num
          if c == pro.type then
            num = curNum
          end
          propertyList[c].num = propertyList[c].num + num
        end
      end
      if 0 < table.count(v.server.random_affix) then
        for n, m in pairs(v.server.random_affix) do
          table.insert(affixList, m)
        end
      end
    end
  end
  DataModel:Clear_Detail()
  Group_Addition.Img_Hp:SetSprite(UIConfig.AttributeType.CurrentHp.icon)
  Group_Addition.Img_Atk:SetSprite(UIConfig.AttributeType.Atk.icon)
  Group_Addition.Img_Def:SetSprite(UIConfig.AttributeType.Def.icon)
  Group_Addition.Img_Hp.Txt_Hp:SetText(GetText(80607459) .. "       " .. 0)
  Group_Addition.Img_Atk.Txt_Atk:SetText(GetText(80607458) .. "       " .. 0)
  Group_Addition.Img_Def.Txt_Def:SetText(GetText(80607460) .. "       " .. 0)
  if count ~= 0 then
    Group_Addition.Img_Hp.Txt_Hp:SetText(GetText(80607459) .. "       " .. propertyList.healthPoint_SN.num)
    Group_Addition.Img_Atk.Txt_Atk:SetText(GetText(80607458) .. "       " .. propertyList.attack_SN.num)
    Group_Addition.Img_Def.Txt_Def:SetText(GetText(80607460) .. "       " .. propertyList.defence_SN.num)
  end
  DataModel:SetDetailAllAffix(affixList)
end

function DataModel:ClickDetail()
  if View.Group_Detail.self.IsActive == true then
    View.Group_Detail.self:SetActive(false)
    View.Group_Left_Presets.Btn_Detail.Img_Close.self:SetActive(true)
    View.Group_Left_Presets.Btn_Detail.Img_Open.self:SetActive(false)
  else
    View.Group_Detail.self:SetActive(true)
    DataModel:OpenDetail()
    View.Group_Left_Presets.Btn_Detail.Img_Close.self:SetActive(false)
    View.Group_Left_Presets.Btn_Detail.Img_Open.self:SetActive(true)
  end
end

function DataModel.GetShowType()
  local portraitId = DataModel.RoleSeverData.current_skin[1]
  if portraitId == nil or portraitId == 0 then
    local viewCa = PlayerData:GetFactoryData(DataModel.RoleCA.viewId, "UnitViewFactory")
    portraitId = DataModel.RoleCA.viewId
  end
  local portrailData = PlayerData:GetFactoryData(portraitId, "UnitViewFactory")
  if DataModel.RoleSeverData.resonance_lv == 5 and portrailData.spine2Url ~= nil and portrailData.spine2Url ~= "" then
    if DataModel.RoleSeverData.current_skin[2] == 1 then
      return "Spine2"
    else
      return "Spine"
    end
  end
  if portrailData.spineUrl ~= nil and portrailData.spineUrl ~= "" then
    return "Spine"
  else
    return "Img"
  end
end

function DataModel:SetCenterSquadsData()
  local squadsRoleList = DataModel.SquadRoleList
  DataModel.SquadRoleListData = {}
  DataModel.CenterSquadsIndex = nil
  local count = 0
  for k, v in ipairs(squadsRoleList) do
    local row = {}
    if v.id and v.id ~= "" and v.isLevelRole ~= true and v.isHelpRole ~= true then
      count = count + 1
      row.roleId = v.id
      if tostring(v.id) == DataModel.RoleId then
        DataModel.CenterSquadsIndex = count
      end
      local viewId = PlayerData:GetFactoryData(v.id).viewId
      local viewCA = PlayerData:GetFactoryData(viewId)
      local serverRole = PlayerData:GetRoleById(v.id)
      row.face = serverRole.current_skin ~= nil and serverRole.current_skin[2] == 1 and viewCA.State2Face or viewCA.face
      table.insert(DataModel.SquadRoleListData, row)
    end
  end
end

return DataModel
