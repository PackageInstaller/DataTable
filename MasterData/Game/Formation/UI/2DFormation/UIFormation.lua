local UIFormation = class("UIFormation", UIBaseWindow)
local base = UIBaseWindow
local cs_tweening = CS.DG.Tweening
local FormationUtil = require("Game.Formation.FormationUtil")
local JumpManager = require("Game.Jump.JumpManager")
local UINFmtHeroInfoItem = require("Game.Formation.UI.2DFormation.UINFmtHeroInfoItem")
local UINFmtNotEditNode = require("Game.Formation.UI.2DFormation.SubNodes.UINFmtNotEditNode")
local UINFmtEditNode = require("Game.Formation.UI.2DFormation.SubNodes.UINFmtEditNode")
local UINFmtTopNode = require("Game.Formation.UI.2DFormation.SubNodes.UINFmtTopNode")
local GuidePicture = require("Game.Guide.GuidePicture.GuidePicture")

function UIFormation:OnShow()
end

function UIFormation:OnInit()
  self.heroNetwork = NetworkManager:GetNetwork(NetworkTypeID.Hero)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_LastTeam, self, self.__ChangeFormationTeam, -1)
  UIUtil.AddButtonListenerWithArg(self.ui.btn_NextTeam, self, self.__ChangeFormationTeam, 1)
  self.__OnWinShowFunc = BindCallback(self, self.OnWinShowFunc)
  self.__OnClickInfo = BindCallback(self, self.OnClickInfo)
  self.ui.obj_fHeroInfoItem:SetActive(false)
  self.heroInfoPool = UIItemPool.New(UINFmtHeroInfoItem, self.ui.obj_fHeroInfoItem)
  self.heroInfoDic = {}
  self.notEditNode = UINFmtNotEditNode.New()
  self.notEditNode:Init(self.ui.obj_notEditorNode)
  self.topNode = UINFmtTopNode.New()
  self.topNode:Init(self.ui.obj_topNode)
  self.editNode = nil
  self.maskMaterial = nil
  self.ui.img_focusMask.enabled = false
  local editorModelSeq = cs_tweening.DOTween.Sequence()
  editorModelSeq:Append(self.ui.tran_FHeroInfo:DOAnchorPosY(self.ui.tran_FHeroInfo.anchoredPosition.y + 20, 0.5))
  editorModelSeq:Join(self.ui.tran_SwitchBtn:DOAnchorPosY(self.ui.tran_SwitchBtn.anchoredPosition.y + 100, 0.5))
  editorModelSeq:Pause()
  editorModelSeq:SetAutoKill(false)
  self.editorModelSeq = editorModelSeq
  self.notEditorSeq = self:__InitPageSeq(self.ui.can_notEditorNode, function()
    self.notEditNode:Hide()
  end)
  self.editorSeq = self:__InitPageSeq(self.ui.can_editorNode, function()
    if self.editNode == nil then
      self.ui.obj_editorNode:SetActive(false)
    else
      self.editNode:Hide()
    end
  end)
  self.curPageSeq = self.notEditorSeq
  self.curPageSeq:Restart()
end

function UIFormation:InitUIFormation(fmtCtrl, enterFmtData)
  self.fmtCtrl = fmtCtrl
  self.enterFmtData = enterFmtData
  JumpManager.couldUseItemJump = true
  self.notEditNode:InitFmt2DUINode(fmtCtrl, enterFmtData)
  self.topNode:InitFmtTopNode(fmtCtrl, enterFmtData)
  if self.editNode == nil then
    self.ui.obj_editorNode:SetActive(false)
  else
    self.editNode:Hide()
  end
  local stageId = self.enterFmtData:GetFmtCtrlFmtIdStageId()
  local stageCfg = ConfigData.sector_stage[stageId]
  local guid_id = 0
  if stageCfg ~= nil then
    guid_id = stageCfg.guide_id
  end
  local resTab = self:RefreshFmtUIResShow()
  if guid_id ~= 0 then
    UIUtil.SetTopStatus(self, self.OnClickBack, resTab, self.__OnClickInfo, nil, nil, self.__OnWinShowFunc)
  else
    UIUtil.SetTopStatus(self, self.OnClickBack, resTab, nil, nil, nil, self.__OnWinShowFunc)
  end
  GuideManager:TryTriggerGuide(eGuideCondition.InFormation)
  if self.enterFmtData:GetIsOpenSelectDebuff() and self.enterFmtData:GetIsOpenBuffWhenEnter() then
    self.notEditNode.selectDebuffNode:OnClickBuffSelect()
  end
end

function UIFormation:OnWinShowFunc()
  if self.enterFmtData:IsFmtInBattleDeploy(true) or self.enterFmtData:IsFmtInWarChessDeploy() then
    UIUtil.SetTopStatusBtnShow(false, false)
  end
  local win = UIManager:GetWindow(UIWindowTypeID.TopStatus)
  if win ~= nil then
    local resItem = win:GetTopStatusResItem(ConstGlobalItem.HeroExp)
    if resItem ~= nil then
      resItem:SetPlayNumberTweenActive(true)
    end
  end
end

function UIFormation:RefreshAllUIAboutFmtData()
  self.notEditNode:InitFmt2DUINode(self.fmtCtrl, self.enterFmtData)
  self.topNode:InitFmtTopNode(self.fmtCtrl, self.enterFmtData)
  if self.editNode ~= nil then
    self.editNode:RefreshEditNode()
  end
end

function UIFormation:RefreshUIAboutCurFmtDat(totalFtPower, totalBenchPower, campCountDic, top5Total)
  local formationData = self.fmtCtrl:GetFmtCtrlFmtData()
  if totalFtPower == nil then
    totalFtPower, totalBenchPower, campCountDic, top5Total = self.fmtCtrl:CalculatePower(formationData)
  end
  self.notEditNode:RefreshBattlePow(totalFtPower, totalBenchPower, campCountDic, top5Total)
  self.notEditNode:RefreshEvaluateNode()
  self.notEditNode:RefreshEnterBattleTip()
  self.notEditNode:RefreshFairyBtn()
  self.topNode:RefreshCurrentFmtPow(totalFtPower, totalBenchPower)
  if self.editNode ~= nil then
    self.editNode:RefreshPowAndEvaluate(totalFtPower, totalBenchPower)
    self.editNode:RefreshScoreRateNum()
  end
end

function UIFormation:RefreshFmtItemPow(fmtData)
  self.topNode:RefreshFmtItemPow(fmtData)
end

function UIFormation:RefreshFmtUIResShow()
  if self.enterFmtData:IsBondModule() then
    return nil
  end
  local showExp = self.enterFmtData:GetIsFmtExpShow()
  local showStamina = self.enterFmtData:GetIsFmtStaminaShow()
  local notStaminaTicketItemId = self.enterFmtData:GetIsFmtTicketId()
  local resTab = {}
  if showExp then
    table.insert(resTab, ConstGlobalItem.HeroExp)
  end
  if showStamina then
    table.insert(resTab, notStaminaTicketItemId)
  end
  return resTab
end

function UIFormation:EnterEditorMode()
  if self.editNode == nil then
    self.editNode = UINFmtEditNode.New()
    self.editNode:Init(self.ui.obj_editorNode)
    self.editNode:InitFmtEditNode(self.fmtCtrl, self.enterFmtData)
  end
  self.editNode:Show()
  self.editNode:OpenEmtEditNode()
  self.editorModelSeq:Restart()
  self:__SwitchPageTween(self.editorSeq)
end

function UIFormation:ExitEditorMode()
  self.notEditNode:Show()
  self.editorModelSeq:PlayBackwards()
  self:__SwitchPageTween(self.notEditorSeq)
end

function UIFormation:__ChangeFormationTeam(num)
  local idOffset = FormationUtil.GetFmtIdOffsetByFmtFromModule(self.enterFmtData:GetFmtCtrlFromModule(), self.enterFmtData:GetFmtCtrlFmtIdStageId())
  local id = self.enterFmtData:GetFmtCtrlFmtId() + num - idOffset
  local max = self.enterFmtData:GetFmtTeamSize()
  if id > max then
    id = 1
  elseif id < 1 then
    id = max
  end
  local index = id
  id = id + idOffset
  self.fmtCtrl:FmtCtrlSwitchFmt(id, index)
end

function UIFormation:SetSwitchButtonActive(active)
  self.ui.btn_LastTeam.gameObject:SetActive(active)
  self.ui.btn_NextTeam.gameObject:SetActive(active)
end

function UIFormation:SetFormationFocus(isOpen, heroPos)
  if isOpen then
    if self.maskMaterial == nil then
      self.maskMaterial = CS.UnityEngine.Object.Instantiate(self.ui.mat_maskFoucus)
    end
    self.ui.img_focusMask.material = self.maskMaterial
    self.ui.img_focusMask.enabled = true
    local screenPos = UIManager:GetMainCamera():WorldToScreenPoint(heroPos)
    self.maskMaterial:SetVector("_Item", Vector4.New(screenPos.x, screenPos.y, 0, 0))
    self.maskMaterial:SetFloat("_Radius", 0.01)
  else
    self.ui.img_focusMask.enabled = false
  end
end

function UIFormation:RefreshFmtCST()
  self.notEditNode:RefreshCSTNode()
end

function UIFormation:RefreshFmtPower()
  self.notEditNode:RefreshBattlePow()
end

function UIFormation:TryRefreshHeroCards(heroIdDic, isSkin)
  if self.editNode ~= nil then
    self.editNode:TryRefreshHeroCard(heroIdDic, isSkin)
  end
end

function UIFormation:CreatFmtHeroInfo(heroData, position)
  if self.heroInfoDic[heroData.dataId] ~= nil then
    local infoItem = self.heroInfoDic[heroData.dataId]
    self:UpdateFmtHeroInfo(heroData, position)
    return infoItem
  end
  local infoItem = self.heroInfoPool:GetOne()
  infoItem:InitFmtHeroInfo(self.fmtCtrl, self.enterFmtData)
  infoItem:RefreshFmtheroInfo(heroData, position)
  self.heroInfoDic[heroData.dataId] = infoItem
  return infoItem
end

function UIFormation:UpdateFmtHeroInfo(heroData, position, onlyPos)
  local infoItem = self.heroInfoDic[heroData.dataId]
  if infoItem == nil then
    return
  end
  infoItem:RefreshFmtheroInfo(heroData, position, onlyPos)
end

function UIFormation:ShowFmtHeroInfo(heroId, show)
  local infoItem = self.heroInfoDic[heroId]
  if infoItem == nil then
    return
  end
  if show then
    infoItem:Show()
  else
    infoItem:Hide()
  end
end

function UIFormation:ReturnFmtHeroInfo(heroId)
  local infoItem = self.heroInfoDic[heroId]
  if infoItem == nil then
    return
  end
  self.heroInfoDic[heroId] = nil
  self.heroInfoPool:HideOne(infoItem)
end

function UIFormation:ShowChangeMark(flag)
  for k, heroInfoItem in pairs(self.heroInfoDic) do
    heroInfoItem:SetChangeMarkState(flag)
  end
end

function UIFormation:SetUIFmtHeroInfoItemLv(heroId, level)
  local heroItem = self.heroInfoDic[heroId]
  if heroItem ~= nil then
    heroItem:SetFmtHeroInfoItemLv(level)
  end
end

function UIFormation:__SwitchPageTween(curPageSeq)
  if self.curPageSeq == curPageSeq then
    return
  end
  self.curPageSeq:PlayBackwards()
  curPageSeq:Restart()
  self.curPageSeq = curPageSeq
end

function UIFormation:__InitPageSeq(pageFade, rewindAct)
  local pageSeq = cs_tweening.DOTween.Sequence()
  pageSeq:Append(pageFade:DOFade(0, 0.5):From())
  pageSeq:Join(pageFade.transform:DOAnchorPosY(pageFade.transform.anchoredPosition.y - 200, 0.5):From())
  pageSeq:OnRewind(rewindAct)
  pageSeq:Pause()
  pageSeq:SetAutoKill(false)
  return pageSeq
end

function UIFormation:IsFmtToltalPowerWarn()
  return self.notEditNode._totalFtPowerWarn
end

function UIFormation:OnClickBack()
  self.fmtCtrl:ExitFormation()
  self:Delete()
end

function UIFormation:OnClickInfo()
  local stageId = self.enterFmtData:GetFmtCtrlFmtIdStageId()
  local stageCfg = ConfigData.sector_stage[stageId]
  if not stageCfg then
    return
  end
  GuidePicture.OpenGuidePicture(stageCfg.guide_id)
end

function UIFormation:OnDelete()
  JumpManager.couldUseItemJump = false
  if self.editorModelSeq ~= nil then
    self.editorModelSeq:Kill()
    self.editorModelSeq = nil
  end
  if self.notEditorSeq ~= nil then
    self.notEditorSeq:Kill()
    self.notEditorSeq = nil
  end
  if self.editorSeq ~= nil then
    self.editorSeq:Kill()
    self.editorSeq = nil
  end
  self.heroInfoPool:DeleteAll()
  self.notEditNode:Delete()
  self.topNode:Delete()
  if self.editNode ~= nil then
    self.editNode:Delete()
  end
  if self.maskMaterial ~= nil then
    DestroyUnityObject(self.maskMaterial)
    self.maskMaterial = nil
  end
  base.OnDelete(self)
end

return UIFormation
