local BreakOutLevelDetailCtrl = class("BreakOutLevelDetailCtrl", BaseCtrl)
local DifficultyState = {
  "Entry",
  "Newbie",
  "Advanced",
  "Expert"
}
BreakOutLevelDetailCtrl._mapNodeConfig = {
  TopBar = {
    sNodeName = "TopBarPanel",
    sCtrlName = "Game.UI.TopBarEx.TopBarCtrl"
  },
  EnemyInfo = {
    sCtrlName = "Game.UI.MainlineEx.MainlineMonsterInfoCtrl"
  },
  btnHeadItem_ = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtn_ClickCharacterItem"
  },
  txtTitleTarget = {
    sNodeName = "txtTitleTarget",
    sComponentName = "TMP_Text",
    sLanguageId = "ChallengingGoals"
  },
  txt_Reward = {
    sNodeName = "txt_Reward",
    sComponentName = "TMP_Text",
    sLanguageId = "BreakOut_Act_Reward"
  },
  txt_LevelTitle = {
    sNodeName = "txt_LevelTitle",
    sComponentName = "TMP_Text"
  },
  txt_DifficultyType = {
    sNodeName = "txt_DifficultyType",
    sComponentName = "TMP_Text"
  },
  txt_LevelDesc = {
    sNodeName = "txt_LevelDesc",
    sComponentName = "TMP_Text"
  },
  txt_Target = {sNodeName = "txt_Target", sComponentName = "TMP_Text"},
  item = {
    nCount = 4,
    sCtrlName = "Game.UI.TemplateEx.TemplateItemCtrl"
  },
  btn_item = {
    nCount = 4,
    sComponentName = "UIButton",
    callback = "OnBtnClick_RewardItem"
  },
  btn_GoChallenge = {sComponentName = "UIButton", callback = "OnBtn_Go"},
  UnClick = {},
  txt_UnGo = {
    sNodeName = "txt_UnGo",
    sComponentName = "TMP_Text",
    sLanguageId = "TD_Btn_Challenge"
  },
  CanClick = {},
  txt_Go = {
    sNodeName = "txt_Go",
    sComponentName = "TMP_Text",
    sLanguageId = "TD_Btn_Challenge"
  },
  btnEnemyInfo = {
    sComponentName = "UIButton",
    callback = "OnBtnClick_EnemyInfo"
  },
  txt_EnemyInfo = {
    sNodeName = "txt_EnemyInfo",
    sComponentName = "TMP_Text",
    sLanguageId = "MonsterInfo"
  },
  txt_title = {
    sNodeName = "txt_title",
    sComponentName = "TMP_Text",
    sLanguageId = "BreakOut_Act_BattleCount"
  },
  txt_battleCount = {
    sNodeName = "txt_battleCount",
    sComponentName = "TMP_Text",
    sLanguageId = "BreakOut_Act_DefaultBattleCount"
  },
  goChar = {
    sCtrlName = "Game.UI.FormationEx.FormationCharCtrl"
  },
  UIParallax3DStage = {
    sComponentName = "UIParallaxStageCameraController"
  },
  iconAdd = {},
  CharacterDetails = {},
  txt_Desc = {
    sNodeName = "txt_Desc",
    sComponentName = "TMP_Text",
    sLanguageId = "BreakOut_Act_DefaultDesc"
  },
  txt_SpDesc = {sNodeName = "txt_SpDesc", sComponentName = "TMP_Text"},
  txt_name = {
    sNodeName = "txt_name",
    sComponentName = "TMP_Text",
    sLanguageId = "BreakOut_Act_DefaultName_Skill"
  },
  txtProperty_CD = {sComponentName = "TMP_Text", sLanguageId = "Talent_CD"},
  txtValue_CD = {sComponentName = "TMP_Text"},
  SkillIcon = {
    sNodeName = "imgIcon_Skill",
    sComponentName = "Image"
  },
  fxChange = {}
}
BreakOutLevelDetailCtrl._mapEventConfig = {
  Event_ReStartBreakOut = "Event_ReStartGoPlay",
  RefreshCharacterBattleTimes = "RefreshCharacterDetail"
}

function BreakOutLevelDetailCtrl:Awake()
  local param = self:GetPanelParam()
  if type(param) == "table" then
    self.nActId = param[1]
    self.nLevelId = param[2]
  end
  self.BreakOutData = PlayerData.Activity:GetActivityDataById(self.nActId)
  self.LevelCharacters = {}
  self.LevelData = self.BreakOutData:GetDetailLevelDataById(self.nLevelId)
  local nFloorId = self.LevelData.FloorId
  self.BreakOutFloorData = ConfigTable.GetData("BreakOutFloor", nFloorId)
  self.PreviewMonsterGroupId = self.LevelData.PreviewMonsterGroupId
  self._mapNode.btnEnemyInfo.gameObject:SetActive(self.PreviewMonsterGroupId ~= 0)
  self.BreakOutLevelDetail_Animator = self.gameObject:GetComponent("Animator")
end

function BreakOutLevelDetailCtrl:OnEnable()
  self.curCharacter = nil
  self.isOnDefaultClick = true
  self.nCurrentIndex = 1
  self.nCurrentCharacterNid = {}
  self.gameObject:SetActive(false)
  local sSceneName = ConfigTable.GetData("BreakOutControl", self.nActId).SceneName
  
  local function Callback(bSuccess)
    self.bOpen = true
    if bSuccess == true then
      local sceneRoot = CS.MainMenuModuleHelper.GetMainMenuSceneRoot(sSceneName)
      self.rtSceneOriginPos = sceneRoot.transform:Find("==== Scene ====")
      self.goSelectRolePrefab = self:CreatePrefabInstance("UI/MainlineFormationEx/SelectRolePrefab.prefab", self.rtSceneOriginPos)
      local goSelectRoleCam = self.goSelectRolePrefab.transform:Find("Camera"):GetComponent("Camera")
      NovaAPI.SetupUIParallaxStageCameraControllerForModelView(self._mapNode.UIParallax3DStage, goSelectRoleCam)
      self:Refresh()
      if #self.nCurrentCharacterNid ~= 0 then
      end
      
      local function wait()
        coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
        if PlayerData.Guide:GetGuideState() then
          EventManager.Hit("Guide_LoadFormationSuccess")
        end
      end
      
      cs_coroutine.start(wait)
    else
      self._mapNode.UIParallax3DStage.gameObject:SetActive(false)
    end
    self._mapNode.goChar:OpenList(false)
    self.bOpen = false
    EventManager.Hit(EventId.SetTransition)
    self.gameObject:SetActive(true)
    self.BreakOutLevelDetail_Animator:Play("BreakOutLevelDetailPanel_in", -1, 0)
  end
  
  CS.MainMenuModuleHelper.GetActiveScene(sSceneName, Callback)
  self.bOpenTransition = false
end

function BreakOutLevelDetailCtrl:OnDisable()
  local sSceneName = ConfigTable.GetData("BreakOutControl", self.nActId).SceneName
  
  local function callback1()
    EventManager.Hit(EventId.SetTransition)
  end
  
  local function callback2()
  end
  
  CS.MainMenuModuleHelper.DeActiveScene(sSceneName, self.bOpenTransition == true and callback1 or callback2)
  if self.curCharacter ~= nil and self.curCharacter.model ~= nil then
    NovaAPI.UnbindUIParallaxStageCameraControllerModel(self._mapNode.UIParallax3DStage, 0)
    destroy(self.curCharacter.model)
  end
  self._mapNode.goChar.nCharId = nil
  if self.goSelectRolePrefab ~= nil then
    destroy(self.goSelectRolePrefab)
  end
  self.curCharacter = nil
end

function BreakOutLevelDetailCtrl:Refresh()
  self:Set_DefaultCharacter()
  self:RefreshLevelDetail()
  self:RefreshLevelCharacter()
  self:RefreshCharacterDetail()
  self:RefreshCharacter()
end

function BreakOutLevelDetailCtrl:RefreshLevelDetail()
  NovaAPI.SetTMPText(self._mapNode.txt_LevelTitle, self.LevelData.Name)
  local time = self.BreakOutFloorData.Time
  local score = self.BreakOutFloorData.Score
  NovaAPI.SetTMPText(self._mapNode.txt_Target, orderedFormat(ConfigTable.GetUIText("BreakOut_Act_Target") or "", time, score))
  local sDifficultType = ConfigTable.GetUIText(DifficultyState[self.LevelData.Type])
  NovaAPI.SetTMPText(self._mapNode.txt_DifficultyType, sDifficultType)
  NovaAPI.SetTMPText(self._mapNode.txt_LevelDesc, self.LevelData.Desc)
  self.tbReward = {}
  for i = 1, 4 do
    local nRewardId = self.LevelData["FirstCompleteReward" .. i .. "Tid"]
    local nRewardQty = self.LevelData["FirstCompleteReward" .. i .. "Qty"]
    if nRewardId ~= nil and 0 < nRewardId and nRewardQty ~= nil and 0 < nRewardQty then
      table.insert(self.tbReward, {nRewardId, nRewardQty})
      self._mapNode.btn_item[i].gameObject:SetActive(true)
    else
      self._mapNode.btn_item[i].gameObject:SetActive(false)
    end
  end
  self.tbBtn = self._mapNode.btnRewardItem
  local bIsComplete = self.BreakOutData:IsLevelComplete(self.nLevelId)
  for k, v in pairs(self.tbReward) do
    self._mapNode.item[k]:SetItem(v[1], nil, v[2], nil, bIsComplete)
  end
  self._mapNode.UnClick:SetActive(self.isOnDefaultClick)
  self._mapNode.CanClick:SetActive(not self.isOnDefaultClick)
end

function BreakOutLevelDetailCtrl:RefreshLevelCharacter()
  local nCharactersNumber = #self.LevelData.Characters
  for i = 1, nCharactersNumber do
    self._mapNode.btnHeadItem_[i].gameObject:SetActive(true)
    local characterNId = ConfigTable.GetData("BreakOutCharacter", self.LevelData.Characters[i]).Id
    local characterId = ConfigTable.GetData("BreakOutCharacter", self.LevelData.Characters[i]).CharId
    self:RefreshLevelCharacterState(i, characterNId, characterId)
  end
  for i = nCharactersNumber + 1, #self._mapNode.btnHeadItem_ do
    self._mapNode.btnHeadItem_[i].gameObject:SetActive(false)
  end
end

function BreakOutLevelDetailCtrl:RefreshLevelCharacterState(index, characterNId, characterId)
  local objTog = self._mapNode.btnHeadItem_[index].gameObject
  local rt_Head_Close = objTog.transform:Find("Head_Close").gameObject
  local rt_SelectIcon = objTog.transform:Find("SelectIcon").gameObject
  local rt_HeadIcon = objTog.transform:Find("img_head").gameObject
  objTog.transform:GetChild(0).name = tostring(characterNId)
  if not self.BreakOutData:CacheIsUnlocked(characterNId) then
    rt_Head_Close:SetActive(true)
    rt_SelectIcon:SetActive(false)
    rt_HeadIcon:SetActive(false)
    local txt_Tip = rt_Head_Close.transform:Find("Tip/txt_Tip"):GetComponent("TMP_Text")
    NovaAPI.SetTMPText(txt_Tip, ConfigTable.GetUIText("BreakOut_Act_CharacterUnOpen"))
  else
    rt_Head_Close:SetActive(false)
    if self.isOnDefaultClick then
      rt_SelectIcon:SetActive(false)
    elseif self.nCurrentIndex == index and self.nCurrentCharacterNid[1] == characterNId then
      rt_SelectIcon:SetActive(true)
    else
      rt_SelectIcon:SetActive(false)
    end
    local img_HeadIcon = rt_HeadIcon.transform:Find("img_headMask/img_headIcon"):GetComponent("Image")
    local sHeadPath = "head_" .. characterId .. "_QM"
    self:SetPngSprite(img_HeadIcon, "Icon/Head/" .. sHeadPath)
  end
end

function BreakOutLevelDetailCtrl:RefreshCharacterDetail()
  local DefaultDesc = self._mapNode.CharacterDetails.transform:Find("DefaultDesc"):GetComponent("CanvasGroup")
  local SpScrollView = self._mapNode.CharacterDetails.transform:Find("SpScrollView"):GetComponent("CanvasGroup")
  if self.isOnDefaultClick or self.nCurrentCharacterNid[1] == nil then
    NovaAPI.SetCanvasGroupAlpha(DefaultDesc, 1)
    NovaAPI.SetCanvasGroupAlpha(SpScrollView, 0)
  else
    NovaAPI.SetCanvasGroupAlpha(DefaultDesc, 0)
    NovaAPI.SetCanvasGroupAlpha(SpScrollView, 1)
    NovaAPI.SetTMPText(self._mapNode.txt_battleCount, self.BreakOutData:GetBattleCount(self.nCurrentCharacterNid[1]))
    local characterData = self.BreakOutData:GetDataFromBreakOutCharacter(self.nCurrentCharacterNid[1])
    if characterData == nil then
      return
    end
    local SkillData = ConfigTable.GetData("Skill", characterData.SkillId)
    local sCD = tostring(SkillData.SkillCD) .. ConfigTable.GetUIText("Talent_Sec")
    NovaAPI.SetTMPText(self._mapNode.txtValue_CD, sCD)
    NovaAPI.SetTMPText(self._mapNode.txt_SpDesc, SkillData.Desc)
    self:SetPngSprite(self._mapNode.SkillIcon, SkillData.Icon)
    NovaAPI.SetTMPText(self._mapNode.txt_name, orderedFormat(ConfigTable.GetUIText("BreakOut_Act_Name_Skill") or "", characterData.Name, SkillData.Title))
    self.BreakOutLevelDetail_Animator:Play("BreakOutLevelDetailPanel_switch", -1, 0)
  end
end

function BreakOutLevelDetailCtrl:RefreshCharacter()
  if #self.nCurrentCharacterNid == 0 then
    self.nCurrentCharacterNid[1] = 0
    self._mapNode.iconAdd:SetActive(true)
    return
  else
    self._mapNode.iconAdd:SetActive(false)
    local characterId = self.BreakOutData:GetDataFromBreakOutCharacter(self.nCurrentCharacterNid[1]).CharId
    if self.curCharacter == nil or self.curCharacter.nCharId ~= characterId then
      self:LoadCharacter(characterId, self.nCurrentCharacterNid[1], self.bOpen)
    elseif self.curCharacter ~= nil then
      NovaAPI.UnbindUIParallaxStageCameraControllerModel(self._mapNode.UIParallax3DStage, 0)
      destroy(self.curCharacter.model)
      self.curCharacter = nil
    end
  end
end

function BreakOutLevelDetailCtrl:LoadCharacter(nCharId, nCharNid, bOpen)
  if self.isOnDefaultClick then
    return
  end
  local mapSkin = self.BreakOutData:GetDataFromBreakOutCharacter(nCharNid)
  if not mapSkin then
    printLog("没有找到皮肤配置" .. nCharId)
    return
  end
  local CharacterSkinOverlapData = ConfigTable.GetData("CharacterSkinOverlap", mapSkin.CharId)
  if not CharacterSkinOverlapData then
    printLog("CharacterSkinOverlap" .. nCharId)
    return
  end
  local nBreakOut_ModelShowScale = CharacterSkinOverlapData.BreakOut_ModelShowScale ~= "" and CharacterSkinOverlapData.BreakOut_ModelShowScale or 1
  local nBreakOut_ModelShow = CharacterSkinOverlapData.BreakOut_Model_Show ~= "" and CharacterSkinOverlapData.BreakOut_Model_Show or mapSkin.Model
  local sFullPath = string.format("%s.prefab", nBreakOut_ModelShow)
  
  local function LoadModelCallback(obj)
    if self._mapNode == nil then
      return
    end
    if self.nCurrentCharacterNid[1] == nCharNid then
      if self.curCharacter ~= nil then
        NovaAPI.UnbindUIParallaxStageCameraControllerModel(self._mapNode.UIParallax3DStage, 0)
        destroy(self.curCharacter.model)
        self.curCharacter = nil
      end
      local go = instantiate(obj, self.rtSceneOriginPos)
      self.curCharacter = {nCharId = nCharId, model = go}
      NovaAPI.BindUIParallaxStageCameraControllerModel(self._mapNode.UIParallax3DStage, 0, go, true)
      if self.rtSceneOriginPos ~= nil then
        go.transform.position = self.rtSceneOriginPos.position
        go.transform.localEulerAngles = Vector3(0, 180, 0)
        go.transform.localScale = Vector3.zero
        GameUIUtils.SetCustomModelMaterialVariant(go, CS.CustomModelMaterialVariantComponent.VariantNames.FormationView)
        
        local function wait()
          coroutine.yield(CS.UnityEngine.WaitForEndOfFrame())
          go.transform.localScale = Vector3.one * (nBreakOut_ModelShowScale / 10000)
        end
        
        cs_coroutine.start(wait)
      end
      if not bOpen then
        self:PlayChangeFx()
      end
    end
  end
  
  self:LoadAssetAsync(sFullPath, typeof(GameObject), LoadModelCallback)
end

function BreakOutLevelDetailCtrl:PlayChangeFx()
  GameUIUtils.RestartParticle(self._mapNode.fxChange)
end

function BreakOutLevelDetailCtrl:OnBtn_ClickCharacterItem(btn, nIndex)
  local characterNId = tonumber(btn.gameObject.transform:GetChild(0).name)
  if not self.BreakOutData:CacheIsUnlocked(characterNId) then
    return
  end
  if self.isOnDefaultClick or self.nCurrentIndex ~= nIndex or self.nCurrentCharacterNid[1] ~= characterNId then
    self.nCurrentIndex = nIndex
    self.isOnDefaultClick = false
    self.nCurrentCharacterNid[1] = characterNId
    self:Refresh()
  end
end

function BreakOutLevelDetailCtrl:OnBtnClick_RewardItem(btn, nIndex)
  local nRewardId
  if self.tbReward ~= nil and self.tbReward[nIndex] ~= nil then
    nRewardId = self.tbReward[nIndex][1]
  end
  if nRewardId ~= nil then
    UTILS.ClickItemGridWithTips(nRewardId, btn.transform, true, true, false)
  end
end

function BreakOutLevelDetailCtrl:OnBtn_Go()
  if self.isOnDefaultClick or self.nCurrentCharacterNid[1] == nil or self.nCurrentCharacterNid[1] == 0 then
    local sTip = ConfigTable.GetUIText("BreakOut_Act_DefaultDesc")
    EventManager.Hit(EventId.OpenMessageBox, sTip)
    return
  end
  self.isOnDefaultClick = true
  local sChar = tostring(self.nCurrentCharacterNid[1])
  local param = {}
  table.insert(param, sChar)
  self.BreakOutData.BreakOutLevelData:InitData(self.nLevelId, self.nCurrentCharacterNid[1], self.nActId)
  CS.AdventureModuleHelper.EnterBrickBreakerLevel(self.LevelData.FloorId, param)
  NovaAPI.EnterModule("AdventureModuleScene", true, 17)
end

function BreakOutLevelDetailCtrl:Event_ReStartGoPlay(tempData)
  local sChar = tostring(tempData.curChar)
  local param = {}
  table.insert(param, sChar)
  self.BreakOutData.BreakOutLevelData:InitData(tempData.nLevelId, tempData.curChar, tempData.nActId)
  CS.AdventureModuleHelper.EnterBrickBreakerLevel(tempData.FloorId, param)
  NovaAPI.EnterModule("AdventureModuleScene", true, 17)
end

function BreakOutLevelDetailCtrl:Set_DefaultCharacter()
  local nCharactersNumber = #self.LevelData.Characters
  if nCharactersNumber == 1 then
    self.nCurrentIndex = nCharactersNumber
    self.isOnDefaultClick = false
    self.nCurrentCharacterNid[1] = ConfigTable.GetData("BreakOutCharacter", self.LevelData.Characters[nCharactersNumber]).Id
  end
end

function BreakOutLevelDetailCtrl:OnBtnClick_EnemyInfo()
  EventManager.Hit("OpenActivityLevelsMonsterInfo", self.PreviewMonsterGroupId)
end

return BreakOutLevelDetailCtrl
