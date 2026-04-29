_class("UILuckLandMainGameController", UIController)
UILuckLandMainGameController = UILuckLandMainGameController

function UILuckLandMainGameController:LoadDataOnEnter(TT, res)
  res:SetSucc(true)
end

function UILuckLandMainGameController:OnShow(uiParams)
  self._showSpeed = 1.5
  self.missId = uiParams[1]
  self._guideID = 138004
  self._guideID2 = 138005
  self._guideModule = GameGlobal.GetModule(GuideModule)
  self.curCardDataList = LuckLandData:GetInstance():CurCardDatas()
  self.curBuildDataLevel = LuckLandData:GetInstance():CurBuildingDatas()
  self:InitWidget()
  self:InitUI()
  self:AttachEvent(GameEventType.OnLuckLandDeleteCardSucc, self._OnLuckLandDeleteCardSucc)
end

function UILuckLandMainGameController:OnHide()
  self:DetachEvent(GameEventType.OnLuckLandDeleteCardSucc, self._OnLuckLandDeleteCardSucc)
  if self.taskid then
    GameGlobal.TaskManager():KillTask(self.taskid)
    self.taskid = nil
  end
  if self.taskMoneyid then
    GameGlobal.TaskManager():KillTask(self.taskMoneyid)
    self.taskMoneyid = nil
  end
end

function UILuckLandMainGameController:_OnLuckLandDeleteCardSucc()
  self:RefreshGameData()
end

function UILuckLandMainGameController:InitWidget()
  self._anim = self:GetGameObject("_anim")
  self.backBtns = UIWidgetHelper.SpawnObject(self, "backBtns", "UINewCommonTopButton")
  self.setView = self:GetGameObject("SetView")
  self.continueGameText = self:GetUIComponent("UILocalizationText", "ContinueGameText")
  self.exitGameText = self:GetUIComponent("UILocalizationText", "ExitGameText")
  self.buildArea = self:GetUIComponent("UISelectObjectPath", "BuildArea")
  self.moneyText = self:GetUIComponent("UILocalizationText", "MoneyText")
  self.heartText = self:GetUIComponent("UILocalizationText", "HeartText")
  self.heartRootRectT = self:GetUIComponent("RectTransform", "Heart")
  self.rollBtnText = self:GetUIComponent("UILocalizationText", "RollBtnText")
  self.morningCardArea = self:GetUIComponent("UISelectObjectPath", "MorningCardArea")
  self.noonCardArea = self:GetUIComponent("UISelectObjectPath", "NoonCardArea")
  self.nightCardArea = self:GetUIComponent("UISelectObjectPath", "NightCardArea")
  self.enemyTotalAtkText = self:GetUIComponent("UILocalizationText", "EnemyTotalAtkText")
  self.nextEnemyGoText = self:GetUIComponent("UILocalizationText", "NextEnemyGoText")
  self.gamePlayTurnCountText = self:GetUIComponent("UILocalizationText", "GamePlayTurnCountText")
  self.enemyList = self:GetUIComponent("UISelectObjectPath", "EnemyList")
  self.redyEnemy = self:GetUIComponent("UISelectObjectPath", "RedyEnemy")
  self.redyEnemyObj = self:GetGameObject("RedyEnemy")
  self.enemyListBeginObj = self:GetGameObject("EnemyListBegin")
  self.EnemyListBeginRectT = self:GetUIComponent("RectTransform", "EnemyListBegin")
  self.AtkTargetRectT = self:GetUIComponent("RectTransform", "AtkTarget")
  self.OriginAtkRectT = self:GetUIComponent("RectTransform", "OriginAtk")
  self.showPhaseObj = self:GetGameObject("ShowPhase")
  self.playerCalcuPhaseObj = self:GetGameObject("PlayerCalcuPhase")
  self.showAtkObj = self:GetGameObject("ShowAtk")
  self.showAtkRectT = self:GetUIComponent("RectTransform", "ShowAtk")
  self.showMoneyObj = self:GetGameObject("ShowMoney")
  self.showRecoverObj = self:GetGameObject("ShowRecover")
  self.showAtkText = self:GetUIComponent("UILocalizationText", "ShowAtkText")
  self.showMoneyText = self:GetUIComponent("UILocalizationText", "ShowMoneyText")
  self.showRecoverText = self:GetUIComponent("UILocalizationText", "ShowRecoverText")
  self.moneyEffObj = self:GetGameObject("MoneyEff")
  self.atkEffObj = self:GetGameObject("AtkEff")
  self.recoverEffObj = self:GetGameObject("RecoverEff")
  self:InitPlayCalcuUI()
  self.speedToggleBackgroundImage = self:GetUIComponent("Image", "SpeedToggleBackground")
  self.monsterAtkEffObj = self:GetGameObject("MonsterAtkEff")
  self.monsterAtkEffObj:SetActive(false)
  self.topUnCtrlObj = self:GetGameObject("TopUnCtrl")
  self.topUnCtrlObj:SetActive(false)
  self.speedtoggle = self:GetUIComponent("Toggle", "SpeedToggle")
  self._moneyAnim = self:GetUIComponent("Animation", "Money")
  self._canPlaySpeedClickAudio = false
  
  function self.OnSpeedToggleValueChanged(isOn)
    if self._canPlaySpeedClickAudio then
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
    end
    self._canPlaySpeedClickAudio = true
    local key = "LuckLandSpeed"
    if isOn then
      self._showSpeed = 0.75
      self.speedToggleBackgroundImage.color = Color(1, 1, 1, 0)
      LocalDB.SetInt(key, 1)
    else
      self._showSpeed = 1.5
      self.speedToggleBackgroundImage.color = Color(1, 1, 1, 1)
      LocalDB.SetInt(key, 0)
    end
  end
  
  self.speedtoggle.onValueChanged:AddListener(self.OnSpeedToggleValueChanged)
  local key = "LuckLandSpeed"
  if LocalDB.HasKey(key) then
    local value = LocalDB.GetInt(key, 0)
    if value == 0 then
      self._showSpeed = 1.5
      self.speedtoggle.isOn = false
      self.speedToggleBackgroundImage.color = Color(1, 1, 1, 1)
    else
      self._showSpeed = 0.75
      self.speedtoggle.isOn = true
      self.speedToggleBackgroundImage.color = Color(1, 1, 1, 0)
    end
  else
    self.speedtoggle.isOn = false
  end
  self.cardDetailtoggle = self:GetUIComponent("Toggle", "CardDetailToggle")
  self._canPlayCradClickAudio = false
  
  function self.OnCardDetailToggleValueChanged(isOn)
    if self._canPlayCradClickAudio then
      AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundDefaultClick)
    end
    self._canPlayCradClickAudio = true
    for i = 1, #self.cardAreaList do
      local card = self.cardAreaList[i]
      card:RefreshDetailMod(isOn)
    end
  end
  
  self.cardDetailtoggle.onValueChanged:AddListener(self.OnCardDetailToggleValueChanged)
  self.flyPosTf = self:GetUIComponent("RectTransform", "FlyPos")
  self.addMoneyText = self:GetUIComponent("UILocalizationText", "AddMoneyText")
end

function UILuckLandMainGameController:InitUI()
  self._missionId = self.missId
  self.backBtns:SetData(function()
    PopupManager.Alert("UICommonMessageBox", PopupPriority.Normal, PopupMsgBoxType.OkCancel, "", StringTable.Get("str_luckland_back_tips"), function(param)
      GameGlobal.UIStateManager():CloseDialog("UILuckLandLevelInfo")
      self:CloseDialog()
    end, nil, nil, nil)
  end, function()
    self:ShowDialog("UIIntroLoader", "UILuckLandMainGameController")
  end, nil, true, nil, false, nil)
  self._curMissionCfg = Cfg.cfg_luckland_client_mission[self._missionId]
  if self._curMissionCfg == nil then
    Log.error("cfg_luckland_client_mission is nil" .. self._missionId)
    return
  end
  GameGlobal:EnterLuckLandGame(self._missionId)
  self:InitGameData()
  self:InitCardArea()
  self:InitBuildArea()
  self:InitEnemyArea()
  self:RefreshGameData()
  self:_CheckGuide()
  self:InitGuideUI()
  self.flyItemList = UIWidgetHelper.SpawnObjects(self, "FlyPos", "UILuckLandFlyItem", 12)
  for i = 1, #self.flyItemList do
    local item = self.flyItemList[i]
    item.view:GetGameObject():SetActive(false)
  end
end

function UILuckLandMainGameController:InitCardArea()
  local moringCount, noonCount, nightCount = 3, 5, 4
  local camplevel, data = self.curBuildDataLevel:CampFireBuildLevel()
  local maxLevel = 5
  local allCount = moringCount + noonCount + nightCount
  self.curRoundCardList = {}
  self.cardAreaList = UIWidgetHelper.SpawnObjects(self, "MorningCardArea", "UILuckLandSingleCard", allCount)
  for i = 1, #self.cardAreaList do
    local item = self.cardAreaList[i]
    if i < allCount - maxLevel + camplevel + 1 then
      local data = self.curCardDataList:DrawCard(self.curRoundCardList)
      self.curRoundCardList[#self.curRoundCardList + 1] = data
      item:SetData(nil)
      item.view:GetGameObject():SetActive(true)
    else
      local data = self.curCardDataList:DrawCard(self.curRoundCardList)
      self.curRoundCardList[#self.curRoundCardList + 1] = data
      item:SetData(data)
      item.view:GetGameObject():SetActive(true)
      item:SetLockCard()
    end
    item:SetPosIndex(i)
  end
  self.cardDetailtoggle.isOn = false
end

function UILuckLandMainGameController:InitBuildArea()
  local maxBuild = 6
  local buildCount = self.curBuildDataLevel:TotalCount()
  self.buildAreaList = UIWidgetHelper.SpawnObjects(self, "BuildArea", "UILuckLandBuildItem", maxBuild)
  for i = 1, #self.buildAreaList do
    if buildCount >= i then
      local item = self.buildAreaList[i]
      item:SetData(self.curBuildDataLevel:GetBuildDataByIndex(i), function(levelup, buildingType)
        self:RefreshGameData()
        self:BuildLevelUnLockCardPool()
        if buildingType == LuckLandBuildingType.Main and levelup then
          self:ShowDialog("UILuckLandSelectCardPopUp", function()
            self:RefreshGameData()
          end)
        end
      end)
    end
  end
end

function UILuckLandMainGameController:ShowBuild(show)
  if self.buildAreaList then
    for _, build in pairs(self.buildAreaList) do
      build:ShowBuild(show)
    end
  end
end

function UILuckLandMainGameController:_ParseRoundMonsters(roundMonsterStrArray)
  local roundMonstersDic = {}
  for _, strVal in ipairs(roundMonsterStrArray) do
    local strArray = string.split(strVal, "|")
    if #strArray < 2 then
      Log.exception("[LuckLand] ParseRoundMonsters size error, roundMonsters = ", strVal)
      return
    end
    local round = tonumber(strArray[1])
    local monsterIDList = {}
    for i = 2, #strArray do
      monsterIDList[#monsterIDList + 1] = strArray[i]
    end
    roundMonstersDic[round] = monsterIDList
  end
  return roundMonstersDic
end

local toint = math.tointeger

function UILuckLandMainGameController:InitEnemyArea()
  local entityList = LuckLandInnerGameHelper.GetFightMonsterData()
  local list = {}
  for i = 1, #entityList do
    local entity = entityList[i]
    local LuckLandEnemyData = LuckLandEnemyData:New()
    LuckLandEnemyData:Init(entity)
    list[#list + 1] = LuckLandEnemyData
  end
  local totalAtk = 0
  self.enemyAreaList = UIWidgetHelper.SpawnObjects(self, "EnemyList", "UILuckLandEnemyItem", #list)
  for i = 1, #self.enemyAreaList do
    local data = list[i]
    local item = self.enemyAreaList[i]
    item:SetData(data, i, self.enemyListBeginObj.transform, function()
      self:RefreshEnemyArea()
    end)
    totalAtk = totalAtk + item:GetDemandMoney()
  end
  local redyEntity = LuckLandInnerGameHelper.GetNextMonster()
  self.redyEnemyList = UIWidgetHelper.SpawnObjects(self, "RedyEnemy", "UILuckLandEnemyItem", 1)
  local round = redyEntity:GetDemandRound()
  local curRound, maxRound = LuckLandInnerGameHelper.GetCurRoundCount()
  local m_luckLandEnemyData = LuckLandEnemyData:New()
  m_luckLandEnemyData:Init(redyEntity)
  self.redyEnemyList[1]:SetData(m_luckLandEnemyData, 1, self.redyEnemyObj.transform, function()
    self:RefreshEnemyArea()
  end)
  self.redyEnemyList[1]:SetReadyEnemy()
  self.enemyTotalAtkText:SetText("" .. totalAtk)
  local leftCount = LuckLandInnerGameHelper.GetLeftMonstersCount()
  self.nextEnemyGoText:SetText(StringTable.Get("str_luckland_some_round_enter", leftCount))
end

function UILuckLandMainGameController:RefreshEnemyArea()
  for i = 1, #self.enemyAreaList do
    local item = self.enemyAreaList[i]
    item:CloseTipsBg()
  end
  local readyItem = self.redyEnemyList[1]
  if readyItem then
    readyItem:CloseTipsBg()
  end
end

function UILuckLandMainGameController:RefreshNextEnemyList(nextRoundID)
  local entityList = LuckLandInnerGameHelper.GetFightMonsterData()
  local list = {}
  for i = 1, #entityList do
    local entity = entityList[i]
    local LuckLandEnemyData = LuckLandEnemyData:New()
    LuckLandEnemyData:Init(entity)
    list[#list + 1] = LuckLandEnemyData
  end
  local totalAtk = 0
  local curMonsterIndex = 0
  self.enemyAreaList = UIWidgetHelper.SpawnObjects(self, "EnemyList", "UILuckLandEnemyItem", #list)
  for i = 1, #self.enemyAreaList do
    local data = list[i]
    local item = self.enemyAreaList[i]
    if not data:GetEnemyEntity():IsDead() then
      curMonsterIndex = curMonsterIndex + 1
      item:SetData(data, curMonsterIndex, self.enemyListBeginObj.transform, function()
        self:RefreshEnemyArea()
      end)
      totalAtk = totalAtk + item:GetDemandMoney()
    else
      item:SetData(data, -1, self.enemyListBeginObj.transform)
    end
  end
  local redyEntity = LuckLandInnerGameHelper.GetNextMonster()
  if redyEntity == nil then
    self.nextEnemyGoText:SetText(StringTable.Get("str_luckland_no_enemy"))
    self.redyEnemyObj:SetActive(false)
    return
  end
  local round = redyEntity:GetDemandRound()
  self.redyEnemyList = UIWidgetHelper.SpawnObjects(self, "RedyEnemy", "UILuckLandEnemyItem", 1)
  local curRound, maxRound = LuckLandInnerGameHelper.GetCurRoundCount()
  local m_luckLandEnemyData = LuckLandEnemyData:New()
  m_luckLandEnemyData:Init(redyEntity)
  self.redyEnemyList[1]:SetData(m_luckLandEnemyData, 1, self.redyEnemyObj.transform, function()
    self:RefreshEnemyArea()
  end)
  self.redyEnemyList[1]:SetReadyEnemy()
  self.enemyTotalAtkText:SetText("" .. totalAtk)
  local leftCount = LuckLandInnerGameHelper.GetLeftMonstersCount()
  self.nextEnemyGoText:SetText(StringTable.Get("str_luckland_some_round_enter", leftCount))
end

function UILuckLandMainGameController:InitGameData()
  self.luckLandGameData = LuckLandData:GetInstance():CurGameData()
  self.luckLandGameData:Init(self._curMissionCfg)
end

function UILuckLandMainGameController:RefreshGameData()
  for i = 1, #self.buildAreaList do
    local item = self.buildAreaList[i]
    item:RefreshBuildUI()
  end
  local money = LuckLandInnerGameHelper.GetCurMoney()
  local curHp, maxHp = LuckLandInnerGameHelper.GetCurHP()
  local curRound, maxRound = LuckLandInnerGameHelper.GetCurRoundCount()
  local lessRound = maxRound - curRound + 1
  self.gamePlayTurnCountText:SetText("" .. curRound)
  if self.curBeyondMoney ~= money then
    if self.curBeyondMoney == nil then
      self.curBeyondMoney = 0
      self.moneyText:SetText("0")
    end
    self.taskMoneyid = self:StartTask(self.RefreshMoneyAnim, self, self.curBeyondMoney, money)
  end
  self.curBeyondMoney = money
  local str = curHp .. "/" .. maxHp
  self.heartText:SetText(str)
end

function UILuckLandMainGameController:RefreshMoneyAnim(pp, curMoney, targetMoney)
  local delta = targetMoney - curMoney
  local count = 4
  local deltaSingle = delta / count
  if curMoney == targetMoney then
    self.taskMoneyid = nil
    return
  end
  self.addMoneyText.gameObject:SetActive(true)
  if 0 < delta then
    self.addMoneyText:SetText("+" .. delta)
  elseif delta < 0 then
    self.addMoneyText:SetText("" .. delta)
  end
  for i = 1, count do
    curMoney = curMoney + deltaSingle
    local moneyCeil = math.ceil(curMoney)
    if 0 < deltaSingle and targetMoney < moneyCeil then
      moneyCeil = targetMoney
    end
    if deltaSingle < 0 and moneyCeil < 0 then
      moneyCeil = 0
    end
    self.moneyText:SetText(moneyCeil)
    YIELD(TT, 50 * self._showSpeed)
  end
  self.addMoneyText.gameObject:SetActive(false)
  self.taskMoneyid = nil
end

function UILuckLandMainGameController:RefrenshRollPlay(TT)
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundBattleComplete)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.LuckLandRoundStart)
  self.topUnCtrlObj:SetActive(true)
  self:InitPlayCalcuUI()
  self:EmptyAllCard()
  YIELD(TT, 300 * self._showSpeed)
  local camplevel, data = self.curBuildDataLevel:CampFireBuildLevel()
  local maxLevel = 5
  self.curRoundCardList = {}
  local entityMgr = LuckLandInnerGameHelper.GetEntityMgr()
  local petEntities = {}
  local finalPetEntities = {}
  if entityMgr then
    finalPetEntities = entityMgr:GetFightPets()
    petEntities = entityMgr:GetFightPetEnterList()
  end
  for i = 1, #self.cardAreaList do
    local item = self.cardAreaList[i]
    item:SetPosIndex(i)
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.LuckLandCardShow)
  self.moveList = {}
  for i = 1, #self.cardAreaList do
    local item = self.cardAreaList[i]
    if i >= #self.cardAreaList - maxLevel + camplevel + 1 then
      item:SetLockCard()
      item:SetBindEntity(nil)
    elseif petEntities[i] then
      local templateID = petEntities[i]:GetTemplateID()
      local data = UILuckLandCardData:New(nil, templateID)
      item:SetData(data, false, true)
      item:SetBindEntity(petEntities[i], true)
      Log.debug("[fx luckland]:data:", StringTable.Get(data:Cfg().CardName), "   entity:", StringTable.Get(petEntities[i]._cfg:GetPetName()))
      item.view:GetGameObject():SetActive(true)
      YIELD(TT, 50 * self._showSpeed)
      if petEntities[i]:GetTempMove() then
        local tempMove = petEntities[i]:GetTempMove()
        if tempMove == LuckLandConst.BVK_MoveToFirst then
          table.insert(self.moveList, 1, item)
          for jk = 1, #self.moveList do
            local moveItem = self.moveList[jk]
            moveItem:MovePos(jk)
          end
        end
        if tempMove == LuckLandConst.BVK_MoveToLast then
          self.moveList[#self.moveList + 1] = item
        end
        YIELD(TT, 500 * self._showSpeed)
      else
        self.moveList[#self.moveList + 1] = item
      end
    else
      item:SetEmptyCard()
      item:SetBindEntity(nil)
    end
  end
  for i = 1, #self.moveList do
    local item = self.moveList[i]
    if i >= #self.cardAreaList - maxLevel + camplevel + 1 then
    elseif item:GetBindEntity() ~= nil then
      item:SkillShow()
      YIELD(TT, 50 * self._showSpeed)
    end
  end
  if self._guideModule:IsGuideProcess(self._guideID) then
    while not self:_GuideStepIsDone(self._guideID, 3) do
      YIELD(TT)
    end
  end
  local needWaitBuild = false
  for i = 1, #self.buildAreaList do
    local item = self.buildAreaList[i]
    local need = item:ShowMoney()
    if need then
      needWaitBuild = need
    end
  end
  if needWaitBuild then
    YIELD(TT, 500 * self._showSpeed)
  end
  local money, atk, recover = self:CalcuRoundRes()
  local calcuMoney = 0
  if 0 < atk then
    if self.speedtoggle.isOn then
      self:ShowDialog("UILuckLandPetAtkPopUp", 2)
    else
      self:ShowDialog("UILuckLandPetAtkPopUp", 1)
    end
    AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundGetItem)
    while not GameGlobal.UIStateManager():IsShow("UILuckLandPetAtkPopUp") do
      YIELD(TT)
    end
    GameGlobal.EventDispatcher():Dispatch(GameEventType.LuckLandResColl, atk)
    self.showAtkRectT.anchoredPosition = self.OriginAtkRectT.anchoredPosition
    YIELD(TT, 1000 * self._showSpeed)
    GameGlobal.UIStateManager():CloseDialog("UILuckLandPetAtkPopUp")
    self.showAtkObj:SetActive(true)
    local pos = self.AtkTargetRectT.anchoredPosition
    self.showAtkRectT:DOAnchorPos(pos, 0.3, true)
    YIELD(TT, 300 * self._showSpeed)
    self.showAtkObj:SetActive(false)
    self.EnemyListBeginRectT:DOPunchAnchorPos(Vector3(0, 50, 0), 0.2, 2)
    self.EnemyListBeginRectT:DOPunchScale(Vector3(0, 0.15, 0), 0.2, 5)
    YIELD(TT, 100 * self._showSpeed)
    for i = 1, #self.enemyAreaList do
      local enemy = self.enemyAreaList[i]
      if not enemy:GetDead() then
        enemy:SetBeAtkDemand(atk)
      end
    end
    YIELD(TT, 200 * self._showSpeed)
  end
  AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.SoundGetItem)
  if self.speedtoggle.isOn then
    self:ShowDialog("UILuckLandResCalcuPopUp", 2)
  else
    self:ShowDialog("UILuckLandResCalcuPopUp", 1)
  end
  while not GameGlobal.UIStateManager():IsShow("UILuckLandResCalcuPopUp") do
    YIELD(TT)
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.LuckLandResColl, money)
  YIELD(TT, 1000 * self._showSpeed)
  self._moneyAnim:Play("uieff_UILuckLandResCalcuPopUp_jiesuan")
  YIELD(TT, 120 * self._showSpeed)
  self:RefreshGameData()
  YIELD(TT, 100 * self._showSpeed)
  GameGlobal.UIStateManager():CloseDialog("UILuckLandResCalcuPopUp")
  self:InitPlayCalcuUI()
  for i = 1, #self.enemyAreaList do
    local enemy = self.enemyAreaList[i]
    if not enemy:GetDead() then
      local round = enemy:GetDemandRound()
      local roundMoney = enemy:GetDemandMoney()
      local curMoney = LuckLandInnerGameHelper.GetCurMoney()
      if round == 0 then
        if roundMoney < curMoney and self._guideModule:IsGuideDone(self._guideID) then
          GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UILuckLandMainGameController2)
          YIELD(TT)
          if self._guideModule:IsGuideProcess(self._guideID2) then
            while not self:_GuideStepIsDone(self._guideID2, 1) do
              YIELD(TT)
            end
          end
          if self._guideModule:IsGuideProcess(self._guideID2) then
            while not self:_GuideStepIsDone(self._guideID2, 2) do
              YIELD(TT)
            end
          end
        end
        self._moneyAnim:Stop()
        if roundMoney <= curMoney then
          enemy:SetGetedDemand(roundMoney)
          YIELD(TT, 250 * self._showSpeed)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.LuckLandMonsterTurn)
          self._moneyAnim:Play("uieff_UILuckLandResCalcuPopUp_boss")
          YIELD(TT, 400 * self._showSpeed)
          self:RefreshGameData()
          enemy:DeadShow()
          AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.N5ShowBuilding)
          YIELD(TT, 250 * self._showSpeed)
        else
          enemy:SetGetedDemand(curMoney)
          YIELD(TT, 250 * self._showSpeed)
          YIELD(TT, 150 * self._showSpeed)
          AudioHelperController.PlayUISoundAutoRelease(CriAudioIDConst.LuckLandMonsterFight)
          self.monsterAtkEffObj:SetActive(false)
          self.monsterAtkEffObj:SetActive(true)
          YIELD(TT, 500 * self._showSpeed)
          self.heartRootRectT:DOPunchScale(Vector3(0.3, 0.3, 0.3), 0.25 * self._showSpeed, 3)
          GameGlobal.EventDispatcher():Dispatch(GameEventType.LuckLandMonsterTurn)
          self:RefreshGameData()
          YIELD(TT, 200 * self._showSpeed)
          self._moneyAnim:Play("uieff_UILuckLandResCalcuPopUp_boss")
          YIELD(TT, 400 * self._showSpeed)
        end
      else
        GameGlobal.EventDispatcher():Dispatch(GameEventType.LuckLandMonsterTurn)
      end
    else
    end
  end
  local curRound, maxRound = LuckLandInnerGameHelper.GetCurRoundCount()
  YIELD(TT, 250 * self._showSpeed)
  self:RefreshNextEnemyList(curRound + 1)
  self:RefreshGameData()
  YIELD(TT, 250 * self._showSpeed)
  local curHp, maxHp = LuckLandInnerGameHelper.GetCurHP()
  if curHp <= 0 then
    self:ShowDialog("UILuckLandGameEndPopUp", function()
      self:RestartGame()
    end)
    self.topUnCtrlObj:SetActive(false)
    self.taskid = nil
    return
  end
  local leftMonsterCount = LuckLandInnerGameHelper.GetLeftMonstersCount()
  local allDead = true
  for i = 1, #self.enemyAreaList do
    local enemy = self.enemyAreaList[i]
    if not enemy:GetDead() then
      allDead = false
    end
  end
  if leftMonsterCount == 0 and allDead then
    self:ShowDialog("UILuckLandGameSucPopUp")
    self.taskid = nil
    YIELD(TT)
    return
  end
  if self._guideModule:IsGuideProcess(self._guideID) then
    while not self:_GuideStepIsDone(self._guideID, 4) do
      YIELD(TT)
    end
  end
  if self._guideModule:IsGuideProcess(self._guideID2) then
    while not self:_GuideStepIsDone(self._guideID2, 2) do
      YIELD(TT)
    end
    self:ShowBuild(true)
  end
  if self._guideModule:IsGuideProcess(self._guideID2) then
    while not self:_GuideStepIsDone(self._guideID2, 3) do
      YIELD(TT)
    end
  end
  if self._guideModule:IsGuideProcess(self._guideID2) then
    while not self:_GuideStepIsDone(self._guideID2, 4) do
      YIELD(TT)
    end
  end
  if self._guideModule:IsGuideProcess(self._guideID2) then
    while not self:_GuideStepIsDone(self._guideID2, 5) do
      YIELD(TT)
    end
  end
  GameGlobal.EventDispatcher():Dispatch(GameEventType.LuckLandRoundEnd)
  self:ShowDialog("UILuckLandSelectCardPopUp", function()
    self:RefreshGameData()
  end)
  self.topUnCtrlObj:SetActive(false)
  self:RefreshGameData()
  self.taskid = nil
end

function UILuckLandMainGameController:CalcuEnemyPhase(atk)
  local teamAtk = atk
  for i = 1, #self.enemyAreaList do
    local item = self.enemyAreaList[i]
    if not item:GetDead() and 0 < teamAtk then
      local hp = item:GetHP()
      local reduceHp = hp
      if teamAtk < reduceHp then
        reduceHp = teamAtk
      end
      item:SetReduceHP(reduceHp)
      teamAtk = teamAtk - reduceHp
      if teamAtk < 0 then
        teamAtk = 0
      end
    end
  end
end

function UILuckLandMainGameController:CalcuRoundRes()
  local money, atk, recover = 0, 0, 0
  money, atk, recover = LuckLandInnerGameHelper.GetRoundRes()
  return money, atk, recover
end

function UILuckLandMainGameController:RestartGame()
end

function UILuckLandMainGameController:BuildLevelUnLockCardPool()
  local camplevel, data = self.curBuildDataLevel:CampFireBuildLevel()
  local maxLevel = 5
  for i = 1, #self.cardAreaList do
    if i < #self.cardAreaList - maxLevel + camplevel + 1 then
      local item = self.cardAreaList[i]
      item:SetUnlockCard()
    end
  end
end

function UILuckLandMainGameController:EmptyAllCard()
  local camplevel, data = self.curBuildDataLevel:CampFireBuildLevel()
  local maxLevel = 5
  for i = 1, #self.cardAreaList do
    if i < #self.cardAreaList - maxLevel + camplevel + 1 then
      local item = self.cardAreaList[i]
      item:SetEmptyCard()
    end
  end
end

function UILuckLandMainGameController:InitPlayCalcuUI()
  self.showPhaseObj:SetActive(false)
  self.playerCalcuPhaseObj:SetActive(false)
  self.showAtkObj:SetActive(false)
  self.showRecoverObj:SetActive(false)
  self.showMoneyObj:SetActive(false)
  self.moneyEffObj:SetActive(false)
  self.atkEffObj:SetActive(false)
  self.recoverEffObj:SetActive(false)
end

function UILuckLandMainGameController:ContinueBtnOnClick(go)
end

function UILuckLandMainGameController:ExitBtnOnClick(go)
end

function UILuckLandMainGameController:RollBtnOnClick(go)
  self.taskid = self:StartTask(self.RefrenshRollPlay, self)
end

function UILuckLandMainGameController:CardBagBtnOnClick(go)
  self:ShowDialog("UILuckLandCardBag", true, true)
end

function UILuckLandMainGameController:_CheckGuide()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.GuideOpenUI, GuideOpenUI.UILuckLandMainGameController)
end

function UILuckLandMainGameController:_GuideStepIsDone(guideID, step)
  if self._guideModule:IsGuideProcess(guideID) then
    local guide = self._guideModule.guides[guideID]
    if guide then
      local guideStep = guide.allSteps[step]
      return guideStep.done
    end
  end
  return true
end

function UILuckLandMainGameController:InitGuideUI()
  if not self._guideModule:IsGuideDone(self._guideID2) then
    self:ShowBuild(false)
  end
end
