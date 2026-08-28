local View = require("UIGroup_WeaponBreak/UIGroup_WeaponBreakView")
local DataModel = require("UIGroup_WeaponBreak/UIGroup_WeaponBreakDataModel")
local Controller = require("UIGroup_WeaponBreak/UIGroup_WeaponBreakController")
local ViewFunction = {
  Group_WeaponBreak_Group_TopBar_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack(false)
    UIManager:Open("UI/CharacterInfo/weapon/Group_Strengthen", Json.encode({
      server = DataModel.server,
      LeftTopTagIndex = DataModel.LeftTopTagIndex,
      equipCA = DataModel.equipCA,
      tagCA = DataModel.tagCA,
      eid = DataModel.eid
    }))
  end,
  Group_WeaponBreak_Group_TopBar_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  Group_WeaponBreak_Group_TopBar_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  Group_WeaponBreak_Group_TopBar_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  Group_WeaponBreak_Group_TopBar_Btn_MoneyMakingGuide_Click = function(btn, str)
    UIManager:Open("UI/MoneyMakingGuide/MoneyMakingGuide")
  end,
  Group_WeaponBreak_Group_TopBar_Group_Money_Btn_GoldCoin_Click = function(btn, str)
  end,
  Group_WeaponBreak_Group_TopBar_Group_Money_Btn_MoneyAdd_Click = function(btn, str)
  end,
  Group_WeaponBreak_Group_Right_Group_Bar_ScrollGrid_Equipment_SetGrid = function(element, elementIndex)
    Controller:OnSetCostEquipGrid(element, elementIndex)
  end,
  Group_WeaponBreak_Group_Right_Group_Bar_ScrollGrid_Equipment_Group_Item_Btn_add_Click = function(btn, str)
    Controller:OpenLeft()
  end,
  Group_WeaponBreak_Group_Right_Group_Bar_ScrollGrid_Equipment_Group_Item_Group_Equipment_Btn_Item_Click = function(btn, str)
    local row = DataModel.RightChooseConsumeEquip[tonumber(str)]
    local index = 1
    for k, v in pairs(DataModel.AllEquip) do
      if v.eid == row.eid then
        index = k
        break
      end
    end
    Controller:OpenLeft(index, true)
  end,
  Group_WeaponBreak_Group_Right_Group_Bar_ScrollGrid_Equipment_Group_Item_Group_Equipment_Btn_Cancel_Click = function(btn, str)
  end,
  Group_WeaponBreak_Group_Right_Btn_WeaponBreak_Click = function(btn, str)
    Controller:OnClickBtnBreak()
  end,
  Group_WeaponBreak_Btn_Close_Click = function(btn, str)
    Controller:CloseLeft()
  end,
  Group_WeaponBreak_Group_Left_Img_Kuang_Group_ExpSSR_Btn_Item_Click = function(btn, str)
  end,
  Group_WeaponBreak_Group_Left_Img_Kuang_Group_ExpSSR_Btn_Cancel_Click = function(btn, str)
  end,
  Group_WeaponBreak_Group_Left_Img_Kuang_Group_ExpSR_Btn_Item_Click = function(btn, str)
  end,
  Group_WeaponBreak_Group_Left_Img_Kuang_Group_ExpSR_Btn_Cancel_Click = function(btn, str)
  end,
  Group_WeaponBreak_Group_Left_Img_Kuang_Group_ExpR_Btn_Item_Click = function(btn, str)
  end,
  Group_WeaponBreak_Group_Left_Img_Kuang_Group_ExpR_Btn_Cancel_Click = function(btn, str)
  end,
  Group_WeaponBreak_Group_Left_Img_Kuang_Group_ExpN_Btn_Item_Click = function(btn, str)
  end,
  Group_WeaponBreak_Group_Left_Img_Kuang_Group_ExpN_Btn_Cancel_Click = function(btn, str)
  end,
  Group_WeaponBreak_Group_Left_ScrollGrid_Item_SetGrid = function(element, elementIndex)
    Controller:OnSetItemGrid(element, elementIndex)
  end,
  Group_WeaponBreak_Group_Left_ScrollGrid_Item_Group_Item_Group_Equipment1_Btn_Item_Click = function(btn, str)
    Controller:ClickLeftEquipData(str)
  end,
  Group_WeaponBreak_Group_Left_ScrollGrid_Item_Group_Item_Group_Equipment1_Btn_Cancel_Click = function(btn, str)
    Controller:OnClickCancelEquip(str)
  end,
  Group_WeaponBreak_Group_Left_Btn_Search_Click = function(btn, str)
  end,
  Group_WeaponBreak_Group_Left_Btn_Sort_Click = function(btn, str)
  end,
  Group_WeaponBreak_Group_EquipmentBase_Page_LvBreak_SetPage = function(element, elementIndex)
    element:SetActive(true)
    element.Btn_ChooseLv:SetEnableAnimator(false)
    local curBreak = Controller:GetCurBreakLv()
    element.Btn_ChooseLv.Txt_LvNum:SetText(elementIndex)
    local curState, lastState
    if elementIndex <= curBreak then
      lastState = "02"
    elseif DataModel.lastNumIndex == nil or elementIndex == DataModel.lastNumIndex + 1 then
      lastState = "04"
    elseif Controller:CanBreak(elementIndex) then
      lastState = "03"
    else
      lastState = "01"
    end
    if elementIndex <= curBreak then
      curState = "02"
    elseif elementIndex == DataModel.curNumIndex + 1 then
      curState = "04"
    elseif Controller:CanBreak(elementIndex) then
      curState = "03"
    else
      curState = "01"
    end
    if lastState == curState then
      for i = 1, 4 do
        element.Btn_ChooseLv["Img_State0" .. i]:SetActive(false)
      end
      element.Btn_ChooseLv["Img_State" .. curState]:SetActive(true)
      element.Btn_ChooseLv["Img_State" .. curState]:GetComponent(typeof(CS.UnityEngine.CanvasGroup)).alpha = 1
      if curState == "04" or curState == "03" then
        element.Btn_ChooseLv.Txt_LvNum:SetColor("#323232")
      elseif curState == "01" or curState == "02" then
        element.Btn_ChooseLv.Txt_LvNum:SetColor("#EBEBEB")
      end
      if curState == "04" then
        element.Btn_ChooseLv.Txt_LvNum:SetLocalScale(Vector3(1, 1, 1))
        element.Btn_ChooseLv:SetLocalPositionY(-100)
      else
        element.Btn_ChooseLv.Txt_LvNum:SetLocalScale(Vector3(0.6, 0.6, 0.6))
        element.Btn_ChooseLv:SetLocalPositionY(-78)
      end
    else
      element.Btn_ChooseLv:SetEnableAnimator(true)
      View.self:SelectPlayAnim(element.Btn_ChooseLv.self, "Btn_ChooseLv_State" .. lastState .. "to" .. curState, function()
        element.Btn_ChooseLv:SetEnableAnimator(false)
      end)
    end
  end,
  Group_WeaponBreak_Group_EquipmentBase_Page_LvBreak_PageDrag = function(dragOffsetPos)
  end,
  Group_WeaponBreak_Group_EquipmentBase_Page_LvBreak_PageDragComplete = function(index)
  end,
  Group_WeaponBreak_Group_EquipmentBase_Page_LvBreak_PageDragBegin = function(dragOffsetPos)
  end,
  Group_WeaponBreak_Group_EquipmentBase_Page_LvBreak_Group_Item_Btn_ChooseLv_Click = function(btn, str)
  end,
  Group_WeaponBreak_Group_EquipmentBase_Page_LvBreakHide_SetPage = function(element, elementIndex)
  end,
  Group_WeaponBreak_Group_EquipmentBase_Page_LvBreakHide_PageDrag = function(dragOffsetPos)
    local group = View.Group_EquipmentBase
    local grid = group.Page_LvBreak.grid.self
    local pos = group.Page_LvBreakHide.grid.self.ScrollRect.content.anchoredPosition
    grid.ScrollRect.content.anchoredPosition = Vector2(pos.x + 139, 0)
    grid:HandleScrollEvent(Vector2(grid.ScrollRect.horizontalNormalizedPosition, 0))
    grid:UpdateScale()
  end,
  Group_WeaponBreak_Group_EquipmentBase_Page_LvBreakHide_PageDragComplete = function(index)
    local group = View.Group_EquipmentBase
    local grid = group.Page_LvBreak.grid.self
    grid.ScrollRect.content.anchoredPosition = Vector2(-139 * index + 139, 0)
    DataModel.lastNumIndex = DataModel.curNumIndex
    DataModel.curNumIndex = index
    for i = 1, group.Page_LvBreak.grid.self.Cells.Count do
      group.Page_LvBreak.grid[i].Btn_ChooseLv:SetEnableAnimator(false)
    end
    grid:HandleScrollEvent(Vector2(grid.ScrollRect.horizontalNormalizedPosition, 0))
    grid:UpdateScale()
    grid:RefreshAllElement()
    Controller:RefreshRight()
  end,
  Group_WeaponBreak_Group_EquipmentBase_Page_LvBreakHide_PageDragBegin = function(dragOffsetPos)
    local group = View.Group_EquipmentBase
    local grid = group.Page_LvBreak.grid.self
    for i = 1, group.Page_LvBreak.grid.self.Cells.Count do
      group.Page_LvBreak.grid[i].Btn_ChooseLv:SetEnableAnimator(false)
    end
    grid:RefreshAllElement()
  end,
  Group_WeaponBreak_Group_EquipmentBase_Page_LvBreakHide_Group_Item_Btn_ChooseLv_Click = function(btn, str)
  end,
  Group_WeaponBreak_Group_Detail_Btn_Close_Click = function(btn, str)
    local function callback()
      View.self:SelectPlayAnim(View.Group_Detail.self, "Group_Detail_Hide", function()
        View.Group_Detail:SetActive(false)
      end)
    end
    
    DataModel:SendEquipLockData(callback)
  end,
  Group_WeaponBreak_Group_Detail_Group_EXPEquip_Btn_Lock_Click = function(btn, str)
    Controller:OnCLickBtnLock()
  end,
  Group_WeaponBreak_Group_Detail_Group_EXPEquip_Btn_Tips_Click = function(btn, str)
  end,
  Group_WeaponBreak_Group_Detail_Group_EXPEquip_ScrollView_Content_Viewport_Content_Btn_Tips1_Click = function(btn, str)
  end,
  Group_WeaponBreak_Group_Right_Group_RequireMiddle_Group_Mat_Btn_Item_Click = function(btn, str)
    CommonTips.OpenItem({itemId = str})
  end
}
return ViewFunction
