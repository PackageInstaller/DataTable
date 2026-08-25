local PVPPreconModeRewardExp = DT.GetConstant("PVPPreconModeRewardExp")
local PVPDraftPickModeRewardExp = DT.GetConstant("PVPDraftPickModeRewardExp")
local PvpSettleDataItem, Super = System.NewComponent("PvpSettleDataItem")

function PvpSettleDataItem:ctor(uiNode, rewardDatas)
  Super.ctor(self)
  self.ui = UI_Pvp_Item_Out_ObtainResource(uiNode)
  self.rewardDatas = rewardDatas
  self.tid = self.rewardDatas[1] and self.rewardDatas[1].tid
  self.totalNum = 0
  for _, rewardData in pairs(self.rewardDatas) do
    self.totalNum = self.totalNum + rewardData.num
  end
end

function PvpSettleDataItem:OnBind(binder)
  self.binder = binder
  if not self.tid then
    self.ui.uiNode:SetActive(false)
    return
  end
  local itemCfg = DT.Item[self.tid]
  binder:BindToImage(self.ui.Image_Icon, function()
    return itemCfg.Icon
  end)
  binder:BindToText(self.ui.Text_Description, function()
    do return LT.Text end
    return LT.Text, itemCfg.Name
  end)
  binder:BindToText(self.ui.Text_Obtain, function()
    do return string.format, "+%s" end
    return string.format, "+%s", self.totalNum
  end)
  binder:BindToVisible(self.ui.Group_Tab_Double, function()
    return false
  end)
  if table.contains({PVPPreconModeRewardExp, PVPDraftPickModeRewardExp}, self.tid) then
    self:BindCompBySettleData(self:GetSettleDataByReason(CommonDefine.PvPSettleRewardDataType.PVPStyle), LT.Text("PVPBattlePerformance"), 0)
    self:BindCompBySettleData(self:GetSettleDataByReason(CommonDefine.PvPSettleRewardDataType.PVP), LT.Text("PvpBattleRewardRankBonus"), 0)
  else
    self:BindCompBySettleData(self:GetSettleDataByReason(CommonDefine.PvPSettleRewardDataType.PVP), LT.Text("PVPMatchVictory"), 0)
    self:BindCompBySettleData(self:GetSettleDataByReason(CommonDefine.PvPSettleRewardDataType.PVPStyle), LT.Text("PVPBattlePerformance"), 0)
  end
  self:BindCompBySettleData(self:GetSettleDataByReason(CommonDefine.PvPSettleRewardDataType.ExpBonus), LT.Text("PVPSettleAccelerateField"))
  if BattlePassDataUtils.IsRoleExp(self.tid) then
    local tempUi = CS.UnityEngine.GameObject.Instantiate(self.ui.UI_Pvp_Out_Manifestation_1, self.ui.UI_Pvp_Out_Manifestation_1.transform.parent)
    tempUi:SetActive(true)
    self.binder:BindComponent(RoleDayExpLimitTips(tempUi))
  end
  self.ui.Group_Tab_Topic:SetActive(self:HasAdvancedPrivilege())
  self.ui.Group_Tab_Double:SetActive(self:HasDoubleActivity())
end

function PvpSettleDataItem:HasAdvancedPrivilege()
  return false
end

function PvpSettleDataItem:HasDoubleActivity()
  return ActivityManager.Instance:IsActivityOpenByType(ActivityDefine.ActivityType.DoubleExp) and self:IsRoleExp()
end

function PvpSettleDataItem:IsRoleExp()
  local cfgList = DT.GetOriginalConstant("PVPandDailyChallengeRewardLimit")
  local expId = cfgList[1]
  local result = self.tid == expId
  return result
end

function PvpSettleDataItem:BindCompBySettleData(settleData, name, defaultNum)
  if not settleData and not defaultNum then
    return
  end
  local showNum = settleData and settleData.num or defaultNum or 0
  local go = CS.UnityEngine.GameObject.Instantiate(self.ui.UI_Pvp_Out_Manifestation_1, self.ui.UI_Pvp_Out_Manifestation_1.transform.parent)
  go:SetActive(true)
  local times = 1
  if BattlePassDataUtils.IsRoleExp(self.tid) then
    local hasActivity = ActivityManager.Instance:IsActivityOpenByType(ActivityDefine.ActivityType.DoubleExp)
    local hasPrivilege = false
    times = hasActivity and times * 2 or times
    times = hasPrivilege and times * 2 or times
  end
  local itemData = {
    name = name,
    num = math.floor(showNum / times)
  }
  self.binder:BindComponent(PvpSettleTextItem(go, itemData))
end

function PvpSettleDataItem:GetSettleDataByReason(type)
  for _, rewardData in pairs(self.rewardDatas) do
    if rewardData.reason == type then
      return rewardData
    end
  end
  return nil
end

return PvpSettleDataItem
