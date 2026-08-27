local UINCardSetDown = class("UINCardSetDown", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon
local CardSetEnum = require("Game.CardSet.Data.CardSetEnum")
local UINCardSetDiffSelect = require("Game.CardSet.UI.Set.DownNode.UINCardSetDiffSelect")
local cs_scrambleMode = CS.DG.Tweening.ScrambleMode

function UINCardSetDown:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Battle, self, self.__OnClickBattle)
  UIUtil.AddButtonListener(self.ui.btn_ShortBattle, self, self.__OnClickBattle)
  UIUtil.AddButtonListener(self.ui.btn_NextRound, self, self.__OnClickNextRound)
  UIUtil.AddButtonListener(self.ui.btn_DiffSwitch, self, self.__OnClickDiff)
  UIUtil.AddButtonListener(self.ui.btn_Potion, self, self.__OnClickPosition)
  self.diffNode = UINCardSetDiffSelect.New()
  self.diffNode:Init(self.ui.node_diffSelectedWindow)
  self.__onDiffChange = BindCallback(self, self.__OnDiffChange)
  MsgCenter:AddListener(eMsgEventId.OnCardSetDiffChange, self.__onDiffChange)
  self.__onCardChange = BindCallback(self, self.__OnCardChange)
  MsgCenter:AddListener(eMsgEventId.OnCardSetCardChange, self.__onCardChange)
  MsgCenter:AddListener(eMsgEventId.OnCardSetCardEffectIdChange, self.__onCardChange)
  self._OnPointDeficiencyFunc = BindCallback(self, self._OnPointDeficiency)
  MsgCenter:AddListener(eMsgEventId.OnCardSetPointDeficiency, self._OnPointDeficiencyFunc)
end

function UINCardSetDown:InitCardDownNode(cardSetCtrl)
  local cardSetData = cardSetCtrl:GetCardSetData()
  self._cardSetData = cardSetData
  self.__cardSetActData = cardSetData:GetActCardSetData()
  self.cardSetCtrl = cardSetCtrl
  self:RefreshCardSetDiff()
  self:RefreshCardSetAdd()
  self:RefreshPotionNum()
  self.diffNode:Hide()
  self.diffNode:InitCardDiffSelect(cardSetCtrl)
  self:_UpdBattleBtn()
  self:_UpdPlayTypeState()
  local itemCfg = cardSetData:GetCurCardSetScoreItemCfg()
  self.ui.img_ScoreIcon.sprite = CRH:GetSprite(itemCfg.small_icon)
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local actId = self.__cardSetActData:GetActId()
  local diffBtnRead = saveUserData:GetCardSetDiffBtnRead(actId)
  self.ui.obj_DiffBlueDot:SetActive(not diffBtnRead)
end

function UINCardSetDown:_UpdPlayTypeState()
  local playType = self.cardSetCtrl:GetCardSetPlayType()
  if playType == CardSetEnum.eSetType.rank then
    self.ui.obj_RemainNum:SetActive(false)
  else
    self.ui.obj_RemainNum:SetActive(true)
    local battlePoint = self._cardSetData:GetCardSetBattlePoint()
    self.ui.tex_RemainNum.text = tostring(battlePoint)
  end
end

function UINCardSetDown:_PlayRemainNumShake()
  self.ui.tex_RemainNum:DOKill()
  self.ui.tex_RemainNum.transform:DOShakePosition(0.5, Vector3.Temp(5, 0.5, 0), 25):SetLink(self.ui.tex_RemainNum.gameObject):SetRecyclable()
end

function UINCardSetDown:_OnPointDeficiency()
  self:_PlayRemainNumShake()
end

function UINCardSetDown:_UpdBattleBtn()
  local cardSetData = self.cardSetCtrl:GetCardSetData()
  local diffData = cardSetData:GetCardSetCurDiffData()
  local playType = self.cardSetCtrl:GetCardSetPlayType()
  self.ui.tex_LongText.gameObject:SetActive(false)
  self.ui.btn_NextRound.gameObject:SetActive(false)
  self.ui.btn_ShortBattle.gameObject:SetActive(false)
  self.ui.btn_Battle.gameObject:SetActive(false)
  self._battleBtnIsNextRound = false
  if playType == CardSetEnum.eSetType.normal or playType == CardSetEnum.eSetType.rewind then
    local battlePoint = cardSetData:GetCardSetBattlePoint()
    local costPoint = diffData:GetCardSetDiffCostBattlePoint()
    local costReduce = cardSetData:GetCardSetCostReduce()
    costPoint = math.max(costPoint - costReduce, 0)
    local isCanBattle = 0 <= battlePoint - costPoint
    self.ui.tex_Cost:SetIndex(0, tostring(costPoint))
    if isCanBattle then
      self.ui.btn_ShortBattle.gameObject:SetActive(true)
      self.ui.btn_NextRound.gameObject:SetActive(true)
      self.ui.tex_NextRoundText:SetIndex(playType == CardSetEnum.eSetType.normal and 0 or 1)
    else
      self.ui.btn_Battle.gameObject:SetActive(true)
      self._battleBtnIsNextRound = true
      self.ui.img_Battle:SetIndex(0)
      self.ui.tex_LongText:SetIndex(playType == CardSetEnum.eSetType.normal and 1 or 2)
      self.ui.tex_LongText.gameObject:SetActive(true)
    end
  elseif playType == CardSetEnum.eSetType.rank then
    self.ui.btn_Battle.gameObject:SetActive(true)
    self.ui.img_Battle:SetIndex(1)
    self.ui.tex_LongText:SetIndex(0)
    self.ui.tex_LongText.gameObject:SetActive(true)
  end
end

function UINCardSetDown:RefreshCardSetDiff()
  local cardSetData = self.cardSetCtrl:GetCardSetData()
  local diffData = cardSetData:GetCardSetCurDiffData()
  local playType = self.cardSetCtrl:GetCardSetPlayType()
  self.ui.tex_DiffLvl.text = diffData:GetCardSetDiffName()
  self.ui.obj_Ex:SetActive(diffData:IsChallengeCardSetDiff())
end

function UINCardSetDown:RefreshCardSetAdd()
  local cardSetData = self.cardSetCtrl:GetCardSetData()
  local isHaveAllNecessaryCard = self.cardSetCtrl:CheckCouldStartBattle(cardSetData)
  local addReate, point, recommendPow = cardSetData:GenCardSetNum()
  local playType = self.cardSetCtrl:GetCardSetPlayType()
  self.ui.tex_AdditonTitle:SetIndex(playType == CardSetEnum.eSetType.rank and 1 or 0)
  self.ui.tex_Additon:SetIndex(0, tostring(math.floor(addReate / 10)))
  self.ui.tex_Point:DOText(tostring(point), 0.5, true, cs_scrambleMode.Numerals):SetLink(self.gameObject):SetEase(CS.DG.Tweening.Ease.OutQuart)
  if isHaveAllNecessaryCard then
    self.ui.tex_RecommendPow.text = tostring(recommendPow)
  else
    self.ui.tex_RecommendPow.text = "-"
  end
end

function UINCardSetDown:RefreshPotionNum()
  local lockedTeamNum = self._cardSetData:GetCardSetBannedHeroTeaNum()
  self.ui.tex_PotionDownNum.text = tostring(lockedTeamNum)
end

function UINCardSetDown:__OnDiffChange()
  self:RefreshCardSetDiff()
  self:RefreshCardSetAdd()
  self:_UpdBattleBtn()
end

function UINCardSetDown:__OnCardChange()
  self:RefreshCardSetAdd()
  self:_UpdBattleBtn()
end

function UINCardSetDown:__OnClickBattle()
  if self._battleBtnIsNextRound then
    self:__OnClickNextRound()
    return
  end
  local playType = self.cardSetCtrl:GetCardSetPlayType()
  local cardSetData = self.cardSetCtrl:GetCardSetData()
  if playType ~= CardSetEnum.eSetType.rank then
    local battlePoint = cardSetData:GetCardSetBattlePoint()
    local diffData = cardSetData:GetCardSetCurDiffData()
    local costPoint = diffData:GetCardSetDiffCostBattlePoint()
    local costReduce = cardSetData:GetCardSetCostReduce()
    costPoint = math.max(costPoint - costReduce, 0)
    if battlePoint < costPoint then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(2210))
      return
    end
  end
  if self.cardSetCtrl:CheckCouldStartBattle(cardSetData) then
    self.cardSetCtrl:SendCardSelectInfo(cardSetData, function()
      self.cardSetCtrl:CardSetEnterFormation(cardSetData)
    end)
  else
    cs_MessageCommon.ShowMessageTips(ConfigData:GetTipContent(2204))
  end
end

function UINCardSetDown:__OnClickNextRound()
  local playType = self.cardSetCtrl:GetCardSetPlayType()
  if playType == CardSetEnum.eSetType.rewind then
    self:_OnClickEndRewind()
    return
  end
  
  local function reqNextRoundFunc()
    local actCardSetData = self.cardSetCtrl:GetCdStActData()
    if not actCardSetData:IsActCardSetTicketsEnough() then
      cs_MessageCommon.ShowMessageTipsWithErrorSound(ConfigData:GetTipContent(2212))
      return
    end
    local cardSetData = self.cardSetCtrl:GetCardSetData()
    self.cardSetCtrl:ReqCardSetRoundNext(cardSetData)
  end
  
  local cardSetData = self.cardSetCtrl:GetCardSetData()
  local curRound = cardSetData:GetCardSetCurRound()
  if cardSetData:GetCardSetIsLastRound(curRound) then
    local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    window:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(2220), reqNextRoundFunc)
    return
  end
  if PlayerDataCenter.cacheSaveData:GetEnableActivityCardSetNextRoundConfirm() then
    local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    window:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(2211), reqNextRoundFunc)
    window:ShowDontRemindTog(function(flag)
      PlayerDataCenter.cacheSaveData:SetEnableActivityCardSetNextRoundConfirm(not flag)
    end, false)
    return
  end
  reqNextRoundFunc()
end

function UINCardSetDown:_OnClickEndRewind()
  local function reqFunc()
    self.cardSetCtrl:ReqCardSetRewindRoundOver()
  end
  
  if PlayerDataCenter.cacheSaveData:GetEnableActivityCardSetRewindEndConfirm() then
    local window = UIManager:ShowWindow(UIWindowTypeID.MessageCommon)
    window:ShowTextBoxWithYesAndNo(ConfigData:GetTipContent(2215), reqFunc)
    window:ShowDontRemindTog(function(flag)
      PlayerDataCenter.cacheSaveData:SetEnableActivityCardSetRewindEndConfirm(not flag)
    end, false)
    return
  end
  reqFunc()
end

function UINCardSetDown:__OnClickDiff()
  self.diffNode:Show()
  self.diffNode:InitCardDiffSelect(self.cardSetCtrl)
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local actId = self.__cardSetActData:GetActId()
  local diffBtnRead = saveUserData:SetCardSetDiffBtnRead(actId)
  self.ui.obj_DiffBlueDot:SetActive(false)
end

function UINCardSetDown:__OnClickPosition()
  UIManager:ShowWindowAsync(UIWindowTypeID.CardSetLockedTeam, function(win)
    if win ~= nil then
      local cardSetData = self.cardSetCtrl:GetCardSetData()
      win:InitCardSetLockedFmt(cardSetData)
    end
  end)
end

function UINCardSetDown:OnDelete()
  MsgCenter:RemoveListener(eMsgEventId.OnCardSetDiffChange, self.__onDiffChange)
  MsgCenter:RemoveListener(eMsgEventId.OnCardSetCardChange, self.__onCardChange)
  MsgCenter:RemoveListener(eMsgEventId.OnCardSetCardEffectIdChange, self.__onCardChange)
  MsgCenter:RemoveListener(eMsgEventId.OnCardSetPointDeficiency, self._OnPointDeficiencyFunc)
  base.OnDelete(self)
end

return UINCardSetDown
