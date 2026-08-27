local UIHeadItem = class("UIHeadItem", UIBaseNode)
local base = UIHeadItem
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")

function UIHeadItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_HeadItem, self, self.ChangePicAction)
  self.userHeadNode = UINUserHead.New()
  self.userHeadNode:Init(self.ui.obj_UINUserHead)
end

function UIHeadItem:InitHeadItem(itemCfg, clickEvent, resloader, frameEffectPool)
  if itemCfg == nil then
    self.clickFun = nil
    return
  end
  self.clickFun = clickEvent
  self.itemCfg = itemCfg
  if self.itemCfg.count > 0 then
    self.ui.headItemLock:SetActive(false)
  else
    self.ui.headItemLock:SetActive(true)
  end
  if self.itemCfg.itype == eItemType.Avatar then
    self.userHeadNode:InitBaseHead(self.itemCfg.id, resloader, frameEffectPool)
  else
    self.userHeadNode:InitBaseHeadFrame(self.itemCfg.id, resloader, frameEffectPool)
  end
  self.ui.img_HeadSel:SetActive(false)
  self.outTime = -1
  self:SetLimtTimeDetailActive(false)
end

function UIHeadItem:InitOutTime(outTime)
  self.outTime = outTime
  self:UpdateLimitTimeDetail()
end

function UIHeadItem:ChangePicAction()
  if self.clickFun ~= nil then
    self.clickFun(self.itemCfg, self)
  end
end

function UIHeadItem:SetLimtTimeDetailActive(bValue)
  if self.ui.obj_Time ~= nil and self.ui.obj_Time.activeSelf ~= bValue then
    self.ui.obj_Time:SetActive(bValue)
  end
end

function UIHeadItem:UpdateLimitTimeDetail()
  if self.outTime == -1 then
    self:SetLimtTimeDetailActive(false)
    return
  end
  self:SetLimtTimeDetailActive(true)
  local diffTime = self.outTime - PlayerDataCenter.timestamp
  if 0 < diffTime then
    local d, h, m, s = TimeUtil:TimestampToTimeInter(diffTime, false, true)
    if 0 < d then
      self.ui.tex_Time:SetIndex(0, tostring(d))
    elseif 0 < h then
      self.ui.tex_Time:SetIndex(1, tostring(h))
    else
      self.ui.tex_Time:SetIndex(1, tostring(1))
    end
  else
    self.ui.tex_Time:SetIndex(2)
  end
end

function UIHeadItem:OnDelete()
  base.OnDelete(self)
end

return UIHeadItem
