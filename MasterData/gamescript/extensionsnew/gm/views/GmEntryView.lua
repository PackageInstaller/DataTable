local GmEntryView, Super = NewClass("GmEntryView", BaseView)
GmEntryView.uiResCls = GmEntryPanelResource

function GmEntryView:ctor()
  Super.ctor(self)
  self._rolePosx = 0
  self._rolePosy = 0
  self._rolePosz = 0
  self._touchPosx = 0
  self._touchPosy = 0
  self._showBtnScroll = false
end

function GmEntryView:RegisterNotifications()
  self:BindEvent(EventMgr.Instance.GMLocation, System.fn(self, self._OnLocation))
  self:BindEvent(EventMgr.Instance.CSSendEvent, System.fn(self, self._OnCSEvent))
end

function GmEntryView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_EntryGm, System.fn(self, self._OnClickBtnEntry))
  self:AddButtonClickListener(self.ui.Btn_Gm, System.fn(self, self._OnClickBtnGm))
  self:AddButtonClickListener(self.ui.Btn_Close, System.fn(self, self._OnClickBtnGm))
  if self.ui.Btn_Gm_Display then
    self:AddButtonClickListener(self.ui.Btn_Gm_Display, System.fn(self, self._OnClickBtnGm))
  end
  self:AddButtonClickListener(self.ui.BtnWin, System.fn(self, self._OnClickBtnWin))
  self:AddButtonClickListener(self.ui.BtnLose, System.fn(self, self._OnClickBtnLose))
end

function GmEntryView:OnEnterView()
  Super.OnEnterView(self)
  if self.ui.Btn_Gm_Display then
    self.ui.Btn_Gm_Display:SetActive(CS.Z1Client.LuaBehaviour.showGMPanel or false)
  end
  self:_RefreshVisible()
  self:BindTimer(0.2, -1, function()
    self:_RefreshVisible()
  end)
end

function GmEntryView:OnExitView()
  Super.OnExitView(self)
end

function GmEntryView:_RefreshVisible()
  self.ui.uiNode:SetActive(DataCenter.gameData.IsShowGmEntry)
  self.ui.Group_Scroll:SetActive(self._showBtnScroll)
  self.ui.Btn_Gm:SetActive(not self._showBtnScroll)
  self.ui.Btn_Dungeons_Effect:SetActive(self:_IsShowDungeonsEffect())
  local isInCombat = DataCenter.gameData.IsInCombat
  self.ui.BtnWin:SetActive(isInCombat)
  self.ui.BtnLose:SetActive(isInCombat)
end

function GmEntryView:_IsShowDungeonsEffect()
  local ret = false
  if DataCenter.copiesData.storyLineTid > 0 then
    for index = 1, 4 do
      local list = DT.PlotConfig[DataCenter.copiesData.storyLineTid]["CopyEffect" .. index]
      if list and #list > 0 then
        ret = true
      end
    end
  end
  return DataCenter.copiesData.BarrierId > 0 and SceneMgr.Instance:IsInCopies() and ret
end

function GmEntryView:_OnLocation(x, y, z, xx, yy)
  self._rolePosx = string.format("%.2f", x)
  self._rolePosy = string.format("%.2f", y)
  self._rolePosz = string.format("%.2f", z)
  self._touchPosx = string.format("%.2f", xx)
  self._touchPosy = string.format("%.2f", yy)
end

function GmEntryView:_OnCSEvent(eventName, _)
  if "OnStartGrabScreen" ~= eventName then
    return
  end
end

function GmEntryView:_OnClickBtnEntry()
  self._showBtnScroll = false
  UIManager.Instance:Reopen(Urls.GmPanel)
end

function GmEntryView:_OnClickBtnGm()
  UIManager.Instance:Reopen(Urls.GmPanel, SceneMgr.Instance:GetSceneType())
end

function GmEntryView:_OnClickBtnWin()
  self._showBtnScroll = false
  GmClientUtils.BattleWin()
end

function GmEntryView:_OnClickBtnLose()
  self._showBtnScroll = false
  GmClientUtils.BattleLose()
end

return GmEntryView
