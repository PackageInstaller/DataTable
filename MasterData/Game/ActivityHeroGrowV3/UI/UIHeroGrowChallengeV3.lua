local base = UIBaseWindow
local UIHeroGrowChallengeV3 = class("UICahrDunV3", base)
local cs_ResLoader = CS.ResLoader
local HeroGorwLevelData = require("Game.ActivityHeroGrowV3.Data.HeroGrowChallengeV3Data")
local UINSectorTaskAchiveItem = require("Game.ActivityHeroGrowV3.UI.UINHeroGrowChallengeRewardItem")
local UINTaskViewReward = require("Game.Task.NewUI.UINTaskViewReward")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local UINLevelNormalBuffItem = require("Game.Sector.SectorLevelDetail.Nodes.UINLevelNormalBuffItem")
local TaskEnum = require("Game.Task.TaskEnum")
local UINCommonRankItemHeroHead = require("Game.CommonUI.Rank.UINCommonRankItemHeroHead")
local OfficialSupportHeroData = require("Game.Formation.Data.OfficialSupportHeroData")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType

function UIHeroGrowChallengeV3:OnInit()
  UIUtil.SetTopStatus(self, self.__OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Battle, self, self.__OnClickBattle)
  self.__onClickRewardItem = BindCallback(self, self.__OnClickRewardItem)
  self.rewardItemPool = UIItemPool.New(UINSectorTaskAchiveItem, self.ui.obj_rewardItem)
  self.ui.obj_rewardItem:SetActive(false)
  self._resloader = cs_ResLoader.Create()
  self.ui.obj_PeroidListNode:SetActive(true)
  self.ui.obj_ChallengeTip:SetActive(true)
  self.ui.obj_RepeatTip:SetActive(false)
  self.ui.obj_Unlock:SetActive(false)
  self.ui.obj_Lock:SetActive(false)
  self.ui.obj_Drop:SetActive(false)
  self.ui.obj_Cost:SetActive(false)
  self.achivParentWidth = self.ui.rect_achivParent.rect.width
  self.viewReward = UINTaskViewReward.New()
  self.viewReward:Init(self.ui.obj_ViewReward)
  self.buffItemPool = UIItemPool.New(UINLevelNormalBuffItem, self.ui.obj_protoItem)
  self.ui.obj_protoItem:SetActive(false)
  self.__ShowBuffDescription = BindCallback(self, self.ShowBuffDescription)
  self.__HideBuffDetail = BindCallback(self, self.HideBuffDetail)
  local atlasPath = PathConsts:GetSpriteAtlasPath("UI_CharDunRepeatVer3")
  self._logoBgAtlas = self._resloader:LoadABAsset(atlasPath)
  self.heroHeadPool = UIItemPool.New(UINCommonRankItemHeroHead, self.ui.obj_heroHeadItem)
  self.ui.obj_heroHeadItem:SetActive(false)
  self.__onClickHeadItem = BindCallback(self, self.__OnClickHeadItem)
end

function UIHeroGrowChallengeV3:InitCahrDunV3(heroGrowV3Data, backCallback)
  self._backCallback = backCallback
  self.heroGrowV3Data = heroGrowV3Data
  self.__showBuffIdList = {}
  local battleCCfg = self.heroGrowV3Data:GetBattleDungeonCfg()
  local protocol = battleCCfg.protocol
  for _, buffId in pairs(protocol) do
    table.insert(self.__showBuffIdList, buffId)
  end
  self.buffItemPool:HideAll()
  for _, buffId in pairs(self.__showBuffIdList) do
    local buffCfg = ConfigData.dungeon_buff[buffId]
    if buffCfg ~= nil then
      local buffItem = self.buffItemPool:GetOne()
      buffItem:InitBuffByCfg(buffCfg, self.__ShowBuffDescription, self.__HideBuffDetail)
    end
  end
  local uiconfig = self.heroGrowV3Data:GetUIConfig()
  if uiconfig ~= nil then
    self.ui.tex_Title.text = LanguageUtil.GetLocaleText(uiconfig.challenge_name)
  end
  local challengeCfg = self.heroGrowV3Data:GetChallengeDungeonCfg()
  if challengeCfg ~= nil then
    local nameResPath = PathConsts:GetSectorEntrancTex(challengeCfg.background_pic)
    self.ui.img_Pic.gameObject:SetActive(false)
    self._resloader:LoadABAssetAsync(nameResPath, function(texture)
      if texture == nil or IsNull(self.transform) then
        return
      end
      self.ui.img_Pic.gameObject:SetActive(true)
      self.ui.img_Pic.texture = texture
    end)
    self.ui.img_Logo.sprite = AtlasUtil.GetResldSprite(self._logoBgAtlas, challengeCfg.dungeon_icon)
    self.ui.tex_ChallengeTip = LanguageUtil.GetLocaleText(challengeCfg.pic_des)
    local assistanceId = challengeCfg.assistance_id
    local officialAssistCfg = ConfigData.official_assist[assistanceId]
    self.heroHeadPool:HideAll()
    if officialAssistCfg ~= nil then
      for index, heroId in ipairs(officialAssistCfg.param1) do
        local assistCfgId = officialAssistCfg.assist_lvs[index]
        local power = officialAssistCfg.effective[index]
        local assisLvCfg = ConfigData.assist_level[assistCfgId]
        local osHeroData = OfficialSupportHeroData.GenOfficialSupportHeroData(heroId, assisLvCfg, power)
        osHeroData:SetOfficialSupportCfgId(assistanceId)
        local item = self.heroHeadPool:GetOne()
        item:InitHead(heroId, assisLvCfg.hero_level, assisLvCfg.hero_rank, self.__onClickHeadItem)
        item:SetHeadHeroData(osHeroData)
      end
    end
  end
  self.ui.img_battle:SetIndex(1)
  self:__RefreshHGV3Color()
  self:__RefreshSectorAchivUI(true)
end

function UIHeroGrowChallengeV3:__RefreshHGV3Color()
  local decoColor = self.heroGrowV3Data:GetHGV3DecoColor()
  for _, colorComp in pairs(self.ui.color_array) do
    colorComp.color = decoColor
  end
end

function UIHeroGrowChallengeV3:__RefreshSectorAchivUI(isInit)
  self.starId = nil
  local curScore = self.heroGrowV3Data:GetChallengeMaxScore(self.curSectorId)
  self.achivDatas = self.heroGrowV3Data:GetChallengeAchievementDatas(self.curSectorId)
  local totalScore = 0
  for i, data in ipairs(self.achivDatas) do
    local tempScore = data.achiveCfg.need_socre
    if totalScore < tempScore then
      totalScore = tempScore
    end
  end
  self.ui.tex_Point.text = tostring(curScore)
  local fillAmount = 0
  if totalScore ~= 0 then
    fillAmount = curScore / totalScore
  end
  if isInit then
    self.ui.img_Process.fillAmount = fillAmount
  else
    self.ui.img_Process:DOKill(true)
    self.ui.img_Process:DOFillAmount(fillAmount, 0.35)
  end
  self.rewardItemPool:HideAll()
  for index, achivData in ipairs(self.achivDatas) do
    local item = self.rewardItemPool:GetOne()
    local state, pointCount
    state = achivData.state
    pointCount = achivData.achiveCfg.need_socre
    item:InitPeroidItem(achivData, state, self.__onClickRewardItem)
    local pos = Vector3.zero
    if totalScore ~= 0 then
      pos = Vector3.New(pointCount / totalScore * self.achivParentWidth, -21, 0)
    end
    item.transform.localPosition = pos
  end
end

function UIHeroGrowChallengeV3:ShowBuffDescription(item, buffCfg)
  local window = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  window:SetTitleAndContext(LanguageUtil.GetLocaleText(buffCfg.name), LanguageUtil.GetLocaleText(buffCfg.describe))
  window:FloatTo(item.transform, HAType.autoCenter, VAType.up, 0, 0.62)
end

function UIHeroGrowChallengeV3:HideBuffDetail(skillData)
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
  end
end

function UIHeroGrowChallengeV3:__OnClickClose()
  if self._backCallback ~= nil then
    self._backCallback()
  end
  self:Delete()
end

function UIHeroGrowChallengeV3:__OnClickBattle()
  local challengeCfg = self.heroGrowV3Data:GetChallengeDungeonCfg()
  UIManager:ShowWindowAsync(UIWindowTypeID.DungeonLevelDetail, function(window)
    if window == nil then
      return
    end
    local heroGorwLevelData = HeroGorwLevelData.New(challengeCfg.dungeon_id, challengeCfg, self.heroGrowV3Data:GetChallengeMaxScore(), self.heroGrowV3Data:GetChallengeMaxDamage())
    window:InitDungeonLevelDetail(heroGorwLevelData, false)
    window:SetDungeonLevelBgClose(true)
  end)
end

function UIHeroGrowChallengeV3:__OnClickRewardItem(item)
  if item.eTaskState == TaskEnum.eTaskState.Completed then
    local network = NetworkManager:GetNetwork(NetworkTypeID.HeroGrowV3)
    network:CS_Activity_HardDungeon_PickScoreReward(self.heroGrowV3Data:GetActFrameId(), item.level, function()
      self:__RefreshSectorAchivUI()
    end)
  else
    self.viewReward:Show()
    self.viewReward:FloatTo(item.transform, HAType.autoCenter, VAType.down, 0, 40)
    self.viewReward:RefreshItems(item.data.rewardIds, item.data.rewardNums, BindCallback(self, self.__OnCloseViewState, item))
    item:SetViewState(true)
  end
end

function UIHeroGrowChallengeV3:__OnClickHeadItem(heroData)
  UIManager:ShowWindowAsync(UIWindowTypeID.SupportHeroState, function(win)
    if win == nil then
      return
    end
    win:InitSupportHeroState(heroData)
  end)
end

function UIHeroGrowChallengeV3:__OnCloseViewState(item)
  item:SetViewState(false)
end

function UIHeroGrowChallengeV3:OnDelete()
  if self._resloader ~= nil then
    self._resloader:Put2Pool()
    self._resloader = nil
  end
  self.rewardItemPool:DeleteAll()
  self.rewardItemPool = nil
  self.viewReward:Delete()
  self.heroGrowV3Data = nil
  self.buffItemPool:DeleteAll()
  self.buffItemPool = nil
  self._logoBgAtlas = nil
  self.heroHeadPool:DeleteAll()
  self.heroHeadPool = nil
  base.OnDelete(self)
end

return UIHeroGrowChallengeV3
