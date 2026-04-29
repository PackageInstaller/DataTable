_class("UITeamsSelectItem", UICustomWidget)
UITeamsSelectItem = UITeamsSelectItem

function UITeamsSelectItem:OnShow()
  self._module = self:GetModule(MissionModule)
  self.ctx = self._module:TeamCtx()
  self._tgl = self:GetUIComponent("Toggle", "tgl")
  self._txtName = self:GetUIComponent("UILocalizationText", "txtName")
  self._artFont = self:GetUIComponent("ArtFont", "txtName")
  self._btnModify = self:GetGameObject("btnModify")
  self._atlas = self:RootUIOwner():GetAsset("UITeams.spriteatlas", LoadType.SpriteAtlas)
  self:AttachEvent(GameEventType.TeamToggleIsOnChanged, self.FlushSth)
  self._etl = UICustomUIEventListener.Get(self._tgl.gameObject)
  self._modEtl = UICustomUIEventListener.Get(self._btnModify)
end

function UITeamsSelectItem:OnHide()
  self:DetachEvent(GameEventType.TeamToggleIsOnChanged, self.FlushSth)
end

function UITeamsSelectItem:Init(id, uiCtl, tglGroup, scrollRect)
  self._id = id
  self._uiCtrl = uiCtl
  self._tgl.group = tglGroup
  self._scrollRect = scrollRect
  local teamid = self.ctx:GetCurrTeamId()
  self:FlushTglIsOn(self._id == teamid)
  self:FlushSth()
  self:FlushName(self._id)
  self:RegUIEventTriggerListener()
end

function UITeamsSelectItem:FlushName(teamId)
  if not self._txtName then
    return
  end
  local teams = self.ctx:Teams()
  local team = teams:Get(teamId)
  if team then
    local name = team.name
    if not name or string.len(name) == 0 then
      name = StringTable.Get("str_discovery_formation_" .. teamId)
    end
    self._txtName:SetText(name)
  else
    Log.error("### team is nil. teamId = ", teamId)
  end
end

function UITeamsSelectItem:SetFontMat(lable, resname)
  local res = ResourceManager:GetInstance():SyncLoadAsset(resname, LoadType.Mat)
  if not res then
    return
  end
  local obj = res.Obj
  local mat = lable.fontMaterial
  lable.fontMaterial = obj
  lable.fontMaterial:SetTexture("_MainTex", mat:GetTexture("_MainTex"))
end

function UITeamsSelectItem:OnValueChange()
  if self._id ~= self.ctx:GetCurrTeamId() then
    local hpm = self:GetModule(HelpPetModule)
    hpm:UI_ClearHelpPet()
    GameGlobal.GetModule(PetModule):ClearAllPetSortInfo()
    self._uiCtrl:FlushTeam(self._id)
    GameGlobal.EventDispatcher():Dispatch(GameEventType.TeamToggleIsOnChanged)
  end
end

function UITeamsSelectItem:FlushTglIsOn(isOn)
  self._tgl.isOn = isOn
end

function UITeamsSelectItem:FlushSth()
  if self._tgl.isOn then
    self._artFont.enabled = true
  else
    self._artFont.enabled = false
  end
end

function UITeamsSelectItem:btnModifyOnClick(go)
  self:ShowDialog("UITeamsNameModify", self._id)
end

function UITeamsSelectItem:GetId()
  return self._id
end

function UITeamsSelectItem:RegUIEventTriggerListener()
  if self._scrollRect then
    self:AddUICustomEventListener(self._etl, UIEvent.BeginDrag, function(eventData)
      self._tgl.enabled = false
      if self._scrollRect then
        self._scrollRect:OnBeginDrag(eventData)
      end
    end)
    self:AddUICustomEventListener(self._etl, UIEvent.Drag, function(eventData)
      if self._scrollRect then
        self._scrollRect:OnDrag(eventData)
      end
    end)
    self:AddUICustomEventListener(self._etl, UIEvent.EndDrag, function(eventData)
      self._tgl.enabled = true
      if self._scrollRect then
        self._scrollRect:OnEndDrag(eventData)
      end
    end)
    self:AddUICustomEventListener(self._modEtl, UIEvent.BeginDrag, function(eventData)
      if self._scrollRect then
        self._scrollRect:OnBeginDrag(eventData)
      end
    end)
    self:AddUICustomEventListener(self._modEtl, UIEvent.Drag, function(eventData)
      if self._scrollRect then
        self._scrollRect:OnDrag(eventData)
      end
    end)
    self:AddUICustomEventListener(self._modEtl, UIEvent.EndDrag, function(eventData)
      if self._scrollRect then
        self._scrollRect:OnEndDrag(eventData)
      end
    end)
    self._tgl.onValueChanged:AddListener(function(value)
      if value then
        AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
        self:OnValueChange()
      end
    end)
  end
end
