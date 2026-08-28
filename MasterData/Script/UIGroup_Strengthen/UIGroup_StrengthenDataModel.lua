local DataModel = {ChooseUseItemIndex = nil}
local Coefficient
DataModel.EquipExpList = {
  [1] = PlayerData:GetFactoryData(99900030).expList,
  [2] = PlayerData:GetFactoryData(99900029).expList,
  [3] = PlayerData:GetFactoryData(99900028).expList,
  [4] = PlayerData:GetFactoryData(99900031).expList,
  [5] = PlayerData:GetFactoryData(99900032).expList
}
DataModel.EquipTypeIcon = {
  [1] = "UI\\CharacterInfo\\weapon\\Weapon",
  [2] = "UI\\CharacterInfo\\weapon\\Armor",
  [3] = "UI\\CharacterInfo\\weapon\\Ornament"
}
DataModel.PropertyBase = {
  [1] = {
    type = "attack_SN",
    icon = "UI\\CharacterInfo\\Characterinfo_icon_att_attack",
    name = GetText(80607458)
  },
  [2] = {
    type = "healthPoint_SN",
    icon = "UI\\CharacterInfo\\Characterinfo_icon_att_health",
    name = GetText(80607459)
  },
  [3] = {
    type = "defence_SN",
    icon = "UI\\CharacterInfo\\Characterinfo_icon_att_defense",
    name = GetText(80607460)
  }
}
DataModel.EntryDetailMaxNum = {
  [1] = "Weapon",
  [2] = "Weapon",
  [3] = "Armor",
  [4] = "Ornaments",
  [5] = "Armor",
  [6] = "Ornaments"
}
DataModel.BtnList = {
  [1] = {
    content = GetText(80607455),
    index = 1,
    type = 3,
    isItem = true,
    max = 0
  },
  [2] = {
    content = GetText(80607456),
    index = 2,
    type = 2,
    isItem = true,
    max = 0
  },
  [3] = {
    content = GetText(80607457),
    index = 3,
    type = 1,
    isItem = true,
    max = 0
  },
  [4] = {
    content = GetText(80607454),
    index = 4,
    type = 1,
    isItem = false,
    max = 0
  },
  [5] = {
    content = GetText(80607453),
    index = 5,
    type = 2,
    isItem = false,
    max = 0
  },
  [6] = {
    content = GetText(80607452),
    index = 6,
    type = 3,
    isItem = false,
    max = 0
  }
}
DataModel.EquipUseNumList = {
  [1] = {ratio = 5},
  [2] = {ratio = 10},
  [3] = {ratio = 20},
  [4] = {ratio = 50},
  [5] = {ratio = 100}
}

function DataModel:Clear()
  if DataModel.AffixList then
    for k, v in pairs(DataModel.AffixList) do
      Object.Destroy(v)
    end
  end
end

local function SetStrengthFilter(index, value)
  if PlayerData.DepotStengthFilter == nil then
    PlayerData.DepotStengthFilter = {}
  end
  PlayerData.DepotStengthFilter[index] = value
end

local StateEnum = {
  [0] = "Btn_All",
  "Btn_S01",
  "Btn_S02"
}

function DataModel:SwitchType(index, Group_Type)
  if index ~= 0 or not DataModel.FilterType[index] then
    DataModel.FilterType[index] = not DataModel.FilterType[index]
  end
  local len = #DataModel.FilterType
  if DataModel.FilterType[0] then
    for i = 1, len do
      DataModel.FilterType[i] = false
    end
  else
    local isAll = true
    local isAntiAll = true
    for i = 1, len do
      isAll = isAll and DataModel.FilterType[i]
      isAntiAll = isAntiAll and not DataModel.FilterType[i]
    end
    if isAll or isAntiAll then
      DataModel.FilterType[0] = true
      for i = 1, len do
        DataModel.FilterType[i] = false
      end
    else
      DataModel.FilterType[0] = false
    end
  end
  for i = 0, len do
    if i == 0 then
      Group_Type.Btn_All.Img_Select:SetActive(DataModel.FilterType[i])
    else
      Group_Type.StaticGrid_Type.grid[i].Btn_Type.Img_Select:SetActive(DataModel.FilterType[i])
    end
  end
  SetStrengthFilter(1, DataModel.FilterType)
end

function DataModel:SwitchRarity(index, Group_Rarity)
  if index ~= 0 or not DataModel.FilterRarity[index] then
    DataModel.FilterRarity[index] = not DataModel.FilterRarity[index]
  end
  local len = #DataModel.FilterRarity
  if DataModel.FilterRarity[0] then
    for i = 1, len do
      DataModel.FilterRarity[i] = false
    end
  else
    local isAll = true
    local isAntiAll = true
    for i = 1, len do
      isAll = isAll and DataModel.FilterRarity[i]
      isAntiAll = isAntiAll and not DataModel.FilterRarity[i]
    end
    if isAll or isAntiAll then
      DataModel.FilterRarity[0] = true
      for i = 1, len do
        DataModel.FilterRarity[i] = false
      end
    else
      DataModel.FilterRarity[0] = false
    end
  end
  for i = 0, len do
    if i == 0 then
      Group_Rarity.Btn_All.Img_Select:SetActive(DataModel.FilterRarity[i])
    else
      Group_Rarity.StaticGrid_Rarity.grid[i].Btn_Rarity.Img_Select:SetActive(DataModel.FilterRarity[i])
    end
  end
  SetStrengthFilter(2, DataModel.FilterRarity)
end

function DataModel:SwitchState(index, Group_State)
  if index ~= 0 or not DataModel.FilterState[index] then
    DataModel.FilterState[index] = not DataModel.FilterState[index]
  end
  local len = #DataModel.FilterState
  if DataModel.FilterState[0] then
    for i = 1, len do
      DataModel.FilterState[i] = false
    end
  else
    local isAll = true
    local isAntiAll = true
    for i = 1, len do
      isAll = isAll and DataModel.FilterState[i]
      isAntiAll = isAntiAll and not DataModel.FilterState[i]
    end
    if isAll or isAntiAll then
      DataModel.FilterState[0] = true
      for i = 1, len do
        DataModel.FilterState[i] = false
      end
    else
      DataModel.FilterState[0] = false
    end
  end
  for i = 0, len do
    if i == 0 then
      Group_State.Btn_All.Img_Select:SetActive(DataModel.FilterState[i])
    else
      Group_State[StateEnum[i]].Img_Select:SetActive(DataModel.FilterState[i])
    end
  end
  SetStrengthFilter(3, DataModel.FilterState)
end

function DataModel:HaveOwnerEquip()
  self.OwnerEquip = {}
  for i, v in pairs(PlayerData.ServerData.roles) do
    if v.equips then
      for a, b in ipairs(v.equips) do
        if b ~= "" then
          self.OwnerEquip[b] = v.id
        end
      end
    end
  end
end

function DataModel:ResetFilter()
  self:HaveOwnerEquip()
  self.EquipType = {}
  self.FilterType = {
    [0] = true
  }
  self.FilterState = {
    [0] = true
  }
  self.FilterRarity = {
    [0] = true
  }
  local ConfigFactory = PlayerData:GetFactoryData(99900017, "ConfigFactory")
  for i, v in ipairs(ConfigFactory.enumEquipTypeList) do
    local data = PlayerData:GetFactoryData(v.equipType, "TagFactory")
    if self.FilterType[i] == nil then
      self.FilterType[i] = false
    end
    self.EquipType[i] = self.EquipType[i] or {
      name = data.Name,
      detail = {},
      id = data.id,
      typeID = data.typeID
    }
  end
  for i, v in ipairs(ConfigFactory.commonRareList) do
    if self.FilterRarity[i] == nil then
      self.FilterRarity[i] = false
    end
  end
  for i = 1, 2 do
    if self.FilterState[i] == nil then
      self.FilterState[i] = false
    end
  end
end

function DataModel:Init(param)
  DataModel.server = param.server
  DataModel.LeftTopTagIndex = param.LeftTopTagIndex
  DataModel.equipCA = param.equipCA
  DataModel.tagCA = param.tagCA
  DataModel.eid = param.eid
  DataModel.EquipUseBtnListIndex = nil
  DataModel.BtnListIndex = nil
  DataModel.EquipUseBtnListLatsIndex = nil
  PlayerData.DepotStengthFilter = nil
  DataModel.DefaultRightBtnListIndex = 1
  DataModel.DefaultEquipUseNumListIndex = 1
  if PlayerData:GetFactoryData(80304810) and PlayerData:GetFactoryData(80304810).balloonList then
    DataModel.EquipUseNumList = {}
    for k, v in pairs(PlayerData:GetFactoryData(80304810).balloonList) do
      if v.ratio and v.ratio == 10 then
        DataModel.DefaultEquipUseNumListIndex = k
      end
      table.insert(DataModel.EquipUseNumList, {
        ratio = math.floor(v.ratio)
      })
    end
  end
  local pro, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp = PlayerData:GetBreakMainAttr(DataModel.equipCA, DataModel.server.lv, 0, DataModel.server.bk_lv)
  DataModel.Max_Equip_Use_Num = DataModel.EquipUseNumList[PlayerData:GetPlayerPrefs("int", "EquipUseNumMax") == 0 and DataModel.DefaultEquipUseNumListIndex or PlayerData:GetPlayerPrefs("int", "EquipUseNumMax")].ratio
  DataModel.EquipFactory = PlayerData:GetFactoryData(99900027)
  DataModel.Max_Equip_Lv = DataModel.EquipFactory.equipMaxLv + math.floor(extraLv or 0)
  DataModel.TypeIndex = PlayerData:GetTypeInt("enumEquipTypeList", DataModel.equipCA.equipTagId)
  DataModel.JewelryEx = 1
  if DataModel.TypeIndex == 3 then
    DataModel.JewelryEx = DataModel.EquipFactory.jewelryEx
  end
  DataModel.Max_Affix_Num = PlayerData:GetFactoryData(DataModel.equipCA.equipTagId).typeName + math.floor(extraSkill)
  DataModel:ResetFilter()
end

function DataModel:RefreshFilterEquipList()
  DataModel.AllEquip = {}
  DataModel.AllCanStrengthNum = 0
  for c, d in pairs(DataModel.BtnList) do
    d.max = 0
  end
  if self.FilterState[0] or self.FilterState[2] then
    for k, v in pairs(PlayerData:GetEquips()) do
      if v.hid == "" and k ~= DataModel.eid then
        local data = PlayerData:GetFactoryData(v.id)
        local typeID = PlayerData:GetFactoryData(data.equipTagId).typeID
        if DataModel.ChooseLeftData[tonumber(k)] or (self.FilterType[0] or self.FilterType[typeID]) and (self.FilterRarity[0] or self.FilterRarity[data.qualityInt + 1]) then
          local row = {}
          row.extra_affix = v.extra_affix
          row.lv = v.lv
          row.ex_num = v.ex_num
          row.random_affix = v.random_affix
          row.exp = v.exp
          row.rp_num = v.rp_num
          row.id = v.id
          row.hid = v.hid
          row.obtain_time = v.obtain_time
          row.is_locked = v.is_locked
          row.bk_lv = v.bk_lv
          row.eid = k
          row.equipCA = data
          row.index = 0
          if row.is_locked == 0 then
            row.index = 2
          end
          if row.is_locked == 1 then
            row.index = 3
          end
          row.isItem = false
          row.isOnPut = false
          if row.equipCA.qualityInt < 4 then
            if row.is_locked == 0 and v.lv == 1 then
              for c, d in pairs(DataModel.BtnList) do
                local type = d.type
                local isItem = d.isItem
                if row.equipCA.qualityInt <= tonumber(type) and isItem == false then
                  d.max = d.max + 1
                  row.isOnPut = true
                end
              end
            end
            table.insert(DataModel.AllEquip, row)
          end
        end
      end
    end
  end
  if self.FilterState[0] or self.FilterState[1] then
    for k, v in pairs(PlayerData:GetMaterials()) do
      local itemCA = PlayerData:GetFactoryData(k)
      if itemCA and itemCA.EquipItemType and v.num ~= 0 and itemCA.EquipItemType == 12600393 and (self.FilterRarity[0] or self.FilterRarity[itemCA.qualityInt + 1]) then
        local row = {}
        row.index = 1
        row.eid = k
        row.id = k
        row.equipCA = itemCA
        row.lv = 1
        row.hid = ""
        row.is_locked = 0
        row.num = 0
        if DataModel.ChooseLeftData[k] and DataModel.ChooseLeftData[k].num then
          row.num = DataModel.ChooseLeftData[k].num
        end
        row.maxNum = v.num
        row.isItem = true
        row.isOnPut = false
        for c, d in pairs(DataModel.BtnList) do
          local type = d.type
          local isItem = d.isItem
          if row.equipCA.qualityInt <= tonumber(type) and isItem == true then
            d.max = d.max + v.num
            row.isOnPut = true
          end
        end
        table.insert(DataModel.AllEquip, row)
      end
    end
  end
  table.sort(DataModel.AllEquip, function(a, b)
    if a.index == b.index then
      if a.equipCA.qualityInt == b.equipCA.qualityInt then
        if a.lv == b.lv then
          return a.equipCA.id < b.equipCA.id
        end
        return a.lv < b.lv
      end
      return a.equipCA.qualityInt > b.equipCA.qualityInt
    end
    return a.index < b.index
  end)
end

function DataModel:InitEquipList()
  DataModel.ChooseLeftData = {}
  DataModel.ChooseLeftDataIndexList = {}
  DataModel.AllConsumeExp = 0
  Coefficient = nil
  DataModel.RightChooseConsumeEquip = {}
  DataModel.AllEquip = {}
  DataModel.AllCanStrengthNum = 0
  for c, d in pairs(DataModel.BtnList) do
    d.max = 0
  end
  if self.FilterState[0] or self.FilterState[2] then
    for k, v in pairs(PlayerData:GetEquips()) do
      if v.hid == "" and k ~= DataModel.eid then
        local data = PlayerData:GetFactoryData(v.id)
        local typeID = PlayerData:GetFactoryData(data.equipTagId).typeID
        if (self.FilterType[0] or self.FilterType[typeID]) and (self.FilterRarity[0] or self.FilterRarity[data.qualityInt + 1]) and (self.FilterState[0] or self.FilterState[1] and self.OwnerEquip[k] or self.FilterState[2] and not self.OwnerEquip[k]) then
          local row = {}
          row.extra_affix = v.extra_affix
          row.lv = v.lv
          row.ex_num = v.ex_num
          row.random_affix = v.random_affix
          row.exp = v.exp
          row.rp_num = v.rp_num
          row.id = v.id
          row.hid = v.hid
          row.obtain_time = v.obtain_time
          row.is_locked = v.is_locked
          row.bk_lv = v.bk_lv
          row.eid = k
          row.equipCA = data
          row.index = 0
          if row.is_locked == 0 then
            row.index = 2
          end
          if row.is_locked == 1 then
            row.index = 3
          end
          row.isItem = false
          row.isOnPut = false
          if row.equipCA.qualityInt < 4 then
            if row.is_locked == 0 and v.lv == 1 then
              for c, d in pairs(DataModel.BtnList) do
                local type = d.type
                local isItem = d.isItem
                if row.equipCA.qualityInt <= tonumber(type) and isItem == false then
                  d.max = d.max + 1
                  row.isOnPut = true
                end
              end
            end
            table.insert(DataModel.AllEquip, row)
          end
        end
      end
    end
  end
  if self.FilterState[0] or self.FilterState[1] then
    for k, v in pairs(PlayerData:GetMaterials()) do
      local itemCA = PlayerData:GetFactoryData(k)
      if itemCA and itemCA.EquipItemType and v.num ~= 0 and itemCA.EquipItemType == 12600393 and (self.FilterRarity[0] or self.FilterRarity[itemCA.qualityInt + 1]) then
        local row = {}
        row.index = 1
        row.eid = k
        row.id = k
        row.equipCA = itemCA
        row.lv = 1
        row.hid = ""
        row.is_locked = 0
        row.num = 0
        row.maxNum = v.num
        row.isItem = true
        row.isOnPut = false
        for c, d in pairs(DataModel.BtnList) do
          local type = d.type
          local isItem = d.isItem
          if row.equipCA.qualityInt <= tonumber(type) and isItem == true then
            d.max = d.max + v.num
            row.isOnPut = true
          end
        end
        table.insert(DataModel.AllEquip, row)
      end
    end
  end
  table.sort(DataModel.AllEquip, function(a, b)
    if a.index == b.index then
      if a.equipCA.qualityInt == b.equipCA.qualityInt then
        if a.lv == b.lv then
          return a.equipCA.id < b.equipCA.id
        end
        return a.lv < b.lv
      end
      return a.equipCA.qualityInt > b.equipCA.qualityInt
    end
    return a.index < b.index
  end)
  DataModel.NowBtnListData = DataModel.BtnList[PlayerData:GetPlayerPrefs("int", "EquipType") == 0 and DataModel.DefaultRightBtnListIndex or PlayerData:GetPlayerPrefs("int", "EquipType")]
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
    callback()
    return
  end
  if isChange == true then
    Net:SendProto("equip.lock", function(json)
      print_r(json)
      for k, v in pairs(changeList) do
        PlayerData:GetEquipByEid(v.eid).is_locked = v.is_locked
      end
      callback()
    end, str_lock, str_unlock)
  end
end

function DataModel:OneClickPutData()
  local onPutNum = 0
  for k, v in pairs(DataModel.ChooseLeftDataIndexList) do
    local type = DataModel.NowBtnListData.type
    local isItem = DataModel.NowBtnListData.isItem
    if v.isOnPut == true and v.equipCA.qualityInt <= tonumber(type) and isItem == v.isItem then
      onPutNum = onPutNum + 1
    end
  end
  if onPutNum >= DataModel.NowBtnListData.max then
    CommonTips.OpenTips(80602255)
    return
  end
  local leftDataCount = table.count(DataModel.ChooseLeftDataIndexList)
  local allEquip = {}
  for k, v in pairs(DataModel.AllEquip) do
    if v.is_locked == 0 and v.hid == "" and k ~= DataModel.eid and v.lv == 1 then
      local type = DataModel.NowBtnListData.type
      local isItem = DataModel.NowBtnListData.isItem
      if v.equipCA.qualityInt <= tonumber(type) and isItem == v.isItem then
        if v.isItem == true then
          if v.maxNum >= v.num then
            for i = 1, v.maxNum - v.num do
              table.insert(allEquip, v)
            end
          end
        elseif DataModel.ChooseLeftData[v.eid] == nil then
          table.insert(allEquip, v)
        end
      end
    end
  end
  table.sort(allEquip, function(a, b)
    if a.equipCA.qualityInt == b.equipCA.qualityInt then
      if a.lv == b.lv then
        return a.equipCA.id < b.equipCA.id
      end
      return a.lv < b.lv
    end
    return a.equipCA.qualityInt > b.equipCA.qualityInt
  end)
  DataModel.AllConsumeExp = 0
  DataModel.AllGold = 0
  DataModel.IsMax = false
  DataModel.Show_Exp = 0
  DataModel.ALLExp = 0
  for i = 1, DataModel.Max_Equip_Use_Num do
    if DataModel.IsMax == false and DataModel.RightChooseConsumeEquip[i].eid == "" and allEquip[i - leftDataCount] and DataModel.RightChooseConsumeEquip[i] then
      local row = {}
      local equip = allEquip[i - leftDataCount]
      row.lv = equip.lv
      row.equipCA = equip.equipCA
      row.eid = equip.eid
      if equip.isItem == true and equip.num < equip.maxNum then
        equip.num = equip.num + 1
        row.num = equip.num
      end
      row.isOnPut = equip.isOnPut
      row.isItem = equip.isItem
      DataModel.ChooseLeftData[row.eid] = row
      DataModel.ChooseLeftData[row.eid].index = i
      DataModel.ChooseLeftDataIndexList[i] = row
      DataModel.ConsumeNum = DataModel.ConsumeNum + 1
      DataModel.RightChooseConsumeEquip[i] = row
    end
    if DataModel.ChooseLeftDataIndexList[i] then
      DataModel:CalculateExp(DataModel.ChooseLeftDataIndexList[i])
    end
  end
end

function DataModel:CalculateExp(row)
  local exp = 0
  local base = 0
  local add_exp = 0
  Coefficient = Coefficient or DataModel.EquipFactory.Coefficient
  if row.isItem == true then
    exp = PlayerData:GetFactoryData(row.eid).equipExp
  else
    local typeIndex = PlayerData:GetTypeInt("enumEquipTypeList", row.equipCA.equipTagId)
    local jewelryEx = 1
    if typeIndex == 3 then
      jewelryEx = DataModel.EquipFactory.jewelryEx
    end
    local index = row.equipCA.qualityInt + 1
    if DataModel.EquipFactory[row.equipCA.quality] then
      base = DataModel.EquipFactory[row.equipCA.quality]
    end
    if DataModel.EquipExpList[index] then
      local equipExpList = DataModel.EquipExpList[index]
      local list = equipExpList[tonumber(row.lv)]
      if list then
        add_exp = list.EnergyMax * Coefficient * jewelryEx
      end
    end
    exp = add_exp + base
  end
  DataModel.AllConsumeExp = DataModel.AllConsumeExp + exp
  DataModel.AllGold = math.floor(DataModel.AllGold + exp * 10)
  DataModel:CalculateEquipNeedExp()
end

function DataModel:CalculateEquipNeedExp(exp)
  DataModel.TotalLv = DataModel.server.lv
  DataModel.TotalExp = DataModel.server.exp
  DataModel.Add_lv = 0
  local equip_lv = DataModel.TotalLv
  local equip_exp = DataModel.TotalExp
  local equipExpList = DataModel.EquipExpList[DataModel.equipCA.qualityInt + 1]
  local equip_exp_max = equipExpList[equip_lv] and equipExpList[equip_lv].EnergyMax or 0
  equip_exp_max = math.floor((equip_exp_max + equip_exp) * DataModel.JewelryEx)
  if equipExpList[equip_lv] then
    local now_exp_max = equipExpList[equip_lv].levelUpExp * DataModel.JewelryEx
    now_exp_max = math.floor(now_exp_max)
    local now_lv = equip_lv
    local residue_exp = DataModel.AllConsumeExp
    while 0 <= residue_exp do
      local stage_exp
      if now_lv == equip_lv then
        stage_exp = now_exp_max - equip_exp
      else
        stage_exp = equipExpList[now_lv].levelUpExp * DataModel.JewelryEx
      end
      DataModel.Add_lv = DataModel.Add_lv + 1
      DataModel.TotalLv = DataModel.TotalLv + 1
      now_lv = now_lv + 1
      residue_exp = residue_exp - stage_exp
      if residue_exp == 0 then
        DataModel.Show_Exp = 0
        break
      end
      if residue_exp < 0 then
        residue_exp = residue_exp + stage_exp
        DataModel.Show_Exp = residue_exp
        DataModel.Add_lv = DataModel.Add_lv - 1
        DataModel.TotalLv = DataModel.TotalLv - 1
        break
      end
      if now_lv == DataModel.Max_Equip_Lv then
        DataModel.Show_Exp = 0
        DataModel.IsMax = true
        break
      end
    end
    DataModel.TotalExp = DataModel.Show_Exp
    if DataModel.IsMax and DataModel.Add_lv + equip_lv == DataModel.Max_Equip_Lv then
      DataModel.AllGold = 0
      local aa = equipExpList[DataModel.Max_Equip_Lv].EnergyMax * DataModel.JewelryEx - equip_exp_max
      local bb = aa * 10
      DataModel.AllGold = bb
    end
  end
end

local function SearchEquipmentAffix(id, Entrylist)
  local EquipmentEntryList = PlayerData:GetFactoryData(id).EquipmentEntryList
  local count = 0
  for k, v in pairs(EquipmentEntryList) do
    for c, d in pairs(Entrylist) do
      if v.id == d.id then
        count = count + 1
      end
    end
  end
  if count == table.count(EquipmentEntryList) then
    return true
  end
  return false
end

function DataModel:GetUseItemData()
  DataModel.UseItemList = {}
  local EquipmentEntryList = {}
  for c, d in pairs(DataModel.equipCA.randomSkillList) do
    local EquipmentEntryList_CA = PlayerData:GetFactoryData(d.skillId).EquipmentEntryList
    for k, v in pairs(EquipmentEntryList_CA) do
      table.insert(EquipmentEntryList, v)
    end
  end
  for k, v in pairs(PlayerData:GetItems()) do
    local itemCA = PlayerData:GetFactoryData(k)
    if itemCA and itemCA.EquipItemType and itemCA.EquipItemType ~= 12600393 and k ~= "11400217" and (DataModel.equipCA.campTagId == -1 or itemCA.campType == -1 or itemCA.campType == DataModel.equipCA.campTagId) then
      if itemCA.EntryItemList[1] then
        local row = {}
        if v.num > 0 then
          for c, d in pairs(v) do
            row[c] = d
          end
          row.itemCA = itemCA
          for _k, _v in pairs(EquipmentEntryList) do
            local state = false
            if k == "11400057" then
              state = SearchEquipmentAffix(itemCA.EntryItemList[1].Entry, EquipmentEntryList)
            end
            if _v.id == itemCA.EntryItemList[1].Entry or state == true then
              table.insert(DataModel.UseItemList, row)
              break
            end
          end
        end
      end
      if table.count(itemCA.EntryItemList) == 0 then
        local row = {}
        if v.num > 0 then
          for c, d in pairs(v) do
            row[c] = d
          end
          row.itemCA = itemCA
          table.insert(DataModel.UseItemList, row)
        end
      end
    end
  end
end

return DataModel
