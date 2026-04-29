require("singleton")
_class("HomeUIBubbleManager", Singleton)
HomeUIBubbleManager = HomeUIBubbleManager

function HomeUIBubbleManager:Init(uiroot)
  self._go = uiroot.transform:Find("UICameras/depth_high/UI/HomeUIBubbleManager").gameObject
  self._root = self._go.transform:Find("SafeArea/Center/pools")
  self._item = self._root:Find("item").gameObject
  self._item:SetActive(false)
  self._initCount = 10
  self._currentCount = 0
  self._showTime = 3000
  self._pools = {}
  self._usingPools = {}
  self:_AddListener()
  self:_OnValue()
end

function HomeUIBubbleManager:_OnValue()
  for i = 1, self._initCount do
    self:CreateUnit()
  end
end

function HomeUIBubbleManager:Dispose()
  GameGlobal.EventDispatcher():RemoveCallbackListener(GameEventType.HomeShowUIBubble, self.ShowBubbleHandler)
end

function HomeUIBubbleManager:_AddListener()
  self.ShowBubbleHandler = GameHelper:GetInstance():CreateCallback(self.ShowBubble, self)
  GameGlobal.EventDispatcher():AddCallbackListener(GameEventType.HomeShowUIBubble, self.ShowBubbleHandler)
end

function HomeUIBubbleManager:ShowBubble(tex, icon)
  local idx = #self._usingPools + 1
  local item
  for i = 1, self._currentCount do
    local lua = self._pools[i]
    if not lua:Using() then
      item = lua
      break
    end
  end
  if not item then
    item = self:CreateAndReturn()
    table.insert(self._pools, item)
  end
  item:SetData(idx, tex, icon, function(item)
    self:Use(item)
  end, function(item)
    self:NoUse(item)
  end)
  local gapsY = 100
  for i = 1, #self._usingPools do
    local lua = self._usingPools[i]
    local y = gapsY * (i - 1)
    lua:MovePosY(y)
  end
end

function HomeUIBubbleManager:Use(item)
  table.insert(self._usingPools, 1, item)
end

function HomeUIBubbleManager:NoUse(item)
  table.removev(self._usingPools, item)
end

function HomeUIBubbleManager:CreateUnit()
  local lua = self:CreateAndReturn()
  table.insert(self._pools, lua)
end

function HomeUIBubbleManager:CreateAndReturn()
  local item = UnityEngine.GameObject.Instantiate(self._item, Vector3(0, 0, 0), Quaternion.identity, self._root)
  item.transform:SetAsLastSibling()
  local anim = item.transform:Find("layout").gameObject
  local iconGo = item.transform:Find("layout/iconGo").gameObject
  local icon = item.transform:Find("layout/iconGo/icon").gameObject
  local tex = item.transform:Find("layout/tex").gameObject
  local _itemGo = item
  local _iconGo = iconGo
  local _icon = icon:GetComponent("RawImageLoader")
  local _tex = tex:GetComponent("UILocalizationText")
  local _anim = anim:GetComponent("Animation")
  local _layout = anim:GetComponent("RectTransform")
  local lua = HomeUIBubbleItem:New(_itemGo, _iconGo, _icon, _tex, _anim, _layout, self._showTime)
  lua:SetActive(false)
  self._currentCount = self._currentCount + 1
  return lua
end

_class("HomeUIBubbleItem", Object)
HomeUIBubbleItem = HomeUIBubbleItem

function HomeUIBubbleItem:Constructor(root, iconGo, icon, tex, anim, layout, animTime)
  self._go = root
  self._iconGo = iconGo
  self._icon = icon
  self._tex = tex
  self._anim = anim
  self._layout = layout
  self._animTime = animTime
  self._active = false
  self._using = false
end

function HomeUIBubbleItem:SetData(idx, tex, icon, using, close)
  self._using = true
  self._usingCb = using
  self._closeCb = close
  self:SetActive(true)
  self._go.transform.localPosition = Vector3(0, 0, 0)
  self._layout.anchoredPosition = Vector2(-72, 0)
  self._tex:SetText(tex)
  if icon then
    self._iconGo:SetActive(true)
    self._icon:LoadImage(icon)
  else
    self._iconGo:SetActive(false)
  end
  if self._usingCb then
    self._usingCb(self)
  end
  self._anim:Play()
  GameGlobal.Timer():AddEvent(self._animTime, function()
    self:Close()
  end)
end

function HomeUIBubbleItem:MovePosY(y)
  local rt = self._go:GetComponent("RectTransform")
  if self._tweener then
    self._tweener:Kill()
  end
  self._tweener = rt:DOAnchorPosY(y, 0.3)
end

function HomeUIBubbleItem:Close()
  self._using = false
  self:SetActive(false)
  if self._closeCb then
    self._closeCb(self)
  end
end

function HomeUIBubbleItem:SetActive(active)
  self._active = active
  self._go:SetActive(self._active)
end

function HomeUIBubbleItem:Using()
  return self._using
end
