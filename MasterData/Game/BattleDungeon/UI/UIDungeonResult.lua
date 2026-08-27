local UIDungeonResult = class("UIDungeonResult", UIBaseWindow)
local base = UIBaseWindow
local ItemData = require("Game.PlayerData.Item.ItemData")
local UIRewardItem = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UICharacterItem = require("Game.BattleResult.UIBattleResultCharacterItem")
local UIBattleSkadaPage = require("Game.BattleResult.Skada.UIBattleSkadaPage")
local UINBtResultWinterChallenge = require("Game.BattleDungeon.UI.WinterChallenge.UINBtResultWinterChallenge")
local UINResultCompleteNode = require("Game.BattleResult.UINResultCompleteNode")
local cs_BattleStatistics = CS.BattleStatistics.Instance
local cs_GameObject = CS.UnityEngine.GameObject
local cs_DOTween = CS.DG.Tweening.DOTween
local cs_MessageCommon = CS.MessageCommon
local DungeonTypeData = require("Game.Dungeon.DungeonTypeData")

function UIDungeonResult:OnInit()
  self.resloader = CS.ResLoader.Create()
  UIUtil.CreateNewTopStatusData(self):SetTopStatusBackAction(self.BackAction):PushTopStatusDataToBackStack()
  self.rewardItemPool = UIItemPool.New(UIRewardItem, self.ui.obj_rewardItem)
  self.heroHeadItemPool = UIItemPool.New(UICharacterItem, self.ui.obj_heroHeadItem)
  self.ui.tex_levelName.gameObject:SetActive(false)
  if not BattleUtil.IsInTDBattle() then
    self.ui.btn_skada.gameObject:SetActive(true)
    UIUtil.AddButtonListener(self.ui.btn_skada, self, self.__OnBtnSkadaClick)
  else
    self.ui.btn_skada.gameObject:SetActive(false)
  end
  self.ui.obj_rewardItem:SetActive(false)
  self.ui.obj_heroHeadItem:SetActive(false)
  self.ui.obj_userSkillNode:SetActive(false)
  self.ui.obj_globalExpNode:SetActive(false)
  self.ui.tex_PlayAgainWinChallenge:SetIndex(0)
  UIUtil.AddButtonListener(self.ui.btn_PlayAgain, self, self.__OnBtnPlayerAgainClick)
  UIUtil.AddButtonListener(self.ui.btn_PlayAgainWinChallenge, self, self._OnClickWinClgPlayAgan)
  UIUtil.AddButtonListener(self.ui.btn_Back, self, self._OnClickWinClgBack)
  self.__updateHandle = BindCallback(self, self.Update)
  UpdateManager:AddUpdate(self.__updateHandle)
  self.__playAnim = BindCallback(self, self.StartExpAnimation)
  MsgCenter:AddListener(eMsgEventId.OnShowBattleResultComplete, self.__playAnim)
  self:__ToFackCameraCanvas()
  self.ui.resultBtnGroup:SetActive(true)
  self.ui.battleAutoNode:SetActive(false)
  self.__OnScreenSizeChanged = BindCallback(self, self.__ToFackCameraCanvas)
  MsgCenter:AddListener(eMsgEventId.OnScreenSizeChanged, self.__OnScreenSizeChanged)
  self._completeNodePool = UIItemPool.New(UINResultCompleteNode, self.ui.completeTime)
  self.ui.completeTime:SetActive(false)
end

function UIDungeonResult:__ToFackCameraCanvas()
  local fakeCameraBattle = cs_GameObject.Find("FakeCameraBattle"):FindComponent(eUnityComponentID.Camera)
  local epMapCamera = BattleDungeonManager.dungeonCtrl.sceneCtrl.bind.epMapCamera
  fakeCameraBattle.enabled = true
  fakeCameraBattle.enabled = false
  self:AlignToFakeCamera(fakeCameraBattle, epMapCamera)
end

function UIDungeonResult:_PlayWinAudio()
  self._auBack = AudioManager:PlayAudioById(3009, function()
    self._auBack = nil
  end)
end

function UIDungeonResult:CompleteDungeon(isGuide, rewardMsg, rewards, resultData, mvpGrade, dungeonType)
  self.resultData = resultData
  if isGuide then
    self.ui.obj_textContinue:SetActive(true)
    self.ui.btn_PlayAgain.gameObject:SetActive(false)
    UIUtil.AddButtonListener(self.ui.btn_background, self, self.__OnBtnContinueClick)
  else
    self.ui.btn_continue.gameObject:SetActive(true)
    UIUtil.AddButtonListener(self.ui.btn_continue, self, self.__OnBtnContinueClick)
  end
  self.ui.obj_heroHeadNode:SetActive(not isGuide)
  self:_PlayWinAudio()
  local rewardList = {}
  self.dungeonType = dungeonType
  if rewardMsg ~= nil then
    local exp = rewardMsg.totalExp
    self.heroIntimacy = rewardMsg.heroIntimacy
  end
  self:_mergeReward(rewardList, rewards)
  self:__InitBattleReward(rewardList, rewardMsg.getATH)
  self:__InitCharacterExp(resultData.lastHeroList)
  self:__InitMvpHeroPic(mvpGrade)
  if BattleDungeonManager.dungeonCtrl.enterMsgData ~= nil and BattleDungeonManager.dungeonCtrl.enterMsgData.ab ~= nil and PlayerDataCenter.friendDataCenter:TryGetFriendData(BattleDungeonManager.dungeonCtrl.enterMsgData.ab.uid) == nil and not PlayerDataCenter.friendDataCenter:GetIsFriendFull() then
    UIManager:ShowWindowAsync(UIWindowTypeID.MessageSideAddFriend, function(window)
      if window == nil then
        return
      end
      window:InitAddHeroSide(BattleDungeonManager.dungeonCtrl.enterMsgData.ab.uid, self.resloader)
    end)
  end
end

function UIDungeonResult:InitCardSetDgResult(resultData, mvpGrade)
  self.ui.rewardLayout:SetActive(false)
  self.ui.obj_heroHeadNode:SetActive(false)
  self.ui.obj_textContinue:SetActive(true)
  self.resultData = resultData
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.__OnBtnContinueClick)
  self:_PlayWinAudio()
  self:__InitMvpHeroPic(mvpGrade)
end

function UIDungeonResult:InitDailyDgResult(isLastDungeon, enterNextLevelFunc)
  self._enterNextLevelFunc = enterNextLevelFunc
  self._isLastDungeon = isLastDungeon
  self.ui.obj_WinterChallengeBtnGroup:SetActive(not isLastDungeon)
  self.ui.resultBtnGroup:SetActive(isLastDungeon)
  self.ui.obj_tex_BackInfo:SetActive(false)
end

function UIDungeonResult:InitWinterChallengeDgResult(scoreAdd, scoreAll, isLastDungeon, enterNextLevelFunc)
  self._enterNextLevelFunc = enterNextLevelFunc
  self._isLastDungeon = isLastDungeon
  self.ui.resultBtnGroup:SetActive(false)
  self.ui.rewardLayout:SetActive(false)
  self.ui.obj_WinterChallengeBtnGroup:SetActive(true)
  self.ui.winterChallengeNode:SetActive(true)
  self.ui.btn_Back.gameObject:SetActive(not isLastDungeon)
  self.ui.tex_PlayAgainWinChallenge:SetIndex(isLastDungeon and 1 or 0)
  local winChallengeNode = UINBtResultWinterChallenge.New()
  winChallengeNode:Init(self.ui.winterChallengeNode)
  winChallengeNode:InitBtResultWinterChallenge(scoreAdd, scoreAll)
  self.winChallengeNode = winChallengeNode
end

function UIDungeonResult:_OnClickWinClgPlayAgan()
  if self._isLastDungeon then
    self:__OnBtnContinueClick()
    return
  end
  if self._enterNextLevelFunc ~= nil then
    self._enterNextLevelFunc()
  end
end

function UIDungeonResult:_OnClickWinClgBack()
  self:__OnBtnContinueClick()
end

function UIDungeonResult:_mergeReward(table, rewards)
  for key, value in pairs(rewards) do
    table[key] = (table[key] or 0) + value
  end
end

function UIDungeonResult:__InitBattleReward(rewardDic, getATH)
  self.rewardDic = rewardDic
  local rewardList = {}
  local hasAth = false
  for id, num in pairs(rewardDic) do
    local itemCfg = ConfigData.item[id]
    if itemCfg == nil then
      error("can't read itemCfg with id=" .. id)
    elseif ConfigData:IsRewardNotShowATH(itemCfg) then
      hasAth = true
    else
      table.insert(rewardList, {
        id = id,
        count = num,
        itemCfg = itemCfg
      })
    end
  end
  if getATH ~= nil then
    for _, uid in pairs(getATH) do
      local athData = PlayerDataCenter.allAthData.athDic[uid]
      if athData ~= nil then
        table.insert(rewardList, {
          id = athData.id,
          count = 1,
          itemCfg = athData.itemCfg,
          isAth = true,
          athData = athData
        })
      end
    end
  end
  if #rewardList == 0 then
    self.ui.rewardLayout:SetActive(false)
    return
  end
  self.ui.rewardLayout:SetActive(true)
  ExplorationManager:RewardSort(rewardList)
  local luckDropDic = BattleDungeonManager.dunInterfaceData:GetAfterBattleLuckDropDic()
  for k, v in ipairs(rewardList) do
    local rewardItem = self.rewardItemPool:GetOne()
    rewardItem:InitItemWithCount(v.itemCfg, v.count, function()
      UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
        if win ~= nil then
          win:InitListDetail(rewardList, k, true)
        end
      end)
    end)
    local isLuckDrop = false
    if luckDropDic ~= nil and luckDropDic[v.id] ~= nil then
      isLuckDrop = v.count >= luckDropDic[v.id]
    end
    rewardItem.ui.obj_img_luckReward:SetActive(isLuckDrop)
  end
  local rewardSequence = cs_DOTween.Sequence()
  for index, item in ipairs(self.rewardItemPool.listItem) do
    item:SetFade(0)
    rewardSequence:AppendCallback(function()
      if ConfigData.game_config.itemWithGreatFxDic[item.itemCfg] then
        item:LoadGetGreatRewardFx(self.resloader, 5)
      else
        item:LoadGetRewardFx(self.resloader, 5)
      end
    end)
    rewardSequence:Append(item:GetFade():DOFade(1, 0.15):SetLink(item.gameObject))
  end
  rewardSequence:SetDelay(0.15)
  rewardSequence:SetAutoKill(false)
  rewardSequence:Pause()
  if self.rewardSequence ~= nil then
    self.rewardSequence:Kill()
  end
  self.rewardSequence = rewardSequence
  if self.__animationStart then
    self:StartExpAnimation()
  end
  local hasReward = 0 < #rewardList
  self.ui.img_rewardBg.color = hasReward and Color.New(1, 1, 1, 0.9) or Color.New(0, 0, 0, 0.4)
  self.ui.obj_rewardText:SetActive(hasReward)
  local showDouble = false
  local multRewardInfo
  if BattleDungeonManager.dunInterfaceData ~= nil then
    multRewardInfo = BattleDungeonManager.dunInterfaceData:GetBattleWinRewardInfo()
  end
  if multRewardInfo ~= nil and multRewardInfo.isMultReward then
    if 0 > multRewardInfo.multRewardTotalNum then
      showDouble = true
      self.ui.tex_DropCount.gameObject:SetActive(false)
    elseif 0 > multRewardInfo.multRewardLeftNum then
      showDouble = false
    else
      showDouble = true
      self.ui.tex_DropCount.gameObject:SetActive(true)
    end
    if showDouble then
      if multRewardInfo.multRewardRate == 1 then
        self.ui.tex_dropInfo:SetIndex(1)
        self.ui.tex_DropCount:SetIndex(1, tostring(multRewardInfo.multRewardLeftNum), tostring(multRewardInfo.multRewardTotalNum))
      else
        self.ui.tex_dropInfo:SetIndex(0)
        self.ui.tex_DropCount:SetIndex(0, tostring(multRewardInfo.multRewardLeftNum), tostring(multRewardInfo.multRewardTotalNum))
      end
    end
  end
  self.ui.obj_DropUPTips:SetActive(showDouble)
  if BattleDungeonManager.dunInterfaceData ~= nil and BattleDungeonManager.dunInterfaceData:GetDgInterfaceDungeonDyncData() ~= nil then
    local dungeonDyncData = BattleDungeonManager.dunInterfaceData:GetDgInterfaceDungeonDyncData()
    if dungeonDyncData:DgDyncIsHaveMultReward() then
      self.ui.obj_DropUPTips:SetActive(true)
      self.ui.tex_dropInfo:SetIndex(1)
      self.ui.tex_DropCount.gameObject:SetActive(false)
    end
  end
end

function UIDungeonResult:__InitCharacterExp(lastHeroList)
  local heroList = BattleDungeonManager.dungeonCtrl.dynPlayer.heroList
  local levelupRoleIdDic = {}
  local hasLevelup = false
  self.heroHeadDic = {}
  local heroItem
  for k, dynHero in ipairs(heroList) do
    if not dynHero:IsFriendSupport() then
      heroItem = self.heroHeadDic[k]
      if heroItem == nil then
        heroItem = self.heroHeadItemPool:GetOne()
      end
      heroItem:InitCharacterItem(dynHero, self.resloader, nil)
      heroItem:RefershExpData(lastHeroList[k])
      heroItem:RefreshFriendShipData(self.heroIntimacy[dynHero.dataId])
      self.heroHeadDic[k] = heroItem
      local oldLevel = lastHeroList[k].level
      if oldLevel > dynHero:GetLevel() then
        levelupRoleIdDic[dynHero.dataId] = true
        hasLevelup = true
      end
    end
  end
end

function UIDungeonResult:StartExpAnimation()
  if BattleUtil.IsInCardSetDungeon() then
    return
  end
  self.__animationStart = true
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
  if self.rewardSequence ~= nil then
    self.rewardSequence:Restart()
  end
  local dungeonStageData
  if BattleDungeonManager.dunInterfaceData ~= nil then
    dungeonStageData = BattleDungeonManager.dunInterfaceData:GetIDungeonStageData()
  end
  if dungeonStageData ~= nil and dungeonStageData.dungeonData ~= nil then
    local dungeonCfg = dungeonStageData.dungeonData.dungeonCfg
    local resource_top = {}
    if dungeonCfg ~= nil then
      for k, v in pairs(dungeonCfg.resource_top) do
        resource_top[k] = v
      end
    end
    table.insert(resource_top, ConstGlobalItem.SKey)
    UIUtil.RefreshTopResId(resource_top, nil, true)
    UIUtil.SetCurButtonGroupActive(false)
  end
end

function UIDungeonResult:Update()
  if not self.__animationStart then
    return
  end
  if self.heroHeadDic ~= nil then
    for k, heroItem in pairs(self.heroHeadDic) do
      heroItem:UpdateExp()
    end
  end
end

function UIDungeonResult:__InitMvpHeroPic(mvpGrade)
  local heroData = mvpGrade.role.character.heroData
  self.ui.tex_heroMvp:SetIndex(mvpGrade.MvpType)
  self.ui.img_heroMvp.color = self.ui.color_MVP[mvpGrade.MvpType + 1]
  self.ui.tex_mvpName.text = tostring(LanguageUtil.GetLocaleText(heroData.heroCfg.name))
  self.ui.tex_mvpDesc:SetIndex(mvpGrade.MvpType)
end

function UIDungeonResult:InitAutoModeShow(battleCount, totalCount)
  if battleCount == totalCount then
    self.ui.resultBtnGroup:SetActive(true)
    self.ui.battleAutoNode:SetActive(false)
    self.ui.btn_continue.gameObject:SetActive(true)
    self.ui.btn_PlayAgain.gameObject:SetActive(false)
    return
  end
  self.ui.resultBtnGroup:SetActive(false)
  self.ui.battleAutoNode:SetActive(true)
  self.ui.tex_AutoCount.text = string.format("%d/%d", battleCount, totalCount)
  self.ui.tex_AutoTimer.text = tostring(ConfigData.game_config.dungeonAutoWaitingTime)
end

function UIDungeonResult:RefreshAutoCutdown(time)
  self.ui.tex_AutoTimer.text = tostring(time)
end

function UIDungeonResult:SetContinueCallback(callback)
  self.continueCallback = callback
end

function UIDungeonResult:BackAction()
  if self.continueCallback ~= nil then
    self.continueCallback()
  end
  self:Delete()
end

function UIDungeonResult:__OnBtnContinueClick()
  UIUtil.OnClickBackByUiTab(self)
end

function UIDungeonResult:InitDungeonRacingResult(frame, isCheat, isNew)
  local item = self._completeNodePool:GetOne()
  item:InitResultCompleteTime(frame, isCheat, isNew)
end

function UIDungeonResult:InitDungeonDamageResult(num, isCheat, isNew)
  local item = self._completeNodePool:GetOne()
  item:InitResultCompleteItem(3, tostring(num), isNew, isCheat)
end

function UIDungeonResult:InitDungeonScoreResult(score, isNew, isCheck)
  local item = self._completeNodePool:GetOne()
  item:InitResultCompleteItem(2, tostring(score), isNew, isCheck)
end

function UIDungeonResult:InitDungeonScoreAddRateResult(scoreAdd, isNew, isCheck)
  local item = self._completeNodePool:GetOne()
  item:InitResultCompleteItem(1, tostring(math.floor(scoreAdd / 10)) .. "%", isNew, isCheck)
end

function UIDungeonResult:DungeonSetPlayeAgain(playerAgainCallback, dInterfaceData, dungeonStageData)
  self.playerAgainCallback = playerAgainCallback
  self.dungeonStageData = dungeonStageData
  self.__dInterfaceData = dInterfaceData
  if dungeonStageData ~= nil then
    self.ui.btn_PlayAgain.gameObject:SetActive(true)
    self.ui.tex_PlayName:SetIndex(0)
    local IsReach2Limit = dungeonStageData:GetIsReach2Limit()
    local IsDungeonReach2Limit = dungeonStageData.dungeonData:GetDungeonPlayLeftLimitNum() == 0
    local couldRestart = not IsReach2Limit and not IsDungeonReach2Limit
    if couldRestart then
      self.ui.img_Ticket.sprite = CRH:GetDefaultKeySprite()
      local costStamina = dungeonStageData:GetStaminaCost()
      self.ui.tex_RestartPoint.text = tostring(costStamina)
    else
      self.ui.btn_PlayAgain.gameObject:SetActive(false)
    end
    self:__updateBattleRemainLimit(dungeonStageData, couldRestart)
    self.ui.dungeonDataRoot.gameObject:SetActive(true)
  elseif dInterfaceData:AbleContinueReplayLevel() then
    self.ui.tex_PlayName:SetIndex(0)
    local costId = dInterfaceData:GetReplayStaminaReplaceItemId()
    self.ui.img_Ticket.sprite = CRH:GetDefaultKeySprite(costId)
    self.ui.tex_RestartPoint.text = tostring(dInterfaceData:GetReplayStaminaCost())
  end
end

function UIDungeonResult:__updateBattleRemainLimit(dungeonStageData, isDisplayDungeonLimit)
  if dungeonStageData ~= nil then
    local moduleRemainNum, moduleTotalNum, moduleUsedNum = dungeonStageData.dungeonData:GetDungeonPlayLeftLimitNum()
    self.ui.text_ModuleName.gameObject:SetActive(-1 < moduleRemainNum)
    if -1 < moduleRemainNum then
      self.ui.text_moduleRemainCount:SetIndex(0, tostring(moduleRemainNum), tostring(moduleTotalNum))
      local dungeonModuleCfg = ConfigData.material_dungeon[dungeonStageData.dungeonData.dungeonId]
      if dungeonModuleCfg ~= nil then
        self.ui.text_ModuleName.text = LanguageUtil.GetLocaleText(ConfigData.material_dungeon[dungeonStageData.dungeonData.dungeonId].name)
      else
        error("在battle_dungeon:material_duungeon中找不到对应的dungeon配置:" .. dungeonStageData.dungeonData.dungeonId)
        self.ui.text_ModuleName.gameObject:SetActive(false)
      end
    end
    if isDisplayDungeonLimit and -1 < dungeonStageData.dungeonStageCfg.frequency_day then
      self.ui.dungeonLimitData:SetActive(true)
      local dungeonRemainNum, dungeonTotalNum, dungeonUsedNum = dungeonStageData:GetCurDungeonDailyLimit()
      self.ui.text_dungeonRemainCount:SetIndex(0, tostring(dungeonRemainNum), tostring(dungeonTotalNum))
    else
      self.ui.dungeonLimitData:SetActive(false)
    end
  end
end

function UIDungeonResult:DungeonSetPlayeNext(playerAgainCallback, dInterfaceData)
  self.playerAgainCallback = playerAgainCallback
  self.__dInterfaceData = dInterfaceData
  if dInterfaceData ~= nil and dInterfaceData:AbleContinueNextLevel() then
    self.ui.tex_PlayName:SetIndex(1)
    self.ui.btn_PlayAgain.gameObject:SetActive(true)
    local costId = dInterfaceData:GetINextStaminaReplaceItemId()
    self.ui.img_Ticket.sprite = CRH:GetDefaultKeySprite(costId)
    self.ui.tex_RestartPoint.text = tostring(dInterfaceData:GetINextStaminaCost())
  end
end

function UIDungeonResult:__OnBtnPlayerAgainClick()
  if self.playerAgainCallback ~= nil then
    self.playerAgainCallback(self.__dInterfaceData)
  end
end

function UIDungeonResult:__OnBtnSkadaClick()
  UIManager:ShowWindowAsync(UIWindowTypeID.ResultSkada, function(window)
    if window == nil then
      return
    end
    window:InitBattleSkada(cs_BattleStatistics, self.resultData.playerRoleList, self.resultData.enemyRoleList)
  end)
end

function UIDungeonResult:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnScreenSizeChanged, self.__OnScreenSizeChanged)
  UIManager:DeleteWindow(UIWindowTypeID.BattleResultExtra)
  self.resultData = nil
  if self._auBack ~= nil then
    AudioManager:StopAudioByBack(self._auBack)
    self._auBack = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.rewardSequence ~= nil then
    self.rewardSequence:Kill()
    self.rewardSequence = nil
  end
  if self.winChallengeNode ~= nil then
    self.winChallengeNode:Delete()
  end
  UpdateManager:RemoveUpdate(self.__updateHandle)
  MsgCenter:RemoveListener(eMsgEventId.OnShowBattleResultComplete, self.__playAnim)
  base.OnDelete(self)
end

return UIDungeonResult
