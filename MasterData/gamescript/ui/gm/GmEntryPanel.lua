local GmEntryPanel, Super = System.NewClass("GmEntryPanel", UIBasePanel)
GmEntryPanel.uiResCls = GmEntryPanelResource

function GmEntryPanel:ctor()
  Super.ctor(self)
  self.rolePosx = 0
  self.rolePosy = 0
  self.rolePosz = 0
  self.touchPosx = 0
  self.touchPosy = 0
  self.fps = Vue.ref(0)
  self.fps.value = 0
  self.ms = Vue.ref(0)
  self.ms.value = 0
  self.showBtnScroll = Vue.ref(false)
end

function GmEntryPanel:OnBind(binder)
  Logger.Debug("GmEntryPanelUI:OnBind(), 创建 UI")
  self.binder = binder
  self.binder:BindButtonClick(self.ui.Btn_EntryGm, System.fn(self, self.OnClickBtnEntry))
  binder:BindEvent(EventMgr.Instance.GMLocation, System.fn(self, self.Location))
  binder:BindButtonClick(self.ui.Btn_Gm, System.fn(self, self.OnClickBtnGm))
  if self.ui.Btn_Gm_Display then
    self.ui.Btn_Gm_Display:SetActive(CS.Z1Client.LuaBehaviour.showGMPanel or false)
    binder:BindButtonClick(self.ui.Btn_Gm_Display, System.fn(self, self.OnClickBtnGm))
  end
  binder:BindButtonClick(self.ui.Btn_Close, System.fn(self, self.OnClickBtnGm))
  binder:BindToVisible(self.ui.Group_Scroll, function()
    return self.showBtnScroll.value
  end)
  binder:BindToVisible(self.ui.Btn_Dungeons_Effect, function()
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
  end)
  binder:BindToVisible(self.ui.Btn_Gm, function()
    return not self.showBtnScroll.value
  end)
  self.binder:BindToVisible(self.ui.uiNode, function()
    return DataCenter.gameData.IsShowGmEntry
  end)
  self.binder:BindToVisible(self.ui.BtnWin, function()
    return DataCenter.gameData.IsInCombat
  end)
  self.binder:BindToVisible(self.ui.BtnLose, function()
    return DataCenter.gameData.IsInCombat
  end)
  self.binder:BindButtonClick(self.ui.BtnWin, function()
    self.showBtnScroll.value = false
    GmClientUtils.BattleWin()
  end)
  self.binder:BindButtonClick(self.ui.BtnLose, function()
    self.showBtnScroll.value = false
    GmClientUtils.BattleLose()
  end)
  binder:BindEvent(EventMgr.Instance.CSSendEvent, System.fn(self, self.OnCSEvent))
end

function GmEntryPanel:OnCSEvent(eventName, _)
  if "OnStartGrabScreen" ~= eventName then
    return
  end
end

function GmEntryPanel:Location(x, y, z, xx, yy)
  self.rolePosx = string.format("%.2f", x)
  self.rolePosy = string.format("%.2f", y)
  self.rolePosz = string.format("%.2f", z)
  self.touchPosx = string.format("%.2f", xx)
  self.touchPosy = string.format("%.2f", yy)
end

function GmEntryPanel:UpdateGC(_)
end

function GmEntryPanel:UpdateStr()
  local str
  str = string.format("角色坐标：(%s,%s,%s)\n触摸屏:(%s,%s)", self.rolePosx, self.rolePosy, self.rolePosz, self.touchPosx, self.touchPosy)
  if not DataCenter.gameData.IsShowAccountState then
    return str
  end
  if DataCenter.loginData.account and DataCenter.loginData.account ~= "" then
    str = string.format("账号: %s\n服务: %s\n%s", DataCenter.loginData.account, DataCenter.loginData.serverName or "", str)
    return str
  end
  return ""
end

function GmEntryPanel:OnClickBtnEntry()
  assert(self, "self is nil")
  self.showBtnScroll.value = false
  UIManager.Instance:Reopen(Urls.GmPanel)
end

function GmEntryPanel:OnClickBtnGm()
  UIManager.Instance:Reopen(Urls.GmPanel, SceneMgr.Instance:GetSceneType())
end

return GmEntryPanel
