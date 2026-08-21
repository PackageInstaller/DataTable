_class("UIHomelandBackpackItem", UICustomWidget)
UIHomelandBackpackItem = UIHomelandBackpackItem

function UIHomelandBackpackItem:OnShow()
  self.item = self:GetUIComponent("UISelectObjectPath", "item")
  self.select = self:GetGameObject("select")
  self.red = self:GetGameObject("red")
  self.default = self:GetGameObject("default")
  self.empty = self:GetGameObject("empty")
  self.anim = self:GetUIComponent("Animation", "root")
  self.animState = self.anim:get_Item("UIHomelandBackpackItem_Switching")
  self.data = self:GetModule(HomelandModule):GetHomelandBackpackData()
  self:AttachEvent(GameEventType.HomelandBackpackSelectItem, self.FlushSelect)
end

function UIHomelandBackpackItem:OnHide()
  self:DetachEvent(GameEventType.HomelandBackpackSelectItem, self.FlushSelect)
  if self._event and not self._event._Complete then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
end

function UIHomelandBackpackItem:Flush(filterId, id)
  if self._event and not self._event._Complete then
    GameGlobal.Timer():CancelEvent(self._event)
    self._event = nil
  end
  self.filterId = filterId
  if id then
    self.default:SetActive(true)
    self.empty:SetActive(false)
    self.id = id
    local dataItem = self.data:GetItemById(id)
    local ra = RoleAsset:New()
    ra.assetid = dataItem:GetTemplateID()
    ra.count = dataItem:GetCount()
    local uiItem = self.item:SpawnObject("UIItemHomeland")
    uiItem:Flush(ra, function()
      self:Click()
    end)
    uiItem:SetNotShowTips(true)
    self:FlushRed()
  else
    self.default:SetActive(false)
    self.empty:SetActive(true)
  end
end

function UIHomelandBackpackItem:FlushRed()
  local isShowNew = self.data:IsItemNew(self.filterId, self.id)
  self.red:SetActive(isShowNew)
end

function UIHomelandBackpackItem:FlushSelect(id)
  if self.id == id then
    self.select:SetActive(true)
  else
    self.select:SetActive(false)
  end
end

function UIHomelandBackpackItem:PlayShowAnim(index, msStep)
  local animName = "UIHomelandBackpackItem_Switching"
  self.anim:Play(animName)
  self.anim:Rewind()
  self.anim:Sample()
  self.anim:Stop()
  self._event = GameGlobal.Timer():AddEvent(index * msStep, function()
    self.anim:Play(animName)
  end)
end

function UIHomelandBackpackItem:Click()
  local dataItem = self.data:GetItemById(self.id)
  if not dataItem then
    return
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.HomelandBackpackSelectItem, self.id, true, self)
end

function UIHomelandBackpackItem:bgOnClick(go)
  self:Click()
end
