local UIFormationRankPreview = class("UIFormationRankPreview", UIBaseWindow)
local base = UIBaseWindow
local UINFmtRankPreviewItem = require("Game.Formation.UI.Rank.UINFmtRankPreviewItem")

function UIFormationRankPreview:OnInit()
  UIUtil.SetTopStatus(self, self.Delete, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self._OnBtnClose)
  UIUtil.AddButtonListener(self.ui.btn_Bg, self, self._OnBtnClose)
  self._rankItemPool = UIItemPool.New(UINFmtRankPreviewItem, self.ui.rowItem, false)
end

function UIFormationRankPreview:InitFmtRankPreview(heroPassStats)
  self._rankItemPool:HideAll()
  for index, passStat in pairs(heroPassStats) do
    local rankItem = self._rankItemPool:GetOne()
    rankItem:InitFmtRankPreviewItem(index, passStat)
  end
end

function UIFormationRankPreview:_OnBtnClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIFormationRankPreview:OnDelete()
  base.OnDelete(self)
end

return UIFormationRankPreview
