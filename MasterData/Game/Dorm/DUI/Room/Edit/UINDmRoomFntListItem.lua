local UINDmRoomFntListItem = class("UINDmRoomFntListItem", UIBaseNode)
local base = UIBaseNode

function UINDmRoomFntListItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
  UIUtil.AddButtonListener(self.ui.btn_Tip, self, self._OnClickTip)
end

function UINDmRoomFntListItem:InitDmRoomFntListItem(fntWarehouseData, clickFunc, inBigRoom)
  self.fntWarehouseData = fntWarehouseData
  self.clickFunc = clickFunc
  self._inBigRoom = inBigRoom
  self.ui.comfortLv:SetActive(not fntWarehouseData.isDefaultDmFnt)
  self.ui.num:SetActive(not fntWarehouseData.isDefaultDmFnt)
  if fntWarehouseData.isDefaultDmFnt then
    self.ui.tex_Name.text = fntWarehouseData.name
    self.ui.img_Icon.sprite = CRH:GetSprite(fntWarehouseData.icon)
  else
    self.ui.tex_Comfort.text = tostring(fntWarehouseData.fntCfg.comfort)
    self.ui.tex_Name.text = LanguageUtil.GetLocaleText(fntWarehouseData.itemCfg.name)
    self.ui.img_Icon.sprite = CRH:GetSprite(fntWarehouseData.itemCfg.icon)
  end
  self.ui.obj_img_OnlyBig:SetActive(fntWarehouseData.fntCfg.only_big)
  self:UpdDmRoomFntListItem()
end

function UINDmRoomFntListItem:UpdDmRoomFntListItem()
  local fntNum = self:_GetFntNum()
  local isSet = self._maxNum ~= nil and fntNum == 0 and PlayerDataCenter.itemDic[self.fntWarehouseData.id] ~= nil
  self.ui.isSet:SetActive(isSet)
  if self.fntWarehouseData.isDefaultDmFnt then
    self.ui.buttom.color = Color.white
    return
  end
  self.ui.tex_Num.text = tostring(fntNum)
  self.ui.buttom.color = 0 < fntNum and Color.white or Color.gray
  if not self._inBigRoom and self.fntWarehouseData.fntCfg.only_big then
    self.ui.buttom.color = Color.gray
  end
end

function UINDmRoomFntListItem:SetDmRoomFntListItemMaxNum(maxNum)
  self._maxNum = maxNum
end

function UINDmRoomFntListItem:_GetFntNum()
  local num = self.fntWarehouseData.count
  if self._maxNum ~= nil then
    num = math.min(num, self._maxNum)
  end
  return num
end

function UINDmRoomFntListItem:_OnClickRoot()
  if self.clickFunc ~= nil then
    self.clickFunc(self.fntWarehouseData, self)
  end
end

function UINDmRoomFntListItem:_OnClickTip()
  UIManager:ShowWindowAsync(UIWindowTypeID.DormItemDetail, function(win)
    if win == nil then
      return
    end
    win:InitDormDetail(self.fntWarehouseData, false)
  end)
end

function UINDmRoomFntListItem:OnDelete()
  base.OnDelete(self)
end

return UINDmRoomFntListItem
