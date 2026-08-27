local UIFmtEvaluation = class("UIFmtEvaluation", UIBaseNode)
local base = UIBaseNode
local FmtEnum = require("Game.Formation.FmtEnum")
local FmtEnum = require("Game.Formation.FmtEnum")
local UIEvaluationItem = require("Game.Formation.UI.FormationEvaluation.UIFmtEvaluationItem")
local FloatAlignEnum = require("Game.CommonUI.FloatWin.FloatAlignEnum")
local HAType = FloatAlignEnum.HAType
local VAType = FloatAlignEnum.VAType

function UIFmtEvaluation:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.evaluationItemPool = UIItemPool.New(UIEvaluationItem, self.ui.evaluationItem)
  self.ui.evaluationItem:SetActive(false)
  self._onEvaluationItemPress = BindCallback(self, self._OnEvaluationItemPress)
  self._onEvaluationItemPressUp = BindCallback(self, self._OnEvaluationItemPressUp)
end

function UIFmtEvaluation:InitializeAdvantageConfig(sectorStageId, fromModuel)
  self.advTypeDic = {}
  local stage
  if fromModuel == FmtEnum.eFmtFromModule.SectorLevel then
    stage = ConfigData.sector_stage[sectorStageId]
  elseif fromModuel == FmtEnum.eFmtFromModule.Infinity then
    local endlessLevel = ConfigData.endless.levelDic[sectorStageId]
    if endlessLevel == nil then
      return
    end
    stage = ConfigData.endless[endlessLevel.sectorId][endlessLevel.index]
  elseif fromModuel == FmtEnum.eFmtFromModule.MaterialDungeon or fromModuel == FmtEnum.eFmtFromModule.ATHDungeon or fromModuel == FmtEnum.eFmtFromModule.FriendshipDungeon then
    stage = ConfigData.battle_dungeon[sectorStageId]
  end
  if stage == nil then
    return
  end
  for _, v in ipairs(stage.sup_career) do
    if self.advTypeDic[v] ~= nil then
      error("优劣势配置重复,关卡id:" .. sectorStageId)
    end
    self.advTypeDic[v] = true
  end
  for _, v in ipairs(stage.inf_career) do
    if self.advTypeDic[v] ~= nil then
      error("优劣势配置重复,关卡id:" .. sectorStageId)
    end
    self.advTypeDic[v] = false
  end
  self.stageCfg = stage
end

function UIFmtEvaluation:AnalysisFormation(formationDic)
  if self.evaluationItemPool ~= nil then
    self.evaluationItemPool:HideAll()
  end
  self:__setCurFmtEvaluation(false)
  self.careerDisAdvList = {}
  local validAdvDic = self:__GetFormationAdvState(formationDic)
  for advTypeId, _ in pairs(validAdvDic) do
    if not self.advTypeDic[advTypeId] then
      table.insert(self.careerDisAdvList, advTypeId)
    end
  end
  if #self.careerDisAdvList > 0 then
    self:__setCurFmtEvaluation(true)
    table.sort(self.careerDisAdvList)
  end
  local advList = {}
  for advTypeId, isAdv in pairs(self.advTypeDic) do
    if isAdv then
      table.insert(advList, advTypeId)
    end
  end
  if 0 < #advList then
    table.sort(advList, function(a, b)
      if validAdvDic[a] ~= validAdvDic[b] then
        return validAdvDic[a]
      end
      return a < b
    end)
  end
  for index, advTypeId in ipairs(advList) do
    self:__generateEvaluationItem(advTypeId, true, validAdvDic[advTypeId])
  end
  for index, advTypeId in ipairs(self.careerDisAdvList) do
    self:__generateEvaluationItem(advTypeId, false, true)
  end
end

function UIFmtEvaluation:IsFmtDisadvantage()
  return self.__containDisadvantage
end

function UIFmtEvaluation:GetDisadvantageDescribe()
  if #self.careerDisAdvList > 0 then
    local content
    for _, v in ipairs(self.careerDisAdvList) do
      local careerCfg = ConfigData.career[v]
      if careerCfg ~= nil then
        local nameStr = LanguageUtil.GetLocaleText(careerCfg.name)
        if content == nil then
          content = nameStr
        else
          content = content .. "、" .. nameStr
        end
      else
        error("找不到指定职业配置，职业id:" .. tostring(v))
      end
    end
    return content
  end
  return nil
end

function UIFmtEvaluation:__generateEvaluationItem(advTypeId, isAdvantage, contains)
  if self.evaluationItemPool == nil then
    return
  end
  local item = self.evaluationItemPool:GetOne()
  local textColor = self.ui.disadvTextColor
  local eColorType = FmtEnum.eFmtEvaluationAdvant.inferior
  if isAdvantage then
    contains = contains or false
    textColor = contains and self.ui.advContainsTextColor or self.ui.advTextColor
    eColorType = contains and FmtEnum.eFmtEvaluationAdvant.advContain or FmtEnum.eFmtEvaluationAdvant.advantage
  end
  item:UpdateItemDisplay(advTypeId, isAdvantage, textColor, eColorType)
  item:SetEvaluationItemClickAct(self._onEvaluationItemPress, self._onEvaluationItemPressUp)
end

function UIFmtEvaluation:_OnEvaluationItemPress(transform, advTypeId, isAdvantage)
  local idList = isAdvantage == true and self.stageCfg.sup_career or self.stageCfg.inf_career
  local infoIdList = isAdvantage == true and self.stageCfg.sup_carrer_info or self.stageCfg.inf_carrer_info
  if idList == nil or infoIdList == nil then
    return
  end
  local advIndex
  for index, id in ipairs(idList) do
    if id == advTypeId then
      advIndex = index
      break
    end
  end
  if advIndex == nil then
    error("Cant find index by:" .. advTypeId)
    return
  end
  local infoId = infoIdList[advIndex]
  if infoId == nil then
    return
  end
  local sectorCareerInfoCfg = ConfigData.sector_career_info[infoId]
  local win = UIManager:ShowWindow(UIWindowTypeID.FloatingFrame)
  win:SetTitleAndContext(nil, LanguageUtil.GetLocaleText(sectorCareerInfoCfg.info))
  win:FloatTo(transform, HAType.right, VAType.up, 0, 0.71, nil)
end

function UIFmtEvaluation:_OnEvaluationItemPressUp()
  self:_HideEvaluationItemInfo()
end

function UIFmtEvaluation:_HideEvaluationItemInfo()
  local win = UIManager:GetWindow(UIWindowTypeID.FloatingFrame)
  if win ~= nil then
    win:Hide()
  end
end

function UIFmtEvaluation:__setCurFmtEvaluation(isContainDisadvantage)
  self.__containDisadvantage = isContainDisadvantage
end

function UIFmtEvaluation:__GetFormationAdvState(formationDic)
  local validAdvDic = {}
  for fmtIndex, heroId in pairs(formationDic) do
    local heroCfg = ConfigData.hero_data[heroId]
    local careerId = heroCfg.career
    local isRemote = heroCfg.range > 1
    if self.advTypeDic[careerId] ~= nil then
      validAdvDic[careerId] = true
    end
    if isRemote then
      if self.advTypeDic[101] ~= nil then
        validAdvDic[101] = true
      end
    elseif self.advTypeDic[100] ~= nil then
      validAdvDic[100] = true
    end
  end
  return validAdvDic
end

function UIFmtEvaluation:OnDelete()
  self:_HideEvaluationItemInfo()
  base.OnDelete(self)
end

return UIFmtEvaluation
