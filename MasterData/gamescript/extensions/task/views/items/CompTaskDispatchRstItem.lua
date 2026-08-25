local MAX_AWAKER_NUM = 4
local MAX_REWARD_NUM = 4
local CompTaskDispatchRstItem, Super = NewViewComponent("CompTaskDispatchRstItem")

function CompTaskDispatchRstItem:ctor(uiNode, view, data)
  Super.ctor(self, uiNode, view)
  self.ui = UI_Research_Item_TaskResource(uiNode)
  self.awakerList = data.awakerList
  self.awardList = data.awardList
  self.taskData = data.taskData
  self.taskTid = self.taskData and self.taskData.tid or 0
  self.taskCfg = DT.Task[self.taskTid] and DT.Task[self.taskTid] or {}
  self.rewardCompGroup = {}
end

function CompTaskDispatchRstItem:RegisterEvents()
  self:BindEvent(EventMgr.Instance.TaskDispatchCompleted, function()
    self:PlayRewardUIEffect()
  end)
end

function CompTaskDispatchRstItem:OnEnterComponent()
  self:_InitAwakerGroup()
  self:_InitRewardGroup()
  self:SetText(self.ui.Text_Title, LT.Text(self.taskCfg.Name))
end

function CompTaskDispatchRstItem:_InitRewardGroup()
  for idx = 1, MAX_REWARD_NUM do
    local obj = self.ui["WuPin_Type_" .. idx]
    local rewardData = self.awardList[idx]
    if rewardData then
      obj:SetActive(true)
      local viewData = {
        itemTid = rewardData.tid,
        itemCount = rewardData.changedNum,
        extraDesc = rewardData.extraDesc and rewardData.extraDesc or rewardData.extraDescFunc and rewardData.extraDescFunc() or "",
        extraDescBgType = rewardData.extraDescFunc and CommonDefine.CommonIconExtraDescBgType.Blue or CommonDefine.CommonIconExtraDescBgType.Default,
        reason = rewardData.reason
      }
      local comp = self:AddViewComponentOnce(obj, CompPublicIconItemType2, viewData)
      table.insert(self.rewardCompGroup, comp)
    else
      obj:SetActive(false)
    end
  end
end

local function CheckAwakerTidValid(awakerTid)
  return awakerTid and awakerTid > 0
end

function CompTaskDispatchRstItem:_InitAwakerGroup()
  for idx = 1, MAX_AWAKER_NUM do
    local awakerTid = self.awakerList[idx]
    local obj = self.ui["UI_Common_Item_Awaker" .. idx]
    if CheckAwakerTidValid(awakerTid) then
      obj:SetActive(true)
      local awakerData = AwakerDataUtils.GetAwakerData(awakerTid)
      local awakerLevel = awakerData and awakerData.level or 1
      local itemCount = string.format("LV.%s", awakerLevel)
      local viewData = {itemCount = itemCount, awakerId = awakerTid}
      self:AddViewComponentOnce(obj, CompPublicIconItemType2, viewData)
    else
      obj:SetActive(false)
    end
  end
end

function CompTaskDispatchRstItem:PlayRewardUIEffect()
  for _, comp in ipairs(self.rewardCompGroup) do
    comp:CreateUIEffect()
  end
end

return CompTaskDispatchRstItem
