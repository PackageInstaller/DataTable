local FormationCtrl = class("FormationCtrl", BaseCtrl)
local Animator = CS.UnityEngine.Animator
local CustomModelMaterialVariantComponent = CS.CustomModelMaterialVariantComponent
local GameCameraStackManager = CS.GameCameraStackManager
local GameResourceLoader = require("Game.Common.Resource.GameResourceLoader")
local ResType = GameResourceLoader.ResType
local typeof = _ENV.typeof
FormationCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  goChar = {
    nCount = 3,
    sCtrlName = "Game.UI.FormationEx.FormationCharCtrl"
  },
  btnLeft = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Left"
  },
  btnRight = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Right"
  },
  txtTeamNane = {sComponentName = "TMP_Text"},
  btnRename = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Rename"
  },
  goPoint = {nCount = 6},
  Mask = {},
  btnStartBattle = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Start"
  },
  txtStartBattle = {
    sComponentName = "TMP_Text",
    sLanguageId = "Mainline_Formation_Go"
  },
  TMPHintTrial = {
    sComponentName = "TMP_Text",
    sLanguageId = "Formation_Trial_Hint"
  },
  UIParallax3DStage = {
    sComponentName = "UIParallaxStageCameraController"
  },
  BGbackup = {
    sNodeName = "----BGbackup----"
  },
  CharList = {
    sNodeName = "--CharList--",
    sCtrlName = "Game.UI.FormationEx.FormationCharListCtrl"
  },
  btnFastFormation = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_FastFormation"
  },
  rt_TeamName = {},
  rt_TeamNameAlpha = {
    sNodeName = "rt_TeamName",
    sComponentName = "CanvasGroup"
  },
  t_arrow_01 = {},
  SwapCharPanel = {
    sCtrlName = "Game.UI.FormationEx.SwapCharCtrl"
  },
  charCanvasGroup = {
    sNodeName = "----Char----",
    sComponentName = "CanvasGroup"
  },
  txtBtnFastFormation = {
    sComponentName = "TMP_Text",
    sLanguageId = "Auto_Formation"
  },
  goLoadMask = {},
  SwapBlock = {},
  rtThemePrevRoot = {},
  rtSlectedChar = {
    sComponentName = "RectTransform"
  },
  goPreselection = {},
  btnPreselection = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_Preselection"
  },
  txtBtnPreselection = {
    sComponentName = "TMP_Text",
    sLanguageId = "Build_Preselection_Btn"
  },
  imgPreSelected = {sComponentName = "Button"},
  txtPreSelect = {sComponentName = "TMP_Text"},
  btnPreDetail = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_PreDetail"
  },
  imgBgDetail = {}
}
FormationCtrl._mapEventConfig = {
  [EventId.FormationLoadModel] = "OnEvent_LoadModel",
  OnEvent_SelectRefresh = "Refresh",
  OnEvent_OpenSelectTeamMemberList = "OnEvent_OpenSelectTeamMemberList",
  OnEvent_OpenSwapTeamMember = "OnEvent_OpenSwapChar",
  [EventId.UIBackConfirm] = "OnEvent_Back",
  [EventId.UIHomeConfirm] = "OnEvent_BackHome",
  OnEvent_CloseTeamList = "OnEvent_CloseList",
  OnEvent_ChangeTeamModel = "OnEvent_ChangeTeamModel",
  UpdateFormationInfoSuc = "OnEvent_UpdateFormationInfoSuc"
}

function FormationCtrl:Refresh(nDirection)
  NovaAPI.SetTMPText(self._mapNode.txtTeamNane, orderedFormat(ConfigTable.GetUIText("Formation_DefaultName"), self._panel.nTeamIndex))
  local _, tbTeamMemberId
  if not self.bTrialLevel then
    _, tbTeamMemberId = PlayerData.Team:GetTeamData(self._panel.nTeamIndex)
    self.nPreselectionId = PlayerData.Team:GetTeamPreselectionId(self._panel.nTeamIndex)
    self.curTeam = {}
    for _, value in ipairs(tbTeamMemberId) do
      table.insert(self.curTeam, value)
    end
    self:RefreshPoint(self._panel.nTeamIndex)
  else
    local mapSelectedMainlineId = PlayerData.Mainline._nSelectId
    local mapMainline = ConfigTable.GetData_Mainline(mapSelectedMainlineId)
    self.curTeam = mapMainline.TrialCharacter
  end
  self:RefreshChar(nDirection)
  self:RefreshPreselection()
end

function FormationCtrl:RefreshPoint(nIndex)
  for i = 1, 6 do
    self._mapNode.goPoint[i].transform:Find("imgOn").gameObject:SetActive(i == nIndex)
    self._mapNode.goPoint[i].transform:Find("imgOff").gameObject:SetActive(i ~= nIndex)
  end
end

function FormationCtrl:RefreshChar(nDirection)
  for i = 1, 3 do
    if self.curTeam[i] == nil then
      self.curTeam[i] = 0
    end
    self._mapNode.goChar[i]:OnRender(self.curTeam, i, self.bTrialLevel, nDirection)
    if self.curTeam[i] ~= 0 then
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

function FormationCtrl:CheckBannedChar(bIsAwake)
  local bHasBannedChar = false
  local tbBannedChar = PlayerData.Mainline:GetBanedCharId()
  local _, tbTeamMemberId = PlayerData.Team:GetTeamData(self._panel.nTeamIndex)
  local sBannedChar = ""
  if tbBannedChar ~= nil then
    for _, nCharID in ipairs(tbTeamMemberId) do
      if table.indexof(tbBannedChar, nCharID) > 0 then
        bHasBannedChar = true
        local mapChar = ConfigTable.GetData_Character(nCharID)
        local sCharName = mapChar.Name
        sBannedChar = sBannedChar .. string.format(" %s", sCharName)
      end
    end
  end
  if bHasBannedChar then
    local sHint = orderedFormat(ConfigTable.GetUIText("SelectTeam_HasBannedChar"), sBannedChar)
    if bIsAwake then
      local function callBack()
        EventManager.Hit("OnEvent_OpenSelectTeamMemberNode")
      end
      
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Alert,
        sContent = sHint,
        callbackConfirm = callBack
      })
    else
      EventManager.Hit(EventId.OpenMessageBox, {
        nType = AllEnum.MessageBox.Alert,
        sContent = sHint
      })
    end
  end
  return bHasBannedChar
end

function FormationCtrl:EnterMainline()
  PlayerData.Mainline.nCurTeamIndex = self._panel.nTeamIndex
  if self:CheckBannedChar(false) then
    self._mapNode.btnStartBattle.enabled = true
    return
  end
  if not self.bTrialLevel and PlayerData.Team:CheckTeamValid(self._panel.nTeamIndex) == false then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("FRFORMATION_02"))
    self._mapNode.btnStartBattle.enabled = true
    return
  end
  
  local function CheckItemCountExceededLimitCb(isExceeded)
    if not isExceeded then
      EventManager.Hit(EventId.SendMsgEnterBattle, self._panel.nTeamIndex)
    end
  end
  
  PlayerData.Item:CheckItemCountExceededLimit(CheckItemCountExceededLimitCb)
end

function FormationCtrl:EnterStarTower()
  local nTeamIdx = self._panel.nTeamIndex
  
  local function EnterDiscSelect()
    local teamIDs = {}
    local _, tbTeamMemberId = PlayerData.Team:GetTeamData(nTeamIdx)
    for i = 1, #tbTeamMemberId do
      if tbTeamMemberId[i] ~= nil and 0 < tbTeamMemberId[i] then
        table.insert(teamIDs, tbTeamMemberId[i])
      end
    end
    if #teamIDs == 3 then
      EventManager.Hit(EventId.OpenPanel, PanelId.MainlineFormationDisc, self.curRoguelikeId, self._panel.nTeamIndex, self.bSweep, self.nPreselectionId)
      self:SetLocalData()
    else
      EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("FRFORMATION_01"))
      self._mapNode.btnStartBattle.enabled = true
    end
  end
  
  local function CheckBuildCountCallBack(nBuildCount)
    local nMaxBuildCount = ConfigTable.GetConfigNumber("StarTowerBuildNumberMax")
    if nBuildCount >= nMaxBuildCount then
      local function confirmCallback()
        EventManager.Hit(EventId.OpenPanel, PanelId.StarTowerBuildBriefList)
        
        self._mapNode.btnStartBattle.enabled = true
      end
      
      local function cancelCallback()
        EnterDiscSelect()
      end
      
      local msg = {
        nType = AllEnum.MessageBox.Confirm,
        sContent = ConfigTable.GetUIText("BUILD_04"),
        sConfirm = ConfigTable.GetUIText("RoguelikeBuild_BuildCount_BtnManage"),
        sCancel = ConfigTable.GetUIText("RoguelikeBuild_BuildCount_BtnCancle"),
        callbackConfirm = confirmCallback,
        callbackCancel = cancelCallback
      }
      EventManager.Hit(EventId.OpenMessageBox, msg)
      return
    else
      EnterDiscSelect()
    end
  end
  
  PlayerData.Build:GetBuildCount(CheckBuildCountCallBack)
end

function FormationCtrl:RefreshPreselection()
  local function callback()
    if self.nPreselectionId == 0 then
      NovaAPI.SetTMPText(self._mapNode.txtPreSelect, ConfigTable.GetUIText("Build_Preselection_Empty"))
      
      self._mapNode.imgPreSelected.interactable = true
      self._mapNode.imgBgDetail.gameObject:SetActive(false)
    else
      self._mapNode.imgBgDetail.gameObject:SetActive(true)
      local bDiff = false
      local mapPreselection = PlayerData.PotentialPreselection:GetPreselectionById(self.nPreselectionId)
      if mapPreselection ~= nil then
        for k, v in ipairs(mapPreselection.tbCharPotential) do
          if k == 1 then
            if v.nCharId ~= self.curTeam[1] then
              bDiff = true
              break
            end
          elseif table.indexof(self.curTeam, v.nCharId) == 0 then
            bDiff = true
            break
          end
        end
      end
      if bDiff then
        NovaAPI.SetTMPText(self._mapNode.txtPreSelect, ConfigTable.GetUIText("Build_Preselection_CharDiff"))
        self._mapNode.imgPreSelected.interactable = false
      else
        NovaAPI.SetTMPText(self._mapNode.txtPreSelect, ConfigTable.GetUIText("Build_Preselection_Selected"))
        self._mapNode.imgPreSelected.interactable = true
      end
    end
  end
  
  PlayerData.PotentialPreselection:SendGetPreselectionList(callback)
end

function FormationCtrl:Awake()
  self.isOpenTeamMember = false
  self:CheckBannedChar(true)
  self._panel.nLoadProcess = 0
end

function FormationCtrl:OnEnable()
  self.nPreselectionId = 0
  local mapSelectedMainlineId = PlayerData.Mainline._nSelectId
  self._mapNode.goLoadMask:SetActive(true)
  self._Animator = self.gameObject:GetComponent("Animator")
  self.bTrialLevel = false
  local tbParam = self:GetPanelParam()
  self.nFRType = tbParam[1] or AllEnum.FormationEnterType.MainLine
  self.curRoguelikeId = tbParam[2]
  self.bSweep = tbParam[4]
  self._mapNode.btnStartBattle.enabled = true
  if self.nFRType == AllEnum.FormationEnterType.MainLine then
    local mapMainline = ConfigTable.GetData_Mainline(mapSelectedMainlineId)
    local tbTeamMemberId, nCaptain
    if mapMainline.TrialCharacter ~= nil and 0 < #mapMainline.TrialCharacter then
      tbTeamMemberId = mapMainline.TrialCharacter
      self.mapTrialChar = PlayerData.Char:CreateTrialChar(tbTeamMemberId)
      self.bTrialLevel = true
    end
  elseif self.nFRType == AllEnum.FormationEnterType.StarTower then
    local mapStartowerCfg = ConfigTable.GetData("StarTower", self.curRoguelikeId)
    if mapStartowerCfg ~= nil then
      local nCachedIdx = PlayerData.StarTower:GetGroupFormation(mapStartowerCfg.GroupId)
      if 0 < nCachedIdx and self._panel.nTeamIndex == nil then
        self._panel.nTeamIndex = nCachedIdx
      end
    end
  end
  local LocalData = require("GameCore.Data.LocalData")
  if self._panel.nTeamIndex == nil then
    local nIdx = tonumber(LocalData.GetPlayerLocalData("SavedTeamIdx"))
    if nIdx == nil then
      nIdx = 1
    end
    self._panel.nTeamIndex = nIdx
  end
  self._mapNode.btnLeft.gameObject:SetActive(not self.bTrialLevel)
  self._mapNode.btnRight.gameObject:SetActive(not self.bTrialLevel)
  self._mapNode.btnFastFormation.gameObject:SetActive(not self.bTrialLevel)
  self._mapNode.rt_TeamName.gameObject:SetActive(not self.bTrialLevel)
  self._mapNode.TMPHintTrial.gameObject:SetActive(self.bTrialLevel)
  self._mapNode.goPreselection.gameObject:SetActive(not self.bTrialLevel)
  self._mapNode.t_arrow_01:SetActive(not self.bTrialLevel)
  local sSceneName = self.nFRType ~= AllEnum.FormationEnterType.MainLine and ConfigTable.GetConfigValue("SelectRole_Rogue") or ConfigTable.GetConfigValue("SelectRole_Main")
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
        PlayerData.Voice:PlayCharVoice("swap", self.curTeam[1])
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
    if tbParam[3] and self.nFRType ~= AllEnum.FormationEnterType.MainLine then
      self._mapNode.goLoadMask:SetActive(false)
    else
      EventManager.Hit(EventId.SetTransition)
    end
    for i = 1, 3 do
      self._mapNode.goChar[i]:OpenList(false)
      self._mapNode.goChar[i]:SetSelectedChar(self._mapNode.rtSlectedChar)
    end
    self._mapNode.btnStartBattle.transform.localScale = Vector3.one
    self.bOpen = false
    if self._panel.bList then
      self:OnEvent_OpenSelectTeamMemberList()
    end
  end
  
  CS.MainMenuModuleHelper.GetActiveScene(sSceneName, callbak)
  self.bOpenTransition = false
end

function FormationCtrl:OnDisable()
  if self._panel.bList then
    self._mapNode.CharList:SyncFormation()
  end
  local sSceneName = self.nFRType ~= AllEnum.FormationEnterType.MainLine and ConfigTable.GetConfigValue("SelectRole_Rogue") or ConfigTable.GetConfigValue("SelectRole_Main")
  
  local function callback1()
    EventManager.Hit(EventId.SetTransition)
  end
  
  local function callback2()
  end
  
  CS.MainMenuModuleHelper.DeActiveScene(sSceneName, self.bOpenTransition == true and callback1 or callback2)
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

function FormationCtrl:OnDestroy()
end

function FormationCtrl:LoadCharacter(nCharId, bOpen)
  local mapSkin
  if self.bTrialLevel and self.mapTrialChar ~= nil then
    local nSkinId = self.mapTrialChar[nCharId].nSkinId
    mapSkin = ConfigTable.GetData_CharacterSkin(nSkinId)
  else
    mapSkin = ConfigTable.GetData_CharacterSkin(PlayerData.Char:GetCharSkinId(nCharId))
  end
  if not mapSkin then
    printLog("没有找到皮肤配置" .. nCharId)
    return
  end
  local sFullPath = string.format("%s.prefab", mapSkin.Model_Show)
  
  local function LoadModelCallback(obj)
    if self._mapNode == nil then
      return
    end
    self._panel.nLoadProcess = self._panel.nLoadProcess - 1
    local idx = table.indexof(self.curTeam, nCharId)
    if 0 < idx then
      if self.mapCurModel[idx] ~= nil then
        NovaAPI.UnbindUIParallaxStageCameraControllerModel(self._mapNode.UIParallax3DStage, idx - 1)
        destroy(self.mapCurModel[idx].model)
        self.mapCurModel[idx] = nil
      end
      local go = instantiate(obj, self.rtSceneOriginPos)
      NovaAPI.ChangeAnimatorDefaultState(go.transform)
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

function FormationCtrl:SetModelPos(nCharId, objModel, nPos)
  local mapSkin = ConfigTable.GetData_CharacterSkin(PlayerData.Char:GetCharSkinId(nCharId))
  if not mapSkin then
    printLog("没有找到皮肤配置" .. nCharId)
    return
  end
  if self.mapCurModel[nPos] ~= nil then
    NovaAPI.UnbindUIParallaxStageCameraControllerModel(self._mapNode.UIParallax3DStage, nPos - 1)
    destroy(self.mapCurModel[nPos].model)
    self.mapCurModel[nPos] = nil
  end
  self.mapCurModel[nPos] = {nCharId = nCharId, model = objModel}
  if self.rtSceneOriginPos ~= nil then
    objModel.transform.position = self.rtSceneOriginPos.position
    objModel.transform.localScale = Vector3.one * (mapSkin.ModelShowScale / 10000)
    local animator = objModel:GetComponent(typeof(Animator))
    if animator ~= nil then
      animator:SetBool("standby", true)
    end
    local matVariantComp = objModel:GetComponent(typeof(CustomModelMaterialVariantComponent))
    if matVariantComp ~= nil then
      matVariantComp:SetVariant(CS.CustomModelMaterialVariantComponent.VariantNames.FormationView)
    end
  end
end

function FormationCtrl:CheckFormationChanged()
  local bChange = false
  local nTeamIndex = self._panel.nTeamIndex
  local _, teamMemberid = PlayerData.Team:GetTeamData(nTeamIndex)
  for i = 1, #teamMemberid do
    if teamMemberid[i] ~= self.curTeam[i] then
      return true
    end
  end
  return bChange
end

function FormationCtrl.filterUnfinish(tbAllChar)
  local tbAvailable = {}
  for _, mapChar in ipairs(tbAllChar) do
    local mapCharCfgData = ConfigTable.GetData_Character(mapChar.nId)
    if mapCharCfgData.Available then
      table.insert(tbAvailable, mapChar)
    end
  end
  return tbAvailable
end

function FormationCtrl.filterLevel(tbAllChar, tbSelectedChar, nLevel)
  local retLevel = {}
  for _, mapChar in ipairs(tbAllChar) do
    if nLevel <= mapChar.nLevel and table.indexof(tbSelectedChar, mapChar.nId) < 1 then
      table.insert(retLevel, mapChar)
    end
  end
  return retLevel
end

function FormationCtrl.filterEET(tbAllChar, tbSelectedChar, tbEET)
  local retEET = {}
  for _, mapChar in ipairs(tbAllChar) do
    local mapCharCfgData = ConfigTable.GetData_Character(mapChar.nId)
    if table.indexof(tbEET, mapCharCfgData.EET) >= 1 and table.indexof(tbSelectedChar, mapChar.nId) < 1 then
      table.insert(retEET, mapChar)
    end
  end
  return retEET
end

function FormationCtrl.filterEETNotrecommend(tbAllChar, tbSelectedChar, tbEET)
  local retEET = {}
  for _, mapChar in ipairs(tbAllChar) do
    local mapCharCfgData = ConfigTable.GetData_Character(mapChar.nId)
    if table.indexof(tbEET, mapCharCfgData.EET) < 1 and table.indexof(tbSelectedChar, mapChar.nId) < 1 then
      table.insert(retEET, mapChar)
    end
  end
  return retEET
end

function FormationCtrl.filterMain(tbAllChar, tbSelectedChar)
  local tbMain = {}
  for _, mapChar in ipairs(tbAllChar) do
    local mapCharCfgData = ConfigTable.GetData_Character(mapChar.nId)
    if mapCharCfgData ~= nil and mapCharCfgData.Class == GameEnum.characterJobClass.Vanguard and table.indexof(tbSelectedChar, mapChar.nId) < 1 then
      table.insert(tbMain, mapChar)
    end
  end
  if #tbMain == 0 then
    for _, mapChar in ipairs(tbAllChar) do
      local mapCharCfgData = ConfigTable.GetData_Character(mapChar.nId)
      if mapCharCfgData ~= nil and mapCharCfgData.Class == GameEnum.characterJobClass.Balance and table.indexof(tbSelectedChar, mapChar.nId) < 1 then
        table.insert(tbMain, mapChar)
      end
    end
  end
  return tbMain
end

function FormationCtrl.filterSub(tbAllChar, tbSelectedChar)
  local tbRet = {}
  for _, mapChar in ipairs(tbAllChar) do
    local mapCharCfgData = ConfigTable.GetData_Character(mapChar.nId)
    if mapCharCfgData ~= nil and mapCharCfgData.Class == GameEnum.characterJobClass.Support and table.indexof(tbSelectedChar, mapChar.nId) < 1 then
      table.insert(tbRet, mapChar)
    end
  end
  if #tbRet == 0 then
    for _, mapChar in ipairs(tbAllChar) do
      local mapCharCfgData = ConfigTable.GetData_Character(mapChar.nId)
      if mapCharCfgData ~= nil and mapCharCfgData.Class == GameEnum.characterJobClass.Balance and table.indexof(tbSelectedChar, mapChar.nId) < 1 then
        table.insert(tbRet, mapChar)
      end
    end
  end
  return tbRet
end

function FormationCtrl.filterBalance(tbAllChar, tbSelectedChar)
  local tbRet = {}
  for _, mapChar in ipairs(tbAllChar) do
    local mapCharCfgData = ConfigTable.GetData_Character(mapChar.nId)
    if mapCharCfgData ~= nil and mapCharCfgData.Class == GameEnum.characterJobClass.Balance and table.indexof(tbSelectedChar, mapChar.nId) < 1 then
      table.insert(tbRet, mapChar)
    end
  end
  if #tbRet == 0 then
    for _, mapChar in ipairs(tbAllChar) do
      local mapCharCfgData = ConfigTable.GetData_Character(mapChar.nId)
      if mapCharCfgData ~= nil and mapCharCfgData.Class == GameEnum.characterJobClass.Support and table.indexof(tbSelectedChar, mapChar.nId) < 1 then
        table.insert(tbRet, mapChar)
      end
    end
  end
  return tbRet
end

function FormationCtrl.selectAtk(tbAllChar, tbSelectedChar)
  local CharacterAttrData = require("GameCore.Data.DataClass.CharacterAttrData")
  local charAttrData = CharacterAttrData.new()
  local maxAtk = 0
  local selCharId = 0
  for _, mapChar in ipairs(tbAllChar) do
    charAttrData:SetCharacter(mapChar.nId)
    local attrList = charAttrData:GetAttrList()
    if maxAtk < attrList[2].totalValue and table.indexof(tbSelectedChar, mapChar.nId) < 1 then
      maxAtk = attrList[2].totalValue
      selCharId = mapChar.nId
    end
  end
  return selCharId
end

function FormationCtrl:AutoSelectMainline()
  local ret = {}
  local mapSelectedMainlineId = PlayerData.Mainline._nSelectId
  local mapMainline = ConfigTable.GetData_Mainline(mapSelectedMainlineId)
  local nLevelOffset = ConfigTable.GetConfigNumber("AutoFormationLevel")
  local nRecommendLevel = mapMainline.Recommend - nLevelOffset
  local tbChar = self.filterUnfinish(PlayerData.Char:GetCharIdList())
  if #tbChar < 3 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Formation_NeedMoreChar"))
    return ret
  end
  local retLevel = self.filterLevel(tbChar, ret, nRecommendLevel)
  if #retLevel == 0 then
    retLevel = tbChar
  end
  local retMain = self.filterMain(retLevel, ret)
  if #retMain == 0 then
    retMain = tbChar
  end
  local nCharId = self.selectAtk(retMain, ret)
  if nCharId == 0 then
    nCharId = tbChar[1].nId
  end
  table.insert(ret, nCharId)
  local cfgDataMain = DataTable.Character[ret[1]]
  local mainEET = {
    cfgDataMain.EET
  }
  local retEET
  retLevel = self.filterLevel(tbChar, ret, nRecommendLevel)
  if #retLevel == 0 then
    retLevel = tbChar
  end
  retEET = self.filterEET(retLevel, ret, mainEET)
  if #retEET == 0 then
    retEET = retLevel
  end
  nCharId = self.selectAtk(retEET, ret)
  if nCharId == 0 then
    nCharId = tbChar[2].nId
  end
  table.insert(ret, nCharId)
  retLevel = self.filterLevel(tbChar, ret, nRecommendLevel)
  if #retLevel == 0 then
    retLevel = tbChar
  end
  retEET = self.filterEET(retLevel, ret, mainEET)
  if #retEET == 0 then
    retEET = retLevel
  end
  nCharId = self.selectAtk(retEET, ret)
  if nCharId == 0 then
    nCharId = tbChar[3].nId
  end
  table.insert(ret, nCharId)
  return ret
end

function FormationCtrl:AutoSelectStarTower()
  local ret = {}
  local mapFR = ConfigTable.GetData("StarTower", self.curRoguelikeId)
  local nLevelOffset = ConfigTable.GetConfigNumber("AutoFormationLevel")
  local nRecommendLevel = mapFR.Recommend - nLevelOffset
  local tbEET = mapFR.EET
  local tbEETNotrecommend = mapFR.NotEET
  local retEET
  local tbChar = self.filterUnfinish(PlayerData.Char:GetCharIdList())
  if #tbChar < 3 then
    EventManager.Hit(EventId.OpenMessageBox, ConfigTable.GetUIText("Formation_NeedMoreChar"))
    return ret
  end
  local retLevel = self.filterLevel(tbChar, ret, nRecommendLevel)
  if #retLevel == 0 then
    retLevel = tbChar
  end
  retEET = self.filterEET(retLevel, ret, tbEET)
  if #retEET == 0 then
    retEET = self.filterEETNotrecommend(retLevel, ret, tbEETNotrecommend)
    if #retEET == 0 then
      retEET = retLevel
    end
  end
  local retMain = self.filterMain(retEET, ret)
  if #retMain < 1 then
    retMain = retEET
  end
  local nCharId = self.selectAtk(retMain, ret)
  if nCharId == 0 then
    nCharId = tbChar[1].nId
  end
  table.insert(ret, nCharId)
  local cfgDataMain = DataTable.Character[ret[1]]
  local tbEETMain = {
    cfgDataMain.EET
  }
  retLevel = self.filterLevel(tbChar, ret, nRecommendLevel)
  if #retLevel == 0 then
    retLevel = tbChar
  end
  retEET = self.filterEET(retLevel, ret, tbEETMain)
  if #retEET == 0 then
    retEET = self.filterEET(retLevel, ret, tbEET)
    if #retEET == 0 then
      retEET = self.filterEETNotrecommend(retLevel, ret, tbEETNotrecommend)
      if #retEET == 0 then
        retEET = retLevel
      end
    end
  end
  local retSub1 = self.filterSub(retEET, ret)
  if #retSub1 < 1 then
    retSub1 = retEET
  end
  nCharId = self.selectAtk(retSub1, ret)
  if nCharId == 0 then
    nCharId = tbChar[2].nId
  end
  table.insert(ret, nCharId)
  retLevel = self.filterLevel(tbChar, ret, nRecommendLevel)
  if #retLevel == 0 then
    retLevel = tbChar
  end
  retEET = self.filterEET(retLevel, ret, tbEETMain)
  if #retEET == 0 then
    retEET = self.filterEET(retLevel, ret, tbEET)
    if #retEET == 0 then
      retEET = self.filterEETNotrecommend(retLevel, ret, tbEETNotrecommend)
      if #retEET == 0 then
        retEET = retLevel
      end
    end
  end
  local retBalance = self.filterBalance(retEET, ret)
  if #retBalance < 1 then
    retBalance = retEET
  end
  nCharId = self.selectAtk(retBalance, ret)
  if nCharId == 0 then
    nCharId = tbChar[3].nId
  end
  table.insert(ret, nCharId)
  return ret
end

function FormationCtrl:OnBtnClick_Left(btn)
  if self._panel.bList then
    return
  end
  if self._panel.nTeamIndex == 1 then
    self._panel.nTeamIndex = 6
  else
    self._panel.nTeamIndex = self._panel.nTeamIndex - 1
  end
  self:Refresh(2)
  if self.curTeam[1] ~= 0 then
    PlayerData.Voice:PlayCharVoice("swap", self.curTeam[1])
  end
end

function FormationCtrl:OnBtnClick_Right(btn)
  if self._panel.bList then
    return
  end
  if self._panel.nTeamIndex == 6 then
    self._panel.nTeamIndex = 1
  else
    self._panel.nTeamIndex = self._panel.nTeamIndex + 1
  end
  self:Refresh(1)
  if self.curTeam[1] ~= 0 then
    PlayerData.Voice:PlayCharVoice("swap", self.curTeam[1])
  end
end

function FormationCtrl:OnBtnClick_Rename(btn)
end

function FormationCtrl:OnBtnClick_FastFormation(btn)
  local function confirmCallback()
    local retTeam
    
    if self.nFRType == AllEnum.FormationEnterType.MainLine then
      retTeam = self:AutoSelectMainline()
    elseif self.nFRType == AllEnum.FormationEnterType.StarTower then
      retTeam = self:AutoSelectStarTower()
    else
      printError("不再支持老遗迹跳转")
    end
    self.curTeam = retTeam
    EventManager.Hit(EventId.OpenMessageBox, {
      nType = AllEnum.MessageBox.Tips,
      bPositive = true,
      sContent = ConfigTable.GetUIText("Auto_FormationTips")
    })
    if self:CheckFormationChanged() then
      local function Callback()
        self:Refresh()
        
        if self.curTeam[1] ~= 0 then
          PlayerData.Voice:PlayCharVoice("swap", self.curTeam[1])
        end
      end
      
      local tmpDisc = PlayerData.Team:GetTeamDiscData(self._panel.nTeamIndex)
      local nPreselectionId = PlayerData.Team:GetTeamPreselectionId(self._panel.nTeamIndex)
      PlayerData.Team:UpdateFormationInfo(self._panel.nTeamIndex, self.curTeam, tmpDisc, nPreselectionId, Callback)
    end
  end
  
  local function cancelCallback()
  end
  
  local msg = {
    nType = AllEnum.MessageBox.Confirm,
    sContent = ConfigTable.GetUIText("Auto_FormationNotice"),
    callbackConfirm = confirmCallback,
    callbackCancel = cancelCallback
  }
  for _, nId in ipairs(self.curTeam) do
    if 0 < nId then
      if not PlayerData.Guide:CheckInGuideGroup(12) then
        EventManager.Hit(EventId.OpenMessageBox, msg)
      else
        confirmCallback()
      end
      return
    end
  end
  confirmCallback()
end

function FormationCtrl:SetLocalData()
  local LocalData = require("GameCore.Data.LocalData")
  LocalData.SetPlayerLocalData("SavedTeamIdx", self._panel.nTeamIndex)
end

function FormationCtrl:OnBtnClick_Start(btn)
  if self._panel.nLoadProcess ~= nil and self._panel.nLoadProcess > 1 then
    return
  end
  self._mapNode.btnStartBattle.enabled = false
  if self.nFRType == AllEnum.FormationEnterType.MainLine then
    self:EnterMainline()
  elseif self.nFRType == AllEnum.FormationEnterType.FixedRoguelike then
    printError("不再支持进入老遗迹")
  elseif self.nFRType == AllEnum.FormationEnterType.StarTower then
    self:EnterStarTower()
  end
  NovaAPI.SetEntryLevelFade(true)
end

function FormationCtrl:OnBtnClick_Preselection()
  PlayerData.PotentialPreselection:SendGetPreselectionList(function()
    EventManager.Hit(EventId.OpenPanel, PanelId.PotentialPreselectionList, self.curTeam, self._panel.nTeamIndex, true)
  end)
end

function FormationCtrl:OnBtnClick_PreDetail()
  if self.nPreselectionId == 0 then
    return
  end
  PlayerData.PotentialPreselection:SendGetPreselectionList(function()
    local mapData = PlayerData.PotentialPreselection:GetPreselectionById(self.nPreselectionId)
    EventManager.Hit(EventId.OpenPanel, PanelId.PotentialPreselectionEdit, AllEnum.PreselectionPanelType.Preview, mapData, self.curTeam, self._panel.nTeamIndex)
  end)
end

function FormationCtrl:OnEvent_LoadModel(bLoadFinish)
  self._mapNode.Mask:SetActive(not bLoadFinish)
end

function FormationCtrl:OnEvent_Back(nPanelId)
  if self._panel.nLoadProcess ~= nil and self._panel.nLoadProcess > 1 then
    return
  end
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  if self._panel.bList == true then
    self._mapNode.CharList:OnBtnClick_Close()
  else
    CS.AdventureModuleHelper.ExitSelectTeam()
    PlayerData.Char:DeleteTrialChar()
    
    local function OpenCallback()
      EventManager.Hit(EventId.CloesCurPanel)
    end
    
    EventManager.Hit(EventId.SetTransition, 5, OpenCallback)
    self.bOpenTransition = true
  end
end

function FormationCtrl:OnEvent_BackHome(nPanelId)
  if self._panel.nLoadProcess ~= nil and self._panel.nLoadProcess > 1 then
    print(self._panel.nLoadProcess)
    return
  end
  if self._panel._nPanelId ~= nPanelId then
    return
  end
  CS.AdventureModuleHelper.ExitSelectTeam()
  PlayerData.Char:DeleteTrialChar()
  
  local function OpenCallback()
    PanelManager.Home()
  end
  
  EventManager.Hit(EventId.SetTransition, 5, OpenCallback)
  self.bOpenTransition = true
end

function FormationCtrl:OnEvent_OpenSelectTeamMemberList(nIdx)
  self._mapNode.btnFastFormation.gameObject:SetActive(false)
  self._mapNode.btnStartBattle.transform.localScale = Vector3.zero
  self._mapNode.t_arrow_01.gameObject:SetActive(false)
  self._mapNode.goPreselection.gameObject:SetActive(false)
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.rt_TeamNameAlpha, 0)
  self._mapNode.CharList:ShowList(self.curTeam, true)
  self._panel.bList = true
  self._Animator:Play("CharList_in")
  self._mapNode.goChar[1]:OpenList(true)
  self._mapNode.goChar[2]:OpenList(true)
  self._mapNode.goChar[3]:OpenList(true)
end

function FormationCtrl:OnEvent_CloseList(bConfirm, tbList)
  if bConfirm then
    local function Callback()
      self:Refresh()
    end
    
    self.curTeam = tbList
    if self:CheckFormationChanged() then
      local tmpDisc = PlayerData.Team:GetTeamDiscData(self._panel.nTeamIndex)
      local nPreselectionId = PlayerData.Team:GetTeamPreselectionId(self._panel.nTeamIndex)
      PlayerData.Team:UpdateFormationInfo(self._panel.nTeamIndex, self.curTeam, tmpDisc, nPreselectionId, Callback)
    end
  else
    self:Refresh()
  end
  
  local function callback()
    self._mapNode.btnFastFormation.gameObject:SetActive(true)
    self._mapNode.btnStartBattle.transform.localScale = Vector3.one
    self._mapNode.t_arrow_01.gameObject:SetActive(true)
    self._mapNode.goPreselection.gameObject:SetActive(true)
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.rt_TeamNameAlpha, 1)
    self._mapNode.CharList:CloseList()
  end
  
  self._Animator:Play("CharList_out")
  self:AddTimer(1, 0.34, callback, true, true)
  for i = 1, 3 do
    self._mapNode.goChar[i]:SetArrowShow(false)
  end
  self._panel.bList = false
  self._mapNode.goChar[1]:OpenList(false)
  self._mapNode.goChar[2]:OpenList(false)
  self._mapNode.goChar[3]:OpenList(false)
end

function FormationCtrl:OnEvent_ChangeTeamModel(tbList)
  self.curTeam = tbList
  self:RefreshChar()
  self:RefreshPreselection()
end

function FormationCtrl:OnEvent_OpenSwapChar(nIdx)
  local function callback(nSwapIdx)
    if nSwapIdx ~= 0 then
      local ntemp = self.curTeam[nIdx]
      
      self.curTeam[nIdx] = self.curTeam[nSwapIdx]
      self.curTeam[nSwapIdx] = ntemp
    end
    
    local function Callback()
      self:Refresh()
      if nSwapIdx == 1 or nIdx == 1 then
        local nCharId = self.curTeam[1]
        PlayerData.Voice:PlayCharVoice("swap", nCharId)
      end
    end
    
    NovaAPI.SetCanvasGroupAlpha(self._mapNode.charCanvasGroup, 1)
    self._mapNode.SwapBlock:SetActive(false)
    for i = 1, 3 do
      if self.mapCurModel[i] ~= nil then
        self.mapCurModel[i].model:SetActive(true)
      end
    end
    if self:CheckFormationChanged() then
      local tmpDisc = PlayerData.Team:GetTeamDiscData(self._panel.nTeamIndex)
      local nPreselectionId = PlayerData.Team:GetTeamPreselectionId(self._panel.nTeamIndex)
      PlayerData.Team:UpdateFormationInfo(self._panel.nTeamIndex, self.curTeam, tmpDisc, nPreselectionId, Callback)
    end
  end
  
  local nCurSelectChar = self.curTeam[nIdx]
  if nCurSelectChar == 0 then
    return
  end
  for i = 1, 3 do
    if self.mapCurModel[i] ~= nil then
      self.mapCurModel[i].model:SetActive(false)
    end
  end
  NovaAPI.SetCanvasGroupAlpha(self._mapNode.charCanvasGroup, 0)
  self._mapNode.SwapCharPanel:ShowSwapChar(self.curTeam, nCurSelectChar, callback)
  self._mapNode.SwapBlock:SetActive(true)
end

function FormationCtrl:OnEvent_UpdateFormationInfoSuc(nTeamIdx)
  if nTeamIdx == self._panel.nTeamIndex then
    self.nPreselectionId = PlayerData.Team:GetTeamPreselectionId(self._panel.nTeamIndex)
    self:RefreshPreselection()
  end
end

return FormationCtrl
