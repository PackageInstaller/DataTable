local UIDormFightFmtEditNode = class("UIDormFightFmtEditNode", UIBaseNode)
local base = UIBaseNode
local UINFormationChioceCareerTog = require("Game.Formation.UI.2DFormation.UINFormationChioceCareerTog")
local UINFmtHeroFilterTypeToggle = require("Game.Formation.UI.2DFormation.UINFmtHeroFilterTypeToggle")
local HeroFilterEnum = require("Game.Hero.NewUI.HeroFilterEnum")
local UINFormationChoiceItem = require("Game.Formation.UI.2DFormation.UINFormationChoiceItem")

function UIDormFightFmtEditNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.selectCamp = 0
  self.heroItemDic = {}
  self._typeTogglePool = UIItemPool.New(UINFmtHeroFilterTypeToggle, self.ui.toggle)
  self.ui.toggle:SetActive(false)
  self.careerPool = UIItemPool.New(UINFormationChioceCareerTog, self.ui.tog_Filtrate)
  self.ui.tog_Filtrate.gameObject:SetActive(false)
  self.ui.cardList.onInstantiateItem = BindCallback(self, self.OnInstantiateItem)
  self.ui.cardList.onChangeItem = BindCallback(self, self.OnHeroChangeItem)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_ReSet, self, self.OnClickResetFomration)
  self.__OnBeginDragHero = BindCallback(self, self.OnBeginDragHero)
  self.__OnDragHero = BindCallback(self, self.OnDragHero)
  self.__OnEndDragHero = BindCallback(self, self.OnEndDragHero)
  self.__OnCheckModelDrag = BindCallback(self, self.OnCheckModelDrag)
  self.__OnPullFormationDeal = BindCallback(self, self.OnPullFormationDeal)
end

function UIDormFightFmtEditNode:InitFmtEditNode(fmtCtrl)
  self.fmtCtrl = fmtCtrl
  self.resloader = self.fmtCtrl:GetResloader()
  self._typeTogglePool:HideAll()
  local item = self._typeTogglePool:GetOne()
  item:InitFilterTypeToggle(0, BindCallback(self, self.RefreshCampTogs))
end

function UIDormFightFmtEditNode:__GetCouldChoiceHeroDic()
  local dormFightItemCfg = ConfigData.dorm_fight_item
  local fomationData = self.fmtCtrl:GetDfFormationData()
  local formationHeroDic = fomationData:GetFormationHeroDic()
  local usedHeroDic = {}
  for formatindex, heroId in pairs(formationHeroDic) do
    usedHeroDic[heroId] = true
  end
  local heroDataDic = {}
  for heroId, heroData in pairs(PlayerDataCenter.heroDic) do
    if not usedHeroDic[heroId] and (dormFightItemCfg[heroData.skinId] ~= nil or dormFightItemCfg[(heroId + 2000) * 100 + 1] ~= nil) then
      heroDataDic[heroId] = heroData
    end
  end
  return heroDataDic
end

function UIDormFightFmtEditNode:OpenEditNode()
  AudioManager:PlayAudioById(1077)
  self.heroDataDic = self:__GetCouldChoiceHeroDic()
  local selectTypeIndex = self.selectCamp > 0 and 2 or 1
  for i, typeToggle in ipairs(self._typeTogglePool.listItem) do
    typeToggle:OnToggleHeroFilterType(i == selectTypeIndex)
  end
  self:RefreshHeroList()
  self.fmtCtrl:RegisterPullFormationDragAct(self.__OnCheckModelDrag, self.__OnPullFormationDeal)
end

function UIDormFightFmtEditNode:CloseEditNode()
  self.fmtCtrl:RegisterPullFormationDragAct(nil, nil)
end

function UIDormFightFmtEditNode:_RefreshSelectCount(currentCount, MaxCount)
  self.ui.Tex_Num.text = currentCount .. "/" .. MaxCount
end

function UIDormFightFmtEditNode:RefreshHeroList(isRefresh)
  self.showHeroList = {}
  for heroId, heroData in pairs(self.heroDataDic) do
    if self.selectCamp == 0 or heroData.camp == self.selectCamp then
      table.insert(self.showHeroList, heroData)
    end
  end
  self.ui.cardList.totalCount = #self.showHeroList
  if isRefresh then
    self.ui.cardList:RefreshCells()
  else
    self.ui.cardList:RefillCells()
  end
  local currentCount = self.fmtCtrl:GetSelectedFighterCount()
  local maxCount = self.fmtCtrl:GetMaxFighterCount()
  self:_RefreshSelectCount(currentCount, maxCount)
end

function UIDormFightFmtEditNode:OnInstantiateItem(go)
  local item = UINFormationChoiceItem.New(self.fmtCtrl, self.enterFmtData)
  item:Init(go)
  self.heroItemDic[go] = item
end

function UIDormFightFmtEditNode:OnHeroChangeItem(go, index)
  local heroData = self.showHeroList[index + 1]
  local item = self.heroItemDic[go]
  item.ui.cg_heroCardHolder.alpha = 1
  item.ui.tweenHolder.localPosition = Vector2.zero
  item:InitChoiceItem(heroData, self.resloader, self.__OnBeginDragHero, self.__OnDragHero, self.__OnEndDragHero, self.__OnClickHero)
  self:RefreshFormationChoiceItemDormfightTag(item, heroData)
end

function UIDormFightFmtEditNode:RefreshFormationChoiceItemDormfightTag(item, heroData)
  if item == nil or heroData == nil then
    return
  end
  local heroId = heroData.dataId
  local skinId = heroData.skinId
  if skinId == 0 then
    skinId = (heroId + 2000) * 100 + 1
  end
  local dormFightTagIndex = ConfigData.dorm_fight_fighter_data[skinId].heroFeature
  local colorList = {}
  UIUtil.LuaUIBindingTable(item.ui.img_Tag.transform, colorList)
  item.ui.img_Tag.color = colorList[tostring(dormFightTagIndex)]
  item.ui.tex_Tag:SetIndex(dormFightTagIndex - 1)
end

function UIDormFightFmtEditNode:RefreshCampTogs()
  if self.__OnClickCampFlitrate == nil then
    self.__OnClickCampFlitrate = BindCallback(self, self.OnClickCampFlitrate)
  end
  self.selectCareer = 0
  self.careerPool:HideAll()
  local careerMax = HeroFilterEnum.eKindMaxCount[HeroFilterEnum.eKindType.Camp]
  for i = 0, careerMax do
    local careerTog = self.careerPool:GetOne()
    careerTog:InitCompany(i, self.__OnClickCampFlitrate)
    careerTog.careerId = i
    if self.selectCamp == i then
      careerTog:SetTogState(true)
    end
  end
end

function UIDormFightFmtEditNode:OnClickCampFlitrate(campId, item)
  self.selectCamp = campId
  self:RefreshHeroList()
  self.ui.tr_CurSel:SetParent(item.transform)
  self.ui.tr_CurSel.localPosition = Vector3.zero
end

function UIDormFightFmtEditNode:OnBeginDragHero(eventData, item)
  self.startDragPos = eventData.position
  self.checkDragCount = 3
  self.__dragingHero = false
end

function UIDormFightFmtEditNode:OnDragHero(eventData, item)
  if self.checkDragCount >= 0 then
    self.checkDragCount = self.checkDragCount - 1
    if self.checkDragCount == 0 then
      local xDiff = math.abs(eventData.position.x - self.startDragPos.x)
      local yDiff = math.abs(eventData.position.y - self.startDragPos.y)
      if xDiff > yDiff * 3 then
        self.ui.cardList:ChangePointDrag(eventData)
      else
        self.ui.cardList:StopMovement()
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
        self:RefreshFormationChoiceItemDormfightTag(self.copyCard, item.heroData)
        AudioManager:PlayAudioById(1059)
      end
    end
  end
  if not self.__dragingHero then
    return
  end
  local uiPos, isCanSeek = self:__CalculateUIPosAndCanSeekPlatform(eventData.position)
  self.copyCard.transform.localPosition = Vector3.New(uiPos.x, uiPos.y, 0)
  if isCanSeek then
    self.fmtCtrl:SeekHeroPutPlatform()
  else
    self.fmtCtrl:RecoverHeroPutPlatform()
  end
end

function UIDormFightFmtEditNode:OnEndDragHero(eventData, item)
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
  local flag, beReplaceHeroData = self.fmtCtrl:ConfirmHeroPutPlatform(self.copyCard.heroData)
  if flag then
    if item.heroData.isFriendSupport then
      item:SetFmtChoiceSupportItemInFmt(true)
    else
      self.heroDataDic[self.copyCard.heroData.dataId] = nil
    end
    if beReplaceHeroData ~= nil then
      self.heroDataDic[beReplaceHeroData.dataId] = beReplaceHeroData
    end
    self:RefreshHeroList(true)
    self.fmtCtrl:OnCurrentFmtChanged()
    local voiceId = ConfigData:GetVoicePointRandom(eVoicePointType.EnterTeam, nil, self.copyCard.heroData.dataId)
    local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
    cvCtr:PlayCv(self.copyCard.heroData.dataId, voiceId)
  end
end

function UIDormFightFmtEditNode:OnCheckModelDrag(touchPos)
  local uiPos, isCanSeek = self:__CalculateUIPosAndCanSeekPlatform(touchPos)
  self.ui.rectTr_Touch2Recycle.gameObject:SetActive(true)
  self.ui.obj_noCard:SetActive(false)
  return not isCanSeek
end

function UIDormFightFmtEditNode:OnPullFormationDeal(heroData)
  self.ui.rectTr_Touch2Recycle.gameObject:SetActive(false)
  if heroData == nil then
    self.ui.obj_noCard:SetActive(self.ui.cardList.totalCount == 0)
    return
  end
  self.heroDataDic[heroData.dataId] = heroData
  self:RefreshHeroList(true)
  self.fmtCtrl:OnCurrentFmtChanged()
end

function UIDormFightFmtEditNode:__CalculateUIPosAndCanSeekPlatform(touchPos)
  local uiPos = UIManager:Screen2UIPosition(touchPos, self.transform.gameObject:GetComponent(typeof(CS.UnityEngine.RectTransform)), UIManager.UICamera)
  if self._autoPutPosY == nil then
    local rectTrWordPos = self.ui.rectTr_Touch2Recycle.transform:TransformPoint(Vector3.zero)
    local rectTrlocalPos = self.transform:InverseTransformPoint(rectTrWordPos)
    self._autoPutPosY = rectTrlocalPos.y + self.ui.rectTr_Touch2Recycle.rect.height / 2
  end
  local isCanSeek = uiPos.y > self._autoPutPosY
  return uiPos, isCanSeek
end

function UIDormFightFmtEditNode:OnClickClose()
  if self.fmtCtrl ~= nil then
    self.fmtCtrl:ExitEditSate()
  end
end

function UIDormFightFmtEditNode:OnClickResetFomration()
  UIManager:ShowWindowAsync(UIWindowTypeID.MessageCommon, function(win)
    if win ~= nil then
      win:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(389), function()
        local formationData = self.fmtCtrl:GetDfFormationData()
        for _, heroId in pairs(formationData:GetFormationHeroDic()) do
          self.heroDataDic[heroId] = self.fmtCtrl.heroEntityIdDic[heroId]:GetFmtHeroEntityData()
        end
        self.fmtCtrl:ClearFmtInEditorModel()
        self:RefreshHeroList()
      end, nil)
    end
  end)
end

function UIDormFightFmtEditNode:OnDelete()
  if self._typeTogglePool ~= nil then
    self._typeTogglePool:HideAll()
    self._typeTogglePool:DeleteAll()
    self._typeTogglePool = nil
  end
  if self.careerPool ~= nil then
    self.careerPool:HideAll()
    self.careerPool:DeleteAll()
    self.careerPool = nil
  end
  if self.heroItemDic ~= nil then
    for go, item in pairs(self.heroItemDic) do
      item:Delete()
    end
    self.heroItemDic = nil
  end
  base.OnDelete(self)
end

return UIDormFightFmtEditNode
