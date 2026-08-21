_class("UIChooseAssistantItem", UICustomWidget)
UIChooseAssistantItem = UIChooseAssistantItem

function UIChooseAssistantItem:OnShow()
  self._module = self:GetModule(PetModule)
  self:_GetComponents()
  self:AttachEvent(GameEventType.OnAssistantPetItemClick, self.OnPetItemClick)
end

function UIChooseAssistantItem:SetData(data, currID, currGrade, cuurSkinId, currAsId, selectID, selectGrade, selectSkinId, selectAsId, callback, getHeadIcon)
  local _data = data
  self._petid = _data.petid
  if self._petid == -1 then
  else
    local cfg = Cfg.cfg_pet[self._petid]
    if not cfg then
      Log.error("###[UIChooseAssistantItem] cfg is nil ! id --> ", self._petid)
    end
    self._petName = cfg.Name
  end
  self._grade = _data.grade
  self._skinId = _data.skinid
  self._asId = _data.asid
  self._currID = currID
  self._selectID = selectID
  self._callback = callback
  self._getHeadIcon = getHeadIcon
  self:_OnValue()
end

function UIChooseAssistantItem:_GetComponents()
  self._name = self:GetUIComponent("UILocalizationText", "name")
  self._head = self:GetUIComponent("RawImageLoader", "head")
  self._select = self:GetGameObject("select")
  self._current = self:GetGameObject("current")
  self._gradeGo = self:GetGameObject("grade")
  self._petGo = self:GetGameObject("pet")
  self._noPetGo = self:GetGameObject("noPet")
end

function UIChooseAssistantItem:_OnValue()
  self._petGo:SetActive(self._petid ~= -1)
  self._noPetGo:SetActive(self._petid == -1)
  if self._petid == -1 then
  else
    if self._getHeadIcon then
      local headIcon = self._getHeadIcon(self._petid, self._grade, self._skinId, self._asId)
      self._head:LoadImage(headIcon)
    end
    self._name:SetText(StringTable.Get(self._petName))
    self._gradeGo:SetActive(self._grade > 0)
  end
  local current = false
  local select = false
  if self._currID == self._petid then
    current = true
  end
  if self._selectID == self._petid then
    select = true
  end
  self._current:SetActive(current)
  self._select:SetActive(select)
end

function UIChooseAssistantItem:bgOnClick()
  if self._select.activeSelf then
    return
  end
  if self._callback then
    self._callback(self._petid, self._grade, self._skinId, self._asId)
  end
end

function UIChooseAssistantItem:OnPetItemClick(petid)
  if self._petid then
    local select = false
    if petid == self._petid then
      select = true
    end
    self._select:SetActive(select)
  end
end

function UIChooseAssistantItem:OnHide()
  self:DetachEvent(GameEventType.OnAssistantPetItemClick, self.OnPetItemClick)
end
