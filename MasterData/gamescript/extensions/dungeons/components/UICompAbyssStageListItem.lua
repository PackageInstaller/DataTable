local UICompAbyssStageListItem, Super = NewViewComponent("UICompAbyssStageListItem")

function UICompAbyssStageListItem:ctor(uiNode, view, data, onClick, isChooseFunc, isPassedFunc)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Dungeons_Item_Common_Tier2Resource(uiNode)
  self.data = data
  self.onClick = onClick
  self.isChooseFunc = isChooseFunc
  self.isPassedFunc = isPassedFunc
end

function UICompAbyssStageListItem:RegisterNotifications()
end

function UICompAbyssStageListItem:RegisterEvents()
  self:AddButtonClickListener(self.ui.Btn_Click, System.fn(self, self._OnClick))
end

function UICompAbyssStageListItem:OnEnterComponent()
  self:_RefreshBaseUI()
  self:_RefreshPassedUI()
  self:_RefreshSelectedUI()
end

function UICompAbyssStageListItem:_RefreshBaseUI()
  self.ui.Group_Star:SetActive(false)
  self.ui.Group_Star_HighLIight:SetActive(false)
  local recommendText = LT.Text("Copy_Recommend_Level") .. self.data.recommendLv
  self:SetText(self.ui.Text_Tip, recommendText)
  self:SetText(self.ui.Text_Title, self.data.name)
  local isMadness = self.data.dailyChallengeMadnessDifficulty and 1 == self.data.dailyChallengeMadnessDifficulty or false
  local bgPath = isMadness and "UIResources/UIBigImages/UI_Dungeous/UI_Dungeous_Image_Difficulty_Bg10.png" or "UIResources/UIBigImages/UI_Dungeous/UI_Dungeous_Image_Difficulty_Bg6.png"
  local bgNode = self.ui.Basebg or self:FindChildRecursively(self.ui.uiNode, "Basebg")
  if bgNode then
    self:SetImage(bgNode, bgPath)
  end
end

function UICompAbyssStageListItem:_RefreshSelectedUI()
  local isChosen = false
  if self.isChooseFunc then
    isChosen = self.isChooseFunc(self.data.tid)
  end
  self.ui.Image_Select:SetActive(isChosen)
end

function UICompAbyssStageListItem:_RefreshPassedUI()
  local isPassedStage = false
  if self.isPassedFunc then
    isPassedStage = self.isPassedFunc(self.data.tid)
  end
  self.ui.Image_Current:SetActive(isPassedStage)
end

function UICompAbyssStageListItem:_OnReset()
  self:_RefreshPassedUI(0)
end

function UICompAbyssStageListItem:_OnClick()
  if self.onClick then
    self.onClick()
  end
end

function UICompAbyssStageListItem:OnExitComponent()
  Super.OnExitComponent(self)
end

return UICompAbyssStageListItem
