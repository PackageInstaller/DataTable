local base = UIBaseWindow
local UIReinforceCardDun = class("UIReinforceCardDun", base)
local ReinforceCardDunLevelData = require("Game.Reinforce.UI.CardDun.ReinforceCardDunLevelData")
local UINReinforceCardDunLevelItem = require("Game.Reinforce.UI.CardDun.UINReinforceCardDunLevelItem")
local UINReinforceCardDunBuffItem = require("Game.Reinforce.UI.CardDun.UINReinforceCardDunBuffItem")
local UINReinforceCardDunLeveScoreNode = require("Game.Reinforce.UI.CardDun.UINReinforceCardDunLeveScoreNode")
local UINReinforceCardDunRewardNode = require("Game.Reinforce.UI.CardDun.UINReinforceCardDunRewardNode")
local UINReinforceCardDunCardInfoNode = require("Game.Reinforce.UI.CardDun.UINReinforceCardDunCardInfoNode")
local UINReinforceCardDunBestLevelNode = require("Game.Reinforce.UI.CardDun.UINReinforceCardDunBestLevelNode")
local cs_ResLoader = CS.ResLoader
local cs_DoTween = CS.DG.Tweening.DOTween
local cs_MessageCommon = CS.MessageCommon
local cs_GameData_ins = CS.GameData.instance

function UIReinforceCardDun:OnInit()
  UIUtil.SetTopStatus(self, self.OnCloseFunc, {
    ConstGlobalItem.SKey
  })
  self._resLoader = cs_ResLoader.Create()
  UIUtil.AddButtonListener(self.ui.Btn_Battle, self, self.__OnClickEnterBattle)
  self.levelItemPool = UIItemPool.New(UINReinforceCardDunLevelItem, self.ui.DunItem, false)
  self.buffItemPool = UIItemPool.New(UINReinforceCardDunBuffItem, self.ui.BuffItem, false)
  self.__onSelectLevel = BindCallback(self, self.__OnSelectLevel)
  self.__showSelectFactCard = BindCallback(self, self.__ShowSelectFactCard)
  self.__onLayerChange = BindCallback(self, self.__OnLayerChange)
  self.rewardNode = UINReinforceCardDunRewardNode.New()
  self.rewardNode:Init(self.ui.Reward)
  self.rankNode = UINReinforceCardDunLeveScoreNode.New()
  self.rankNode:Init(self.ui.ScoreRank)
  self.cardInfoNode = UINReinforceCardDunCardInfoNode.New()
  self.cardInfoNode:Init(self.ui.CardInfo)
  self.bestLevelNode = UINReinforceCardDunBestLevelNode.New()
  self.bestLevelNode:Init(self.ui.BestLvl)
end

function UIReinforceCardDun:InitReinforceDun(actData, isInfinityBlood, closeCallback)
  self.actData = actData
  self.levelDataList = {}
  self.closeCallback = closeCallback
  local actId = actData:GetActId()
  local actFrameId = actData:GetActFrameId()
  local levelCfgDic = ConfigData.reinforce_exploration_verify_exploration[actFrameId]
  for stageId, levelCfg in pairs(levelCfgDic) do
    if isInfinityBlood then
      if levelCfg.infinite_score ~= 0 then
        local data = ReinforceCardDunLevelData.New(levelCfg, actData)
        table.insert(self.levelDataList, data)
      end
    elseif levelCfg.infinite_score == 0 then
      local data = ReinforceCardDunLevelData.New(levelCfg, actData)
      table.insert(self.levelDataList, data)
    end
  end
  table.sort(self.levelDataList, function(a, b)
    return a.levelCfg.order_id < b.levelCfg.order_id
  end)
  local dataAll = self.actData:GetActAnv24RfCardDataAll()
  local cardDic = dataAll:GetRfFactorCardDataDic()
  self.factCardDic = cardDic
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local lastIndex = saveUserData:GetAnni24LastInfinityLevelIndex(actId) or 1
  self.__selectedLevelData = self.levelDataList[lastIndex]
  if self.__selectedLevelData == nil then
    self.__selectedLevelData = self.levelDataList[1]
    if self.__selectedLevelData == nil then
      error("this type not have at least one level, pls check it")
      return
    end
  end
  local UID = self.__selectedLevelData:GetLastSelectFactCardId()
  self.__factCardData = self:__GetCardDataByUID(UID)
  self.cardInfoNode:BindActData(self.actData, self._resLoader, self.__showSelectFactCard)
  self:__RefreshLevelList()
  self:__RefreshLevelInfo()
  self:PlayEnterTween()
end

function UIReinforceCardDun:__RefreshLevelList()
  self.levelItemPool:HideAll()
  for index, levelData in ipairs(self.levelDataList) do
    local levelItem = self.levelItemPool:GetOne(true)
    local isSelected = self.__selectedLevelData == levelData
    levelItem:InitReinforceLevelItem(levelData, self.actData, self._resLoader, self.__onSelectLevel)
    levelItem:SetReinforceLevelItemIsSelected(isSelected)
  end
end

function UIReinforceCardDun:__RefreshLevelInfo()
  self.ui.Tex_Title.text = self.__selectedLevelData:GetLevelName()
  local picRes = self.__selectedLevelData:GetLevelBigPic()
  self.ui.Img_Pic.texture = self._resLoader:LoadABAsset(picRes)
  local buffIds = self.__selectedLevelData:GetBuffIds()
  self.buffItemPool:HideAll()
  for _, buffid in ipairs(buffIds) do
    local buffCfg = ConfigData.exploration_buff[buffid]
    if buffCfg.is_listshow then
      local buffItem = self.buffItemPool:GetOne(true)
      buffItem:InitRfCdBuffItem(buffCfg)
      buffItem:BindLayerBuffDes(nil)
      buffItem:SetReinfoceDunBuffCount(nil)
    end
  end
  local isHaveRank = self.__selectedLevelData:IsHaveRank()
  local isHaveLayer = self.__selectedLevelData:IsHaveLayerGroup()
  self.rankNode:Hide()
  self.rewardNode:Hide()
  self.bestLevelNode:Hide()
  if isHaveRank then
    if isHaveLayer then
      self.bestLevelNode:Show()
      self.bestLevelNode:RefreshLayerNode(self.__selectedLevelData, self.actData, self.__onLayerChange)
    else
      self.rankNode:Show()
      self.rankNode:RefreshRankNode(self.__selectedLevelData, self.actData)
    end
  else
    self.rewardNode:Show()
    self.rewardNode:RefreshRewardNode(self.__selectedLevelData, self.actData)
  end
  self.ui.Tex_BatRecNum.text = tostring(self.__selectedLevelData:GetRecPow())
  self:__RefreshFactCardInfo()
end

function UIReinforceCardDun:__RefreshFactCardInfo()
  self.cardInfoNode:RefreshCardInfoNode(self.__factCardData)
end

function UIReinforceCardDun:__OnLayerChange()
  self:__RefreshLevelBuff()
  self.ui.Tex_BatRecNum.text = tostring(self.__selectedLevelData:GetRecPow())
end

function UIReinforceCardDun:__RefreshLevelBuff()
  local buffIds = self.__selectedLevelData:GetBuffIds()
  self.buffItemPool:HideAll()
  for _, buffid in ipairs(buffIds) do
    local buffCfg = ConfigData.exploration_buff[buffid]
    if buffCfg.is_listshow then
      local buffItem = self.buffItemPool:GetOne(true)
      buffItem:InitRfCdBuffItem(buffCfg)
      buffItem:BindLayerBuffDes(nil)
      buffItem:SetReinfoceDunBuffCount(nil)
    end
  end
  local layerGroupId = self.__selectedLevelData:GetLayerGroupId()
  local cfgList = ConfigData.reinforce_exploration_layer_group[layerGroupId]
  local curLevel = self.bestLevelNode.curLevel
  local curCfg = cfgList[curLevel]
  for index, buffid in ipairs(curCfg.infinite_proto_list) do
    local buffLevel = curCfg.proto_level_list[index]
    local battleSkillCfg = cs_GameData_ins.listBattleSkillDatas:GetDataById(buffid)
    if battleSkillCfg == nil then
      error("Battle Skill Cfg is null,Id:" .. tostring(buffid))
      return
    end
    local des = battleSkillCfg:GetLevelDescribe(buffLevel)
    local buffCfg = ConfigData.exploration_buff[buffid]
    local buffItem = self.buffItemPool:GetOne(true)
    buffItem:InitRfCdBuffItem(buffCfg)
    buffItem:BindLayerBuffDes(des)
    buffItem:SetReinfoceDunBuffCount(buffLevel)
  end
end

function UIReinforceCardDun:__ShowSelectFactCard(isShowCurDetail)
  UIManager:ShowWindowAsync(UIWindowTypeID.UIReinforceCardSetSelect, function(win)
    if win == nil then
      return
    end
    win:InitRfCardSetSingleSelect(self.actData:GetActAnv24RfCardDataAll(), self.__factCardData, function(cardData)
      self:__OnSelectFactCard(cardData)
    end, isShowCurDetail)
  end)
end

function UIReinforceCardDun:__OnSelectLevel(levelData)
  self.__selectedLevelData = levelData
  for _, levelItem in pairs(self.levelItemPool.listItem) do
    levelItem:SetReinforceLevelItemIsSelected(levelItem.levelData == self.__selectedLevelData)
  end
  local UID = self.__selectedLevelData:GetLastSelectFactCardId()
  self.__factCardData = self:__GetCardDataByUID(UID)
  self:__RefreshLevelInfo()
  local index = table.indexof(self.levelDataList, levelData)
  local actId = self.actData:GetActId()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:SetAnni24LastInfinityLevelIndex(actId, index)
  self:PlayLevelChangeTween()
end

function UIReinforceCardDun:__OnSelectFactCard(factCardData)
  self.__factCardData = factCardData
  if factCardData ~= nil then
    local uid = factCardData:GetRfCdUID()
    self.__selectedLevelData:SetLastSelectFactCardId(uid)
  else
    self.__selectedLevelData:SetLastSelectFactCardId(nil)
  end
  self:__RefreshFactCardInfo()
end

function UIReinforceCardDun:__OnClickEnterBattle()
  local function EnterFmt()
    local anniversary24Ctrl = ControllerManager:GetController(ControllerTypeId.ActAnniversary24)
    
    local stageId = self.__selectedLevelData:GetStageId()
    local isHighEp = self.__selectedLevelData:IsHighEp()
    local layerLevel
    if self.__selectedLevelData:IsHaveLayerGroup() then
      layerLevel = self.__selectedLevelData:GetLayerIndex()
    end
    anniversary24Ctrl:EnterAnniversaryCardDunEp(stageId, self.__factCardData, isHighEp, layerLevel)
  end
  
  if self.__factCardData == nil then
    cs_MessageCommon.ShowMessageBox(ConfigData:GetTipContent(59025), EnterFmt, nil)
  else
    EnterFmt()
  end
end

function UIReinforceCardDun:__GetCardDataByUID(UID)
  for key, cardData in pairs(self.factCardDic) do
    if cardData:GetRfCdUID() == UID then
      return cardData
    end
  end
end

function UIReinforceCardDun:PlayEnterTween()
  local sequence = cs_DoTween.Sequence():Append(self.ui.cg_Main:DOFade(0, 0.25):From()):Join(self.ui.cg_Main.transform:DOLocalMoveY(-50, 0.3):From()):Insert(0.15, self.ui.cg_DownNode:DOFade(0, 0.25):From()):Join(self.ui.cg_DownNode.transform:DOLocalMoveY(-30, 0.3):From()):AppendCallback(function()
    if self.EnterSequence ~= nil then
      self.EnterSequence = nil
    end
  end):SetLink(self.gameObject)
  self.EnterSequence = sequence
end

function UIReinforceCardDun:PlayLevelChangeTween()
  if self.EnterSequence ~= nil then
    return
  end
  if self.ChangeLevelSequence ~= nil then
    self.ChangeLevelSequence:Restart()
    return
  end
  local sequence = cs_DoTween.Sequence():Append(self.ui.cg_Main:DOFade(0, 0.35):From()):Join(self.ui.cg_Main.transform:DOLocalMoveY(-30, 0.3):From()):AppendCallback(function()
    if self.ChangeLevelSequence ~= nil then
      self.ChangeLevelSequence = nil
    end
  end):SetLink(self.gameObject)
  self.ChangeLevelSequence = sequence
end

function UIReinforceCardDun:OnCloseFunc()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  self:Delete()
end

function UIReinforceCardDun:OnDelete()
  if self._resLoader ~= nil then
    self._resLoader:Put2Pool()
    self._resLoader = nil
  end
  self.levelItemPool:DeleteAll()
  self.buffItemPool:DeleteAll()
  self.rewardNode:Delete()
  self.rankNode:Delete()
  self.cardInfoNode:Delete()
  self.bestLevelNode:Delete()
  base.OnDelete(self)
end

return UIReinforceCardDun
