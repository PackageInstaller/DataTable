_class("UIPetIntimacyVoiceItem", UICustomWidget)
UIPetIntimacyVoiceItem = UIPetIntimacyVoiceItem

function UIPetIntimacyVoiceItem:OnShow(uiParams)
  self._titleLabel = self:GetUIComponent("UILocalizationText", "Title")
  self._name1Label = self:GetUIComponent("UILocalizationText", "Name1")
  self._name2Label = self:GetUIComponent("UILocalizationText", "Name2")
  self._voicePlayGo = self:GetGameObject("VoicePlay")
  self._voiceUnPlayGo = self:GetGameObject("VoiceUnPlay")
  self._name2Go = self:GetGameObject("Name2")
  self._titleGo = self:GetGameObject("Title")
end

function UIPetIntimacyVoiceItem:Refresh(intimacyMainController, intimacyVoice, petData, data)
  self._intimacyMainController = intimacyMainController
  self._intimacyVoice = intimacyVoice
  self._data = data
  self._petData = petData
  self._isOpen = true
  self.condition = nil
  if self._data.isSkin then
    self._isOpen = self._data.skinUnLock
  end
  if self._data.condition and self._data.condition ~= -1 then
    if self._isOpen then
      self._isOpen = self._data.unLock
    end
    self.condition = Cfg.pet_intimacy_condition[self._data.condition]
  end
  self:RefreshVoiceStatus()
end

function UIPetIntimacyVoiceItem:RefreshVoiceStatus()
  if self._isOpen then
    self._name1Label.text = self._data.index .. "." .. self._data.name
    self._name2Label.text = self._data.index .. "." .. self._data.name
    self._titleGo:SetActive(false)
    self._name2Go:SetActive(true)
    if self._data.isPlay then
      self._voiceUnPlayGo:SetActive(false)
      self._voicePlayGo:SetActive(true)
    else
      self._voiceUnPlayGo:SetActive(true)
      self._voicePlayGo:SetActive(false)
    end
  else
    if self._data.isSkin then
      if self._data.skinUnLock then
        self._titleLabel:SetText(StringTable.Get(self.condition.Des))
      else
        local skinid = self._data.skinID
        local cfg = Cfg.cfg_pet_skin[skinid]
        local name = cfg.SkinName
        if self._data.unLock then
          self._titleLabel:SetText(StringTable.Get("str_affinity_only_skin_unlock_des", StringTable.Get(name)))
        else
          local addCond = self.condition.AddDes
          local _tex
          if addCond then
            _tex = StringTable.Get(addCond, StringTable.Get(name))
            self._titleLabel:SetText(_tex)
          else
            self._titleLabel:SetText(StringTable.Get("str_affinity_only_skin_unlock_des", StringTable.Get(name)))
          end
        end
      end
    else
      self._titleLabel:SetText(StringTable.Get(self.condition.Des))
    end
    self._voiceUnPlayGo:SetActive(true)
    self._voicePlayGo:SetActive(false)
    self._name2Go:SetActive(false)
    self._titleGo:SetActive(true)
  end
end

function UIPetIntimacyVoiceItem:BtnVoicePlayOnClick(go)
  if not self._isOpen then
    return
  end
  self._intimacyVoice:PlayVoice(self._data, self)
end

function UIPetIntimacyVoiceItem:BtnVoiceUnPlayOnClick(go)
  if not self._isOpen then
    return
  end
  self._intimacyVoice:StopPlayVoice()
end
