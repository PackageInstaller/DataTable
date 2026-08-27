local UINBaseItemWithCount = class("UINBaseItemWithCount", UIBaseNode)
local base = UIBaseNode
local UINBaseItem = require("Game.CommonUI.Item.UINBaseItem")

function UINBaseItemWithCount:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.baseItem = UINBaseItem.New()
  self.baseItem:Init(self.ui.uINBaseItem)
end

function UINBaseItemWithCount:InitItemWithCount(itemCfg, count, clickEvent, wareHouseNum, clickExtrEvent, isHideLoopFx)
  if self.ui.obj_Empty ~= nil then
    if itemCfg == nil then
      self.ui.obj_Empty:SetActive(true)
      self.baseItem:Hide()
      return
    else
      self.ui.obj_Empty:SetActive(false)
      self.baseItem:Show()
    end
  end
  self.itemCfg = itemCfg
  self.baseItem:InitBaseItem(itemCfg, clickEvent, clickExtrEvent, isHideLoopFx)
  self:SetNum(count, nil, wareHouseNum)
  if self.ui.tex_ItemName ~= nil then
    self.ui.tex_ItemName.text = tostring(LanguageUtil.GetLocaleText(itemCfg.name))
  end
end

function UINBaseItemWithCount:ShowLimtTimeDetail(outTime)
  self.baseItem:ShowLimtTimeDetail(outTime)
end

function UINBaseItemWithCount:EnableButton(flag)
  if self.baseItem ~= nil then
    self.baseItem:EnableButton(flag)
  end
end

function UINBaseItemWithCount:SetNum(count, notAutoHide, wareHouseNum)
  if count == nil then
    if not notAutoHide and not IsNull(self.ui.count) then
      self.ui.count:SetActive(false)
    end
  elseif wareHouseNum ~= nil then
    self.ui.count:SetActive(true)
    if count <= wareHouseNum then
      self.ui.tex_TotalCount:SetIndex(1, tostring(wareHouseNum), tostring(count))
    else
      self.ui.tex_TotalCount:SetIndex(2, tostring(wareHouseNum), tostring(count))
    end
  else
    self.ui.count:SetActive(true)
    if self.ui.tex_TotalCount.SetIndex ~= nil then
      self.ui.tex_TotalCount:SetIndex(0, tostring(count))
    else
      self.ui.tex_TotalCount.text = tostring(count)
    end
  end
end

function UINBaseItemWithCount:BindAthItemUid(uid)
  self.baseItem:BindAthItemUid(uid)
end

function UINBaseItemWithCount:BindClickCustomArg(arg)
  self.baseItem:BindClickCustomArg(arg)
end

function UINBaseItemWithCount:BindBaseItemResloader(resloader)
  self.baseItem:BindBaseItemResloader(resloader)
end

function UINBaseItemWithCount:SetFade(value)
  self.ui.Fade.alpha = value
end

function UINBaseItemWithCount:GetFade()
  return self.ui.Fade
end

function UINBaseItemWithCount:SetNotNeedAnyJump(bool)
  self.baseItem:SetNotNeedAnyJump(bool)
end

function UINBaseItemWithCount:LoadGetRewardFx(resloader, xRotate)
  self.baseItem:LoadGetRewardFx(resloader, xRotate)
end

function UINBaseItemWithCount:LoadGetGreatRewardFx(resloader, xRotate)
  self.baseItem:LoadGetGreatRewardFx(resloader, xRotate)
end

function UINBaseItemWithCount:LoadGetGreatRewardLoopFx(xRotate)
  self.baseItem:LoadGetGreatRewardLoopFx(xRotate)
end

function UINBaseItemWithCount:CloseGreatRewardLoopFx()
  self.baseItem:CloseGreatRewardLoopFx()
end

function UINBaseItemWithCount:CloseQualityFx()
  self.baseItem:CloseQualityFx()
end

function UINBaseItemWithCount:SetItemRecycyleTag(bool)
  self.baseItem:SetItemRecycyleTag(bool)
end

function UINBaseItemWithCount:SetItemFragTag(bool)
  self.baseItem:SetItemFragTag(bool)
end

function UINBaseItemWithCount:SetHasFlagObjActive(bValue)
  self.baseItem:SetHasFlagObjActive(bValue)
end

function UINBaseItemWithCount:OnDelete()
  self.baseItem:Delete()
  base.OnDelete(self)
end

return UINBaseItemWithCount
