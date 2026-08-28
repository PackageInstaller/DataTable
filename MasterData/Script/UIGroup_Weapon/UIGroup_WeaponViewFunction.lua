local View = require("UIGroup_Weapon/UIGroup_WeaponView")
local CharacterInfoDataModel = require("UICharacterInfo/DataModel")
local Controller = require("UIGroup_Weapon/UIGroup_WeaponController")
local CharacterDragSetting = require("UICharacterInfo/DragSetting")
local DataModel = require("UIGroup_Weapon/UIGroup_WeaponDataModel")
local ViewFunction = {
  Group_Weapon_Group_Center_Btn_Compare_Click = function(btn, str)
    local function callBack()
      DataModel:OpenEquipCompare()
    end
    
    DataModel:SendEquipLockData(callBack)
  end,
  Group_Weapon_Group_Center_Btn_Presets_Click = function(btn, str)
    local function callBack()
      DataModel:OpenPresets()
    end
    
    DataModel:SendEquipLockData(callBack)
  end,
  Group_Weapon_Group_Center_Btn_Detail_Click = function(btn, str)
  end,
  Group_Weapon_Group_Center_Group_Compare_Btn_Lock_Click = function(btn, str)
    local row = DataModel.MySelfEquip.server
    if row.is_locked == 1 then
      row.is_locked = 0
      PlayerData:GetEquipById(DataModel.MySelfEquip.eid).is_locked = 0
      if DataModel.isPresets == false and DataModel.OldEquipData.index then
        View.Group_Left.ScrollGrid_Item.grid.self:GetElementByIndex(DataModel.OldEquipData.index - 1).Group_Equipment.Img_Lock:SetActive(false)
      end
      View.Group_Center.Group_Compare.Btn_Lock.Img_Lock:SetActive(false)
      View.Group_Center.Group_Compare.Btn_Lock.Img_Unlock:SetActive(true)
    else
      row.is_locked = 1
      PlayerData:GetEquipById(DataModel.MySelfEquip.eid).is_locked = 1
      if DataModel.isPresets == false and DataModel.OldEquipData.index then
        View.Group_Left.ScrollGrid_Item.grid.self:GetElementByIndex(DataModel.OldEquipData.index - 1).Group_Equipment.Img_Lock:SetActive(true)
      end
      View.Group_Center.Group_Compare.Btn_Lock.Img_Lock:SetActive(true)
      View.Group_Center.Group_Compare.Btn_Lock.Img_Unlock:SetActive(false)
    end
    if DataModel.MySelfEquip.server.is_locked == DataModel.MySelfEquip.old_locked then
      DataModel.MySelfEquip.isChange = 0
    else
      DataModel.MySelfEquip.isChange = 1
    end
  end,
  Group_Weapon_Group_Center_Group_Compare_Btn_Tips_Click = function(btn, str)
  end,
  Group_Weapon_Group_Left_Btn_Weapon_Click = function(btn, str)
  end,
  Group_Weapon_Group_Left_Btn_Armor_Click = function(btn, str)
  end,
  Group_Weapon_Group_Left_Btn_Ring_Click = function(btn, str)
  end,
  Group_Weapon_Group_Left_ScrollGrid_Item_SetGrid = function(element, elementIndex)
    local row = DataModel.NowList[tonumber(elementIndex)]
    DataModel.ShowNowList[tonumber(elementIndex)] = {}
    element.Group_Equipment.Btn_Item:SetClickParam(elementIndex)
    element.Group_Equipment.Img_Item:SetSprite(row.equipCA.iconPath)
    element.Group_Equipment.Img_Mask:SetSprite(UIConfig.MaskConfig[row.equipCA.qualityInt + 1])
    element.Group_Equipment.Img_Bottom:SetSprite(UIConfig.BottomConfig[row.equipCA.qualityInt + 1])
    element.Group_Equipment.Txt_EquipmentLevel:SetText(string.format(GetText(80600474), row.server.lv))
    element.Group_Equipment.Img_Select:SetActive(false)
    element.Group_Equipment.Group_Face:SetActive(false)
    if row.server.hid ~= "" then
      element.Group_Equipment.Group_Face:SetActive(true)
      element.Group_Equipment.Group_Face.Img_Character.Img_Face:SetSprite(PlayerData:GetFactoryData(PlayerData:GetFactoryData(row.server.hid).viewId).face)
      if row.server.hid == DataModel.RoleId then
        local old = {}
        old.index = elementIndex
        old.eid = row.eid
        DataModel.OldEquipData = old
      end
    end
    element.Group_Equipment.Img_Lock:SetActive(false)
    if row.server.is_locked == 1 then
      element.Group_Equipment.Img_Lock:SetActive(true)
    end
    element.Group_Equipment.Img_NoType:SetActive(false)
    if row.index == 2 then
      element.Group_Equipment.Img_NoType:SetActive(true)
    end
    if DataModel.EquipIndex and DataModel.EquipIndex == tonumber(elementIndex) then
      element.Group_Equipment.Img_Select:SetActive(true)
    end
  end,
  Group_Weapon_Group_Left_Btn_Search_Click = function(btn, str)
    Controller:OpenFilter()
  end,
  Group_Weapon_Group_Filter_Btn_BG_Click = function(btn, str)
    if View.Group_Filter.self then
      View.Group_Filter.self:SetActive(false)
    end
  end,
  Group_Weapon_Group_Filter_Group_Group_Btn_All_Click = function(btn, str)
    Controller:SwitchFilterGroupByBtn(btn, 0)
  end,
  Group_Weapon_Group_Filter_Group_Group_Btn_C01_Click = function(btn, str)
    Controller:SwitchFilterGroupByBtn(btn, 1)
  end,
  Group_Weapon_Group_Filter_Group_Group_Btn_C02_Click = function(btn, str)
    Controller:SwitchFilterGroupByBtn(btn, 2)
  end,
  Group_Weapon_Group_Filter_Group_Group_Btn_C03_Click = function(btn, str)
    Controller:SwitchFilterGroupByBtn(btn, 3)
  end,
  Group_Weapon_Group_Filter_Group_Group_Btn_C04_Click = function(btn, str)
    Controller:SwitchFilterGroupByBtn(btn, 4)
  end,
  Group_Weapon_Group_Filter_Group_Group_Btn_C05_Click = function(btn, str)
    Controller:SwitchFilterGroupByBtn(btn, 5)
  end,
  Group_Weapon_Group_Filter_Group_Group_Btn_C06_Click = function(btn, str)
    Controller:SwitchFilterGroupByBtn(btn, 6)
  end,
  Group_Weapon_Group_Filter_Group_Group_Btn_C07_Click = function(btn, str)
    Controller:SwitchFilterGroupByBtn(btn, 7)
  end,
  Group_Weapon_Group_Filter_Group_Group_Btn_C08_Click = function(btn, str)
    Controller:SwitchFilterGroupByBtn(btn, 8)
  end,
  Group_Weapon_Group_Filter_Group_Group_Btn_C09_Click = function(btn, str)
    Controller:SwitchFilterGroupByBtn(btn, 9)
  end,
  Group_Weapon_Group_Filter_Group_Rarity_Btn_All_Click = function(btn, str)
    Controller:SwitchFilterRarityByBtn(btn, 0)
  end,
  Group_Weapon_Group_Filter_Group_Rarity_Btn_G01_Click = function(btn, str)
    Controller:SwitchFilterRarityByBtn(btn, 1)
  end,
  Group_Weapon_Group_Filter_Group_Rarity_Btn_G02_Click = function(btn, str)
    Controller:SwitchFilterRarityByBtn(btn, 2)
  end,
  Group_Weapon_Group_Filter_Group_Rarity_Btn_G03_Click = function(btn, str)
    Controller:SwitchFilterRarityByBtn(btn, 3)
  end,
  Group_Weapon_Group_Filter_Group_Rarity_Btn_G04_Click = function(btn, str)
    Controller:SwitchFilterRarityByBtn(btn, 4)
  end,
  Group_Weapon_Group_Filter_Group_State_Btn_All_Click = function(btn, str)
    Controller:SwitchFilterStateByBtn(btn, 0)
  end,
  Group_Weapon_Group_Filter_Group_State_Btn_S01_Click = function(btn, str)
    Controller:SwitchFilterStateByBtn(btn, 1)
  end,
  Group_Weapon_Group_Filter_Group_State_Btn_S02_Click = function(btn, str)
    Controller:SwitchFilterStateByBtn(btn, 2)
  end,
  Group_Weapon_Group_Filter_Btn_OK_Click = function(btn, str)
    if View.Group_Filter.self then
      View.Group_Filter.self:SetActive(false)
    end
    DataModel:RefreshFilterList()
  end,
  Group_Weapon_Group_Filter_Btn_Cancel_Click = function(btn, str)
    if View.Group_Filter.self then
      View.Group_Filter.self:SetActive(false)
    end
  end,
  Group_Weapon_Group_Left_Btn_Sort_Click = function(btn, str)
    local function callBack()
      DataModel:SortButton()
    end
    
    DataModel:SendEquipLockData(callBack)
  end,
  Group_Weapon_Group_Right_Btn_Lock_Click = function(btn, str)
    local row = DataModel.SendLockList[DataModel.NowChooseEquip.eid]
    if row.is_locked == 1 then
      row.is_locked = 0
      PlayerData:GetEquipById(DataModel.NowChooseEquip.eid).is_locked = 0
      if DataModel.isPresets == false and View.Group_Left.ScrollGrid_Item.grid.self:GetElementByIndex(tonumber(DataModel.EquipIndex) - 1) then
        View.Group_Left.ScrollGrid_Item.grid.self:GetElementByIndex(tonumber(DataModel.EquipIndex) - 1).Group_Equipment.Img_Lock:SetActive(false)
      end
      View.Group_Right.Btn_Lock.Img_Lock:SetActive(false)
      View.Group_Right.Btn_Lock.Img_Unlock:SetActive(true)
    else
      row.is_locked = 1
      PlayerData:GetEquipById(DataModel.NowChooseEquip.eid).is_locked = 1
      if DataModel.isPresets == false and View.Group_Left.ScrollGrid_Item.grid.self:GetElementByIndex(tonumber(DataModel.EquipIndex) - 1) then
        View.Group_Left.ScrollGrid_Item.grid.self:GetElementByIndex(tonumber(DataModel.EquipIndex) - 1).Group_Equipment.Img_Lock:SetActive(true)
      end
      View.Group_Right.Btn_Lock.Img_Lock:SetActive(true)
      View.Group_Right.Btn_Lock.Img_Unlock:SetActive(false)
    end
    if row.is_locked == row.old_locked then
      row.isChange = 0
    else
      row.isChange = 1
    end
  end,
  Group_Weapon_Group_Right_Btn_Tips_Click = function(btn, str)
  end,
  Group_Weapon_Group_Right_Btn_Strengthen_Click = function(btn, str)
    local function callBack_a()
      local function callBack()
        local params = DataModel.NowChooseEquip
        
        params.element = nil
        params.server.element = nil
        params.LeftTopTagIndex = DataModel.LeftTopTagIndex
        CommonTips.OpenGroupStrengthen(params)
      end
      
      DataModel:SendEquipLockData(callBack)
    end
    
    if View.Group_Center.Group_Compare.self.IsActive == true then
      DataModel:OpenEquipCompare(true, callBack_a)
      return
    end
    callBack_a()
  end,
  Group_Weapon_Group_Right_Btn_Removing_Click = function(btn, str)
    if View.Group_Center.Group_Compare.self.IsActive == true then
      DataModel:OpenEquipCompare()
    end
    Net:SendProto("hero.set_equip", function(json)
      PlayerData:GetRoleById(DataModel.RoleId).equips[DataModel.RoleEquipIndex] = ""
      PlayerData:GetEquipById(DataModel.NowChooseEquip.eid).hid = ""
      if DataModel.OldEquipData and table.count(DataModel.OldEquipData) > 0 then
        PlayerData:GetEquipById(DataModel.OldEquipData.eid).hid = ""
      end
      DataModel:ChooseLeftTop(DataModel.LeftTopTagIndex, true)
      DataModel:SetRoleEquip()
      Controller:RefreshCenterEquip()
    end, DataModel.RoleId, DataModel.NowChooseEquip.eid, 1)
  end,
  Group_Weapon_Group_Right_Btn_Use_Click = function(btn, str)
    local function callBack()
      Net:SendProto("hero.set_equip", function(json)
        print_r(json)
        
        PlayerData:GetRoleById(DataModel.RoleId).equips[DataModel.RoleEquipIndex] = DataModel.NowChooseEquip.eid
        PlayerData:GetRoleById(DataModel.SendRoleID).equips[DataModel.RoleEquipIndex] = ""
        PlayerData:GetEquipById(DataModel.NowChooseEquip.eid).hid = DataModel.RoleId
        if DataModel.OldEquipData and table.count(DataModel.OldEquipData) > 0 then
          PlayerData:GetEquipById(DataModel.OldEquipData.eid).hid = ""
        end
        DataModel:ChooseLeftTop(DataModel.LeftTopTagIndex, true)
        DataModel:SetRoleEquip()
        Controller:RefreshCenterEquip()
      end, DataModel.RoleId, DataModel.NowChooseEquip.eid, 0)
    end
    
    if DataModel.SendRoleIsSelf == false then
      local content = string.format(GetText(80600448), PlayerData:GetFactoryData(DataModel.SendRoleID).name)
      local checkTipParam = {
        checkTipType = 1,
        checkTipKey = "SendRoleEquip",
        isCheckTip = true
      }
      CommonTips.OnPrompt(content, nil, nil, callBack, nil, nil, nil, nil, checkTipParam)
      return
    end
    local equipTagId = DataModel.NowChooseEquip.equipCA.equipTagId
    local typeInt = PlayerData:GetTypeInt("enumEquipTypeList", equipTagId)
    if typeInt ~= DataModel.RoleEquipType then
      CommonTips.OpenTips(80600267)
      return
    end
    Net:SendProto("hero.set_equip", function(json)
      print_r(json)
      PlayerData:GetRoleById(DataModel.RoleId).equips[DataModel.RoleEquipIndex] = DataModel.NowChooseEquip.eid
      PlayerData:GetEquipById(DataModel.NowChooseEquip.eid).hid = DataModel.RoleId
      if DataModel.OldEquipData and table.count(DataModel.OldEquipData) > 0 then
        PlayerData:GetEquipById(DataModel.OldEquipData.eid).hid = ""
      end
      DataModel:ChooseLeftTop(DataModel.LeftTopTagIndex, true)
      DataModel:SetRoleEquip()
      Controller:RefreshCenterEquip()
    end, DataModel.RoleId, DataModel.NowChooseEquip.eid, 0)
  end,
  Group_Weapon_Group_Left_ScrollGrid_Item_Group_Item_Group_Equipment_Btn_Item_Click = function(btn, str)
    local function callBack()
      DataModel:ChooseEquip(tonumber(str))
    end
    
    DataModel:SendEquipLockData(callBack)
  end,
  Group_Weapon_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    local function callBack()
      if DataModel.isPresets == true then
        View.Group_Detail.self:SetActive(false)
        
        Controller:ClosePresets(1)
        local index = DataModel.LeftTopTagIndex
        DataModel.LeftTopTagIndex = nil
        DataModel:ChooseLeftTop(index)
        return
      end
      if View.Group_Center.Group_Compare.self.IsActive == true then
        View.self:PlayAnim("Out_Compare", function()
          UIManager:GoBack()
        end)
      else
        UIManager:GoBack()
      end
    end
    
    DataModel:SendEquipLockData(callBack)
  end,
  Group_Weapon_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    local function callBack()
      UIManager:GoHome()
    end
    
    DataModel:SendEquipLockData(callBack)
  end,
  Group_Weapon_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Group_Weapon_Group_Left_StaticGrid_Item_SetGrid = function(element, elementIndex)
    local row = DataModel.LeftTopTagName[tonumber(elementIndex)]
    local Img_Close = element.Btn_Item.Img_Close
    Img_Close.Txt_CWeapon:SetText(row)
    local Img_Open = element.Btn_Item.Img_Open
    Img_Open.Txt_OWeapon:SetText(row)
    element.Btn_Item:SetClickParam(elementIndex)
    if elementIndex == DataModel.LeftTopTagIndex then
      Img_Open:SetActive(true)
      Img_Close:SetActive(false)
    else
      Img_Open:SetActive(false)
      Img_Close:SetActive(true)
    end
  end,
  Group_Weapon_Group_Right_ScrollView_Content_Viewport_Content_Btn_Tips1_Click = function(btn, str)
    View.Group_Tips.self:SetActive(true)
    View.Btn_CloseTips:SetActive(true)
  end,
  Group_Weapon_Group_Center_Group_Compare_ScrollView_Content_Viewport_Content_Btn_Tips1_Click = function(btn, str)
    View.Group_Tips.self:SetActive(false)
    View.Btn_CloseTips:SetActive(false)
  end,
  Group_Weapon_Group_Left_Presets_ScrollGrid_Presets_SetGrid = function(element, elementIndex)
    local Btn_Presets = element.Btn_Presets
    if tonumber(elementIndex) == 1 then
      Btn_Presets.Btn_Use:SetActive(false)
      Btn_Presets.Txt_PresetsName:SetText(GetText(80603529))
    else
      Btn_Presets.Btn_Use:SetActive(true)
      Btn_Presets.Txt_PresetsName:SetText(GetText(80603516) .. elementIndex - 1)
    end
    Btn_Presets.Img_Select:SetActive(false)
    if DataModel.PresetIndex and DataModel.PresetIndex == tonumber(elementIndex) then
      Btn_Presets.Img_Select:SetActive(true)
    end
    Btn_Presets:SetClickParam(elementIndex)
    Btn_Presets.Btn_Use:SetClickParam(elementIndex)
    for i = 1, 3 do
      DataModel:SetEquipElement(Btn_Presets, elementIndex, i)
    end
  end,
  Group_Weapon_Group_Left_Presets_ScrollGrid_Presets_Group_Item_Btn_Presets_Click = function(btn, str)
    DataModel:ChoosePresetsGroup(str)
  end,
  Group_Weapon_Group_Left_Presets_ScrollGrid_Presets_Group_Item_Btn_Presets_Btn_Use_Click = function(btn, str)
    DataModel:ChoosePresetsGroup(str)
    DataModel:UsePresets(tonumber(str))
  end,
  Group_Weapon_Group_Left_Presets_Btn_Detail_Click = function(btn, str)
    DataModel:ClickDetail()
  end,
  Group_Weapon_Group_Left_Presets_Btn_Save_Click = function(btn, str)
    if tonumber(str) == 1 then
      return
    end
    local choose_equip = DataModel.PresetListElementData[DataModel.PresetIndex]
    local now_equip = DataModel.PresetListElementData[1]
    local list = {}
    local count = 0
    for k, v in pairs(now_equip) do
      table.insert(list, v)
    end
    for c, d in pairs(choose_equip) do
      if d ~= "" then
        count = count + 1
      end
    end
    local num, row = table:Difference(choose_equip, list)
    if 0 < num then
      local function callBack()
        local connect = ","
        
        local equipList = ""
        for i = 1, table.count(list) do
          local v = list[i]
          equipList = equipList .. v .. connect
        end
        equipList = string.sub(equipList, 1, string.len(equipList) - 1)
        Net:SendProto("hero.save", function(json)
          print_r(json)
          PlayerData:GetRoleById(DataModel.RoleId).pre_equips[DataModel.PresetIndex - 1] = list
          DataModel.RoleSeverData = PlayerData:GetRoleById(DataModel.RoleId)
          DataModel.PresetListElementData[DataModel.PresetIndex] = list
          for i = 1, 3 do
            DataModel:SetEquipElement(View.Group_Left_Presets.ScrollGrid_Presets.grid.self:GetElementByIndex(DataModel.PresetIndex - 1).Btn_Presets, DataModel.PresetIndex, i)
          end
          local index = DataModel.PresetIndex
          DataModel.PresetIndex = nil
          DataModel:ChoosePresetsGroup(index)
        end, DataModel.RoleId, equipList, DataModel.PresetIndex - 2)
      end
      
      if count == 0 then
        callBack()
      else
        CommonTips.OnPrompt(80600470, nil, nil, callBack)
      end
    end
  end,
  Group_Weapon_Group_Left_Presets_Btn_Delete_Click = function(btn, str)
    if View.Group_Left_Presets.Btn_Delete.Img_Open.IsActive == true then
      local function callBack()
        local clear_equip = {
          [1] = "",
          
          [2] = "",
          [3] = ""
        }
        Net:SendProto("hero.save", function(json)
          print_r(json)
          PlayerData:GetRoleById(DataModel.RoleId).pre_equips[DataModel.PresetIndex - 1] = clear_equip
          DataModel.RoleSeverData = PlayerData:GetRoleById(DataModel.RoleId)
          DataModel.PresetListElementData[DataModel.PresetIndex] = clear_equip
          for i = 1, 3 do
            DataModel:SetEquipElement(View.Group_Left_Presets.ScrollGrid_Presets.grid.self:GetElementByIndex(DataModel.PresetIndex - 1).Btn_Presets, DataModel.PresetIndex, i)
          end
          local index = DataModel.PresetIndex
          DataModel.PresetIndex = nil
          DataModel:ChoosePresetsGroup(index)
        end, DataModel.RoleId, ",,", DataModel.PresetIndex - 2)
      end
      
      CommonTips.OnPrompt(80600471, nil, nil, callBack)
    end
  end,
  Group_Weapon_Group_Left_Presets_ScrollGrid_Presets_Group_Item_Btn_Presets_Group_Equipment_1_Group_Info_Btn_Item_Click = function(btn, str)
    local eid = DataModel.PresetListElementData[tonumber(str)][1]
    local Btn_Presets = View.Group_Left_Presets.ScrollGrid_Presets.grid.self:GetElementByIndex(tonumber(str) - 1).Btn_Presets
    if Btn_Presets.Group_Equipment_1.Group_Info.Img_Select.IsActive == true then
      return
    end
    if eid ~= "" then
      DataModel:ChoosePresetsGroup(str)
      Btn_Presets.Group_Equipment_1.Group_Info.Img_Select:SetActive(true)
      Btn_Presets.Group_Equipment_2.Group_Info.Img_Select:SetActive(false)
      Btn_Presets.Group_Equipment_3.Group_Info.Img_Select:SetActive(false)
      DataModel.EquipIndex = nil
      DataModel:ChoosePresetEquip(1)
    end
  end,
  Group_Weapon_Group_Left_Presets_ScrollGrid_Presets_Group_Item_Btn_Presets_Group_Equipment_2_Group_Info_Btn_Item_Click = function(btn, str)
    local eid = DataModel.PresetListElementData[tonumber(str)][2]
    local Btn_Presets = View.Group_Left_Presets.ScrollGrid_Presets.grid.self:GetElementByIndex(tonumber(str) - 1).Btn_Presets
    if Btn_Presets.Group_Equipment_2.Group_Info.Img_Select.IsActive == true then
      return
    end
    if eid ~= "" then
      DataModel:ChoosePresetsGroup(str)
      Btn_Presets.Group_Equipment_2.Group_Info.Img_Select:SetActive(true)
      Btn_Presets.Group_Equipment_1.Group_Info.Img_Select:SetActive(false)
      Btn_Presets.Group_Equipment_3.Group_Info.Img_Select:SetActive(false)
      DataModel.EquipIndex = nil
      DataModel:ChoosePresetEquip(2)
    end
  end,
  Group_Weapon_Group_Left_Presets_ScrollGrid_Presets_Group_Item_Btn_Presets_Group_Equipment_3_Group_Info_Btn_Item_Click = function(btn, str)
    local eid = DataModel.PresetListElementData[tonumber(str)][3]
    local Btn_Presets = View.Group_Left_Presets.ScrollGrid_Presets.grid.self:GetElementByIndex(tonumber(str) - 1).Btn_Presets
    if Btn_Presets.Group_Equipment_3.Group_Info.Img_Select.IsActive == true then
      return
    end
    if eid ~= "" then
      DataModel:ChoosePresetsGroup(str)
      Btn_Presets.Group_Equipment_3.Group_Info.Img_Select:SetActive(true)
      Btn_Presets.Group_Equipment_1.Group_Info.Img_Select:SetActive(false)
      Btn_Presets.Group_Equipment_2.Group_Info.Img_Select:SetActive(false)
      DataModel.EquipIndex = nil
      DataModel:ChoosePresetEquip(3)
    end
  end,
  Group_Weapon_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Group_Weapon_Btn_CloseTips_Click = function(btn, str)
    View.Group_Tips.self:SetActive(false)
    View.Btn_CloseTips:SetActive(false)
  end,
  Group_Weapon_Group_Left_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  Group_Weapon_Group_Left_StaticGrid_Item_Group_Item_Btn_Item_Click = function(btn, str)
    local function callBack()
      DataModel:ChooseLeftTop(tonumber(str))
    end
    
    DataModel:SendEquipLockData(callBack)
    Controller:RefreshCenterEquip()
  end,
  Group_Weapon_Group_Middle_Drag_Spine_BeginDrag = function(direction, dragPos)
    if DataModel.IsCanDrag == false then
      return
    end
    DataModel.BeginDragPosX = dragPos.x
    local isSpine2 = DataModel.GetShowType() == "Spine2"
    if isSpine2 then
      DataModel.SpinePosX = View.Group_Middle.SpineSecondMode_Character:GetAnchoredPositionX()
    else
      DataModel.SpinePosX = View.Group_Middle.SpineAnimation_Character:GetAnchoredPositionX()
    end
  end,
  Group_Weapon_Group_Middle_Drag_Spine_EndDrag = function(direction, dragPos)
    if DataModel.IsCanDrag == false then
      return
    end
    if not DataModel.DragOver then
      View.self:SetRaycastBlock(false)
      local showType = DataModel.GetShowType()
      local isSpine2 = showType == "Spine2"
      local isSpine = showType == "Spine"
      local show, detail
      if isSpine2 then
        show = View.Group_Middle.SpineSecondMode_Character
        detail = View.Group_Middle.SpineSecondMode_Character
      elseif isSpine then
        show = View.Group_Middle.SpineAnimation_Character
        detail = View.Group_Middle.SpineAnimation_Character
      else
        show = View.Group_Middle.Group_Character
        detail = View.Group_Middle.Group_Character.Img_Character
      end
      if DataModel.live2D == 1 then
        show = View.Group_Middle.Group_Character
        detail = View.Group_Middle.Group_Character.Img_Character
      end
      local posX = DataModel.GetSpinePortraitPos()
      if not isSpine2 and not isSpine then
        posX = DataModel.GetPortraitPos()
      end
      DOTweenTools.DOLocalMoveXCallback(show.transform, posX, CharacterDragSetting.Time, nil, function()
        View.Group_Middle.Drag_Spine:SetAnchoredPositionX(posX)
      end)
      DOTweenTools.DOLocalMoveX(View.Group_Right.self.transform, DataModel.GroupRightPositionX, CharacterDragSetting.Time)
      DOTweenTools.DOFadeColorCallback(detail, Color(1, 1, 1, 1), CharacterDragSetting.Time, function()
        View.self:SetRaycastBlock(true)
      end)
      DOTweenTools.DOFadeColorCallback(detail, Color(1, 1, 1, 1), CharacterDragSetting.Time, function()
        View.Group_Right.self:SetEnableAnimator(true)
        View.self:SetRaycastBlock(true)
      end)
    end
    DataModel.DragOver = false
  end,
  Group_Weapon_Group_Middle_Drag_Spine_OnDrag = function(direction, dragPos)
    if DataModel.IsCanDrag == false then
      return
    end
    if DataModel.DragOver or not DataModel.BeginDragPosX then
      return
    end
    local showType = DataModel.GetShowType()
    local isSpine2 = showType == "Spine2"
    local isSpine = showType == "Spine"
    local show, detail
    local posX = DataModel.GetSpinePortraitPos(isSpine2)
    if isSpine2 then
      show = View.Group_Middle.SpineSecondMode_Character
      detail = View.Group_Middle.SpineSecondMode_Character
    elseif isSpine then
      show = View.Group_Middle.SpineAnimation_Character
      detail = View.Group_Middle.SpineAnimation_Character
    else
      show = View.Group_Middle.Group_Character.Img_Character
      detail = View.Group_Middle.Group_Character.Img_Character
    end
    if DataModel.live2D == 1 then
      show = View.Group_Middle.Group_Character.Img_Character
      detail = View.Group_Middle.Group_Character.Img_Character
      posX = DataModel.GetPortraitPos(isSpine2)
    elseif not isSpine2 and not isSpine then
      posX = DataModel.GetPortraitPos(isSpine2)
    end
    local dragPosX = dragPos.x
    DataModel.DragOverPosX = posX + (dragPosX - DataModel.BeginDragPosX) * CharacterDragSetting.DragCharacterRatio
    local offset = math.abs(DataModel.DragOverPosX - posX)
    show:SetAnchoredPositionX(DataModel.DragOverPosX)
    detail:SetColor(Color(1, 1, 1, 1 - offset / Screen.width * 4))
    View.Group_Middle.Drag_Spine:SetAnchoredPositionX(DataModel.DragOverPosX)
    View.self:SetRaycastBlock(true)
    if math.abs(DataModel.DragOverPosX - posX) >= Screen.width / 5 then
      DataModel.DragOver = true
      View.self:SetRaycastBlock(false)
      DOTweenTools.DOFadeColorCallback(detail, Color(1, 1, 1, 0), CharacterDragSetting.Time)
      DOTweenTools.DOLocalMoveXCallback(show.transform, DataModel.DragOverPosX > 0 and Screen.width or -Screen.width, CharacterDragSetting.Time, nil, function()
        DataModel.NextRole(DataModel.DragOverPosX < 0)
        DataModel:RefreshRole(DataModel.RoleList[DataModel.RoleListIndex])
        Controller:Init()
        showType = DataModel.GetShowType()
        isSpine2 = showType == "Spine2"
        isSpine = showType == "Spine"
        posX = DataModel.GetSpinePortraitPos(isSpine2)
        if isSpine2 then
          show = View.Group_Middle.SpineSecondMode_Character
        elseif isSpine then
          show = View.Group_Middle.SpineAnimation_Character
        else
          show = View.Group_Middle.Group_Character
          posX = DataModel.GetPortraitPos(isSpine2)
        end
        show:SetAnchoredPositionX(-(DataModel.DragOverPosX > 0 and Screen.width or -Screen.width))
        DOTweenTools.DOFadeColorCallback(detail, Color(1, 1, 1, 1), CharacterDragSetting.Time)
        DOTweenTools.DOLocalMoveXCallback(show.transform, posX, CharacterDragSetting.Time, nil, function()
          CharacterInfoDataModel.isWeaponRoleId = DataModel.RoleId
          View.self:SetRaycastBlock(true)
          View.Group_Middle.Drag_Spine:SetAnchoredPositionX(posX)
        end)
      end)
    end
  end,
  Group_Weapon_Group_Center_Group_Character_Btn_ProfilePhoto_Click = function(btn, str)
  end,
  Group_Weapon_Group_Center_StaticGrid_Character_SetGrid = function(element, elementIndex)
    Controller:SetCenterSquadsRole(element, elementIndex)
  end,
  Group_Weapon_Group_Center_StaticGrid_Character_Group_Character_Btn_ProfilePhoto_Click = function(btn, str)
    Controller:ClickCenterSquads(str)
  end,
  Group_Weapon_Group_Center_StaticGrid_Equipment_SetGrid = function(element, elementIndex)
    Controller:SetCenterEquipElement(element, elementIndex)
  end,
  Group_Weapon_Group_Center_StaticGrid_Equipment_Group_Equipment_Btn_Item_Click = function(btn, str)
    Controller:ClickCenterEquip(str)
  end,
  Group_Weapon_Group_Center_StaticGrid_Equipment_Group_Equipment_Group_Equipment_Btn_Item_Click = function(btn, str)
    Controller:ClickCenterEquip(str)
  end,
  Group_Weapon_Group_Center_Group_Equipment_Btn_Item_Click = function(btn, str)
  end,
  Group_Weapon_Group_Center_Group_Equipment_Group_Equipment_Btn_Item_Click = function(btn, str)
  end
}
return ViewFunction
