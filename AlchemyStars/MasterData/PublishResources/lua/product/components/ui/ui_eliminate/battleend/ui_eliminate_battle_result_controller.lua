_class("UIEliminateBattleResultController", UIController)
UIEliminateBattleResultController = UIEliminateBattleResultController

function UIEliminateBattleResultController:OnShow(uiParams)
  self._dialogLeftGO = self:GetGameObject("DialogLeft")
  self._dialogRightGO = self:GetGameObject("DialogRight")
  self._dialogLeftTxt = self:GetUIComponent("UILocalizationText", "DialogTextLeft")
  self._dialogRightTxt = self:GetUIComponent("UILocalizationText", "DialogTextRight")
  self._scoreTxt = self:GetUIComponent("UILocalizationText", "score")
  self._completetitle = self:GetUIComponent("RawImageLoader", "completetitle")
  self._completeen = self:GetUIComponent("RawImageLoader", "completeen")
  self._imgComplete = self:GetUIComponent("RawImageLoader", "imgComplete")
  self._completeenObj = self:GetGameObject("completeen")
  local eng = HelperProxy:GetInstance():IsInEnglish()
  self._completeenObj:SetActive(not eng)
  self._isWin = uiParams[1]
  self._levelIndex = uiParams[2]
  local matchEnterData = self:GetModule(MatchModule):GetMatchEnterData()
  local localPlayerInfo = matchEnterData:GetLocalPlayerInfo()
  local petID = localPlayerInfo.pet_list[1].pet_pstid
  local petModule = self:GetModule(PetModule)
  self._petData = petModule:GetPet(petID)
  self._petListData = localPlayerInfo.pet_list
  self._matchPetData = {}
  for i = 1, #self._petListData do
    self._matchPetData[i] = MatchPet:New(self._petListData[i])
  end
  local gameMatchModule = self:GetModule(GameMatchModule)
  local matchResult = UI_MatchResult:New()
  matchResult = gameMatchModule:GetMachResult()
  self._itemTab = matchResult.m_vecAwardNormal
  self._scoreTxt:SetText(matchResult._starNum)
  self._selectItemInfoPool = self:GetUIComponent("UISelectObjectPath", "ItemInfoPool")
  self._selectItemInfo = self._selectItemInfoPool:SpawnObject("UISelectInfo")
  self:AttachEvent(GameEventType.ShowItemTips, self.ShowItemTips)
  self:InitAwards()
  self:PlayAudio()
  self:TalkMsg()
  self:StaticBody()
  self:_SetStatisticsBtn()
  local funcModule = self:GetModule(RoleModule).uiModule
  funcModule:LockAchievementFinishPanel(false)
end

function UIEliminateBattleResultController:OnHide()
  self:DetachEvent(GameEventType.ShowItemTips, self.ShowItemTips)
  GameGlobal:GetInstance():ExitCoreGame()
end

function UIEliminateBattleResultController:InitAwards()
  self._itemPool = self:GetUIComponent("UISelectObjectPath", "Items")
  local itemTabCount = table.count(self._itemTab)
  Log.debug("[error] mazeResult --> itemTabCount is " .. itemTabCount .. " !")
  self._itemPool:SpawnObjects("UIWidgetResultReward", itemTabCount)
  local items = self._itemPool:GetAllSpawnList()
  local itemCfg = Cfg.cfg_item
  for i = 1, itemTabCount do
    local roleAsset = self._itemTab[i]
    Log.debug("[error] mazeResult --> index is " .. i .. " roleAsset.assetid is " .. roleAsset.assetid .. " !")
    items[i]:Init(roleAsset.count, roleAsset.assetid, false)
  end
end

function UIEliminateBattleResultController:TalkMsg()
  local cfg
  local phraseId = self._petData:GetSkinId()
  cfg = Cfg.pet_phrase[phraseId]
  if not cfg then
    phraseId = self._petData:GetTemplateID()
    cfg = Cfg.pet_phrase[phraseId]
  end
  if cfg == nil then
    Log.fatal("### cfg_pet_phrase is nil ! id --> ", phraseId)
  end
  if cfg.Dir == nil then
    Log.fatal("### cfg_pet_phrase Dir is nil ! id --> ", phraseId)
  end
  local left = cfg.Dir == 0
  local useDialogTxt = left and self._dialogLeftTxt or self._dialogRightTxt
  if cfg.Pos == nil then
    Log.fatal("### cfg_pet_phrase Pos is nil ! id --> ", phraseId)
  end
  local pos = cfg.Pos
  local posTbl = table.tonumber(string.split(pos, "|"))
  if left then
    self._dialogLeftGO.transform.localPosition = Vector2(posTbl[1], posTbl[2])
  else
    self._dialogRightGO.transform.localPosition = Vector2(posTbl[1], posTbl[2])
  end
  self._dialogLeftGO:SetActive(left)
  self._dialogRightGO:SetActive(not left)
  local str = self._isWin and cfg.CompletePhrase or cfg.FailPhrase
  useDialogTxt:SetText(HelperProxy:GetInstance():ReplacePlayerName(StringTable.Get(str)))
  local csf = useDialogTxt.transform.parent:GetComponent("ContentSizeFitter")
  local rect = useDialogTxt.rectTransform.parent:GetComponent("RectTransform")
  local textWidth = 570
  if textWidth <= useDialogTxt.preferredWidth then
    csf.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.Unconstrained
    rect.sizeDelta = Vector2(textWidth, rect.sizeDelta.y)
  else
    csf.horizontalFit = UnityEngine.UI.ContentSizeFitter.FitMode.PreferredSize
  end
  if self._isWin then
    self._imgComplete:LoadImage("thread_shengli_frame16")
    self._completetitle:LoadImage("world_tiaozhan_tu13")
    self._completeen:LoadImage("world_tiaozhan_tu14")
  else
    self._imgComplete:LoadImage("thread_shengli_frame17")
    self._completetitle:LoadImage("thread_shengli_chara7")
    self._completeen:LoadImage("thread_shengli_chara8")
  end
end

function UIEliminateBattleResultController:StaticBody()
  self._goCG = self:GetGameObject("imgRole").transform
  self._imgRole = self:GetUIComponent("MultiplyImageLoader", "imgRole")
  local cg = self._petData:GetPetBattleResultCG(PetSkinEffectPath.BODY_BATTLE_RESULT)
  cg = cg or self._petData:GetPetStaticBody(PetSkinEffectPath.BODY_BATTLE_RESULT)
  self._imgRole:Load(cg, "white")
  UICG.SetTransform(self._goCG, "UIBattleResultComplete", cg)
end

function UIEliminateBattleResultController:PlayAudio()
  local tplID = self._petData:GetTemplateID()
  local pm = GameGlobal.GetModule(PetAudioModule)
  pm:PlayPetAudio("BattleSucceed", tplID)
end

function UIEliminateBattleResultController:BgOnClick()
  GameGlobal:GetInstance():ExitCoreGame()
  local anipopModule = GameGlobal.GetModule(AnipopModule)
  local anipopInfo = anipopModule:GetAniPopInfo()
  local roundInfo = anipopInfo.round_info
  local levelInfo = roundInfo.level_list[roundInfo.mission_index]
  if not anipopInfo or not levelInfo then
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIEliminateController)
    ToastManager.ShowToast(StringTable.Get("str_pet_config_pet_error_faild19"))
    return
  end
  if self._isWin then
    if self._levelIndex == table.count(roundInfo.level_list) then
      GameGlobal.UIStateManager():SwitchState(UIStateType.UIEliminateController, true, true)
    else
      GameGlobal.UIStateManager():SwitchState(UIStateType.UIEliminateLevelController)
    end
  else
    GameGlobal.UIStateManager():SwitchState(UIStateType.UIEliminateController, true)
  end
end

function UIEliminateBattleResultController:ShowItemTips(itemID, pos)
  self._selectItemInfo:SetData(itemID, pos)
end

function UIEliminateBattleResultController:_SetStatisticsBtn()
  local isShow = true
  local btnGo = self:GetGameObject("StatisticsBtnRoot")
  if btnGo then
    btnGo:SetActive(isShow)
  end
end

function UIEliminateBattleResultController:StatisticsBtnOnClick(go)
  self:ShowDialog("UIBattleStatistics", self._matchPetData)
end
