local UINFmtNotEditNode = class("UINFmtNotEditNode", UIBaseNode)
local base = UIBaseNode
local cs_tweening = CS.DG.Tweening
local cs_MessageCommon = CS.MessageCommon
local UINFmtChallengeTask = require("Game.Formation.UI.ChallengeTask.UINFmtChallengeTask")
local UINBtnCommanderSkill = require("Game.Formation.UI.2DFormation.UINBtnCommanderSkill")
local UINFmtEvaluation = require("Game.Formation.UI.FormationEvaluation.UIFmtEvaluation")
local UINFmtDebuffNode = require("Game.Formation.UI.2DFormation.UINFmtDebuffNode")
local UINFmtEnvBuffNode = require("Game.Formation.UI.2DFormation.UINFmtEnvBuffNode")
local UINFmtFairyBtn = require("Game.Formation.UI.2DFormation.UINFmtFairyBtn")

function UINFmtNotEditNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Editor, self, self.__OnClickEdit)
  UIUtil.AddButtonListener(self.ui.btn_SelectChip, self, self.__OnClickChipList)
  UIUtil.AddButtonListener(self.ui.btn_Battle, self, self.__OnClickBattle)
  UIUtil.AddButtonListener(self.ui.btn_Continue, self, self.__OnClickContinue)
  self.__isLowPower = nil
  self.fairyBtn = UINFmtFairyBtn.New()
  self.fairyBtn:Init(self.ui.obj_btn_Fairy)
end

function UINFmtNotEditNode:InitFmt2DUINode(fmtCtrl, enterFmtData)
  self.fmtCtrl = fmtCtrl
  self.enterFmtData = enterFmtData
  self:RefreshBattleBtnState()
  self:RefreshBattlePow()
  self:RefreshChallengeNode()
  self:RefreshCSTNode()
  self:RefreshEvaluateNode()
  self:RefreshSelectDebuffNode()
  self:RefreshChipListBtn()
  self:RefreshFmtEditBtn()
  self:RefreshEnterBattleTip()
  self:RefreshFairyBtn()
  self:RefreshRightGroup()
  self:RefreshSelectEnvBuffNode()
end

function UINFmtNotEditNode:RefreshBattleBtnState()
  local isShowContinue = self.enterFmtData:IsFmtInBattleDeploy() or self.enterFmtData:IsFmtInWarChessDeploy()
  local isHaveBattleFunc = self.enterFmtData:GetFmtCtrlStartBattleFunc() ~= nil
  self.ui.btn_Battle.gameObject:SetActive(not isShowContinue and isHaveBattleFunc)
  self.ui.btn_Continue.gameObject:SetActive(isShowContinue)
  if isShowContinue then
    return
  end
  if self.enterFmtData:GetIsAutoBattleState() then
    self.ui.tex_Battle:SetIndex(1)
  elseif self.enterFmtData:IsFmtChallengeMode() then
    self.ui.tex_Battle:SetIndex(2)
  else
    self.ui.tex_Battle:SetIndex(0)
  end
  local staminaCost = self.enterFmtData:GetStaminaCost()
  local notStaminaTicketItemId = self.enterFmtData:GetIsFmtTicketId()
  self.ui.image_key.sprite = CRH:GetDefaultKeySprite(notStaminaTicketItemId)
  if staminaCost ~= nil then
    self.ui.tex_Point:SetIndex(0, tostring(staminaCost))
  end
end

function UINFmtNotEditNode:RefreshBattlePow(totalFtPower, totalBenchPower, campCountDic, top5Total)
  local couldShowNormalNode = true
  couldShowNormalNode = couldShowNormalNode and self.enterFmtData:GetIsShowEditNormalObj()
  self.ui.obj_normalNode:SetActive(couldShowNormalNode)
  if not couldShowNormalNode then
    return
  end
  local isShowPower = self.enterFmtData:GetIsShowTotalPow()
  local isHideRecommandPower = self.enterFmtData:GetIsHideRecommandPow()
  if self.enterFmtData:IsFmtHaveChallengeMode() then
    isShowPower = not self.enterFmtData:GetFmtChallengeModeData():IsStageChallengeOpen()
  end
  self.ui.obj_totalPower:SetActive(isShowPower)
  self.ui.obj_recomendPower:SetActive(isShowPower and not isHideRecommandPower)
  if not isShowPower then
    return
  end
  if totalFtPower == nil then
    local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
    totalFtPower, totalBenchPower, campCountDic, top5Total = self.fmtCtrl:CalculatePower(formationData)
  end
  self.ui.tex_TotalPower.text = tostring(totalFtPower)
  self.ui.tex_BenchTotalPower.text = tostring(totalBenchPower)
  local stageRecommendPower, benchRecommendPower = self.enterFmtData:GetFmtCtrlRecommendPower()
  self.ui.tex_RecomendPower.text = tostring(math.floor(stageRecommendPower))
  self.ui.tex_RecomendBenchPower.text = tostring(math.floor(benchRecommendPower))
  local warnRate = (ConfigData.game_config.formationPowWarn or 80) * 0.01
  local minPower = math.floor(stageRecommendPower * warnRate)
  self.__isLowPower = minPower > (top5Total or 0)
  local isLow = totalFtPower < stageRecommendPower
  local isBenchLow = totalBenchPower < benchRecommendPower
  self:__SetBattlePowTween(isLow, isBenchLow)
  self._totalFtPowerWarn = isLow
end

function UINFmtNotEditNode:__SetBattlePowTween(isLow, isBenchLow)
  self.ui.img_LowPower:DORewind()
  self.ui.img_LowPower:DOKill()
  if isLow then
    self.ui.img_LowPower:DOFade(0, 1.5):SetLoops(-1, cs_tweening.LoopType.Yoyo):SetLink(self.ui.img_LowPower.gameObject)
  end
  self.ui.img_LowBeachPow:DORewind()
  self.ui.img_LowBeachPow:DOKill()
  if isBenchLow then
    self.ui.img_LowBeachPow:DOFade(0, 1.5):SetLoops(-1, cs_tweening.LoopType.Yoyo):SetLink(self.ui.img_LowBeachPow.gameObject)
  end
  self.ui.img_LowPower.enabled = isLow
  self.ui.img_LowBeachPow.enabled = isBenchLow
end

function UINFmtNotEditNode:RefreshChallengeNode()
  if self.enterFmtData:IsFmtHaveChallengeMode() then
    if self.fmtChallengeNode == nil then
      self.fmtChallengeNode = UINFmtChallengeTask.New()
      self.fmtChallengeNode:Init(self.ui.obj_challengeNode)
    end
    self.fmtChallengeNode:Show()
    self.fmtChallengeNode:InitFmtChallengeTask(self.fmtCtrl, self.enterFmtData, self)
  elseif self.fmtChallengeNode == nil then
    self.ui.obj_challengeNode:SetActive(false)
  else
    self.fmtChallengeNode:Hide()
  end
end

function UINFmtNotEditNode:RefreshCSTNode()
  local ctrlLock = self.enterFmtData:GetIsCloseCommandSkill()
  local isCSUnlock = not ctrlLock and FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill) and FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_commander_skill_Ui)
  if isCSUnlock then
    if self.btnCstItem == nil then
      self.btnCstItem = UINBtnCommanderSkill.New()
      self.btnCstItem:Init(self.ui.obj_btn_CommanderSkill)
    end
    self.btnCstItem:Show()
    self.btnCstItem:InitBtnCommanderSkill4FmtCtrl(self.fmtCtrl, self.enterFmtData)
    local isFixed, skills = self.enterFmtData:GetFixedCstSkills()
    if isFixed then
      self.btnCstItem:RefreshCstByIdAndList(0, skills, isFixed)
      return
    end
    local cstData = self.fmtCtrl:GetFmtCtrlFmtCSTData()
    local ctsDataList = self.fmtCtrl:GetFmtCtrlFmtCSTDataList()
    self.btnCstItem:RefreshCstByTreeInfo(cstData, ctsDataList)
  elseif self.btnCstItem == nil then
    self.ui.obj_btn_CommanderSkill:SetActive(false)
  else
    self.btnCstItem:Hide()
  end
end

function UINFmtNotEditNode:RefreshEvaluateNode()
  local isOpenEvaluate = self.enterFmtData:GetIsOpenFmtEvaluate()
  if isOpenEvaluate then
    if self.UIFmtEvaluation == nil then
      self.UIFmtEvaluation = UINFmtEvaluation.New()
      self.UIFmtEvaluation:Init(self.ui.obj_formationEvaluation)
      local sectorStageId = self.enterFmtData:GetFmtCtrlFmtIdStageId()
      local fromModule = self.enterFmtData:GetFmtCtrlFromModule()
      self.UIFmtEvaluation:InitializeAdvantageConfig(sectorStageId, fromModule)
    end
    self.UIFmtEvaluation:Show()
    local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
    self.UIFmtEvaluation:AnalysisFormation(formationData.data)
  elseif self.UIFmtEvaluation == nil then
    self.ui.obj_formationEvaluation:SetActive(false)
  else
    self.UIFmtEvaluation:Hide()
  end
end

function UINFmtNotEditNode:RefreshSelectDebuffNode()
  local isOpenBuffSelect = self.enterFmtData:GetIsOpenSelectDebuff()
  if isOpenBuffSelect then
    if self.selectDebuffNode == nil then
      self.selectDebuffNode = UINFmtDebuffNode.New()
      self.selectDebuffNode:Init(self.ui.obj_debuffSelect)
    end
    self.selectDebuffNode:RefreshDebuffNode(self.fmtCtrl, self.enterFmtData)
    self.selectDebuffNode:Show()
  elseif self.selectDebuffNode == nil then
    self.ui.obj_debuffSelect:SetActive(false)
  else
    self.selectDebuffNode:Hide()
  end
end

function UINFmtNotEditNode:RefreshSelectEnvBuffNode()
  local isOpenBuffSelect = self.enterFmtData:GetIsOpenSelectEnvBuff()
  if isOpenBuffSelect then
    if self.selectEnvBuffNode == nil then
      self.selectEnvBuffNode = UINFmtEnvBuffNode.New()
      self.selectEnvBuffNode:Init(self.ui.obj_roomBuff)
    end
    self.selectEnvBuffNode:RefreshEnvBuffNode(self.fmtCtrl, self.enterFmtData)
    self.selectEnvBuffNode:Show()
  elseif self.selectEnvBuffNode == nil then
    self.ui.obj_roomBuff:SetActive(false)
  else
    self.selectEnvBuffNode:Hide()
  end
end

function UINFmtNotEditNode:RefreshChipListBtn()
  local chipDataList = self.enterFmtData:GetFmtChipDataList()
  local isHaveChip = chipDataList ~= nil and 0 < #chipDataList
  self.ui.btn_SelectChip.gameObject:SetActive(isHaveChip)
  if isHaveChip then
    if self.UIFmtEvaluation == nil then
      self.ui.obj_formationEvaluation:SetActive(true)
    else
      self.UIFmtEvaluation:Show()
    end
  end
end

function UINFmtNotEditNode:RefreshFmtEditBtn()
  if self.enterFmtData:IsFmtCtrlFiexd() then
    if self.enterFmtData:HasFmtFixedExtra() then
      self.ui.btn_Editor.gameObject:SetActive(true)
    else
      self.ui.btn_Editor.gameObject:SetActive(false)
    end
  elseif self.enterFmtData:GetIsEpInifinity() then
    self.ui.btn_Editor.gameObject:SetActive(false)
  end
end

function UINFmtNotEditNode:RefreshEnterBattleTip()
  local isChallengeMode = self.enterFmtData:IsFmtChallengeMode()
  if isChallengeMode then
    self.ui.obj_WarnTips:SetActive(true)
    self.ui.tex_WarnTips:SetIndex(0)
  elseif self.enterFmtData:IsFmtCtrlFiexd() and not self.enterFmtData:IsFmtFixedHeroFull(self.fmtCtrl:GetFmtCtrlFmtData()) then
    self.ui.obj_WarnTips:SetActive(true)
    self.ui.tex_WarnTips:SetIndex(1)
  else
    self.ui.obj_WarnTips:SetActive(false)
  end
end

function UINFmtNotEditNode:RefreshFairyBtn()
  local isFairyUnlock = FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_fairy)
  if not (self.enterFmtData:GetFmtIsShowFairy() and isFairyUnlock) or self.enterFmtData:GetIsEpInifinity() then
    self.fairyBtn:Hide()
    return
  else
    self.fairyBtn:Show()
  end
  local resloader = self.fmtCtrl:GetFmtCtrlResloader()
  local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
  local fairyData = formationData:GetFmtFairyData()
  self.fairyBtn:SetCurFmtFairy(fairyData, resloader, function()
    UIManager:CreateWindowAsync(UIWindowTypeID.FairyFormation, function(win)
      if win == nil then
        return
      end
      win:InitSelectFairy()
    end)
  end)
end

function UINFmtNotEditNode:RefreshRightGroup()
  local isShowPower = self.enterFmtData:GetIsShowTotalPow()
  self.ui.obj_powergroup:SetActive(isShowPower or self.ui.obj_WarnTips.activeSelf)
end

function UINFmtNotEditNode:__OnClickEdit()
  self.fmtCtrl:FmtCtrlEnterEditSate()
end

function UINFmtNotEditNode:__OnClickChipList()
  local chipDataList = self.enterFmtData:GetFmtChipDataList()
  if chipDataList ~= nil and 0 < #chipDataList then
    UIManager:ShowWindowAsync(UIWindowTypeID.CurrentChip, function(window)
      window:InitCurrentChip(chipDataList)
    end)
  end
end

function UINFmtNotEditNode:__OnClickBattle()
  if self.__isLowPower and not self.enterFmtData:IsFmtChallengeMode() then
    local tip = self.fmtCtrl:GetLowerEfficiencyTip(self.enterFmtData.stageId)
    cs_MessageCommon.ShowMessageBox(tip, function()
      self.fmtCtrl:FmtStartBattle()
    end, nil)
  else
    self.fmtCtrl:FmtStartBattle()
  end
end

function UINFmtNotEditNode:__OnClickContinue()
  if self.enterFmtData:IsFmtInWarChessDeploy() then
    local callback = self.enterFmtData:GetDeployOverCallback()
    if callback ~= nil then
      callback(self.fmtCtrl.__fmtData)
    end
  end
  UIUtil.OnClickBackByWinId(UIWindowTypeID.Formation)
end

function UINFmtNotEditNode:OnDelete()
  if self.fmtChallengeNode ~= nil then
    self.fmtChallengeNode:Delete()
  end
  if self.selectEnvBuffNode ~= nil then
    self.selectEnvBuffNode:Delete()
  end
end

return UINFmtNotEditNode
