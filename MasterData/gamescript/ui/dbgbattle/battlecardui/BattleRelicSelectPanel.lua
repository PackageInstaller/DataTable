local BattleRelicSelectPanel, Super = System.NewClass("BattleRelicSelectPanel", UIBasePanel)
BattleRelicSelectPanel.uiResCls = UI_Dbgcopy_Panel_Select_CreationResource

function BattleRelicSelectPanel:ctor(data, callback)
  Super.ctor(self)
  self.data = data
  self.confirmCallback = callback
  self._relicDict = {}
end

function BattleRelicSelectPanel:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Text_Desc, self.data.titleStr or LT.Text("Battle_Win_SelectRelic"))
  UICommonBtnVibes.BindCommonBtnVibes(binder, self.ui.UI_Common_Btn_Vibes)
  binder:BindZ1Button(self.ui.UI_Common_Item_Btn_2, System.fn(self, self.OnConfirmClick), function()
    return CommonDefine.BtnType.High
  end, function()
    do return LT.Text end
    return LT.Text, "UniversalConfirmButton"
  end, nil, nil, nil)
  local relics = {}
  for _, relicData in pairs(self.data.targetRelicList or {}) do
    table.insert(relics, relicData)
  end
  for i = 1, 3 do
    if relics[i] then
      local item = self.binder:BindComponent(WorldStageBigRelicItem(self.ui["UI_Dbgcopy_Item_Select_Creation_Quote" .. i], relics[i], System.fn(self, self.CreationClickCb)))
      self._relicDict[relics[i].uid] = item
    else
      binder:SetActive(self.ui["UI_Dbgcopy_Item_Select_Creation_Quote" .. i], false)
    end
  end
  if bg and bg.battleRender then
    bg.battleRender.eventMgr:RegisterEvent(BattleRenderEvent.CommandResult, self.OnCommandResult, self)
  end
  binder:BindEvent(EventMgr.Instance.NewRecordSegment, System.fn(self, self.OnNewRecordSegment))
  self:AutoCloseInRelayOrAutoBattle()
end

function BattleRelicSelectPanel:AutoCloseInRelayOrAutoBattle()
  if bg.IsRelayOrAutoBattle() then
    self.binder:BindTimer(CommonDefine.ReplayCommandWaitTime, 0, nil, System.fn(self, self.Close))
  end
end

function BattleRelicSelectPanel:CreationClickCb(item)
  AudioManager.Instance:PostSoundEvent("EXPLORE_SELECTPROPS_POP")
  if self.selectedItem then
    self.selectedItem:EnableSelectShow(false)
  end
  self.selectedItem = item
  self.selectedItem:EnableSelectShow(true)
end

function BattleRelicSelectPanel:OnConfirmClick()
  if self.selectedItem and self.selectedItem and self.confirmCallback then
    self.confirmCallback(self.selectedItem.uid)
  end
end

function BattleRelicSelectPanel:OnCommandResult(msgData)
  if msgData.msgId == BattleCommand.lg_SelectTargets and msgData.selectType == bc.TargetSelectType.Relic and msgData.ret then
    if bg.isReplay then
      self:OnReplaySelectRelic(msgData.targetUids)
    else
      self:Close()
    end
  end
end

function BattleRelicSelectPanel:OnNewRecordSegment()
  if bg.battlePanel and bg.battlePanel.SetOpMode then
    bg.battlePanel:SetOpMode(rc.OpMode.Play)
  end
  self:Close()
end

function BattleRelicSelectPanel:OnReplaySelectRelic(targetUids)
  for _, uid in ipairs(targetUids) do
    local item = self._relicDict[uid]
    if item then
      item:EnableSelectShow(true)
    end
  end
end

function BattleRelicSelectPanel:OnUnbind()
  Super.OnUnbind(self)
  if bg and bg.battleRender and bg.battleRender.eventMgr then
    bg.battleRender.eventMgr:UnregisterAllEventsByTarget(self)
  end
  if self.callback then
    self.callback()
  end
end

return BattleRelicSelectPanel
