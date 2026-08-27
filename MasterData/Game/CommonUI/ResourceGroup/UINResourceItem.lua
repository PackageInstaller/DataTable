local UINResourceItem = class("UINResourceItem", UIBaseNode)
local base = UIBaseNode
local smallResSize = Vector2.New(181, 50.62)

function UINResourceItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Add, self, self.OnClickAdd)
  UIUtil.AddButtonListener(self.ui.btn_resourceItem, self, self.OnClickItem)
  self.passiveRefresh = true
  self.__defaultSize = self.transform.sizeDelta
end

function UINResourceItem:InitCurrencyItem(itemCfg)
  self:SetPlayNumberTweenActive(false)
  self.itemCfg = itemCfg
  self.isSmallIconType = itemCfg.small_icon_type
  self.gameObject.name = itemCfg.id
  local isKey = ConstGlobalItem.SKey == self.itemCfg.id
  self.ui.img_Icon.gameObject:SetActive(not isKey)
  self.ui.obj_key_Icon.gameObject:SetActive(isKey)
  if not isKey then
    self.ui.img_Icon.sprite = CRH:GetSprite(itemCfg.small_icon)
    self.ui.btn_Add.gameObject:SetActive(false)
  end
  if itemCfg.small_icon_type then
    self.ui.img_buttom:SetIndex(1)
    self.ui.img_Icon.color = ItemQualityColor[itemCfg.quality]
    self.transform.sizeDelta = smallResSize
  else
    self.ui.img_buttom:SetIndex(0)
    self.ui.img_Icon.color = Color.white
    self.transform.sizeDelta = self.__defaultSize
  end
  self:UpdateCount()
end

function UINResourceItem:SetPassiveRefresh(active)
  self.passiveRefresh = active
end

function UINResourceItem:UpdateCount(setCount)
  self.ui.tex_Count.color = Color.white
  self.ui.tex_RemainTime.transform.parent.gameObject:SetActive(false)
  if setCount ~= nil then
    self.ui.tex_Count.text = tostring(setCount)
    return
  end
  if not self.passiveRefresh then
    return
  end
  if ConstGlobalItem.SKey == self.itemCfg.id then
    if self._UpdateCount == nil then
      self._UpdateCount = BindCallback(self, self.UpdateCount)
      MsgCenter:AddListener(eMsgEventId.StaminaUpdate, self._UpdateCount)
    end
    self.ui.tex_Count.text = tostring(PlayerDataCenter.stamina:GetCurrentStamina()) .. "/" .. tostring(PlayerDataCenter.stamina:GetStaminaCeiling())
    return
  end
  local count = PlayerDataCenter:GetItemCount(self.itemCfg.id)
  if self.itemCfg.link_item_id > 0 then
    count = count + PlayerDataCenter:GetItemCount(self.itemCfg.link_item_id)
  end
  self:_InitRemainTimer()
  if self.itemCfg.id >= 1003 then
    local capcity = PlayerDataCenter.playerBonus:GetWarehouseCapcity(self.itemCfg.id)
    if capcity == nil or capcity == 0 then
      self.ui.tex_Count.text = tostring(count)
    else
      self.ui.tex_Count.text = tostring(count) .. "/" .. tostring(capcity)
    end
  else
    self.ui.tex_Count.text = tostring(count)
  end
  if self.isSmallIconType then
    local cfg = ConfigData.dungeon_material_count[self.itemCfg.id]
    if cfg == nil then
      return
    end
    if count >= cfg.colorCount then
      self.ui.tex_Count.color = Color.New(1, 0.576, 0.08, 1)
    end
  end
  if self._canTween then
    self.ui.tex_Count:StartScrambleTypeWriter()
  end
end

function UINResourceItem:OnClickAdd()
  if self.__ClickAddCallback ~= nil then
    self.__ClickAddCallback()
    return
  end
end

function UINResourceItem:SetAddBtn(bool, addBtnCallback)
  self.ui.btn_Add.gameObject:SetActive(bool)
  if bool then
    self.__ClickAddCallback = addBtnCallback
  else
    self.__ClickAddCallback = nil
  end
end

function UINResourceItem:OnClickItem()
  local window = UIManager:ShowWindow(UIWindowTypeID.GlobalItemDetail)
  if self.parentWindowType ~= nil then
    window:ParentWindowType(self.parentWindowType)
  end
  local linkItemId = self.itemCfg.link_item_id
  if 0 < linkItemId and 0 < PlayerDataCenter:GetItemCount(linkItemId) then
    local itemCfg = ConfigData.item[linkItemId]
    local stackInfo = PlayerDataCenter:GetDynLimtTimeItemStackInfo(linkItemId, 1)
    window:InitLimitTimeItemDetail(itemCfg, stackInfo)
    return
  end
  window:InitCommonItemDetail(self.itemCfg)
end

function UINResourceItem:OnHide()
  self.passiveRefresh = true
end

function UINResourceItem:SetPlayNumberTweenActive(Active)
  self._canTween = true
end

function UINResourceItem:_InitRemainTimer()
  TimerManager:StopTimer(self._remainTimer)
  if self.itemCfg.link_item_id <= 0 then
    self.ui.tex_RemainTime.transform.parent.gameObject:SetActive(false)
    return
  end
  if self:_UpdRemainTimer() then
    self._remainTimer = TimerManager:StartTimer(1, self._UpdRemainTimer, self, false)
  end
end

function UINResourceItem:_UpdRemainTimer()
  self.ui.tex_RemainTime.transform.parent.gameObject:SetActive(false)
  local linkItemId = self.itemCfg.link_item_id
  if PlayerDataCenter:GetItemCount(linkItemId) <= 0 then
    return false
  end
  local stackInfo = PlayerDataCenter:GetDynLimtTimeItemStackInfo(linkItemId, 1)
  if stackInfo == nil then
    error(string.format("Item(%s) is not limit time item", linkItemId))
    return false
  end
  local diffTime = stackInfo.time - PlayerDataCenter.timestamp
  if 0 < diffTime then
    local d, h, m, s = TimeUtil:TimestampToTimeInter(diffTime, false, true)
    if 0 < d then
      self.ui.tex_RemainTime:SetIndex(0, tostring(d))
    elseif 0 < h then
      self.ui.tex_RemainTime:SetIndex(1, tostring(h))
    else
      self.ui.tex_RemainTime:SetIndex(2, tostring(m))
    end
    self.ui.tex_RemainTime.transform.parent.gameObject:SetActive(true)
  end
  return true
end

function UINResourceItem:OnDelete()
  TimerManager:StopTimer(self._remainTimer)
  if self._UpdateCount ~= nil then
    MsgCenter:RemoveListener(eMsgEventId.StaminaUpdate, self._UpdateCount)
    self._UpdateCount = nil
  end
  base.OnDelete(self)
end

return UINResourceItem
