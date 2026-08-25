local TutorialSimplePanel, Super = System.NewClass("TutorialSimplePanel", UIBasePanel)
TutorialSimplePanel.uiResCls = UI_Course_Popup_SimpleResource

function TutorialSimplePanel:ctor(tutorialTid)
  Super.ctor(self)
  self.tutorialCfg = DT.Tutorial[tutorialTid]
  self.totalPage = #self.tutorialCfg.data_list
  self.curPage = 1
end

function TutorialSimplePanel:OnBind(binder)
  self.binder = binder
  binder:BindButtonClick(self.ui.Btn_Left, System.fn(self, self.OnLeftClick))
  binder:BindButtonClick(self.ui.Btn_Right, System.fn(self, self.OnRightClick))
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
  binder:SetActive(self.ui.Btn_Left, self.totalPage > 1)
  binder:SetActive(self.ui.Btn_Right, self.totalPage > 1)
  self:RefreshPanel(self.curPage)
end

function TutorialSimplePanel:RefreshPanel(page)
  self.curPage = page
  local data = self.tutorialCfg.data_list[page]
  if not data then
    return
  end
  self.binder:SetImage(self.ui.Image_Course, data.Picture)
  if data.Desc then
    self.binder:SetText(self.ui.Text_CourseDesc, data.Desc)
    AutoAdaptionText.StartAutoAdaptionText(self.ui.Text_CourseDesc, 0, 0, 0, nil, true)
  end
  if data.Title then
    self.binder:SetText(self.ui.Text_Title, data.Title)
  end
  if data.Picture then
    self.binder:SetImage(self.ui.Image_Course, data.Picture)
  end
  for i = 1, 5 do
    local pageGo = self.ui["Page_" .. i]
    if not pageGo then
      break
    end
    self.binder:SetActive(pageGo, i <= self.totalPage)
    local pageBright = self.ui["Page_Bright_" .. i]
    self.binder:SetActive(pageBright, i == self.curPage)
  end
end

function TutorialSimplePanel:OnLeftClick()
  local newPage = self.curPage - 1
  if newPage < 1 then
    newPage = self.totalPage
  end
  if newPage ~= self.curPage then
    self:RefreshPanel(newPage)
  end
end

function TutorialSimplePanel:OnRightClick()
  local newPage = self.curPage + 1
  if newPage > self.totalPage then
    newPage = 1
  end
  if newPage ~= self.curPage then
    self:RefreshPanel(newPage)
  end
end

return TutorialSimplePanel
