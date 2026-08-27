local UINHeroLevelUpItem = class("UINHeroLevelUpItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")

function UINHeroLevelUpItem:OnInit()
  self.selectedNum = 0
  self.itemNum = nil
  self.exp = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.baseItem = UINBaseItem.New()
  self.baseItem:Init(self.ui.uINBaseItem)
  UIUtil.AddButtonListener(self.ui.btn_Minus, self, self.MinusOne)
  self.baseItem.ui.btn_Root.onPress:AddListener(BindCallback(self, self.PressAdd))
  self.ui.btn_Minus.onPress:AddListener(BindCallback(self, self.PressMinus))
end

function UINHeroLevelUpItem:InitExpItem(itemData, numChangeFunc, checkItemUseFunc)
  local itemCfg = itemData.itemCfg
  self.id = itemCfg.id
  self.itemNum = itemData:GetCount()
  self.numChangeFunc = numChangeFunc
  self.checkItemUseFunc = checkItemUseFunc
  self.exp = itemData:GetActionArg(1)
  self.ui.CanvasGroup.alpha = 1
  self.ui.tex_TotalCount:SetIndex(0, tostring(self.itemNum))
  self.baseItem:InitBaseItem(itemCfg, BindCallback(self, self.AddOne))
  self:UpdateSelectedNum()
end

function UINHeroLevelUpItem:InitEmptyExpItem(itemId)
  local itemCfg = ConfigData.item[itemId]
  self.id = itemId
  self.itemNum = nil
  self.exp = nil
  self.ui.obj_UseCount.gameObject:SetActive(false)
  self.ui.CanvasGroup.alpha = 0.5
  self.ui.btn_Minus.gameObject:SetActive(false)
  self.ui.tex_TotalCount:SetIndex(0, "0")
  self.baseItem:InitBaseItem(itemCfg)
end

function UINHeroLevelUpItem:UpdateSelectedNum(num, isForbidCall)
  num = num or self.selectedNum
  self.ui.tex_UseCount.text = tostring(num)
  if num == 0 then
    self.ui.btn_Minus.gameObject:SetActive(false)
    self.ui.obj_UseCount.gameObject:SetActive(false)
  else
    self.ui.btn_Minus.gameObject:SetActive(true)
    self.ui.obj_UseCount.gameObject:SetActive(true)
  end
  if self.numChangeFunc ~= nil and not isForbidCall then
    self.numChangeFunc(num)
  end
end

function UINHeroLevelUpItem:SetAddExpLimt(maxAddExp, addExp)
  self.addableExp = maxAddExp - addExp
  self.addedExp = addExp
end

function UINHeroLevelUpItem:AddOne()
  if self.checkItemUseFunc ~= nil then
    local canUse = self.checkItemUseFunc(true)
    if not canUse then
      return
    end
  end
  if self.selectedNum + 1 > self.itemNum or self.addableExp <= 0 and 0 < self.addedExp then
    return
  end
  AudioManager:PlayAudioById(1064)
  self.selectedNum = self.selectedNum + 1
  self:UpdateSelectedNum()
end

function UINHeroLevelUpItem:PressAdd()
  if self.itemNum == nil then
    return
  end
  if self.checkItemUseFunc ~= nil then
    local canUse = self.checkItemUseFunc(true)
    if not canUse then
      return
    end
  end
  local pressedTime = self.baseItem.ui.btn_Root:GetPressedTime()
  local addNum = math.ceil(pressedTime * pressedTime / 5)
  if self.selectedNum + addNum >= self.itemNum or addNum * self.exp > self.addableExp then
    local remainNum = self.itemNum - self.selectedNum
    local newAddNum = math.min(remainNum, math.ceil(self.addableExp / self.exp))
    if 0 < newAddNum then
      addNum = newAddNum
    elseif self.addedExp == 0 and 0 < remainNum then
      addNum = 1
    else
      return
    end
  end
  AudioManager:PlayAudioById(1064)
  self.selectedNum = self.selectedNum + addNum
  self:UpdateSelectedNum()
end

function UINHeroLevelUpItem:MinusOne()
  if self.selectedNum - 1 < 0 then
    return
  end
  AudioManager:PlayAudioById(1065)
  self.selectedNum = self.selectedNum - 1
  self:UpdateSelectedNum()
end

function UINHeroLevelUpItem:PressMinus()
  local pressedTime = self.ui.btn_Minus:GetPressedTime()
  local minusNum = math.ceil(pressedTime * pressedTime / 10)
  if self.selectedNum - minusNum <= 0 then
    self.selectedNum = 0
  else
    self.selectedNum = self.selectedNum - minusNum
  end
  AudioManager:PlayAudioById(1065)
  self:UpdateSelectedNum()
end

function UINHeroLevelUpItem:CleanAll(isForbidCall)
  self.selectedNum = 0
  self:UpdateSelectedNum(0, isForbidCall)
end

function UINHeroLevelUpItem:GetHeroLvUpItemId()
  return self.id
end

function UINHeroLevelUpItem:OnDelete()
  if self.fillTween ~= nil then
    self.fillTween:Kill(true)
    self.fillTween = nil
  end
  base.OnDelete(self)
end

return UINHeroLevelUpItem
