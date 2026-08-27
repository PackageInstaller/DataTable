local UIFormationQuick = class("UIFormationQuick", UIBaseWindow)
local base = UIBaseWindow
local UINHeroAttributeNode = require("Game.Formation.UI.Common.UINHeroAttributeNode")
local UINHeroSortList = require("Game.Hero.NewUI.SortList.UINHeroSortList")
local UINFmtSkillItem = require("Game.Formation.UI.QuickFmt.UINFmtSkillItem")
local UINAthHeroInfo = require("Game.Arithmetic.AthHeroInfo.UINAthHeroInfo")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")
local UINSortButtonGroup = require("Game.Hero.NewUI.SortList.UINSortButtonGroup")
local UINSiftCondition = require("Game.Hero.NewUI.SortList.UINSiftCondition")
local HeroSortEnum = require("Game.Hero.NewUI.HeroSortEnum")
local HeroFilterEnum = require("Game.Hero.NewUI.HeroFilterEnum")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType
local CS_ResLoader = CS.ResLoader
local CS_MessageCommon = CS.MessageCommon
local cs_Edge = CS.UnityEngine.RectTransform.Edge
local UINHeroCardItem = require("Game.Formation.UI.2DFormation.UINFmtCardItem")
local PeridicChallengeEnum = require("Game.PeriodicChallenge.PeridicChallengeEnum")
local BrotatoEnum = require("Game.ActivityBrotatoLobby.BrotatoEnum")

function UIFormationQuick:OnInit()
  UIUtil.SetTopStatus(self, self.OnClickBack)
  UIUtil.AddButtonListener(self.ui.btn_Comfirm, self, self.OnClickConfirm)
  UIUtil.AddButtonListener(self.ui.btn_Filter, self, self.OnBtnFilterClick)
  UIUtil.AddButtonListener(self.ui.btn_Detail, self, self.OnBtnDetailClick)
  self.ui.skillItem:SetActive(false)
  self.skillItemPool = UIItemPool.New(UINFmtSkillItem, self.ui.skillItem)
  self.__ShowSkillDescription = BindCallback(self, self.ShowSkillDescription)
  self.__HideSkillDetail = BindCallback(self, self.HideSkillDetail)
  self.resloader = CS_ResLoader.Create()
  self.campItemDic = {}
  self.ui.obj_campLock:SetActive(false)
  self.ui.obj_campItem:SetActive(false)
  self.ui.obj_campList:SetActive(false)
  self.ui.obj_campLayout = self.ui.obj_campList.transform.parent.gameObject
  self.color_ori_level = self.ui.tex_Level.text.color
end

function UIFormationQuick:InitQuickFmt(fmtData, fmtCtrl, selectHeroData, specialRuleGenerator)
  self.fmtCtrl = fmtCtrl
  self.specialRuleGenerator = specialRuleGenerator
  local HeroSortList = UINHeroSortList.New()
  HeroSortList:Init(self.ui.heroList)
  HeroSortList:SetCustomCardClass(UINHeroCardItem)
  HeroSortList:SetOfficialSupportHeroDic(self.officialSupportHeroDic)
  HeroSortList:InitHeroSortList(self.resloader, nil, BindCallback(self, self.OnSelectHero), false, false, false, false, specialRuleGenerator)
  HeroSortList:SetHeroListAnchorPosOffset(1)
  HeroSortList:ShowHeroPower(true)
  self.heroSortList = HeroSortList
  local isTdGame = self.fmtCtrl:GetCurEnterFmtData():IsInTdFormation()
  if isTdGame then
    self.heroSortList:SetChangeItemCallback(function(index, heroItem)
      local gameTypeAdapter = ExplorationEnum.SpecGameTypeAdapter.None
      if self.fmtCtrl:GetCurEnterFmtData():IsFmtTdSpecHero(heroItem.heroData.dataId) then
        gameTypeAdapter = ExplorationEnum.SpecGameTypeAdapter.TD
      end
      heroItem:SetSpecialGameHeroActive(gameTypeAdapter)
    end)
  end
  local isBrotatoGame = self.fmtCtrl:GetCurEnterFmtData():IsFmtInBrotatoDeploy()
  local isNeedBanNotSelf = self.fmtCtrl:GetCurEnterFmtData():GetFmtBrotatoNeedBanNotSelf()
  if isBrotatoGame then
    if isNeedBanNotSelf then
      self.heroSortList:SetIsBanNotSelfHero(true)
    else
      self.heroSortList:SetIsForceSupport(true)
    end
  end
  local sortButtonGroup = UINSortButtonGroup.New()
  sortButtonGroup:Init(self.ui.sortButtonGroup)
  self.sortButtonGroup = sortButtonGroup
  self.athNode = UINAthHeroInfo.New()
  self.athNode:Init(self.ui.algorithmNode)
  if specialRuleGenerator or self.officialSupportHeroDic then
    self.athNode:Hide()
    self.ui.btn_Detail.gameObject:SetActive(false)
  end
  self:RefreshFmtData(fmtData)
  self.sortButtonGroup:InitSortButtonGroup(HeroSortEnum.SortMannerDefine, BindCallback(self, self.__OnBtnSortItemClick), HeroSortEnum.eSortResource.formation)
  self.heroSortList:SetInFormationHero(self.inFormationDic)
  self:RefreshSelectedHero(selectHeroData)
  self:RefreshFmtHeroCount()
  self:RefreshCamp()
end

function UIFormationQuick:SetOfficialSupportHeroDic(dic)
  self.officialSupportHeroDic = dic
end

function UIFormationQuick:RefreshFmtData(formationData)
  self.originalFormationData = formationData
  self.inFmtHeroList = {}
  self.inFmtBenchHeroList = {}
  self.inFormationDic = {}
  local enterFmtData = self.fmtCtrl:GetCurEnterFmtData()
  self.fmtMaxHeroCount = enterFmtData:GetFormationMaxStageNum()
  self.fmtMaxBenchHeroCount = 0
  for i = 1, self.fmtMaxHeroCount do
    local heroId = formationData.data[i]
    if heroId ~= nil then
      table.insert(self.inFmtHeroList, heroId)
      self.inFormationDic[heroId] = false
    end
  end
  for i = 1, enterFmtData:GetFormationMaxBenchNum() do
    local unlock = FunctionUnlockMgr.BenchUnlock(i)
    if unlock then
      self.fmtMaxBenchHeroCount = self.fmtMaxBenchHeroCount + 1
      local heroId = formationData.data[i + self.fmtMaxHeroCount]
      if heroId ~= nil then
        table.insert(self.inFmtBenchHeroList, heroId)
        self.inFormationDic[heroId] = true
      end
    end
  end
end

local campCountColorDic = {
  [1] = Color.white,
  [2] = Color.white,
  [3] = Color.New(0.329, 0.666, 0.941),
  [4] = Color.New(0.752, 0.431, 1),
  [5] = Color.New(1, 0.635, 0.121)
}

function UIFormationQuick:OpenFQCampInfluence(isOpened)
  self.isOpenCampInfluence = isOpened
  if isOpened then
    self.ui.obj_campLayout:SetActive(true)
  else
    self.ui.obj_campLayout:SetActive(false)
  end
end

function UIFormationQuick:RefreshCamp()
  local isCampFetterUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_CampConnection)
  self.ui.obj_campLock:SetActive(not isCampFetterUnlock)
  self.ui.obj_campList:SetActive(isCampFetterUnlock)
  if not isCampFetterUnlock or not self.isOpenCampInfluence then
    return
  end
  local maxFetterDic = ConfigData.camp_connection.maxFetterDic
  local campCountDic = {}
  local heroData
  for heroId, boolKey in pairs(self.inFormationDic) do
    heroData = PlayerDataCenter:GetHeroData(heroId)
    if heroData ~= nil then
      local campId = heroData.camp
      local count = campCountDic[campId] or 0
      campCountDic[campId] = count + 1
    end
  end
  local campCountList = {}
  for index, cfg in ipairs(ConfigData.camp) do
    local campData = {
      campId = cfg.id,
      count = campCountDic[cfg.id] or 0,
      icon = cfg.icon
    }
    table.insert(campCountList, campData)
  end
  for campId, campItem in pairs(self.campItemDic) do
    campItem.go:SetActive(false)
  end
  for index, campData in ipairs(campCountList) do
    local campItem = self.campItemDic[campData.campId]
    if campItem == nil then
      campItem = {}
      campItem.go = self.ui.obj_campItem:Instantiate()
      campItem.img_Icon = campItem.go:FindComponent("Img_CampIcon", eUnityComponentID.Image)
      campItem.Img_Count = campItem.go:FindComponent("Img_Count", eUnityComponentID.Image)
      self.campItemDic[campData.campId] = campItem
    end
    if campData.icon ~= nil then
      campItem.img_Icon.sprite = CRH:GetSprite(campData.icon, CommonAtlasType.CareerCamp)
    end
    local maxFetter = maxFetterDic[campData.campId]
    local sizeCount = math.clamp(campData.count, 0, maxFetter)
    local vec = campItem.Img_Count.transform.sizeDelta
    vec.y = 15 * sizeCount
    campItem.Img_Count.transform.sizeDelta = vec
    local colCount = math.clamp(campData.count, 1, maxFetter)
    campItem.Img_Count.color = campCountColorDic[colCount]
    campItem.go:SetActive(true)
  end
end

function UIFormationQuick:RefreshFmtHeroCount()
  self.ui.tex_MainNum.text = tostring(#self.inFmtHeroList) .. "/" .. tostring(self.fmtMaxHeroCount)
  self.ui.tex_SubNum.text = tostring(#self.inFmtBenchHeroList) .. "/" .. tostring(self.fmtMaxBenchHeroCount)
end

function UIFormationQuick:RefreshSelectedHero(heroData)
  if heroData == nil then
    self.ui.heroDetailNode:SetActive(false)
    self.ui.emptyNode:SetActive(true)
    return
  end
  self.heroData = heroData
  self.ui.heroDetailNode:SetActive(true)
  self.ui.emptyNode:SetActive(false)
  self.ui.tex_Name.text = heroData:GetName()
  self.ui.tex_FightingPower.text = tostring(heroData:GetFightingPower())
  self:RefreshLevel(heroData.level)
  if self.attrNode == nil then
    self.attrNode = UINHeroAttributeNode.New()
    self.attrNode:Init(self.ui.heroAttributeNode)
  end
  local attrDataList = {}
  local index = 0
  for _, attrId in ipairs(ConfigData.attribute.baseAttrIds) do
    if 10 <= index then
      break
    end
    if ConfigData.attribute[attrId].merge_attribute == 0 then
      index = index + 1
      attrDataList[index] = {
        attrId = attrId,
        attrValue = heroData:GetAttr(attrId)
      }
    end
  end
  local selfHeroData = PlayerDataCenter.heroDic[self.heroData.dataId]
  local overriodColor
  if selfHeroData == nil or selfHeroData.level ~= self.heroData.level or selfHeroData.rank ~= self.heroData.rank then
    overriodColor = self.ui.color_syn
  end
  self.attrNode:InitHeroAttrNode(attrDataList, overriodColor)
  local isInTd = self.fmtCtrl:GetCurEnterFmtData():IsInTdFormation()
  self.skillItemPool:HideAll()
  for k, skillData in pairs(heroData.skillList) do
    if skillData.type ~= eHeroSkillType.LifeSkill and not skillData:IsCommonAttack() then
      local oriSkillData = selfHeroData ~= nil and selfHeroData.skillDic[skillData.dataId] or nil
      local overriodColor
      if oriSkillData == nil or oriSkillData.level ~= skillData.level then
        overriodColor = self.ui.color_syn
      end
      local skillItem = self.skillItemPool:GetOne()
      local adapterType = 0
      if isInTd then
        local tdSkillCfg = ConfigData.skill_adapter[ExplorationEnum.SpecGameTypeAdapter.TD]
        local skillAdapterCfg
        if tdSkillCfg ~= nil then
          skillAdapterCfg = tdSkillCfg[skillData.dataId]
        end
        if skillAdapterCfg ~= nil and 0 < skillAdapterCfg.lock_type then
          adapterType = skillAdapterCfg.lock_type
          local realSkillId = skillAdapterCfg.skill_id_new
          skillData = skillData:CopyHeroSkillNewId(realSkillId)
        end
      end
      skillItem:InitFmtSkillItem(skillData, self.resloader, nil, self.__ShowSkillDescription, self.__HideSkillDetail, overriodColor)
      skillItem:FmtShowSkillAdapter(adapterType)
    end
  end
  if self.athNode.active then
    self.athNode:InitAthHeroInfo(heroData, self.resloader, true)
  end
end

function UIFormationQuick:RefreshLevel(level)
  if 999 < level then
    warn("level Num is out off MaxSize 999")
  end
  local empty = ""
  if level <= 9 then
    empty = "00"
  elseif level <= 99 then
    empty = "0"
  end
  local selfHeroData = PlayerDataCenter.heroDic[self.heroData.dataId]
  if selfHeroData ~= nil and selfHeroData.level == level then
    self.ui.tex_Level.text.color = self.color_ori_level
    self.ui.obj_Sync:SetActive(false)
  else
    self.ui.tex_Level.text.color = self.ui.color_syn
    self.ui.obj_Sync:SetActive(true)
  end
  self.ui.tex_Level:SetIndex(0, empty, level)
end

function UIFormationQuick:ShowSkillDescription(item, skillData)
  if skillData:GetIsUnlock() then
    self.__onRichIntroOpen = BindCallback(self, self.__RichIntroOpen, skillData)
    UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
      if win ~= nil then
        self.__onRichIntroOpen(win)
      end
    end)
  end
end

function UIFormationQuick:HideSkillDetail(skillData)
  UIManager:HideWindow(UIWindowTypeID.RichIntro)
end

function UIFormationQuick:__RichIntroOpen(skillData)
  if skillData:GetIsUnlock() then
    UIManager:ShowWindowAsync(UIWindowTypeID.RichIntro, function(win)
      if win ~= nil then
        win:ShowIntroBySkillData(self.ui.richIntroHolder, skillData, true)
        win:SetIntroListPosition(cs_Edge.Left)
      end
    end)
  end
end

function UIFormationQuick:OnSelectHero(heroData, heroCardItem)
  local heroId = heroData.dataId
  if self.inFormationDic[heroId] == nil then
    if table.count(self.inFormationDic) >= self.fmtMaxHeroCount + self.fmtMaxBenchHeroCount then
      CS_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(TipContent.Formation_MaxHeroCount))
      return
    end
    local isBench = #self.inFmtHeroList >= self.fmtMaxHeroCount
    if isBench then
      table.insert(self.inFmtBenchHeroList, heroId)
    else
      table.insert(self.inFmtHeroList, heroId)
    end
    self.inFormationDic[heroId] = isBench
    if heroCardItem ~= nil then
      heroCardItem:SetSelectActive(true, isBench)
    end
    self:RefreshSelectedHero(heroData)
    AudioManager:PlayAudioById(1059)
  else
    if self.inFormationDic[heroId] then
      table.removebyvalue(self.inFmtBenchHeroList, heroId)
    else
      table.removebyvalue(self.inFmtHeroList, heroId)
    end
    self.inFormationDic[heroId] = nil
    if heroCardItem ~= nil then
      heroCardItem:SetSelectActive(false)
    end
    self:RefreshSelectedHero(nil)
  end
  self:RefreshFmtHeroCount()
  self:RefreshCamp()
end

function UIFormationQuick:__OnBtnSortItemClick(sortFunc)
  self.heroSortList:RefreshHeroSortList(nil, sortFunc)
end

function UIFormationQuick:OnBtnDetailClick()
  local hasSpecialHero = false
  if self.specialRuleGenerator ~= nil then
    hasSpecialHero = self.specialRuleGenerator.specialRuler.heroIds ~= nil
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.HeroState, function(windows)
    if windows == nil then
      error(LanguageUtil.GetLocaleText(self.heroData.name) .. "Click can't show state")
      return
    end
    windows:InitHeroState(self.heroData, self.heroSortList.curHeroList, function()
      self:RefreshSelectedHero(self.heroData)
    end, hasSpecialHero)
    windows:RegistFromeWindowTypeID(UIWindowTypeID.FormationQuick)
    local parWin = UIManager:GetWindow(UIWindowTypeID.FormationQuick)
    if parWin ~= nil then
      parWin:Hide()
    end
  end)
end

function UIFormationQuick:OnBtnFilterClick()
  if self.siftCondition == nil then
    local SiftConditionPage = UINSiftCondition.New()
    SiftConditionPage:Init(self.ui.sortConditionNode)
    SiftConditionPage:InitSiftCondition(HeroFilterEnum.eKindType, HeroFilterEnum.eKindMaxCount, BindCallback(self, self.OnFilterConfirmAction))
    self.siftCondition = SiftConditionPage
  end
  self.siftCondition:Show()
end

function UIFormationQuick:OnFilterConfirmAction(sortKindData)
  self.sortKindData = sortKindData
  if self.__SiftFunction == nil then
    self.__SiftFunction = BindCallback(self, self.SiftFunction)
  end
  self.heroSortList:RefreshHeroSortList(self.__SiftFunction, nil)
end

function UIFormationQuick:SiftFunction(heroData)
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
  local vowConfig = self.sortKindData[HeroFilterEnum.eKindType.Vowed]
  local index = ConfigData.game_config.heroVowed
  if not heroData:GetHeroIsVowed() then
    index = index + 1
  end
  local vowedOk = vowConfig.nocondition or vowConfig.selectIndexs[index]
  if rankOk and campOk and careerOk and vowedOk then
    return true
  else
    return false
  end
end

function UIFormationQuick:OnClickBack()
  self.fmtCtrl:ExitQuickFormation()
end

function UIFormationQuick:OnClickConfirm()
  local newFmtHeroData = {}
  local newFmtHeroIdList = {}
  for k, heroId in ipairs(self.inFmtHeroList) do
    newFmtHeroData[k] = heroId
    table.insert(newFmtHeroIdList, heroId)
  end
  for k, heroId in ipairs(self.inFmtBenchHeroList) do
    newFmtHeroData[k + self.fmtMaxHeroCount] = heroId
    table.insert(newFmtHeroIdList, heroId)
  end
  local changed = false
  local oldFmtHeroData = self.originalFormationData.data
  if table.count(oldFmtHeroData) == table.count(newFmtHeroData) then
    for k, v in pairs(newFmtHeroData) do
      if oldFmtHeroData[k] ~= v then
        changed = true
        break
      end
    end
  else
    changed = true
  end
  if changed then
    local enterFmtData = self.fmtCtrl:GetCurEnterFmtData()
    if enterFmtData:IsFmtInBrotatoDeploy() and enterFmtData:GetIsHaveOfficialSupport() then
      local fmtData = self.fmtCtrl:GetFmtCtrlFmtData()
      fmtData:CleanFormation()
      fmtData:SetOfficialSupportHeroData(self.heroData, 1)
      self.fmtCtrl:ModifyFormation(fmtData, newFmtHeroData, true)
    else
      self.fmtCtrl:ModifyFormation(nil, newFmtHeroData, true)
    end
  end
  if 0 < #newFmtHeroIdList then
    local voHeroId = newFmtHeroIdList[math.random(#newFmtHeroIdList)]
    local voiceId = ConfigData:GetVoicePointRandom(eVoicePointType.EnterTeam, nil, voHeroId)
    local cvCtr = ControllerManager:GetController(ControllerTypeId.Cv, true)
    cvCtr:PlayCv(voHeroId, voiceId)
  end
  UIUtil.PopFromBackStackByUiTab(self)
  self.fmtCtrl:ExitQuickFormation(changed)
end

function UIFormationQuick:OnDelete()
  self.skillItemPool:DeleteAll()
  self.heroSortList:Delete()
  self.sortButtonGroup:Delete()
  if self.siftCondition ~= nil then
    self.siftCondition:Delete()
  end
  self.athNode:Delete()
  self.resloader:Put2Pool()
  self.resloader = nil
  self.officialSupportHeroDic = nil
  base.OnDelete(self)
end

return UIFormationQuick
