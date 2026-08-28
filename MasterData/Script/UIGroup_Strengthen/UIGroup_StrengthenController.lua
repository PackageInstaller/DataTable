local DataModel = require("UIGroup_Strengthen/UIGroup_StrengthenDataModel")
local View = require("UIGroup_Strengthen/UIGroup_StrengthenView")
local CommonItem = require("Common/BtnItem")
local Controller = {}

local function Clear_Center()
  if DataModel.AffixList_Center then
    for k, v in pairs(DataModel.AffixList_Center) do
      Object.Destroy(v)
    end
  end
end

function Controller:Init(...)
  View.Group_UseMoney.self:SetActive(false)
  View.Group_Windows.self:SetActive(false)
  View.Group_Detail.self:SetActive(false)
  View.Group_Left.self:SetActive(false)
  Controller:InitEquip()
  Controller:InitFilter()
end

function Controller:InitFilter()
  UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/weapon/Group_Strengthen", "Group_Filter")
  local StaticGrid_Type = View.Group_Filter.Group_Type.StaticGrid_Type.grid.self
  StaticGrid_Type:SetDataCount(#DataModel.EquipType)
  StaticGrid_Type:RefreshAllElement()
  local StaticGrid_Rarity = View.Group_Filter.Group_Rarity.StaticGrid_Rarity.grid.self
  StaticGrid_Rarity:SetDataCount(#PlayerData:GetFactoryData(99900017, "ConfigFactory").commonRareList)
  StaticGrid_Rarity:RefreshAllElement()
  DataModel:SwitchType(0, View.Group_Filter.Group_Type)
  DataModel:SwitchRarity(0, View.Group_Filter.Group_Rarity)
  DataModel:SwitchState(0, View.Group_Filter.Group_State)
end

function Controller:InitEquip()
  DataModel:InitEquipList()
  View.Group_SortRare.self:SetActive(false)
  View.Group_Right.Btn_List.Img_Arrow.transform.localRotation = Quaternion.Euler(0, 0, 90)
  View.Group_Right.Btn_List.Txt_List:SetText(DataModel.NowBtnListData.content)
end

function Controller:RefreshFilter()
  DataModel:RefreshFilterEquipList()
  if View.Group_Detail.self.IsActive == true then
    View.Group_Detail.self:SetActive(false)
  end
  View.Group_Left.ScrollGrid_Item.grid.self:SetDataCount(table.count(DataModel.AllEquip))
  View.Group_Left.ScrollGrid_Item.grid.self:RefreshAllElement()
  View.Group_Left.ScrollGrid_Item.grid.self:MoveToTop()
end

function Controller:SelectBtnList(index)
  if DataModel.BtnListIndex and index == DataModel.BtnListIndex then
    return
  end
  DataModel.BtnListIndex = index
  PlayerData:SetPlayerPrefs("int", "EquipType", index)
  View.Group_SortRare.Img_Glass.Img_Bg.StaticGrid_Rare.grid.self:RefreshAllElement()
  DataModel.NowBtnListData = DataModel.BtnList[DataModel.BtnListIndex]
  View.Group_Right.Btn_List.Txt_List:SetText(DataModel.NowBtnListData.content)
end

function Controller:SelectEquipUseBtnList(index)
  if DataModel.EquipUseBtnListIndex and index == DataModel.EquipUseBtnListIndex then
    return
  end
  DataModel.EquipUseBtnListIndex = index
  PlayerData:SetPlayerPrefs("int", "EquipUseNumMax", index)
  DataModel.Max_Equip_Use_Num = DataModel.EquipUseNumList[index].ratio
  View.Group_Numbtn.Img_Glass.Img_Bg.StaticGrid_Arrow.grid.self:RefreshAllElement()
  local Group_Right = View.Group_Right
  Group_Right.Txt_Number:SetText(string.format(GetText(80600540), table.count(DataModel.ChooseLeftDataIndexList), DataModel.Max_Equip_Use_Num))
end

function Controller:UseOnlyItemEntry()
  local function callback(...)
    local itemID = 11400217
    
    local items = {}
    items[tostring(itemID)] = 1
    Net:SendProto("equip.set_item_affix", function(json)
      DataModel.server = json.equip
      PlayerData.ServerData.equipments.equips[DataModel.eid] = json.equip
      if itemID ~= "" then
        PlayerData:RefreshUseItems(items)
      end
      Controller:RefreshChangeWindows()
      View.Group_Windows.Txt_Tips:SetActive(true)
      View.Group_Windows.Group_UseItem.self:SetActive(false)
      View.Group_Windows.ScrollGrid_Entry.self:SetActive(true)
      if DataModel.EntryIndex and DataModel.IsMaxAffix == false then
        local Btn_Entry = View.Group_Windows.ScrollGrid_Entry.grid.self:GetElementByIndex(DataModel.EntryIndex - 2)
        if Btn_Entry then
          Btn_Entry = Btn_Entry.Btn_Entry
          Btn_Entry.Img_CannotSelect:SetActive(false)
          Btn_Entry.Img_Select:SetActive(true)
          Btn_Entry.Img_Choose:SetActive(true)
        end
      end
    end, DataModel.eid, itemID)
  end
  
  local checkTipParam = {}
  checkTipParam.isCheckTip = true
  checkTipParam.checkTipKey = "EquipOnlyUseItemKey"
  checkTipParam.checkTipType = 1
  checkTipParam.showDanger = true
  CommonTips.OnPrompt(GetText(80601577), nil, nil, callback, nil, nil, nil, nil, checkTipParam)
end

function Controller:UseItemEntry()
  if DataModel.ChooseUseItemIndex == nil then
    return
  end
  if DataModel.server.extra_affix and table.count(DataModel.server.extra_affix) > 0 and DataModel.server.ex_num ~= 0 then
    CommonTips.OpenTips(80601652)
    return
  end
  
  local function callback()
    local itemID = ""
    local items = {}
    if DataModel.ChooseUseItemIndex then
      local row = DataModel.UseItemList[tonumber(DataModel.ChooseUseItemIndex)]
      itemID = row.id
      items[tostring(itemID)] = 1
    end
    Net:SendProto("equip.set_item_affix", function(json)
      DataModel.server = json.equip
      PlayerData.ServerData.equipments.equips[DataModel.eid] = json.equip
      if itemID ~= "" then
        PlayerData:RefreshUseItems(items)
      end
      Controller:RefreshChangeWindows()
      View.Group_Windows.Txt_Tips:SetActive(true)
      View.Group_Windows.Group_UseItem.self:SetActive(false)
      View.Group_Windows.ScrollGrid_Entry.self:SetActive(true)
      if DataModel.EntryIndex and DataModel.IsMaxAffix == false then
        local Btn_Entry = View.Group_Windows.ScrollGrid_Entry.grid.self:GetElementByIndex(DataModel.EntryIndex - 2)
        if Btn_Entry then
          Btn_Entry = Btn_Entry.Btn_Entry
          Btn_Entry.Img_CannotSelect:SetActive(false)
          Btn_Entry.Img_Select:SetActive(true)
          Btn_Entry.Img_Choose:SetActive(true)
        end
      end
    end, DataModel.eid, itemID)
  end
  
  local checkTipParam = {}
  checkTipParam.isCheckTip = true
  checkTipParam.checkTipKey = "EquipUseItemKey"
  checkTipParam.checkTipType = 1
  checkTipParam.showDanger = true
  CommonTips.OnPrompt(GetText(80601577), nil, nil, callback, nil, nil, nil, nil, checkTipParam)
end

function Controller:ConfirmEntry()
  if View.Group_Windows.Btn_Confirm.Img_Use.IsActive == false then
    return
  end
  
  local function callback()
    Net:SendProto("equip.set_affix", function(json)
      print_r(json)
      PlayerData.ServerData.equipments.equips[DataModel.eid] = json.equip
      DataModel.server = json.equip
      DataModel.ChooseUseItemIndex = nil
      Controller:RefreshChangeWindows()
      DataModel.IsSend = true
    end, DataModel.eid, DataModel.EntryIndex - 1)
  end
  
  CommonTips.OnPrompt(GetText(80601578), nil, nil, callback, nil)
end

function Controller:DelEnrty()
  local function callback()
    Net:SendProto("equip.set_affix", function(json)
      print_r(json)
      
      PlayerData.ServerData.equipments.equips[DataModel.eid] = json.equip
      DataModel.server = json.equip
      DataModel.ChooseUseItemIndex = nil
      Controller:RefreshChangeWindows()
    end, DataModel.eid, -1)
  end
  
  local checkTipParam = {}
  checkTipParam.isCheckTip = true
  checkTipParam.checkTipKey = "EquipDelItemKey"
  checkTipParam.checkTipType = 1
  checkTipParam.showDanger = true
  CommonTips.OnPrompt(GetText(80601666), nil, nil, callback, nil, nil, nil, nil, checkTipParam)
end

function Controller:CloseGroupUseItem()
  if DataModel.ChooseUseItemIndex then
    View.Group_Windows.Img_ItemChangeEntry:SetActive(false)
  end
  View.Group_Windows.Btn_UseItem.self:SetActive(true)
  View.Group_Windows.Group_UseItem.self:SetActive(false)
  View.Group_Windows.Txt_Tips:SetActive(true)
  View.Group_Windows.ScrollGrid_Entry.self:SetActive(true)
  Controller.RefreshEntryTop()
end

function Controller:ClickGroupUseItem()
  DataModel.ChooseUseItemIndex = nil
  Controller:RefreshUseItem()
  View.Group_Windows.Btn_UseItem.self:SetActive(false)
end

function Controller:ChooseEquipItem(str)
  if tonumber(str) == DataModel.ChooseUseItemIndex then
    return
  end
  if DataModel.ChooseUseItemIndex then
    local old_element = View.Group_Windows.Group_UseItem.ScrollGrid_Item.grid.self:GetElementByIndex(DataModel.ChooseUseItemIndex - 1)
    if old_element then
      old_element.Group_Equipment1.Img_Select:SetActive(false)
    end
  end
  DataModel.ChooseUseItemIndex = tonumber(str)
  local element = View.Group_Windows.Group_UseItem.ScrollGrid_Item.grid.self:GetElementByIndex(tonumber(str) - 1)
  if element then
    element.Group_Equipment1.Img_Select:SetActive(true)
  end
  Controller:RefreshUseItemBottomState()
  Controller:RefreshUseItemTopPage()
end

function Controller:RefreshUseItem()
  if table.count(DataModel.UseItemList) == 0 then
    DataModel:GetUseItemData()
  end
  table.sort(DataModel.UseItemList, function(a, b)
    return a.itemCA.qualityInt < b.itemCA.qualityInt
  end)
  View.Group_Windows.Group_UseItem.self:SetActive(true)
  View.Group_Windows.Txt_Tips:SetActive(false)
  View.Group_Windows.ScrollGrid_Entry.self:SetActive(false)
  Controller:RefreshUseItemBottomState()
  View.Group_Windows.Group_UseItem.ScrollGrid_Item.grid.self:SetDataCount(table.count(DataModel.UseItemList))
  View.Group_Windows.Group_UseItem.ScrollGrid_Item.grid.self:RefreshAllElement()
  DataModel.ChooseUseItemIndex = nil
  Controller:ChooseEquipItem(1)
end

function Controller:RefreshUseItemBottomState()
  if DataModel.ChooseUseItemIndex and DataModel.UseItemList[DataModel.ChooseUseItemIndex] then
    View.Group_Windows.Group_UseItem.Btn_ConfirmItem.Img_Useless.self:SetActive(false)
    View.Group_Windows.Group_UseItem.Btn_ConfirmItem.Img_Use.self:SetActive(true)
  else
    View.Group_Windows.Group_UseItem.Btn_ConfirmItem.Img_Useless.self:SetActive(true)
    View.Group_Windows.Group_UseItem.Btn_ConfirmItem.Img_Use.self:SetActive(false)
  end
end

function Controller:CloseChangeWindows()
  View.self:PlayAnim("Close_Windows", function()
    DataModel.ChooseUseItemIndex = nil
    DataModel.UseItemList = {}
    View.Group_Windows.self:SetActive(false)
  end)
end

function Controller:ClickChangeWindows()
  DataModel.IsSend = false
  DataModel.IsMaxAffix = false
  UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/weapon/Group_Strengthen", "Group_Windows")
  View.Group_Windows.self:SetActive(true)
  if DataModel.equipCA and DataModel.server then
    CommonItem:SetEquipment(View.Group_Windows.Group_Equipment_Row.Group_Equipment, {
      data = {
        id = DataModel.equipCA.id
      },
      server = DataModel.server
    })
    View.Group_Windows.Group_Equipment_Row.Txt_EquipmentName:SetText(DataModel.equipCA.name)
    local tagIndex = PlayerData:GetTypeInt("enumEquipTypeList", DataModel.equipCA.equipTagId)
    for i = 1, 3 do
      View.Group_Windows.Group_Equipment_Row.Group_EquipmentType["Img_type" .. i]:SetActive(i == tagIndex)
    end
    View.Group_Windows.Group_Equipment_Row.Txt_EquipmentLvNum:SetText(DataModel.server.lv)
    local imgAttr = View.Group_Windows.Group_Equipment_Row.Img_Attr
    imgAttr.self:SetActive(false)
    local pro, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp = PlayerData:GetBreakMainAttr(DataModel.equipCA, DataModel.server.lv, 0, DataModel.server.bk_lv or 0)
    imgAttr:SetSprite(pro.icon)
    imgAttr.Txt_Attr:SetText(pro.name .. " <color='#FFB800'>+ " .. PlayerData:GetPreciseDecimalFloor(curNum, 0) .. "</color>")
    imgAttr.self:SetActive(true)
    if 0 < #DataModel.equipCA.skillList then
      local skillCa = PlayerData:GetFactoryData(DataModel.equipCA.skillList[1].skillId)
      local strList = string.split(skillCa.description, "\\n")
      local str = table.concat(strList, " ")
      View.Group_Windows.Group_Equipment_Row.Img_Affix.Txt_Affix:SetText(str)
    end
  end
  Controller:RefreshChangeWindows()
  if DataModel.EntryIndex and DataModel.IsMaxAffix == false then
    local Btn_Entry = View.Group_Windows.ScrollGrid_Entry.grid.self:GetElementByIndex(DataModel.EntryIndex - 2)
    if Btn_Entry then
      Btn_Entry = Btn_Entry.Btn_Entry
      Btn_Entry.Img_CannotSelect:SetActive(false)
      Btn_Entry.Img_Select:SetActive(true)
      Btn_Entry.Img_Choose:SetActive(true)
    end
  end
  View.self:PlayAnim("Open_Windows")
end

function Controller:EntryClickSetGrid(elementIndex)
  if tonumber(elementIndex) == DataModel.EntryIndex then
    return
  end
  if tonumber(elementIndex) ~= 1 or DataModel.IsImmobilization == true then
  end
  if DataModel.isSameType == true then
    CommonTips.OpenTips(80601953)
    return
  end
  if DataModel.IsMaxAffix == false and DataModel.EntryIndex then
    CommonTips.OpenTips(80600677)
    return
  end
  if DataModel.EntryIndex then
    local Btn_Entry_Old = View.Group_Windows.ScrollGrid_Entry.grid.self:GetElementByIndex(DataModel.EntryIndex - 2)
    if Btn_Entry_Old then
      Btn_Entry_Old = Btn_Entry_Old.Btn_Entry
      Btn_Entry_Old.Img_Select:SetActive(false)
      Btn_Entry_Old.Img_Choose:SetActive(false)
    end
  end
  local Btn_Entry = View.Group_Windows.ScrollGrid_Entry.grid.self:GetElementByIndex(elementIndex - 2)
  if Btn_Entry ~= nil then
    Btn_Entry = Btn_Entry.Btn_Entry
    if Btn_Entry.Img_CannotSelect.IsActive == false and (table.count(DataModel.server.extra_affix) > 0 or DataModel.EntryIndex) then
      DataModel.EntryIndex = tonumber(elementIndex)
      Btn_Entry.Img_Select:SetActive(true)
      Btn_Entry.Img_Choose:SetActive(true)
    end
  end
  Controller:RefreshBottomEntryButton()
end

function Controller:EntrySetGrid(element, elementIndex)
  local row = DataModel.RandomAffixLits[elementIndex]
  DataModel.EntryAffixList[tonumber(elementIndex)] = {}
  local Btn_Entry = element.Btn_Entry
  Btn_Entry:SetClickParam(elementIndex)
  Btn_Entry.Img_Lock:SetActive(false)
  Btn_Entry.Img_Change:SetActive(false)
  Btn_Entry.Img_CannotSelect:SetActive(false)
  if row then
    local talentCA = PlayerData:GetFactoryData(row.id)
    if row.value > -1 then
      local descriptionShow = string.format(talentCA.description, PlayerData:GetPreciseDecimalFloor(tonumber(row.value * talentCA.CommonNum), talentCA.floatNum))
      Btn_Entry.Txt_Entry:SetText(descriptionShow)
    else
      Btn_Entry.Txt_Entry:SetText(talentCA.description)
    end
    if DataModel.SearchAffixSameList[tonumber(talentCA.id)] == nil then
      DataModel.SearchAffixSameList[tonumber(talentCA.id)] = true
    end
    Btn_Entry.Img_Change:SetActive(true)
    Btn_Entry.Img_Select:SetColor(UIConfig.EntryColor[talentCA.rarityColor])
  else
    Btn_Entry.Txt_Entry:SetText("")
    if not DataModel.EntryIndex or DataModel.IsMaxAffix ~= false then
      Btn_Entry.Img_CannotSelect:SetActive(true)
    end
  end
  if elementIndex == 1 and DataModel.IsImmobilization == true then
    Btn_Entry.Img_Lock:SetActive(true)
    Btn_Entry.Img_Change:SetActive(false)
  elseif DataModel.EntryIndex then
    if DataModel.EntryIndex == tonumber(elementIndex) then
      Btn_Entry.Img_Change:SetActive(true)
    else
      Btn_Entry.Img_CannotSelect:SetActive(row == nil or DataModel.isSameType == true)
      Btn_Entry.Img_Change:SetActive(row ~= nil and DataModel.isSameType == false)
    end
  end
  Btn_Entry.Img_Select:SetActive(false)
  Btn_Entry.Img_Choose:SetActive(false)
  if DataModel.EntryIndex and tonumber(elementIndex) == DataModel.EntryIndex then
    Btn_Entry.Img_Select:SetActive(true)
    Btn_Entry.Img_Choose:SetActive(true)
  end
end

function Controller:RefreshChangeWindows()
  local Group_Windows = View.Group_Windows
  Group_Windows.Txt_RemainingChangeNum:SetText(string.format(GetText(80600576), DataModel.server.rp_num))
  Group_Windows.Group_UseItem.self:SetActive(false)
  Group_Windows.Txt_Tips:SetActive(true)
  Controller:RefreshEntryTop()
  local max = DataModel.Max_Affix_Num
  DataModel.EntryIndex = nil
  DataModel.IsImmobilization = false
  for k, v in pairs(DataModel.server.random_affix) do
    if v.value == -1 then
      DataModel.IsImmobilization = true
      break
    end
  end
  DataModel.RandomAffixLits = {}
  for k, v in pairs(DataModel.server.random_affix) do
    local row = v
    row.index = k
    table.insert(DataModel.RandomAffixLits, row)
  end
  table.sort(DataModel.RandomAffixLits, function(a, b)
    return a.index < b.index
  end)
  DataModel.SearchAffixSameList = {}
  if table.count(DataModel.server.random_affix) == max then
    DataModel.IsMaxAffix = true
  end
  Controller:RefreshBottomEntryButton()
  View.Group_Windows.Group_UseItem.self:SetActive(false)
  View.Group_Windows.Txt_Tips:SetActive(true)
  View.Group_Windows.ScrollGrid_Entry.self:SetActive(true)
  DataModel.EntryAffixList = {}
  Group_Windows.ScrollGrid_Entry.grid.self:SetDataCount(max - 1)
  Group_Windows.ScrollGrid_Entry.grid.self:RefreshAllElement()
  DataModel:GetUseItemData()
  Group_Windows.Btn_UseItem.self:SetActive(table.count(DataModel.UseItemList) ~= 0)
end

function Controller:RefreshEntryTop()
  local Group_Windows = View.Group_Windows
  Group_Windows.Btn_Add.self:SetActive(false)
  Group_Windows.Img_HaveChangeEntry:SetActive(false)
  Group_Windows.Img_NoHaveChangeEntry:SetActive(false)
  Group_Windows.Img_ItemChangeEntry:SetActive(false)
  local Img_HaveChangeEntry = View.Group_Windows.Img_HaveChangeEntry
  if table.count(DataModel.server.extra_affix) > 0 then
    Group_Windows.Img_HaveChangeEntry:SetActive(true)
    Group_Windows.Img_HaveChangeEntry.Btn_Del.self:SetActive(true)
    Img_HaveChangeEntry.Txt_RemainingNum:SetText(string.format(GetText(80600578), DataModel.server.ex_num))
    local talentCA = PlayerData:GetFactoryData(DataModel.server.extra_affix.id)
    if DataModel.server.extra_affix.value > -1 then
      local descriptionShow = string.format(talentCA.description, PlayerData:GetPreciseDecimalFloor(tonumber(DataModel.server.extra_affix.value * talentCA.CommonNum), talentCA.floatNum))
      Img_HaveChangeEntry.Txt_Entry:SetText(descriptionShow)
    else
      Img_HaveChangeEntry.Txt_Entry:SetText(talentCA.description)
    end
    Group_Windows.Img_HaveChangeEntry.Img_Diamond:SetColor(UIConfig.EntryColor[talentCA.rarityColor])
  else
    Group_Windows.Img_NoHaveChangeEntry:SetActive(true)
  end
  Img_HaveChangeEntry.Txt_RemainingNum:SetText(string.format(GetText(80600578), DataModel.server.ex_num))
  if 0 < PlayerData:GetGoodsById(11400217).num and DataModel.server.ex_num == 0 then
    Group_Windows.Btn_Add.self:SetActive(true)
    Group_Windows.Btn_Add.Txt_RemainingNum:SetText(string.format(GetText(80607576), PlayerData:GetGoodsById(11400217).num))
    Img_HaveChangeEntry.Txt_RemainingNum:SetText("")
    Group_Windows.Img_HaveChangeEntry.Btn_Del.self:SetActive(false)
  end
end

function Controller:RefreshUseItemTopPage()
  local Group_Windows = View.Group_Windows
  Group_Windows.Img_ItemChangeEntry:SetActive(true)
  if Group_Windows.Img_NoHaveChangeEntry.IsActive == true then
    Group_Windows.Img_NoHaveChangeEntry:SetActive(false)
  end
  local row = DataModel.UseItemList[tonumber(DataModel.ChooseUseItemIndex)]
  local Img_ItemChangeEntry = Group_Windows.Img_ItemChangeEntry
  local Group_Equipment1 = Img_ItemChangeEntry.Group_Equipment1
  Img_ItemChangeEntry.Txt_ChangeEntryTitle:SetText(row.itemCA.name)
  Img_ItemChangeEntry.Txt_Entry:SetText(row.itemCA.briefText)
  Img_ItemChangeEntry.Txt_RemainingNum:SetText(string.format(GetText(80600578), DataModel.server.ex_num))
  Group_Equipment1.Img_Item:SetSprite(row.itemCA.iconPath)
  Group_Equipment1.Img_Mask:SetSprite(UIConfig.MaskConfig[row.itemCA.qualityInt + 1])
  Group_Equipment1.Img_Bottom:SetSprite(UIConfig.BottomConfig[row.itemCA.qualityInt + 1])
  Group_Equipment1.Txt_EquipmentLevel:SetText(1)
  Group_Equipment1.Img_Select:SetActive(false)
  Group_Equipment1.Btn_Cancel:SetActive(true)
  Group_Equipment1.Group_Face:SetActive(false)
  Group_Equipment1.Img_Choose:SetActive(false)
  Group_Equipment1.Img_Lock:SetActive(false)
  Group_Equipment1.Img_NoType:SetActive(false)
  Group_Windows.Btn_Add.self:SetActive(false)
end

function Controller:RefreshBottomEntryButton()
  local Group_Windows = View.Group_Windows
  DataModel.isSameType = false
  if DataModel.server.extra_affix and table.count(DataModel.server.extra_affix) > 0 then
    local max = DataModel.Max_Affix_Num
    if DataModel.EntryIndex == nil then
      Group_Windows.Btn_Confirm.Img_Use:SetActive(true)
      Group_Windows.Btn_Confirm.Img_Useless:SetActive(false)
      local num = DataModel.IsImmobilization == true and 1 or 0
      num = 1
      DataModel.EntryIndex = table.count(DataModel.server.random_affix) + num
      local count = 0
      for k, v in pairs(DataModel.server.random_affix) do
        if v.id == DataModel.server.extra_affix.id then
          count = tonumber(k) + 1
          break
        end
      end
      if count and 0 < count then
        DataModel.isSameType = true
        DataModel.EntryIndex = count
      end
      if DataModel.server.extra_affix.id and table.count(DataModel.server.random_affix) == 0 then
        DataModel.EntryIndex = 1
      end
    end
  end
  if DataModel.EntryIndex and DataModel.isSameType == false and DataModel.EntryIndex > table.count(DataModel.server.random_affix) and DataModel.IsMaxAffix == true then
    DataModel.EntryIndex = nil
  end
  if table.count(DataModel.server.extra_affix) > 0 and DataModel.EntryIndex ~= nil then
    Group_Windows.Btn_Confirm.Img_Use:SetActive(true)
    Group_Windows.Btn_Confirm.Img_Useless:SetActive(false)
  else
    Group_Windows.Btn_Confirm.Img_Use:SetActive(false)
    Group_Windows.Btn_Confirm.Img_Useless:SetActive(true)
  end
end

function Controller:OneClickPut()
  if DataModel.ConsumeNum == DataModel.Max_Equip_Use_Num then
    CommonTips.OpenTips(80600584)
    return
  end
  if DataModel.server.lv == DataModel.Max_Equip_Lv then
    CommonTips.OpenTips(80608661)
    return
  end
  DataModel:OneClickPutData()
  local Group_Right = View.Group_Right
  Group_Right.Txt_Number:SetText(string.format(GetText(80600540), table.count(DataModel.ChooseLeftDataIndexList), DataModel.Max_Equip_Use_Num))
  Group_Right.Group_Bar.ScrollGrid_Equipment.grid.self:SetDataCount(table.count(DataModel.RightChooseConsumeEquip))
  Group_Right.Group_Bar.ScrollGrid_Equipment.grid.self:RefreshAllElement()
  Group_Right.Group_Bar.ScrollGrid_Equipment.grid.self:MoveToTop()
  View.Group_UseMoney.self:SetActive(false)
  if DataModel.AllGold > 0 then
    View.Group_UseMoney.self:SetActive(true)
    View.Group_UseMoney.Txt_UseMoney:SetText(math.floor(DataModel.AllGold))
  end
  Controller:RefreshAddExpData()
  DataModel:Clear()
  Controller:RefreshRightDownContent()
end

function Controller:SortButton()
  DataModel.SortDown = not DataModel.SortDown
  if table.count(DataModel.AllEquip) == 0 then
    return
  end
  if DataModel.SortDown == true then
    View.Group_Left.Btn_Sort.Img_Down:SetActive(true)
    View.Group_Left.Btn_Sort.Img_Up:SetActive(false)
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
  else
    View.Group_Left.Btn_Sort.Img_Down:SetActive(false)
    View.Group_Left.Btn_Sort.Img_Up:SetActive(true)
    table.sort(DataModel.AllEquip, function(a, b)
      if a.index == b.index then
        if a.equipCA.qualityInt == b.equipCA.qualityInt then
          if a.lv == b.lv then
            return a.equipCA.id > b.equipCA.id
          end
          return a.lv > b.lv
        end
        return a.equipCA.qualityInt < b.equipCA.qualityInt
      end
      return a.index > b.index
    end)
  end
  View.Group_Left.ScrollGrid_Item.grid.self:SetDataCount(table.count(DataModel.AllEquip))
  View.Group_Left.ScrollGrid_Item.grid.self:RefreshAllElement()
end

function Controller:ClickLeftEquipData(str, state)
  local row = DataModel.AllEquip[tonumber(str)]
  
  local function callback()
    if DataModel.LeftChooseEquipIndex ~= nil then
      local old_element = View.Group_Left.ScrollGrid_Item.grid.self:GetElementByIndex(tonumber(DataModel.LeftChooseEquipIndex) - 1)
      if old_element then
        old_element.Group_Equipment1.Img_Select:SetActive(false)
      end
    end
    DataModel.LeftChooseEquipIndex = tonumber(str)
    DataModel.LeftChooseEquipData = DataModel.AllEquip[tonumber(str)]
    local element = View.Group_Left.ScrollGrid_Item.grid.self:GetElementByIndex(tonumber(str) - 1)
    if element then
      element.Group_Equipment1.Img_Select:SetActive(true)
    end
    UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/weapon/Group_Strengthen", "Group_Detail")
    local showState = View.Group_Detail.self.IsActive
    Controller:RefreshCenterContent(row)
    if not showState then
      View.self:PlayAnim("Open_Detail")
    end
    if state == true then
      return
    end
    if row.isItem == true then
      if DataModel.ChooseLeftData[row.eid] ~= nil and row.num == row.maxNum then
        return
      end
    elseif DataModel.ChooseLeftData[row.eid] ~= nil then
      return
    end
    if row.is_locked == 1 then
      if DataModel.ChooseLeftData[row.eid] then
        if element then
          element.Group_Equipment1.Img_Choose:SetActive(false)
          element.Group_Equipment1.Btn_Cancel:SetActive(false)
        end
        table.remove(DataModel.ChooseLeftDataIndexList, DataModel.ChooseLeftData[row.eid].index)
        DataModel.ChooseLeftData[row.eid] = nil
        Controller:RefreshBottomEquipData()
      end
      CommonTips.OpenTips(80600048)
      return
    end
    if tonumber(DataModel.server.lv) == DataModel.Max_Equip_Lv then
      CommonTips.OpenTips(80600584)
      return
    end
    if DataModel.IsMax == true then
      CommonTips.OpenTips(80600523)
      return
    end
    if DataModel.ConsumeNum == DataModel.Max_Equip_Use_Num then
      CommonTips.OpenTips(80600584)
      return
    end
    if DataModel.ChooseLeftData[row.eid] == nil then
      if table.count(DataModel.ChooseLeftData) == DataModel.Max_Equip_Use_Num then
        CommonTips.OpenTips(80600584)
        return
      end
      element.Group_Equipment1.Btn_Cancel:SetActive(true)
      element.Group_Equipment1.Img_Choose:SetActive(true)
      if row.isItem == true and row.num < row.maxNum then
        row.num = row.num + 1
        element.Group_Equipment1.Img_AddNum:SetActive(true)
        element.Group_Equipment1.Img_AddNum.Txt_Num:SetText(row.num)
      end
      local list = {}
      list.lv = row.lv
      list.equipCA = PlayerData:GetFactoryData(row.id)
      list.index = table.count(DataModel.ChooseLeftData) + 1
      list.eid = row.eid
      list.isItem = false
      if row.isItem == true then
        list.num = 1
        list.isItem = true
      end
      list.isOnPut = row.isOnPut
      list.bk_lv = row.bk_lv
      DataModel.ChooseLeftData[row.eid] = list
      table.insert(DataModel.ChooseLeftDataIndexList, list)
      Controller:RefreshBottomEquipData()
      DataModel:Clear()
      Controller:RefreshRightDownContent()
    elseif row.isItem == true and row.num ~= row.maxNum then
      if table.count(DataModel.ChooseLeftData) == DataModel.Max_Equip_Use_Num then
        CommonTips.OpenTips(80600584)
        return
      end
      if element then
        element.Group_Equipment1.Btn_Cancel:SetActive(true)
        element.Group_Equipment1.Img_Choose:SetActive(true)
      end
      row.num = row.num + 1
      if element then
        element.Group_Equipment1.Img_AddNum:SetActive(true)
        element.Group_Equipment1.Img_AddNum.Txt_Num:SetText(row.num)
      end
      local list = {}
      list.lv = row.lv
      list.equipCA = PlayerData:GetFactoryData(row.id)
      list.index = table.count(DataModel.ChooseLeftData) + 1
      list.eid = row.eid
      list.num = DataModel.ChooseLeftData[row.eid].num + 1
      list.isItem = true
      list.bk_lv = row.bk_lv
      DataModel.ChooseLeftData[row.eid] = list
      table.insert(DataModel.ChooseLeftDataIndexList, list)
      Controller:RefreshBottomEquipData()
      DataModel:Clear()
      Controller:RefreshRightDownContent()
    end
    return
  end
  
  if DataModel.LeftChooseEquipData and DataModel.LeftChooseEquipData.isChange and row.is_locked == 0 then
    DataModel:SendEquipLockData(callback)
    return
  elseif DataModel.LeftChooseEquipIndex and tonumber(str) == tonumber(DataModel.LeftChooseEquipIndex) then
    if row.isItem == true and row.num < row.maxNum then
      DataModel:SendEquipLockData(callback)
    end
    return
  end
  DataModel:SendEquipLockData(callback)
end

function Controller:CloseChooseEquip()
  View.self:PlayAnim("Close_List", function()
    View.Group_Left.self:SetActive(false)
    View.Btn_Close:SetActive(false)
  end)
end

function Controller:OpenChooseEquipList(index, state)
  View.Group_Left.self:SetActive(true)
  View.Btn_Close:SetActive(true)
  DataModel.SendLockList = {}
  DataModel.LeftChooseEquipIndex = nil
  DataModel.LeftChooseEquipData = {}
  DataModel.SortDown = true
  View.Group_Left.Btn_Sort.Img_Down:SetActive(true)
  View.Group_Left.Btn_Sort.Img_Up:SetActive(false)
  View.Group_Left.ScrollGrid_Item.grid.self:SetDataCount(table.count(DataModel.AllEquip))
  View.Group_Left.ScrollGrid_Item.grid.self:RefreshAllElement()
  View.Group_Left.ScrollGrid_Item.grid.self:MoveToTop()
  if index then
    View.Group_Left.ScrollGrid_Item.grid.self:MoveToPos(index)
    Controller:ClickLeftEquipData(index, state)
    View.self:PlayAnim("Open_All")
  else
    View.self:PlayAnim("Open_List")
  end
end

function Controller:RefreshRightContent()
  DataModel.IsMax = false
  DataModel.IsMaxLv = false
  View.Btn_Close:SetActive(false)
  Controller:RefreshExpData()
  Controller:InitBottomEquipData()
  Controller:RefreshBottomEquipData()
  View.Group_Right.Group_Money.Txt_MoneyNum:SetText(PlayerData:GetUserInfo().gold)
  View.Img_EquipmentBase.Img_Equipment:SetSprite(DataModel.equipCA.tipsPath)
  DataModel:Clear()
  local Group_Right = View.Group_Right
  Group_Right.self:SetActive(true)
  Group_Right.Img_Quailty:SetSprite(UIConfig.WeaponQuality[DataModel.equipCA.qualityInt + 1])
  Group_Right.Img_Quailty:SetNativeSize()
  Group_Right.Group_Nameandlevel.Txt_EquipmentName:SetText(DataModel.equipCA.name)
  Group_Right.Group_Nameandlevel.Txt_EquipmentLevel:SetText(string.format(GetText(80600474), DataModel.server.lv))
  Group_Right.Group_BreakLv.Txt_EquipmentCharacter:SetText(string.format(GetText(80612235), DataModel.server.bk_lv or 0))
  if DataModel.server.hid == "" then
    Group_Right.Txt_EquipmentCharacter:SetActive(false)
  else
    Group_Right.Txt_EquipmentCharacter:SetActive(true)
    local name = PlayerData:GetFactoryData(DataModel.server.hid).name
    Group_Right.Txt_EquipmentCharacter:SetText(string.format(GetText(80600429), name))
  end
  Group_Right.Img_Property.self:SetActive(false)
  local pro, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp = PlayerData:GetBreakMainAttr(DataModel.equipCA, DataModel.server.lv, 0, DataModel.server.bk_lv or 0)
  Group_Right.Img_Property:SetSprite(pro.icon)
  Group_Right.Img_Property.Txt_Atk:SetText(pro.name .. " <color='#FFB800'>+ " .. PlayerData:GetPreciseDecimalFloor(curNum, 0) .. "</color>")
  Group_Right.Img_Property.self:SetActive(true)
  Controller:RefreshRightDownContent()
  Controller:RefreshSurplus()
end

function Controller:RefreshSurplus()
  View.Group_Right.Txt_Surplus:SetText(string.format(GetText(80600577), DataModel.server.rp_num))
end

function Controller:InitBottomEquipData()
  local Group_Right = View.Group_Right
  DataModel.ConsumeNum = 0
  local choose_equip = 0
  DataModel.Max_Equip_Use_Num = DataModel.Max_Equip_Use_Num or DataModel.EquipFactory.UseNum
  for i = 1, DataModel.Max_Equip_Use_Num do
    local row = {}
    row.eid = ""
    DataModel.RightChooseConsumeEquip[i] = row
  end
  Group_Right.Txt_Number:SetText(string.format(GetText(80600540), choose_equip, DataModel.Max_Equip_Use_Num))
  Group_Right.Group_Bar.ScrollGrid_Equipment.grid.self:SetDataCount(table.count(DataModel.RightChooseConsumeEquip))
  Group_Right.Group_Bar.ScrollGrid_Equipment.grid.self:RefreshAllElement()
end

function Controller:RefreshBottomEquipData()
  DataModel.AllConsumeExp = 0
  DataModel.AllGold = 0
  DataModel.ConsumeNum = 0
  DataModel.IsMax = false
  DataModel.Show_Exp = 0
  local Group_Right = View.Group_Right
  if table.count(DataModel.ChooseLeftDataIndexList) == 0 then
    DataModel.Add_lv = 0
    DataModel.TotalLv = DataModel.server.lv
    DataModel.TotalExp = DataModel.server.exp
  end
  local count = 0
  for i = 1, DataModel.Max_Equip_Use_Num do
    local row = {}
    row.eid = ""
    if DataModel.ChooseLeftDataIndexList[i] and DataModel.IsMax == false then
      count = count + 1
      local equip = DataModel.ChooseLeftDataIndexList[i]
      row.eid = equip.eid
      row.lv = equip.lv
      row.equipCA = equip.equipCA
      DataModel.ChooseLeftData[row.eid] = DataModel.ChooseLeftDataIndexList[i]
      DataModel.ChooseLeftData[row.eid].index = i
      DataModel:CalculateExp(DataModel.ChooseLeftDataIndexList[i])
      DataModel.ConsumeNum = DataModel.ConsumeNum + 1
    end
    DataModel.RightChooseConsumeEquip[i] = row
  end
  Group_Right.Txt_Number:SetText(string.format(GetText(80600540), count, DataModel.Max_Equip_Use_Num))
  Group_Right.Group_Bar.ScrollGrid_Equipment.grid.self:SetDataCount(table.count(DataModel.RightChooseConsumeEquip))
  Group_Right.Group_Bar.ScrollGrid_Equipment.grid.self:RefreshAllElement()
  View.Group_UseMoney.self:SetActive(false)
  if 0 < DataModel.AllGold then
    View.Group_UseMoney.self:SetActive(true)
    View.Group_UseMoney.Txt_UseMoney:SetText(math.floor(DataModel.AllGold))
  end
  Controller:RefreshAddExpData()
end

function Controller:RefreshExpData()
  if DataModel.AniState == true then
    return
  end
  local now_exp = math.floor(DataModel.server.exp)
  DataModel.Add_lv = 0
  DataModel.Show_Exp = now_exp
  DataModel.AllConsumeExp = 0
  DataModel.AllGold = 0
  if tonumber(DataModel.server.lv) == tonumber(DataModel.Max_Equip_Lv) then
    DataModel.IsMaxLv = true
    local Group_Right = View.Group_Right
    Group_Right.Txt_Experienceadd:SetActive(false)
    Group_Right.Txt_Experience:SetActive(false)
    Group_Right.Txt_Experienceall:SetText("<color=#FFFFFF>" .. "MAX" .. "</color>")
    Group_Right.Img_ExperienceLine:SetFilledImgAmount(1)
    Group_Right.Img_ExperienceAdd:SetFilledImgAmount(1)
  else
    local max_exp = DataModel.EquipExpList[DataModel.equipCA.qualityInt + 1][DataModel.server.lv].levelUpExp * DataModel.JewelryEx
    local Group_Right = View.Group_Right
    Group_Right.Txt_Experience:SetActive(false)
    Group_Right.Txt_Experienceall:SetText("<color=#FFFFFF>" .. now_exp .. "</color>" .. "/" .. max_exp)
    Group_Right.Img_ExperienceLine:SetFilledImgAmount(now_exp / max_exp)
    Group_Right.Img_ExperienceAdd:SetFilledImgAmount(0)
  end
  Controller:RefreshAddExpData()
end

function Controller:RefreshAddExpData()
  local Group_Right = View.Group_Right
  Group_Right.Txt_EquipmentLeveladd:SetActive(false)
  Group_Right.Img_Property.Txt_AtkAdd:SetActive(false)
  Group_Right.Txt_Experienceadd:SetActive(false)
  local now_exp = DataModel.server.exp
  local now_lv = DataModel.server.lv
  local equipExpList = DataModel.EquipExpList[DataModel.equipCA.qualityInt + 1]
  if equipExpList[now_lv] == nil then
    return
  end
  local now_exp_max = equipExpList[now_lv].levelUpExp * DataModel.JewelryEx
  now_exp_max = math.floor(now_exp_max)
  if DataModel.Add_lv ~= 0 then
    Group_Right.Txt_EquipmentLeveladd:SetActive(true)
    Group_Right.Txt_EquipmentLeveladd:SetText("+" .. DataModel.Add_lv)
    local now_pro, lastNum1, curNum1, extraAttr1, lastAttr1, extraLv1, lastLv1, extraSkill1, lastSkill1, mainSkillUp1 = PlayerData:GetBreakMainAttr(DataModel.equipCA, now_lv, 0, DataModel.server.bk_lv or 0)
    local before_pro, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp = PlayerData:GetBreakMainAttr(DataModel.equipCA, DataModel.server.lv + DataModel.Add_lv, 0, DataModel.server.bk_lv or 0)
    local diff = curNum - curNum1
    if 0 < diff then
      Group_Right.Img_Property.Txt_AtkAdd:SetActive(true)
      Group_Right.Img_Property.Txt_AtkAdd:SetText("+" .. PlayerData:GetPreciseDecimalFloor(diff, 0))
    end
  end
  if DataModel.IsMaxLv == false then
    if DataModel.AllConsumeExp ~= 0 then
      local exp_string = "<color=#FFFFFF>" .. math.floor(now_exp) .. "</color>"
      local add_exp_string = "<color=#FFB800>" .. "+" .. math.floor(DataModel.AllConsumeExp) .. "</color>"
      Group_Right.Txt_Experienceall:SetText(exp_string .. add_exp_string .. "/" .. now_exp_max)
    else
      local exp_string = "<color=#FFFFFF>" .. math.floor(now_exp) .. "</color>"
      Group_Right.Txt_Experienceall:SetText(exp_string .. "/" .. now_exp_max)
    end
  else
    Group_Right.Txt_Experienceall:SetText("<color=#FFFFFF>" .. "MAX" .. "</color>")
  end
  if DataModel.Add_lv > 0 then
    Group_Right.Img_ExperienceAdd:SetFilledImgAmount(1)
  end
  if DataModel.Add_lv == 0 then
    DataModel.Show_Exp = DataModel.Show_Exp + math.floor(DataModel.server.exp)
    local max_exp = DataModel.EquipExpList[DataModel.equipCA.qualityInt + 1][DataModel.server.lv].levelUpExp * DataModel.JewelryEx
    Group_Right.Img_ExperienceAdd:SetFilledImgAmount(DataModel.Show_Exp / max_exp)
  end
end

function Controller:RefreshCenterContent(row)
  Clear_Center()
  UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/weapon/Group_Strengthen", "Group_Detail", true)
  local Group_Detail = View.Group_Detail
  Group_Detail.self:SetActive(true)
  Group_Detail.Img_Quailty:SetSprite(UIConfig.WeaponQuality[DataModel.LeftChooseEquipData.equipCA.qualityInt + 1])
  Group_Detail.Img_Quailty:SetNativeSize()
  Group_Detail.Txt_EquipmentName:SetText("")
  Group_Detail.Group_EXPEquip.Group_NameLevel.Txt_EquipmentName:SetText(DataModel.LeftChooseEquipData.equipCA.name)
  Group_Detail.Group_EXPEquip.Group_NameLevel.Txt_EquipmentLevel:SetText(string.format(GetText(80600474), DataModel.LeftChooseEquipData.lv))
  Group_Detail.Group_EXPEquip.self:SetActive(false)
  Group_Detail.Group_EXPItem.self:SetActive(false)
  if row.isItem == true then
    Group_Detail.Group_EXPItem.self:SetActive(true)
    Group_Detail.Group_EXPEquip.Txt_EquipmentCharacter:SetActive(false)
    Group_Detail.Group_EXPItem.Txt_Detail:SetText(row.equipCA.des)
    Group_Detail.Group_EXPItem.Txt_Num:SetText(PlayerData:GetGoodsById(row.id).num)
    Group_Detail.Group_EXPItem.Txt_ItemName:SetText(DataModel.LeftChooseEquipData.equipCA.name)
    Group_Detail.Group_EXPItem.Group_EXPNum.Txt_EXP:SetText(row.equipCA.Experiencevalue)
    Group_Detail.Group_BreakLv.self:SetActive(false)
  else
    Group_Detail.Group_EXPEquip.self:SetActive(true)
    if DataModel.LeftChooseEquipData.hid == "" then
      Group_Detail.Group_EXPEquip.Txt_EquipmentCharacter:SetActive(false)
    else
      Group_Detail.Group_EXPEquip.Txt_EquipmentCharacter:SetActive(true)
      local name = PlayerData:GetFactoryData(DataModel.LeftChooseEquipData.hid).name
      Group_Detail.Group_EXPEquip.Txt_EquipmentCharacter:SetText(string.format(GetText(80600429), name))
    end
    Group_Detail.Group_EXPEquip.Btn_Lock.Img_Lock:SetActive(false)
    Group_Detail.Group_EXPEquip.Btn_Lock.Img_Unlock:SetActive(false)
    if DataModel.SendLockList[DataModel.LeftChooseEquipData.eid] == nil then
      local row = {}
      row.is_locked = DataModel.LeftChooseEquipData.is_locked
      row.isChange = 0
      row.old_locked = DataModel.LeftChooseEquipData.is_locked
      DataModel.SendLockList[DataModel.LeftChooseEquipData.eid] = row
    end
    if DataModel.SendLockList[DataModel.LeftChooseEquipData.eid].is_locked == 1 then
      Group_Detail.Group_EXPEquip.Btn_Lock.Img_Lock:SetActive(true)
    else
      Group_Detail.Group_EXPEquip.Btn_Lock.Img_Unlock:SetActive(true)
    end
    Group_Detail.Group_EXPEquip.Img_Property.self:SetActive(false)
    local pro, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp = PlayerData:GetBreakMainAttr(DataModel.LeftChooseEquipData.equipCA, DataModel.LeftChooseEquipData.lv, 0, DataModel.LeftChooseEquipData.bk_lv or 0)
    Group_Detail.Group_EXPEquip.Img_Property:SetSprite(pro.icon)
    Group_Detail.Group_EXPEquip.Img_Property.Txt_Atk:SetText(pro.name .. " <color='#FFB800'>+ " .. PlayerData:GetPreciseDecimalFloor(curNum, 0) .. "</color>")
    Group_Detail.Group_EXPEquip.Img_Property.self:SetActive(true)
    Controller:RefreshCenterDownContent(math.floor(extraSkill))
    Group_Detail.Group_BreakLv.self:SetActive(true)
    Group_Detail.Group_BreakLv.Txt_EquipmentCharacter:SetText(string.format(GetText(80612235), DataModel.LeftChooseEquipData.bk_lv or 0))
  end
end

local affix_bg_height = 47
local baseDesHight = 24

local function SetCenterDownAffix(obj, row, index)
  obj.transform:Find("Txt_Entry_1").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.descriptionShow)
  obj.transform:Find("Img_").transform:GetComponent(typeof(CS.Seven.UIImg)):SetColor(UIConfig.EntryColor[row.rarityColor])
  local hight_des = obj.transform:Find("Txt_Entry_1").transform:GetComponent(typeof(CS.Seven.UITxt)):GetHeight()
  local Hight = 0
  if hight_des > baseDesHight then
    Hight = hight_des - baseDesHight
  end
  return Hight
end

local function SetCenterDownAllAffix(Content, AffixList)
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
  local Group_Entry_Detail = "UI/CharacterInfo/weapon/Group_Entry_Detail"
  space = top_des_height
  DataModel.AffixList_Center = {}
  local random_affix = AffixList
  local affix_list = {}
  for k, v in pairs(random_affix) do
    local row = v
    row.index = k
    table.insert(affix_list, row)
  end
  table.sort(affix_list, function(a, b)
    return a.index < b.index
  end)
  if 0 < table.count(affix_list) then
    for i = 1, table.count(affix_list) do
      local talentCA = {}
      talentCA = PlayerData:GetFactoryData(affix_list[i].id)
      if affix_list[i].value > -1 then
        talentCA.descriptionShow = string.format(talentCA.description, PlayerData:GetPreciseDecimalFloor(tonumber(affix_list[i].value * talentCA.CommonNum), talentCA.floatNum))
      else
        talentCA.descriptionShow = talentCA.description
      end
      local obj = View.self:GetRes(Group_Entry_Detail, Parent.transform)
      local name = obj.name
      local hight = obj.transform.sizeDelta.y
      local lastPosY = obj.transform.localPosition.y
      local lastPosX = obj.transform.localPosition.x
      local offest = 0
      hight = affix_bg_height
      if count ~= 1 then
        lastY = lastY - hight + offest - lastY_1_Bg
      else
        lastY = lastY_1
      end
      obj.name = name .. "_" .. count
      obj.transform.localPosition = Vector3(lastPosX, lastY, 0)
      obj:SetActive(true)
      table.insert(DataModel.AffixList_Center, obj)
      local hight_des = SetCenterDownAffix(obj, talentCA, count)
      lastY_1_Bg = hight_des
      space = space + hight_des + hight
      count = count + 1
      if baseViewSpace < space then
        View.Group_Detail.Group_EXPEquip.ScrollView_Content:SetContentHeight(space)
      end
    end
  end
end

function Controller:RefreshCenterDownContent(extraAffix)
  local max = PlayerData:GetFactoryData(DataModel.LeftChooseEquipData.equipCA.equipTagId).typeName + (extraAffix or 0)
  local ScrollView_Content = View.Group_Detail.Group_EXPEquip.ScrollView_Content
  ScrollView_Content.Viewport.Content.Txt_EntryNumber:SetText(string.format(GetText(80600501), table.count(DataModel.LeftChooseEquipData.random_affix), max))
  SetCenterDownAllAffix(ScrollView_Content.Viewport.Content, DataModel.LeftChooseEquipData.random_affix)
end

local function SetDownAffix(obj, row, index)
  obj.transform:Find("Txt_Entry_1").transform:GetComponent(typeof(CS.Seven.UITxt)):SetText(row.descriptionShow)
  if row.isTxt then
    obj.transform:Find("Img_").transform:GetComponent(typeof(CS.Seven.UIImg)):SetColor(UIConfig.Color.Orange)
  else
    obj.transform:Find("Img_").transform:GetComponent(typeof(CS.Seven.UIImg)):SetColor(UIConfig.EntryColor[row.rarityColor])
  end
  local hight_des = obj.transform:Find("Txt_Entry_1").transform:GetComponent(typeof(CS.Seven.UITxt)):GetHeight()
  local Hight = 0
  if hight_des > baseDesHight then
    Hight = hight_des - baseDesHight
  end
  return Hight
end

local function SetDownAllAffix(Content, AffixList)
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
  local Group_Entry = "UI/CharacterInfo/weapon/Group_Entry"
  space = top_des_height
  DataModel.AffixList = {}
  local random_affix = AffixList
  local affix_list = {}
  for k, v in pairs(random_affix) do
    local row = v
    row.index = k
    table.insert(affix_list, row)
  end
  table.sort(affix_list, function(a, b)
    return a.index < b.index
  end)
  local max_affix_num = DataModel.Max_Affix_Num
  local isRegular = false
  local regularCount = 0
  for k, v in pairs(random_affix) do
    if v.value == -1 then
      isRegular = true
      regularCount = regularCount + 1
    end
  end
  local now_affix_num = table.count(random_affix)
  local streng_lv = DataModel.server.lv + DataModel.Add_lv
  local LevelNum = DataModel.EquipFactory.LevelNum
  local unLock_num = math.floor(streng_lv / LevelNum) - math.floor(DataModel.server.lv / LevelNum) + now_affix_num
  local residue_affix_num
  if max_affix_num > unLock_num then
    residue_affix_num = unLock_num - now_affix_num
  else
    residue_affix_num = max_affix_num - now_affix_num
  end
  local isFirst = false
  if 0 < residue_affix_num then
    local row = {}
    row.txt = string.format(GetText(80600770), residue_affix_num)
    row.index = 1
    row.num = residue_affix_num
    table.insert(affix_list, 1, row)
    isFirst = true
  end
  local residue_replace_num
  local diffNum = math.floor(streng_lv / LevelNum) - math.floor(DataModel.server.lv / LevelNum)
  if max_affix_num < unLock_num and now_affix_num < unLock_num and 0 < DataModel.Add_lv and 1 <= diffNum then
    residue_replace_num = unLock_num - math.max(max_affix_num, now_affix_num)
    local row = {}
    row.txt = string.format(GetText(80600771), residue_replace_num)
    row.index = 2
    row.num = residue_replace_num
    if isFirst == true then
      table.insert(affix_list, 2, row)
    else
      table.insert(affix_list, 1, row)
    end
  end
  DataModel.Add_Right_Content = {}
  if 0 < table.count(affix_list) then
    for i = 1, table.count(affix_list) do
      local talentCA = {}
      if affix_list[i].id then
        talentCA = PlayerData:GetFactoryData(affix_list[i].id)
        if affix_list[i].value > -1 then
          talentCA.descriptionShow = string.format(talentCA.description, PlayerData:GetPreciseDecimalFloor(tonumber(affix_list[i].value * talentCA.CommonNum), talentCA.floatNum))
        else
          talentCA.descriptionShow = talentCA.description
        end
      else
        local _r = affix_list[i]
        table.insert(DataModel.Add_Right_Content, {
          id = _r.id,
          text = _r.txt,
          index = _r.index,
          num = _r.num
        })
        talentCA.descriptionShow = affix_list[i].txt
        talentCA.isTxt = true
      end
      local obj = View.self:GetRes(Group_Entry, Parent.transform)
      local name = obj.name
      local hight = obj.transform.sizeDelta.y
      local lastPosY = obj.transform.localPosition.y
      local lastPosX = obj.transform.localPosition.x
      local offest = 0
      hight = affix_bg_height
      if count ~= 1 then
        lastY = lastY - hight + offest - lastY_1_Bg
      else
        lastY = lastY_1
      end
      obj.name = name .. "_" .. count
      obj.transform.localPosition = Vector3(lastPosX, lastY, 0)
      obj:SetActive(true)
      table.insert(DataModel.AffixList, obj)
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

function Controller:RefreshRightDownContent(Group)
  local max = DataModel.Max_Affix_Num
  local ScrollView_Content = View.Group_Right.ScrollView_Content
  ScrollView_Content.Viewport.Content.Txt_EntryNumber:SetText(string.format(GetText(80600501), table.count(DataModel.server.random_affix), max))
  SetDownAllAffix(ScrollView_Content.Viewport.Content, DataModel.server.random_affix)
end

local function UpdateSortRare()
  View.Group_SortRare.Img_Glass.Img_Bg.StaticGrid_Rare.grid.self:SetDataCount(table.count(DataModel.BtnList))
  View.Group_SortRare.Img_Glass.Img_Bg.StaticGrid_Rare.grid.self:RefreshAllElement()
  Controller:SelectBtnList(PlayerData:GetPlayerPrefs("int", "EquipType") == 0 and DataModel.DefaultRightBtnListIndex or PlayerData:GetPlayerPrefs("int", "EquipType"))
end

local function UpdateEquipUseNum()
  View.Group_Numbtn.Img_Glass.Img_Bg.StaticGrid_Arrow.grid.self:SetDataCount(table.count(DataModel.EquipUseNumList))
  View.Group_Numbtn.Img_Glass.Img_Bg.StaticGrid_Arrow.grid.self:RefreshAllElement()
  Controller:SelectEquipUseBtnList(PlayerData:GetPlayerPrefs("int", "EquipUseNumMax") == 0 and DataModel.DefaultEquipUseNumListIndex or PlayerData:GetPlayerPrefs("int", "EquipUseNumMax"))
end

function Controller:ClickRightBtn()
  if View.Group_SortRare.self.IsActive == true then
    View.Group_SortRare.self:SetActive(false)
    View.Group_SortRare.self:SelectPlayAnim("Out_SortRare")
    View.Group_Right.Btn_List.Img_Arrow.transform.localRotation = Quaternion.Euler(0, 0, 90)
  else
    UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/weapon/Group_Strengthen", "Group_SortRare")
    View.Group_SortRare.self:SetActive(true)
    View.Btn_CloseTips:SetActive(true)
    View.Group_SortRare.self:SelectPlayAnim("In_SortRare")
    UpdateSortRare()
    View.Group_Right.Btn_List.Img_Arrow.transform.localRotation = Quaternion.Euler(0, 0, 0)
  end
end

function Controller:ClickRightEquipUseBtn()
  if View.Group_Numbtn.self.IsActive == true then
    View.Group_Numbtn.self:SetActive(false)
    View.Group_Right.Btn_Num.Img_Arrow.transform.localRotation = Quaternion.Euler(0, 0, 90)
    if DataModel.EquipUseBtnListLatsIndex ~= DataModel.EquipUseBtnListIndex then
      Controller:InitEquip()
      Controller:RefreshRightContent()
    end
    DataModel.EquipUseBtnListLatsIndex = nil
  else
    UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/weapon/Group_Strengthen", "Group_Numbtn")
    View.Group_Numbtn.self:SetActive(true)
    View.Btn_CloseTips:SetActive(true)
    UpdateEquipUseNum()
    View.Group_Right.Btn_Num.Img_Arrow.transform.localRotation = Quaternion.Euler(0, 0, 0)
  end
end

return Controller
