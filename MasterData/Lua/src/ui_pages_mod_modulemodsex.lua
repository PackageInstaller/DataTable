local module = class("moduleModSex", G_UIModuleBase)
local SexToggle = {MALE = true, FEMALE = false}
local _switchSexAudio = "Play_SFX_System_UI_Dressing_CHAR_Switch"

function module.bind()
  return {
    active_effect1 = false,
    active_effect2 = false,
    active_prefab1 = false,
    active_prefab2 = false,
    active_content = false,
    prefab_name1 = "",
    prefab_name2 = "",
    scale1 = L_Vector3.one,
    scale2 = L_Vector3.one,
    eular1 = L_Vector3.zero,
    eular2 = L_Vector3.zero
  }
end

function module.methods()
  return {
    onClick1 = function(self)
      self:selectSex(SexToggle.MALE, true)
    end,
    onClick2 = function(self)
      self:selectSex(SexToggle.FEMALE, true)
    end
  }
end

function module:setInitSex(isMale)
  self.isMale = isMale
end

function module:selectSex(isMale, playShowAnim)
  if self.isMale == isMale then
    return
  end
  self.isMale = isMale
  self.bind.active_effect1 = isMale == SexToggle.MALE
  self.bind.active_effect2 = isMale == SexToggle.FEMALE
  self._colorComp1.colorTint = isMale == SexToggle.MALE and C_Color.white or C_Color.grey
  self._colorComp2.colorTint = isMale == SexToggle.FEMALE and C_Color.white or C_Color.grey
  if isMale == SexToggle.MALE then
    if playShowAnim then
      self.boyAnimator:Play("Itos")
      self.girlAnimator:Play("Stoi")
    else
      self.boyAnimator:Play("Select")
      self.girlAnimator:Play("Idle")
    end
  elseif playShowAnim then
    self.boyAnimator:Play("Stoi")
    self.girlAnimator:Play("Itos")
  else
    self.boyAnimator:Play("Idle")
    self.girlAnimator:Play("Select")
  end
  C_AudioManager.Play(_switchSexAudio)
end

function module:initAll()
  self.bind.prefab_name1 = L_GameTpl:getGameConstTpl():getData(L_Const.playerPath.avatarPrefabMalePath, L_Const.GameTplType.string)
  self.bind.prefab_name2 = L_GameTpl:getGameConstTpl():getData(L_Const.playerPath.avatarPrefabFemalePath, L_Const.GameTplType.string)
  local modelCtrl1 = self.bindComponents.Hero1.prefab:GetComponent(typeof(C_ModelControl))
  local biodata1 = modelCtrl1.transform:GetChild(0):GetComponent(typeof(C_BiologyAvatar))
  biodata1.isSync = true
  local loadNames = CS.System.Array.CreateInstance(typeof(CS.System.String), 1)
  loadNames[0] = "Idle"
  self.boyAvatar = AzurWorld.avatarMgr:SetAvatarUIPreviewWithLoadStateNames(modelCtrl1, L_ModStore:getDefaultData(L_Const.sexType.male), loadNames)
  biodata1.magicaClothActive = false
  self.boyAnimator = biodata1:GetComponent(typeof(C_PlayableAnimator))
  self.boyAnimator.updateMode = C_PlayableAnimator.UpdateMode.Normal
  self.boyAnimator:Play("Idle")
  self._colorComp1 = self.bindComponents.Hero1.prefab.gameObject:PickComponent(typeof(CS.CharacterColorAdjust))
  local modelCtrl2 = self.bindComponents.Hero2.prefab:GetComponent(typeof(C_ModelControl))
  local biodata2 = modelCtrl2.transform:GetChild(0):GetComponent(typeof(C_BiologyAvatar))
  biodata2.isSync = true
  self.girlAvatar = AzurWorld.avatarMgr:SetAvatarUIPreviewWithLoadStateNames(modelCtrl2, L_ModStore:getDefaultData(L_Const.sexType.female), loadNames)
  biodata2.magicaClothActive = false
  self.girlAnimator = biodata2:GetComponent(typeof(C_PlayableAnimator))
  self.girlAnimator.updateMode = C_PlayableAnimator.UpdateMode.Normal
  self.girlAnimator:Play("Idle")
  self._colorComp2 = self.bindComponents.Hero2.prefab.gameObject:PickComponent(typeof(CS.CharacterColorAdjust))
  if L_ModStore:getModData() then
    self:selectSex(L_ModStore:getModData().Sex ~= 2)
  else
    self:selectSex(SexToggle.MALE)
  end
end

function module:showAll()
  self.bind.active_content = true
  self.bind.active_prefab1 = true
  self.bind.active_prefab2 = true
  self.bind.active_effect1 = self.isMale == SexToggle.MALE
  self.bind.active_effect2 = self.isMale ~= SexToggle.MALE
end

function module:hideAll()
  self.bind.active_content = false
  self.bind.active_prefab1 = false
  self.bind.active_prefab2 = false
  self.bind.active_effect1 = false
  self.bind.active_effect2 = false
end

function module:close()
  if self.boyAvatar then
    AzurWorld.avatarMgr:ReleaseAvatarController(self.boyAvatar)
    self.boyAvatar = nil
  end
  if self.girlAvatar then
    AzurWorld.avatarMgr:ReleaseAvatarController(self.girlAvatar)
    self.girlAvatar = nil
  end
end

return module
