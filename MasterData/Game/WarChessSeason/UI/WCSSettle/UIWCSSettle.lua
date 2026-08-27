local base = UIBaseWindow
local UIWCSSettle = class("UIWCSSettle", UIBaseWindow)

function UIWCSSettle:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_button, self, self.__OnClickClose)
end

function UIWCSSettle:InitSettle(isWin)
  self.__isWin = isWin
  self:__RefreshLevelAndScore()
  self:__ShowChipNum()
end

function UIWCSSettle:__RefreshLevelAndScore()
  local wcsCtrl = WarChessSeasonManager:GetWCSCtrl()
  local level = wcsCtrl:WCSGetFloor()
  local score = wcsCtrl:WCSGetTotalScore()
  self.ui.text_totalScore:SetIndex(0, tostring(score))
  self.ui.text_totalLevel:SetIndex(0, tostring(level))
end

function UIWCSSettle:__ShowChipNum()
  local wcCtrl = WarChessManager:GetWarChessCtrl()
  local teamDic = wcCtrl.teamCtrl:GetWCTeams()
  local allChipLevel = 0
  for _, teamData in pairs(teamDic) do
    local dynPlayer = teamData:GetTeamDynPlayer()
    local chipList = dynPlayer:GetChipList()
    for _, chipData in pairs(chipList) do
      allChipLevel = allChipLevel + chipData:GetCount()
    end
  end
  self.ui.text_totalChipLevel:SetIndex(0, tostring(allChipLevel))
end

function UIWCSSettle:__OnClickClose()
  WarChessManager:ExitWarChess(Consts.SceneName.Sector, self.__isWin, nil, function()
  end)
end

function UIWCSSettle:OnDelete()
  base.OnDelete(self)
end

return UIWCSSettle
