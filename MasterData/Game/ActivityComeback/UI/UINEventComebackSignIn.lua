local UINEventComebackSignIn = class("UINEventComebackSignIn", UIBaseNode)
local base = UIBaseNode
local UINEventComebackSignInItem = require("Game.ActivityComeback.UI.UINEventComebackSignInItem")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")

function UINEventComebackSignIn:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_AvgReview, self, self.__OnClickPlayAVG)
  self.__RefreshItemCallback = BindCallback(self, self.__RefreshItem)
  MsgCenter:AddListener(eMsgEventId.NoviceSignTime, self.__RefreshItemCallback)
  self.__ReviewAwardCallback = BindCallback(self, self.__ReviewAward)
  self._dayPool = UIItemPool.New(UINEventComebackSignInItem, self.ui.signItem)
  self.ui.signItem:SetActive(false)
end

function UINEventComebackSignIn:InitCombackSingIn(signId)
  self._data = PlayerDataCenter.eventNoviceSignData.dataDic[signId]
  if self._data == nil then
    erro("回归签到活动为空")
    return
  end
  self._dayPool:HideAll()
  local list = {}
  for k, v in pairs(self._data.awardCfg) do
    table.insert(list, v)
  end
  table.sort(list, function(a, b)
    return a.day < b.day
  end)
  local isAllowReceive = self._data:IsAllowReceive()
  for k, awardCfg in pairs(list) do
    local item = self._dayPool:GetOne()
    item:InitCombackSingIn(awardCfg, self.__ReviewAwardCallback)
    item:RefreshCombackSignItemState(self._data:GetEventSignTimes() + 1, isAllowReceive)
  end
end

function UINEventComebackSignIn:__ReviewAward(day)
  if not self._data:IsAllowReceive() then
    return
  end
  if self._data:GetEventSignTimes() + 1 ~= day then
    return
  end
  NetworkManager:GetNetwork(NetworkTypeID.EventNoviceSign):CS_SIGNACTIVITY_Pick(self._data.id, function(objList)
    self:__RefreshItem()
    if objList.Count == 0 then
      error("objList.Count == 0")
      return
    end
    local rewardDic = objList[0]
    local rewardIdList = {}
    local rewardNumList = {}
    for k, v in pairs(rewardDic) do
      local itemCfg = ConfigData.item[k]
      if itemCfg.type ~= eItemType.BattlePassPoint then
        table.insert(rewardIdList, k)
        table.insert(rewardNumList, v)
      end
    end
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window ~= nil then
        local CRData = CommonRewardData.CreateCRDataUseList(rewardIdList, rewardNumList)
        window:AddAndTryShowReward(CRData)
      end
    end)
  end)
end

function UINEventComebackSignIn:__RefreshItem()
  local isAllowReceive = self._data:IsAllowReceive()
  for i, item in ipairs(self._dayPool.listItem) do
    item:RefreshCombackSignItemState(self._data:GetEventSignTimes() + 1, isAllowReceive)
  end
end

function UINEventComebackSignIn:__OnClickPlayAVG()
  if self._playAvgCallback ~= nil then
    self._playAvgCallback()
  end
end

function UINEventComebackSignIn:SetPlayComebackAvg(callbakc)
  self._playAvgCallback = callbakc
end

function UINEventComebackSignIn:OnDelete()
  base.OnDelete(self)
  MsgCenter:RemoveListener(eMsgEventId.NoviceSignTime, self.__RefreshItemCallback)
end

return UINEventComebackSignIn
