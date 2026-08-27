local UINChallengeTaskInfoItem = require("Game.PeriodicChallenge.UI.UINChallengeTaskInfoItem")
local UINBrotatoTaskInfoItem = class("UINBrotatoTaskInfoItem", UINChallengeTaskInfoItem)
local base = UINChallengeTaskInfoItem
local UINBaseItemWithCount = require("Game.CommonUI.Item.UINBaseItemWithCount")
local TaskEnum = require("Game.Task.TaskEnum")

function UINBrotatoTaskInfoItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.itemPool = UIItemPool.New(UINBaseItemWithCount, self.ui.uINBaseItem)
  self.ui.uINBaseItem:SetActive(false)
  UIUtil.AddButtonListener(self.ui.infoItem, self, self.OnClickTaskPanel)
  self.__RefreshReddotState = BindCallback(self, self.RefreshReddotState)
  self.__RefreshScoreInfo = BindCallback(self, self.RefreshScoreInfo)
  MsgCenter:AddListener(eMsgEventId.PeroidUpdate, self.__RefreshScoreInfo)
  self.__OnBrotatoChange = BindCallback(self, self.OnBrotatoChange)
  MsgCenter:AddListener(eMsgEventId.ActivityTinyGameBrotatoChange, self.__OnBrotatoChange)
  self.__OnBrotatoTaskWinClose = BindCallback(self, self.OnBrotatoTaskWinClose)
end

function UINBrotatoTaskInfoItem:OnBrotatoChange(brotatoData)
  if brotatoData ~= self.brotatoData then
    return
  end
  self:RefreshScoreInfo()
end

function UINBrotatoTaskInfoItem:InitTaskInfoItem(brotatoId)
  self.brotatoId = brotatoId
  self.brotatoCfg = ConfigData.tiny_game_brotato[brotatoId]
  local activityBrotatoLobbyCtrl = ControllerManager:GetController(ControllerTypeId.ActivityBrotatoLobby, true)
  self.brotatoData = activityBrotatoLobbyCtrl:GetBrotatoData(brotatoId)
  self.rewardReddot = self.brotatoData:GetBrotatoRedDot()
  self:RefreshScoreInfo()
  self:SetTaskInfoReddot(self.rewardReddot)
end

function UINBrotatoTaskInfoItem:SetTaskInfoReddot(rewardReddot)
  if rewardReddot == nil then
    return
  end
  self:RefreshReddotState(rewardReddot)
  RedDotController:AddListener(rewardReddot.nodePath, self.__RefreshReddotState)
end

function UINBrotatoTaskInfoItem:RefreshScoreInfo()
  if self.brotatoData == nil then
    return
  end
  local peroidDatas = self.brotatoData:GetBrotatoAchieveData()
  local currActiveNum = self.brotatoData:GetGameBrotatoItemNum()
  local totalActiveNum = 0
  local selectPeroidData
  local isLimit = false
  for i, data in ipairs(peroidDatas) do
    totalActiveNum = data.stcData.activeNum
    if currActiveNum < totalActiveNum then
      selectPeroidData = data
      break
    elseif i == #peroidDatas then
      selectPeroidData = data
      isLimit = true
    end
  end
  self.ui.scoreText:SetIndex(0, tostring(currActiveNum), tostring(totalActiveNum))
  self.ui.obj_isGetALL:SetActive(isLimit)
  self.ui.obj_rewardNode:SetActive(not isLimit)
  self.itemPool:HideAll()
  if isLimit then
    return
  end
  for i, itemId in ipairs(selectPeroidData.stcData.rewardIds) do
    local itemCount = selectPeroidData.stcData.rewardNums[i]
    local itemCfg = ConfigData.item[itemId]
    local item = self.itemPool:GetOne()
    item:InitItemWithCount(itemCfg, itemCount)
  end
end

function UINBrotatoTaskInfoItem:RefreshReddotState(reddot)
  self.ui.redDot:SetActive(reddot ~= nil and reddot:GetRedDotCount() > 0)
end

function UINBrotatoTaskInfoItem:OnClickTaskPanel()
  if self.brotatoData == nil then
    return
  end
  UIManager:ShowWindowAsync(UIWindowTypeID.MiniGameTask, function(win)
    if win == nil then
      return
    end
    win:InitBrotatoTask(self.brotatoData, self.__OnBrotatoTaskWinClose)
    self.ui.obj_rewardNode:SetActive(false)
  end)
end

function UINBrotatoTaskInfoItem:OnBrotatoTaskWinClose()
  self.ui.obj_rewardNode:SetActive(true)
end

function UINBrotatoTaskInfoItem:OnDelete()
  if self.rewardReddot ~= nil then
    RedDotController:RemoveListener(self.rewardReddot.nodePath, self.__RefreshReddotState)
  end
  MsgCenter:RemoveListener(eMsgEventId.ActivityTinyGameBrotatoChange, self.__OnBrotatoChange)
  base.OnDelete(self)
end

return UINBrotatoTaskInfoItem
