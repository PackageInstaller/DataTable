_class("SeasonUISign", Object)
SeasonUISign = SeasonUISign

function SeasonUISign:Constructor(gameObject, atlas)
  self._gameObject = gameObject
  self._atlas = atlas
  self._eventPoint = nil
  self._view = self._gameObject:GetComponent(typeof(UIView))
  self:_GetComponents()
end

function SeasonUISign:_GetComponents()
  self._rootTransform = self._view:GetUIComponent("Transform", "Root")
  self._sign = self._view:GetUIComponent("Image", "Sign")
end

function SeasonUISign:SetData(eventPoint, express)
  if eventPoint then
    self._eventPoint = eventPoint
    local spriteName
    if express then
      local content = express:Content()
      if content then
        spriteName = content.sprite
      end
    end
    if spriteName then
      self._sign.enabled = true
      self._sign.sprite = self._atlas:GetSprite(spriteName)
    else
      self._sign.enabled = false
    end
    local cfg = self._eventPoint:GetEventPointCfg()
    if cfg and cfg.UISignOffset then
      self._rootTransform.localPosition = Vector3(cfg.UISignOffset[1], cfg.UISignOffset[2], cfg.UISignOffset[3])
    end
    self:RefreshPosition()
  else
    self:Clear()
  end
end

function SeasonUISign:RefreshPosition()
  if self._eventPoint then
    local show = self._eventPoint:IsShow()
    if self._eventPoint:EventPointType() == SeasonEventPointType.MainLevel and show then
      show = self._eventPoint:IsLastMainLevelGroup()
    end
    self._gameObject:SetActive(show)
    self._gameObject.transform.position = self._eventPoint:Position()
  end
end

function SeasonUISign:EventPoint()
  return self._eventPoint
end

function SeasonUISign:IsFree()
  return self._eventPoint == nil
end

function SeasonUISign:Clear()
  self._eventPoint = nil
  self._gameObject:SetActive(false)
end
