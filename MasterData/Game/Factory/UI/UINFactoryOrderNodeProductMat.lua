local UINFactoryOrderNodeProductMat = class("UINFactoryOrderNodeProductMat", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")
local MAX_MAT = 3

function UINFactoryOrderNodeProductMat:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_matItem, self, self.OnClickMatItem)
end

function UINFactoryOrderNodeProductMat:InitProductMat(itemCfg, index)
  self.itemCfg = itemCfg
  if index == MAX_MAT then
    self.ui.img_Sign:SetIndex(1)
  end
  if itemCfg == nil then
    self.ui.img_Empty:SetActive(true)
    self.ui.normal:SetActive(false)
    return
  else
    self.ui.img_Empty:SetActive(false)
    self.ui.normal:SetActive(true)
  end
  self.ui.img_Icon.sprite = CRH:GetSpriteByItemConfig(itemCfg)
  self:SetCost(0)
end

function UINFactoryOrderNodeProductMat:InitProductOut(itemCfg)
  self.itemCfg = itemCfg
  self.ui.img_Icon.sprite = CRH:GetSpriteByItemConfig(itemCfg)
end

function UINFactoryOrderNodeProductMat:SetCost(num, isShowUse)
  local itemNum = PlayerDataCenter:GetItemCount(self.itemCfg.id)
  if num == 0 and itemNum == 0 or num > itemNum then
    if isShowUse then
      self.ui.tex_Count:SetIndex(2, tostring(itemNum), tostring(num))
    else
      self.ui.tex_Count:SetIndex(0, tostring(itemNum), tostring(num))
    end
    self.ui.imgInfo_normal:SetIndex(1)
    self.ui.obj_CapacityInsufficient:SetActive(true)
  else
    if isShowUse then
      self.ui.tex_Count:SetIndex(3, tostring(itemNum), tostring(num))
    else
      self.ui.tex_Count:SetIndex(1, tostring(itemNum), tostring(num))
    end
    self.ui.imgInfo_normal:SetIndex(0)
    self.ui.obj_CapacityInsufficient:SetActive(false)
  end
end

function UINFactoryOrderNodeProductMat:OnClickMatItem()
  if self.itemCfg ~= nil then
    local window = UIManager:ShowWindow(UIWindowTypeID.GlobalItemDetail)
    window:InitCommonItemDetail(self.itemCfg)
  end
end

function UINFactoryOrderNodeProductMat:OnDelete()
  base.OnDelete(self)
end

return UINFactoryOrderNodeProductMat
