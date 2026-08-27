local UINFmtEditNode = class("UINFmtEditNode", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local cs_tweening = CS.DG.Tweening
local cs_DOTween = CS.DG.Tweening.DOTween
local HeroFilterEnum = require("Game.Hero.NewUI.HeroFilterEnum")
local UINFormationChoiceItem = require("Game.Formation.UI.2DFormation.UINFormationChoiceItem")
local UINFormationChoiceSupportItem = require("Game.Formation.UI.2DFormation.UINFormationChoiceSupportItem")
local UINFormationChioceCareerTog = require("Game.Formation.UI.2DFormation.UINFormationChioceCareerTog")
local UINFormationChioceCampTog = require("Game.Formation.UI.2DFormation.UINFormationChioceCampTog")
local UINFmtEvaluation = require("Game.Formation.UI.FormationEvaluation.UIFmtEvaluation")
local FriendSupportHeroData = require("Game.Formation.Data.FriendSupportHeroData")
local FormationUtil = require("Game.Formation.FormationUtil")
local UINFmtHeroFilterTypeToggle = require("Game.Formation.UI.2DFormation.UINFmtHeroFilterTypeToggle")
local UINCommonSwitchToggle = require("Game.CommonUI.CommonSwitchToggle.UINCommonSwitchToggle")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local FmtEnum = require("Game.Formation.FmtEnum")

function UINFmtEditNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_ReSet, self, self.OnClickResetFomration)
  UIUtil.AddButtonListener(self.ui.btn_Sort, self, self.OnClickPowerSort)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickChioceClose)
  UIUtil.AddButtonListener(self.ui.btn_CompleteRank, self, self.OnFmtCompleteRankClick)
  UIUtil.AddButtonListener(self.ui.btn_OfficialSupport, self, self.__OnClickOfficialSuport)
  UIUtil.AddButtonListener(self.ui.btn_Recommend, self, self.__OnClickRecommendFormation)
  UIUtil.AddButtonListener(self.ui.btn_LineupCmd, self, self.__OnClickLineupCmd)
  self.__OnBeginDragHero = BindCallback(self, self.OnBeginDragHero)
  self.__OnDragHero = BindCallback(self, self.OnDragHero)
  self.__OnEndDragHero = BindCallback(self, self.OnEndDragHero)
  self.__OnClickHero = BindCallback(self, self.OnClickHero)
  self.__OnCheckModelDrag = BindCallback(self, self.OnCheckModelDrag)
  self.__OnPullFormationDeal = BindCallback(self, self.OnPullFormationDeal)
  self.__OnClickSelectSupportHero = BindCallback(self, self.OnClickSelectSupportHero)
  self.__OnClickSupportUnavailable = BindCallback(self, self.OnClickSupportUnavailable)
  self.ui.cardList.onInstantiateItem = BindCallback(self, self.OnInstantiateItem)
  self.ui.cardList.onChangeItem = BindCallback(self, self.OnHeroChangeItem)
  self.heroItemDic = {}
  self.showHeroList = nil
  self.__isInOfficialSupport = false
  self.selectCareer = 0
  self.selectCamp = 0
  self.isDesOrder = true
  self.supportHero = UINFormationChoiceSupportItem.New()
  self.supportHero:Init(self.ui.obj_SupportHolder)
  self.ui.obj_Careers:SetActive(false)
  self.ui.obj_Camps:SetActive(false)
  self.careerPool = UIItemPool.New(UINFormationChioceCareerTog, self.ui.tog_Filtrate, false)
  self.campPool = UIItemPool.New(UINFormationChioceCampTog, self.ui.tog_FiltrateCamp, false)
  self.ui.tog_Filtrate.gameObject:SetActive(false)
  self._typeTogglePool = UIItemPool.New(UINFmtHeroFilterTypeToggle, self.ui.toggle)
  self.ui.toggle:SetActive(false)
  self._switchOfficialSupportTog = nil
end

function UINFmtEditNode:InitFmtEditNode(fmtCtrl, enterFmtData)
  self.fmtCtrl = fmtCtrl
  self.enterFmtData = enterFmtData
  self.resloader = self.fmtCtrl:GetFmtCtrlResloader()
end

function UINFmtEditNode:InitTypeTogglePool()
  self._typeTogglePool:HideAll()
  for i = 0, 1 do
    local item = self._typeTogglePool:GetOne()
    if i == 0 then
      item:InitFilterTypeToggle(i, BindCallback(self, self.RefreshCareerTogs))
    elseif i == 1 then
      item:InitFilterTypeToggle(i, BindCallback(self, self.RefreshCampTogs))
    end
  end
end

function UINFmtEditNode:OpenEmtEditNode()
  UIUtil.SetTopStatus(self, self.OnClickQuick)
  AudioManager:PlayAudioById(1077)
  local isForceHideOfficialSupport = false
  if self.enterFmtData:IsFmtInBrotatoDeploy() then
    if self.enterFmtData:GetIsHaveOfficialSupport() then
      self.__isInOfficialSupport = true
    else
      local stageId = self.enterFmtData:GetFmtCtrlFmtIdStageId()
      error("当前brotato关卡[" .. stageId .. "]没有官方助战ID")
    end
    isForceHideOfficialSupport = true
  end
  self.heroDataDic = self:__GetCouldChoiceHeroDic()
  self:RefreshPowerSortBtn()
  self:__RefreshIsShowSwitchOfficialSupport(isForceHideOfficialSupport)
  self:__RefreshIsShowScoreRate()
  self:__RefreshIsShowRecommendFormation()
  if #self._typeTogglePool.listItem <= 0 then
    self:InitTypeTogglePool()
  end
  local selectTypeIndex = 0 < self.selectCamp and 2 or 1
  for i, typeToggle in ipairs(self._typeTogglePool.listItem) do
    typeToggle:OnToggleHeroFilterType(i == selectTypeIndex)
  end
  self:RefreshPowAndEvaluate()
  self:InitFormationSupportHero()
  self.fmtCtrl.fmtSceneCtrl:RegisterPullFormationDragAct(self.__OnCheckModelDrag, self.__OnPullFormationDeal)
  local heroPassStats = self.enterFmtData:GetFmtHeroPassInfo()
  self.ui.btn_CompleteRank.gameObject:SetActive(heroPassStats ~= nil)
  self.ui.btn_LineupCmd.gameObject:SetActive(self.enterFmtData:GetIsShowBtnLineupCmd() and not CS.ClientConsts.IsAudit)
end

function UINFmtEditNode:OnClickQuick(tohome)
  if self.fmtCtrl ~= nil then
    self.fmtCtrl:FmtCtrlQuitEditSate()
  end
  if not tohome then
    GuideManager:TryTriggerGuide(eGuideCondition.InFormation)
    GuideManager:TryTriggerGuide(eGuideCondition.InFormationSpecial)
  end
  self.fmtCtrl.fmtSceneCtrl:RemovePullFormationDragAct()
end

function UINFmtEditNode:RefreshEditNode()
  if not self.active then
    return
  end
  self.heroDataDic = self:__GetCouldChoiceHeroDic()
  self:RefreshHeroList()
  self:RefreshPowAndEvaluate()
  self:RefreshScoreRateNum()
  local fomationData = self.fmtCtrl:GetFmtCtrlFmtData()
  if self.supportHero.heroData ~= fomationData:GetRealSupportHeroData() then
    self:InitFormationSupportHero()
  else
    self.supportHero:SetFmtChoiceSupportItemInFmt(fomationData:GetRealSupportHeroData() ~= nil)
  end
end

function UINFmtEditNode:__GetCouldChoiceHeroDic()
  local fomationData = self.fmtCtrl:GetFmtCtrlFmtData()
  local formationHeroDic = fomationData:GetFormationHeroDic(true)
  local usedHeroDic = {}
  for formatindex, heroId in pairs(formationHeroDic) do
    usedHeroDic[heroId] = true
  end
  if self.enterFmtData:IsFmtInWarChessDeploy() then
    local AllFmtIdDic = {}
    local idOffset = FormationUtil.GetFmtIdOffsetByFmtFromModule(self.enterFmtData:GetFmtCtrlFromModule())
    local curFmtId = self.enterFmtData:GetFmtCtrlFmtId()
    local max = self.enterFmtData:GetFmtTeamSize()
    for i = 1, max do
      local fmtId
      if self.enterFmtData:IsFmtFixedCouldChangeTeam() then
        fmtId = self.enterFmtData:GetFmtFixedChangeTeamFmtId(i)
      end
      if fmtId == nil then
        fmtId = idOffset + i
      end
      if fmtId ~= curFmtId then
        AllFmtIdDic[i] = fmtId
      end
    end
    self.otherFmtHeroDic = {}
    self.otherFmtHeroFmtDic = {}
    for index, fmtId in pairs(AllFmtIdDic) do
      local fmtData = self.fmtCtrl:GetOtherFormationData(fmtId)
      if fmtData ~= nil then
        local fmtHeroDic = fmtData:GetFormationHeroDic(false)
        for fmtIndex, heroId in pairs(fmtHeroDic) do
          self.otherFmtHeroDic[heroId] = true
          self.otherFmtHeroFmtDic[heroId] = {fmtData = fmtData, index = index}
        end
      end
    end
  end
  local heroDataDic = {}
  if self.__isInOfficialSupport then
    local usedOfficalSupportDic = {}
    local curOfficialSupportDic = fomationData:GetIsHaveOfficialSupportDic()
    if curOfficialSupportDic ~= nil then
      for fmtIdx, officialSuppotData in pairs(curOfficialSupportDic) do
        usedOfficalSupportDic[officialSuppotData.heroId] = true
      end
    end
    for heroId, heroData in pairs(self.__allOfficialSupportHeroDataDic) do
      if usedOfficalSupportDic[heroId] == nil then
        heroDataDic[heroId] = heroData
      end
    end
    return heroDataDic
  end
  for heroId, heroData in pairs(PlayerDataCenter.heroDic) do
    if usedHeroDic[heroId] == nil then
      heroDataDic[heroId] = heroData
    end
  end
  return heroDataDic
end

function UINFmtEditNode:RefreshHeroList(isRefresh)
  self.showHeroList = {}
  for heroId, heroData in pairs(self.heroDataDic) do
    if self.nodeType == UINFormationChioceCareerTog.eNodeType.all then
      table.insert(self.showHeroList, heroData)
    elseif self.nodeType == UINFormationChioceCareerTog.eNodeType.byData then
      if heroData.career == self.selectCareer or heroData.camp == self.selectCamp then
        table.insert(self.showHeroList, heroData)
      end
    elseif ConfigData:IsCampBelongOther(heroData.camp) and not ConfigData:IsCampExclude(heroData.camp) then
      table.insert(self.showHeroList, heroData)
    end
  end
  local powerDic = {}
  for _, heroData in pairs(self.showHeroList) do
    powerDic[heroData.dataId] = heroData:GetFightingPower()
  end
  local isInBattleDeploy = self.enterFmtData:IsFmtInBattleDeploy()
  table.sort(self.showHeroList, function(heroDataA, heroDataB)
    local heroDataIdA = heroDataA.dataId
    local heroDataIdB = heroDataB.dataId
    if isInBattleDeploy then
      local fmtDungeonDyncData = self.enterFmtData:GetFmtDungeonDyncData()
      local hpPerA = fmtDungeonDyncData:GetDungeonDyncHeroHpPer(heroDataA)
      local hpPerB = fmtDungeonDyncData:GetDungeonDyncHeroHpPer(heroDataB)
      local deadA = hpPerA == 0
      local deadB = hpPerB == 0
      if deadA ~= deadB then
        return deadB
      end
    end
    local bannedDic = self.enterFmtData:GetCardSetTempBannedHeroDic()
    if bannedDic then
      local bannedA = bannedDic[heroDataIdA]
      local bannedB = bannedDic[heroDataIdB]
      if bannedA ~= bannedB then
        return bannedB
      end
    end
    local wcCtrl = WarChessManager:GetWarChessCtrl()
    if wcCtrl ~= nil then
      local isDeployedA = self.otherFmtHeroDic[heroDataIdA] or wcCtrl.teamCtrl:GetHeroDynDataById(heroDataA.dataId) ~= nil
      local isDeployedB = self.otherFmtHeroDic[heroDataIdB] or wcCtrl.teamCtrl:GetHeroDynDataById(heroDataB.dataId) ~= nil
      if isDeployedA ~= isDeployedB then
        return isDeployedB
      end
      local hpPerA = wcCtrl.teamCtrl:GetWcTeamHeroHpPer(heroDataA.dataId)
      local hpPerB = wcCtrl.teamCtrl:GetWcTeamHeroHpPer(heroDataB.dataId)
      local deadA = hpPerA == 0
      local deadB = hpPerB == 0
      if deadA ~= deadB then
        return deadB
      end
    end
    if powerDic[heroDataA.dataId] == powerDic[heroDataB.dataId] then
      return heroDataA.dataId < heroDataB.dataId
    end
    if self.isDesOrder then
      return powerDic[heroDataA.dataId] > powerDic[heroDataB.dataId]
    else
      return powerDic[heroDataA.dataId] < powerDic[heroDataB.dataId]
    end
  end)
  self.ui.cardList.totalCount = #self.showHeroList
  if isRefresh then
    self.ui.cardList:RefreshCells()
  else
    self.ui.cardList:RefillCells()
  end
  self.ui.obj_noCard:SetActive(self.ui.cardList.totalCount == 0)
end

function UINFmtEditNode:OnInstantiateItem(go)
  local item = UINFormationChoiceItem.New(self.fmtCtrl, self.enterFmtData)
  item:Init(go)
  self.heroItemDic[go] = item
end

function UINFmtEditNode:OnHeroChangeItem(go, index)
  local heroData = self.showHeroList[index + 1]
  local item = self.heroItemDic[go]
  item.ui.cg_heroCardHolder.alpha = 1
  item.ui.tweenHolder.localPosition = Vector2.zero
  item:InitChoiceItem(heroData, self.resloader, self.__OnBeginDragHero, self.__OnDragHero, self.__OnEndDragHero, self.__OnClickHero)
  local hpPer
  if self.enterFmtData:IsFmtInWarChessDeploy() then
    local isShowOtherFmtHero = self.otherFmtHeroDic[heroData.dataId]
    item:SetShowInOtherFmt(isShowOtherFmtHero)
    local wcCtrl = WarChessManager:GetWarChessCtrl()
    if wcCtrl then
      hpPer = wcCtrl.teamCtrl:GetWcTeamHeroHpPer(heroData.dataId)
      item:UpdFmtHeroChoiceItemHp(hpPer)
    end
  end
  if self.enterFmtData:IsFmtInBattleDeploy() then
    hpPer = self.enterFmtData:GetFmtDungeonDyncData():GetDungeonDyncHeroHpPer(heroData)
    item:UpdFmtHeroChoiceItemHp(hpPer)
  end
  if not heroData.isFriendSupport then
    local bannedDic = self.enterFmtData:GetCardSetTempBannedHeroDic()
    item:UpdateIsCanBattle(hpPer, bannedDic)
  end
end

function UINFmtEditNode:__GetFmtHeroItemByIndex(index)
  local go = self.ui.cardList:GetCellByIndex(index)
  if not IsNull(go) then
    return self.heroItemDic[go]
  end
  return nil
end

function UINFmtEditNode:__CalculateUIPosAndCanSeekPlatform(touchPos)
  local uiPos = UIManager:Screen2UIPosition(touchPos, self.transform.gameObject:GetComponent(typeof(CS.UnityEngine.RectTransform)), UIManager.UICamera)
  if self._autoPutPosY == nil then
    local rectTrWordPos = self.ui.rectTr_Touch2Recycle.transform:TransformPoint(Vector3.zero)
    local rectTrlocalPos = self.transform:InverseTransformPoint(rectTrWordPos)
    self._autoPutPosY = rectTrlocalPos.y + self.ui.rectTr_Touch2Recycle.rect.height / 2
  end
  local isCanSeek = uiPos.y > self._autoPutPosY
  return uiPos, isCanSeek
end

function UINFmtEditNode:OnBeginDragHero(eventData, item)
  self.startDragPos = eventData.position
  self.checkDragCount = 3
  self.__dragingHero = false
end

function UINFmtEditNode:OnDragHero(eventData, item)
  if self.checkDragCount >= 0 then
    self.checkDragCount = self.checkDragCount - 1
    if self.checkDragCount == 0 then
      local xDiff = math.abs(eventData.position.x - self.startDragPos.x)
      local yDiff = math.abs(eventData.position.y - self.startDragPos.y)
      if xDiff > yDiff * 3 then
        if self.__guideData ~= nil then
          return
        end
        self.ui.cardList:ChangePointDrag(eventData)
      else
        self.ui.cardList:StopMovement()
        if self.__guideData ~= nil and item.heroData.dataId ~= self.__guideData.heroId then
          return
        end
        if self.enterFmtData:IsFmtInWarChessDeploy() then
          local heroId = item.heroData.dataId
          local isShowOtherFmtHero = self.otherFmtHeroDic[heroId]
          local otherFmtData = self.otherFmtHeroFmtDic[heroId]
          if isShowOtherFmtHero then
            local teamName = otherFmtData.fmtData.name
            if string.IsNullOrEmpty(teamName) then
              teamName = string.format(ConfigData:GetTipContent(TipContent.WarChess_TeamDefaultName), tostring(otherFmtData.index))
            end
            local msg = string.format(ConfigData:GetTipContent(8712), teamName)
            cs_MessageCommon.ShowMessageTipsWithErrorSound(msg)
            return
          end
          local wcCtrl = WarChessManager:GetWarChessCtrl()
          if wcCtrl ~= nil and 0 >= wcCtrl.teamCtrl:GetWcTeamHeroHpPer(item.heroData.dataId) then
            return
          end
        end
        local fmtDungeonDyncData = self.enterFmtData:GetFmtDungeonDyncData()
        if fmtDungeonDyncData ~= nil and 0 >= fmtDungeonDyncData:GetDungeonDyncHeroHpPer(item.heroData) then
          cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(2903))
          item:SetSelectedState(true)
          return
        end
        if self.enterFmtData:IsFmtFixedHeroId(item.heroData.dataId) then
          cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(1002))
          item:SetSelectedState(true)
          return
        end
        if self.enterFmtData:IsBondModule() then
          local bandDic = self.enterFmtData:GetCardSetTempBannedHeroDic()
          if bandDic[item.heroData.dataId] then
            item:SetSelectedState(true)
            return
          end
        end
        item:SetSelectedState(true)
        self.__dragingHero = true
        self.fmtCtrl:FmtCtrlOnStartDraggingCard(item.heroData)
        if self.copyCard == nil then
          self.copyCard = UINFormationChoiceItem.New(self.fmtCtrl, self.enterFmtData)
          local go = self.ui.heroCardHolder:Instantiate(self.transform)
          self.copyCard:Init(go)
          self.copyCard.transform.localScale = Vector3.New(0.8, 0.8, 0.8)
        end
        self.copyCard:Show()
        self.copyCard:InitChoiceItem(item.heroData, self.resloader)
        AudioManager:PlayAudioById(1059)
        if self.enterFmtData:IsFmtInBattleDeploy() then
          local fmtDungeonDyncData = self.enterFmtData:GetFmtDungeonDyncData()
          local hpPer = fmtDungeonDyncData:GetDungeonDyncHeroHpPer(item.heroData)
          self.copyCard:UpdFmtHeroChoiceItemHp(hpPer)
        end
      end
    end
  end
  if not self.__dragingHero then
    return
  end
  local uiPos, isCanSeek = self:__CalculateUIPosAndCanSeekPlatform(eventData.position)
  self.copyCard.transform.localPosition = Vector3.New(uiPos.x, uiPos.y, 0)
  if isCanSeek then
    self.fmtCtrl.fmtSceneCtrl:SeekHeroPutPlatform()
  else
    self.fmtCtrl.fmtSceneCtrl:RecoverHeroPutPlatform()
  end
end

function UINFmtEditNode:OnEndDragHero(eventData, item)
  item:SetSelectedState(false)
  if not self.__dragingHero then
    return
  end
  self.__dragingHero = false
  self.copyCard:Hide()
  self.fmtCtrl:FmtCtrlOnEndDraggingCard()
  local uiPos, isCanSeek = self:__CalculateUIPosAndCanSeekPlatform(eventData.position)
  if not isCanSeek then
    return
  end
  if self.__guideData ~= nil then
    local lastHeroPlat = self.fmtCtrl.fmtSceneCtrl:GetFmtLastSeekHeroPlat()
    if lastHeroPlat ~= nil and lastHeroPlat.fmtIndex == self.__guideData.posId then
      self.__guideData.compelete = true
    else
      self.fmtCtrl.fmtSceneCtrl:RecoverHeroPutPlatform()
    end
  end
  local flag, beReplaceHeroData = self.fmtCtrl.fmtSceneCtrl:ConfirmHeroPutPlatform(self.copyCard.heroData)
  if flag then
    if item.heroData.isFriendSupport then
      item:SetFmtChoiceSupportItemInFmt(true)
    else
      self.heroDataDic[self.copyCard.heroData.dataId] = nil
    end
    if beReplaceHeroData ~= nil then
      if beReplaceHeroData.isFriendSupport then
        self.supportHero:SetFmtChoiceSupportItemInFmt(false)
      elseif beReplaceHeroData.isOfficialSupport or self.__isInOfficialSupport then
        if beReplaceHeroData.isOfficialSupport and self.__isInOfficialSupport then
          self.heroDataDic[beReplaceHeroData.dataId] = beReplaceHeroData
        end
      else
        self.heroDataDic[beReplaceHeroData.dataId] = beReplaceHeroData
      end
    end
    self:RefreshHeroList(true)
    self.fmtCtrl:OnCurrentFmtChanged()
    local voiceId = ConfigData:GetVoicePointRandom(eVoicePointType.EnterTeam, nil, self.copyCard.heroData.dataId)
    local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
    cvCtr:PlayCv(self.copyCard.heroData.dataId, voiceId)
  end
end

function UINFmtEditNode:OnClickHero(heroData)
  if self.__guideData ~= nil then
    return
  end
  if self.copyCard ~= nil and self.copyCard.active then
    return
  end
  if heroData.isFriendSupport then
    return
  end
  if heroData.isOfficialSupport then
    UIManager:ShowWindowAsync(UIWindowTypeID.SupportHeroState, function(win)
      if win == nil then
        return
      end
      win:InitSupportHeroState(heroData)
    end)
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroState, function(win)
    if win ~= nil then
      win:InitHeroState(heroData, self.showHeroList)
    end
  end)
end

function UINFmtEditNode:OnCheckModelDrag(touchPos)
  local uiPos, isCanSeek = self:__CalculateUIPosAndCanSeekPlatform(touchPos)
  self.ui.rectTr_Touch2Recycle.gameObject:SetActive(true)
  self.ui.obj_noCard:SetActive(false)
  if isCanSeek then
    if self.ui.doTween_RecycleImage.tween:IsPlaying() then
      self.ui.doTween_RecycleImage:DOPause()
      self.ui.canvasGroup_RecycleImage.alpha = 1
    end
  elseif not self.ui.doTween_RecycleImage.tween:IsPlaying() then
    self.ui.doTween_RecycleImage:DORestart()
  end
  return not isCanSeek
end

function UINFmtEditNode:OnPullFormationDeal(heroData)
  self.ui.doTween_RecycleImage:DOPause()
  self.ui.canvasGroup_RecycleImage.alpha = 1
  self.ui.rectTr_Touch2Recycle.gameObject:SetActive(false)
  if heroData == nil then
    self.ui.obj_noCard:SetActive(self.ui.cardList.totalCount == 0)
    return
  end
  if heroData.isFriendSupport then
    self.supportHero:SetFmtChoiceSupportItemInFmt(false)
  elseif heroData.isOfficialSupport or self.__isInOfficialSupport then
    if heroData.isOfficialSupport and self.__isInOfficialSupport then
      self.heroDataDic[heroData.dataId] = heroData
    end
  else
    self.heroDataDic[heroData.dataId] = heroData
  end
  self:RefreshHeroList(true)
  self.fmtCtrl:OnCurrentFmtChanged()
end

function UINFmtEditNode:InitFormationSupportHero()
  local fomationData = self.fmtCtrl:GetFmtCtrlFmtData()
  if not self.enterFmtData:GetFmtIsFriendSupport() then
    if self.enterFmtData:GetFmtForceShowSupportNotAvaliable() then
      self.supportHero:Show()
      self.supportHero:InitAsUnavailable(self.__OnClickSupportUnavailable)
      return
    end
    self.supportHero:Hide()
    return
  end
  self.supportHero:Show()
  if self.enterFmtData:GetFmtIsFriendSupportTimeLimitted() then
    self.supportHero:InitAsExhaustCard()
    return
  end
  local supportHeroData = fomationData:GetRealSupportHeroData()
  local inFmt = supportHeroData ~= nil
  if supportHeroData == nil then
    supportHeroData = self.fmtCtrl:GetCacheSelectedSupportHero()
  end
  local fmtDungeonDyncData = self.enterFmtData:GetFmtDungeonDyncData()
  if fmtDungeonDyncData ~= nil and fmtDungeonDyncData:HasDgDyncLastAstHero() then
    local brief, random = fmtDungeonDyncData:GetDgDyncAscHeroData()
    local fixCfg = PlayerDataCenter.supportHeroData:GetCurFormationLevelEffectByAllHero(PlayerDataCenter.heroDic)
    supportHeroData = FriendSupportHeroData.CreatSupportHeroDataBase(brief, random, fixCfg)
  end
  if supportHeroData ~= nil then
    self.supportHero:InitChoiceItem(supportHeroData, self.fmtCtrl.resloader, self.__OnBeginDragHero, self.__OnDragHero, self.__OnEndDragHero, self.__OnClickSelectSupportHero)
    self.supportHero:SetFmtChoiceSupportItemInFmt(inFmt)
    if fmtDungeonDyncData ~= nil then
      local hpPer = fmtDungeonDyncData:GetDungeonDyncHeroHpPer(supportHeroData)
      self.supportHero:UpdFmtHeroChoiceItemHp(hpPer)
    end
  else
    self.supportHero:InitAsEmpuyCard(self.__OnClickSelectSupportHero)
  end
end

function UINFmtEditNode:OnClickSelectSupportHero()
  if self.__guideData ~= nil then
    return
  end
  local fmtDungeonDyncData = self.enterFmtData:GetFmtDungeonDyncData()
  if fmtDungeonDyncData ~= nil and fmtDungeonDyncData:HasDgDyncLastAstHero() then
    cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(2904))
    return
  end
  if self.enterFmtData:GetFmtCtrlFromModule() == FmtEnum.eFmtFromModule.DailyDungeon and FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_DailyDungeonQuick) and not PlayerDataCenter:IsDungeonModuleOpenQuick(fmtDungeonDyncData.moduleId) then
    cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(9307), function()
      self:__EnterSupprtSelect()
    end, nil)
    return
  end
  self:__EnterSupprtSelect()
end

function UINFmtEditNode:__EnterSupprtSelect()
  UIManager:ShowWindowAsync(UIWindowTypeID.SelectSupportList, function(win)
    if win ~= nil then
      UIManager:HideWindow(UIWindowTypeID.Formation)
      local fomationData = self.fmtCtrl:GetFmtCtrlFmtData()
      win:InitSelectSupportHeroList(function(friednSupportHeroData)
        local supportHeroData = fomationData:GetRealSupportHeroData()
        if supportHeroData ~= nil and friednSupportHeroData ~= supportHeroData then
          fomationData:CleanSupportData()
          self.fmtCtrl.fmtSceneCtrl:RefreshFmtScene()
        end
        if friednSupportHeroData ~= nil then
          self.supportHero:InitChoiceItem(friednSupportHeroData, self.fmtCtrl.resloader, self.__OnBeginDragHero, self.__OnDragHero, self.__OnEndDragHero, self.__OnClickSelectSupportHero)
          if fmtDungeonDyncData ~= nil then
            local hpPer = 10000
            self.supportHero:UpdFmtHeroChoiceItemHp(hpPer)
          end
          self.fmtCtrl:CacheSelectedSupportHero(friednSupportHeroData)
        end
      end, self.selectCareer, fomationData)
      win:SetBackFunc(function()
        UIManager:ShowWindowOnly(UIWindowTypeID.Formation, true)
      end)
    end
  end)
end

function UINFmtEditNode:ClearSupportCard()
  self.supportHero:InitAsEmpuyCard(self.__OnClickSelectSupportHero)
end

function UINFmtEditNode:OnClickSupportUnavailable()
  if self.enterFmtData:IsFmtChallengeMode() then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(960))
    return
  end
  if self.enterFmtData:GetFmtCtrlFromModule() == FmtEnum.eFmtFromModule.WarChess and WarChessManager:GetIsMainSectorStageWC() then
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(341))
  end
  cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(7004))
end

function UINFmtEditNode:RefreshPowerSortBtn()
  local color = self.ui.img_ArrowUp.color
  color.a = self.isDesOrder and 0.5 or 1
  self.ui.img_ArrowUp.color = color
  color = self.ui.img_ArrowDown.color
  color.a = self.isDesOrder and 1 or 0.5
  self.ui.img_ArrowDown.color = color
end

function UINFmtEditNode:RefreshCareerTogs()
  if self.__OnClickCareerFiltrate == nil then
    self.__OnClickCareerFiltrate = BindCallback(self, self.OnClickCareerFiltrate)
  end
  self.selectCamp = 0
  self.ui.obj_Careers:SetActive(true)
  self.ui.obj_Camps:SetActive(false)
  self.careerPool:HideAll()
  self.campPool:HideAll()
  local careerMax = HeroFilterEnum.eKindMaxCount[HeroFilterEnum.eKindType.Career]
  for iCareerIndex = 0, careerMax do
    local nodeType
    if iCareerIndex == 0 then
      nodeType = UINFormationChioceCareerTog.eNodeType.all
    else
      nodeType = UINFormationChioceCareerTog.eNodeType.byData
    end
    local careerTog = self.careerPool:GetOne()
    careerTog:InitCareerTog(iCareerIndex, self.__OnClickCareerFiltrate, nodeType)
    if self.selectCareer == iCareerIndex then
      careerTog:SetTogState(true)
    else
      careerTog:SetTogState(false)
    end
  end
end

function UINFmtEditNode:RefreshCampTogs()
  if self.__OnClickCampFlitrate == nil then
    self.__OnClickCampFlitrate = BindCallback(self, self.OnClickCampFlitrate)
  end
  self.prefCampItem = nil
  self.selectCareer = 0
  self.ui.obj_Careers:SetActive(false)
  self.ui.obj_Camps:SetActive(true)
  self.careerPool:HideAll()
  self.campPool:HideAll()
  local campMax = ConfigData:GetCampMaxCount()
  local camWithOther = ConfigData:GetCampCountWithOther()
  local tCount = math.min(campMax, camWithOther)
  for iCareerIndex = 0, tCount do
    local nodeType
    if iCareerIndex == 0 then
      nodeType = UINFormationChioceCareerTog.eNodeType.all
    elseif iCareerIndex == camWithOther then
      nodeType = UINFormationChioceCareerTog.eNodeType.other
    else
      nodeType = UINFormationChioceCareerTog.eNodeType.byData
    end
    local careerTog = self.campPool:GetOne()
    careerTog:InitCompany(iCareerIndex, self.__OnClickCampFlitrate, nodeType)
    if self.selectCamp == iCareerIndex then
      careerTog:SetTogState(true)
    else
      careerTog:SetTogState(false)
    end
  end
end

function UINFmtEditNode:RefreshPowAndEvaluate(totalFtPower, totalBenchPower)
  local isEditShowPow = self.enterFmtData:GetFmtEditIsShowPow()
  local isEditShowEvaluate = self.enterFmtData:GetFmtEditIsShowEvaluate()
  self.ui.curPower:SetActive(isEditShowPow)
  self.ui.evaluation:SetActive(isEditShowEvaluate)
  local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
  if isEditShowEvaluate then
    if self.fmtEvaluation == nil then
      self.fmtEvaluation = UINFmtEvaluation.New()
      self.fmtEvaluation:Init(self.ui.evaluation)
      local sectorStageId = self.enterFmtData:GetFmtCtrlFmtIdStageId()
      local fromModule = self.enterFmtData:GetFmtCtrlFromModule()
      self.fmtEvaluation:InitializeAdvantageConfig(sectorStageId, fromModule)
      for _, careerItem in ipairs(self.careerPool.listItem) do
        careerItem:SetEvaluation(self.fmtEvaluation.advTypeDic[careerItem.advTypeId] == true)
      end
    end
    if formationData ~= nil then
      self.fmtEvaluation:AnalysisFormation(formationData:GetFormationHeroDic())
    end
  end
  if isEditShowPow and formationData ~= nil then
    if totalFtPower == nil then
      totalFtPower, totalBenchPower = self.fmtCtrl:CalculatePower(formationData)
    end
    local power = totalFtPower + totalBenchPower
    self.ui.tex_CurPower.text = tostring(power)
  end
end

function UINFmtEditNode:OnClickResetFomration()
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
    if win ~= nil then
      win:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(389), function()
        local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
        if self.__isInOfficialSupport then
          local officialSptDic = formationData:GetIsHaveOfficialSupportDic()
          if officialSptDic ~= nil then
            for _, officialSuppotData in pairs(officialSptDic) do
              self.heroDataDic[officialSuppotData.heroId] = officialSuppotData.o_heroData
            end
          end
        else
          for _, heroId in pairs(formationData:GetFormationHeroDic(true)) do
            self.heroDataDic[heroId] = self.fmtCtrl.fmtSceneCtrl.heroEntityIdDic[heroId]:GetFmtHeroEntityData()
          end
        end
        formationData.data = {}
        formationData:CleanSupportData()
        self:RefreshHeroList()
        self.fmtCtrl.fmtSceneCtrl:ClearFmtInEditorModel()
        self.fmtCtrl.fmtSceneCtrl:RefreshFmtScene(true)
        self.fmtCtrl:OnCurrentFmtChanged()
        self.supportHero:SetFmtChoiceSupportItemInFmt(false)
      end, nil)
    end
  end)
end

function UINFmtEditNode:OnClickPowerSort()
  self.isDesOrder = not self.isDesOrder
  self:RefreshHeroList()
  self:RefreshPowerSortBtn()
  AudioManager:PlayAudioById(4100)
end

function UINFmtEditNode:OnClickCareerFiltrate(careerId, item, nodeType)
  self.selectCareer = careerId
  self.nodeType = nodeType
  self:RefreshHeroList()
  self.ui.tr_CurSel.gameObject:SetActive(true)
  self.ui.tr_CurSel:SetParent(item.transform)
  self.ui.tr_CurSel.localPosition = Vector3.zero
end

function UINFmtEditNode:OnClickCampFlitrate(campId, item, nodeType)
  if self.prefCampItem ~= nil and self.prefCampItem.gameObject.activeSelf then
    self.prefCampItem:SetCampCurSelActive(false)
  end
  self.prefCampItem = item
  item:SetCampCurSelActive(true)
  self.selectCamp = campId
  self.nodeType = nodeType
  self:RefreshHeroList()
  self.ui.tr_CurSel.gameObject:SetActive(false)
end

function UINFmtEditNode:TryRefreshHeroCard(heroIdDic, isSkin)
  for index, heroData in pairs(self.showHeroList) do
    local heroId = heroData.dataId
    if heroIdDic[heroId] ~= nil then
      local cardItem = self:__GetFmtHeroItemByIndex(index - 1)
      if cardItem ~= nil then
        if isSkin then
          cardItem.heroCardItem:UpdateSkin()
        else
          cardItem.heroCardItem:RefreshHeroCardItem()
          cardItem:OnShowChoiceRedTip()
          cardItem:OnShowChoiceNorTip()
        end
      end
    end
  end
end

function UINFmtEditNode:SetFmtEditorGuideData(heroId, posId)
  self.__guideData = {
    heroId = heroId,
    posId = posId,
    compelete = false
  }
  self.ui.rect_cardList.raycastTarget = false
  self.ui.cardList:StopMovement()
  self.fmtCtrl.fmtSceneCtrl:GuideDisableClickPlat(true)
end

function UINFmtEditNode:IsFmtEditorGuideComplete()
  if self.__guideData == nil then
    return true
  end
  return self.__guideData.compelete
end

function UINFmtEditNode:ClearFmtEditorGuideData()
  self.__guideData = nil
  self.ui.rect_cardList.raycastTarget = true
  self.fmtCtrl.fmtSceneCtrl:GuideDisableClickPlat(false)
end

function UINFmtEditNode:OnFmtCompleteRankClick()
  local heroPassStats = self.enterFmtData:GetFmtHeroPassInfo()
  if heroPassStats == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.FormationRankPreview, function(window)
    if window == nil then
      return
    end
    window:InitFmtRankPreview(heroPassStats)
  end)
end

function UINFmtEditNode:__RefreshIsShowScoreRate()
  local isShow = self.enterFmtData:GetIsShowScoreRate()
  self.ui.obj_ScoreRate:SetActive(isShow)
  self:RefreshScoreRateNum()
end

function UINFmtEditNode:RefreshScoreRateNum()
  local isShow = self.enterFmtData:GetIsShowScoreRate()
  if not isShow then
    return
  end
  local normal = 100
  local rate = self.enterFmtData:GetScoreRateReduceNum()
  local fmtData = self.fmtCtrl:GetFmtCtrlFmtData()
  local heroDic = fmtData:GetIsHaveOfficialSupportDic()
  if heroDic then
    for id, heroId in pairs(heroDic) do
      normal = normal - rate / 10
    end
  end
  self.ui.tex_ScoreRate.text = tostring(FormatNum(normal)) .. "%"
end

function UINFmtEditNode:__RefreshIsShowSwitchOfficialSupport(isForceHide)
  local isHave = self.enterFmtData:GetIsHaveOfficialSupport() and not isForceHide
  self.ui.btn_OfficialSupport.gameObject:SetActive(isHave)
  if isHave and self._switchOfficialSupportTog == nil then
    self._switchOfficialSupportTog = UINCommonSwitchToggle.New()
    self._switchOfficialSupportTog:Init(self.ui.tog_OfficialSupport)
    self._switchOfficialSupportTog:InitCommonSwitchToggle(self.__isInOfficialSupport, nil)
  end
end

function UINFmtEditNode:__RefreshIsShowRecommendFormation()
  local isHave = self.enterFmtData:GetCouldShowWarChessRecommendBtn()
  self.ui.btn_Recommend.gameObject:SetActive(isHave)
end

function UINFmtEditNode:__OnClickOfficialSuport()
  if self.__isInOfficialSupport then
    self.__allOfficialSupportHeroDataDic = nil
  else
    local allOfficialSupportHeroDataDic = self.enterFmtData:GetIsHaveOfficialSupportHeroDic()
    self.__allOfficialSupportHeroDataDic = allOfficialSupportHeroDataDic
  end
  self.__isInOfficialSupport = not self.__isInOfficialSupport
  self._switchOfficialSupportTog:SetCommonSwitchToggleValue(self.__isInOfficialSupport)
  if self.__officialUpportsSquence ~= nil then
    self.__officialUpportsSquence:Kill()
    self.__officialUpportsSquence = nil
  end
  local sequence = cs_DOTween.Sequence()
  sequence:AppendInterval(0.01)
  for go, cardItem in pairs(self.heroItemDic) do
    sequence:Join(cardItem.ui.tweenHolder:DOLocalMoveY(-200, 0.2))
    sequence:Join(cardItem.ui.cg_heroCardHolder:DOFade(0, 0.2))
  end
  sequence:AppendInterval(0.2)
  sequence:AppendCallback(function()
    self:RefreshEditNode()
  end)
  sequence:AppendCallback(function()
    for index, heroData in ipairs(self.showHeroList) do
      index = index - 1
      local cardItem = self:__GetFmtHeroItemByIndex(index)
      if cardItem == nil then
        break
      end
      cardItem.ui.cg_heroCardHolder.alpha = 0
      cardItem.ui.tweenHolder.localPosition = Vector2.zero
      cardItem.ui.tweenHolder:DOKill()
      cardItem.ui.tweenHolder:DOLocalMoveY(-200, 0.2):From():SetDelay(0.015 * index):SetLink(cardItem.ui.tweenHolder.gameObject)
      cardItem.ui.cg_heroCardHolder:DOKill()
      cardItem.ui.cg_heroCardHolder:DOFade(1, 0.2):SetDelay(0.015 * index):SetLink(cardItem.ui.cg_heroCardHolder.gameObject)
    end
  end)
  self.__officialUpportsSquence = sequence
end

function UINFmtEditNode:__OnClickRecommendFormation()
  UIManager:ShowWindowAsync(UIWindowTypeID.RecommeFormationWindow, function(window)
    if window == nil then
      return
    end
    local recommendTeamList = self.enterFmtData:GetRecommendTeam()
    local recommendSkillDataList = self.enterFmtData:GetRecommendSkillData()
    window:InitFmtRecommendTeamAndSkill(recommendTeamList, recommendSkillDataList)
    window.gameObject.transform:SetAsLastSibling()
  end)
end

function UINFmtEditNode:__OnClickLineupCmd()
  UIManager:ShowWindowAsync(UIWindowTypeID.LineupRecommend, function(window)
    if window == nil then
      return
    end
    local ids
    local fmtCtrl = ControllerManager:GetController(ControllerTypeId.Formation)
    if fmtCtrl ~= nil then
      local enterFmtData = fmtCtrl:GetCurEnterFmtData()
      local cfg = enterFmtData:GetStageCfg()
      if cfg ~= nil then
        ids = cfg.up_team_strategy
      end
    end
    window:InitLineupRecommend(ids)
  end)
end

function UINFmtEditNode:OnClickChioceClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UINFmtEditNode:OnDelete()
  UIManager:DeleteWindow(UIWindowTypeID.RecommeFormationWindow)
  if self.__officialUpportsSquence ~= nil then
    self.__officialUpportsSquence:Kill()
    self.__officialUpportsSquence = nil
  end
end

return UINFmtEditNode
