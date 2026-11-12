local CharacterSkinCtrl = class("CharacterSkinCtrl", BaseCtrl)
local PlayerCharData = PlayerData.Char
local PlayerCharSkinData = PlayerData.CharSkin
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local tableInsert = table.insert
local Animator = CS.UnityEngine.Animator
local typeof = _ENV.typeof
CharacterSkinCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  rawImgActor2D = {
    sNodeName = "----Actor2D----",
    sComponentName = "RawImage"
  },
  rtRawImgActor2D = {
    sNodeName = "----Actor2D----",
    sComponentName = "RectTransform"
  },
  eventSkinDrag = {
    sNodeName = "btnSkin",
    sComponentName = "UIDrag",
    callback = "OnUIDrag_Drag"
  },
  eventSkinZoom = {
    sNodeName = "btnSkin",
    sComponentName = "UIZoom",
    callback = "OnUIZoom_Skin"
  },
  btnSkin = {
    sComponentName = "Button",
    callback = "OnBtnClick_Skin"
  },
  goSkinDesc = {},
  txtSkinDesc = {sComponentName = "TMP_Text"},
  goTheme = {},
  imgTheme = {sComponentName = "Image"},
  txtTheme = {sComponentName = "TMP_Text"},
  goPreview = {},
  btnFullScene = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_FullScene"
  },
  btnSwitchModel = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SwitchModel"
  },
  goPortrait = {},
  go3D = {},
  sv = {
    sComponentName = "LoopScrollView"
  },
  trSv = {sNodeName = "sv", sComponentName = "Transform"},
  txtSkinName = {sComponentName = "TMP_Text"},
  btnGotoBuy = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_GotoBuy"
  },
  txtBtnGotoBuy = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterSkin_GotoBuy"
  },
  btnUseSkin = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_UseSkin"
  },
  imgEquipped = {},
  txtSkinEquipped = {
    sComponentName = "TMP_Text",
    sLanguageId = "Skin_Equipped"
  },
  txtBtnUseSkin = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterSkin_Use_Skin"
  },
  btnSwitchHalf = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_SwitchHalf"
  },
  txtPortrait = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterSkin_Portrait"
  },
  txt3D = {
    sComponentName = "TMP_Text",
    sLanguageId = "CharacterSkin_3D"
  },
  goLeft = {sNodeName = "---Left---"},
  goRight = {
    sNodeName = "---Right---"
  },
  canvasGroupRight = {
    sNodeName = "---Right---",
    sComponentName = "CanvasGroup"
  },
  UIParallax3DStage = {
    sComponentName = "UIParallaxStageCameraController"
  },
  aniSafeAreaRoot = {
    sNodeName = "----SafeAreaRoot----",
    sComponentName = "Animator"
  },
  aniArrow = {sNodeName = "goArrow", sComponentName = "Animator"},
  topBarAnim = {sNodeName = "goBack", sComponentName = "Animator"}
}
CharacterSkinCtrl._mapEventConfig = {
  [EventId.UIBackConfirm] = "OnBtnClick_Back",
  [EventId.UIHomeConfirm] = "OnBtnClick_Home"
}
local show_mode_2d = 1
local show_mode_3d = 2

function CharacterSkinCtrl:SortSkinList()
  self.tbSortSkinList = {}
  for _, v in pairs(self.tbSkinList) do
    if true == v:CheckSkinShow() or true == v:CheckUnlock() then
      tableInsert(self.tbSortSkinList, v)
    end
  end
  table.sort(self.tbSortSkinList, function(a, b)
    return a:GetId() < b:GetId()
  end)
end

function CharacterSkinCtrl:RefreshSelectSkinInfo()
  local skinData = self.tbSortSkinList[self.nSelectIndex]
  if nil == skinData then
    return
  end
  local usingSkinId = PlayerCharData:GetCharUsedSkinId(self.nCharId)
  local skinCfg = skinData:GetCfgData()
  self.nSkinId = skinData:GetId()
  self._mapNode.goSkinDesc:SetActive(skinCfg.Desc ~= "")
  NovaAPI.SetTMPText(self._mapNode.txtSkinDesc, skinCfg.Desc)
  NovaAPI.SetTMPText(self._mapNode.txtSkinName, skinCfg.Name)
  self._mapNode.btnUseSkin.gameObject:SetActive(self.nSkinId ~= usingSkinId and skinData:CheckUnlock())
  local bEquipped = self.nSkinId == usingSkinId and skinData:CheckUnlock()
  local bNotHave = not skinData:CheckUnlock() and self.nSkinId ~= usingSkinId and skinCfg.SourceDesc ~= nil
  self._mapNode.imgEquipped.gameObject:SetActive(bEquipped or bNotHave)
  if bNotHave then
    local sText = AllEnum.CharSkinSource[skinCfg.SourceDesc]
    if sText ~= nil then
      NovaAPI.SetTMPText(self._mapNode.txtSkinEquipped, ConfigTable.GetUIText(sText))
    else
      self._mapNode.imgEquipped.gameObject:SetActive(false)
    end
  else
    NovaAPI.SetTMPText(self._mapNode.txtSkinEquipped, ConfigTable.GetUIText("Skin_Equipped"))
  end
  self._mapNode.goTheme.gameObject:SetActive(skinCfg.SkinTheme ~= 0)
  if skinCfg.SkinTheme ~= 0 then
    local themeCfg = ConfigTable.GetData("CharacterSkinTheme", skinCfg.SkinTheme)
    if nil ~= themeCfg then
      self:SetPngSprite(self._mapNode.imgTheme, themeCfg.Icon)
      NovaAPI.SetTMPText(self._mapNode.txtTheme, themeCfg.Name)
    end
  end
  if self.nShowMode == show_mode_2d then
    self:RefreshActor2D()
  elseif self.nShowMode == show_mode_3d then
    self:LoadCharacter()
  end
end

function CharacterSkinCtrl:RefreshActor2D()
  Actor2DManager.SetActor2D(self:GetPanelId(), self._mapNode.rawImgActor2D, self.nCharId, self.nSkinId)
end

function CharacterSkinCtrl:RefreshPreviewMode(bPreview)
  self.bPreview = bPreview
  self._mapNode.goPreview.gameObject:SetActive(true)
  self._mapNode.btnSkin.gameObject:SetActive(bPreview)
  self._mapNode.eventSkinZoom:SetZoomLock(not bPreview)
  if not bPreview then
    self:RefreshSelectSkinInfo()
    if self.nShowMode == show_mode_3d then
      self._mapNode.aniArrow:Play("CharacterSkin_3D_Out")
      self.curShowModel.transform.localEulerAngles = Vector3(0, 180, 0)
    end
    self._mapNode.aniSafeAreaRoot:Play("CharacterSkin_preview_in")
    NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroupRight, true)
    Actor2DManager.ResetActor2DDragOffset(self.v3Offset)
  else
    if self.bUseFull then
      self:OnBtnClick_SwitchHalf()
      self:AddTimer(1, 0.7, function()
        NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroupRight, false)
        self.v3Offset = Actor2DManager.SwitchActor2DDragOffset()
      end, true, true, true)
      EventManager.Hit(EventId.TemporaryBlockInput, 0.7)
    else
      NovaAPI.SetCanvasGroupBlocksRaycasts(self._mapNode.canvasGroupRight, false)
      self.v3Offset = Actor2DManager.SwitchActor2DDragOffset()
      if self.nShowMode == show_mode_3d and self.bDragValid then
        self._mapNode.aniArrow:Play("CharacterSkin_3D_In")
      end
    end
    self._mapNode.aniSafeAreaRoot:Play("CharacterSkin_preview_out")
  end
end

function CharacterSkinCtrl:RefreshFullScene(bFullScene)
  self._mapNode.goPreview.gameObject:SetActive(not bFullScene)
  self._mapNode.TopBar.gameObject:SetActive(not bFullScene)
  if bFullScene and self.timerFullScene ~= nil then
    self.timerFullScene:Cancel()
    self.timerFullScene = nil
  end
  if not bFullScene and self.timerFullScene == nil then
    self.timerFullScene = self:AddTimer(1, 5, function()
      self._mapNode.TopBar.gameObject:SetActive(false)
      self.timerFullScene = nil
    end, true, true, true)
  end
end

function CharacterSkinCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.TemplateEx.TemplateSkinCtrl")
  end
  self.tbGridCtrl[nInstanceId]:SetSkinData(self.tbSortSkinList[nIndex])
  if self.nSelectIndex == nIndex then
    self.tbGridCtrl[nInstanceId]:SetSelect(true)
  else
    self.tbGridCtrl[nInstanceId]:SetSelect(false)
  end
end

function CharacterSkinCtrl:OnGridBtnClick(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  local goSelect = self._mapNode.trSv:Find("Viewport/Content/" .. self.nSelectIndex - 1)
  if goSelect then
    self.tbGridCtrl[goSelect.gameObject:GetInstanceID()]:SetSelect(false)
  end
  self.tbGridCtrl[nInstanceId]:SetSelect(true)
  self._mapNode.sv:SetScrollGridPos(nIndex - 1, 0.1, 0)
  self.nSelectIndex = nIndex
  self:RefreshSelectSkinInfo()
end

function CharacterSkinCtrl:LoadCharacter()
  if self.nShowModelSkinId == self.nSkinId then
    return
  end
  self.nShowModelSkinId = self.nSkinId
  local bNeedLoad = true
  for skinId, v in pairs(self.tbModelList) do
    if skinId == self.nSkinId then
      bNeedLoad = false
      v.gameObject:SetActive(true)
      v.transform.localEulerAngles = Vector3(0, 180, 0)
      self.nModelDragRot = v.transform.localEulerAngles.y
      self.curShowModel = v
      self:WaitReadyClipFinish()
      NovaAPI.BindUIParallaxStageCameraControllerModel(self._mapNode.UIParallax3DStage, 0, v.gameObject, true)
      GameUIUtils.SetCustomModelMaterialVariant(v.gameObject, CS.CustomModelMaterialVariantComponent.VariantNames.FormationView)
    else
      v.gameObject:SetActive(false)
    end
  end
  if bNeedLoad then
    local mapSkin = ConfigTable.GetData_CharacterSkin(self.nSkinId)
    local sFullPath = string.format("%s.prefab", mapSkin.Model_Show)
    
    local function LoadModelCallback(obj)
      if self.rtSceneOriginPos == nil then
        return
      end
      local go = instantiate(obj, self.rtSceneOriginPos)
      self.tbModelList[self.nSkinId] = go
      self.curShowModel = go
      self:WaitReadyClipFinish()
      NovaAPI.BindUIParallaxStageCameraControllerModel(self._mapNode.UIParallax3DStage, 0, go, true)
      GameUIUtils.SetCustomModelMaterialVariant(go, CS.CustomModelMaterialVariantComponent.VariantNames.FormationView)
      NovaAPI.ChangeAnimatorDefaultState(go.transform)
      go.transform.position = self.rtSceneOriginPos.position
      go.transform.localEulerAngles = Vector3(0, 180, 0)
      self.nModelDragRot = go.transform.localEulerAngles.y
      go.transform.localScale = Vector3.zero
      local animator = go:GetComponent(typeof(Animator))
      if animator ~= nil and animator:IsNull() == false then
        animator:SetBool("standby", true)
      end
      
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        go.transform.localScale = Vector3.one * (mapSkin.ModelShowScale / 10000)
      end
      
      cs_coroutine.start(wait)
      EventManager.Hit(EventId.BlockInput, false)
    end
    
    self:LoadAssetAsync(sFullPath, typeof(GameObject), LoadModelCallback)
    EventManager.Hit(EventId.BlockInput, true)
  end
end

function CharacterSkinCtrl:WaitReadyClipFinish()
  if self.waitReadyClipCor ~= nil then
    cs_coroutine.stop(self.waitReadyClipCor)
  end
  if self.curShowModel == nil then
    return
  end
  local director = self.curShowModel:GetComponent("PlayableDirector")
  if director == nil then
    return
  end
  local readyClipName = "_Ready"
  
  local function wait()
    while CS.AdventureModuleHelper.CheckTimelineClipFinish(director, readyClipName) == false do
      coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    end
    self.bDragValid = true
    if self.bPreview and self.nShowMode == show_mode_3d then
      self._mapNode.aniArrow:Play("CharacterSkin_3D_In")
    end
  end
  
  self.bDragValid = false
  self.waitReadyClipCor = cs_coroutine.start(wait)
end

function CharacterSkinCtrl:DestroyCharacter()
  local sSceneName = ConfigTable.GetConfigValue("CharacterSkin_Scene")
  
  local function callback()
  end
  
  CS.MainMenuModuleHelper.DeActiveScene(sSceneName, callback)
  NovaAPI.UnbindUIParallaxStageCameraControllerModel(self._mapNode.UIParallax3DStage, 1)
  for _, v in pairs(self.tbModelList) do
    destroy(v)
  end
  self.tbModelList = {}
  self.curShowModel = nil
  self.nModelDragRot = 0
  if nil ~= self.goSelectRolePrefab then
    destroy(self.goSelectRolePrefab)
  end
  self.goSelectRolePrefab = nil
end

function CharacterSkinCtrl:Awake()
  self.canvas = self.gameObject:GetComponent("Canvas")
  self.gameObject:SetActive(false)
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nCharId = param[1]
  end
  self.tbGridCtrl = {}
  self.nSelectIndex = nil
  self.nShowModelSkinId = 0
  self.tbModelList = {}
  self.curShowModel = nil
  self.nModelDragRot = 0
  self.v3Offset = Vector3.zero
  self.nShowMode = show_mode_2d
  self.tbZoomRange = ConfigTable.GetConfigArray("SkinZoomRange")
  self.bUseFull = false
end

function CharacterSkinCtrl:OnEnable()
  self.bPreview = false
  self.bStartDrag = false
  self.bDragValid = true
  self.tbSkinList = PlayerCharSkinData:GetSkinListByCharacterId(self.nCharId)
  self:SortSkinList()
  self._mapNode.eventSkinZoom:SetZoomLock(true)
  self._mapNode.eventSkinZoom:SetZoomLimitValue(tonumber(self.tbZoomRange[1]), tonumber(self.tbZoomRange[2]))
  for insId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[insId] = nil
  end
  for nIndex = 1, #self.tbSortSkinList do
    local usingSkinId = PlayerCharData:GetCharUsedSkinId(self.nCharId)
    if usingSkinId == self.tbSortSkinList[nIndex]:GetId() then
      self.nSelectIndex = nIndex
      break
    end
  end
  if self.nSelectIndex == nil then
    self.nSelectIndex = 1
  end
  self._mapNode.sv:Init(#self.tbSortSkinList, self, self.OnGridRefresh, self.OnGridBtnClick)
  self._mapNode.goPreview.gameObject:SetActive(true)
  self._mapNode.btnSkin.gameObject:SetActive(false)
  self._mapNode.go3D.gameObject:SetActive(self.nShowMode == show_mode_3d)
  self._mapNode.goPortrait.gameObject:SetActive(self.nShowMode == show_mode_2d)
  local sSceneName = ConfigTable.GetConfigValue("CharacterSkin_Scene")
  NovaAPI.SetComponentEnable(self.canvas, false)
  
  local function callback(bSuccess)
    NovaAPI.SetComponentEnable(self.canvas, true)
    if bSuccess == true then
      local sceneRoot = CS.MainMenuModuleHelper.GetMainMenuSceneRoot(sSceneName)
      self.rtSceneOriginPos = sceneRoot.transform:Find("==== Scene ====")
      self.goSelectRolePrefab = self:CreatePrefabInstance("UI/CharacterSkin/CharSkin3DShowPrefab.prefab", self.rtSceneOriginPos)
      local goSelectRoleCam = self.goSelectRolePrefab.transform:Find("Camera"):GetComponent("Camera")
      NovaAPI.SetupUIParallaxStageCameraControllerForModelView(self._mapNode.UIParallax3DStage, goSelectRoleCam)
    else
      self._mapNode.UIParallax3DStage.gameObject:SetActive(false)
    end
    self.gameObject:SetActive(true)
    self._mapNode.sv:SetScrollGridPos(self.nSelectIndex - 1, 0, 0)
    self:RefreshSelectSkinInfo()
    EventManager.Hit(EventId.SetTransition)
  end
  
  CS.MainMenuModuleHelper.GetActiveScene(sSceneName, callback)
end

function CharacterSkinCtrl:OnDisable()
  self.tbSkinList = nil
  self.tbSortSkinList = nil
  for insId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[insId] = nil
  end
  self.tbGridCtrl = {}
  self.bStartDrag = nil
  self.bDragValid = nil
  if self.waitReadyClipCor ~= nil then
    cs_coroutine.stop(self.waitReadyClipCor)
  end
  Actor2DManager.UnsetActor2D()
  self:DestroyCharacter()
end

function CharacterSkinCtrl:OnDestroy()
end

function CharacterSkinCtrl:OnBtnClick_FullScene()
  self:RefreshPreviewMode(true)
  self:RefreshFullScene(true)
end

function CharacterSkinCtrl:OnBtnClick_SwitchModel()
  self.nShowMode = self.nShowMode == show_mode_2d and show_mode_3d or show_mode_2d
  self._mapNode.btnSwitchHalf.gameObject:SetActive(self.nShowMode == show_mode_2d)
  self._mapNode.go3D.gameObject:SetActive(self.nShowMode == show_mode_3d)
  self._mapNode.goPortrait.gameObject:SetActive(self.nShowMode == show_mode_2d)
  if self.nShowMode == show_mode_2d then
    local tweener = NovaAPI.DoRawImageColor(self._mapNode.rawImgActor2D, Color(1, 1, 1, 1), 0.5)
    tweener:SetUpdate(true)
    self._mapNode.rtRawImgActor2D:DOScale(1, 0.5):SetUpdate(true)
  elseif self.nShowMode == show_mode_3d then
    local tweener = NovaAPI.DoRawImageColor(self._mapNode.rawImgActor2D, Color(1, 1, 1, 0), 0.5)
    tweener:SetUpdate(true)
    self._mapNode.rtRawImgActor2D:DOScale(1.5, 0.5):SetUpdate(true)
  end
  self:RefreshSelectSkinInfo()
end

function CharacterSkinCtrl:OnBtnClick_SkinPreview()
  self:RefreshPreviewMode(true)
end

function CharacterSkinCtrl:OnBtnClick_Skin()
  if not self.bStartDrag then
    self:RefreshFullScene(false)
  end
end

function CharacterSkinCtrl:OnBtnClick_GotoBuy()
end

function CharacterSkinCtrl:OnBtnClick_UseSkin()
  local function func_callback()
    PlayerData.Char:SetCharSkinId(self.nCharId, self.nSkinId)
    
    self:RefreshSelectSkinInfo()
  end
  
  local msgSend = {}
  msgSend.CharId = self.nCharId
  msgSend.SkinId = self.nSkinId
  HttpNetHandler.SendMsg(NetMsgId.Id.char_skin_set_req, msgSend, nil, func_callback)
end

function CharacterSkinCtrl:OnBtnClick_Back(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if self.bPreview then
    self:RefreshPreviewMode(false)
    if self.timerFullScene ~= nil then
      self.timerFullScene:Cancel()
      self.timerFullScene = nil
    end
  else
    EventManager.Hit(EventId.CloesCurPanel)
  end
end

function CharacterSkinCtrl:OnBtnClick_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  PanelManager.Home()
end

function CharacterSkinCtrl:OnBtnClick_SwitchHalf()
  self.bUseFull = not self.bUseFull
  Actor2DManager.SwitchFullHalf()
end

function CharacterSkinCtrl:OnUIDrag_Drag(mDrag)
  if not self.bDragValid then
    return
  end
  if mDrag.DragEventType == AllEnum.UIDragType.DragStart then
    self.bStartDrag = true
  elseif mDrag.DragEventType == AllEnum.UIDragType.Drag then
    if true == self.bStartDrag then
      if self.nShowMode == show_mode_2d then
        Actor2DManager.SyncLocalPos(mDrag.EventData.delta.x, mDrag.EventData.delta.y, nil, self._mapNode.rtRawImgActor2D)
      elseif self.nShowMode == show_mode_3d and nil ~= self.curShowModel then
        self.nModelDragRot = self.nModelDragRot - mDrag.EventData.delta.x * 0.5
        self.curShowModel.transform.localEulerAngles = Vector3(0, self.nModelDragRot, 0)
      end
    end
  elseif mDrag.DragEventType == AllEnum.UIDragType.DragEnd then
    self.bStartDrag = false
  end
end

function CharacterSkinCtrl:OnUIZoom_Skin(mZoom)
  if mZoom.InZoom then
    if mZoom.ZoomValue ~= 0 then
      self.bDragValid = false
      Actor2DManager.SyncLocalScale(mZoom.ZoomValue)
    end
  else
    self.bDragValid = true
  end
end

return CharacterSkinCtrl
