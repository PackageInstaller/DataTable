local TutorialSimpleView, Super = NewClass("TutorialSimpleView", BaseView)
TutorialSimpleView.uiResCls = UI_Course_Popup_SimpleResource

function TutorialSimpleView:ctor(tutorialTid)
  Super.ctor(self)
  self._tutorialTid = tutorialTid
end

function TutorialSimpleView:OnBuildView()
end

function TutorialSimpleView:RegisterNotifications()
  self:RegisterLocalNotify(NotifyId.OnTutorialSimpleDataChanged, self._RefreshPanel, self)
end

function TutorialSimpleView:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Left, System.fn(self, self._OnLeftClick))
  self:AddButtonClickListener(self.ui.Btn_Right, System.fn(self, self._OnRightClick))
  self:AddButtonClickListener(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
end

function TutorialSimpleView:OnEnterView()
  Super.OnEnterView(self)
  TutorialSimpleModel.Instance:SetTutorialTid(self._tutorialTid)
  local totalPage = TutorialSimpleModel.Instance:GetTotalPage()
  self.ui.Btn_Left:SetActive(totalPage > 1)
  self.ui.Btn_Right:SetActive(totalPage > 1)
  self:LocalNotify(NotifyId.OnTutorialSimpleDataChanged)
end

function TutorialSimpleView:OnExitView()
  Super.OnExitView(self)
end

function TutorialSimpleView:_RefreshPanel()
  local model = TutorialSimpleModel.Instance
  local data = model:GetCurPageData()
  if not data then
    return
  end
  if data.Picture then
    self:SetImage(self.ui.Image_Course, data.Picture)
  end
  if data.Desc then
    self:SetText(self.ui.Text_CourseDesc, data.Desc)
    AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_CourseDesc, 0, 0, 0, nil, true)
  end
  if data.Title then
    self:SetText(self.ui.Text_Title, data.Title)
  end
  local totalPage = model:GetTotalPage()
  local curPage = model:GetCurPage()
  for i = 1, 5 do
    local pageGo = self.ui["Page_" .. i]
    if not pageGo then
      break
    end
    pageGo:SetActive(i <= totalPage)
    local pageBright = self.ui["Page_Bright_" .. i]
    if pageBright then
      pageBright:SetActive(i == curPage)
    end
  end
end

function TutorialSimpleView:_OnLeftClick()
  local model = TutorialSimpleModel.Instance
  local newPage = model:GetCurPage() - 1
  if newPage < 1 then
    newPage = model:GetTotalPage()
  end
  if newPage ~= model:GetCurPage() then
    model:SetCurPage(newPage)
    self:LocalNotify(NotifyId.OnTutorialSimpleDataChanged)
  end
end

function TutorialSimpleView:_OnRightClick()
  local model = TutorialSimpleModel.Instance
  local newPage = model:GetCurPage() + 1
  if newPage > model:GetTotalPage() then
    newPage = 1
  end
  if newPage ~= model:GetCurPage() then
    model:SetCurPage(newPage)
    self:LocalNotify(NotifyId.OnTutorialSimpleDataChanged)
  end
end

return TutorialSimpleView
