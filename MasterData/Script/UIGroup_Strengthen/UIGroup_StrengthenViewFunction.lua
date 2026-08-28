local CommonItem = require("Common/BtnItem")
local View = require("UIGroup_Strengthen/UIGroup_StrengthenView")
local DataModel = require("UIGroup_Strengthen/UIGroup_StrengthenDataModel")
local Controller = require("UIGroup_Strengthen/UIGroup_StrengthenController")
local ViewFunction = {
  Group_Strengthen_Group_Right_Group_Money_Btn_MoneyAdd_Click = function(btn, str)
    UIManager:Open("UI/MoneyMakingGuide/MoneyMakingGuide")
  end,
  Group_Strengthen_Group_Right_Btn_List_Click = function(btn, str)
    Controller:ClickRightBtn()
  end,
  Group_Strengthen_Group_Right_Btn_Oneclickput_Click = function(btn, str)
    Controller:OneClickPut()
  end,
  Group_Strengthen_Group_Right_Group_Bar_ScrollGrid_Equipment_SetGrid = function(element, elementIndex)
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
  end,
  Group_Strengthen_Group_Right_Group_Bar_ScrollGrid_Equipment_Group_Item_Btn_add_Click = function(btn, str)
    Controller:OpenChooseEquipList()
  end,
  Group_Strengthen_Group_Right_Group_Bar_ScrollGrid_Equipment_Group_Item_Group_Equipment_Btn_Item_Click = function(btn, str)
    local row = DataModel.RightChooseConsumeEquip[tonumber(str)]
    local index = 1
    for k, v in pairs(DataModel.AllEquip) do
      if v.eid == row.eid then
        index = k
        break
      end
    end
    Controller:OpenChooseEquipList(index, true)
  end,
  Group_Strengthen_Group_Right_Btn_Change_Click = function(btn, str)
    Controller:ClickChangeWindows()
  end,
  Group_Strengthen_Btn_Close_Click = function(btn, str)
    Controller:CloseChooseEquip()
  end,
  Group_Strengthen_Btn_Strengthen_Click = function(btn, str)
    local connect = ";"
    local costExp = ""
    if DataModel.ConsumeNum == 0 then
      CommonTips.OpenTips(80600524)
      return
    end
    if DataModel.AllGold > PlayerData:GetUserInfo().gold then
      CommonTips.OpenTips(80600129)
      return
    end
    local equipList = ""
    local itemList = {}
    local hasBreakEquip
    for i = 1, table.count(DataModel.RightChooseConsumeEquip) do
      local eid = DataModel.RightChooseConsumeEquip[i].eid
      if eid ~= "" then
        if PlayerData:GetFactoryData(eid) then
          if itemList[eid] == nil then
            itemList[eid] = DataModel.ChooseLeftData[tostring(eid)]
          end
        else
          equipList = equipList .. eid .. connect
          if DataModel.ChooseLeftData[tostring(eid)].bk_lv and 0 < DataModel.ChooseLeftData[tostring(eid)].bk_lv then
            hasBreakEquip = true
          end
        end
      end
    end
    for k, v in pairs(itemList) do
      costExp = costExp .. k .. ":" .. v.num .. connect
    end
    if equipList ~= "" then
      equipList = string.sub(equipList, 1, string.len(equipList) - 1)
    end
    if costExp ~= "" then
      costExp = string.sub(costExp, 1, string.len(costExp) - 1)
    end
    
    local function cb()
      Net:SendProto("equip.upgrade", function(json)
        local trackArgs = {}
        trackArgs.equip_id = DataModel.equipCA.id
        trackArgs.equip_lv = DataModel.server.lv
        trackArgs.cost_item = costExp
        trackArgs.cost_equip = equipList
        SdkReporter.TrackEquip(trackArgs)
        print_r(json)
        if View.Group_Detail.self.IsActive == true then
          View.self:PlayAnim("Close_All")
          View.Group_Detail.self:SetActive(false)
          Controller:CloseChooseEquip()
        elseif View.Group_Left.self.IsActive == true then
          View.self:PlayAnim("Close_List")
          Controller:CloseChooseEquip()
        end
        View.self:SelectPlayAnim(View.Group_effect.self, "Strengthen", function()
          if table.count(DataModel.Add_Right_Content) > 0 then
            local params = {}
            params.beforeLv = DataModel.server.lv
            params.nowLv = DataModel.Add_lv + DataModel.server.lv
            params.content = DataModel.Add_Right_Content
            params.ca = DataModel.equipCA
            params.equip = json.equip
            params.reward = json.reward
            CommonTips.OnStrengthenSuccesePage(params)
          else
            CommonTips.OpenShowItem(json.reward)
          end
          DataModel.server.exp = DataModel.Show_Exp
          DataModel.server.lv = DataModel.server.lv + DataModel.Add_lv
          PlayerData.ServerData.equipments.equips[DataModel.eid] = json.equip
          DataModel.server = json.equip
          for k, v in pairs(DataModel.RightChooseConsumeEquip) do
            if v.eid ~= "" then
              if PlayerData:GetFactoryData(v.eid) then
                PlayerData:GetGoodsById(v.eid).num = PlayerData:GetGoodsById(v.eid).num - 1
                if PlayerData:GetGoodsById(v.eid).num == 0 then
                  PlayerData:GetItems()[v.eid] = nil
                end
              else
                PlayerData.ServerData.equipments.equips[v.eid] = nil
              end
            end
          end
          Controller:InitEquip()
          Controller:RefreshRightContent()
          View.Group_Right.Group_Bar.ScrollGrid_Equipment.grid.self:MoveToTop()
        end)
      end, DataModel.eid, costExp, equipList)
    end
    
    if hasBreakEquip then
      CommonTips.OnPrompt(80612354, nil, nil, cb)
    else
      cb()
    end
  end,
  Group_Strengthen_Group_Left_ScrollGrid_Item_SetGrid = function(element, elementIndex)
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
      Group_Equipment1.Img_Choose:SetActive(true)
    end
    if DataModel.LeftChooseEquipData.eid and DataModel.LeftChooseEquipData.eid == row.eid then
      Controller:ClickLeftEquipData(elementIndex)
    end
    row.element = element
  end,
  Group_Strengthen_Group_Left_ScrollGrid_Item_Group_Item_Group_Equipment1_Btn_Item_Click = function(btn, str)
    Controller:ClickLeftEquipData(str)
  end,
  Group_Strengthen_Group_Left_ScrollGrid_Item_Group_Item_Group_Equipment1_Btn_Cancel_Click = function(btn, str)
    local row = DataModel.AllEquip[tonumber(str)]
    if DataModel.ChooseLeftData[row.eid] then
      if row.isItem == true and row.num > 1 then
        row.num = row.num - 1
        row.element.Group_Equipment1.Img_AddNum:SetActive(true)
        row.element.Group_Equipment1.Img_AddNum.Txt_Num:SetText(row.num)
        table.remove(DataModel.ChooseLeftDataIndexList, DataModel.ChooseLeftData[row.eid].index)
        Controller:RefreshBottomEquipData()
        DataModel:Clear()
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
          View.self:PlayAnim("Close_Detail", function()
            View.Group_Detail.self:SetActive(false)
          end)
        end
        
        DataModel:SendEquipLockData(callback)
        Controller:RefreshBottomEquipData()
        DataModel:Clear()
        Controller:RefreshRightDownContent()
      end
    end
  end,
  Group_Strengthen_Group_Left_Btn_Search_Click = function(btn, str)
    UIManager:LoadSplitPrefab(View, "UI/CharacterInfo/weapon/Group_Strengthen", "Group_Filter")
    View.Group_Filter.self:SetActive(true)
  end,
  Group_Strengthen_Group_Left_Btn_Sort_Click = function(btn, str)
    Controller:SortButton()
  end,
  Group_Strengthen_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack()
  end,
  Group_Strengthen_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  Group_Strengthen_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Right_ScrollView_Content_Viewport_Content_Btn_Tips1_Click = function(btn, str)
    View.Group_Tips.self:SetActive(true)
    View.Btn_CloseTips:SetActive(true)
  end,
  Group_Strengthen_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Right_Group_Money_Btn_GoldCoin_Click = function(btn, str)
  end,
  Group_Strengthen_Btn_CloseTips_Click = function(btn, str)
    if View.Group_Tips.self.IsActive == true then
      View.Group_Tips.self:SetActive(false)
    end
    if View.Group_SortRare.self.IsActive == true then
      Controller:ClickRightBtn()
    end
    if View.Group_Numbtn.self.IsActive == true then
      Controller:ClickRightEquipUseBtn()
    end
    View.Btn_CloseTips:SetActive(false)
  end,
  Group_Strengthen_Group_Right_Group_Bar_ScrollGrid_Equipment_Group_Item_Group_Equipment_Btn_Cancel_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Left_Img_Kuang_Group_ExpSSR_Btn_Item_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Left_Img_Kuang_Group_ExpSSR_Btn_Cancel_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Left_Img_Kuang_Group_ExpSR_Btn_Item_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Left_Img_Kuang_Group_ExpSR_Btn_Cancel_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Left_Img_Kuang_Group_ExpR_Btn_Item_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Left_Img_Kuang_Group_ExpR_Btn_Cancel_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Left_Img_Kuang_Group_ExpN_Btn_Item_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Left_Img_Kuang_Group_ExpN_Btn_Cancel_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Right_Btn_Num_Click = function(btn, str)
    DataModel.EquipUseBtnListLatsIndex = DataModel.EquipUseBtnListIndex
    Controller:ClickRightEquipUseBtn()
  end,
  Group_Strengthen_Group_Right_Btn_MoneyMakingGuide_Click = function(btn, str)
    UIManager:Open("UI/MoneyMakingGuide/MoneyMakingGuide")
  end,
  Group_Strengthen_Btn_WeaponBreak_Click = function(btn, str)
    local function cb()
      UIManager:Open("UI/CharacterInfo/weapon/Group_WeaponBreak/Group_WeaponBreak", Json.encode({
        server = DataModel.server,
        
        LeftTopTagIndex = DataModel.LeftTopTagIndex,
        equipCA = DataModel.equipCA,
        tagCA = DataModel.tagCA,
        eid = DataModel.eid
      }))
    end
    
    if DataModel.SendLockList then
      DataModel:SendEquipLockData(cb)
    else
      cb()
    end
  end,
  Group_Strengthen_Group_Windows_Btn_Black_Click = function(btn, str)
    Controller:CloseChangeWindows()
    if DataModel.IsSend == true then
      Controller:InitEquip()
      Controller:RefreshRightContent()
    end
  end,
  Group_Strengthen_Group_Windows_Btn_UseItem_Click = function(btn, str)
    Controller:ClickGroupUseItem()
  end,
  Group_Strengthen_Group_Windows_Img_NoHaveChangeEntry_Btn_Tips1_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Windows_Img_ItemChangeEntry_Group_Equipment1_Btn_Item_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Windows_Img_ItemChangeEntry_Group_Equipment1_Btn_Cancel_Click = function(btn, str)
    Controller:CloseGroupUseItem()
    Controller:ClickGroupUseItem()
  end,
  Group_Strengthen_Group_Windows_ScrollGrid_Entry_SetGrid = function(element, elementIndex)
    Controller:EntrySetGrid(element, elementIndex + 1)
  end,
  Group_Strengthen_Group_Windows_ScrollGrid_Entry_Group_Item_Btn_Entry_Click = function(btn, str)
    Controller:EntryClickSetGrid(str)
  end,
  Group_Strengthen_Group_Windows_Btn_Cancel_Click = function(btn, str)
    Controller:CloseChangeWindows()
    if DataModel.IsSend == true then
      Controller:InitEquip()
      Controller:RefreshRightContent()
    end
  end,
  Group_Strengthen_Group_Windows_Btn_Confirm_Click = function(btn, str)
    Controller:ConfirmEntry()
  end,
  Group_Strengthen_Group_Detail_Btn_Close_Click = function(btn, str)
    local function callback()
      View.self:PlayAnim("Close_Detail", function()
        View.Group_Detail.self:SetActive(false)
      end)
    end
    
    DataModel:SendEquipLockData(callback)
  end,
  Group_Strengthen_Group_Detail_Group_EXPEquip_Btn_Lock_Click = function(btn, str)
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
  end,
  Group_Strengthen_Group_Detail_Group_EXPEquip_Btn_Tips_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Detail_Group_EXPEquip_ScrollView_Content_Viewport_Content_Btn_Tips1_Click = function(btn, str)
  end,
  Group_Strengthen_Group_SortRare_Img_Glass_Img_Bg_StaticGrid_Rare_SetGrid = function(element, elementIndex)
    local row = DataModel.BtnList[tonumber(elementIndex)]
    element.Btn_Select:SetClickParam(elementIndex)
    element.Img_Select:SetActive(DataModel.BtnListIndex ~= tonumber(elementIndex))
    element.Img_Select.Txt_Detail:SetText(row.content)
    element.Img_Selected:SetActive(DataModel.BtnListIndex == tonumber(elementIndex))
    element.Img_Selected.Txt_Detail:SetText(row.content)
  end,
  Group_Strengthen_Group_SortRare_Img_Glass_Img_Bg_StaticGrid_Rare_Group_Rare_Btn_Select_Click = function(btn, str)
    Controller:SelectBtnList(tonumber(str))
  end,
  Group_Strengthen_Group_SortRare_Group_Rare_Btn_Select_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Windows_Txt_RemainingChangeNum_Btn_Tips_Click = function(btn, str)
    View.Group_Windows.Group_Tips.self:SetActive(true)
    View.Group_Windows.Btn_CloseTips:SetActive(true)
  end,
  Group_Strengthen_Group_Windows_Btn_CloseTips_Click = function(btn, str)
    View.Group_Windows.Group_Tips.self:SetActive(false)
    View.Group_Windows.Btn_CloseTips:SetActive(false)
  end,
  Group_Strengthen_Group_Windows_Group_UseItem_Btn_CancelItem_Click = function(btn, str)
    Controller:CloseGroupUseItem()
  end,
  Group_Strengthen_Group_Windows_Group_UseItem_Btn_ConfirmItem_Click = function(btn, str)
    Controller:UseItemEntry()
  end,
  Group_Strengthen_Group_Windows_Group_UseItem_ScrollGrid_Item_SetGrid = function(element, elementIndex)
    local row = DataModel.UseItemList[tonumber(elementIndex)]
    local Group_Equipment1 = element.Group_Equipment1
    Group_Equipment1.Btn_Item:SetClickParam(elementIndex)
    Group_Equipment1.Btn_Cancel:SetClickParam(elementIndex)
    Group_Equipment1.Img_Item:SetSprite(row.itemCA.iconPath)
    Group_Equipment1.Img_Mask:SetSprite(UIConfig.MaskConfig[row.itemCA.qualityInt + 1])
    Group_Equipment1.Img_Bottom:SetSprite(UIConfig.BottomConfig[row.itemCA.qualityInt + 1])
    Group_Equipment1.Txt_EquipmentLevel:SetText(row.num)
    Group_Equipment1.Img_Select:SetActive(false)
    Group_Equipment1.Btn_Cancel:SetActive(false)
    Group_Equipment1.Group_Face:SetActive(false)
    Group_Equipment1.Img_Choose:SetActive(false)
    Group_Equipment1.Img_Lock:SetActive(false)
    Group_Equipment1.Img_NoType:SetActive(false)
    if DataModel.ChooseUseItemIndex and DataModel.ChooseUseItemIndex == tonumber(elementIndex) then
      Group_Equipment1.Img_Select:SetActive(true)
    end
    row.element = element
  end,
  Group_Strengthen_Group_Windows_Group_UseItem_ScrollGrid_Item_Group_Item_Group_Equipment1_Btn_Item_Click = function(btn, str)
    Controller:ChooseEquipItem(str)
  end,
  Group_Strengthen_Group_Windows_Group_UseItem_ScrollGrid_Item_Group_Item_Group_Equipment1_Btn_Cancel_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Windows_Img_HaveChangeEntry_Btn_Del_Click = function(btn, str)
    Controller:DelEnrty()
  end,
  Group_Strengthen_Group_Windows_Btn_Add_Click = function(btn, str)
    Controller:UseOnlyItemEntry()
  end,
  Group_Strengthen_Group_Filter_Btn_BG_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Filter_Group_Type_Btn_All_Click = function(btn, str)
    DataModel:SwitchType(0, View.Group_Filter.Group_Type)
  end,
  Group_Strengthen_Group_Filter_Group_Type_StaticGrid_Type_SetGrid = function(element, elementIndex)
    local index = tonumber(elementIndex)
    local data = DataModel.EquipType[index]
    element.Btn_Type.self:SetClickParam(tostring(elementIndex))
    element.Btn_Type.Txt_Name:SetText(data.name)
  end,
  Group_Strengthen_Group_Filter_Group_Type_StaticGrid_Type_Group_BtnType_Btn_Type_Click = function(btn, str)
    DataModel.FilterType[0] = false
    DataModel:SwitchType(tonumber(str), View.Group_Filter.Group_Type)
  end,
  Group_Strengthen_Group_Filter_Group_Rarity_Btn_All_Click = function(btn, str)
    DataModel:SwitchRarity(0, View.Group_Filter.Group_Rarity)
  end,
  Group_Strengthen_Group_Filter_Group_Rarity_StaticGrid_Rarity_SetGrid = function(element, elementIndex)
    local index = tonumber(elementIndex)
    local Btn_Rarity = element.Btn_Rarity
    Btn_Rarity.self:SetClickParam(tostring(elementIndex))
    Btn_Rarity.Img_Name:SetSprite(UIConfig.EquipTipRarity[index])
    Btn_Rarity.Img_Name:SetActive(true)
  end,
  Group_Strengthen_Group_Filter_Group_Rarity_StaticGrid_Rarity_Group_BtnRarity_Btn_Rarity_Click = function(btn, str)
    DataModel.FilterRarity[0] = false
    DataModel:SwitchRarity(tonumber(str), View.Group_Filter.Group_Rarity)
  end,
  Group_Strengthen_Group_Filter_Group_State_Btn_All_Click = function(btn, str)
    DataModel:SwitchState(0, View.Group_Filter.Group_State)
  end,
  Group_Strengthen_Group_Filter_Group_State_Btn_S01_Click = function(btn, str)
    DataModel.FilterState[0] = false
    DataModel:SwitchState(1, View.Group_Filter.Group_State)
  end,
  Group_Strengthen_Group_Filter_Group_State_Btn_S02_Click = function(btn, str)
    DataModel.FilterState[0] = false
    DataModel:SwitchState(2, View.Group_Filter.Group_State)
  end,
  Group_Strengthen_Group_Filter_Btn_OK_Click = function(btn, str)
    View.Group_Filter.self:SetActive(false)
    Controller:RefreshFilter()
  end,
  Group_Strengthen_Group_Filter_Btn_Cancel_Click = function(btn, str)
    View.Group_Filter.self:SetActive(false)
    DataModel:SwitchType(0, View.Group_Filter.Group_Type)
    DataModel:SwitchRarity(0, View.Group_Filter.Group_Rarity)
    DataModel:SwitchState(0, View.Group_Filter.Group_State)
  end,
  Group_Strengthen_Group_Numbtn_Group_Arrow_Btn_200_Click = function(btn, str)
  end,
  Group_Strengthen_Group_Numbtn_Img_Glass_Img_Bg_StaticGrid_Arrow_SetGrid = function(element, elementIndex)
    local num = DataModel.EquipUseNumList[tonumber(elementIndex)].ratio
    element.Btn_200:SetClickParam(elementIndex)
    element.Img_Select:SetActive(DataModel.EquipUseBtnListIndex ~= tonumber(elementIndex))
    element.Img_Select.Txt_Detail:SetText(num)
    element.Img_Selected:SetActive(DataModel.EquipUseBtnListIndex == tonumber(elementIndex))
    element.Img_Selected.Txt_Detail:SetText(num)
  end,
  Group_Strengthen_Group_Numbtn_Img_Glass_Img_Bg_StaticGrid_Arrow_Group_Arrow_Btn_200_Click = function(btn, str)
    Controller:SelectEquipUseBtnList(tonumber(str))
  end
}
return ViewFunction
