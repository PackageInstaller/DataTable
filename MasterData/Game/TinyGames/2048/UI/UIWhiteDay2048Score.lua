local UIWhiteDay2048Score = class("UIWhiteDay2048Score", UIBaseWindow)
local base = UIBaseWindow

function UIWhiteDay2048Score:OnInit()
  UIUtil.SetTopStatus(self, self._OnClickReturn, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Again, self, self.OnBtnGameAgain)
  UIUtil.AddButtonListener(self.ui.btn_background, self, self.OnBtnBGClick)
end

function UIWhiteDay2048Score:InitGame2048Score(gameCtrl, score, newRecord, gameWindow)
  self._gameCtrl = gameCtrl
  self.ui.tex_Score.text = tostring(score)
  self._gameWindow = gameWindow
  self.ui.img_NewScore:SetActive(newRecord)
end

function UIWhiteDay2048Score:OnBtnGameAgain()
  UIUtil.OnClickBackByUiTab(self)
  if self._gameCtrl ~= nil then
    self._gameCtrl:StartNew2048Game()
  end
end

function UIWhiteDay2048Score:_OnClickReturn()
  self._gameWindow:Reset2048UIState(false)
  self:Delete()
end

function UIWhiteDay2048Score:OnBtnBGClick()
  UIUtil.OnClickBackByUiTab(self)
end

function UIWhiteDay2048Score:OnDelete()
  base.OnDelete(self)
end

return UIWhiteDay2048Score
