local MallSkinPreviewCtrl = class("MallSkinPreviewCtrl", BaseCtrl)
local PlayerCharData = PlayerData.Char
local PlayerCharSkinData = PlayerData.CharSkin
local Actor2DManager = require("Game.Actor2D.Actor2DManager")
local SkinData = require("GameCore.Data.DataClass.SkinData")
local Animator = CS.UnityEngine.Animator
local typeof = _ENV.typeof
local ClientManager = CS.ClientManager.Instance
MallSkinPreviewCtrl._mapNodeConfig = {
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
  imgRoleBg = {},
  txtRoleName = {sComponentName = "TMP_Text"},
  btnReplace = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Replace"
  },
  txtBtnReplace = {
    sComponentName = "TMP_Text",
    sLanguageId = "Skin_Replace"
  },
  btnBuy = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Buy"
  },
  txtSaleTip = {sComponentName = "TMP_Text"},
  goCurrency = {},
  imgCurrency = {sComponentName = "Image"},
  txtPrice = {sComponentName = "TMP_Text"},
  txtSalePrice = {sComponentName = "TMP_Text"},
  imgEquipped = {},
  txtSkinEquipped = {
    sComponentName = "TMP_Text",
    sLanguageId = "Skin_Equipped"
  },
  txtSkinHas = {sComponentName = "TMP_Text", sLanguageId = "Skin_Has"},
  txtTips = {
    sComponentName = "TMP_Text",
    sLanguageId = "Skin_UnUsed_Tip"
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
  topBarAnim = {sNodeName = "goBack", sComponentName = "Animator"},
  imgTrialHead = {sNodeName = "imgBg", sComponentName = "Image"},
  btnTrialPlay = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Trial"
  },
  txtTrialPlay = {
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_SkinPlay"
  },
  redH = {
    sNodeName = "redDotEntrance2"
  }
}
MallSkinPreviewCtrl._mapEventConfig = {
  [EventId.UIBackConfirm] = "OnBtnClick_Back",
  [EventId.UIHomeConfirm] = "OnBtnClick_Home",
  MallOrderClear = "OnEvent_BuyMallPackageSuccess"
}
local show_mode_2d = 1
local show_mode_3d = 2

function MallSkinPreviewCtrl:SortSkinList()
  table.sort(self.tbSkinList, function(a, b)
    return a.nId < b.nId
  end)
end

function MallSkinPreviewCtrl:GetTimeStr(nRemainTime)
  local str = ""
  if nRemainTime <= 3600 then
    str = ConfigTable.GetUIText("Mall_Package_WithinHour")
  elseif 3600 < nRemainTime and nRemainTime <= 86400 then
    str = orderedFormat(ConfigTable.GetUIText("Mall_Package_Hour") or "", math.floor(nRemainTime / 3600))
  elseif 86400 < nRemainTime then
    str = orderedFormat(ConfigTable.GetUIText("Mall_Package_Day") or "", math.floor(nRemainTime / 86400))
  end
  return str
end

function MallSkinPreviewCtrl:RefreshSelectSkinInfo()
  local skinData = self.tbSkinList[self.nSelectIndex]
  if nil == skinData then
    return
  end
  self._mapNode.txtSaleTip.gameObject:SetActive(false)
  self.nSkinId = skinData.nId
  if self.sMallPackageId ~= nil then
    self:UnRegisterRedNode(self.sMallPackageId)
  end
  self.sMallPackageId = skinData.mapCfg and skinData.mapCfg.Id or nil
  self.nCharId = 0
  local bUsed = false
  local bCharUnlock = false
  local bUnlock = PlayerData.CharSkin:CheckSkinUnlock(self.nSkinId)
  local mapSkinCfg = ConfigTable.GetData_CharacterSkin(self.nSkinId)
  if mapSkinCfg ~= nil then
    self.nCharId = mapSkinCfg.CharId
    local usingSkinId = PlayerCharData:GetCharUsedSkinId(self.nCharId)
    bUsed = usingSkinId == self.nSkinId
    bCharUnlock = PlayerData.Char:CheckCharUnlock(self.nCharId)
    self._mapNode.goSkinDesc:SetActive(mapSkinCfg.Desc ~= "")
    NovaAPI.SetTMPText(self._mapNode.txtSkinDesc, mapSkinCfg.Desc)
    NovaAPI.SetTMPText(self._mapNode.txtSkinName, mapSkinCfg.Name)
    local mapCharCfg = ConfigTable.GetData_Character(self.nCharId)
    self._mapNode.imgRoleBg.gameObject:SetActive(false)
    if mapCharCfg ~= nil then
      self._mapNode.imgRoleBg.gameObject:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtRoleName, mapCharCfg.Name)
    end
    self.nTrialGroup = mapSkinCfg.TrialGroup
  end
  self._mapNode.btnBuy.gameObject:SetActive(not bUnlock)
  self._mapNode.btnReplace.gameObject:SetActive(bUnlock and not bUsed and bCharUnlock)
  self._mapNode.imgEquipped.gameObject:SetActive(bUnlock and (bUsed or not bCharUnlock))
  self._mapNode.txtSkinEquipped.gameObject:SetActive(bUsed)
  self._mapNode.txtSkinHas.gameObject:SetActive(bUnlock and not bCharUnlock)
  if not bUnlock then
    local mapCfg = skinData.mapCfg
    self._mapNode.txtSalePrice.gameObject:SetActive(0 < mapCfg.BasePrice)
    if mapCfg.CurrencyType == GameEnum.currencyType.Cash then
      self._mapNode.goCurrency:SetActive(false)
      NovaAPI.SetTMPText(self._mapNode.txtPrice, tostring(mapCfg.CurrencyShowPrice))
      NovaAPI.SetTMPText(self._mapNode.txtSalePrice, tostring(mapCfg.CurrencyShowBasePrice))
    elseif mapCfg.CurrencyType == GameEnum.currencyType.Item then
      self._mapNode.goCurrency:SetActive(true)
      NovaAPI.SetTMPText(self._mapNode.txtPrice, mapCfg.CurrencyItemQty)
      NovaAPI.SetTMPText(self._mapNode.txtSalePrice, mapCfg.BasePrice)
      self:SetPngSprite(self._mapNode.imgCurrency, ConfigTable.GetData_Item(mapCfg.CurrencyItemId).Icon2)
    elseif mapCfg.CurrencyType == GameEnum.currencyType.Free then
      self._mapNode.goCurrency:SetActive(false)
      self._mapNode.txtSalePrice:SetActive(false)
      NovaAPI.SetTMPText(self._mapNode.txtPrice, ConfigTable.GetUIText("Mall_Package_Free"))
    end
    local bSale = mapCfg.IsSaleSkin
    if bSale then
      local nDeListTime = PlayerData.Shop:ChangeToTimeStamp(mapCfg.DeListTime)
      local nCurTime = ClientManager.serverTimeStamp
      local nTime = nDeListTime - nCurTime
      if 0 < nTime then
        self._mapNode.txtSaleTip.gameObject:SetActive(true)
        local sTimeStr = self:GetTimeStr(nTime)
        NovaAPI.SetTMPText(self._mapNode.txtSaleTip, orderedFormat(ConfigTable.GetUIText("Mall_Skin_Sale_End"), sTimeStr))
      end
    end
  end
  self._mapNode.goTheme.gameObject:SetActive(mapSkinCfg.SkinTheme ~= 0)
  if mapSkinCfg.SkinTheme ~= 0 then
    local themeCfg = ConfigTable.GetData("CharacterSkinTheme", mapSkinCfg.SkinTheme)
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
  self:RefreshTrialState()
end

function MallSkinPreviewCtrl:RefreshActor2D()
  Actor2DManager.SetActor2D(self:GetPanelId(), self._mapNode.rawImgActor2D, self.nCharId, self.nSkinId)
end

function MallSkinPreviewCtrl:RefreshPreviewMode(bPreview)
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

function MallSkinPreviewCtrl:RefreshFullScene(bFullScene)
  self._mapNode.goPreview.gameObject:SetActive(not bFullScene)
  self._mapNode.TopBar.gameObject:SetActive(not bFullScene)
  if not bFullScene and self.timerFullScene == nil then
    self.timerFullScene = self:AddTimer(1, 5, function()
      self._mapNode.TopBar.gameObject:SetActive(false)
      self.timerFullScene = nil
    end, true, true, true)
  end
end

function MallSkinPreviewCtrl:OnGridRefresh(goGrid, gridIndex)
  local nIndex = gridIndex + 1
  local nInstanceId = goGrid:GetInstanceID()
  if not self.tbGridCtrl[nInstanceId] then
    self.tbGridCtrl[nInstanceId] = self:BindCtrlByNode(goGrid, "Game.UI.TemplateEx.TemplateSkinCtrl")
  end
  local skinData = self.tbSkinList[nIndex].skinData
  self.tbGridCtrl[nInstanceId]:SetSkinData(skinData, false, true)
  if nIndex == self.nSelectIndex then
    self.tbGridCtrl[nInstanceId]:SetSelect(true)
  end
end

function MallSkinPreviewCtrl:OnGridBtnClick(goGrid, gridIndex)
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

function MallSkinPreviewCtrl:LoadCharacter()
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
      local go = instantiate(obj, self.rtSceneOriginPos)
      self.tbModelList[self.nSkinId] = go
      self.curShowModel = go
      self:WaitReadyClipFinish()
      NovaAPI.BindUIParallaxStageCameraControllerModel(self._mapNode.UIParallax3DStage, 0, go, true)
      GameUIUtils.SetCustomModelMaterialVariant(go, CS.CustomModelMaterialVariantComponent.VariantNames.FormationView)
      if self.rtSceneOriginPos ~= nil then
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
      end
      EventManager.Hit(EventId.BlockInput, false)
    end
    
    self:LoadAssetAsync(sFullPath, typeof(GameObject), LoadModelCallback)
    EventManager.Hit(EventId.BlockInput, true)
  end
end

function MallSkinPreviewCtrl:WaitReadyClipFinish()
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

function MallSkinPreviewCtrl:DestroyCharacter()
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

function MallSkinPreviewCtrl:Awake()
  self.canvas = self.gameObject:GetComponent("Canvas")
  self.gameObject:SetActive(false)
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

function MallSkinPreviewCtrl:OnEnable()
  self.bPreview = false
  self.bStartDrag = false
  self.bDragValid = true
  local tbParam = self:GetPanelParam()
  local tbMallList = tbParam[1]
  self.nSkinId = tbParam[2]
  if self.nSelectIndex == nil then
    self.nSelectIndex = tbParam[3]
  end
  self.tbSkinList = {}
  for _, v in ipairs(tbMallList) do
    local mapCfg = ConfigTable.GetData("MallPackage", v.sId)
    local tbParam = decodeJson(mapCfg.Items)
    local nSkinId = 0
    for nId, v in pairs(tbParam) do
      nSkinId = tonumber(nId)
      break
    end
    local nUnlock = PlayerData.CharSkin:CheckSkinUnlock(nSkinId) and 1 or 0
    local skinData = SkinData.new(nSkinId, 0, nUnlock)
    table.insert(self.tbSkinList, {
      nId = nSkinId,
      mapCfg = mapCfg,
      skinData = skinData
    })
  end
  self._mapNode.eventSkinZoom:SetZoomLock(true)
  self._mapNode.eventSkinZoom:SetZoomLimitValue(tonumber(self.tbZoomRange[1]), tonumber(self.tbZoomRange[2]))
  for insId, objCtrl in pairs(self.tbGridCtrl) do
    self:UnbindCtrlByNode(objCtrl)
    self.tbGridCtrl[insId] = nil
  end
  if self.nSelectIndex == nil then
    for k, v in ipairs(self.tbSkinList) do
      if v.nId == self.nSkinId then
        self.nSelectIndex = k
        break
      end
    end
  end
  if self.nSelectIndex == nil then
    self.nSelectIndex = 1
  end
  self._mapNode.sv:Init(#self.tbSkinList, self, self.OnGridRefresh, self.OnGridBtnClick)
  
  local function wait()
    coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
    self._mapNode.sv:SetScrollGridPos(self.nSelectIndex - 1, 0, 0)
  end
  
  cs_coroutine.start(wait)
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
    self:RefreshSelectSkinInfo()
    EventManager.Hit(EventId.SetTransition)
  end
  
  CS.MainMenuModuleHelper.GetActiveScene(sSceneName, callback)
end

function MallSkinPreviewCtrl:OnDisable()
  self.tbSkinList = nil
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
  self:UnRegisterRedNode(self.sMallPackageId)
  self.nShowModelSkinId = 0
end

function MallSkinPreviewCtrl:OnDestroy()
end

function MallSkinPreviewCtrl:OnBtnClick_FullScene()
  self:RefreshPreviewMode(true)
  self:RefreshFullScene(true)
end

function MallSkinPreviewCtrl:OnBtnClick_SwitchModel()
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

function MallSkinPreviewCtrl:OnBtnClick_SkinPreview()
  self:RefreshPreviewMode(true)
end

function MallSkinPreviewCtrl:OnBtnClick_Skin()
  if not self.bStartDrag then
    self:RefreshFullScene(false)
  end
end

function MallSkinPreviewCtrl:OnBtnClick_Buy()
  local mapData = self.tbSkinList[self.nSelectIndex]
  local mapCfg = mapData.mapCfg
  if not mapCfg then
    return
  end
  local bUnlock = PlayerData.CharSkin:CheckSkinUnlock(self.nSkinId)
  if bUnlock then
    return
  end
  local nCurrencyType = mapCfg.CurrencyType
  if nCurrencyType == GameEnum.currencyType.Cash then
    PlayerData.Mall:BuyPackage(mapCfg.Id, mapCfg.StatisticalGroup)
  else
    if nCurrencyType == GameEnum.currencyType.Item then
      local nHas = 0
      if mapCfg.CurrencyItemId == AllEnum.CoinItemId.FREESTONE or mapCfg.CurrencyItemId == AllEnum.CoinItemId.STONE then
        nHas = PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.FREESTONE) + PlayerData.Coin:GetCoinCount(AllEnum.CoinItemId.STONE)
      else
        nHas = PlayerData.Coin:GetCoinCount(mapCfg.CurrencyItemId)
      end
      if nHas < mapCfg.CurrencyItemQty then
        local msg = {
          nType = AllEnum.MessageBox.Confirm,
          sContent = orderedFormat(ConfigTable.GetUIText("Recruit_Charge") or "", ConfigTable.GetData_Item(AllEnum.CoinItemId.STONE).Id),
          callbackConfirm = function()
            EventManager.Hit(EventId.CloesCurPanel)
            EventManager.Hit("OpenMallTog", AllEnum.MallToggle.Gem)
          end,
          bBlur = false
        }
        EventManager.Hit(EventId.OpenMessageBox, msg)
        return
      end
    end
    PlayerData.Mall:SendMallPackageOrderReq(mapCfg.Id)
  end
end

function MallSkinPreviewCtrl:OnBtnClick_Replace()
  local function func_callback()
    PlayerData.Char:SetCharSkinId(self.nCharId, self.nSkinId)
    
    self:RefreshSelectSkinInfo()
  end
  
  local msgSend = {}
  msgSend.CharId = self.nCharId
  msgSend.SkinId = self.nSkinId
  HttpNetHandler.SendMsg(NetMsgId.Id.char_skin_set_req, msgSend, nil, func_callback)
end

function MallSkinPreviewCtrl:OnBtnClick_Back(nPanelId)
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

function MallSkinPreviewCtrl:OnBtnClick_Home(nPanelId)
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  PanelManager.Home()
end

function MallSkinPreviewCtrl:OnEvent_BuyMallPackageSuccess(bMoney)
  if not bMoney then
    PlayerData.CharSkin:TryOpenSkinShowPanel()
  end
  self:RefreshSelectSkinInfo()
end

function MallSkinPreviewCtrl:OnBtnClick_SwitchHalf()
  self.bUseFull = not self.bUseFull
  Actor2DManager.SwitchFullHalf()
end

function MallSkinPreviewCtrl:OnUIDrag_Drag(mDrag)
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

function MallSkinPreviewCtrl:OnUIZoom_Skin(mZoom)
  if mZoom.InZoom then
    if mZoom.ZoomValue ~= 0 then
      self.bDragValid = false
      Actor2DManager.SyncLocalScale(mZoom.ZoomValue)
    end
  else
    self.bDragValid = true
  end
end

function MallSkinPreviewCtrl:RefreshTrialState()
  if self.nTrialGroup == nil or self.nTrialGroup == 0 then
    self._mapNode.btnTrialPlay.gameObject:SetActive(false)
    return
  else
    self._mapNode.btnTrialPlay.gameObject:SetActive(true)
  end
  local mapSkinData = ConfigTable.GetData_CharacterSkin(self.nSkinId)
  if mapSkinData ~= nil then
    self:SetPngSprite(self._mapNode.imgTrialHead, mapSkinData.Icon, AllEnum.CharHeadIconSurfix.L)
  end
  if PlayerCharSkinData:CheckSkinUnlock(self.nSkinId) then
    self._mapNode.redH:SetActive(false)
    return
  end
  self:RegisterRedNode(self.sMallPackageId)
  PlayerCharData:UpdateCharSkinTrialRedDot(self.sMallPackageId)
end

function MallSkinPreviewCtrl:OnBtnClick_Trial()
  PlayerCharData:SetCharSkinTrialRedDot(self.sMallPackageId)
  PlayerData.Trial:SetSelectTrialGroup(self.nTrialGroup)
  EventManager.Hit(EventId.OpenPanel, PanelId.TrialSkinSelectPanel)
end

function MallSkinPreviewCtrl:RegisterRedNode(sId)
  RedDotManager.RegisterNode(RedDotDefine.Mall_CharSkinTrial, {sId}, self._mapNode.redH)
end

function MallSkinPreviewCtrl:UnRegisterRedNode(sId)
  RedDotManager.SetValid(RedDotDefine.Mall_CharSkinTrial, {sId}, false)
  RedDotManager.UnRegisterNode(RedDotDefine.Mall_CharSkinTrial, {sId}, self._mapNode.redH)
end

return MallSkinPreviewCtrl
