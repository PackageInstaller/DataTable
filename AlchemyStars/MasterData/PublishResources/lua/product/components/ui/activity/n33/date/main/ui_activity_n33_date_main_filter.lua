_class("UIActivityN33DateMainFilter", UICustomWidget)
UIActivityN33DateMainFilter = UIActivityN33DateMainFilter

function UIActivityN33DateMainFilter:Constructor()
  self._type = nil
  self._sliderPos = {
    Vector2(-154, -31),
    Vector2(0, -31),
    Vector2(154, -31)
  }
end

function UIActivityN33DateMainFilter:OnShow()
  self:AttachEvent(GameEventType.OnN33FindPet, self.OnN33FindPet)
  self:_GetComponent()
  self:_Init()
end

function UIActivityN33DateMainFilter:_GetComponent()
  self._sliderIcon = self:GetUIComponent("RectTransform", "sliderIcon")
  self._anim = self:GetUIComponent("Animation", "anim")
  self._allSelectObj = self:GetGameObject("allSelect")
  self._petSelectObj = self:GetGameObject("petSelect")
  self._buildSelectObj = self:GetGameObject("buildSelect")
end

function UIActivityN33DateMainFilter:_Init()
  self._type = UIActivityN33DateMainFilterType.All
  self._allSelectObj:SetActive(true)
  self._petSelectObj:SetActive(false)
  self._buildSelectObj:SetActive(false)
  self._sliderIcon.anchoredPosition = self._sliderPos[UIActivityN33DateMainFilterType.All]
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnDateFilterClick, self._type)
end

function UIActivityN33DateMainFilter:OnN33FindPet()
  self._type = UIActivityN33DateMainFilterType.All
  self._allSelectObj:SetActive(true)
  self._petSelectObj:SetActive(false)
  self._buildSelectObj:SetActive(false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnDateFilterClick, self._type)
  self:_PlayFilterAnim(UIActivityN33DateMainFilterType.All)
end

function UIActivityN33DateMainFilter:FilterAll()
  if self._type == UIActivityN33DateMainFilterType.All then
    return
  end
  self._type = UIActivityN33DateMainFilterType.All
  self._allSelectObj:SetActive(true)
  self._petSelectObj:SetActive(false)
  self._buildSelectObj:SetActive(false)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.OnDateFilterClick, self._type)
  self:_PlayFilterAnim(UIActivityN33DateMainFilterType.All)
end

function UIActivityN33DateMainFilter:LeftFilterBtnOnClick()
  if self._type == UIActivityN33DateMainFilterType.All then
    self:_PlayFilterAnim(UIActivityN33DateMainFilterType.All)
  elseif self._type == UIActivityN33DateMainFilterType.Pet then
    self._type = UIActivityN33DateMainFilterType.Build
    self._allSelectObj:SetActive(false)
    self._petSelectObj:SetActive(false)
    self._buildSelectObj:SetActive(true)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnDateFilterClick, self._type)
    self:_PlayFilterAnim(UIActivityN33DateMainFilterType.Build)
  elseif self._type == UIActivityN33DateMainFilterType.Build then
    self._type = UIActivityN33DateMainFilterType.All
    self._allSelectObj:SetActive(true)
    self._petSelectObj:SetActive(false)
    self._buildSelectObj:SetActive(false)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnDateFilterClick, self._type)
    self:_PlayFilterAnim(UIActivityN33DateMainFilterType.All)
  end
  self._sliderIcon.anchoredPosition = self._sliderPos[self._type]
end

function UIActivityN33DateMainFilter:RightFilterBtnOnClick()
  if self._type == UIActivityN33DateMainFilterType.All then
    self._type = UIActivityN33DateMainFilterType.Build
    self._allSelectObj:SetActive(false)
    self._petSelectObj:SetActive(false)
    self._buildSelectObj:SetActive(true)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnDateFilterClick, self._type)
    self:_PlayFilterAnim(UIActivityN33DateMainFilterType.Build)
  elseif self._type == UIActivityN33DateMainFilterType.Pet then
    self:_PlayFilterAnim(UIActivityN33DateMainFilterType.Pet)
  elseif self._type == UIActivityN33DateMainFilterType.Build then
    self._type = UIActivityN33DateMainFilterType.Pet
    self._allSelectObj:SetActive(false)
    self._petSelectObj:SetActive(true)
    self._buildSelectObj:SetActive(false)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.OnDateFilterClick, self._type)
    self:_PlayFilterAnim(UIActivityN33DateMainFilterType.Pet)
  end
  self._sliderIcon.anchoredPosition = self._sliderPos[self._type]
end

function UIActivityN33DateMainFilter:_PlayFilterAnim(type)
  self:Lock("UIActivityN33DateMainFilter_PlayFilterAnim")
  if type == UIActivityN33DateMainFilterType.All then
    self._anim:Play("uieffanim_UIActivityN33DateMainFilter_01")
  elseif type == UIActivityN33DateMainFilterType.Pet then
    self._anim:Play("uieffanim_UIActivityN33DateMainFilter_03")
  elseif type == UIActivityN33DateMainFilterType.Build then
    self._anim:Play("uieffanim_UIActivityN33DateMainFilter_02")
  end
  self:UnLock("UIActivityN33DateMainFilter_PlayFilterAnim")
end

local UIActivityN33DateMainFilterType = {
  All = 1,
  Build = 2,
  Pet = 3
}
_enum("UIActivityN33DateMainFilterType", UIActivityN33DateMainFilterType)
