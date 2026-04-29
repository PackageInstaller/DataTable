_class("UIDiscoveryPartItem", UICustomWidget)
UIDiscoveryPartItem = UIDiscoveryPartItem

function UIDiscoveryPartItem:Constructor()
  self.module = self:GetModule(MissionModule)
  self.data = self.module:GetDiscoveryData()
end

function UIDiscoveryPartItem:OnShow()
  self.normal = self:GetGameObject("normal")
  self.section = self:GetGameObject("section")
  self.lineNormal = self:GetGameObject("lineNormal")
  self.lineSection = self:GetGameObject("lineSection")
  self.imgIconNormal = self:GetUIComponent("RawImageLoader", "imgIconNormal")
  self.imgIconSection = self:GetUIComponent("RawImageLoader", "imgIconSection")
  self.rawIconNormal = self:GetUIComponent("RawImage", "imgIconNormal")
  self.rawIconSection = self:GetUIComponent("RawImage", "imgIconSection")
  self.txtNameNormal = self:GetUIComponent("UILocalizationText", "txtNameNormal")
  self.txtNameSection = self:GetUIComponent("UILocalizationText", "txtNameSection")
  self.curNormal = self:GetGameObject("curNormal")
  self.curSection = self:GetGameObject("curSection")
  self.lock = self:GetGameObject("lock")
end

function UIDiscoveryPartItem:OnHide()
  self.imgIconNormal:DestoryLastImage()
  self.imgIconSection:DestoryLastImage()
end

function UIDiscoveryPartItem:Flush(sectionId, curSectionId)
  self.sectionId = sectionId
  self.curSectionId = curSectionId
  local section = self.data:GetDiscoverySectionBySectionId(sectionId)
  local state, chapterId = section:State()
  self.isLock = state == nil
  if section.isBetween then
    self.normal:SetActive(false)
    self.section:SetActive(true)
    self:FlushSection(section)
  else
    self.normal:SetActive(true)
    self.section:SetActive(false)
    self:FlushNormal(section)
  end
end

function UIDiscoveryPartItem:FlushNormal(section)
  self:FlushLastLine(self.lineNormal)
  self.txtNameNormal:SetText(section.index_name .. StringTable.Get("str_common_colon") .. section.name)
  self.imgIconNormal:LoadImage(section.icon)
  self:FlushCur(section, self.curNormal)
  self:FlushLock(self.rawIconNormal)
end

function UIDiscoveryPartItem:FlushSection(section)
  self:FlushLastLine(self.lineSection)
  self.txtNameSection:SetText(section.index_name .. StringTable.Get("str_common_colon") .. section.name)
  self.imgIconSection:LoadImage(section.icon)
  self:FlushCur(section, self.curSection)
  self:FlushLock(self.rawIconSection)
end

function UIDiscoveryPartItem:FlushLastLine(line)
  local last = self.data:GetDiscoveryLastSection()
  local isLast = last and last.id == self.sectionId or false
  line:SetActive(not isLast)
end

function UIDiscoveryPartItem:FlushCur(section, cur)
  if self.isLock then
    cur:SetActive(false)
  elseif self.sectionId == self.curSectionId then
    cur:SetActive(true)
  else
    cur:SetActive(false)
  end
end

function UIDiscoveryPartItem:FlushLock(rawIcon)
  self.lock:SetActive(self.isLock)
  if not self._EMIMat then
    self._EMIMat = UnityEngine.Material:New(rawIcon.material)
  end
  if self.isLock then
    local texture = rawIcon.material.mainTexture
    rawIcon.material = self._EMIMat
    rawIcon.material.mainTexture = texture
    rawIcon.material:SetFloat("_LuminosityAmount", 1)
  else
    rawIcon.material:SetFloat("_LuminosityAmount", 0)
  end
end

function UIDiscoveryPartItem:imgIconNormalOnClick(go)
  self:OnClick(go)
end

function UIDiscoveryPartItem:imgIconSectionOnClick(go)
  self:OnClick(go)
end

function UIDiscoveryPartItem:OnClick(go)
  local section = self.data:GetDiscoverySectionBySectionId(self.sectionId)
  local state, chapterId = section:State()
  if state == DiscoveryStageState.CanPlay then
    GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryFlushChapter, chapterId)
  elseif state == DiscoveryStageState.Nomal then
    for cId, b in pairs(section.chapterIds) do
      chapterId = cId
      break
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.DiscoveryFlushChapter, chapterId)
  else
    ToastManager.ShowToast(StringTable.Get("str_discovery_section_" .. section.id .. "_unlock_condition"))
  end
  if GameGlobal.UIStateManager():IsShow("UIChapters") then
    GameGlobal.UIStateManager():CloseDialog("UIChapters")
  end
  GameGlobal.UIStateManager():CloseDialog("UIDiscoveryPart")
end
