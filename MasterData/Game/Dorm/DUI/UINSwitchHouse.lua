local UINSwitchHouse = class("UINSwitchHouse", UIBaseNode)
local base = UIBaseNode
local UINSwitchHouseBtn = require("Game.Dorm.DUI.UINSwitchHouseBtn")

function UINSwitchHouse:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_closeSwitchHouse, self, self.OnHideHouseListClicked)
  UIUtil.AddButtonListener(self.ui.btn_Left, self, self.OnBtnSwitchLeftClicked)
  UIUtil.AddButtonListener(self.ui.btn_Right, self, self.OnBtnSwitchRightClicked)
  self.btnSwtichHouse = UINSwitchHouseBtn.New()
  self.btnSwtichHouse:Init(self.ui.btn_SwitchHouse)
  self._houseItemPool = UIItemPool.New(UINSwitchHouseBtn, self.ui.btn_House, false)
  self._switchHouseClicked = BindCallback(self, self.OnSwitchHouseClicked)
  self._originSize = self.ui.tans_count.sizeDelta
  local ok, newHouseNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Dorm, RedDotStaticTypeId.DormNewHouse)
  if ok then
    self._newHouseListener = BindCallback(self, self.__RefreshSwitchHouseReddot)
    RedDotController:AddListener(newHouseNode.nodePath, self._newHouseListener)
  end
end

function UINSwitchHouse:InitSwitchNode(dormCtrl, curHouse)
  self.dormCtrl = dormCtrl
  if not self.dormCtrl:IsSelfDorm() then
    return
  end
  local iconIdx = curHouse:GetDmHouseIconIdx()
  self.btnSwtichHouse:InitSwitchHouse(curHouse.id, curHouse:GetName(), iconIdx, BindCallback(self, self.OnShowHouseListClicked))
  self:UpdDmSwitchUI(curHouse)
  self:__RefreshSwitchHouseReddot()
end

function UINSwitchHouse:UpdDmSwitchUI(curHouse)
  local allDormData = self.dormCtrl.allDormData
  local count = #allDormData.houseIdList
  self.ui.tans_count.sizeDelta = Vector2.New(self._originSize.x * count, self._originSize.y)
  local index
  for i, houseId in pairs(allDormData.houseIdList) do
    if houseId == curHouse.id then
      index = i
    end
  end
  self._houseIndex = index
  self.ui.obj_CurrNum.anchoredPosition = Vector2.New((index - 1) * self._originSize.x, 0)
end

function UINSwitchHouse:OnShowHouseListClicked()
  self.btnSwtichHouse:SetSwitchHouseReddot(false)
  self.btnSwtichHouse:ShowSwitchHouseBlueDot(false)
  self.ui.switchBtnList:SetActive(true)
  self._houseItemPool:HideAll()
  local curHouse = self.dormCtrl:GetCurHouse()
  local allDormData = self.dormCtrl.allDormData
  for _, houseId in pairs(allDormData.houseIdList) do
    if houseId ~= curHouse.id then
      local houseData = allDormData.houseDic[houseId]
      local switchHouseItem = self._houseItemPool:GetOne()
      local iconIdx = houseData:GetDmHouseIconIdx()
      switchHouseItem:InitSwitchHouse(houseId, houseData:GetName(), iconIdx, self._switchHouseClicked)
      switchHouseItem:SetSwitchHouseBtnLock(houseData:IsDmHouseLock())
      local isReddot = PlayerDataCenter.dormBriefData:GetDormHouseIsNew(houseId)
      switchHouseItem:SetSwitchHouseReddot(isReddot)
      local showBlueDot = false
      if not isReddot then
        showBlueDot = not houseData:IsDmHouseUnlockableReaded()
      end
      switchHouseItem:ShowSwitchHouseBlueDot(showBlueDot)
    end
  end
end

function UINSwitchHouse:__RefreshSwitchHouseReddot()
  local showReddot = false
  local ok, newHouseNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Dorm, RedDotStaticTypeId.DormNewHouse)
  if ok then
    showReddot = newHouseNode:GetRedDotCount() > 0
    self.btnSwtichHouse:SetSwitchHouseReddot(showReddot)
  end
  self._showReddot = showReddot
  self:_UpdBluedot()
end

function UINSwitchHouse:_UpdBluedot()
  local showBlueDot = false
  if not self._showReddot then
    local dromCtrl = self.dormCtrl
    showBlueDot = dromCtrl.allDormData:IsAnyDmHouseUnlockableUnread()
  end
  self.btnSwtichHouse:ShowSwitchHouseBlueDot(showBlueDot)
end

function UINSwitchHouse:OnHideHouseListClicked()
  self.ui.switchBtnList:SetActive(false)
  self:__RefreshSwitchHouseReddot()
end

function UINSwitchHouse:OnSwitchHouseClicked(houseId, tryBuyNewHouse)
  self.ui.switchBtnList:SetActive(false)
  self.dormCtrl:ChangedDormHouse(houseId, function()
    if tryBuyNewHouse then
      self.dormCtrl:TryBuyNewHouse(houseId)
    end
  end)
  self:__RefreshSwitchHouseReddot()
end

function UINSwitchHouse:OnBtnSwitchLeftClicked()
  local allDormData = self.dormCtrl.allDormData
  self._houseIndex = self._houseIndex - 1
  if self._houseIndex < 1 then
    self._houseIndex = #allDormData.houseIdList
  end
  local houseId = allDormData.houseIdList[self._houseIndex]
  self:OnSwitchHouseClicked(houseId)
end

function UINSwitchHouse:OnBtnSwitchRightClicked()
  local allDormData = self.dormCtrl.allDormData
  self._houseIndex = self._houseIndex + 1
  if self._houseIndex > #allDormData.houseIdList then
    self._houseIndex = 1
  end
  local houseId = allDormData.houseIdList[self._houseIndex]
  self:OnSwitchHouseClicked(houseId)
end

function UINSwitchHouse:OnDelete()
  local ok, newHouseNode = RedDotController:GetRedDotNode(RedDotStaticTypeId.Main, RedDotStaticTypeId.Dorm, RedDotStaticTypeId.DormNewHouse)
  if ok then
    RedDotController:RemoveListener(newHouseNode.nodePath, self._newHouseListener)
  end
  base.OnDelete(self)
end

return UINSwitchHouse
