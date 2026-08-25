local InvestigatorLevelUpView, Super = NewClass("InvestigatorLevelUpView", BaseView)
InvestigatorLevelUpView.uiResCls = UI_Other_Popup_Player_LevelUpResource

function InvestigatorLevelUpView:ctor(data)
  Super.ctor(self)
  self._oldLevel = data.oldLevel
  self._confirmCallback = data.confirmCallback
end

function InvestigatorLevelUpView:OnBuildView()
end

function InvestigatorLevelUpView:RegisterNotifications()
end

function InvestigatorLevelUpView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Confirm, System.fn(self, self._OnClickConfirm))
end

function InvestigatorLevelUpView:OnEnterView()
  Super.OnEnterView(self)
  local newLevel = DataCenter.playerData.DRole.level
  self.ui.Group_Lv:SetActive(true)
  self.ui.Group_Lv_LimitIncrease:SetActive(false)
  self.ui.Group_Level:SetActive(true)
  self:SetText(self.ui.Text_Title, LT.Text("Level_Up_Tips"))
  self:SetText(self.ui.Text_Level_All, self._oldLevel)
  self:SetText(self.ui.Text_Level_Next, newLevel)
  local oldDailyAppointNum = PlayerDataUtils.GetDailyAppointNumByLevel(self._oldLevel)
  local newDailyAppointNum = PlayerDataUtils.GetDailyAppointNumByLevel(newLevel)
  local showDesc = oldDailyAppointNum < newDailyAppointNum
  self.ui.Group_Desc_1:SetActive(showDesc)
  self.ui.Text_Group_Desc_1:SetActive(showDesc)
  if showDesc then
    self:SetText(self.ui.Text_Group_Desc_1, LT.Textf("Task_Appoint_AcountLvUpTips", newDailyAppointNum))
  end
  self.ui.Group_Desc_2:SetActive(false)
  self.ui.Text_Group_Desc_2:SetActive(false)
  self.ui.Group_Desc_3:SetActive(false)
  self.ui.Text_Group_Desc_3:SetActive(false)
  self.ui.Btn_Confirm:SetActive(true)
end

function InvestigatorLevelUpView:OnExitView()
  Super.OnExitView(self)
end

function InvestigatorLevelUpView:_OnClickConfirm()
  if self._confirmCallback then
    self._confirmCallback()
  end
  self:Close()
end

return InvestigatorLevelUpView
