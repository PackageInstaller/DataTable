local UIRecommeFormationSeason = class("UIRecommeFormationSeason", UIBaseWindow)
local base = UIBaseWindow
local UINRecommeTeamItem = require("Game.CommonUI.Rank.UINRecommeTeamItem")

function UIRecommeFormationSeason:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_close, self, self.OnClickClose)
  self.recommeTeamItemPool = UIItemPool.New(UINRecommeTeamItem, self.ui.obj_recommeTeamItem)
  self.ui.obj_recommeTeamItem:SetActive(false)
end

function UIRecommeFormationSeason:RefreshTeamItem(teamHeroList)
  self.recommeTeamItemPool:HideAll()
  for k, v in pairs(teamHeroList) do
    local item = self.recommeTeamItemPool:GetOne(true)
    item:RefreshRecommeTeamItem(v, k)
  end
  if #teamHeroList == 1 then
    local item = self.recommeTeamItemPool:GetOne(true)
    item:RefreshRecommeTeamItem(nil, 2)
  end
end

function UIRecommeFormationSeason:SetShowPosition(transform, downTransform)
  local positionX, positionY = UIManager:World2UIPositionOut(transform, self.ui.frame.parent, UIManager.UICamera, UIManager.UICamera)
  local downPositionX, downPositionY = UIManager:World2UIPositionOut(downTransform, self.ui.frame.parent, UIManager.UICamera, UIManager.UICamera)
  local downY = positionY - self.ui.frame.sizeDelta.y
  if downPositionY > downY then
    positionY = positionY - (downY - downPositionY)
  end
  self.ui.frame.anchoredPosition = Vector2.Temp(positionX, positionY)
end

function UIRecommeFormationSeason:OnClickClose()
  self.recommeTeamItemPool:DeleteAll()
  self:Delete()
end

return UIRecommeFormationSeason
