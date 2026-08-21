_class("UIN25IdolApEventItem", UICustomWidget)
UIN25IdolApEventItem = UIN25IdolApEventItem

function UIN25IdolApEventItem:Constructor()
  self.weekDay2Tex = {
    [1] = "str_n25_idol_y_concert_Monday",
    [2] = "str_n25_idol_y_concert_Tuesday",
    [3] = "str_n25_idol_y_concert_Wednesday",
    [4] = "str_n25_idol_y_concert_Thursday",
    [5] = "str_n25_idol_y_concert_Friday",
    [6] = "str_n25_idol_y_concert_Saturday",
    [7] = "str_n25_idol_y_concert_Sunday"
  }
end

function UIN25IdolApEventItem:OnShow(uiParams)
  self:GetComponents()
end

function UIN25IdolApEventItem:SetData(eventid, status, weekDay, roomid, light)
  self.eventid = eventid
  self.cfg = Cfg.cfg_component_idol_event({EventId = eventid})[1]
  self.weekDay = weekDay
  self.roomid = roomid
  self.status = status
  self.light = light
  self:OnValue()
end

function UIN25IdolApEventItem:OnHide()
  if self.timer then
    GameGlobal.Timer():CancelEvent(self.timer)
  end
end

function UIN25IdolApEventItem:GetComponents()
  self.descTex = self:GetUIComponent("UILocalizationText", "desc")
  self.icon = self:GetUIComponent("RawImageLoader", "icon")
  self.bg = self:GetUIComponent("Image", "bg")
  self.statusImg = self:GetUIComponent("Image", "status")
  self.weekTex = self:GetUIComponent("UILocalizationText", "week")
  self.atlas = self:GetAsset("UIN25Idol.spriteatlas", LoadType.SpriteAtlas)
  self.lightGo = self:GetGameObject("light")
  self.anim = self:GetUIComponent("Animation", "UIN25Idol_ApItem")
end

function UIN25IdolApEventItem:OnValue()
  local desc = self.cfg.Desc
  local iconImg = self.cfg.PetHead
  self.icon:LoadImage(iconImg)
  self.descTex:SetText(StringTable.Get(desc))
  local weekTex = self.weekDay2Tex[self.weekDay]
  self.weekTex:SetText(StringTable.Get(weekTex))
  if self.status == UIIdolApEventStatus.Ready then
    self.statusImg.gameObject:SetActive(false)
  else
    self.statusImg.gameObject:SetActive(true)
    local sprite
    if self.status == UIIdolApEventStatus.Pass then
      sprite = "n25_yczjm_di08"
    else
      sprite = "n25_yczjm_di09"
    end
    self.statusImg.sprite = self.atlas:GetSprite(sprite)
  end
  local roomSp
  if self.roomid == IdolTrainType.IdolTrainType_Music then
    roomSp = "n25_yczjm_di10"
  elseif self.roomid == IdolTrainType.IdolTrainType_Dance then
    roomSp = "n25_yczjm_di12"
  else
    roomSp = "n25_yczjm_di11"
  end
  self.bg.sprite = self.atlas:GetSprite(roomSp)
  self.lightGo:SetActive(self.light)
end

function UIN25IdolApEventItem:PlayIn()
  self.anim:Play("uieff_UIN25IdolApItem_light_in")
  if self.timer then
    GameGlobal.Timer():CancelEvent(self.timer)
  end
  self.timer = GameGlobal.Timer():AddEvent(333, function()
    self:PlayLoop()
  end)
end

function UIN25IdolApEventItem:PlayOut()
  self.anim:Play("uieff_UIN25IdolApItem_light_out")
end

function UIN25IdolApEventItem:PlayLoop()
  self.anim:Play("uieff_UIN25IdolApItem_light_loop")
end
