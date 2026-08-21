_class("UIMiniGameGuest", UICustomWidget)
UIMiniGameGuest = UIMiniGameGuest

function UIMiniGameGuest:Constructor()
  self._inited = false
end

function UIMiniGameGuest:OnShow(uiParams)
  self:_GetComponents()
end

function UIMiniGameGuest:_GetComponents()
  self._lookForward = self:GetUIComponent("RawImageLoader", "LookForward")
  self._quietness = self:GetUIComponent("RawImageLoader", "Quietness")
  self._impatient = self:GetUIComponent("RawImageLoader", "Impatient")
  self._happy = self:GetUIComponent("RawImageLoader", "Happy")
  self._rawImage = {}
  self._rawImage[GuestMood.LookForward] = self:GetUIComponent("RawImage", "LookForward")
  self._rawImage[GuestMood.Quietness] = self:GetUIComponent("RawImage", "Quietness")
  self._rawImage[GuestMood.Impatient] = self:GetUIComponent("RawImage", "Impatient")
  self._rawImage[GuestMood.Happy] = self:GetUIComponent("RawImage", "Happy")
  self._moodObj = {}
  self._moodObj[GuestMood.LookForward] = self:GetGameObject("LookForward")
  self._moodObj[GuestMood.Quietness] = self:GetGameObject("Quietness")
  self._moodObj[GuestMood.Impatient] = self:GetGameObject("Impatient")
  self._moodObj[GuestMood.Happy] = self:GetGameObject("HappyObj")
  self._moodAnimation = {}
  self._moodAnimation[GuestMood.LookForward] = self:GetUIComponent("Animation", "LookForward")
  self._moodAnimation[GuestMood.Impatient] = self:GetUIComponent("Animation", "Impatient")
  self._moodAnimation[GuestMood.Happy] = self:GetUIComponent("Animation", "HappyObj")
  self._orderformObj = self:GetGameObject("Orderform")
  self._orderformImg = {}
  self._orderformImg[OrderformStep.Weight] = self:GetUIComponent("Image", "Weight")
  self._orderformImg[OrderformStep.Ingredient] = self:GetUIComponent("Image", "Ingredient")
  self._orderformImg[OrderformStep.Jam] = self:GetUIComponent("Image", "Jam")
  self._atlas = self:GetAsset("UISummerGame.spriteatlas", LoadType.SpriteAtlas)
  self._hand = self:GetUIComponent("RawImageLoader", "Hand")
end

function UIMiniGameGuest:SetActive(active)
  self.view.gameObject:SetActive(active)
end

function UIMiniGameGuest:SetData(id)
  self.id = id
  if not self._inited then
    self._lookForward:LoadImage(string.format(GuestImg.Img[GuestMood.LookForward], id))
    self._quietness:LoadImage(string.format(GuestImg.Img[GuestMood.Quietness], id))
    self._impatient:LoadImage(string.format(GuestImg.Img[GuestMood.Impatient], id))
    self._happy:LoadImage(string.format(GuestImg.Img[GuestMood.Happy], id))
    self._hand:LoadImage(string.format(GuestImg.Misc.Hand, id))
    self._inited = true
  end
  for key, value in pairs(GuestMood) do
    self._moodObj[value]:SetActive(value == GuestMood.LookForward)
    self._moodObj[value].transform.localPosition = Vector3.zero
    self._rawImage[value].color = Color.white
  end
  self._orderformObj:SetActive(false)
  self:PlayAnimation(GuestMood.LookForward)
end

function UIMiniGameGuest:SetPosition(position, offset)
  self.view.transform.position = position
  self.view.transform.localPosition = self.view.transform.localPosition + offset
end

function UIMiniGameGuest:_Update(mood)
  for key, value in pairs(GuestMood) do
    local active = value == mood
    if self._moodObj[value].activeSelf ~= active then
      self._moodObj[value]:SetActive(active)
    end
  end
end

function UIMiniGameGuest:Happy(orderform, mood)
  self._orderformObj:SetActive(true)
  local imgs = OrderformImg.Img
  self._orderformImg[OrderformStep.Weight].sprite = self._atlas:GetSprite(imgs[OrderformStep.Weight][orderform._weight])
  self._orderformImg[OrderformStep.Ingredient].sprite = self._atlas:GetSprite(imgs[OrderformStep.Ingredient][orderform._weight][orderform._ingredient])
  self._orderformImg[OrderformStep.Jam].sprite = self._atlas:GetSprite(imgs[OrderformStep.Jam][orderform._weight][orderform._jam])
  self:PlayAnimation(mood)
end

function UIMiniGameGuest:PlayAnimation(mood)
  self._moodAnimation[mood]:Play(MGAnimations.Guest[mood])
end
