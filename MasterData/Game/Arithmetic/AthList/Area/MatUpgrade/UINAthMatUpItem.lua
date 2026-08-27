local UINAthMatUpItem = class("UINAthMatUpItem", UIBaseNode)
local base = UIBaseNode

function UINAthMatUpItem:OnInit()
  self.selectedNum = 0
  self.itemNum = nil
  self.exp = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Minus, self, self.MinusOne)
  UIUtil.AddButtonListener(self.ui.btn_Add, self, self.AddOne)
  self.ui.btn_Add.onPress:AddListener(BindCallback(self, self.PressAdd))
  self.ui.btn_Minus.onPress:AddListener(BindCallback(self, self.PressMinus))
end

function UINAthMatUpItem:InitExpItem(itemData, numChangeFunc, checkItemUseFunc)
  local itemCfg = itemData.itemCfg
  self.id = itemCfg.id
  self.itemNum = itemData:GetCount()
  self.numChangeFunc = numChangeFunc
  self.itemCfg = itemCfg
  self.checkItemUseFunc = checkItemUseFunc
  self.exp = itemData:GetActionArg(1)
  self.ui.CanvasGroup.alpha = 1
  self.ui.tex_TotalCount:SetIndex(0, tostring(self.itemNum))
  self.ui.img_ItemPic.sprite = CRH:GetSpriteByItemConfig(itemCfg)
  self.ui.hasCount.color = itemData:GetColor()
  self:UpdateSelectedNum()
end

function UINAthMatUpItem:InitEmptyExpItem(itemId)
  local itemCfg = ConfigData.item[itemId]
  self.itemCfg = itemCfg
  self.id = itemId
  self.itemNum = nil
  self.exp = nil
  self.ui.obj_UseCount.gameObject:SetActive(false)
  self.ui.CanvasGroup.alpha = 0.5
  self.ui.btn_Minus.gameObject:SetActive(false)
  self.ui.tex_TotalCount:SetIndex(0, "0")
  self.ui.img_ItemPic.sprite = CRH:GetSpriteByItemConfig(itemCfg)
  self.ui.hasCount.color = ItemQualityColor[itemCfg.quality]
end

function UINAthMatUpItem:UpdateSelectedNum(num)
  num = num or self.selectedNum
  self.ui.tex_UseCount.text = tostring(num)
  if num == 0 then
    self.ui.btn_Minus.gameObject:SetActive(false)
    self.ui.obj_UseCount.gameObject:SetActive(false)
  else
    self.ui.btn_Minus.gameObject:SetActive(true)
    self.ui.obj_UseCount.gameObject:SetActive(true)
  end
  if self.numChangeFunc ~= nil then
    self.numChangeFunc(num)
  end
end

function UINAthMatUpItem:SetAddExpLimt(maxAddExp, addExp, expLimitFunc)
  self.addableExp = maxAddExp - addExp
  self.expLimitFunc = expLimitFunc
end

function UINAthMatUpItem:AddOne()
  local complete = self:TryAddOne()
  if complete then
    AudioManager:PlayAudioById(1064)
  end
end

function UINAthMatUpItem:TryAddOne()
  if self.itemNum == nil then
    UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
      if win ~= nil then
        win:InitCommonItemDetail(self.itemCfg)
      end
    end)
    return false
  end
  if self.checkItemUseFunc ~= nil then
    local canUse = self.checkItemUseFunc(true)
    if not canUse then
      return false
    end
  end
  if self.addableExp <= 0 then
    if self.expLimitFunc ~= nil then
      self.expLimitFunc()
    end
    return false
  end
  if self.selectedNum + 1 > self.itemNum then
    return false
  end
  self.selectedNum = self.selectedNum + 1
  self:UpdateSelectedNum()
  return true
end

function UINAthMatUpItem:PressAdd()
  if self.itemNum == nil then
    return
  end
  if self.checkItemUseFunc ~= nil then
    local canUse = self.checkItemUseFunc(true)
    if not canUse then
      return
    end
  end
  local pressedTime = self.ui.btn_Add:GetPressedTime()
  local addNum = math.ceil(pressedTime * pressedTime / 5)
  if self.selectedNum + addNum >= self.itemNum or addNum * self.exp > self.addableExp then
    local newAddNum = math.min(self.itemNum - self.selectedNum, math.ceil(self.addableExp / self.exp))
    if 0 < newAddNum then
      addNum = newAddNum
    else
      return
    end
  end
  AudioManager:PlayAudioById(1064)
  self.selectedNum = self.selectedNum + addNum
  self:UpdateSelectedNum()
end

function UINAthMatUpItem:MinusOne()
  if self.selectedNum - 1 < 0 then
    return
  end
  self.selectedNum = self.selectedNum - 1
  AudioManager:PlayAudioById(1065)
  self:UpdateSelectedNum()
end

function UINAthMatUpItem:PressMinus()
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

function UINAthMatUpItem:CleanAll()
  self.selectedNum = 0
  self:UpdateSelectedNum()
end

function UINAthMatUpItem:GetHeroLvUpItemId()
  return self.id
end

function UINAthMatUpItem:OnDelete()
  if self.fillTween ~= nil then
    self.fillTween:Kill(true)
    self.fillTween = nil
  end
  base.OnDelete(self)
end

return UINAthMatUpItem
