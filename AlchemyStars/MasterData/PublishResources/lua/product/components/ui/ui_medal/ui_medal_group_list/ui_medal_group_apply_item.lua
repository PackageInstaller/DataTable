_class("UIMedalGroupApplyItem", UICustomWidget)
UIMedalGroupApplyItem = UIMedalGroupApplyItem

function UIMedalGroupApplyItem:Constructor()
  self.medalModule = GameGlobal.GetModule(MedalModule)
  self.editData = self.medalModule:GetN22MedalEditData()
end

function UIMedalGroupApplyItem:OnShow(uiParams)
  self:_GetComponents()
end

function UIMedalGroupApplyItem:_GetComponents()
  self.medalBg = self:GetUIComponent("RawImageLoader", "imgIcon")
  self.medalBgRt = self:GetUIComponent("RectTransform", "imgIcon")
  self.pool = self:GetUIComponent("UISelectObjectPath", "pool")
  self.title = self:GetUIComponent("RollingText", "title")
  self.medal_collect = self:GetUIComponent("UILocalizationText", "medal_collect")
  self.bg_collect = self:GetUIComponent("UILocalizationText", "bg_collect")
  self.desc = self:GetUIComponent("UILocalizationText", "desc")
  self.all = self:GetGameObject("all")
end

function UIMedalGroupApplyItem:ApplyBtnOnClick(go)
  if self._callback then
    self._callback(self._idx)
  end
end

function UIMedalGroupApplyItem:SetData(idx, data, callBack, atlas)
  self._idx = idx
  self._data = data
  self._callback = callBack
  self.atlas = atlas
  self:OnValue()
  self:PlayAnim()
end

function UIMedalGroupApplyItem:OnHide()
  if self._timer then
    GameGlobal.Timer():CancelEvent(self._timer)
  end
end

function UIMedalGroupApplyItem:PlayAnim()
  local yieldTime = (self._idx - 1) * 60
  local rootTr = self:GetUIComponent("RectTransform", "root")
  rootTr.anchoredPosition = Vector2(0, -30)
  self._timer = GameGlobal.Timer():AddEvent(yieldTime, function()
    local anim = self:GetUIComponent("Animation", "UIMedalGroupApplyItem")
    anim:Play("uieff_UIMedalGroupApplyItem_in")
  end)
end

function UIMedalGroupApplyItem:OnValue()
  self:SetMedals()
  self:SetTxt()
  self:SetBg()
end

function UIMedalGroupApplyItem:SetMedals()
  local medals = self._data.MedalIDList
  self.pool:SpawnObjects("UIMedalGroupMedalItem", #medals)
  local pools = self.pool:GetAllSpawnList()
  for i = 1, #medals do
    local item = pools[i]
    local data = medals[i]
    local id = data[1]
    local sprite = UIN22MedalEditItem.GetSprite(self.atlas, BoardMedal.IconMedalById(id))
    local collect = UIMedalGroupApply.CheckMedalCollect(id)
    local width = self.medalBgRt.rect.width
    item:SetData(data, sprite, collect, width, self.editData)
  end
end

function UIMedalGroupApplyItem:SetTxt()
  local title = self._data.Title
  local haveBgNum = UIMedalGroupApply.CheckBgCollect(self._data)
  local haveMedalNum = UIMedalGroupApply.CheckMedalListCollect(self._data)
  local medalNum = #self._data.MedalIDList
  self.bg_collect:SetText(haveBgNum .. "/1")
  self.medal_collect:SetText(haveMedalNum .. "/" .. medalNum)
  local collectAll = 1 <= haveBgNum and haveMedalNum >= medalNum
  self.all:SetActive(collectAll)
  local desc = self._data.Des
  self.title:RefreshText(StringTable.Get(title))
  self.desc:SetText(StringTable.Get(desc))
end

function UIMedalGroupApplyItem:SetBg()
  local boardid = self._data.BoardID
  local boardIconHD = UIN22MedalEdit.GetMedalBoardBgHd(boardid)
  self.medalBg:LoadImage(boardIconHD)
end
