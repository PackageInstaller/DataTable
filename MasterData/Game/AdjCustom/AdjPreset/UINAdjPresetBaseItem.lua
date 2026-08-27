local UINAdjPresetBaseItem = class("UINAdjPresetBaseItem", UIBaseNode)
local base = UIBaseNode
local CS_MessageCommon = CS.MessageCommon
local ALPHA_BUTTOM_LOCK = 0.39215686274509803

function UINAdjPresetBaseItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self.OnClickEdit)
  UIUtil.AddButtonListener(self.ui.btn_ChangeName, self, self.OnClicName)
  UIUtil.AddButtonListener(self.ui.btn_Del, self, self.OnClickDel)
  UIUtil.AddButtonListener(self.ui.btn_Select, self, self.OnClickSelect)
  self._defaultName = self.ui.tex_PresetName.text
  self._defaultSelectTxt = self.ui.text_empty.text
  self.__OnChangeNameCallback = BindCallback(self, self.__OnChangeName)
  self.ui.text_Select:SetIndex(0)
end

function UINAdjPresetBaseItem:InitAdjPresetItem(teamId, resloader, selectFunc, clickEditFunc)
  self._teamId = teamId
  self._resloader = resloader
  self._selectFunc = selectFunc
  self._clickEditFunc = clickEditFunc
  self._unlock = false
  self:__RefreshFixContent()
  self:RefreshAdjPresetItem()
  self:RefreshAdjLockState(true)
end

function UINAdjPresetBaseItem:RefreshAdjPresetItem()
  self._data = PlayerDataCenter.allAdjCustomData:GetAdjCustomPresetData(self._teamId)
  local hasData = self._data ~= nil
  self.ui.empty:SetActive(not hasData)
  self.ui.have:SetActive(hasData)
  self.ui.btn_Select.gameObject:SetActive(hasData)
  if hasData then
    self:__RefreshAdjPresetBg()
    self:__RefreshAdjPresetHero()
  end
  self:RefreshAdjPresetItemName()
  self.ui.btn_Del.gameObject:SetActive(PlayerDataCenter.allAdjCustomData:HasAdjPresetCount() > 1)
end

function UINAdjPresetBaseItem:RefreshAdjLockState(isForce)
  if self._unlock and not isForce then
    return
  end
  local lock = PlayerDataCenter.allAdjCustomData:IsAdjPresetUnlock(self._teamId)
  if lock == self._unlock and not isForce then
    return
  end
  self._unlock = lock
  self.ui.btn_ChangeName.gameObject:SetActive(self._unlock)
  self.ui.tex_PresetName.gameObject:SetActive(self._unlock)
  self.ui.lock:SetActive(not self._unlock)
  self.ui.image_select.gameObject:SetActive(self._unlock)
  local color = self.ui.buttom_empty.color
  color.a = self._unlock and 1 or ALPHA_BUTTOM_LOCK
  self.ui.buttom_empty.color = color
  self.ui.text_empty.color = self._unlock and Color.white or Color.black
  if self._unlock then
    self.ui.text_empty.text = self._defaultSelectTxt
  else
    local cfg = ConfigData.main_interface[self._teamId]
    if cfg ~= nil then
      self.ui.text_empty.text = CheckCondition.GetUnlockInfoLua(cfg.pre_condition, cfg.pre_para1, cfg.pre_para2)
    end
  end
end

function UINAdjPresetBaseItem:__RefreshAdjPresetHero()
end

function UINAdjPresetBaseItem:__RefreshFixContent()
  self.ui.img_Index:SetIndex(self._teamId - 1)
  self.ui.curSelect:SetActive(false)
end

function UINAdjPresetBaseItem:__RefreshAdjPresetBg()
  if self._data == nil then
    return
  end
  local bgId = self._data:GetAdjPresetBgId()
  if bgId == nil then
    return
  end
  local bgCfg = ConfigData.background[bgId]
  if bgCfg == nil then
    return
  end
  self.ui.tex_BgName.text = LanguageUtil.GetLocaleText(bgCfg.name)
  local bgPath = PathConsts:GetMainSceneBgPath(bgCfg.src_id_pic_day)
  self.ui.img_Bg.gameObject:SetActive(false)
  self._resloader:LoadABAssetAsync(bgPath, function(texture)
    if not IsNull(self.transform) then
      self.ui.img_Bg.gameObject:SetActive(true)
      self.ui.img_Bg.texture = texture
    end
  end)
end

function UINAdjPresetBaseItem:RefreshAdjPresetItemName()
  local teamName
  if self._data ~= nil then
    teamName = self._data:GetAdjPresetName()
  end
  if string.IsNullOrEmpty(teamName) then
    teamName = self._defaultName .. tostring(self._teamId)
  end
  self.ui.tex_PresetName.text = teamName
end

function UINAdjPresetBaseItem:OnClickSelect()
  if not PlayerDataCenter.allAdjCustomData:IsAdjPresetUnlock(self._teamId) then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(404))
    return
  end
  PlayerClickCollectManager:BtnClickNumCollect(1013)
  if self._data == nil then
    if self._clickEditFunc ~= nil then
      self._clickEditFunc(self._teamId, 1)
    end
    return
  end
  if self._selectFunc ~= nil then
    self._selectFunc(self._teamId)
  end
end

function UINAdjPresetBaseItem:OnClicName()
  if not PlayerDataCenter.allAdjCustomData:IsAdjPresetUnlock(self._teamId) then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(404))
    return
  end
  if self._data == nil then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(403))
    return
  end
  if CloseCustomBename then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(393))
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.AdjPresetNameChange, function(window)
    if window == nil then
      return
    end
    window:InitAdjPresetNameChange(self.ui.tex_PresetName.text, self.__OnChangeNameCallback)
  end)
end

function UINAdjPresetBaseItem:__OnChangeName(nameStr)
  local network = NetworkManager:GetNetwork(NetworkTypeID.AdjCustom)
  network:CS_MainInterface_PresetRename(self._teamId, nameStr, function()
    self:RefreshAdjPresetItemName()
  end)
end

function UINAdjPresetBaseItem:OnClickEdit()
  if not PlayerDataCenter.allAdjCustomData:IsAdjPresetUnlock(self._teamId) then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(404))
    return
  end
  if self._clickEditFunc ~= nil then
    self._clickEditFunc(self._teamId, 1)
  end
end

function UINAdjPresetBaseItem:OnClickDel()
  if PlayerDataCenter.allAdjCustomData:HasAdjPresetCount() <= 1 then
    return
  end
  if PlayerDataCenter.allAdjCustomData:GetUsingAdjCustomPresetId() == self._teamId then
    CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(408))
    return
  end
  if self._data == nil or not PlayerDataCenter.allAdjCustomData:IsAdjPresetUnlock(self._teamId) then
    return
  end
  local network = NetworkManager:GetNetwork(NetworkTypeID.AdjCustom)
  network:CS_MainInterface_PresetDel(self._teamId)
end

function UINAdjPresetBaseItem:SetSelectAdjPresetItemState(flag)
  self.ui.curSelect:SetActive(flag)
  self.ui.text_Select:SetIndex(flag and 1 or 0)
  local color = self.ui.img_Select.color
  color.a = flag and 0.2 or 1
  self.ui.img_Select.color = color
end

function UINAdjPresetBaseItem:GetAdjPresetItemTeamId()
  return self._teamId
end

return UINAdjPresetBaseItem
