local UIResultSettlement = class("UIResultSettlement", UIBaseWindow)
local base = UIBaseWindow
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local UINResultSettlementHeroItem = require("Game.BattleResult.UINResultSettlementHeroItem")
local cs_MessageCommon = CS.MessageCommon
local cs_ResLoader = CS.ResLoader
local cs_DoTween = CS.DG.Tweening.DOTween

function UIResultSettlement:OnInit()
  self.playExpAnime = false
  UIUtil.AddButtonListener(self.ui.btn_Return, self, self.OnClickBack)
  self.heroItemPool = UIItemPool.New(UINResultSettlementHeroItem, self.ui.obj_heroHeadItem)
  self.ui.obj_heroHeadItem:SetActive(false)
  self.rewardItemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.obj_baseItemWithCount)
  self.ui.obj_baseItemWithCount:SetActive(false)
  self.ui.obj_CommanderLvUp:SetActive(false)
  self.resloader = cs_ResLoader.Create()
  self.__updateHandle = BindCallback(self, self.Update)
  UpdateManager:AddUpdate(self.__updateHandle)
end

function UIResultSettlement:InitResultSettlement(isWin, backRewards, rewardList, resultSettlementData, backCallback)
  self.backCallback = backCallback
  self.isWin = isWin
  if resultSettlementData == nil or backRewards == nil then
    error("UIResultSettlement: can't read data backRewards" .. tostring(backRewards) .. "oldData" .. tostring(resultSettlementData))
    self:OnClickBack()
  end
  self:m_ChnageBgColor(isWin)
  self:RefreshLevelName()
  self:RefreshEpItemReward(rewardList)
  self:RefreshEpTeam(backRewards, resultSettlementData)
end

function UIResultSettlement:m_ChnageBgColor(isWin)
  DestroyUnityObject(self.resultBG_Material)
  self.resultBG_Material = nil
  self.resultBG_Material = UIUtil.GetImageMaterial(self.ui.img_ResultBG)
  local resultBG_Material = self.resultBG_Material
  if isWin then
    resultBG_Material:SetFloat("_Decoloration", 0)
    self.ui.img_ResultBG.color = self.ui.col_Success
  else
    resultBG_Material:SetFloat("_Decoloration", 1)
    self.ui.img_ResultBG.color = self.ui.col_Over
  end
end

function UIResultSettlement:RefreshLevelName()
  local moduleId = ExplorationManager:GetEpModuleId()
  local stageCfg = ExplorationManager:GetSectorStageCfg()
  local msg
  if moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Exploration then
    msg = ConfigData:GetSectorInfoMsg(stageCfg.sector, stageCfg.num, stageCfg.difficulty)
  elseif moduleId == proto_csmsg_SystemFunctionID.SystemFunctionID_Endless then
    local endlessCfg = stageCfg.endlessCfg
    msg = ConfigData:GetEndlessInfoMsg(endlessCfg, endlessCfg.index * 10)
  else
    msg = ConfigData:GetChallengeInfoMsg(moduleId)
  end
  self.ui.tex_LevelCount.text = msg
end

function UIResultSettlement:RefreshEpTeam(backRewards, resultSettlementData)
  local oldHeroLevelDic = resultSettlementData.oldHeroLevelDic
  local oldHeroExpDic = resultSettlementData.oldHeroExpDic
  local heroList = ExplorationManager.epCtrl.dynPlayer.heroList
  self.heroItemPool:HideAll()
  for _, dynHeroData in ipairs(heroList) do
    local heroItem = self.heroItemPool:GetOne()
    local heroId = dynHeroData.dataId
    heroItem:InitCharacterItem(dynHeroData, self.resloader, nil)
    heroItem:RefershExpData(oldHeroLevelDic[heroId], oldHeroExpDic[heroId], backRewards.exp or 0)
    heroItem:RefreshFriendShipData(backRewards.heroIntimacy[heroId] or 0)
  end
  self.playExpAnime = true
end

function UIResultSettlement:RefreshEpItemReward(rewardList)
  ExplorationManager:RewardSort(rewardList)
  self.rewardItemPool:HideAll()
  for i, v in pairs(rewardList) do
    local item = self.rewardItemPool:GetOne()
    item:InitItemWithCount(v.itemCfg, v.num, function()
      UIManager:ShowWindowAsync(UIWindowTypeID.GlobalItemDetail, function(win)
        if win ~= nil then
          win:InitListDetail(rewardList, i)
        end
      end)
    end)
  end
  local rewardSequence = cs_DoTween.Sequence()
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
  rewardSequence:Play()
  if self.rewardSequence ~= nil then
    self.rewardSequence:Kill()
  end
  self.rewardSequence = rewardSequence
end

function UIResultSettlement:m_isRandomAth(rewardId)
  if 8000 <= rewardId and rewardId < 9000 then
    return true
  end
  return false
end

function UIResultSettlement:Update()
  if self.playExpAnime then
    local hasnotFinish = false
    for _, heroItem in ipairs(self.heroItemPool.listItem) do
      local isFinish = heroItem:UpdateExp()
      if not isFinish then
        hasnotFinish = true
      end
    end
    if not hasnotFinish then
      self.playExpAnime = false
    end
  end
end

function UIResultSettlement:OnClickBack()
  if self.isWin then
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    avgPlayCtrl:TryPlayTaskAvg(2, function()
      self:Delete()
      if self.backCallback ~= nil then
        self.backCallback()
      end
    end)
  else
    self:Delete()
    if self.backCallback ~= nil then
      self.backCallback()
    end
  end
end

function UIResultSettlement:OnDelete()
  UpdateManager:RemoveUpdate(self.__updateHandle)
  DestroyUnityObject(self.resultBG_Material)
  self.resultBG_Material = nil
  if self.resloaders ~= nil then
    self.resloaders:Put2Pool()
    self.resloaders = nil
  end
  if self.rewardSequence ~= nil then
    self.rewardSequence:Kill()
    self.rewardSequence = nil
  end
  if self.skillSequence ~= nil then
    self.skillSequence:Kill()
    self.skillSequence = nil
  end
  base.OnDelete(self)
end

return UIResultSettlement
