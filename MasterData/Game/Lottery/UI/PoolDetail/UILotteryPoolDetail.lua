local UILotteryPoolDetail = class("UILotteryPoolDetail", UIBaseWindow)
local base = UIBaseWindow
local LotteryEnum = require("Game.Lottery.LotteryEnum")
local UINLtrPoolBaseRule = require("Game.Lottery.UI.PoolDetail.BaseRule.UINLtrPoolBaseRule")
local UINLtrPoolDetailRate = require("Game.Lottery.UI.PoolDetail.DetailRate.UINLtrPoolDetailRate")
local UINLtrPoolUpRate = require("Game.Lottery.UI.PoolDetail.UpRate.UINLtrPoolUpRate")
local UINLtrPoolRecord = require("Game.Lottery.UI.PoolDetail.Record.UINLtrPoolRecord")
local UINLtrPoolDetailTog = require("Game.Lottery.UI.PoolDetail.UINLtrPoolDetailTog")
local UINLtrPoolUpRule = require("Game.Lottery.UI.PoolDetail.UpRule.UINLtrPoolUpRule")
local UINFairyLtrPoolDetail = require("Game.Lottery.UI.PoolDetail.FairyDetailRate.UINFairyLtrPoolDetail")
local UINFairyLtrPoolSkillRate = require("Game.Lottery.UI.PoolDetail.FairySkillRate.UINFairyLtrPoolSkillRate")
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local cs_ResLoader = CS.ResLoader

function UILotteryPoolDetail:OnInit()
  self.baseRuleNode = UINLtrPoolBaseRule.New()
  self.baseRuleNode:Init(self.ui.baseRulePanel)
  self.baseRuleNode:Hide()
  self.detailRateNode = UINLtrPoolDetailRate.New()
  self.detailRateNode:Init(self.ui.detailRatePanel)
  self.detailRateNode:Hide()
  self.upRateNode = UINLtrPoolUpRate.New()
  self.upRateNode:Init(self.ui.uPRatePanel)
  self.upRateNode:Hide()
  self.recordNode = UINLtrPoolRecord.New()
  self.recordNode:Init(self.ui.recordPanel)
  self.recordNode:Hide()
  self.upRuleNode = UINLtrPoolUpRule.New()
  self.upRuleNode:Init(self.ui.upRulePanel)
  self.upRuleNode:Hide()
  self.fairyDetailNode = UINFairyLtrPoolDetail.New()
  self.fairyDetailNode:Init(self.ui.fairyDetailRatePanel)
  self.fairyDetailNode:Hide()
  self.fairySkillRateNode = UINFairyLtrPoolSkillRate.New()
  self.fairySkillRateNode:Init(self.ui.fairySkilllRatePanel)
  self.fairySkillRateNode:Hide()
  self.typeTogList = {}
  for k, tog in ipairs(self.ui.typeTogList) do
    UIUtil.AddValueChangedListener(tog, self, self._OnClickDetailType, k)
    local typeTog = UINLtrPoolDetailTog.New()
    typeTog:Init(tog.gameObject)
    self.typeTogList[k] = typeTog
  end
  self.resLoader = cs_ResLoader.Create()
end

function UILotteryPoolDetail:InitLtrPoolDetail(ltrPoolData, poolGrouData, exitAction)
  local poolCfg = ltrPoolData.ltrCfg
  self.ltrPoolData = ltrPoolData
  self.poolCfg = poolCfg
  self.poolGrouData = poolGrouData
  UIUtil.Push2BackStack(self, function()
    self:Delete()
    if exitAction ~= nil then
      exitAction()
    end
  end)
  self:Show()
  AudioManager:PlayAudioById(1066)
  if ltrPoolData:GetLotteryDataCfgPoolType() == LotteryEnum.eLotteryPoolLogicType.fairy then
  else
    self:_GenPoolData()
  end
  local allZero = true
  for k, rate in ipairs(poolCfg.prob_in) do
    if rate ~= 0 then
      allZero = false
      break
    end
  end
  local isFairyLottery = ltrPoolData:GetLotteryDataCfgPoolType() == LotteryEnum.eLotteryPoolLogicType.fairy
  local isShowUpRate = not allZero and not isFairyLottery
  local isShowNormalRate = poolCfg.pool_client_type == 1 and not isFairyLottery
  local isShowBaseRule = not isFairyLottery
  local isShowRecord = ltrPoolData:GetLotteryDataCfgPoolType() == LotteryEnum.eLotteryPoolLogicType.Paid and not isFairyLottery
  local isShowUpDes = ltrPoolData:ShowLtrUpIntro() and not isFairyLottery
  self.ui.typeTogList[1].gameObject:SetActive(isShowUpRate)
  self.ui.typeTogList[2].gameObject:SetActive(isShowNormalRate)
  self.ui.typeTogList[3].gameObject:SetActive(isShowBaseRule)
  self.ui.typeTogList[4].gameObject:SetActive(isShowRecord)
  self.ui.typeTogList[5].gameObject:SetActive(isShowUpDes)
  self.ui.typeTogList[6].gameObject:SetActive(isFairyLottery)
  self.ui.typeTogList[7].gameObject:SetActive(isFairyLottery)
  local showNewRuleRedPoint = ltrPoolData:IsShowLtrNewRuleReddot()
  self.ui.redDot_BaseRule:SetActive(showNewRuleRedPoint)
  for k, tog in ipairs(self.ui.typeTogList) do
    tog.isOn = false
    if tog.gameObject.activeInHierarchy then
      tog.isOn = true
      break
    end
  end
end

function __GetRewardBuildingLevel(rewardCfg)
  local level = 0
  for k, v in ipairs(rewardCfg.pre_condition) do
    if v == CheckerTypeId.BuildingLevel then
      level = rewardCfg.pre_para2[k]
      break
    end
  end
  return level
end

function UILotteryPoolDetail:_GenPoolData()
  self.rewardHeroDic = {}
  self.rewardDataList = {}
  local lotteryCfg = ConfigData.lottery[self.poolCfg.lottery_id]
  if lotteryCfg == nil then
    error("Cant get lotteryCfg, id = " .. self.poolCfg.lottery_id)
    return
  end
  local specialSelelctDic
  local speSelectList = self.ltrPoolData:GetLtrSpeSelectedList()
  if self.ltrPoolData:IsLtrSpecialSelectHero() and speSelectList ~= nil then
    specialSelelctDic = {}
    for k, itemId in ipairs(speSelectList) do
      specialSelelctDic[itemId] = true
    end
  end
  self._itemIsAdd = false
  for type, v in pairs(lotteryCfg) do
    local rewardTypeDic = ConfigData.lottery_reward_pool[type]
    if rewardTypeDic == nil then
      error("Cant get lottery_reward_pool, type = " .. tostring(type))
    else
      self:_AddRewardData(rewardTypeDic, specialSelelctDic)
    end
  end
  table.sort(self.rewardDataList, function(a, b)
    local isHeroA = a.heroCfg ~= nil
    local isHeroB = b.heroCfg ~= nil
    local starA = a.rankCfg ~= nil and a.rankCfg.star or 0
    local starB = b.rankCfg ~= nil and b.rankCfg.star or 0
    local buildingLvA = __GetRewardBuildingLevel(a.rewardCfg)
    local buildingLvB = __GetRewardBuildingLevel(b.rewardCfg)
    if a.upHero ~= b.upHero then
      return a.upHero
    end
    if isHeroA ~= isHeroB then
      return isHeroA
    end
    if starA ~= starB then
      return starA > starB
    end
    if buildingLvA ~= buildingLvB then
      return buildingLvA > buildingLvB
    end
    return a.itemCfg.id < b.itemCfg.id
  end)
end

function UILotteryPoolDetail:_AddRewardData(rewardTypeDic, specialSelelctDic)
  for k, rewardCfg in pairs(rewardTypeDic) do
    local rewardData = {}
    rewardData.rewardCfg = rewardCfg
    local itemId = rewardCfg.item_reward
    local itemCfg = ConfigData.item[itemId]
    if itemCfg == nil then
      error("Cant get itemCfg, id = " .. itemId)
    else
      rewardData.itemCfg = itemCfg
      local rate = self.poolCfg.prob_item
      if itemCfg.action_type == eItemActionType.HeroCard then
        local heroId = itemCfg.arg[1]
        local heroCfg = ConfigData.hero_data[heroId]
        if heroCfg == nil then
          error("hero cfg is null,id:" .. tostring(heroId))
        else
          rewardData.heroCfg = heroCfg
          local rankCfg = ConfigData.hero_rank[heroCfg.rank]
          if rankCfg == nil then
            error("Can't find rankCfg, id = " .. tostring(heroCfg.rank))
          else
            rewardData.rankCfg = rankCfg
            self.rewardHeroDic[heroId] = rewardData
            if self.poolCfg.heroUpAllDic[heroId] then
              rewardData.upHero = true
              if #self.poolCfg.prob_up < rankCfg.star then
                error("lottery_para.prob_up error, lottery_id = " .. tostring(self.poolCfg.lottery_id))
              else
                rate = self.poolCfg.prob_up[rankCfg.star]
                else
                  if #self.poolCfg.prob < rankCfg.star then
                    error("lottery_para.prob error, lottery_id = " .. tostring(self.poolCfg.lottery_id))
                    goto lbl_132
                  end
                  rate = self.poolCfg.prob[rankCfg.star]
                end
                local star = rewardData.rankCfg.star
                local count = math.ceil(star / 2)
                if 3 <= count and specialSelelctDic ~= nil and specialSelelctDic[rewardData.itemCfg.id] == nil then
                  goto lbl_132
                end
                elseif not self._itemIsAdd then
                  rewardData.isItem = true
                  self._itemIsAdd = true
                  rewardData.rate = rate
                  table.insert(self.rewardDataList, rewardData)
                end
              end
          end
        end
    end
    ::lbl_132::
  end
end

function UILotteryPoolDetail:_OnClickDetailType(index, isOn)
  local typeTog = self.typeTogList[index]
  typeTog:ChangeLtrPoolDetailTogState(isOn)
  if index == 1 then
    if isOn then
      self.upRateNode:Show()
      self.upRateNode:InitLtrPoolUpRate(self.rewardDataList, self.resLoader)
    else
      self.upRateNode:Hide()
    end
  elseif index == 2 then
    if isOn then
      self.detailRateNode:Show()
      local isGuarantee = self.poolCfg.is_guarantee
      self.detailRateNode:InitLtrPoolDetailRate(self.rewardDataList, isGuarantee)
    else
      self.detailRateNode:Hide()
    end
  elseif index == 3 then
    if isOn then
      self.baseRuleNode:Show()
      self.baseRuleNode:InitLtrPoolBaseRule(self.poolGrouData, self.ltrPoolData)
      if self.ui.redDot_BaseRule.activeInHierarchy then
        PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData):SetReadLtrNewRuleReddot(self.poolCfg.new_rule_reddot)
        self.ui.redDot_BaseRule:SetActive(false)
        local ltrWin = UIManager:GetWindow(UIWindowTypeID.LotteryWindow)
        if ltrWin ~= nil then
          ltrWin:HideLtrDetailNewRuleRedPoint()
        end
      end
    else
      self.baseRuleNode:Hide()
    end
  elseif index == 4 then
    if isOn then
      self.recordNode:Show()
      self.recordNode:InitLtrPoolRecord(self.ltrPoolData)
    else
      self.recordNode:Hide()
    end
  elseif index == 5 then
    if isOn then
      self.upRuleNode:Show()
      self.upRuleNode:InitLtrPoolUpRule(self.poolCfg)
    else
      self.upRuleNode:Hide()
    end
  elseif index == 6 then
    if isOn then
      self.fairyDetailNode:Show()
      self.fairyDetailNode:InitFairyLtrPoolDetailRate(self.ltrPoolData)
    else
      self.fairyDetailNode:Hide()
    end
  elseif index == 7 then
    if isOn then
      self.fairySkillRateNode:Show()
      self.fairySkillRateNode:InitFairyLtrPoolSkillRate()
    else
      self.fairySkillRateNode:Hide()
    end
  end
end

function UILotteryPoolDetail:ShowLtrDetailUpRule()
  self.ui.typeTogList[5].isOn = true
end

function UILotteryPoolDetail:OnDelete()
  self.baseRuleNode:Delete()
  self.upRateNode:Delete()
  self.detailRateNode:Delete()
  self.recordNode:Delete()
  self.upRuleNode:Delete()
  self.resLoader:Put2Pool()
  self.resLoader = nil
  base.OnDelete(self)
end

return UILotteryPoolDetail
