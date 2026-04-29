_class("UIBattleUltraSkillCG", UIController)
UIBattleUltraSkillCG = UIBattleUltraSkillCG

function UIBattleUltraSkillCG:OnShow(arg)
  local uiParams = arg[1]
  if not self:SenityCheck(uiParams) then
    return
  end
  self:SyncLoadAllAsset(uiParams)
  self.toolbox = self:FetchUIComponents(self._fxresReq.Obj)
  local go = self:GetGameObject("SafeArea")
  self.toolbox.csRTrsfmEffect:SetParent(go.transform, false)
  self.toolbox.csRTrsfmEffect.localPosition = Vector3.zero
  self.toolbox.csRTrsfmEffect.localScale = Vector3.one
  self:Refresh(uiParams)
end

function UIBattleUltraSkillCG:Dispose()
  self.toolbox = nil
  if self._fxresReq then
    self._fxresReq:Dispose()
    self._fxresReq = nil
  end
  if self._cgMatReq then
    self._cgMatReq:Dispose()
    self._cgMatReq = nil
  end
  if self._iconMatReq then
    self._iconMatReq:Dispose()
    self._iconMatReq = nil
  end
  UIBattleUltraSkillCG.super.Dispose(self)
end

function UIBattleUltraSkillCG:SenityCheck(uiParams)
  local resmgr = ResourceManager:GetInstance()
  if not resmgr:HasResource(uiParams.effectRes) then
    Log.fatal(self._className, "invalid effectRes: ", tostring(uiParams.effectRes))
    return false
  end
  if not resmgr:HasResource(uiParams.petCGMat) then
    Log.fatal(self._className, "invalid petCG: ", tostring(uiParams.petCGMat))
    return false
  end
  if not resmgr:HasResource(uiParams.petIconMat) then
    Log.fatal(self._className, "invalid petIcon: ", tostring(uiParams.petIconMat))
    return false
  end
  return true
end

function UIBattleUltraSkillCG:SyncLoadAllAsset(uiParams)
  local resmgr = ResourceManager:GetInstance()
  self._fxresReq = resmgr:SyncLoadAsset(uiParams.effectRes, LoadType.GameObject)
  self._cgMatReq = resmgr:SyncLoadAsset(uiParams.petCGMat, LoadType.Mat)
  self._iconMatReq = resmgr:SyncLoadAsset(uiParams.petIconMat, LoadType.Mat)
end

function UIBattleUltraSkillCG:FetchUIComponents(go)
  local toolbox = {}
  toolbox.csGOEffect = go
  toolbox.csRTrsfmEffect = go:GetComponent("RectTransform")
  local csTrsfmEffect = go.transform
  toolbox.csGORoleCG = csTrsfmEffect:Find("name/root/role").gameObject
  toolbox.csRawImageRoleCG = toolbox.csGORoleCG:GetComponent("RawImage")
  toolbox.csGOIcon = csTrsfmEffect:Find("name/name01/roleicon").gameObject
  toolbox.csRawImageIcon = toolbox.csGOIcon:GetComponent("RawImage")
  local csGOSkillName = csTrsfmEffect:Find("name/name01/skill").gameObject
  toolbox.csTextSkillName = csGOSkillName:GetComponent("UILocalizationText")
  local csGOSkillNameDeco0 = csTrsfmEffect:Find("name/Text").gameObject
  toolbox.csTextSkillNameDeco0 = csGOSkillNameDeco0:GetComponent("UILocalizationText")
  local csGOSkillNameDeco1 = csTrsfmEffect:Find("name/Text1").gameObject
  toolbox.csTextSkillNameDeco1 = csGOSkillNameDeco1:GetComponent("UILocalizationText")
  toolbox.csEffectWithImageEffect = go:GetComponent("EffectWithImageEffect")
  return toolbox
end

function UIBattleUltraSkillCG:Refresh(uiParams)
  local toolbox = self.toolbox
  if toolbox.csRawImageRoleCG and self._cgMatReq and self._cgMatReq.Obj then
    toolbox.csRawImageRoleCG.material = self._cgMatReq.Obj
    toolbox.csRawImageRoleCG.transform.localPosition = Vector3(uiParams.offsetPos.x, uiParams.offsetPos.y, 0)
    toolbox.csRawImageRoleCG.transform.localScale = Vector3(uiParams.offsetScale, uiParams.offsetScale, 1)
  end
  if toolbox.csRawImageIcon and self._iconMatReq and self._iconMatReq.Obj then
    toolbox.csRawImageIcon.material = self._iconMatReq.Obj
  end
  local strSkillName = StringTable.Get("str_skill_name_" .. uiParams.skillID)
  if toolbox.csTextSkillName then
    toolbox.csTextSkillName:SetText(strSkillName)
  end
  if toolbox.csTextSkillNameDeco0 then
    toolbox.csTextSkillNameDeco0:SetText(strSkillName)
  end
  if toolbox.csTextSkillNameDeco1 then
    toolbox.csTextSkillNameDeco1:SetText(strSkillName)
  end
  local csTrsfm = self:GetGameObject().transform
  local csTrsfmUIContainer = csTrsfm.parent
  local csTrsfmDepth = csTrsfmUIContainer.parent
  local csGOCamera = csTrsfmDepth:Find("Camera").gameObject
  local csCamera = csGOCamera:GetComponent("Camera")
  if toolbox.csEffectWithImageEffect then
    toolbox.csEffectWithImageEffect.imageCamera = csCamera
  end
  self.toolbox.csGOEffect:SetActive(true)
end
