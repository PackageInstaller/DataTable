_class("SeasonUIFunction", Object)
SeasonUIFunction = SeasonUIFunction

function SeasonUIFunction:Constructor(gameObject, atlas)
  self._gameObject = gameObject
  self._atlas = atlas
  self._eventPoint = nil
  self._express = nil
  self._view = self._gameObject:GetComponent(typeof(UIView))
  self:_GetComponents()
end

function SeasonUIFunction:_GetComponents()
  self._rootTransform = self._view:GetUIComponent("Transform", "Root")
  self._function = self._view:GetUIComponent("Image", "Function")
  self._functionGO = self._function.gameObject
  self._functionBox = self._functionGO:GetComponent(typeof(UnityEngine.BoxCollider))
end

function SeasonUIFunction:SetData(eventPoint, express)
  if eventPoint then
    self._eventPoint = eventPoint
    local spriteName
    self._express = express
    if self._express then
      local content = self._express:Content()
      if content then
        spriteName = content.sprite
        if content.functionType and content.functionType == SeasonFunctionType.PlayExpress then
          self._functionBox.enabled = true
        else
          self._functionBox.enabled = false
        end
      end
    end
    if spriteName then
      local sprite = self._atlas:GetSprite(spriteName)
      if sprite then
        self._function.sprite = sprite
        self._function.enabled = true
        self._function:SetNativeSize()
        if self._functionBox.enabled then
          self._functionBox.size = Vector3(self._function.sprite.rect.width, self._function.sprite.rect.height, 0)
          self._functionBox.center = Vector3(0, self._function.sprite.rect.height * 0.5, 0)
        end
      else
        self._function.enabled = false
      end
    else
      self._function.enabled = false
    end
    local cfg = self._eventPoint:GetEventPointCfg()
    if cfg and cfg.UIFunctionOffset then
      self._rootTransform.localPosition = Vector3(cfg.UIFunctionOffset[1], cfg.UIFunctionOffset[2], cfg.UIFunctionOffset[3])
    end
    self:RefreshPosition()
  else
    self:Clear()
  end
end

function SeasonUIFunction:RefreshPosition()
  if self._eventPoint then
    local show = self._eventPoint:IsShow()
    self._gameObject:SetActive(show)
    self._gameObject.transform.position = self._eventPoint:Position()
  end
end

function SeasonUIFunction:EventPoint()
  return self._eventPoint
end

function SeasonUIFunction:Function()
  return self._functionGO
end

function SeasonUIFunction:IsFree()
  return self._eventPoint == nil
end

function SeasonUIFunction:Clear()
  self._eventPoint = nil
  self._gameObject:SetActive(false)
end
