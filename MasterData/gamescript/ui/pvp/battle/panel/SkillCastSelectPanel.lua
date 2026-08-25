local UICustomInput = CS.UICustomInput
local Vector2 = CS.UnityEngine.Vector2
local Vector3 = CS.UnityEngine.Vector3
local RectTransformUtility = CS.UnityEngine.RectTransformUtility
local UIAnimationController = CS.Z1Client.UIAnimationController
local TypeCamera = typeof(CS.UnityEngine.Camera)
local TypeRawImage = typeof(CS.UnityEngine.UI.RawImage)
local RenderTexture = CS.UnityEngine.RenderTexture
local SkillCastSelectPanel, Super = System.NewClass("SkillCastSelectPanel", UIBasePanel)
SkillCastSelectPanel.uiResCls = UI_Pvp_Skill_SelectedResource

function SkillCastSelectPanel:ctor(data)
  Super.ctor(self)
  Logger.Info("SkillCastSelectPanel:ctor data ", table.tostring(data))
  self.data = data
  self.casterSfxList = {}
  self._selectConfirmed = false
  self._cancelHandled = false
end

function SkillCastSelectPanel:OnBind(binder)
  self.binder = binder
  self:InitFunc()
  self:InitMapUI()
  self:ResetHover()
  self:ExcuteByData()
  self:HoverCheck()
  self:InitCardDesc()
  self:ShowCasterSfx()
  self:RenderSelectAwaker()
  bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ChangeBoutPhase, self.OnChangeBoutPhase, self)
  self.binder:BindEvent(EventMgr.Instance.BattleResult, System.fn(self, self.Close))
end

function SkillCastSelectPanel:RenderSelectAwaker()
  EventMgr.Instance.PVPAwakerSelect:Dispatch(self:GetAwakerUidMap())
  local sizeDelta = self.ui.Image_Awaker.transform.sizeDelta
  local imgWidth = sizeDelta.x
  local imgHeight = sizeDelta.y
  local rtCamera = self.ui.TopSceneCamera:GetComponent(TypeCamera)
  self:SetRTCamera(rtCamera)
  if self._renderTexture then
    RenderTexture.ReleaseTemporary(self._renderTexture)
  end
  self._renderTexture = RenderTexture.GetTemporary(imgWidth, imgHeight)
  local scale = UIRootMgr.GetUIRootHeight() / imgHeight
  self.ui.Image_Awaker.transform.localScale = Vector3(scale, scale, 1)
  rtCamera.targetTexture = self._renderTexture
  local compRawImage = self.ui.Image_Awaker:GetComponent(TypeRawImage)
  compRawImage.texture = self._renderTexture
  local eraseBlackMat = ResLoadMgr.LoadAsset("Render/Material/RenderTextureEraseBlack.mat", self)
  if eraseBlackMat then
    local mat = GameObject.Instantiate(eraseBlackMat)
    compRawImage.material = mat
    self.eraseBlackMat = mat
  end
end

function SkillCastSelectPanel:SetRTCamera(rtCamera)
  local mainCamera = UIRootMgr.GetMainCamera()
  local topSceneCameraTf = rtCamera.gameObject.transform
  local mainCameraGoTf = mainCamera.gameObject.transform
  topSceneCameraTf.position = mainCameraGoTf.position
  topSceneCameraTf.rotation = mainCameraGoTf.rotation
  rtCamera.fieldOfView = mainCamera.fieldOfView
  rtCamera.nearClipPlane = mainCamera.nearClipPlane
  rtCamera.farClipPlane = mainCamera.farClipPlane
end

function SkillCastSelectPanel:GetAwakerUidMap()
  local uidMap = {}
  if self.data.castAwakerUid then
    uidMap[self.data.castAwakerUid] = true
  end
  if self.data.castRoleUid then
    uidMap[self.data.castRoleUid] = true
  end
  for _, uid in ipairs(self.data.targetUids or {}) do
    uidMap[uid] = true
  end
  for _, uid in ipairs(self.clientSelectedAwaker or {}) do
    uidMap[uid] = true
  end
  return uidMap
end

function SkillCastSelectPanel:OnChangeBoutPhase()
  self:Close()
end

function SkillCastSelectPanel:ExcuteByData()
  local data = self.data
  local targetSelectType = data.targetSelectType
  local targetType = data.targetType
  if bc.TargetSelectType.Awaker == targetSelectType then
    Logger.Info("指示器api：", targetType)
    self:ShowCastMate()
    self.targetFuncMap[targetType]()
  end
end

function SkillCastSelectPanel:InitFunc()
  self.targetFuncMap = {}
  for key, _ in pairs(bc.PVPTargetType) do
    self.targetFuncMap[key] = System.fn(self, self[key])
  end
end

function SkillCastSelectPanel:ShowCasterSfx()
  self:RemoveCasterSfx()
  local castRoleUid = self.data.castRoleUid or -1
  local role = bg.battleScene:GetRoleByUid(castRoleUid)
  if not role or role.roleType == bc.RoleType.Player then
    return
  end
  local effectKey = bg.battleDataCenter:IsMyCamp(role.camp) and "PVPMinerReadyVFX" or "PVPEnemyReadyVFX"
  local casterEffectList = bg.DT.GetOriginalConstant(effectKey) or {}
  for _, effectId in ipairs(casterEffectList) do
    local sfx = role:PlaySfx(effectId)
    if sfx then
      table.insert(self.casterSfxList, sfx)
    end
  end
end

function SkillCastSelectPanel:RemoveCasterSfx()
  for _, sfx in ipairs(self.casterSfxList) do
    bg.battleRender.sfxMgr:FreeSfx(sfx)
  end
  self.casterSfxList = {}
end

function SkillCastSelectPanel:InitMapUI()
  self.pvp_UI = {
    enemyFrame = self.ui.Image_Right_Steer,
    mateFrame = self.ui.Image_left_Steer,
    cardFrame = self.ui.Image_Card_Steer,
    enemyPos1 = self.ui.Image_Steer_1,
    enemyPos2 = self.ui.Image_Steer_2,
    enemyPos3 = self.ui.Image_Steer_3,
    enemyPos4 = self.ui.Image_Steer_4,
    matePos1 = self.ui.Image_Steer_5,
    matePos2 = self.ui.Image_Steer_6,
    matePos3 = self.ui.Image_Steer_7,
    matePos4 = self.ui.Image_Steer_8,
    mateCast1 = self.ui.Image_Cast_1,
    mateCast2 = self.ui.Image_Cast_2,
    mateCast3 = self.ui.Image_Cast_3,
    mateCast4 = self.ui.Image_Cast_4,
    mateAll = self.ui.Image_All_1,
    enemyAll = self.ui.Image_All_2,
    cardAll = self.ui.Image_All_3,
    mateRandom = self.ui.Image_Random_1,
    enemyRandom = self.ui.Image_Random_2,
    cardRandom = self.ui.Image_Random_3
  }
  self:ResetUI()
  local mateCamp = bg.battleDataCenter:GetMyCamp()
  local enemyCamp = bg.battleDataCenter:GetEnemyCamp()
  self:FixFramePos(mateCamp, self.pvp_UI.mateFrame.transform)
  self:FixFramePos(enemyCamp, self.pvp_UI.enemyFrame.transform)
  local mateSpawnPoints = bg.battleScene:GetSpawnPointsMap(mateCamp)
  local enemySpawnPoints = bg.battleScene:GetSpawnPointsMap(enemyCamp)
  for i = 1, 4 do
    local mateSpawnPos = mateSpawnPoints[i].position
    local enemySpawnPos = enemySpawnPoints[i].position
    self:Fix2Pos(mateSpawnPos, self.pvp_UI["matePos" .. i].transform)
    self:Fix2Pos(mateSpawnPos, self.pvp_UI["mateCast" .. i].transform)
    self:Fix2Pos(enemySpawnPos, self.pvp_UI["enemyPos" .. i].transform)
  end
end

function SkillCastSelectPanel:Fix2Pos(targetWorldPos, trans)
  local uiCamera = UIRootMgr.GetUICamera()
  local orilocalPos = trans.localPosition
  local screenPos = self:WorldToScreenPoint(targetWorldPos)
  local curScreenPos = self:WorldToScreenPoint(trans.position)
  curScreenPos.x = screenPos.x
  local _, worldPos = RectTransformUtility.ScreenPointToWorldPointInRectangle(trans, curScreenPos, uiCamera)
  trans.position = worldPos
  trans.localPosition = Vector3(trans.localPosition.x, orilocalPos.y, 0)
end

function SkillCastSelectPanel:FixFramePos(camp, frame)
  local matePos = self:GetCenterPos(camp)
  self:Fix2Pos(matePos, frame)
end

function SkillCastSelectPanel:GetCenterPos(camp)
  local firstPosTrans = bg.battleScene:GetSpawnPoint(camp, 1)
  local forthPosTrans = bg.battleScene:GetSpawnPoint(camp, 4)
  local firstPos = firstPosTrans.position
  local forthPos = forthPosTrans.position
  local centerPos = (firstPos + forthPos) / 2
  return centerPos
end

function SkillCastSelectPanel:WorldToScreenPoint(pos)
  local mainCamera = UIRootMgr.GetMainCamera()
  local screenPos = mainCamera:WorldToScreenPoint(pos)
  screenPos = Vector2(screenPos.x, screenPos.y)
  return screenPos
end

function SkillCastSelectPanel:ResetUI()
  for _, v in pairs(self.pvp_UI) do
    v:SetActive(false)
  end
end

function SkillCastSelectPanel:_GetCastCard()
  local skillConfigId = self.data and self.data.skillConfigId
  if not (skillConfigId and bg.battleRender) or not bg.battleRender.cardMgr then
    return nil
  end
  if bg.ultiSkillAwakerTid and SkillDataUtils.CheckIsUltiSkill(skillConfigId) then
    return nil
  end
  local card = bg.battleRender.cardMgr:GetCardByConfigId(skillConfigId)
  local cardUid = self.data.cardUid
  if cardUid then
    card = bg.battleRender.cardMgr:GetCardByUid(cardUid)
  end
  return card
end

function SkillCastSelectPanel:_SkillCastCardIsConfuse()
  local card = self:_GetCastCard()
  if card then
    do return card.IsConfuse end
    return card.IsConfuse, card, nil, nil, nil, nil, nil
  end
  if bg.isPVP and bg.ultiSkillAwakerTid then
    local skillConfigId = self.data and self.data.skillConfigId
    if skillConfigId and SkillDataUtils.CheckIsUltiSkill(skillConfigId) then
      local castRoleUid = self.data.castRoleUid
      local castRole = bg.battleDataCenter:GetRoleDataModel(castRoleUid)
      if castRole then
        local myCamp = bg.battleDataCenter:GetMyCamp()
        if castRole.camp == myCamp then
          local ErosionColorInk = castRole:GetProperty(bc.BattleProperty.ErosionColorInk)
          return ErosionColorInk and ErosionColorInk > 0
        end
      end
    end
  end
  return false
end

function SkillCastSelectPanel:_GetRawNameForCastPanel()
  local skillConfigId = self.data.skillConfigId
  if not skillConfigId then
    return ""
  end
  if bg.ultiSkillAwakerTid and SkillDataUtils.CheckIsUltiSkill(skillConfigId) then
    local castRoleUid = self.data.castRoleUid
    local castRole = bg.battleDataCenter:GetRoleDataModel(castRoleUid)
    do return AwakerDataUtils.GetUltiSkillName, bg.ultiSkillAwakerTid end
    return AwakerDataUtils.GetUltiSkillName, bg.ultiSkillAwakerTid, castRole, nil, nil, nil, nil, nil
  end
  local card = self:_GetCastCard()
  if card then
    local skillId = card.configData.ID
    local cardType = card.configData.Type
    if table.contains(cardType, "Card_KeeperSkill") and not ItemDataUtils.IsPlayerHasKeeperSkill(skillId) then
      local skillConfig = DT.Skill[skillId]
      if skillConfig then
        do return LT.Text end
        return LT.Text, skillConfig.UnknownName, nil, nil, nil, nil
      end
    end
    local _, potencyLevel = BattleSkillUtils.GetBreakAndPotencyLevel(card.awaker)
    local breakSkillLevel = BattleSkillUtils.GetBreakSkillLevel(card.awaker)
    do return BattleSkillUtils.GetSkillName, card.configData, breakSkillLevel end
    return BattleSkillUtils.GetSkillName, card.configData, breakSkillLevel, potencyLevel
  end
  local castRoleUid = self.data.castRoleUid
  local castRole = bg.battleScene:GetRoleByUid(castRoleUid)
  do return BattleSkillUtils.GetSkillName, DT.Skill[skillConfigId], 0, 0 end
  return BattleSkillUtils.GetSkillName, DT.Skill[skillConfigId], 0, 0, {awaker = castRole}, breakSkillLevel, potencyLevel
end

function SkillCastSelectPanel:_GetRawDescForCastPanel()
  local skillConfigId = self.data.skillConfigId
  if not skillConfigId then
    return ""
  end
  if bg.ultiSkillAwakerTid and SkillDataUtils.CheckIsUltiSkill(skillConfigId) then
    local castRoleUid = self.data.castRoleUid
    local castRole = bg.battleScene:GetRoleByUid(castRoleUid)
    do return bg.battleDataCenter.GetUltiSkillDesc, bg.battleDataCenter, bg.ultiSkillAwakerTid end
    return bg.battleDataCenter.GetUltiSkillDesc, bg.battleDataCenter, bg.ultiSkillAwakerTid, castRole
  end
  local card = self:_GetCastCard()
  if not card then
    return ""
  end
  do return card.GetCardDescription end
  return card.GetCardDescription, card, bg.battleDataCenter, bg.ultiSkillAwakerTid, castRole
end

function SkillCastSelectPanel:_ApplyCastPanelCardDescText(rawDesc)
  local desc = rawDesc
  local isConfuse = self:_SkillCastCardIsConfuse()
  if isConfuse then
    if #desc > 0 then
      math.randomseed(#desc)
      desc = desc:sub(1, math.random(50, 70))
    end
  else
    desc = LT.EnsureDescEndsWithPeriod(desc)
  end
  desc = LT.ReplaceSpecialChineseChar(desc)
  local setOk, setErr = pcall(function()
    self.binder:SetText(self.ui.Text_Card_Desc, desc, false, nil, {OpenConfuseText = isConfuse, banKeywordBtn = true})
  end)
  if not setOk then
    Logger.Warn("SkillCastSelectPanel._ApplyCastPanelCardDescText SetText failed err=%s", tostring(setErr))
    self.binder:SetRawText(self.ui.Text_Card_Desc, desc or "")
  end
  self.binder:RemoveUnderline(self.ui.Text_Card_Desc)
end

function SkillCastSelectPanel:_BindCastPanelCardName()
  self.binder:BindToRaw(function(cbinder, name)
    if nil == name then
      name = ""
    end
    cbinder:BindToRaw(function()
      local isConfuse = self:_SkillCastCardIsConfuse()
      local showName = name
      if isConfuse and #showName > 0 then
        math.randomseed(#name)
        showName = name:sub(1, math.random(2, 8))
      elseif not isConfuse and DataCenter.gameData.CurrTextLanguage == cd.Lang.EN and "" ~= showName then
        showName = StrUtils.CapitalizeFirstLetter(name)
      end
      self.binder:SetText(self.ui.Text_Card_Name, showName, nil, nil, {OpenConfuseText = isConfuse})
    end, function()
      do return self._SkillCastCardIsConfuse end
      return self._SkillCastCardIsConfuse, self
    end)
  end, System.fn(self, self._GetRawNameForCastPanel))
end

function SkillCastSelectPanel:_BindCastPanelCardDesc()
  self.binder:BindToRaw(function(cbinder, desc)
    if nil == desc then
      desc = ""
    end
    cbinder:BindToRaw(function()
      self:_ApplyCastPanelCardDescText(desc)
    end, function()
      do return self._SkillCastCardIsConfuse end
      return self._SkillCastCardIsConfuse, self
    end)
  end, System.fn(self, self._GetRawDescForCastPanel))
end

function SkillCastSelectPanel:InitCardDesc()
  self.binder:BindToVisible(self.ui.Image_Card_Desc, function()
    return true
  end)
  self:_BindCastPanelCardName()
  self:_BindCastPanelCardDesc()
end

function SkillCastSelectPanel:ResetHover()
  self.hoverList = {}
end

function SkillCastSelectPanel:CancelCheck()
  if self.curHoverCnt <= 0 then
    self:CancelSelectTarget()
    FrameWaiter.OnNextFrame(function()
      self:Close()
    end, 1)
  end
end

function SkillCastSelectPanel:HoverCheck()
  self.curHoverCnt = 0
  local triCnt = #self.hoverList
  for _, obj in ipairs(self.hoverList) do
    UICustomInput.Get(obj).onAction = function(hover)
      if hover then
        self.curHoverCnt = self.curHoverCnt + 1
      end
      triCnt = triCnt - 1
      if triCnt <= 0 then
        self:CancelCheck()
        self.curHoverCnt = 0
        triCnt = #self.hoverList
      end
    end
  end
end

function SkillCastSelectPanel:GetUIByUid(uid, tag)
  local role = bg.battleScene:GetRoleByUid(uid)
  if role then
    local uiName = tag .. role.battleFieldPos
    local uiObj = self.pvp_UI[uiName]
    return uiObj
  else
    return nil
  end
end

function SkillCastSelectPanel:ShowCastMate()
  local castUid = self.data.castAwakerUid
  local casterUi = self:GetUIByUid(castUid, "mateCast")
  if casterUi then
    casterUi:SetActive(true)
  end
end

function SkillCastSelectPanel:GetMateCamp()
  do return bg.battleDataCenter.GetRoleCamp, bg.battleDataCenter end
  return bg.battleDataCenter.GetRoleCamp, bg.battleDataCenter, self.data.castRoleUid
end

function SkillCastSelectPanel:GetEnemyCamp()
  local castUid = self.data.castRoleUid
  local Camp1 = bc.BattleCamp.Camp1
  local Camp2 = bc.BattleCamp.Camp2
  local castCamp = bg.battleDataCenter:GetRoleCamp(castUid)
  local enemyCamp = castCamp == Camp1 and Camp2 or Camp1
  return enemyCamp
end

function SkillCastSelectPanel:CancelSelectTarget()
  if self._cancelHandled then
    return
  end
  self._cancelHandled = true
  bg.battleRender:SendCommand(BattleCommand.lg_CancelSelectTargets, {})
  EventMgr.Instance.PVPAwakerSelectCancel:Dispatch(self.data.skillConfigId)
end

function SkillCastSelectPanel:ConfirmSelectTarget()
  self._selectConfirmed = true
  local cmdTargetMode = bg.battleRender.cmdTargetMgr and bg.battleRender.cmdTargetMgr:GetModel() or bc.PVPTargetModel.Server
  Logger.Info("SkillCastSelectPanel:ConfirmSelectTarget self.data ", table.tostring(self.data))
  if cmdTargetMode == bc.PVPTargetModel.Server then
    bg.battleRender:SendCommand(BattleCommand.lg_SelectTargets, self.data)
  elseif cmdTargetMode == bc.PVPTargetModel.Client then
    bg.battleRender:SendCommand(self.data.battleCommandId, self.data)
  end
  self:Close()
end

function SkillCastSelectPanel:ShowEnemyFrame()
  self.pvp_UI.enemyFrame:SetActive(true)
  table.insert(self.hoverList, self.pvp_UI.enemyFrame)
end

function SkillCastSelectPanel:ShowMateFrame()
  self.pvp_UI.mateFrame:SetActive(true)
  table.insert(self.hoverList, self.pvp_UI.mateFrame)
end

function SkillCastSelectPanel:ShowTargetNotSelect(tag)
  for _, uid in ipairs(self.data.targetUids) do
    local ui = self:GetUIByUid(uid, tag)
    if ui then
      ui:SetActive(true)
      self:PlaySelectAnim(ui)
      self.binder:BindZ1Button(ui, System.fn(self, self.ConfirmSelectTarget))
      table.insert(self.hoverList, ui)
    end
  end
end

function SkillCastSelectPanel:ShowTargetSelectOne(list, tag)
  local function selectCall(uid)
    table.clear(self.data.targetUids)
    
    table.insert(self.data.targetUids, uid)
    self:ConfirmSelectTarget()
  end
  
  for _, uid in pairs(list) do
    self:PlayTargetSelectOne(uid, tag, selectCall)
  end
end

function SkillCastSelectPanel:PlayTargetSelectOne(uid, tag, clickFunc)
  local ui = self:GetUIByUid(uid, tag)
  ui:SetActive(true)
  self:PlaySelectAnim(ui)
  self.binder:BindZ1Button(ui, function()
    if clickFunc then
      clickFunc(uid)
    end
  end)
  table.insert(self.hoverList, ui)
end

function SkillCastSelectPanel:SelectCmdCaster()
  self:ShowTargetNotSelect("matePos")
end

function SkillCastSelectPanel:SelectFrontEnemy()
  self:ShowTargetNotSelect("enemyPos")
end

function SkillCastSelectPanel:SelectAlly()
  self:ShowTargetSelectOne(self.data.targetUids, "matePos")
end

function SkillCastSelectPanel:SelectEnemy()
  self:ShowTargetSelectOne(self.data.targetUids, "enemyPos")
end

function SkillCastSelectPanel:SelectRandomEnemy()
  self:ShowEnemyFrame()
  self.pvp_UI.enemyRandom:SetActive(true)
  self.binder:BindZ1Button(self.pvp_UI.enemyFrame, System.fn(self, self.ConfirmSelectTarget))
end

function SkillCastSelectPanel:SelectAwaker()
  local myList = {}
  local enemyList = {}
  local myCamp = self:GetMateCamp()
  for _, uid in ipairs(self.data.targetUids) do
    local camp = bg.battleDataCenter:GetRoleCamp(uid)
    if myCamp == camp then
      table.insert(myList, uid)
    else
      table.insert(enemyList, uid)
    end
  end
  self:ShowTargetSelectOne(myList, "matePos")
  self:ShowTargetSelectOne(enemyList, "enemyPos")
end

function SkillCastSelectPanel:SelectAllOtherAwaker()
  local myList = {}
  local enemyList = {}
  local myCamp = self:GetMateCamp()
  for _, uid in ipairs(self.data.targetUids) do
    local camp = bg.battleDataCenter:GetRoleCamp(uid)
    if myCamp == camp then
      table.insert(myList, uid)
    else
      table.insert(enemyList, uid)
    end
  end
  self:ShowTargetSelectOne(myList, "matePos")
  self:ShowTargetSelectOne(enemyList, "enemyPos")
end

function SkillCastSelectPanel:SelectTarget()
  local myList = {}
  local enemyList = {}
  local myCamp = self:GetMateCamp()
  for _, uid in ipairs(self.data.targetUids) do
    local camp = bg.battleDataCenter:GetRoleCamp(uid)
    if myCamp == camp then
      table.insert(myList, uid)
    else
      table.insert(enemyList, uid)
    end
  end
  self:ShowTargetSelectOne(myList, "matePos")
  self:ShowTargetSelectOne(enemyList, "enemyPos")
end

function SkillCastSelectPanel:SelectMaxHpEnemy()
  local _, targetTag = self:_GetTargetTypeTag()
  local enemyCamp = bg.battleDataCenter:GetEnemyCamp()
  local targetUid = bg.battleRender.cmdTargetMgr and bg.battleRender.cmdTargetMgr:GetTargetEnermyUidWithHpBlock(bc.PVPTargetType.SelectMaxHpEnemy, enemyCamp, targetTag)
  if targetUid then
    self.clientSelectedAwaker = {targetUid}
    self:PlayTargetSelectOne(targetUid, "enemyPos", System.fn(self, self.ConfirmSelectTarget))
  end
end

function SkillCastSelectPanel:SelectMinHpEnemy()
  local _, targetTag = self:_GetTargetTypeTag()
  local enemyCamp = bg.battleDataCenter:GetEnemyCamp()
  local targetUid = bg.battleRender.cmdTargetMgr and bg.battleRender.cmdTargetMgr:GetTargetEnermyUidWithHpBlock(bc.PVPTargetType.SelectMinHpEnemy, enemyCamp, targetTag)
  if targetUid then
    self.clientSelectedAwaker = {targetUid}
    self:PlayTargetSelectOne(targetUid, "enemyPos", System.fn(self, self.ConfirmSelectTarget))
  end
end

function SkillCastSelectPanel:_GetTargetTypeTag()
  local cmdTargetStr = SkillDataUtils.GetSkillCfgByField("CmdTarget", self.data.skillConfigId) or ""
  local awakerUid = self.data.castRoleUid
  local awaker = bg.battleScene:GetRoleByUid(awakerUid)
  local params = {awaker = awaker}
  local targetType, targetTag = SkillDataUtils.ParseCmdTargetStr(cmdTargetStr, self.data.skillConfigId, params)
  return targetType, targetTag
end

function SkillCastSelectPanel:SelectRandomAlly()
  self:ShowMateFrame()
  self.pvp_UI.mateRandom:SetActive(true)
  self.binder:BindZ1Button(self.pvp_UI.mateFrame, System.fn(self, self.ConfirmSelectTarget))
end

function SkillCastSelectPanel:SelectAllAlly()
  self:ShowMateFrame()
  self.pvp_UI.mateAll:SetActive(true)
  self.binder:BindZ1Button(self.pvp_UI.mateFrame, System.fn(self, self.ConfirmSelectTarget))
end

function SkillCastSelectPanel:SelectAllEnemy()
  self:ShowEnemyFrame()
  self.pvp_UI.enemyAll:SetActive(true)
  self.binder:BindZ1Button(self.pvp_UI.enemyFrame, System.fn(self, self.ConfirmSelectTarget))
end

function SkillCastSelectPanel:OnUnbind()
  if not self._selectConfirmed then
    self:CancelSelectTarget()
  end
  if not IsNil(self.eraseBlackMat) then
    GameObject.Destroy(self.eraseBlackMat)
    self.eraseBlackMat = nil
  end
  self:RemoveCasterSfx()
  bg.battleRender.eventMgr:UnregisterEvent(BattleRenderEvent.ChangeBoutPhase, self.OnChangeBoutPhase, self)
  EventMgr.Instance.PVPAwakerSelect:Dispatch()
  if not IsNil(self._renderTexture) then
    RenderTexture.ReleaseTemporary(self._renderTexture)
  end
  Super.OnUnbind(self)
end

function SkillCastSelectPanel:PlaySelectAnim(ui)
  local prefab = self.binder:LoadAsset("UI/UI_Pvp/UI_Pvp_Prefab/UI_Vx_Pvp_Skill_Selected_01.prefab")
  local go = self.binder:Instantiate(prefab, ui.transform)
  local rectTrans = go:GetComponent(typeof(CS.UnityEngine.RectTransform))
  rectTrans.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
  local uiAnimationController = go:GetComponent(typeof(UIAnimationController))
  uiAnimationController:LoopPlayState("UI_Vx_Pvp_Skill_Selected_01")
end

return SkillCastSelectPanel
