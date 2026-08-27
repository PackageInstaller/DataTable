local base = UIBaseWindow
local UIWarChessInheritChip = class("UIWarChessInheritChip", base)
local UINWarChessInheritTeamItem = require("Game.WarChess.UI.InheritChip.UINWarChessInheritTeamItem")
local UINWarChessInheritChipItem = require("Game.WarChess.UI.InheritChip.UINWarChessInheritChipItem")
local cs_ResLoader = CS.ResLoader

function UIWarChessInheritChip:OnInit()
  self.resloader = cs_ResLoader.Create()
  self.wcCtrl = WarChessManager:GetWarChessCtrl()
  self.teamNode = UINWarChessInheritTeamItem.New()
  self.teamNode:Init(self.ui.obj_teamItem)
  self.chipNodePool = UIItemPool.New(UINWarChessInheritChipItem, self.ui.obj_chipNode)
  self.ui.obj_chipNode:SetActive(false)
end

function UIWarChessInheritChip:InitSelectCouldInheritChip(dTeamDataDic, deadIndexList, finishCallback)
  self.__dTeamDataList = {}
  self.__deadIndexList = table.copy(deadIndexList)
  self.__finishCallback = finishCallback
  for _, dTeamData in pairs(dTeamDataDic) do
    table.insert(self.__dTeamDataList, dTeamData)
  end
  table.sort(self.__dTeamDataList, function(a, b)
    return a:GetDTeamIndex() > b:GetDTeamIndex()
  end)
  table.sort(self.__deadIndexList)
  self:__TryInheritNextTeam()
end

function UIWarChessInheritChip:__TryInheritNextTeam()
  if #self.__dTeamDataList <= 0 or 0 >= #self.__deadIndexList then
    self:Delete()
    if self.__finishCallback ~= nil then
      self.__finishCallback()
    end
  else
    local dTeamData = table.remove(self.__dTeamDataList, 1)
    self:__RefreshInheritChip(dTeamData)
  end
end

function UIWarChessInheritChip:__RefreshInheritChip(dTeamData)
  self.teamNode:InitWCDeployTeamItem(dTeamData, self.resloader)
  self.chipNodePool:HideAll()
  for index, realTeamIndex in ipairs(self.__deadIndexList) do
    local teamData = self.wcCtrl.teamCtrl:GetDeadTeamDataByTeamIndex(realTeamIndex)
    if teamData ~= nil then
      local chipNodeItem = self.chipNodePool:GetOne()
      chipNodeItem:InitWCInheritChipItem(teamData, self.resloader, function()
        dTeamData:SetInheritTeamIndex(realTeamIndex)
        table.remove(self.__deadIndexList, index)
        self:__TryInheritNextTeam()
      end)
    end
  end
end

function UIWarChessInheritChip:OnDelete()
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
end

return UIWarChessInheritChip
