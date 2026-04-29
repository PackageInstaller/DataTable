_class("UISeasonS2CGTab", UICustomWidget)
UISeasonS2CGTab = UISeasonS2CGTab

function UISeasonS2CGTab:OnShow(uiParams)
  self:InitWidget()
  self:AttachEvent(GameEventType.OnSeasonShareCgFinished, self._OnShareFinish)
end

function UISeasonS2CGTab:InitWidget()
  self.content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
end

function UISeasonS2CGTab:SetData(data, seasonObj)
  self._collageData = data
  self._cpt = seasonObj:GetComponent(ECCampaignSeasonComponentID.STORY)
  self._collageData:RefreshCgShareState(self._cpt)
  self._seasonID = data:GetSeasonID()
  local count = self._collageData:GetCGCount()
  self._items = self.content:SpawnObjects("UISeasonS1CollageCGItem", count)
  
  local function onSelect(data)
    self:_OnSelect(data)
  end
  
  for i = 1, count do
    self._items[i]:SetData(self._collageData:GetCGByIndex(i), onSelect)
  end
end

function UISeasonS2CGTab:SetShow(show)
  self:GetGameObject():SetActive(show)
end

function UISeasonS2CGTab:_OnSelect(data)
  if not data:IsUnlock() then
    return
  end
  if data:IsNew() then
    self._collageData:CGCancelNew(data)
    self._items[data:Index()]:SetNew(false)
    self:DispatchEvent(GameEventType.UISeasonS1OnSelectCollageItem)
  end
  self:ShowDialog("UISeasonCgDetailController", Cfg.cfg_cg_book[data:ID()], self._cpt)
end

function UISeasonS2CGTab:_OnShareFinish(id)
  self._collageData:RefreshCgShareState(self._cpt)
  local count = self._collageData:GetCGCount()
  for i = 1, count do
    self._items[i]:ResetShareState()
  end
end

function UISeasonS2CGTab:PlayExitAnim()
  self._anim:Play("uieffanim_UISeasonS1CGTab_out")
  local count = self._collageData:GetCGCount()
  for i = 1, count do
    self._items[i]:PlayExitAnim()
  end
end
