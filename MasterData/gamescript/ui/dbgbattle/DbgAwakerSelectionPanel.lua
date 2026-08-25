local BP = bc.BattleProperty
local Z1ButtonState = CS.Z1Client.Z1ButtonState
local typeof = _ENV.typeof
local UIAnimationController = CS.Z1Client.UIAnimationController
local SayeAwakerSelectVxAnimOpen = "UI_Vx_Battle_B15_02_Open"
local SayeAwakerSelectVxAnimLoop = "UI_Vx_Battle_B15_02_Loop"
local SayeAwakerSelectVxAnimClose = "UI_Vx_Battle_B15_02_Close"
local DbgAwakerSelectionPanel, Super = System.NewClass("DbgAwakerSelectionPanel", UIBasePanel)
DbgAwakerSelectionPanel.uiResCls = UI_Battle_Popup_SelectAwakerResource
DbgAwakerSelectionPanel.__ignorMaskClose = true
local MUST_SELECT_ALL = 0

function DbgAwakerSelectionPanel:ctor(selectData, callback)
  Super.ctor(self)
  self.selectData = selectData
  self.callback = callback
  self._sayeVxAnimCtrl = nil
  self.cancelable = selectData.cancelable
  bg.SendBattleEvent(rc.BattleEvent.BattleUIOpen, self.__name)
  self.selectNum = selectData.selectNum or 1
  self.selectLogic = selectData.selectLogic
  self.selectedDic = {}
end

function DbgAwakerSelectionPanel:OnBind(binder)
  self.binder = binder
  if self.selectData.desc then
    self.binder:SetText(self.ui.Text_C_Title, LT.Text(self.selectData.desc))
  end
  self.binder:SetText(self.ui.Text_Btn_Confirm, LT.Text("UniversalConfirmButton"))
  self.binder:SetActive(self.ui.Btn_Confirm, self.selectNum > 1)
  self.binder:BindButtonClick(self.ui.Btn_Confirm, function()
    if self.callback then
      local keys = table.keys(self.selectedDic)
      if self.selectLogic == MUST_SELECT_ALL then
        self.callback(keys)
      end
    end
    self:Close()
  end)
  local count = #self.selectData.targetUids
  for index, targetUid in ipairs(self.selectData.targetUids) do
    local awaker = bg.battleDataCenter:GetAwakerDataModel(targetUid)
    local paintingPath = DT.AwakerConfig[awaker.tid].AwakeList
    paintingPath = bg.battleDataCenter:ReplaceSkinPath(paintingPath, targetUid)
    binder:SetImage(self.ui["Image_Awaker_" .. index], paintingPath)
    local selectedImg = self.ui["Image_Select_" .. index]
    
    local function clickFunc()
      if 1 == self.selectNum then
        self:Close()
        if self.callback then
          self.callback({
            awaker.uid
          })
        end
      else
        self.selectedDic[awaker.uid] = not self.selectedDic[awaker.uid]
        selectedImg:SetActive(self.selectedDic[awaker.uid])
        self:CheckConfirmBtnState()
      end
    end
    
    binder:BindButtonClick(self.ui["Btn_Select_" .. index], clickFunc)
    local energy = awaker:GetProperty(BP.ulti_energy)
    binder:SetActive(self.ui["Text_Mad_" .. index], true)
    binder:SetText(self.ui["Text_Mad_" .. index], LT.Textf("CurUenergyValue", energy))
    local extraParam = {withoutForwardPanel = true}
    binder:BindComponent(ShortCutComp(self.ui["Text_ShortCut_" .. index], "KeyCard" .. index, clickFunc, extraParam))
  end
  for index = 1, 4 do
    binder:SetActive(self.ui["Item_Battle_SelectAwaker_" .. index], count >= index)
  end
  self.ui.UI_Common_Btn_Back1:SetActive(self.cancelable)
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.OnBtnCancel))
  binder:BindButtonClick(self.ui.Btn_Block_Window, function()
    local value = not self.ui.UI_Common_Popup_Tips_L.activeSelf
    self.ui.UI_Common_Popup_Tips_L:SetActive(value)
    self.ui.Image_Open:SetActive(value)
    self.ui.Image_Close:SetActive(not value)
  end)
  bg.battleDataCenter:SetOpMode(rc.OpMode.Inspect, 9999)
  if bg.battleRender and bg.battleRender.eventMgr then
    bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.ChangeBoutPhase, self.OnChangeBoutPhase, self)
    bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.CommandResult, self.OnCommandResult, self)
  end
  binder:BindEvent(EventMgr.Instance.NewRecordSegment, System.fn(self, self.OnNewRecordSegment))
  self:AutoCloseInRelayOrAutoBattle()
  self:_TrySetupSayeAwakerSelectVx(binder)
end

function DbgAwakerSelectionPanel:_ResolveSelectCastRoleUid()
  local sd = self.selectData
  if not sd then
    return nil
  end
  local castUid = sd.castRoleUid
  if castUid and 0 ~= castUid then
    return castUid
  end
  local skillConfigId = sd.skillConfigId
  if skillConfigId and bg.battleRender and bg.battleRender.cardMgr then
    local card = bg.battleRender.cardMgr:GetCardByConfigId(skillConfigId)
    if card and card.ownerUid and 0 ~= card.ownerUid then
      return card.ownerUid
    end
  end
  return nil
end

function DbgAwakerSelectionPanel:_TrySetupSayeAwakerSelectVx(binder)
  if not bg.battleDataCenter then
    return
  end
  local castUid = self:_ResolveSelectCastRoleUid()
  if not castUid then
    return
  end
  local caster = bg.battleDataCenter:GetAwakerDataModel(castUid)
  if not caster or caster.tid ~= CommonDefine.BattleAwakerTid.Saye then
    return
  end
  local tipsRoot = self.ui.UI_Common_Popup_Tips_L
  if IsNil(tipsRoot) then
    return
  end
  tipsRoot:SetActive(true)
  self.ui.Image_Open:SetActive(true)
  self.ui.Image_Close:SetActive(false)
  local prefab = binder:LoadAsset(CommonRes.SayeAwakerSelectVxPrefab)
  if not prefab or IsNil(prefab) then
    Logger.Warn("DbgAwakerSelectionPanel: Saye VX prefab load failed path=%s", CommonRes.SayeAwakerSelectVxPrefab)
    return
  end
  local go = binder:Instantiate(prefab, tipsRoot.transform)
  go:SetActive(true)
  local rectTrans = go:GetComponent(typeof(CS.UnityEngine.RectTransform))
  if rectTrans then
    rectTrans.localPosition = CS.UnityEngine.Vector3.zero
    rectTrans.localScale = CS.UnityEngine.Vector3.one
  end
  local animCtrl = go:GetComponent(typeof(UIAnimationController))
  animCtrl = animCtrl or go:GetComponentInChildren(typeof(UIAnimationController), true)
  if not animCtrl then
    Logger.Warn("DbgAwakerSelectionPanel: Saye VX prefab has no UIAnimationController root=%s", go.name)
    return
  end
  self._sayeVxAnimCtrl = animCtrl
  animCtrl:PlayState(SayeAwakerSelectVxAnimOpen, function()
    animCtrl:LoopPlayState(SayeAwakerSelectVxAnimLoop)
  end)
end

function DbgAwakerSelectionPanel:CheckConfirmBtnState()
  local state = Z1ButtonState.High
  if self.selectLogic == MUST_SELECT_ALL then
    local keys = table.keys(self.selectedDic)
    if #keys < self.selectNum then
      state = Z1ButtonState.Unclickable
    end
  end
  self.binder:SetButtonState(self.ui.Btn_Confirm, state)
end

function DbgAwakerSelectionPanel:AutoCloseInRelayOrAutoBattle()
  if bg.IsRelayOrAutoBattle() then
    self.binder:BindTimer(CommonDefine.ReplayCommandWaitTime, 0, nil, System.fn(self, self.Close))
  end
end

function DbgAwakerSelectionPanel:OnNewRecordSegment()
  if bg.battlePanel and bg.battlePanel.SetOpMode then
    bg.battlePanel:SetOpMode(rc.OpMode.Play)
  end
  self:Close()
end

function DbgAwakerSelectionPanel:OnChangeBoutPhase(data)
  if data.newPhase == bc.BoutPhase.End then
    self:Close()
  end
end

function DbgAwakerSelectionPanel:OnCommandResult(msgData)
  if msgData.msgId == BattleCommand.lg_SelectTargets and msgData.selectType == bc.TargetSelectType.Awaker and msgData.ret then
    if bg.isReplay then
      self:OnReplaySelectAwaker(msgData.targetUids)
    else
      self:Close()
    end
  end
end

function DbgAwakerSelectionPanel:OnReplaySelectAwaker(targetUids)
  for index, targetUid in ipairs(self.selectData.targetUids) do
    if table.contains(targetUids, targetUid) then
      local selectedImg = self.ui["Image_Select_" .. index]
      selectedImg:SetActive(true)
    end
  end
end

function DbgAwakerSelectionPanel:OnBtnCancel()
  if bg.battleRender then
    bg.battleRender:SendCommand(BattleCommand.lg_CancelSelectTargets, {})
  end
  self:Close()
end

function DbgAwakerSelectionPanel:Close()
  if self._sayeVxAnimCtrl then
    self._sayeVxAnimCtrl:ClearCompleteCb()
    self._sayeVxAnimCtrl:StopPlayableGraph()
    self._sayeVxAnimCtrl:PlayState(SayeAwakerSelectVxAnimClose)
    self._sayeVxAnimCtrl = nil
  end
  Super.Close(self)
end

function DbgAwakerSelectionPanel:OnUnbind()
  if bg.battleDataCenter then
    bg.battleDataCenter:SetOpMode(rc.OpMode.Play)
  end
  if bg.battleRender and bg.battleRender.eventMgr then
    bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
  end
  Super.OnUnbind(self)
  bg.SendBattleEvent(rc.BattleEvent.BattleUIClose, self.__name)
end

return DbgAwakerSelectionPanel
