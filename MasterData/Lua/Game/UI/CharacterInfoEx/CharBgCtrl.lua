local CharBgCtrl = class("CharBgCtrl", BaseCtrl)
local PlayerCharData = PlayerData.Char
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local Path = require("path")
local LocalSettingData = require("GameCore.Data.LocalSettingData")
local ResTypeAny = GameResourceLoader.ResType.Any
local LayerMask = CS.UnityEngine.LayerMask
local RendererProjectionModifier = CS.RendererProjectionModifier
local typeof = _ENV.typeof
CharBgCtrl._mapNodeConfig = {
  imgBgRT = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  UIDrag = {
    sComponentName = "UIDrag",
    callback = "OnDrag_Character"
  },
  rtBgRoot = {sNodeName = "----bg----", sComponentName = "Transform"},
  animBgLeft = {sNodeName = "bgLeft", sComponentName = "Animator"},
  animBgMiddle = {sNodeName = "bgMiddle", sComponentName = "Animator"},
  rtOffScreenRoot = {
    sNodeName = "Char_OffScreen_Renderer",
    sComponentName = "Transform"
  },
  trCamera = {
    sNodeName = "OffScreen3DCamera",
    sComponentName = "Camera"
  },
  bgRight = {
    sComponentName = "SpriteRenderer"
  },
  trCharacter = {sNodeName = "animator", sComponentName = "Transform"},
  trPanelOffsetL2D = {
    sNodeName = "panel_offset",
    sComponentName = "Transform"
  },
  trActorOffsetL2d = {
    sNodeName = "actor_offset",
    sComponentName = "Transform"
  },
  trPng = {sNodeName = "PNG", sComponentName = "Transform"},
  trL2D = {sNodeName = "L2D", sComponentName = "Transform"},
  spr_body = {
    sNodeName = "sp_body",
    sComponentName = "SpriteRenderer"
  },
  spr_face = {
    sNodeName = "sp_face",
    sComponentName = "SpriteRenderer"
  },
  actor2dNode = {
    sNodeName = "----Actor2D_Node----",
    sComponentName = "Transform"
  }
}
CharBgCtrl._mapEventConfig = {
  [EventId.CharBgRefresh] = "OnEvent_RefreshPanel",
  [EventId.CharRelatePanelAdvance] = "OnEvent_PanelSwitch",
  [EventId.CharRelatePanelBack] = "OnEvent_PanelSwitch",
  [EventId.HideCharBgActor] = "OnEvent_HideCharBgActor",
  [EventId.RevertCharBgActor] = "OnEvent_RevertCharBgActor",
  PlayCharL2DAnim = "PlayCharL2DAnim",
  PlayCharBgLeftAnim = "PlayCharBgLeftAnim",
  ChangeCharBgDrag = "OnEvent_ChangeDrag",
  SwitchCurChar = "OnEvent_SwitchCurChar"
}

function CharBgCtrl:CreateRT()
end

function CharBgCtrl:ReleaseRT()
  NovaAPI.SetTexture(self._mapNode.imgBgRT, nil)
end

function CharBgCtrl:GetOffsetData(sOffset)
  local objOffset
  if nil == self.mapOffsetObj[sOffset] then
    objOffset = self:LoadAsset(sOffset, typeof(CS.Actor2DOffsetData))
    self.mapOffsetObj[sOffset] = objOffset
  else
    objOffset = self.mapOffsetObj[sOffset]
  end
  local nShowPanelId = self:GetOffsetPanelId()
  if nil == objOffset then
    printError(string.format("角色关联界面 加载偏移数据失败！！！panelId = %s, 加载路径[%s]", nShowPanelId, sOffset))
    return Vector3.zero, Vector3.one
  end
  local nX, nY = 0, 0
  local s, x, y = objOffset:GetOffsetData(nShowPanelId, indexOfPose("a"), true, nX, nY)
  local vPos = Vector3(x, y, 0)
  local vScale = Vector3(s, s, 1)
  return vPos, vScale
end

function CharBgCtrl:GetOffsetPanelId()
  local nShowPanelId = self._panel.nPanelId
  local tbConfig = Actor2DManager.GetMapPanelConfig(self._panel.nPanelId)
  if nil ~= tbConfig and tbConfig.nReuse > 0 then
    nShowPanelId = tbConfig.nReuse
  end
  return nShowPanelId
end

function CharBgCtrl:CheckUseL2D()
  local bL2D = false
  local tbConfig = Actor2DManager.GetMapPanelConfig(self._panel.nPanelId)
  if nil ~= tbConfig then
    bL2D = tbConfig.bL2D and LocalSettingData.mapData.UseLive2D
  end
  return bL2D
end

function CharBgCtrl:GetName(sPortrait, sFace)
  local sFileFullName = Path.basename(sPortrait)
  local sFileExtName = Path.extension(sPortrait)
  local sFileName = string.gsub(sFileFullName, sFileExtName, "")
  sFileName = string.gsub(sFileName, "_a", "")
  local sBodyName = string.format("%s_%s", sFileName, "001")
  local sFaceName = string.format("%s_%s", sFileName, sFace)
  return sBodyName, sFaceName
end

function CharBgCtrl:SetCharacterPng(nSkinId, nType)
  local bSetSuccess, nT, nAnimLength, tbRenderer = Actor2DManager.SetActor2DWithRender(self._panel.nPanelId, self._mapNode.imgBgRT, self.nCharId, nSkinId, nil, self._mapNode.actor2dNode)
  if bSetSuccess and self.lasttrPanelOffsetL2DPos ~= nil then
    self._mapNode.trPanelOffsetL2D:DOLocalMoveX(self.lasttrPanelOffsetL2DPos, 0):SetUpdate(true)
  end
  local skinCfgData = ConfigTable.GetData_CharacterSkin(nSkinId)
  NovaAPI.SetSpriteRendererSprite(self._mapNode.bgRight, self:LoadAsset(skinCfgData.Bg .. ".png", typeof(Sprite)))
end

function CharBgCtrl:SetCharacterL2D(nSkinId, nType)
  if nil ~= self.tbRenderer then
    if self.tbRenderer.nSkinId == nSkinId then
      return
    end
    self:RecycleCharacter()
  end
  local bSetSuccess, nT, nAnimLength, tbRenderer = Actor2DManager.SetActor2DWithRender(self._panel.nPanelId, self._mapNode.imgBgRT, self.nCharId, nSkinId, nil, self._mapNode.actor2dNode)
  if bSetSuccess then
    self.tbRenderer = {}
    self.tbRenderer.nSkinId = nSkinId
    self.tbRenderer.tbRenderer = tbRenderer
    self.mapCharacter[nSkinId] = self.tbRenderer
    Actor2DManager.PlayL2DAnim(self.tbRenderer.tbRenderer.trL2DIns, "idle", true, true)
    if self.lasttrPanelOffsetL2DPos ~= nil then
      self._mapNode.trPanelOffsetL2D:DOLocalMoveX(self.lasttrPanelOffsetL2DPos, 0):SetUpdate(true)
    end
  end
  local skinCfgData = ConfigTable.GetData_CharacterSkin(nSkinId)
  NovaAPI.SetSpriteRendererSprite(self._mapNode.bgRight, self:LoadAsset(skinCfgData.Bg .. ".png", typeof(Sprite)))
end

function CharBgCtrl:SetCharacter(nCharId)
  if nil ~= nCharId and nCharId ~= self.nCharId then
    self.nCharId = nCharId
  end
  local nSkinId = PlayerCharData:GetCharSkinId(self.nCharId)
  local bL2D = self:CheckUseL2D()
  local nType = AllEnum.Actor2DType.Normal
  if bL2D then
    self:SetCharacterL2D(nSkinId, nType)
  else
    self:SetCharacterPng(nSkinId, nType)
  end
  self._mapNode.trL2D.gameObject:SetActive(bL2D)
  self._mapNode.trPng.gameObject:SetActive(not bL2D)
  local skinCfgData = ConfigTable.GetData_CharacterSkin(nSkinId)
  local vPos, vScale = self:GetOffsetData(skinCfgData.Offset)
  self._mapNode.trActorOffsetL2d.localPosition = vPos
  self._mapNode.trActorOffsetL2d.localScale = vScale
end

function CharBgCtrl:PlayCharL2DAnim(animName, bLoop, bForcePlay)
  if self.tbRenderer ~= nil and self.tbRenderer.trL2DIns ~= nil then
    Actor2DManager.PlayL2DAnim(self.tbRenderer.tbRenderer.trL2DIns.transform, animName, bLoop, bForcePlay)
  end
end

function CharBgCtrl:PlayCharBgLeftAnim(bIn)
  if bIn then
    self._mapNode.animBgLeft:Play("CharBgPanelBg_in")
  else
    self._mapNode.animBgLeft:Play("CharBgPanelBg_out")
  end
end

function CharBgCtrl:RecycleCharacter()
  self.mapCharacter[self.tbRenderer.nSkinId] = self.tbRenderer
  Actor2DManager.UnSetActor2DWithRender(self.tbRenderer.tbRenderer)
end

function CharBgCtrl:ClearCharacter()
  for k, v in pairs(self.mapCharacter) do
    Actor2DManager.UnSetActor2DWithRender(v.tbRenderer)
  end
  self.mapCharacter = {}
  self.tbRenderer = nil
  self._mapNode.trPanelOffsetL2D.localPosition = Vector3.zero
  self._mapNode.trPanelOffsetL2D.localScale = Vector3.one
  self._mapNode.trActorOffsetL2d.localPosition = Vector3.zero
  self._mapNode.trActorOffsetL2d.localScale = Vector3.one
end

function CharBgCtrl:RefreshBgShow()
  local nPanelId = self._panel.nPanelId
  local panelCfg = self.tbPanelCfg[nPanelId]
  if nil == panelCfg then
    return
  end
  self.nType = panelCfg.type
  if self.nType == AllEnum.CharBgPanelShowType.L2D then
    self:SetCharacter(self._panel.nCharId)
  end
end

function CharBgCtrl:InitBgPos()
  local panelAnimCfg = self.tbPanelCfg[self._panel.nPanelId]
  if nil ~= panelAnimCfg then
    self._mapNode.rtBgRoot:DOLocalMoveX(panelAnimCfg.bgPosX, 0)
    self._mapNode.trPanelOffsetL2D:DOLocalMoveX(panelAnimCfg.L2DPosX, 0)
  end
  if self._panel.nPanelId == PanelId.CharEquipment then
    self._mapNode.animBgMiddle:Play("CharBgPanelBgMiddle_out")
  end
end

function CharBgCtrl:Awake()
  self.charInfoCtrl = nil
  self.charSkillCtrl = nil
  self.mapOffsetObj = {}
  self.tbRenderer = nil
  self.mapCharacter = {}
  self.nDragStartPosX = nil
  self.nDragThreshold = ConfigTable.GetConfigNumber("CharDragThreshold")
  self.bgTweener = nil
  self.l2dTweener = nil
end

function CharBgCtrl:OnEnable()
  self:CreateRT()
  self.tbPanelCfg = self._panel:GetPanelShowCfg()
  if nil == self.uiRoot then
    self.uiRoot = PanelManager.GetUIRoot(self._panel._sSortingLayerName)
  end
  if nil ~= self.uiRoot then
    self._mapNode.rtOffScreenRoot:SetParent(self.uiRoot)
    self._mapNode.rtOffScreenRoot.localScale = Vector3.one
    self._mapNode.rtOffScreenRoot:SetParent(self.gameObject.transform)
  end
  self.nCharId = self._panel.nCharId
  self.characterIdList = self._panel.tbCharList
  self.curCharacterIndex = 1
  for index, characterId in ipairs(self.characterIdList) do
    if self.nCharId == characterId then
      self.curCharacterIndex = index
      break
    end
  end
  self:RefreshBgShow()
  self:InitBgPos()
  self.tbSelectedCharList = {}
end

function CharBgCtrl:OnDisable()
  self.mapOffsetObj = {}
  self.charInfoCtrl = nil
  self.charSkillCtrl = nil
  self:ClearCharacter()
  self:ReleaseRT()
end

function CharBgCtrl:OnDestroy()
end

function CharBgCtrl:OnDrag_Character(mDrag)
  if #self.characterIdList <= 1 then
    return
  end
  if mDrag.DragEventType == AllEnum.UIDragType.DragStart then
    self.nDragStartPosX = mDrag.EventData.position.x
  elseif mDrag.DragEventType == AllEnum.UIDragType.DragEnd then
    local dragEndPosX = mDrag.EventData.position.x
    if self.nDragStartPosX ~= nil then
      if dragEndPosX - self.nDragStartPosX > self.nDragThreshold then
        self:OnEvent_SwitchCurChar(true)
      elseif dragEndPosX - self.nDragStartPosX < -self.nDragThreshold then
        self:OnEvent_SwitchCurChar(false)
      end
    end
  end
end

function CharBgCtrl:OnEvent_SwitchCurChar(bLeft)
  if #self.characterIdList <= 1 then
    return
  end
  if bLeft then
    local bUnlock = false
    while not bUnlock do
      self.curCharacterIndex = self.curCharacterIndex - 1
      if 1 > self.curCharacterIndex then
        self.curCharacterIndex = #self.characterIdList
      end
      bUnlock = PlayerData.Char:CheckCharUnlock(self.characterIdList[self.curCharacterIndex])
    end
    local nCharId = self.characterIdList[self.curCharacterIndex]
    EventManager.Hit(EventId.CharBgRefresh, self._panel.nPanelId, nCharId)
  else
    local bUnlock = false
    while not bUnlock do
      self.curCharacterIndex = self.curCharacterIndex + 1
      if self.curCharacterIndex > #self.characterIdList then
        self.curCharacterIndex = 1
      end
      bUnlock = PlayerData.Char:CheckCharUnlock(self.characterIdList[self.curCharacterIndex])
    end
    local nCharId = self.characterIdList[self.curCharacterIndex]
    EventManager.Hit(EventId.CharBgRefresh, self._panel.nPanelId, nCharId)
  end
end

function CharBgCtrl:OnEvent_RefreshPanel(nPanelId, nCharId)
  self._panel.nPanelId = nPanelId
  self._panel.nCharId = nCharId
  EventManager.Hit("RefreshCharTopBar")
  self:RefreshBgShow()
  EventManager.Hit("RefreshCharFg")
end

function CharBgCtrl:OnEvent_PanelSwitch(nClosePanelId, nOpenPanelId)
  self:RefreshBgShow()
  EventManager.Hit("RefreshCharTopBar")
  self._mapNode.UIDrag.gameObject:SetActive(true)
  local panelAnimCfg = self.tbPanelCfg[nOpenPanelId]
  if nil ~= panelAnimCfg then
    local nBgTime, nL2dTime = self._panel:GetPanelAnimTime(nClosePanelId, nOpenPanelId)
    if nil == nBgTime or nil == nL2dTime then
      return
    end
    local tbCfg = self._panel:GetPanelAnimCfg(nClosePanelId, nOpenPanelId)
    if nil ~= tbCfg then
      if self.bgTweener ~= nil then
        self.bgTweener:Kill()
      end
      if self.l2dTweener ~= nil then
        self.l2dTweener:Kill()
      end
      self.bgTweener = self._mapNode.rtBgRoot:DOLocalMoveX(panelAnimCfg.bgPosX, nBgTime):SetUpdate(true)
      self.l2dTweener = self._mapNode.trPanelOffsetL2D:DOLocalMoveX(panelAnimCfg.L2DPosX, nL2dTime):SetUpdate(true)
      self.lasttrPanelOffsetL2DPos = panelAnimCfg.L2DPosX
      if nil ~= tbCfg.bgEaseType then
        self.bgTweener:SetEase(tbCfg.bgEaseType)
        self.l2dTweener:SetEase(tbCfg.bgEaseType)
      end
    end
  end
end

function CharBgCtrl:OnEvent_HideCharBgActor()
  self.curPanelOffsetL2D = self._mapNode.trPanelOffsetL2D.localPosition.x
  self._mapNode.trPanelOffsetL2D:DOLocalMoveX(-100, 0):SetUpdate(true)
end

function CharBgCtrl:OnEvent_RevertCharBgActor()
  self._mapNode.trPanelOffsetL2D:DOLocalMoveX(self.curPanelOffsetL2D, 0):SetUpdate(true)
end

function CharBgCtrl:OnEvent_ChangeDrag(bAble)
  self._mapNode.UIDrag.gameObject:SetActive(bAble)
end

return CharBgCtrl
