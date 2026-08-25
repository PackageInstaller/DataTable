local Activity2ndAnniversaryInviteView, Super = NewClass("Activity2ndAnniversaryInviteView", BaseView)
Activity2ndAnniversaryInviteView.uiResCls = UI_Event_Item_ReturnResource

function Activity2ndAnniversaryInviteView:ctor(closeCb, isShowBtn)
  Super.ctor(self)
  self.isShowBtn = isShowBtn
  self.closeCb = closeCb
end

function Activity2ndAnniversaryInviteView:OnBuildView()
end

function Activity2ndAnniversaryInviteView:OnEnterView()
  local targetActivityTid = DT.GetConstant("Aniversary2ndTaskActivityTid")
  ClientDataUtils.SetData(cd.ClientDataMainKey.Aniversary2ndInviteTips, targetActivityTid, cd.NumberTrue)
  self:_RefreshView()
end

function Activity2ndAnniversaryInviteView:Close()
  if self.closeCb then
    self.closeCb()
  end
  Super.Close(self)
end

function Activity2ndAnniversaryInviteView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Mask, System.fn(self, self.Close))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Level1, function()
    local panelData = {
      targetActivityTid = DT.GetConstant("Aniversary2ndTaskActivityTid")
    }
    UIManager.Instance:Reopen(Urls.ActivityMainPanel, panelData)
    self:Close()
  end)
end

function Activity2ndAnniversaryInviteView:_RefreshView()
  self:SetActive(self.ui.Image_Line_3, false)
  self:SetActive(self.ui.UI_Common_Btn_Level1, self.isShowBtn)
  self:SetText(self.ui.Text_Name, LT.Text("2ndAnniversarySenderText"))
  self:SetText(self.ui.Text_Title, LT.Text("2ndAnniversaryTitleText"))
  self:SetText(self.ui.Text_Information, LT.Text("2ndAnniversaryText"))
  self:SetButtonText(self.ui.UI_Common_Btn_Level1, LT.Text("GoTo"))
  self:_RefreshAwardList()
end

function Activity2ndAnniversaryInviteView:_RefreshAwardList()
  self:SetActive(self.ui.ScrollView_Thing, false)
  CS.Framework.TransformUtil.SetHeight(self.ui.ScrollView_Information.transform, 384.01)
end

return Activity2ndAnniversaryInviteView
