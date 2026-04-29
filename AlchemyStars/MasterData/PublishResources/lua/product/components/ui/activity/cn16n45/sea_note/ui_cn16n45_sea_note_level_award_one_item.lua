_class("UICN16N45SeaNoteLevelAwardOneItem", UICustomWidget)
UICN16N45SeaNoteLevelAwardOneItem = UICN16N45SeaNoteLevelAwardOneItem

function UICN16N45SeaNoteLevelAwardOneItem:OnShow(uiParams)
  self:InitWidget()
end

function UICN16N45SeaNoteLevelAwardOneItem:OnHide()
  if self.te then
    GameGlobal.Timer():CancelEvent(self.te)
    self.te = nil
  end
end

function UICN16N45SeaNoteLevelAwardOneItem:InitWidget()
  self.icon = self:GetUIComponent("RawImageLoader", "Icon")
  self.got = self:GetGameObject("Got")
  self.gotpp = self:GetGameObject("Gotpp")
  self.gotpp:SetActive(false)
  self.got:SetActive(false)
  self._Count = self:GetUIComponent("UILocalizationText", "Count")
  self.animation = self:GetUIComponent("Animation", "Anim")
end

function UICN16N45SeaNoteLevelAwardOneItem:SetData(award, ClickCB, mission_id, index)
  self.award = award
  self.id = self.award[1]
  self.mission_id = mission_id
  self.index = index
  self.click = ClickCB
  self:_SetIcon()
end

function UICN16N45SeaNoteLevelAwardOneItem:_SetIcon()
  local itemId = self.award[1]
  local count = self.award[2]
  self._cfg_item = Cfg.cfg_item[itemId]
  if self._cfg_item == nil then
    Log.fatal("[quest] error --> cfg_item is nil ! id --> " .. itemId)
    return
  end
  local icon = self._cfg_item.Icon
  self.icon:LoadImage(icon)
  self._Count:SetText(count)
end

function UICN16N45SeaNoteLevelAwardOneItem:ClickBtnOnClick(go)
  if self.click then
    self.click(self.id)
  end
end

function UICN16N45SeaNoteLevelAwardOneItem:SetPass(pass)
  if not pass then
    self.got:SetActive(false)
    self.gotpp:SetActive(false)
    return
  end
  if LocalDB.GetInt("UICN16N45SeaNoteLevelAwardOneItem:Pass2" .. self.mission_id .. self.index) == 0 then
    self.te = GameGlobal.Timer():AddEventTimes(2000, TimerTriggerCount.Once, function()
      self.got:SetActive(true)
      self.gotpp:SetActive(true)
      self.animation:Play("uianim_UICN16N45SeaNoteLevelAwardOneItem_Get")
      LocalDB.SetInt("UICN16N45SeaNoteLevelAwardOneItem:Pass2" .. self.mission_id .. self.index, 1)
      self.te = nil
    end)
  else
    self.got:SetActive(true)
    self.gotpp:SetActive(false)
  end
end
