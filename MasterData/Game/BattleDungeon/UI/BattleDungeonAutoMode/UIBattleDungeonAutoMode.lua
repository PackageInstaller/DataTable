local UIBattleDungeonAutoMode = class("UIBattleDungeonAutoMode", UIBaseWindow)
local base = UIBaseWindow
local UINBattleDungeonAutoResult = require("Game.BattleDungeon.UI.BattleDungeonAutoMode.UINBattleDungeonAutoResult")
local UINBattleDungeonAutoStart = require("Game.BattleDungeon.UI.BattleDungeonAutoMode.UINBattleDungeonAutoStart")
local UINBattleDungeonPlotAutoStart = require("Game.BattleDungeon.UI.BattleDungeonAutoMode.UINBattleDungeonPlotAutoStart")
local UINBattleDungeonLevelAutoStart = require("Game.BattleDungeon.UI.BattleDungeonAutoMode.UINBattleDungeonLevelAutoStart")
local eNodeType = {
  normalSet = 1,
  plotSet = 2,
  dunLevelSet = 3,
  reward = 4
}

function UIBattleDungeonAutoMode:OnInit()
  self.__nodeCfg = {
    [eNodeType.normalSet] = {
      class = UINBattleDungeonAutoStart,
      obj = self.ui.autoBattle
    },
    [eNodeType.plotSet] = {
      class = UINBattleDungeonPlotAutoStart,
      obj = self.ui.autoChip
    },
    [eNodeType.dunLevelSet] = {
      class = UINBattleDungeonLevelAutoStart,
      obj = self.ui.autoBattle
    },
    [eNodeType.reward] = {
      class = UINBattleDungeonAutoResult,
      obj = self.ui.autoResult
    }
  }
  self.nodeDic = {}
  for _, cfg in pairs(self.__nodeCfg) do
    cfg.obj:SetActive(false)
  end
  self.__OnClickClose = BindCallback(self, self.OnClickClose)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickClose)
  self.__OnBattleStart = BindCallback(self, self.OnBattleStart)
  UIUtil.SetTopStatus(self, self.OnCloseAutoMode, nil, nil, nil, true)
end

function UIBattleDungeonAutoMode:__PreCloseItem()
  for _, node in pairs(self.nodeDic) do
    node:Hide()
  end
end

function UIBattleDungeonAutoMode:InitDungeonAutoSet(dungeonStageData, callback, quickBattleFunc)
  self:__PreCloseItem()
  self.ui.tex_Title:SetIndex(0)
  self.closeCallback = nil
  self.startcallback = callback
  if dungeonStageData.dungeonData:IsFrageDungeon() then
    local plotSetNode = self:__GetNode(eNodeType.plotSet)
    plotSetNode:Show()
    plotSetNode:InitPlotAutoStart(dungeonStageData, self.__OnBattleStart)
  else
    local autoSetNode = self:__GetNode(eNodeType.normalSet)
    autoSetNode:Show()
    autoSetNode:InitAutoStart(dungeonStageData, self.__OnBattleStart)
    autoSetNode:SetBattleAutoStartQuick(quickBattleFunc)
  end
end

function UIBattleDungeonAutoMode:InitDungeonAutoRes(dInterfaceData, count, rewardDic, ath, callback)
  self:__PreCloseItem()
  self.ui.tex_Title:SetIndex(1)
  local resultNode = self:__GetNode(eNodeType.reward)
  resultNode:Show()
  if dInterfaceData ~= nil then
    resultNode:InitAutoResultTitle(dInterfaceData:GetIDungeonLevelData(), dInterfaceData:GetIDungeonStageData())
  else
    resultNode:InitAutoResultTitle(nil, nil)
  end
  resultNode:InitAutoResult(count, rewardDic, ath, self.__OnClickClose)
  self.startcallback = nil
  self.closeCallback = callback
end

function UIBattleDungeonAutoMode:InitSectorIIDunAutoSet(dungeonLevelData, startcallback, quickBattleFunc)
  self:__PreCloseItem()
  self.ui.tex_Title:SetIndex(0)
  local dunLevelNode = self:__GetNode(eNodeType.dunLevelSet)
  dunLevelNode:InitDunLevelAutoStart(dungeonLevelData, self.__OnBattleStart)
  dunLevelNode:SetBattleAutoStartQuick(quickBattleFunc)
  dunLevelNode:Show()
  self.closeCallback = nil
  self.startcallback = startcallback
end

function UIBattleDungeonAutoMode:InitSectorIIDunAutoRes()
end

function UIBattleDungeonAutoMode:OnClickClose()
  UIUtil.OnClickBackByUiTab(self)
end

function UIBattleDungeonAutoMode:OnBattleStart(count)
  UIUtil.OnClickBackByUiTab(self)
  if self.startcallback ~= nil then
    self.startcallback(count)
  end
end

function UIBattleDungeonAutoMode:__GetNode(type)
  if self.nodeDic[type] ~= nil then
    return self.nodeDic[type]
  end
  local cfg = self.__nodeCfg[type]
  local node = cfg.class.New()
  node:Init(cfg.obj)
  self.nodeDic[type] = node
  return node
end

function UIBattleDungeonAutoMode:OnCloseAutoMode()
  self:Delete()
  if self.closeCallback then
    self.closeCallback()
  end
end

function UIBattleDungeonAutoMode:OnDelete()
  for _, node in pairs(self.nodeDic) do
    node:Delete()
  end
  base.OnDelete(self)
end

return UIBattleDungeonAutoMode
