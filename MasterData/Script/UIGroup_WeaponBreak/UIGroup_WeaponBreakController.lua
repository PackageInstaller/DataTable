local View = require("UIGroup_WeaponBreak/UIGroup_WeaponBreakView")
local DataModel = require("UIGroup_WeaponBreak/UIGroup_WeaponBreakDataModel")
local Controller = {}

function Controller:Init(param)
  DataModel:Init(param)
  DataModel:InitEquipList()
  View.Group_Right.Group_ExperienceBar:SetActive(false)
  View.Group_EquipmentBase.Img_Equipment:SetSprite(DataModel.equipCA.tipsPath)
  View.Group_Right.Group_Nameandlevel.Txt_EquipmentName:SetText(DataModel.equipCA.name)
  View.Group_Right.Img_Quailty:SetSprite(UIConfig.WeaponQuality[DataModel.equipCA.qualityInt + 1])
  local hCA = PlayerData:GetFactoryData(DataModel.server.hid)
  if hCA then
    View.Group_Right.Txt_EquipmentCharacter:SetActive(true)
    View.Group_Right.Txt_EquipmentCharacter:SetText(string.format(GetText(80600429), hCA.name))
  else
    View.Group_Right.Txt_EquipmentCharacter:SetActive(false)
  end
  View.Group_Right.Img_Quailty:SetNativeSize()
  View.Group_Right.Group_Nameandlevel.Txt_EquipmentLevel:SetText(string.format(GetText(80600474), DataModel.server.lv))
  View.Group_Left:SetActive(false)
  local weaponBreakEffect
  if DataModel.equipCA.quality == "Orange" then
    weaponBreakEffect = DataModel.equipConfig.URWeaponBreakCost
  elseif DataModel.equipCA.quality == "Golden" then
    weaponBreakEffect = DataModel.equipConfig.SSRWeaponBreakCost
  elseif DataModel.equipCA.quality == "Purple" then
    weaponBreakEffect = DataModel.equipConfig.SRWeaponBreakCost
  elseif DataModel.equipCA.quality == "Blue" then
    weaponBreakEffect = DataModel.equipConfig.RWeaponBreakCost
  end
  DataModel.WeaponBreakEffect = weaponBreakEffect
  Controller:UpdateView()
end

function Controller:UpdateView()
  View.Group_TopBar.Group_Money.Txt_MoneyNum:SetText(PlayerData:GetGoodsById(11400001).num)
  local curBreak = self:GetCurBreakLv()
  DataModel.curNumIndex = curBreak
  Controller:RefreshRight()
  Controller:InitBottomEquipData()
  local equipConfig = DataModel.equipConfig
  local group = View.Group_EquipmentBase
  local grid = group.Page_LvBreak.grid.self
  grid:SetDataCount(#DataModel.WeaponBreakEffect)
  grid:RefreshAllElement()
  local gridHide = group.Page_LvBreakHide.grid.self
  gridHide:SetDataCount(#DataModel.WeaponBreakEffect)
  gridHide:RefreshAllElement()
  gridHide:LocatElementImmediate(math.min(curBreak, #DataModel.WeaponBreakEffect - 1))
end

function Controller:RefreshRight()
  local equipConfig = DataModel.equipConfig
  local curBreak = DataModel.curNumIndex
  local bkLv = self:GetCurBreakLv()
  local pro, lastNum, curNum, extraAttr, lastAttr, extraLv, lastLv, extraSkill, lastSkill, mainSkillUp = PlayerData:GetBreakMainAttr(DataModel.equipCA, DataModel.server.lv, bkLv, curBreak + 1)
  View.Group_Right.Group_MaxLvUp.Txt_LvNum:SetText(equipConfig.equipMaxLv + extraLv)
  local content = View.Group_Right.ScrollView_Content.Viewport.Content.Group_Entry
  local count = content.self.transform.childCount
  for i = 0, count - 1 do
    content.self.transform:GetChild(i):GetComponent(typeof(CS.Seven.UITxt)):SetActive(false)
  end
  if bkLv < curBreak + 1 then
    if lastAttr < extraAttr then
      local str = ""
      for i = 1, #DataModel.WeaponBreakEffect do
        if DataModel.WeaponBreakEffect[i].effect == "MainAttrUp" then
          str = GetText(DataModel.WeaponBreakEffect[i].effectDes)
          break
        end
      end
      content.self.transform:GetChild(0):GetComponent(typeof(CS.Seven.UITxt)):SetActive(true)
      content.self.transform:GetChild(1):GetComponent(typeof(CS.Seven.UITxt)):SetActive(true)
      str = string.format(str, PlayerData:GetPreciseDecimalFloor(extraAttr * 100))
      content.self.transform:GetChild(0):GetComponent(typeof(CS.Seven.UITxt)):SetText(str)
      local attrStr = GetText(80612190)
      attrStr = string.format(attrStr, pro.name, lastNum, pro.name, curNum)
      content.self.transform:GetChild(1):GetComponent(typeof(CS.Seven.UITxt)):SetText(attrStr)
    end
    if lastSkill < extraSkill then
      local str = ""
      for i = 1, #DataModel.WeaponBreakEffect do
        if DataModel.WeaponBreakEffect[i].effect == "AddRandomSkill" then
          str = GetText(DataModel.WeaponBreakEffect[i].effectDes)
          break
        end
      end
      content.self.transform:GetChild(2):GetComponent(typeof(CS.Seven.UITxt)):SetActive(true)
      str = string.format(str, PlayerData:GetPreciseDecimalFloor(extraSkill))
      content.self.transform:GetChild(2):GetComponent(typeof(CS.Seven.UITxt)):SetText(str)
    end
    if mainSkillUp then
      content.self.transform:GetChild(3):GetComponent(typeof(CS.Seven.UITxt)):SetActive(true)
      content.self.transform:GetChild(4):GetComponent(typeof(CS.Seven.UITxt)):SetActive(true)
      local skillCA = PlayerData:GetFactoryData(DataModel.equipCA.skillList[1].skillId)
      content.self.transform:GetChild(4):GetComponent(typeof(CS.Seven.UITxt)):SetText(skillCA.levelUpDescription)
    end
  end
  local _, needLv, needEquip, needMoney, materialId, needMaterial = Controller:CanBreak(curBreak + 1)
  DataModel.Max_Equip_Use_Num = needEquip
  DataModel.Need_Money_Num = needMoney
  View.Group_Right.Group_Require.Group_RequireLeft.Txt_UseMoney:SetText(needLv)
  View.Group_Right.Group_Require.Group_RequireRight.Txt_UseMoney:SetText(DataModel.Need_Money_Num)
  View.Group_Right.Group_Bar.Txt_CostItemRequireNum:SetText(DataModel.Max_Equip_Use_Num)
  View.Group_Right.Group_RequireMiddle:SetActive(0 < materialId)
  if 0 < materialId then
    View.Group_Right.Group_Bar:SetWidth(730)
    View.Group_Right.Group_Bar.ScrollGrid_Equipment.self:SetWidth(600)
    View.Group_Right.Group_RequireMiddle.Txt_LvRequire:SetText(PlayerData:GetGoodsById(materialId).num .. "/" .. needMaterial)
    View.Group_Right.Group_RequireMiddle.Group_Mat.Btn_Item:SetClickParam(materialId)
  else
    View.Group_Right.Group_Bar:SetWidth(900)
    View.Group_Right.Group_Bar.ScrollGrid_Equipment.self:SetWidth(770)
  end
  Controller:RefreshBottomEquipData()
end

function Controller:OpenLeft(index, state)
  DataModel.SendLockList = {}
  DataModel:RefreshFilterEquipList()
  View.Btn_Close:SetActive(true)
  View.Group_Left.self:SetActive(true)
  DataModel.LeftChooseEquipIndex = nil
  DataModel.LeftChooseEquipData = {}
  View.Group_Left.ScrollGrid_Item.grid.self:SetDataCount(#DataModel.AllEquip)
  View.Group_Left.ScrollGrid_Item.grid.self:RefreshAllElement()
  if index then
    Controller:ClickLeftEquipData(index, state)
  end
end

function Controller:CloseLeft()
  View.Btn_Close:SetActive(false)
  View.self:SelectPlayAnim(View.Group_Left.self, "Group_Left_Hide", function()
    View.Group_Left.self:SetActive(false)
  end)
end

function Controller:OnSetItemGrid(element, elementIndex)
  local row = DataModel.AllEquip[tonumber(elementIndex)]
  local Group_Equipment1 = element.Group_Equipment1
  Group_Equipment1.Btn_Item:SetClickParam(elementIndex)
  Group_Equipment1.Btn_Cancel:SetClickParam(elementIndex)
  Group_Equipment1.Img_Item:SetSprite(row.equipCA.iconPath)
  Group_Equipment1.Img_Mask:SetSprite(UIConfig.MaskConfig[row.equipCA.qualityInt + 1])
  Group_Equipment1.Img_Bottom:SetSprite(UIConfig.BottomConfig[row.equipCA.qualityInt + 1])
  Group_Equipment1.Txt_EquipmentLevel:SetText(string.format(GetText(80600474), row.lv))
  Group_Equipment1.Img_Select:SetActive(false)
  Group_Equipment1.Btn_Cancel:SetActive(false)
  Group_Equipment1.Group_Face:SetActive(false)
  Group_Equipment1.Img_Choose:SetActive(false)
  Group_Equipment1.Img_Lock:SetActive(false)
  Group_Equipment1.Img_AddNum:SetActive(false)
  Group_Equipment1.Txt_Num:SetActive(false)
  if row.maxNum then
    Group_Equipment1.Txt_Num:SetActive(true)
    Group_Equipment1.Txt_Num:SetText(row.maxNum)
  end
  if row.isItem == true then
    if row.num > 0 then
      Group_Equipment1.Img_AddNum:SetActive(true)
      Group_Equipment1.Img_AddNum.Txt_Num:SetText(row.num)
    end
    Group_Equipment1.Txt_EquipmentLevel:SetText("")
  end
  if row.is_locked == 1 then
    Group_Equipment1.Img_Lock:SetActive(true)
  end
  Group_Equipment1.Img_NoType:SetActive(false)
  if DataModel.ChooseLeftData[row.eid] then
    Group_Equipment1.Btn_Cancel:SetActive(true)
  end
  element.Group_Equipment1.Img_Select:SetActive(elementIndex == DataModel.LeftChooseEquipIndex)
  if not DataModel.LeftChooseEquipData.eid or DataModel.LeftChooseEquipData.eid == row.eid then
  end
  row.element = element
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
    if DataModel.IsMax == true then
      CommonTips.OpenTips(80600523)
      return
    end
    if DataModel.ChooseLeftData[row.eid] == nil then
      if table.count(DataModel.ChooseLeftData) >= DataModel.Max_Equip_Use_Num then
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
      Controller:RefreshRightDownContent()
      View.Group_Left.ScrollGrid_Item.grid.self:RefreshAllElement()
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
      DataModel.ChooseLeftData[row.eid] = list
      table.insert(DataModel.ChooseLeftDataIndexList, list)
      Controller:RefreshBottomEquipData()
      Controller:RefreshRightDownContent()
      View.Group_Left.ScrollGrid_Item.grid.self:RefreshAllElement()
    end
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

function Controller:OnClickCancelEquip(str)
  local row = DataModel.AllEquip[tonumber(str)]
  if DataModel.ChooseLeftData[row.eid] then
    if row.isItem == true and row.num > 1 then
      row.num = row.num - 1
      row.element.Group_Equipment1.Img_AddNum:SetActive(true)
      row.element.Group_Equipment1.Img_AddNum.Txt_Num:SetText(row.num)
      table.remove(DataModel.ChooseLeftDataIndexList, DataModel.ChooseLeftData[row.eid].index)
      Controller:RefreshBottomEquipData()
      Controller:RefreshRightDownContent()
    else
      row.element.Group_Equipment1.Img_Choose:SetActive(false)
      row.element.Group_Equipment1.Btn_Cancel:SetActive(false)
      row.element.Group_Equipment1.Img_AddNum:SetActive(false)
      if row.isItem == true then
        row.num = 0
      end
      table.remove(DataModel.ChooseLeftDataIndexList, DataModel.ChooseLeftData[row.eid].index)
      DataModel.ChooseLeftData[row.eid] = nil
      if DataModel.LeftChooseEquipIndex ~= nil then
        local old_element = DataModel.AllEquip[DataModel.LeftChooseEquipIndex].element
        old_element.Group_Equipment1.Img_Select:SetActive(false)
        DataModel.LeftChooseEquipIndex = nil
      end
      
      local function callback()
        View.self:SelectPlayAnim(View.Group_Detail.self, "Group_Detail_Hide", function()
          View.Group_Detail:SetActive(false)
        end)
      end
      
      DataModel:SendEquipLockData(callback)
      Controller:RefreshBottomEquipData()
      Controller:RefreshRightDownContent()
    end
  end
end

function Controller:RefreshRightDownContent()
  View.Group_Left.ScrollGrid_Item.grid.self:RefreshAllElement()
end

function Controller:InitBottomEquipData()
  DataModel.RightChooseConsumeEquip = {}
  local Group_Right = View.Group_Right
  DataModel.ConsumeNum = 0
  for i = 1, DataModel.Max_Equip_Use_Num do
    local row = {}
    row.eid = ""
    DataModel.RightChooseConsumeEquip[i] = row
  end
  View.Group_Right.Group_Bar.Txt_CostItemNum:SetText(0)
  Group_Right.Group_Bar.ScrollGrid_Equipment.grid.self:SetDataCount(DataModel.Max_Equip_Use_Num)
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
      DataModel.ConsumeNum = DataModel.ConsumeNum + 1
    end
    DataModel.RightChooseConsumeEquip[i] = row
  end
  for i = #DataModel.ChooseLeftDataIndexList, DataModel.Max_Equip_Use_Num + 1, -1 do
    local row = DataModel.ChooseLeftDataIndexList[i]
    DataModel.ChooseLeftData[row.eid] = nil
    table.remove(DataModel.ChooseLeftDataIndexList, i)
  end
  View.Group_Right.Group_Bar.Txt_CostItemNum:SetText(table.count(DataModel.ChooseLeftDataIndexList))
  Group_Right.Group_Bar.ScrollGrid_Equipment.grid.self:SetDataCount(DataModel.Max_Equip_Use_Num)
  Group_Right.Group_Bar.ScrollGrid_Equipment.grid.self:RefreshAllElement()
  Group_Right.Group_Bar.ScrollGrid_Equipment.grid.self:MoveToTop()
end

function Controller:OnSetCostEquipGrid(element, elementIndex)
  local row = DataModel.RightChooseConsumeEquip[tonumber(elementIndex)]
  element.Btn_add:SetActive(true)
  element.Btn_add:SetClickParam(elementIndex)
  element.Group_Equipment:SetActive(true)
  if row.eid == "" then
    element.Group_Equipment:SetActive(false)
  else
    local equip_data = DataModel.ChooseLeftDataIndexList[tonumber(elementIndex)]
    local Group_Equipment = element.Group_Equipment
    Group_Equipment.Btn_Item:SetClickParam(elementIndex)
    Group_Equipment.Img_Item:SetSprite(equip_data.equipCA.iconPath)
    Group_Equipment.Img_Mask:SetSprite(UIConfig.MaskConfig[equip_data.equipCA.qualityInt + 1])
    Group_Equipment.Img_Bottom:SetSprite(UIConfig.BottomConfig[equip_data.equipCA.qualityInt + 1])
    Group_Equipment.Txt_EquipmentLevel:SetText(string.format(GetText(80600474), equip_data.lv))
    Group_Equipment.Img_Select:SetActive(false)
    Group_Equipment.Group_Face:SetActive(false)
    Group_Equipment.Img_Lock:SetActive(false)
    if row.is_locked == 1 then
      Group_Equipment.Img_Lock:SetActive(true)
    end
    Group_Equipment.Img_NoType:SetActive(false)
    if DataManager:GetFactoryNameById(row.eid) == "SourceMaterialFactory" then
      Group_Equipment.Txt_EquipmentLevel:SetText("")
    end
  end
end

function Controller:GetCurBreakLv()
  return DataModel.server.bk_lv or 0
end

function Controller:CanBreak(lv)
  lv = math.min(lv, #DataModel.WeaponBreakEffect)
  local equipConfig = DataModel.equipConfig
  local curBreak = self:GetCurBreakLv()
  local moneyCost
  if DataModel.equipCA.quality == "Orange" then
    moneyCost = equipConfig.URWeaponBreakCost
  elseif DataModel.equipCA.quality == "Golden" then
    moneyCost = equipConfig.SSRWeaponBreakCost
  elseif DataModel.equipCA.quality == "Purple" then
    moneyCost = equipConfig.SRWeaponBreakCost
  elseif DataModel.equipCA.quality == "Blue" then
    moneyCost = equipConfig.RWeaponBreakCost
  end
  local needLv = DataModel.WeaponBreakEffect[lv].requireEquipLv
  local needEquip = 0
  local needMoney = 0
  local needMaterial = 0
  local materialId = -1
  for i = curBreak + 1, lv do
    needEquip = needEquip + moneyCost[i].costSameEquip
    needMoney = needMoney + moneyCost[i].costMoney
    if moneyCost[i].costMaterialNum then
      needMaterial = needMaterial + moneyCost[i].costMaterialNum
    end
    if moneyCost[i].costMaterial and 0 < moneyCost[i].costMaterial and materialId <= 0 then
      materialId = moneyCost[i].costMaterial
    end
  end
  return needLv <= DataModel.server.lv and needMoney <= PlayerData:GetGoodsById(11400001).num and needEquip <= #DataModel.AllEquip, needLv, needEquip, needMoney, materialId, needMaterial
end

function Controller:OnClickBtnBreak()
  if Controller:GetCurBreakLv() > DataModel.curNumIndex then
    return
  end
  local _, needLv, needEquip, needMoney, materialId, needMaterial = Controller:CanBreak(DataModel.curNumIndex + 1)
  if needLv > DataModel.server.lv then
    CommonTips.OpenTips(80612187)
    return
  end
  if needEquip > table.count(DataModel.ChooseLeftDataIndexList) then
    CommonTips.OpenTips(80612185)
    return
  end
  if needMoney > PlayerData:GetGoodsById(11400001).num then
    CommonTips.OpenTips(80612186)
    return
  end
  if 0 < materialId and needMaterial > PlayerData:GetGoodsById(materialId).num then
    CommonTips.OpenTips(80612185)
    return
  end
  local costs = ""
  local hasBreakEquip = false
  for i = 1, #DataModel.ChooseLeftDataIndexList do
    if costs ~= "" then
      costs = costs .. ","
    end
    costs = costs .. DataModel.ChooseLeftDataIndexList[i].eid
    if DataModel.ChooseLeftDataIndexList[i].bk_lv and 0 < DataModel.ChooseLeftDataIndexList[i].bk_lv then
      hasBreakEquip = true
    end
  end
  
  local function cb()
    Net:SendProto("equip.eq_break", function(json)
      UIManager:Open("UI/CharacterInfo/weapon/Group_WeaponBreak/Group_WeaponBreakSuccess", Json.encode({
        equipCA = DataModel.equipCA,
        equipLv = DataModel.server.lv,
        lastBkLv = Controller:GetCurBreakLv(),
        curBkLv = DataModel.curNumIndex + 1
      }))
      DataModel.server.bk_lv = DataModel.curNumIndex + 1
      PlayerData:RefreshUseItems({
        ["11400001"] = DataModel.Need_Money_Num
      })
      if 0 < materialId then
        PlayerData:RefreshUseItems({
          [tostring(materialId)] = needMaterial
        })
      end
      for i = 1, #DataModel.ChooseLeftDataIndexList do
        local row = DataModel.ChooseLeftDataIndexList[i]
        PlayerData.ServerData.equipments.equips[row.eid] = nil
      end
      DataModel.ChooseLeftDataIndexList = {}
      DataModel.ChooseLeftData = {}
      PlayerData.ServerData.equipments.equips[DataModel.eid] = json.equip
      DataModel.server = json.equip
      DataModel:InitEquipList()
      Controller:OpenLeft()
      View.Group_Detail:SetActive(false)
      Controller:UpdateView()
    end, DataModel.eid, costs)
  end
  
  if hasBreakEquip then
    CommonTips.OnPrompt(80612354, nil, nil, function()
      if DataModel.server.is_locked ~= 1 then
        local row = {}
        row.is_locked = 1
        row.isChange = 1
        row.old_locked = 0
        DataModel.SendLockList[DataModel.eid] = row
      end
      DataModel:SendEquipLockData(cb)
    end)
  else
    if DataModel.server.is_locked ~= 1 then
      local row = {}
      row.is_locked = 1
      row.isChange = 1
      row.old_locked = 0
      DataModel.SendLockList[DataModel.eid] = row
    end
    DataModel:SendEquipLockData(cb)
  end
end

local function Clear_Center()
  if DataModel.AffixList_Center then
    for k, v in pairs(DataModel.AffixList_Center) do
      Object.Destroy(v)
    end
  end
end

function Controller:RefreshCenterContent(row)
  Clear_Center()
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

function Controller:OnCLickBtnLock()
  local row = DataModel.SendLockList[DataModel.LeftChooseEquipData.eid]
  local row_left = DataModel.AllEquip[tonumber(DataModel.LeftChooseEquipIndex)]
  if row.is_locked == 1 then
    row.is_locked = 0
    PlayerData:GetEquipById(DataModel.LeftChooseEquipData.eid).is_locked = 0
    row_left.is_locked = 0
    row_left.element.Group_Equipment1.Img_Lock:SetActive(false)
    View.Group_Detail.Group_EXPEquip.Btn_Lock.Img_Lock:SetActive(false)
    View.Group_Detail.Group_EXPEquip.Btn_Lock.Img_Unlock:SetActive(true)
  else
    row.is_locked = 1
    PlayerData:GetEquipById(DataModel.LeftChooseEquipData.eid).is_locked = 1
    row_left.is_locked = 1
    row_left.element.Group_Equipment1.Img_Lock:SetActive(true)
    View.Group_Detail.Group_EXPEquip.Btn_Lock.Img_Lock:SetActive(true)
    View.Group_Detail.Group_EXPEquip.Btn_Lock.Img_Unlock:SetActive(false)
  end
  if row.is_locked == row.old_locked then
    row.isChange = 0
    DataModel.LeftChooseEquipData.isChange = 0
  else
    row.isChange = 1
    DataModel.LeftChooseEquipData.isChange = 1
  end
  if row.is_locked == 1 then
    local row = DataModel.AllEquip[tonumber(DataModel.LeftChooseEquipIndex)]
    if DataModel.ChooseLeftData[row.eid] then
      row.element.Group_Equipment1.Img_Choose:SetActive(false)
      row.element.Group_Equipment1.Btn_Cancel:SetActive(false)
      table.remove(DataModel.ChooseLeftDataIndexList, DataModel.ChooseLeftData[row.eid].index)
      DataModel.ChooseLeftData[row.eid] = nil
      Controller:RefreshBottomEquipData()
    end
  end
end

function Controller:RefreshCenterDownContent(extraSkill)
  local max = PlayerData:GetFactoryData(DataModel.LeftChooseEquipData.equipCA.equipTagId).typeName + (extraSkill or 0)
  local ScrollView_Content = View.Group_Detail.Group_EXPEquip.ScrollView_Content
  ScrollView_Content.Viewport.Content.Txt_EntryNumber:SetText(string.format(GetText(80600501), table.count(DataModel.LeftChooseEquipData.random_affix), max))
  SetCenterDownAllAffix(ScrollView_Content.Viewport.Content, DataModel.LeftChooseEquipData.random_affix)
end

return Controller
