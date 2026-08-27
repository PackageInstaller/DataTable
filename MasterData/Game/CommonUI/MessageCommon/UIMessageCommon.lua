local UIMessageCommon = class("UIMessageCommon", UIBaseWindow)
local base = UIBaseWindow
local UINMsgCommonItem = require("Game.CommonUI.MessageCommon.UINMsgCommonItem")

function UIMessageCommon:OnInit()
  self.__permanent = true
  UIUtil.AddButtonListener(self.ui.btnClose, self, self._OnClickClose)
  UIUtil.AddButtonListener(self.ui.buttonConfirm, self, self._OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.buttonNo, self, self._OnClickNo)
  UIUtil.AddButtonListener(self.ui.buttonYes, self, self._OnClickYes)
  self.ui.extrItem.gameObject:SetActive(false)
  self.extraItemPool = UIItemPool.New(UINMsgCommonItem, self.ui.extrItem)
  self.ui.tex_BtnYes:SetIndex(0)
end

function UIMessageCommon:_Reset()
  self.ui.textNode:SetActive(false)
  self.ui.itemNode:SetActive(false)
  self.ui.yesNoNode:SetActive(false)
  self.ui.btnClose.gameObject:SetActive(false)
  self.ui.buttonConfirm.gameObject:SetActive(false)
  self.ui.textRemind:SetActive(false)
  self.ui.obj_Arrow:SetActive(false)
  self.extraItemPool:HideAll()
  self.ui.itemARoot:SetActive(false)
  self.ui.itemBRoot:SetActive(false)
  self.ui.buttonYes.interactable = true
end

function UIMessageCommon:_ShowItemCostInternal(itemId, costNum, itemNum)
  self.ui.itemNode:SetActive(true)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    error("Cant get itemCfg, id = " .. tostring(itemId))
    return
  end
  self.ui.itemARoot:SetActive(true)
  local itemA = self.extraItemPool:GetOne()
  itemA.transform:SetParent(self.ui.itemARoot.transform)
  itemA.transform:SetAsLastSibling()
  itemA:InitMsgCommonItem(itemCfg, costNum, itemNum)
end

function UIMessageCommon:_ShowItemGetInternal(itemId, num)
  local itemCfg = ConfigData.item[itemId]
  if itemCfg == nil then
    error("Cant get itemCfg, id = " .. tostring(itemId))
    return
  end
  self.ui.itemBRoot:SetActive(true)
  local itemB = self.extraItemPool:GetOne()
  itemB.transform:SetParent(self.ui.itemBRoot.transform)
  itemB.transform:SetAsLastSibling()
  itemB:InitMsgCommonItem(itemCfg, nil, num)
end

function UIMessageCommon:_ShowItemCostAnyInternal(msg, itemListId, costListNum)
  self.ui.itemNode:SetActive(true)
  self.ui.tex_ItemContent.text = msg
  if itemListId == nil or #itemListId == 0 then
    return
  end
  self.ui.itemARoot:SetActive(true)
  for index, itemId in pairs(itemListId) do
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      error("Cant get itemCfg, id = " .. tostring(itemId))
      return
    end
    local itemA = self.extraItemPool:GetOne()
    itemA.transform:SetParent(self.ui.itemARoot.transform)
    itemA.transform:SetAsLastSibling()
    itemA:InitMsgCommonItem(itemCfg, costListNum[index] or 0)
  end
end

function UIMessageCommon:ShowItemCostConfirm(msg, itemId, costNum, confirmFunc, onlyShowCostNum)
  self:_Reset()
  if onlyShowCostNum then
    self:_ShowItemCostInternal(itemId, nil, costNum)
  else
    self:_ShowItemCostInternal(itemId, costNum)
  end
  self.ui.tex_ItemContent.text = msg
  self.ui.buttonConfirm.gameObject:SetActive(true)
  self.confirmFunc = confirmFunc
end

function UIMessageCommon:ShowItemCost(msg, itemId, costNum, yesFunc, noFunc, onlyShowCostNum)
  self:_Reset()
  if onlyShowCostNum then
    self:_ShowItemCostInternal(itemId, nil, costNum)
  else
    self:_ShowItemCostInternal(itemId, costNum)
  end
  self.ui.tex_ItemContent.text = msg
  self.ui.yesNoNode:SetActive(true)
  self.yesFunc = yesFunc
  self.noFunc = noFunc
end

function UIMessageCommon:ShowItemCostAny(msg, itemListId, costListNum, yesFunc, noFunc)
  self:_Reset()
  self:_ShowItemCostAnyInternal(msg, itemListId, costListNum)
  self.ui.yesNoNode:SetActive(true)
  self.yesFunc = yesFunc
  self.noFunc = noFunc
end

function UIMessageCommon:ShowItemCost2(msg, itemId, costNum, itemId2, costNum2, yesFunc, noFunc)
  self:_Reset()
  self:_ShowItemCostAnyInternal(msg, {itemId, itemId2}, {costNum, costNum2})
  self.ui.yesNoNode:SetActive(true)
  self.yesFunc = yesFunc
  self.noFunc = noFunc
end

function UIMessageCommon:ShowItemConvert(msg, srcIdList, srcNumList, tarIdList, tarNumList, yesFunc, noFunc)
  self:_Reset()
  self.ui.tex_ItemContent.text = msg
  for k, itemId in ipairs(srcIdList) do
    local costNum = srcNumList[k]
    self:_ShowItemCostInternal(itemId, nil, costNum)
  end
  self.ui.obj_Arrow:SetActive(true)
  for k, itemId in ipairs(tarIdList) do
    local num = tarNumList[k]
    self:_ShowItemGetInternal(itemId, num)
  end
  self.ui.yesNoNode:SetActive(true)
  self.yesFunc = yesFunc
  self.noFunc = noFunc
end

function UIMessageCommon:ShowItemCostAnyConfirm(msg, itemListId, costListNum, confirmFunc)
  self:_Reset()
  self:_ShowItemCostAnyInternal(msg, itemListId, costListNum)
  self.ui.buttonConfirm.gameObject:SetActive(true)
  self.confirmFunc = confirmFunc
end

function UIMessageCommon:ShowItemCost2Confirm(msg, itemId1, costNum1, itemId2, costNum2, confirmFunc)
  self:_Reset()
  self:_ShowItemCostAnyInternal(msg, {itemId1, itemId2}, {costNum1, costNum2})
  self.ui.buttonConfirm.gameObject:SetActive(true)
  self.confirmFunc = confirmFunc
end

function UIMessageCommon:ShowTextBox(msg)
  self:_Reset()
  local hasMsg = msg ~= nil
  self.ui.itemNode:SetActive(not hasMsg)
  self.ui.textNode:SetActive(hasMsg)
  self.ui.tex_Content.text = msg
  self.ui.yesNoNode:SetActive(false)
  self.ui.buttonConfirm.gameObject:SetActive(false)
  self.ui.btnClose.gameObject:SetActive(false)
end

function UIMessageCommon:ShowTextBoxWithConfirm(msg, comfirmFunc)
  self:_Reset()
  self:ShowTextBox(msg)
  self.ui.buttonConfirm.gameObject:SetActive(true)
  self.confirmFunc = comfirmFunc
end

function UIMessageCommon:ShowTextBoxWithClose(msg, closeFunc)
  self:_Reset()
  self:ShowTextBox(msg)
  self.ui.btnClose.gameObject:SetActive(true)
  self.closeFunc = closeFunc
end

function UIMessageCommon:ShowTextBoxWithYesAndNo(msg, yesFunc, noFunc, withYesWait)
  self:_Reset()
  self:ShowTextBox(msg)
  self.ui.yesNoNode:SetActive(true)
  self.yesFunc = yesFunc
  self.noFunc = noFunc
  if withYesWait then
    self.ui.buttonYes.interactable = false
    local time = 3
    self.ui.tex_BtnYes:SetIndex(1, tostring(time))
    self:_ClearBtnYesTimer()
    self._btnYesTimerId = TimerManager:StartTimer(1, function()
      time = time - 1
      if 0 < time then
        self.ui.tex_BtnYes:SetIndex(1, tostring(time))
      else
        self.ui.buttonYes.interactable = true
        self.ui.tex_BtnYes:SetIndex(0)
        self:_ClearBtnYesTimer()
      end
    end)
  else
    self.ui.tex_BtnYes:SetIndex(0)
  end
end

function UIMessageCommon:_ClearBtnYesTimer()
  if self._btnYesTimerId == nil then
    return
  end
  TimerManager:StopTimer(self._btnYesTimerId)
  self._btnYesTimerId = nil
end

function UIMessageCommon:ShowDontRemindTog(callback, isOn)
  self.dontRemindFunc = callback
  self.ui.textRemind:SetActive(true)
  self.ui.tog_RemindSwitch.isOn = isOn or false
end

function UIMessageCommon:OnClickClose()
  self:_OnClickClose()
end

function UIMessageCommon:_OnClickClose()
  self:Hide()
  if self.closeFunc ~= nil then
    local func = self.closeFunc
    self.closeFunc = nil
    func()
  end
end

function UIMessageCommon:_OnClickConfirm()
  self:Hide()
  if self.confirmFunc ~= nil then
    local func = self.confirmFunc
    self.confirmFunc = nil
    func()
  end
  if self.dontRemindFunc ~= nil then
    local func = self.dontRemindFunc
    self.dontRemindFunc = nil
    func(self.ui.tog_RemindSwitch.isOn)
  end
end

function UIMessageCommon:OnClickNo()
  self:_OnClickNo()
end

function UIMessageCommon:_OnClickNo()
  self:Hide()
  if self.noFunc ~= nil then
    local func = self.noFunc
    self.noFunc = nil
    self.yesFunc = nil
    func()
  end
end

function UIMessageCommon:_OnClickYes()
  self:Hide()
  if self.yesFunc ~= nil then
    local func = self.yesFunc
    self.yesFunc = nil
    self.noFunc = nil
    func()
  end
  if self.dontRemindFunc ~= nil then
    local func = self.dontRemindFunc
    self.dontRemindFunc = nil
    func(self.ui.tog_RemindSwitch.isOn)
  end
end

function UIMessageCommon:_GetItemA()
  if self.itemA == nil then
    self.itemA = UINMsgCommonItem.New()
    self.itemA:Init(self.ui.extrItemA)
  end
  self.itemA.gameObject:SetActive(true)
  return self.itemA
end

function UIMessageCommon:_GetItemB()
  if self.itemB == nil then
    self.itemB = UINMsgCommonItem.New()
    self.itemB:Init(self.ui.extrItemB)
  end
  self.itemB.gameObject:SetActive(true)
  return self.itemB
end

function UIMessageCommon:OnHide()
  self:_ClearBtnYesTimer()
  base.OnHide(self)
end

function UIMessageCommon:OnDelete()
  base.OnDelete(self)
end

return UIMessageCommon
