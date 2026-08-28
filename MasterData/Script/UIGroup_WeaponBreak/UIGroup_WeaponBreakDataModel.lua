local DataModel = {}
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

function DataModel:Init(param)
  DataModel.server = param.server
  DataModel.LeftTopTagIndex = param.LeftTopTagIndex
  DataModel.equipCA = param.equipCA
  DataModel.tagCA = param.tagCA
  DataModel.eid = param.eid
  DataModel.equipConfig = PlayerData:GetFactoryData(99900027)
end

function DataModel:InitEquipList()
  DataModel.ChooseLeftData = {}
  DataModel.ChooseLeftDataIndexList = {}
  DataModel.RightChooseConsumeEquip = {}
  DataModel:RefreshFilterEquipList()
end

function DataModel:RefreshFilterEquipList()
  DataModel.AllEquip = {}
  DataModel.AllCanStrengthNum = 0
  for c, d in pairs(DataModel.BtnList) do
    d.max = 0
  end
  for k, v in pairs(PlayerData:GetEquips()) do
    if v.hid == "" and v.id == tostring(DataModel.equipCA.id) then
      local data = PlayerData:GetFactoryData(v.id)
      if k ~= DataModel.eid then
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
        table.insert(DataModel.AllEquip, row)
      end
    end
  end
  for k, v in pairs(PlayerData:GetMaterials()) do
    local itemCA = PlayerData:GetFactoryData(k)
    if itemCA and itemCA.EquipItemType and v.num ~= 0 and itemCA.EquipItemType == "BreakItem" then
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

return DataModel
