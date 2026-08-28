local View = require("UIChoseBG/UIChoseBGView")
local DataModel = require("UIChoseBG/UIChoseBGDataModel")

local function SetActive(node, value)
  if node == nil then
    return
  end
  if node.SetActive then
    node:SetActive(value)
    return
  end
  if node.self and node.self.SetActive then
    node.self:SetActive(value)
  end
end

local function SetText(node, value)
  if node == nil then
    return
  end
  if node.SetText then
    node:SetText(value or "")
    return
  end
  if node.self and node.self.SetText then
    node.self:SetText(value or "")
  end
end

local function SetSprite(node, value)
  if node == nil or value == nil or value == "" then
    return
  end
  if node.SetSprite then
    node:SetSprite(value)
    return
  end
  if node.self and node.self.SetSprite then
    node.self:SetSprite(value)
  end
end

local function SetClickParam(node, value)
  if node == nil then
    return
  end
  if node.SetClickParam then
    node:SetClickParam(value)
    return
  end
  if node.self and node.self.SetClickParam then
    node.self:SetClickParam(value)
  end
end

local function SetNativeSize(node)
  if node == nil then
    return
  end
  if node.SetNativeSize then
    node:SetNativeSize()
    return
  end
  if node.self and node.self.SetNativeSize then
    node.self:SetNativeSize()
  end
end

local function SetLocalPosition(node, x, y)
  if node == nil then
    return
  end
  x = tonumber(x) or 0
  y = tonumber(y) or 0
  if node.SetLocalPosition then
    node:SetLocalPosition(Vector3(x, y, 0))
    return
  end
  if node.SetAnchoredPosition then
    node:SetAnchoredPosition(Vector2(x, y))
    return
  end
  if node.self and node.self.SetLocalPosition then
    node.self:SetLocalPosition(Vector3(x, y, 0))
  end
end

local function SetLocalPositionX(node, x)
  if node == nil then
    return
  end
  x = tonumber(x) or 0
  if node.SetLocalPositionX then
    node:SetLocalPositionX(x)
    return
  end
  if node.SetAnchoredPositionX then
    node:SetAnchoredPositionX(x)
    return
  end
  if node.self and node.self.SetLocalPositionX then
    node.self:SetLocalPositionX(x)
  end
end

local function RefreshBgPic(group, bgPicList)
  if group == nil then
    return
  end
  local hasPic = false
  bgPicList = bgPicList or {}
  for index = 1, 4 do
    local img = group["Img_" .. index]
    local info = bgPicList[index]
    local show = info ~= nil and info.path ~= nil and info.path ~= ""
    SetActive(img, show)
    if show then
      hasPic = true
      SetSprite(img, info.path)
      SetNativeSize(img)
      SetLocalPosition(img, info.pathX, info.pathY)
    end
  end
  SetActive(group, hasPic)
end

local function RefreshLockBG(row)
  local showLock = row ~= nil and (row.sceneCount or 0) > 1
  SetActive(View.Group_LockBG, showLock)
  if not showLock then
    return
  end
  local btn = View.Group_LockBG.Btn_Lock
  local isLock = row.isLock == true
  SetActive(btn.Img_On, isLock)
  SetActive(btn.Img_Off, not isLock)
  SetLocalPositionX(btn.Img_Bar, isLock and 23.2 or -26)
end

local function RefreshRoomBackDisplay(row)
  if row == nil then
    RefreshBgPic(View.Group_BgPic, nil)
    return
  end
  SetSprite(View.Btn_BG and View.Btn_BG.Img_BG, row.bgPath)
  RefreshBgPic(View.Group_BgPic, row.bgPicList)
end

local function RefreshGrid(scrollGrid)
  if scrollGrid and scrollGrid.grid and scrollGrid.grid.self then
    scrollGrid.grid.self:SetDataCount(#DataModel.RoomBackList)
    scrollGrid.grid.self:RefreshAllElement()
    if DataModel.NeedMoveToSelectIndex then
      scrollGrid.grid.self:MoveToPos(DataModel.SelectIndex)
      DataModel.NeedMoveToSelectIndex = false
    elseif DataModel.NeedMoveToTop then
      scrollGrid.grid.self:MoveToTop()
      DataModel.NeedMoveToTop = false
    end
  end
end

local function OpenLockedTips()
  if CommonTips and CommonTips.OpenTips then
    CommonTips.OpenTips(80608959)
  end
end

local function RefreshOpenedRoomBack()
  if UIManager and UIManager.IsPanelOpened and not UIManager:IsPanelOpened("UI/CharacterInfo/ChangePosterGirl/ChangePosterGirl") then
    return
  end
  local bgPath = DataModel.GetCurrentRoomBackBgPath()
  if bgPath == "" then
    return
  end
  local okChangeView, changeView = pcall(require, "UIChangePosterGirl/UIChangePosterGirlView")
  if okChangeView and changeView.Img_MeetingRoom then
    SetSprite(changeView.Img_MeetingRoom, bgPath)
    RefreshBgPic(changeView.Group_BgPic, DataModel.GetCurrentRoomBackBgPicList())
  end
end

local function RefreshShow()
  local row = DataModel.GetSelectedRow()
  local hasRow = row ~= nil
  local canEquip = hasRow and row.isHave and not row.isWear
  local canUnlockOrJump = hasRow and not row.isHave and (row.hasBgCost or row.hasGetWay)
  SetActive(View.Group_Show, hasRow)
  SetActive(View.Group_Tips, false)
  SetActive(View.Group_SkinCho and View.Group_SkinCho.Btn_Sale, canEquip)
  SetActive(View.Group_SkinCho and View.Group_SkinCho.Btn_Trun, canUnlockOrJump)
  SetActive(View.Btn_Confirm, canEquip)
  RefreshRoomBackDisplay(row)
  RefreshLockBG(row)
  if not hasRow then
    return
  end
  SetSprite(View.Group_Show.Img_Gift, row.bgPath ~= "" and row.bgPath or row.previewPath)
  SetActive(View.Group_Show.Img_jianbian, row.isWear)
  View.Group_Show.Group_Name.Txt_:SetText(row.bgName)
  SetText(View.Group_Tips and View.Group_Tips.Txt_Tips, row.desc)
end

local function RefreshAll()
  DataModel.RefreshRoomBackStates()
  RefreshGrid(View.Group_SkinCho and View.Group_SkinCho.ScrollGrid_List)
  RefreshShow()
end

local function TurnToRoomBackGetWay()
  local row = DataModel.GetSelectedRow()
  if row == nil or row.isHave or not row.hasGetWay then
    return
  end
  local getwayIndex = DataModel.GetFirstGetWayIndex(row.getwayList)
  if getwayIndex == nil then
    return
  end
  local getwayDataModel = require("UIGroup_GetWay/UIGroup_GetWayDataModel")
  getwayDataModel.isTrainWeapon = DataManager:GetFactoryNameById(row.id) == "HomeWeaponFactory"
  getwayDataModel.getwayList = row.getwayList
  getwayDataModel.goback_num = 1
  DataModel.MarkReturnSelectRoomBackId(row.id)
  local getwayViewFunction = require("UIGroup_GetWay/UIGroup_GetWayViewFunction")
  getwayViewFunction.Group_GetWay_Img_WayBg_ScrollGrid__Group_Item_Group_Forward_Btn_Forward_Click(nil, tostring(getwayIndex))
end

local function OpenRoomBackUnlock()
  local row = DataModel.GetSelectedRow()
  if row == nil or row.isHave then
    return
  end
  if row.hasBgCost then
    local costCfg = PlayerData:GetFactoryData(row.bgCost, "ListFactory")
    if costCfg == nil or costCfg.materialList == nil or #costCfg.materialList == 0 then
      if row.hasGetWay then
        TurnToRoomBackGetWay()
      else
        OpenLockedTips()
      end
      return
    end
    UIManager:Open("UI/CharacterInfo/ChangePosterGirl/UnlockedChoose", Json.encode({
      source = "RoomBack",
      itemId = tostring(row.id),
      costId = row.bgCost,
      unlockProto = "main.unlock_room_back",
      indexOffset = -1
    }))
    return
  end
  TurnToRoomBackGetWay()
end

local function SelectRoomBack(index)
  if DataModel.SelectRoomBack(index) then
    RefreshAll()
  end
end

local function ConfirmRoomBack()
  local row = DataModel.GetSelectedRow()
  if row == nil then
    return
  end
  if not row.isHave then
    OpenLockedTips()
    return
  end
  if row.isWear then
    return
  end
  DataModel.SetSelectedAsCurrent(function(success)
    RefreshAll()
    if success then
      RefreshOpenedRoomBack()
      UIManager:GoBack(false)
    end
  end)
end

local ViewFunction = {
  ChoseBG_Btn_BG_Click = function(btn, str)
    UIManager:GoBack(false)
  end,
  ChoseBG_Group_CommonTopLeft_Btn_Return_Click = function(btn, str)
    UIManager:GoBack(false)
  end,
  ChoseBG_Group_CommonTopLeft_Btn_Home_Click = function(btn, str)
    UIManager:GoHome()
  end,
  ChoseBG_Group_CommonTopLeft_Btn_Menu_Click = function(btn, str)
  end,
  ChoseBG_Group_CommonTopLeft_Btn_Help_Click = function(btn, str)
  end,
  ChoseBG_Group_Show_Btn_Check_Click = function(btn, str)
  end,
  ChoseBG_ScrollGrid_List_SetGrid = function(element, elementIndex)
  end,
  ChoseBG_ScrollGrid_List_Group_Item_Group_Item_Btn_Item_Click = function(btn, str)
  end,
  ChoseBG_Group_SkinCho_ScrollGrid_List_SetGrid = function(element, elementIndex)
    local row = DataModel.RoomBackList[tonumber(elementIndex)]
    if row == nil then
      return
    end
    SetClickParam(element.Btn_, elementIndex)
    SetSprite(element.Img_Mask and element.Img_Mask.Img_, row.previewPath)
    SetText(element.Txt_Name, row.name)
    SetActive(element.Img_cho, row.isSelect)
    SetActive(element.Img_Chose, row.isWear)
    SetActive(element.Img_Lock, not row.isHave)
  end,
  ChoseBG_Group_SkinCho_ScrollGrid_List_Group_Item_Btn__Click = function(btn, str)
    SelectRoomBack(str)
  end,
  ChoseBG_Group_SkinCho_Btn_Sale_Click = function(btn, str)
    ConfirmRoomBack()
  end,
  ChoseBG_Group_SkinCho_Btn_Trun_Click = function(btn, str)
    OpenRoomBackUnlock()
  end,
  ChoseBG_Btn_Confirm_Click = function(btn, str)
    ConfirmRoomBack()
  end,
  ChoseBG_Group_LockBG_Btn_Lock_Click = function(btn, str)
    if DataModel.ToggleSelectedRoomBackLock() then
      RefreshShow()
      RefreshOpenedRoomBack()
    end
  end,
  ChoseBG_Group_LockBG_Btn_SceneChange_Click = function(btn, str)
    if DataModel.SwitchSelectedRoomBackScene() then
      RefreshShow()
      RefreshOpenedRoomBack()
    end
  end,
  ChoseBG_Btn_Cancel_Click = function(btn, str)
    UIManager:GoBack(false)
  end,
  ChoseBG_Btn_Sale_Click = function(btn, str)
    ConfirmRoomBack()
  end,
  ChoseBG_Btn_Trun_Click = function(btn, str)
    OpenRoomBackUnlock()
  end
}
ViewFunction.RefreshAll = RefreshAll
ViewFunction.RefreshShow = RefreshShow
ViewFunction.RefreshOpenedRoomBack = RefreshOpenedRoomBack
return ViewFunction
