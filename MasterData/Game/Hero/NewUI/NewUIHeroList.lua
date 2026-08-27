local NewUIHeroList = class("NewUIHeroList", UIBaseWindow)
local base = UIBaseWindow
local HeroFilterEnum = require("Game.Hero.NewUI.HeroFilterEnum")
local HeroSortEnum = require("Game.Hero.NewUI.HeroSortEnum")
local HeroListStateEnum = require("Game.Hero.NewUI.HeroListStateEnum")
local UINHeroSortList = require("Game.Hero.NewUI.SortList.UINHeroSortList")
local UINSortButtonGroup = require("Game.Hero.NewUI.SortList.UINSortButtonGroup")
local UINSiftCondition = require("Game.Hero.NewUI.SortList.UINSiftCondition")
local UINHeroListFavorHeroNode = require("Game.Hero.NewUI.UINHeroListFavorHeroNode")
local cs_ResLoader = CS.ResLoader
local cs_DoTween = CS.DG.Tweening.DOTween

function NewUIHeroList:OnInit()
  self:__InitUI()
  self:__InitData()
  self:SetHeroListTweens()
  self.__onHeroListUpdate = BindCallback(self, self.__OnHeroListUpdate)
  self.__siftFunction = BindCallback(self, self.__SiftFunction)
  MsgCenter:AddListener(eMsgEventId.UpdateHero, self.__onHeroListUpdate)
end

function NewUIHeroList:__InitUI()
  UIUtil.SetTopStatus(self, self.OnReturnClicked, nil, nil, nil)
  UIUtil.AddButtonListener(self.ui.btn_Filter, self, self.__OnBtnFilterClick)
  UIUtil.AddValueChangedListener(self.ui.tog_ShowAllHero, self, self.__OnClickShowAllHeroTog)
  if CS.ClientConsts.IsAudit then
    self.ui.collect:SetActive(false)
    self.ui.tog_ShowAllHero.gameObject:SetActive(false)
  else
    self.ui.tog_ShowAllHero.gameObject:SetActive(true)
  end
  self.ui.sortConditionNode:SetActive(false)
  self.ui.btn_Comfirm.gameObject:SetActive(false)
  self:ShowHeroCollection()
end

function NewUIHeroList:__InitData()
  self.resloader = cs_ResLoader.Create()
  self.__returnEvent = nil
  self.__onSelHeroItemClick = BindCallback(self, self.OnSelHeroItemClick)
  self.__onFilterConfirmAction = BindCallback(self, self.__OnFilterConfirmAction)
  self.__onBtnSortItemClick = BindCallback(self, self.__OnBtnSortItemClick)
  self.__heroListFlag = HeroListStateEnum.eHeroListFlag.none
  self:__InitHeroList()
  self:__InitSortButtonGroup()
  self:__InitFavorHeroNode()
  self:InitRedDotEvent()
end

function NewUIHeroList:ChangeHeroListFlage(isAdd, flagEnum)
  if isAdd then
    self.__heroListFlag = self.__heroListFlag | flagEnum
  else
    self.__heroListFlag = self.__heroListFlag & ~flagEnum
  end
  if self.heroSortList == nil then
    self:__InitHeroList()
  end
  self.heroSortList:RefreshHeroSortList(self.__siftFunction, nil, self.__heroListFlag)
  self.favorHeroNode:OnHeroListFlageChange(self.__heroListFlag)
end

function NewUIHeroList:__OnHeroListUpdate(heroList)
  self:ShowHeroCollection()
end

function NewUIHeroList:InitRedDotEvent()
  function self.__onHeroCardRedDotEvent(node)
    local heroItem = self.heroSortList:__GetHeroItemById(node.nodeId)
    
    if heroItem ~= nil then
      heroItem:SetRedDotActive(node:GetRedDotCount() > 0)
    end
  end
  
  RedDotController:AddListener(RedDotDynPath.HeroCardPath, self.__onHeroCardRedDotEvent)
end

function NewUIHeroList:RemoveRedDotEvent()
  RedDotController:RemoveListener(RedDotDynPath.HeroCardPath, self.__onHeroCardRedDotEvent)
end

function NewUIHeroList:SetReturnEvent(returnEvent)
  self.__returnEvent = returnEvent
end

function NewUIHeroList:OnReturnClicked()
  if self.__returnEvent ~= nil then
    self.__returnEvent()
    self.__returnEvent = nil
  else
    self:CloseSelf()
  end
end

function NewUIHeroList:__InitHeroList()
  if self.heroSortList == nil then
    local HeroSortList = UINHeroSortList.New()
    HeroSortList:Init(self.ui.heroListFade.gameObject)
    HeroSortList:SetShowRedDotActive(true)
    HeroSortList:InitHeroSortList(self.resloader, nil, self.__onSelHeroItemClick, true, nil, false, nil, nil, true, true)
    HeroSortList:ShowHeroPower(true)
    self.heroSortList = HeroSortList
    
    function self.heroSortList.ui.scrollRest.onReturnItem(go)
      if self.ui.head.constraintActive then
        local heroItem = self.heroSortList.heroItemDic[go]
        local heroData = heroItem.heroData
        local index = table.indexof(self.heroSortList.curHeroList, heroData)
        if index == 1 then
          self.ui.head.constraintActive = false
        end
      end
    end
    
    self.heroSortList:SetChangeItemCallback(function(index)
      if index == 1 then
        self.ui.head.constraintActive = true
      end
    end)
  end
end

function NewUIHeroList:OnSelHeroItemClick(heroData, selectItem, afterClickCallback)
  if heroData == nil then
    return
  end
  if HeroListStateEnum.isHaveFlag(self.__heroListFlag, HeroListStateEnum.eHeroListFlag.editorFavor) then
    local heroId = heroData.dataId
    local isFavorHero = PlayerDataCenter.favorHeroData:IsFavorHero(heroId)
    if isFavorHero then
      PlayerDataCenter.favorHeroData:SetIsFavorHero(heroId, false)
      selectItem:SetSelectActive(false)
    else
      PlayerDataCenter.favorHeroData:SetIsFavorHero(heroId, true)
      selectItem:SetSelectActive(true, nil, true)
    end
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroState, function(windows)
    if windows == nil then
      error(LanguageUtil.GetLocaleText(heroData.name) .. "Click can't show state")
      return
    end
    local heroList = {}
    for index, heroData in ipairs(self.heroSortList.curHeroList) do
      if not heroData.isLockedHero then
        table.insert(heroList, heroData)
      end
    end
    windows:InitHeroState(heroData, heroList, function()
      self.heroSortList:RefreshHeroSortList(self.__siftFunction, nil, self.__heroListFlag, true)
      for go, heroItem in pairs(self.heroSortList.heroItemDic) do
        heroItem:RefreshHeroCardItem()
        heroItem:RefreshFightPower()
      end
    end)
    windows:RegistFromeWindowTypeID(UIWindowTypeID.HeroList)
    TimerManager:StartTimer(1, function()
      local parWin = UIManager:GetWindow(UIWindowTypeID.HeroList)
      if parWin ~= nil then
        parWin:Hide()
      end
      if afterClickCallback ~= nil then
        afterClickCallback()
      end
    end, nil, true, true, true)
  end)
end

function NewUIHeroList:__InitSortButtonGroup()
  if self.sortButtonGroup == nil then
    local sortButtonGroup = UINSortButtonGroup.New()
    sortButtonGroup:Init(self.ui.buttonGroup)
    sortButtonGroup:InitSortButtonGroup(HeroSortEnum.SortMannerDefine, self.__onBtnSortItemClick, HeroSortEnum.eSortResource.heroList)
    self.sortButtonGroup = sortButtonGroup
  end
end

function NewUIHeroList:__InitFavorHeroNode()
  self.favorHeroNode = UINHeroListFavorHeroNode.New()
  self.favorHeroNode:Init(self.ui.favorHeroBindHelper)
  self.favorHeroNode:InitFavorHeroNode(self)
  self.favorHeroNode:OnHeroListFlageChange(self.__heroListFlag)
end

function NewUIHeroList:__OnBtnSortItemClick(sortFunc)
  if self.heroSortList == nil then
    self:__InitHeroList()
  end
  self.heroSortList:RefreshHeroSortList(self.__siftFunction, sortFunc, self.__heroListFlag)
end

function NewUIHeroList:__OnBtnFilterClick()
  if self.siftCondition == nil then
    local SiftConditionPage = UINSiftCondition.New()
    SiftConditionPage:Init(self.ui.sortConditionNode)
    SiftConditionPage:InitSiftCondition(HeroFilterEnum.eKindType, HeroFilterEnum.eKindMaxCount, self.__onFilterConfirmAction)
    self.siftCondition = SiftConditionPage
  end
  self.siftCondition:Show()
end

function NewUIHeroList:__OnClickShowAllHeroTog(bool)
  self:ChangeHeroListFlage(bool, HeroListStateEnum.eHeroListFlag.showLocked)
end

function NewUIHeroList:__OnFilterConfirmAction(sortKindData)
  self.sortKindData = sortKindData
  if self.heroSortList == nil then
    self:__InitHeroList()
  end
  self.heroSortList:RefreshHeroSortList(self.__siftFunction, nil, self.__heroListFlag)
  self.favorHeroNode:OnHeroListFlageChange(self.__heroListFlag)
end

function NewUIHeroList:__SiftFunction(heroData)
  local isShowFavor = HeroListStateEnum.isHaveFlag(self.__heroListFlag, HeroListStateEnum.eHeroListFlag.showFavor)
  local isEditorFavor = HeroListStateEnum.isHaveFlag(self.__heroListFlag, HeroListStateEnum.eHeroListFlag.editorFavor)
  if heroData.isLockedHero and (isEditorFavor or isShowFavor) then
    return false
  end
  if not isEditorFavor and isShowFavor and not PlayerDataCenter.favorHeroData:IsFavorHero(heroData.dataId) then
    return false
  end
  if self.sortKindData == nil then
    return true
  end
  local rareConfig = self.sortKindData[HeroFilterEnum.eKindType.Rank]
  local Star = math.floor(heroData.rank / 2)
  if Star == 0 then
    Star = 1
  end
  local rankOk = rareConfig.nocondition or rareConfig.selectIndexs[Star]
  if not rankOk then
    return false
  end
  local campConfig = self.sortKindData[HeroFilterEnum.eKindType.Camp]
  local isBelongOther = ConfigData:IsCampBelongOther(heroData.camp) and campConfig.selectIndexs[ConfigData:GetCampCountWithOther()]
  local isExclude = ConfigData:IsCampExclude(heroData.camp)
  local campOk = campConfig.nocondition or campConfig.selectIndexs[heroData.camp] or isBelongOther
  campOk = campOk and not isExclude
  if not campOk then
    return false
  end
  local careerConfig = self.sortKindData[HeroFilterEnum.eKindType.Career]
  local careerOk = careerConfig.nocondition or careerConfig.selectIndexs[heroData.career]
  if not careerOk then
    return false
  end
  local vowConfig = self.sortKindData[HeroFilterEnum.eKindType.Vowed]
  local index = ConfigData.game_config.heroVowed
  if not heroData:GetHeroIsVowed() then
    index = index + 1
  end
  local vowedOk = vowConfig.nocondition or vowConfig.selectIndexs[index]
  if not vowedOk then
    return false
  end
  return true
end

function NewUIHeroList:ShowHeroCollection()
  local totalCount = ConfigData.hero_data.totalShowHeroCount
  local haveCount = PlayerDataCenter.heroCount - PlayerDataCenter.hideHeroCount
  local collectRate = 0
  collectRate = math.ceil(haveCount / totalCount * 100)
  self.ui.tex_Trim.gameObject:SetActive(0 < collectRate / 100)
  self.ui.tex_Collect:SetIndex(0, tostring(collectRate))
end

function NewUIHeroList:SetHeroListTweens()
  self.ui.decorFade.alpha = 0
  self.ui.heroListFade.alpha = 0
  self.pageSequence = cs_DoTween.Sequence()
  self.pageSequence:Append(self.ui.decorFade:DOFade(1, 0.1):SetLoops(3))
  self.pageSequence:Append(self.ui.heroListFade:DOFade(1, 0.15))
  self.pageSequence:SetDelay(0.1)
  self.pageSequence:SetAutoKill(false)
end

function NewUIHeroList:DeleteHeroListTweens()
  if self.pageSequence ~= nil then
    self.pageSequence:Kill()
    self.pageSequence = nil
  end
end

function NewUIHeroList:Roll2Hero(heroId)
  local targetIndex
  for index, heroData in ipairs(self.heroSortList.curHeroList) do
    if heroData.dataId == heroId then
      targetIndex = index - 1
      return
    end
  end
  self.heroSortList:SrollToCell(targetIndex, 5000)
end

function NewUIHeroList:CloseSelf()
  self:Delete()
end

function NewUIHeroList:Delete()
  self:OnCloseWin()
  if self.fromType == eBaseWinFromWhere.home then
    local homeWin = UIManager:GetWindow(UIWindowTypeID.Home)
    if homeWin ~= nil then
      AudioManager:RemoveAllVoice()
    end
  end
  base.Delete(self)
end

function NewUIHeroList:OnDelete()
  self:RemoveRedDotEvent()
  MsgCenter:RemoveListener(eMsgEventId.UpdateHero, self.__onHeroListUpdate)
  MsgCenter:Broadcast(eMsgEventId.UIHeroListClosed)
  if self.sortButtonGroup ~= nil then
    self.sortButtonGroup:Delete()
  end
  if self.siftCondition ~= nil then
    self.siftCondition:Delete()
  end
  if self.heroSortList ~= nil then
    self.heroSortList:Delete()
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  PlayerDataCenter.favorHeroData:CleanFavorHeroBuffDic()
  self.favorHeroNode:Delete()
  self:DeleteHeroListTweens()
  base.OnDelete(self)
end

return NewUIHeroList
