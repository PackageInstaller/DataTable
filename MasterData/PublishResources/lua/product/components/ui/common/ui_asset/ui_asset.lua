require("ui_asset_config")
_class("UIAsset", UICustomWidget)
UIAsset = UIAsset

function UIAsset:OnShow()
  self._componentRoot = nil
  self._disableRoot = nil
  self._uiCommonAtlas = self:RootUIOwner():GetAsset("UICommon.spriteatlas", LoadType.SpriteAtlas)
  self._icon = self:GetUIComponent("RawImageLoader", "icon")
  self._iconRect = self:GetUIComponent("RectTransform", "icon")
  self._iconObj = self:GetGameObject("icon")
  self._txt = self:GetUIComponent("UILocalizationText", "txt")
  self._txtObj = self:GetGameObject("txt")
  self._quality = self:GetUIComponent("Image", "quality")
  self._qualityObj = self:GetGameObject("quality")
  self._bg = self:GetUIComponent("Image", "bg")
  self._bgObj = self:GetGameObject("quality")
  self._transform = self:GetGameObject().transform
  self._componentRoot = self:GetGameObject("Components").transform
end

function UIAsset:OnHide()
end

function UIAsset:ComponentRoot()
  return self._componentRoot
end

function UIAsset:SetBgImage(bImage)
  if bImage then
    self._bg.sprite = self._uiCommonAtlas:GetSprite("spirit_dikuang10_frame")
  else
    self._bg.sprite = self._uiCommonAtlas:GetSprite("spirit_dikuang1_frame")
  end
end

function UIAsset:SetData(itemId, scale)
  if self._id then
    self:_RemoveAllComponent()
  else
    self._id = itemId
    self._components = {}
    self._disableComponent = {}
  end
  self:SetItemIconSize()
end

function UIAsset:SetItemData(param)
  param = param or {}
  self._bgObj:SetActive(param.showBG)
  if param.icon then
    self._icon:LoadImage(param.icon)
    self._iconObj:SetActive(true)
  else
    self._iconObj:SetActive(false)
  end
  if param.text then
    if type(param.text) == "number" then
      local num = param.text
      self._txt:SetText(HelperProxy:GetInstance():FormatItemCount(num))
    elseif type(param.text) == "string" then
      self._txt:SetText(param.text)
    end
    self._txtObj:SetActive(true)
  else
    self._txtObj:SetActive(false)
  end
  if param.quality then
    if param.quality < 0 then
      self._qualityObj:SetActive(false)
      return
    end
    local qualityName = UIEnum.ItemColorFrame(param.quality)
    if qualityName ~= "" then
      self._qualityObj:SetActive(true)
      self._quality.sprite = self._uiCommonAtlas:GetSprite(qualityName)
    else
      self._qualityObj:SetActive(false)
    end
  else
    self._qualityObj:SetActive(false)
  end
end

function UIAsset:SetItemIconSize()
  local oriSize = Vector2(155, 155)
  if self._id and self._id >= 3751000 and self._id <= 3751999 then
    local newHeight = 160 * oriSize.x / 190
    local newSize = Vector2(oriSize.x, newHeight)
    if self._iconRect then
      self._iconRect.sizeDelta = newSize
    end
    return
  end
  if self._iconRect then
    self._iconRect.sizeDelta = oriSize
  end
end

function UIAsset:SetScale(scale)
  scale = scale or 1
  if self._transform then
    self._transform.localScale = Vector3(scale, scale, scale)
  end
end

function UIAsset:GetComponent(type)
  for _, component in ipairs(self._components) do
    if component._className == type._className then
      return component
    end
  end
  return nil
end

function UIAsset:ContainsComponent(type)
  return self:GetComponent(type) ~= nil
end

function UIAsset:AddComponent(type, ...)
  local c = self:GetComponent(type)
  if c then
    Log.error("重复的组件")
    return nil
  end
  local typeName = type._className
  local index = #self._components + 1
  if self._disableComponent[typeName] then
    c = self._disableComponent[typeName]
    self._disableComponent[typeName] = nil
    c:Reset(self._id, index, {
      ...
    })
  else
    c = type:New(self, self._id, index, {
      ...
    })
    c:LoadPrefab(UIAssetConfig.GetComponentPrefab(type))
    c:OnInit()
  end
  self._components[index] = c
  c:OnAdd()
  return c
end

function UIAsset:RemoveComponent(type)
  local c = self:GetComponent(type)
  if not c then
    Log.error("不包含组件，无法移除")
    return
  end
  local typeName = type._className
  c:OnRemove()
  self._components[typeName] = nil
  table.remove(self._components, c:Index())
  self._disableComponent[typeName] = c
  return c
end

function UIAsset:_RemoveAllComponent()
  for i = #self._components, 1, -1 do
    local c = self._components[i]
    c:OnRemove()
    table.remove(self._components, i)
    self._disableComponent[c._className] = c
  end
end

function UIAsset:GetBtn()
  local eventComponent = self:GetComponent(UIAssetComponentEvent)
  if eventComponent then
    return eventComponent:GetBtnObject()
  end
end
