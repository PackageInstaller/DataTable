_class("UISeasonS3CGTab", UICustomWidget)
UISeasonS3CGTab = UISeasonS3CGTab

function UISeasonS3CGTab:OnShow(uiParams)
  self:InitWidget()
  self:AttachEvent(GameEventType.OnSeasonShareCgFinished, self._OnShareFinish)
end

function UISeasonS3CGTab:InitWidget()
  self.content = self:GetUIComponent("UISelectObjectPath", "Content")
  self._anim = self:GetGameObject():GetComponent(typeof(UnityEngine.Animation))
end

function UISeasonS3CGTab:SetData(data, seasonObj)
  self._collageData = data
  self._cpt = seasonObj:GetComponent(ECCampaignSeasonComponentID.STORY)
  self._collageData:RefreshCgShareState(self._cpt)
  self._seasonID = data:GetSeasonID()
  local count = self._collageData:GetCGCount()
  self._items = self.content:SpawnObjects("UISeasonS3CollageCGItem", count)
  
  local function onSelect(data)
    self:_OnSelect(data)
  end
  
  for i = 1, count do
    self._items[i]:SetData(self._collageData:GetCGByIndex(i), onSelect)
  end
end

function UISeasonS3CGTab:SetShow(show)
  self:GetGameObject():SetActive(show)
end

function UISeasonS3CGTab:_OnSelect(data)
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

function UISeasonS3CGTab:_OnShareFinish(id)
  self._collageData:RefreshCgShareState(self._cpt)
  local count = self._collageData:GetCGCount()
  for i = 1, count do
    self._items[i]:ResetShareState()
  end
end

function UISeasonS3CGTab:PlayExitAnim()
end
