_class("UIRecruitThumbTitleItem", Object)
UIRecruitThumbTitleItem = UIRecruitThumbTitleItem

function UIRecruitThumbTitleItem:Constructor(gameObject, type)
  self._gameObject = gameObject
  self._gameObject.name = gameObject.name .. type
  self._uiView = self._gameObject:GetComponent(typeof(UIView))
  self._uiView:SetShow(true, self)
  self._type = type
  local cfg = Cfg.cfg_recruit_pool_subtype[self._type]
  local text = self._uiView:GetUIComponent("UILocalizationText", "title")
  text:SetText(StringTable.Get(cfg.Title))
  local image = self._uiView:GetUIComponent("RawImageLoader", "bg")
  image:LoadImage(cfg.Bg)
end

function UIRecruitThumbTitleItem:Dispose()
  self._uiView:SetShow(false, self)
  self._uiView = nil
end
