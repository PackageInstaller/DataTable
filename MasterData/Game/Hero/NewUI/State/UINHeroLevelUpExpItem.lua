local UINHeroLevelUpExpItem = class("UINHeroLevelUpExpItem", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")

function UINHeroLevelUpExpItem:OnInit()
  self.selectedNum = 0
  self.itemNum = nil
  self.exp = nil
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.baseItem = UINBaseItem.New()
  self.baseItem:Init(self.ui.obj_BaseItem)
  UIUtil.AddButtonListener(self.ui.btn_Reduce, self, self.MinusOne)
  self.baseItem.ui.btn_Root.onPress:AddListener(BindCallback(self, self.PressAdd))
  self.ui.btn_Reduce.onPress:AddListener(BindCallback(self, self.PressMinus))
  self.ringPlayback = BindCallback(self, self.PlayRingBack)
end

function UINHeroLevelUpExpItem:InitExpItem(itemData, numChangeFunc)
  local itemCfg = itemData.itemCfg
  self.itemNum = itemData:GetCount()
  self.numChangeFunc = numChangeFunc
  self.exp = itemData:GetActionArg(1)
  self.ui.CanvasGroup.alpha = 1
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(itemCfg.name)
  self.ui.tex_TotalCount:SetIndex(0, tostring(self.itemNum))
  self.baseItem:InitBaseItem(itemCfg, BindCallback(self, self.AddOne))
  self:UpdateSelectedNum()
end

function UINHeroLevelUpExpItem:InitEmptyExpItem(itemId)
  local itemCfg = ConfigData.item[itemId]
  self.ui.CanvasGroup.alpha = 0.5
  self.ui.btn_Reduce.gameObject:SetActive(false)
  self.ui.tex_Name.text = LanguageUtil.GetLocaleText(itemCfg.name)
  self.ui.tex_TotalCount:SetIndex(0, "0")
  self.baseItem:InitBaseItem(itemCfg)
end

function UINHeroLevelUpExpItem:UpdateSelectedNum(num)
  num = num or self.selectedNum
  self.ui.tex_UseCount.text = tostring(num)
  if num == 0 then
    self.ui.btn_Reduce.gameObject:SetActive(false)
  else
    self.ui.btn_Reduce.gameObject:SetActive(true)
  end
  if self.numChangeFunc ~= nil then
    self.numChangeFunc(num)
  end
end

function UINHeroLevelUpExpItem:SetAddExpLimt(maxAddExp, addExp)
  self.addableExp = maxAddExp - addExp
end

function UINHeroLevelUpExpItem:PlayRing()
  self.ui.img_RingAnima.gameObject:SetActive(true)
  local time = self.ui.float_ringTime
  if self.fillTween ~= nil then
    self.fillTween:Kill(true)
  end
  self.ui.img_RingAnima.fillAmount = 0
  self.ui.img_RingAnima.fillClockwise = true
  self.fillTween = self.ui.img_RingAnima:DOFillAmount(1, time)
  self.fillTween:OnComplete(self.ringPlayback)
end

function UINHeroLevelUpExpItem:PlayRingBack()
  local time = self.ui.float_ringTime
  if self.fillTween ~= nil then
    self.fillTween:Kill(true)
  end
  self.ui.img_RingAnima.fillAmount = 1
  self.ui.img_RingAnima.fillClockwise = false
  self.fillTween = self.ui.img_RingAnima:DOFillAmount(0, time)
end

function UINHeroLevelUpExpItem:AddOne()
  if self.selectedNum + 1 > self.itemNum or self.addableExp <= 0 then
    return
  end
  self.selectedNum = self.selectedNum + 1
  self:UpdateSelectedNum()
  self:PlayRing()
end

function UINHeroLevelUpExpItem:PressAdd()
  local pressedTime = self.baseItem.ui.btn_Root:GetPressedTime()
  local addNum = math.ceil(pressedTime * pressedTime / 10)
  if self.selectedNum + addNum >= self.itemNum or addNum * self.exp > self.addableExp then
    local newAddNum = math.min(self.itemNum - self.selectedNum, math.ceil(self.addableExp / self.exp))
    if 0 < newAddNum then
      addNum = newAddNum
    else
      return
    end
  end
  self.selectedNum = self.selectedNum + addNum
  self:UpdateSelectedNum()
  self:PlayRing()
end

function UINHeroLevelUpExpItem:MinusOne()
  if self.selectedNum - 1 < 0 then
    return
  end
  self.selectedNum = self.selectedNum - 1
  self:UpdateSelectedNum()
end

function UINHeroLevelUpExpItem:PressMinus()
  local pressedTime = self.ui.btn_Reduce:GetPressedTime()
  local minusNum = math.ceil(pressedTime * pressedTime / 10)
  if self.selectedNum - minusNum <= 0 then
    self.selectedNum = 0
  else
    self.selectedNum = self.selectedNum - minusNum
  end
  self:UpdateSelectedNum()
end

function UINHeroLevelUpExpItem:CleanAll()
  self.selectedNum = 0
  self:UpdateSelectedNum()
end

function UINHeroLevelUpExpItem:OnDelete()
  if self.fillTween ~= nil then
    self.fillTween:Kill(true)
    self.fillTween = nil
  end
  base.OnDelete(self)
end

return UINHeroLevelUpExpItem
