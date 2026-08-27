local UISelectBoardHero = class("UISelectBoardHero", UIBaseWindow)
local base = UIBaseWindow
local CS_ResLoader = CS.ResLoader
local util = require("XLua.Common.xlua_util")
local UINHeroSortList = require("Game.Hero.NewUI.SortList.UINHeroSortList")
local UINSortButtonGroup = require("Game.Hero.NewUI.SortList.UINSortButtonGroup")
local UINSiftCondition = require("Game.Hero.NewUI.SortList.UINSiftCondition")
local HeroSortEnum = require("Game.Hero.NewUI.HeroSortEnum")
local HeroFilterEnum = require("Game.Hero.NewUI.HeroFilterEnum")

function UISelectBoardHero:OnInit()
  self.changeBoardHeroCallback = nil
  UIUtil.SetTopStatus(self, self.OnReturnClick)
  UIUtil.AddButtonListener(self.ui.btn_Comfirm, self, self.Confirm)
  UIUtil.AddButtonListener(self.ui.btn_Filter, self, self.OnBtnFilterClick)
  self.ui.btn_Comfirm.gameObject:SetActive(true)
  self.resloader = CS_ResLoader.Create()
  local HeroSortList = UINHeroSortList.New()
  HeroSortList:Init(self.ui.heroListFade.gameObject)
  HeroSortList:InitHeroSortList(self.resloader, nil, BindCallback(self, self._OnSelectHeroItem), false, false, true, false)
  HeroSortList:SetHeroListAnchorPosOffset(1)
  HeroSortList:RefreshHeroSortList()
  HeroSortList:ShowHeroPower(false)
  self.heroSortList = HeroSortList
  local sortButtonGroup = UINSortButtonGroup.New()
  sortButtonGroup:Init(self.ui.buttonGroup)
  self.sortButtonGroup = sortButtonGroup
  self.sortButtonGroup:InitSortButtonGroup(HeroSortEnum.SortMannerDefine, BindCallback(self, self.__OnBtnSortItemClick), HeroSortEnum.eSortResource.boardHero)
end

function UISelectBoardHero:InitSelectBoardHero(heroData)
  self._isInit = true
  self.OriginalHeroData = heroData
  self.heroSortList:__RefreshSelectHero(heroData)
  self:ShowHeroCollection()
  self._isInit = false
end

function UISelectBoardHero:_OnSelectHeroItem(heroData, selectItem)
  if self._selectHeroData ~= heroData then
    self._selectHeroData = heroData
    if not self._isInit then
      AudioManager:PlayAudioById(1058)
    end
  end
end

function UISelectBoardHero:__OnBtnSortItemClick(sortFunc)
  self.heroSortList:RefreshHeroSortList(nil, sortFunc)
end

function UISelectBoardHero:OnBtnFilterClick()
  if self.siftCondition == nil then
    local SiftConditionPage = UINSiftCondition.New()
    SiftConditionPage:Init(self.ui.sortConditionNode)
    SiftConditionPage:InitSiftCondition(HeroFilterEnum.eKindType, HeroFilterEnum.eKindMaxCount, BindCallback(self, self.OnFilterConfirmAction))
    self.siftCondition = SiftConditionPage
  end
  self.siftCondition:Show()
end

function UISelectBoardHero:OnFilterConfirmAction(sortKindData)
  self.sortKindData = sortKindData
  if self.__SiftFunction == nil then
    self.__SiftFunction = BindCallback(self, self.SiftFunction)
  end
  self.heroSortList:RefreshHeroSortList(self.__SiftFunction, nil)
end

function UISelectBoardHero:SiftFunction(heroData)
  local rareConfig = self.sortKindData[HeroFilterEnum.eKindType.Rank]
  local Star = math.floor(heroData.rank / 2)
  if Star == 0 then
    Star = 1
  end
  local rankOk = rareConfig.nocondition or rareConfig.selectIndexs[Star]
  local campConfig = self.sortKindData[HeroFilterEnum.eKindType.Camp]
  local campOk = campConfig.nocondition or campConfig.selectIndexs[heroData.camp]
  local careerConfig = self.sortKindData[HeroFilterEnum.eKindType.Career]
  local careerOk = careerConfig.nocondition or careerConfig.selectIndexs[heroData.career]
  if rankOk and campOk and careerOk then
    return true
  else
    return false
  end
end

function UISelectBoardHero:Confirm()
  if self.changeBoardHeroCallback ~= nil and self.OriginalHeroData.dataId ~= self.heroSortList.selectHero.dataId then
    self.changeBoardHeroCallback(self.heroSortList.selectHero, function()
      NetworkManager:GetNetwork(NetworkTypeID.Object):CS_User_ModifyShowGirl(self.heroSortList.selectHero.dataId)
      AudioManager:RemoveAllVoice(true)
      
      local function waitFunc()
        coroutine.yield(nil)
        ControllerManager:GetController(ControllerTypeId.HomeController):PlayLoginHeroGreeting()
        UIUtil.OnClickBackByUiTab(self)
      end
      
      self.__waitCoroutine = GR.StartCoroutine(util.cs_generator(waitFunc))
    end)
  else
    UIUtil.OnClickBackByUiTab(self)
  end
end

function UISelectBoardHero:ShowHeroCollection()
  local totalCount = ConfigData.hero_data.totalShowHeroCount
  local haveCount = PlayerDataCenter.heroCount - PlayerDataCenter.hideHeroCount
  local collectRate = 0
  collectRate = math.ceil(haveCount / totalCount * 100)
  self.ui.tex_Trim.gameObject:SetActive(0 < collectRate / 100)
  self.ui.tex_Collect:SetIndex(0, tostring(collectRate))
end

function UISelectBoardHero:OnReturnClick()
  self:OnCloseWin()
  self:Delete()
end

function UISelectBoardHero:OnDelete()
  if self.__waitCoroutine ~= nil then
    GR.StopCoroutine(self.__waitCoroutine)
    self.__waitCoroutine = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  self.heroSortList:Delete()
  self.sortButtonGroup:Delete()
  base.OnDelete(self)
end

return UISelectBoardHero
