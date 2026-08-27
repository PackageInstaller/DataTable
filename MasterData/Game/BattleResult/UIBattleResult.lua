local UIBattleResult = class("UIBattleResult", UIBaseWindow)
local base = UIBaseWindow
local ItemData = require("Game.PlayerData.Item.ItemData")
local UIRewardItem = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UICharacterItem = require("Game.BattleResult.UIBattleResultCharacterItem")
local UINBattleResultWeekly = require("Game.BattleResult.WeeklyReward.UINBattleResultWeekly")
local EpUtil = require("Game.Exploration.Util.EpUtil")
local cs_ResLoader = CS.ResLoader
local cs_BattleStatistics = CS.BattleStatistics.Instance
local cs_GameObject = CS.UnityEngine.GameObject
local cs_DOTween = CS.DG.Tweening.DOTween
local cs_CanvasGroup = CS.UnityEngine.CanvasGroup
local cs_MessageCommon = CS.MessageCommon

function UIBattleResult:OnInit()
  UIUtil.SetTopStatus(self, self.BackAction, nil, nil, nil, true)
  self.resloader = cs_ResLoader.Create()
  self.rewardItemPool = UIItemPool.New(UIRewardItem, self.ui.obj_rewardItem)
  self.heroHeadItemPool = UIItemPool.New(UICharacterItem, self.ui.obj_heroHeadItem)
  self.ui.obj_rewardItem:SetActive(false)
  if not BattleUtil.IsInTDBattle() then
    UIUtil.AddButtonListener(self.ui.btn_skada, self, self.__OnBtnSkadaClick)
  else
    self.ui.btn_skada.gameObject:SetActive(false)
  end
  UIUtil.AddButtonListener(self.ui.btn_continue, self, self.__OnBtnContinueClick)
  self.__playAnim = BindCallback(self, self.StartExpAnimation)
  MsgCenter:AddListener(eMsgEventId.OnShowBattleResultComplete, self.__playAnim)
  self:__ToFackCameraCanvas()
  self.__OnScreenSizeChanged = BindCallback(self, self.__ToFackCameraCanvas)
  MsgCenter:AddListener(eMsgEventId.OnScreenSizeChanged, self.__OnScreenSizeChanged)
  self.ui.obj_bNNode:SetActive(false)
  self.ui.obj_sCNode:SetActive(false)
end

function UIBattleResult:__ToFackCameraCanvas()
  local fakeCameraBattle = cs_GameObject.Find("FakeCameraBattle"):FindComponent(eUnityComponentID.Camera)
  local epMapCamera = ExplorationManager.epCtrl.sceneCtrl.epSceneEntity:GetEpMapCamera()
  fakeCameraBattle.enabled = true
  fakeCameraBattle.enabled = false
  self:AlignToFakeCamera(fakeCameraBattle, epMapCamera)
end

function UIBattleResult:InitBattleResultData(playerRoleList, enemyRoleList, mvpGrade)
  self.__playerRoleList = playerRoleList
  self.__enemyRoleList = enemyRoleList
  self.isInfinity = ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless
  self.isPerodicChallenge = ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_DailyChallenge
  local floor = ExplorationManager:GetCurLevelIndex() + 1
  local step = ExplorationManager.epCtrl:GetCurrentRoomData().x
  local roomType = ExplorationManager.epCtrl:GetCurrentRoomData():GetRoomType(true)
  local roomTypeCfg = ConfigData.exploration_roomtype[roomType]
  self.ui.tex_levelName.text = LanguageUtil.GetLocaleText(roomTypeCfg.title)
  self:__InitBattleReward()
  self:__InitMvpHeroPic(self.__playerRoleList, mvpGrade)
  if ExplorationManager:GetEpModuleId() == proto_csmsg_SystemFunctionID.SystemFunctionID_WeeklyChallenge then
    self:_InitWeeklyReward()
  end
  if ExplorationManager:IsEpInifinity() then
    self:_InitEpInfinityReward()
  end
  if ExplorationManager:IsEpInifinity4Act24() then
    self:_InitEpInfinityReward4Act24()
  end
  if GuideManager:TryTriggerGuide(eGuideCondition.InEpBattleResult) then
  end
end

function UIBattleResult:_InitWeeklyReward()
  self.ui.rewardLayout:SetActive(false)
  self.weeklyResultNode = UINBattleResultWeekly.New()
  self.weeklyResultNode:Init(self.ui.weeklyRewardLayout)
  self.weeklyResultNode:InitBattleResultWeekly(self.roomMoneyNum)
  self.weeklyResultNode:Show()
end

function UIBattleResult:_InitEpInfinityReward()
  local totalDmg = self:__CalTotalDamageValue()
  local score, addrate = EpUtil.CalEpInfinityScore(totalDmg)
  self.ui.obj_bNNode:SetActive(true)
  self.ui.obj_sCNode:SetActive(true)
  self.ui.tex_BnNum.text = tostring(addrate) .. "%"
  self.ui.tex_ScNum.text = tostring(score)
end

function UIBattleResult:_InitEpInfinityReward4Act24()
  local totalDmg = self:__CalTotalDamageValue()
  local score, addrate = EpUtil.CalEpInfinityScore4Act24(totalDmg)
  self.ui.obj_bNNode:SetActive(true)
  self.ui.obj_sCNode:SetActive(true)
  self.ui.tex_BnNum.text = tostring(addrate) .. "%"
  self.ui.tex_ScNum.text = tostring(score)
end

function UIBattleResult:__CalTotalDamageValue()
  local num = 0
  local playerDamage = cs_BattleStatistics.playerDamage
  for i, v in pairs(playerDamage) do
    num = num + v.damage
  end
  local cmdDamage = cs_BattleStatistics.commanderDamager
  num = num + cmdDamage
  return num
end

function UIBattleResult:SetContinueCallback(callback)
  self.continueCallback = callback
end

function UIBattleResult:__SetGlobalExpNode(globalExpFrom)
  if PlayerDataCenter.AllBuildingData.oasisBuilt[eBuildingId.OasisLibrary] == nil then
    self.ui.obj_globalExpNode:SetActive(false)
    return
  end
  self.ui.obj_globalExpNode:SetActive(true)
  local globalExpTo = PlayerDataCenter:GetItemCount(ConfigData.game_config.globalExpItemId)
  local globalExpCeiling = PlayerDataCenter.playerBonus:GetGlobalExpCeiling()
  self.ui.tex_globalExp:SetIndex(0, tostring(math.floor(globalExpTo - globalExpFrom)))
  local fromFill = globalExpFrom / globalExpCeiling
  self.ui.img_globalExp.fillAmount = fromFill
  if globalExpTo < globalExpCeiling then
    if globalExpFrom == 0 then
      return
    end
    local toFill = globalExpTo / globalExpCeiling
    if self.globalExpTween == nil then
      local tween = self.ui.img_globalExp:DOFillAmount(toFill, 1)
      self.globalExpTween = tween
    else
      self.globalExpTween:ChangeEndValue(toFill, true)
      self.globalExpTween:Restart()
    end
  else
  end
end

function UIBattleResult:__InitBattleReward()
  local isShowAth = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm)
  local isCompletedInfinity
  if self.isInfinity then
    local stageCfg = ExplorationManager:GetSectorStageCfg()
    isCompletedInfinity = PlayerDataCenter.infinityData:IsInfinityDungeonCompleted(stageCfg.dungeonId)
  end
  local couldShowDrop = not self.isPerodicChallenge and (not self.isInfinity or isCompletedInfinity)
  local ChipData = require("Game.PlayerData.Item.ChipData")
  local chipDataList = {}
  
  local function addChipFunc(id, num)
    local chip = ChipData.NewChipForLocal(id, num)
    table.insert(chipDataList, chip)
  end
  
  local curRoomData = ExplorationManager.epCtrl:GetCurrentRoomData()
  local rewardDic = {}
  self.rewardDic = rewardDic
  local metalChipData
  for k, itemData in ipairs(curRoomData.rewardList) do
    if couldShowDrop or not itemData.itemCfg.explorationHold then
      local dataId = itemData.dataId
      local itemCfg = ConfigData.item[dataId]
      if itemCfg.type == eItemType.GlobalChip and metalChipData == nil then
        local chipCfg = ConfigData.chip[itemCfg.id]
        if chipCfg.chip_show_type == 1 then
          metalChipData = ChipData.NewChipForLocal(itemCfg.id, itemData:GetCount())
        else
          addChipFunc(itemCfg.id, itemData:GetCount())
        end
      end
      local hasAth = ConfigData:IsRewardNotShowATH(itemCfg)
      if not hasAth or isShowAth then
        if rewardDic[dataId] == nil then
          rewardDic[dataId] = {
            data = itemData,
            count = itemData:GetCount(),
            itemCfg = itemData.itemCfg
          }
        else
          rewardDic[dataId].count = rewardDic[dataId].count + itemData:GetCount()
        end
      end
    end
  end
  if curRoomData.rewardExtraDic ~= nil then
    for dataId, count in pairs(curRoomData.rewardExtraDic) do
      if couldShowDrop or not ConfigData.item[dataId].explorationHold then
        local itemCfg = ConfigData.item[dataId]
        if itemCfg and itemCfg.type == eItemType.GlobalChip then
          addChipFunc(dataId, count)
        elseif rewardDic[dataId] == nil then
          local itemData = ItemData.New(dataId, count)
          rewardDic[dataId] = {
            data = itemData,
            count = count,
            itemCfg = itemData.itemCfg
          }
        else
          rewardDic[dataId].count = rewardDic[dataId].count + count
        end
      end
    end
  end
  local moneyId = 1
  local moneyData
  local rewardList = {}
  for k, v in pairs(rewardDic) do
    if k ~= moneyId then
      table.insert(rewardList, v)
    else
      moneyData = v
      rewardDic[k] = nil
    end
  end
  self.ui.text_ccDes:SetIndex(0)
  if BattleUtil.IsInBrotatBattle() then
    local dynPlayer = ExplorationManager:GetDynPlayer()
    if dynPlayer ~= nil then
      self.ui.text_ccDes:SetIndex(1)
      local moneyCount = dynPlayer:GetMoneyCount() + dynPlayer:GetCacheMoneyCount()
      if moneyData == nil then
        moneyData = {}
      end
      moneyData.count = moneyCount
    end
  end
  self.roomMoneyNum = 0
  if moneyData == nil then
    self.ui.obj_ccNode:SetActive(false)
  else
    self.ui.obj_ccNode:SetActive(true)
    self.ui.tex_ccCount.text = tostring(moneyData.count)
    self.roomMoneyNum = moneyData.count
  end
  if metalChipData ~= nil then
    self.ui.obj_rewardNode:SetActive(false)
    if self.__resultMetaGearInfo == nil then
      local UINResultMetalGear = require("Game.BattleResult.UINResultMetalGear")
      self.__resultMetaGearInfo = UINResultMetalGear.New()
      self.__resultMetaGearInfo:Init(self.ui.obj_mGNode)
    end
    self.__resultMetaGearInfo:Show()
    self.__resultMetaGearInfo:InitBattleResultMetalGear(metalChipData)
    return
  end
  ExplorationManager:RewardSort(rewardList)
  for k, v in ipairs(rewardList) do
    local rewardItem = self.rewardItemPool:GetOne()
    rewardItem:InitItemWithCount(v.itemCfg, v.count, function()
      UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
        if win ~= nil then
          win:InitListDetail(rewardList, k)
        end
      end)
    end)
  end
  for k, chipData in ipairs(chipDataList) do
    local msg = string.format(ConfigData:GetTipContent(120), chipData:GetName())
    cs_MessageCommon.ShowMessageTips(msg)
  end
  local buffList = {}
  local DynBuff = require("Game.Exploration.Data.DynBuff")
  for buffId, num in pairs(curRoomData.rewardBuffDic) do
    local buffData = DynBuff.CreateByEpBuffId(buffId)
    table.insert(buffList, buffData)
  end
  if 0 < #buffList and not ExplorationManager.epCtrl.autoCtrl:IsAutoModeRunning() then
    UIManager:ShowWindowAsync(UIWindowTypeID.EpBuffDesc, function(win)
      if win == nil then
        return
      end
      win:InitGetEpBuffShow(buffList)
    end)
  end
  local rewardSequence = cs_DOTween.Sequence()
  for index, item in ipairs(self.rewardItemPool.listItem) do
    item:SetFade(0)
    rewardSequence:AppendCallback(function()
      if ConfigData.game_config.itemWithGreatFxDic[item.itemCfg.id] then
        item:LoadGetGreatRewardFx(self.resloader, 5)
      else
        item:LoadGetRewardFx(self.resloader, 5)
      end
    end)
    rewardSequence:Append(item:GetFade():DOFade(1, 0.15):SetLink(item.gameObject))
  end
  rewardSequence:SetDelay(0.15)
  rewardSequence:Pause()
  if self.rewardSequence ~= nil then
    self.rewardSequence:Kill()
  end
  self.rewardSequence = rewardSequence
  local hasReward = 0 < #rewardList
  self.ui.obj_rewardNode:SetActive(hasReward)
end

function UIBattleResult:__InitCharacterExp(lastHeroList)
  local heroList = ExplorationManager.dynPlayer.heroList
  local levelupRoleIdDic = {}
  local hasLevelup = false
  self.heroHeadDic = {}
  local heroItem
  for k, dynHero in ipairs(heroList) do
    heroItem = self.heroHeadDic[k]
    if heroItem == nil then
      heroItem = self.heroHeadItemPool:GetOne()
    end
    heroItem:InitCharacterItem(dynHero, self.resloader, nil)
    heroItem:RefershExpData(lastHeroList[k - 1])
    self.heroHeadDic[k] = heroItem
    local oldLevel = lastHeroList[k - 1].level
    if oldLevel > dynHero:GetLevel() then
      levelupRoleIdDic[dynHero.dataId] = true
      hasLevelup = true
    end
  end
  if hasLevelup then
    ExplorationManager:RequestHeroAttr(levelupRoleIdDic)
  end
end

function UIBattleResult:__InitMvpHeroPic(playerRoleList, mvpGrade)
  local dynHero = mvpGrade.role.character
  self.ui.tex_heroMvp:SetIndex(mvpGrade.MvpType)
  self.ui.img_heroMvp.color = self.ui.color_MVP[mvpGrade.MvpType + 1]
  self.ui.tex_mvpName.text = dynHero:GetName()
  self.ui.tex_mvpDesc:SetIndex(mvpGrade.MvpType)
end

function UIBattleResult:__OnBtnSkadaClick()
  UIManager:ShowWindowAsync(UIWindowTypeID.ResultSkada, function(window)
    if window == nil then
      return
    end
    window:InitBattleSkada(cs_BattleStatistics, self.__playerRoleList, self.__enemyRoleList)
  end)
end

function UIBattleResult:__OnBtnContinueClick()
  self:ExitBattleResult()
end

function UIBattleResult:SkipSettlementTimeLine()
  local m_settlementDirector = CS.CameraController.Instance.m_settlementDirector
  local skipLength = math.ceil(m_settlementDirector.duration)
  if skipLength > m_settlementDirector.time then
    m_settlementDirector.time = skipLength
  end
end

function UIBattleResult:BackAction()
  if not self.canPopFromStack then
    self.canPopFromStack = true
    self:SkipSettlementTimeLine()
    self:SetStartExpAnimation()
  end
  if self.continueCallback ~= nil then
    self.continueCallback()
  end
  self:FadeDelete()
end

function UIBattleResult:ExitBattleResult()
  UIUtil.OnClickBackByUiTab(self)
end

function UIBattleResult:FadeDelete()
  if self.__fadeTween ~= nil then
    self.__fadeTween:Kill()
    self.__fadeTween = nil
  end
  self.__fadeTween = UIManager:PlayDoFade(self.ui.canvasGroup, 1, 0, 0.5, function()
    self:Delete()
  end)
end

function UIBattleResult:StartExpAnimation()
  if not self.canPopFromStack then
    self:SetStartExpAnimation()
  end
  self.canPopFromStack = true
end

function UIBattleResult:SetStartExpAnimation()
  AudioManager:PlayAudioById(1003)
  local containAth = false
  for id, num in pairs(self.rewardDic) do
    local itemCfg = ConfigData.item[id]
    if itemCfg ~= nil and itemCfg.type == eItemType.Arithmetic then
      containAth = true
      break
    end
  end
  if containAth and #PlayerDataCenter.allAthData:GetAllAthList() >= ConfigData.game_config.athMaxNum then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.Ath_MaxCount))
  end
  self.__animationStart = true
  if self.rewardSequence ~= nil then
    self.rewardSequence:Restart()
  end
end

function UIBattleResult:Update()
  if not self.__animationStart then
    return
  end
  for k, heroItem in pairs(self.heroHeadDic) do
    heroItem:UpdateExp()
  end
end

function UIBattleResult:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnScreenSizeChanged, self.__OnScreenSizeChanged)
  self.__playerRoleList = nil
  self.__enemyRoleList = nil
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.rewardSequence ~= nil then
    self.rewardSequence:Kill()
    self.rewardSequence = nil
  end
  if self.weeklyResultNode ~= nil then
    self.weeklyResultNode:Delete()
  end
  MsgCenter:RemoveListener(eMsgEventId.OnShowBattleResultComplete, self.__playAnim)
  base.OnDelete(self)
end

return UIBattleResult
