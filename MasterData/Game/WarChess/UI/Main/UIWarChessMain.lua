local base = UIBaseWindow
local UIWarChessMain = class("UIWarChessMain", UIBaseWindow)
local cs_ResLoader = CS.ResLoader
local UINWarChessMainTop = require("Game.WarChess.UI.Main.Top.UINWarChessMainTop")
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local UINWarChessWarnLoop = require("Game.WarChess.UI.Main.UINWarChessWarnLoop")
local DownNode = {
  deploy = {
    res = "UINWarChessDeploy",
    class = "Game.WarChess.UI.Main.UINWarChessMain_DeployNode"
  },
  play = {
    res = "UINWarChessInPlay",
    class = "Game.WarChess.UI.Main.UINWarChessMain_PlayNode"
  }
}
local SpecialItemNode = {
  [eWarChessEnum.WCSpecialItemType.pumpkin] = {
    res = "UINWCBottleHalloween22",
    class = "Game.WarChess.UI.Main.WarChessItem.UINWarChessPumpkin"
  },
  [eWarChessEnum.WCSpecialItemType.start] = {
    res = "UINWCBottleChristmas22",
    class = "Game.WarChess.UI.Main.WarChessItem.UINWarChessChristmasStar"
  },
  [eWarChessEnum.WCSpecialItemType.greenBox] = {
    res = "UINWCBottleWinter23",
    class = "Game.WarChess.UI.Main.WarChessItem.UINWarChessPumpkin"
  }
}
local SpecialTrriggerNode = {
  [eWarChessEnum.WCSpecialTriggerType.chessJump] = {
    res = "UINWarChessLevelTrigger",
    class = "Game.WarChess.UI.Main.WarChessItem.UINWarChessLevelChessTrigger"
  }
}

function UIWarChessMain:OnInit()
  self.topNode = UINWarChessMainTop.New()
  self.topNode:Init(self.ui.obj_top)
  self.downNode = nil
  self.__curDownNodeName = nil
  self.resloader = cs_ResLoader.Create()
  self._warnEffectNode = UINWarChessWarnLoop.New()
  self._warnEffectNode:Init(self.ui.img_turnWarrning)
  self.__onTimeRewind = BindCallback(self, self.__OnTimeRewind)
  MsgCenter:AddListener(eMsgEventId.WC_TimeRewind, self.__onTimeRewind)
end

function UIWarChessMain:__LoadDownNode(name)
  if self.__curDownNodeName == name then
    return
  end
  if self.downNode ~= nil then
    self.downNode:Delete()
    self.downNode = nil
  end
  self.__curDownNodeName = name
  local data = DownNode[name]
  local downNode = require(data.class).New(self)
  local prefab = self.resloader:LoadABAsset(PathConsts:GetWarChessUINodePrefabPath(data.res))
  local go = prefab:Instantiate(self.ui.trans_Down)
  downNode:Init(go)
  self.downNode = downNode
end

function UIWarChessMain:InitWarChessDeploy(deployState)
  self:__LoadDownNode("deploy")
  local isDynDeploy = deployState:GetIsDynDeploy()
  self.downNode:InitWarChessDeployNode(deployState, self.resloader)
  if not isDynDeploy then
    self.topNode:ShowWCDeployInfo()
  else
    self.topNode:ShowWCPlayInfo(deployState.wcCtrl)
  end
end

function UIWarChessMain:InitWarChessPlay(wcPlayState, curTeamData)
  self:__LoadDownNode("play")
  self.downNode:InitWarChessPlayNode(wcPlayState, curTeamData, self.resloader)
  self.topNode:ShowWCPlayInfo(wcPlayState.wcCtrl)
  self:InitSpecialItem()
  self:InitLevelTriggerItem()
end

function UIWarChessMain:GetWCDeployNode()
  if self.__curDownNodeName == "deploy" then
    return self.downNode
  end
  return nil
end

function UIWarChessMain:GetWCPlayNode()
  if self.__curDownNodeName == "play" then
    return self.downNode
  end
  return nil
end

function UIWarChessMain:SetWCMainCanvasRaycast(active)
  self.ui.canvasGroup.blocksRaycasts = active
end

function UIWarChessMain:WcMainFadeBttomUI(isFade)
  if isFade then
    self.ui.dt_trans_Down:DOPlayForward()
  else
    self.ui.dt_trans_Down:DOPlayBackwards()
  end
end

function UIWarChessMain:InitSpecialItem()
  if not WarChessSeasonManager:GetIsInWCSeason() then
    return
  end
  if self.itemShowNode ~= nil then
    self.itemShowNode:Delete()
    self.itemShowNode = nil
  end
  local wcsCfg = WarChessSeasonManager:GetWCSSeasonCfg()
  local specialItemId = wcsCfg.warchess_item
  local specialItemCfg = ConfigData.warchess_season_item[specialItemId]
  if specialItemCfg == nil then
    return
  end
  local uiNodeCfg = SpecialItemNode[specialItemCfg.ui_type]
  if uiNodeCfg == nil then
    return
  end
  local itemShowNode = require(uiNodeCfg.class).New(self)
  local prefab = self.resloader:LoadABAsset(PathConsts:GetWarChessUINodePrefabPath(uiNodeCfg.res))
  local go = prefab:Instantiate(self.ui.trans_Down)
  itemShowNode:Init(go)
  itemShowNode:InitWCSSpecialItem(specialItemCfg)
  itemShowNode.transform:SetParent(self.ui.trans_SpBottleHolder)
  itemShowNode.transform.anchoredPosition = Vector2.zero
  self.itemShowNode = itemShowNode
end

function UIWarChessMain:InitLevelTriggerItem()
  if self.levelSpecialTriggerNode ~= nil then
    self.levelSpecialTriggerNode:Delete()
    self.levelSpecialTriggerNode = nil
  end
  if self.levelTriggerNode ~= nil then
    self.levelTriggerNode:Delete()
    self.levelTriggerNode = nil
  end
  local wcLevelCfg = WarChessManager:GetWCLevelCfg()
  if wcLevelCfg ~= nil and wcLevelCfg.trigger_special > 0 then
    local uiNodeCfg = SpecialTrriggerNode[wcLevelCfg.trigger_special]
    local node = require(uiNodeCfg.class).New(self)
    local prefab = self.resloader:LoadABAsset(PathConsts:GetWarChessUINodePrefabPath(uiNodeCfg.res))
    local go = prefab:Instantiate(self.ui.trans_Down)
    node:Init(go)
    node.transform:SetParent(self.ui.trans_SpBottleHolder)
    node.transform.anchoredPosition = Vector2.zero
    node:InitWCLevelSpecialTrigger(self.resloader)
    self.levelSpecialTriggerNode = node
    return
  end
  local isHave, icon, trigger_id = WarChessManager:GetWCLevelGlobalTriggerCfg()
  if not isHave or string.IsNullOrEmpty(icon) then
    return
  end
  local levelTriggerNode = require("Game.WarChess.UI.Main.WarChessItem.UINWarChessLevelTrigger").New()
  local prefab = self.resloader:LoadABAsset(PathConsts:GetWarChessUINodePrefabPath("UINWarChessLevelTrigger"))
  local go = prefab:Instantiate(self.ui.trans_SpBottleHolder)
  levelTriggerNode:Init(go)
  levelTriggerNode:InitWCLevelTrigger(icon, self.resloader, trigger_id)
  levelTriggerNode.transform.anchoredPosition = Vector2.zero
  self.levelTriggerNode = levelTriggerNode
end

function UIWarChessMain:__OnTimeRewind()
  if self.itemShowNode ~= nil then
    self.itemShowNode:WCSpecialItemNodeRefresh()
  end
end

function UIWarChessMain:GetWCMTopBuffPos()
  if self.topNode == nil then
    return nil
  end
  return self.topNode.GoalNode:GetWCMTGoalBuffPos()
end

function UIWarChessMain:OnDelete()
  base.OnDelete(self)
  if self.topNode ~= nil then
    self.topNode:Delete()
    self.topNode = nil
  end
  if self.downNode ~= nil then
    self.downNode:Delete()
    self.downNode = nil
  end
  if self.itemShowNode ~= nil then
    self.itemShowNode:Delete()
    self.itemShowNode = nil
  end
  if self.resloader ~= nil then
    self.resloader:Put2Pool()
    self.resloader = nil
  end
  if self.levelTriggerNode ~= nil then
    self.levelTriggerNode:Delete()
    self.levelTriggerNode = nil
  end
  if self.levelSpecialTriggerNode ~= nil then
    self.levelSpecialTriggerNode:Delete()
    self.levelSpecialTriggerNode = nil
  end
  if self._warnEffectNode ~= nil then
    self._warnEffectNode:Delete()
    self._warnEffectNode = nil
  end
  MsgCenter:RemoveListener(eMsgEventId.WC_TimeRewind, self.__onTimeRewind)
end

return UIWarChessMain
