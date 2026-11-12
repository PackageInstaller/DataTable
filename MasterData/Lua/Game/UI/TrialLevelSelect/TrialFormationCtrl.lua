local TrialFormationCtrl = class("TrialFormationCtrl", BaseCtrl)
local Animator = CS.UnityEngine.Animator
local CustomModelMaterialVariantComponent = CS.CustomModelMaterialVariantComponent
local GameCameraStackManager = CS.GameCameraStackManager
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResType = GameResourceLoader.ResType
local typeof = _ENV.typeof
TrialFormationCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  goChar = {
    nCount = 3,
    sCtrlName = "Game.UI.FormationEx.FormationCharCtrl"
  },
  Mask = {},
  btnStartBattle = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Start"
  },
  txtStartBattle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_Btn_StartBattle"
  },
  UIParallax3DStage = {
    sComponentName = "UIParallaxStageCameraController"
  },
  BGbackup = {
    sNodeName = "----BGbackup----"
  },
  btnInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Info"
  },
  charCanvasGroup = {
    sNodeName = "----Char----",
    sComponentName = "CanvasGroup"
  },
  txtBtnInfo = {
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_Btn_FormationInfo"
  },
  goLoadMask = {},
  txtCurTrial = {
    nCount = 3,
    sComponentName = "TMP_Text",
    sLanguageId = "Trial_CurTrialChar"
  },
  goCurTrial = {nCount = 3}
}
TrialFormationCtrl._mapEventConfig = {
  [EventId.FormationLoadModel] = "OnEvent_LoadModel",
  OnEvent_SelectRefresh = "Refresh",
  [EventId.UIBackConfirm] = "OnEvent_Back",
  [EventId.UIHomeConfirm] = "OnEvent_BackHome"
}

function TrialFormationCtrl:InitData()
  local mapLevelCfg = ConfigTable.GetData("TrialFloor", self.nFloorId)
  if not mapLevelCfg then
    return
  end
  self.mapBuildData = PlayerData.Build:GetTrialBuild(mapLevelCfg.TrialBuild)
  self.tbCharId, self.tbCharTrialToId, self.curTeam, self.mapCharData, self.mapTalentAddLevel, self.tbCharTrialId = {}, {}, {}, {}, {}, {}
  for _, mapChar in ipairs(self.mapBuildData.tbChar) do
    table.insert(self.tbCharId, mapChar.nTid)
    table.insert(self.curTeam, mapChar.nTrialId)
    self.tbCharTrialToId[mapChar.nTrialId] = mapChar.nTid
    self.tbCharTrialId[mapChar.nTid] = mapChar.nTrialId
    self.mapCharData[mapChar.nTid] = PlayerData.Char:GetTrialCharById(mapChar.nTrialId)
    self.mapTalentAddLevel[mapChar.nTid] = PlayerData.Talent:GetTrialEnhancedPotential(mapChar.nTrialId)
    if mapLevelCfg.TrialChar == mapChar.nTid then
      self.nCurTrialId = mapChar.nTrialId
    end
  end
  self.tbDiscId, self.mapDiscData = {}, {}
  for _, nDiscId in ipairs(self.mapBuildData.tbDisc) do
    if 0 < nDiscId then
      table.insert(self.tbDiscId, nDiscId)
      local mapCfg = ConfigTable.GetData("TrialDisc", nDiscId)
      if mapCfg then
        self.mapDiscData[mapCfg.DiscId] = PlayerData.Disc:GetTrialDiscById(nDiscId)
      end
    end
  end
  self.tbDepotPotential = {}
  for nCharId, tbPerk in pairs(self.mapBuildData.tbPotentials) do
    if self.tbCharTrialId[nCharId] then
      if not self.tbDepotPotential[nCharId] then
        self.tbDepotPotential[nCharId] = {}
      end
      for _, v in ipairs(tbPerk) do
        self.tbDepotPotential[nCharId][v.nPotentialId] = v.nLevel
      end
    else
      printError("体验build内，有多余角色的潜能" .. nCharId)
    end
  end
end

function TrialFormationCtrl:Refresh(nDirection)
  self:RefreshChar(nDirection)
end

function TrialFormationCtrl:RefreshChar(nDirection)
  for i = 1, 3 do
    if self.curTeam[i] == nil then
      self.curTeam[i] = 0
    end
    self._mapNode.goChar[i].gameObject:SetActive(self.curTeam[i] ~= 0)
    self._mapNode.goCurTrial[i]:SetActive(self.curTeam[i] == self.nCurTrialId)
    if self.curTeam[i] ~= 0 then
      self._mapNode.goChar[i]:OnRender(self.curTeam, i, true, nDirection)
      if self.mapCurModel[i] == nil or self.mapCurModel[i].nCharId ~= self.curTeam[i] then
        self:LoadCharacter(self.curTeam[i], self.bOpen or nDirection ~= nil)
      end
    elseif self.mapCurModel[i] ~= nil then
      NovaAPI.UnbindUIParallaxStageCameraControllerModel(self._mapNode.UIParallax3DStage, i - 1)
      destroy(self.mapCurModel[i].model)
      self.mapCurModel[i] = nil
    end
  end
end

function TrialFormationCtrl:LoadCharacter(nCharId, bOpen)
  local mapTrialChar = PlayerData.Char:GetTrialCharById(nCharId)
  if not mapTrialChar then
    return
  end
  local nSkinId = mapTrialChar.nSkinId
  local mapSkin = ConfigTable.GetData_CharacterSkin(nSkinId)
  if not mapSkin then
    printLog("没有找到皮肤配置" .. nCharId)
    return
  end
  local sFullPath = string.format("%s.prefab", mapSkin.Model_Show)
  
  local function LoadModelCallback(obj)
    self._panel.nLoadProcess = self._panel.nLoadProcess - 1
    if self._mapNode == nil then
      return
    end
    local idx = table.indexof(self.curTeam, nCharId)
    if 0 < idx then
      if self.mapCurModel[idx] ~= nil then
        NovaAPI.UnbindUIParallaxStageCameraControllerModel(self._mapNode.UIParallax3DStage, idx - 1)
        destroy(self.mapCurModel[idx].model)
        self.mapCurModel[idx] = nil
      end
      local go = instantiate(obj, self.rtSceneOriginPos)
      self.mapCurModel[idx] = {nCharId = nCharId, model = go}
      NovaAPI.BindUIParallaxStageCameraControllerModel(self._mapNode.UIParallax3DStage, idx - 1, go, true)
      if self.rtSceneOriginPos ~= nil then
        go.transform.position = self.rtSceneOriginPos.position
        go.transform.localEulerAngles = Vector3(0, 180, 0)
        go.transform.localScale = Vector3.one * (mapSkin.ModelShowScale / 10000)
        local animator = go:GetComponent(typeof(Animator))
        if animator ~= nil and animator:IsNull() == false then
          animator:SetBool("standby", true)
        end
        GameUIUtils.SetCustomModelMaterialVariant(go, CS.CustomModelMaterialVariantComponent.VariantNames.FormationView)
      end
      if not bOpen then
        self._mapNode.goChar[idx]:PlayChangeFx()
      end
      if PlayerData.Guide:GetGuideState() then
        EventManager.Hit("Guide_LoadCharacterSuccess")
      end
    end
  end
  
  self._panel.nLoadProcess = self._panel.nLoadProcess + 1
  self:LoadAssetAsync(sFullPath, typeof(GameObject), LoadModelCallback)
end

function TrialFormationCtrl:LoadScene()
  local sSceneName = ConfigTable.GetConfigValue("SelectRole_Main")
  self.mapCurModel = {}
  
  local function callbak(bSuccess)
    self.bOpen = true
    if bSuccess == true then
      local sceneRoot = CS.MainMenuModuleHelper.GetMainMenuSceneRoot(sSceneName)
      self.rtSceneOriginPos = sceneRoot.transform:Find("==== Scene ====")
      self.goSelectRolePrefab = self:CreatePrefabInstance("UI/MainlineFormationEx/SelectRolePrefab.prefab", self.rtSceneOriginPos)
      local goSelectRoleCam = self.goSelectRolePrefab.transform:Find("Camera"):GetComponent("Camera")
      NovaAPI.SetupUIParallaxStageCameraControllerForModelView(self._mapNode.UIParallax3DStage, goSelectRoleCam)
      self:Refresh()
      if self.curTeam[1] ~= 0 then
        PlayerData.Voice:PlayCharVoice("swap", self.tbCharTrialToId[self.curTeam[1]])
      end
      
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        self._mapNode.goLoadMask:SetActive(false)
        if PlayerData.Guide:GetGuideState() then
          EventManager.Hit("Guide_LoadFormationSuccess")
        end
      end
      
      cs_coroutine.start(wait)
    else
      self._mapNode.goLoadMask:SetActive(false)
      self._mapNode.UIParallax3DStage.gameObject:SetActive(false)
      self._mapNode.BGbackup:SetActive(true)
    end
    EventManager.Hit(EventId.SetTransition)
    for i = 1, 3 do
      self._mapNode.goChar[i]:OpenList(false)
    end
    self._mapNode.btnStartBattle.transform.localScale = Vector3.one
    self.bOpen = false
  end
  
  CS.MainMenuModuleHelper.GetActiveScene(sSceneName, callbak)
end

function TrialFormationCtrl:Awake()
  self._panel.nLoadProcess = 0
end

function TrialFormationCtrl:OnEnable()
  self._panel.nLoadProcess = 0
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nFloorId = tbParam[1]
  end
  self:InitData()
  self._mapNode.goLoadMask:SetActive(true)
  self._mapNode.btnStartBattle.enabled = true
  self:LoadScene()
end

function TrialFormationCtrl:OnDisable()
  local sSceneName = ConfigTable.GetConfigValue("SelectRole_Main")
  
  local function callback()
  end
  
  CS.MainMenuModuleHelper.DeActiveScene(sSceneName, callback)
  for i, mapModel in pairs(self.mapCurModel) do
    if mapModel.model ~= nil then
      NovaAPI.UnbindUIParallaxStageCameraControllerModel(self._mapNode.UIParallax3DStage, i - 1)
      destroy(mapModel.model)
    end
  end
  for i = 1, 3 do
    self._mapNode.goChar[i].nCharId = nil
  end
  if self.goSelectRolePrefab ~= nil then
    destroy(self.goSelectRolePrefab)
  end
  self.mapCurModel = {}
end

function TrialFormationCtrl:OnDestroy()
end

function TrialFormationCtrl:OnBtnClick_Info(btn)
  if self._panel.nLoadProcess ~= nil and self._panel.nLoadProcess > 1 then
    return
  end
  local tbDisc = {}
  for _, v in ipairs(self.tbDiscId) do
    local mapCfg = ConfigTable.GetData("TrialDisc", v)
    if mapCfg then
      table.insert(tbDisc, mapCfg.DiscId)
    end
  end
  EventManager.Hit(EventId.OpenPanel, PanelId.TrialDepot, self.tbCharId, tbDisc, self.mapCharData, self.mapDiscData, self.mapTalentAddLevel, self.tbDepotPotential, self.mapBuildData.tbNotes)
end

function TrialFormationCtrl:OnBtnClick_Start(btn)
  if self._panel.nLoadProcess ~= nil and self._panel.nLoadProcess > 1 then
    return
  end
  self._mapNode.btnStartBattle.enabled = false
  PlayerData.Trial:EnterTrial(self.nFloorId)
  NovaAPI.SetEntryLevelFade(true)
end

function TrialFormationCtrl:OnEvent_LoadModel(bLoadFinish)
  self._mapNode.Mask:SetActive(not bLoadFinish)
end

function TrialFormationCtrl:OnEvent_Back(nPanelId)
  if self._panel.nLoadProcess ~= nil and self._panel.nLoadProcess > 1 then
    return
  end
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  CS.AdventureModuleHelper.ExitSelectTeam()
  EventManager.Hit(EventId.CloesCurPanel)
  PlayerData.Build:DeleteTrialBuild()
end

function TrialFormationCtrl:OnEvent_BackHome(nPanelId)
  if self._panel.nLoadProcess ~= nil and self._panel.nLoadProcess > 1 then
    return
  end
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  CS.AdventureModuleHelper.ExitSelectTeam()
  PlayerData.Build:DeleteTrialBuild()
  PanelManager.Home()
end

return TrialFormationCtrl
