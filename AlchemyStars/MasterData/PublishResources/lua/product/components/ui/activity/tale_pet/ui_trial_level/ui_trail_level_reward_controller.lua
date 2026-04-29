local TrailLevelRewardStatus = {
  UnComplete = 2,
  UnGet = 0,
  HasGet = 1
}
_enum("TrailLevelRewardStatus", TrailLevelRewardStatus)
_class("UITrailLevelRewardController", UIController)
UITrailLevelRewardController = UITrailLevelRewardController

function UITrailLevelRewardController:LoadDataOnEnter(TT, res, uiParams)
  local talePetModule = GameGlobal.GetModule(TalePetModule)
  self._level, self._maxLevel = talePetModule:GetLevelCount()
  self._rewardData = {}
  local rewardDatas = talePetModule:GetTrailLevelRewardList()
  for i = 1, #rewardDatas do
    local data = rewardDatas[i]
    local rewardData = {}
    rewardData.id = data[1]
    rewardData.status = data[2]
    local cfg = Cfg.cfg_tale_stage_reward[rewardData.id]
    rewardData.count = cfg.Count
    rewardData.icon = cfg.Icon
    rewardData.dropId = cfg.DropId
    rewardData.name = StringTable.Get(cfg.Name)
    rewardData.des = StringTable.Get(cfg.Desc, rewardData.count)
    self._rewardData[#self._rewardData + 1] = rewardData
  end
  self._rewardCount = #self._rewardData
end

function UITrailLevelRewardController:OnShow(uiParams)
  self._levelLabel = self:GetUIComponent("UILocalizationText", "Level")
  local param = self._level .. "/<color=#FF7800>" .. self._maxLevel .. "</color>"
  self._levelLabel:SetText(StringTable.Get("str_tale_pet_trail_level_reward_progress", param))
  self._scrollView = self:GetUIComponent("UIDynamicScrollView", "RewardList")
  self:_InitScrollView()
end

function UITrailLevelRewardController:_InitScrollView()
  self._scrollView:InitListView(self._rewardCount, function(scrollview, index)
    return self:_OnGetRewardItem(scrollview, index)
  end)
end

function UITrailLevelRewardController:_OnGetRewardItem(scrollView, index)
  local item = scrollView:NewListViewItem("RowItem")
  local rowPool = self:GetUIComponentDynamic("UISelectObjectPath", item.gameObject)
  if item.IsInitHandlerCalled == false then
    item.IsInitHandlerCalled = true
    rowPool:SpawnObjects("UITrailLevelRewardItem", 1)
  end
  local rowList = rowPool:GetAllSpawnList()
  local itemWidget = rowList[1]
  if itemWidget then
    local itemIndex = index + 1
    if itemIndex > self._rewardCount then
      itemWidget:GetGameObject():SetActive(false)
    else
      itemWidget:GetGameObject():SetActive(true)
      self:_RefreshRewardItemInfo(itemWidget, itemIndex)
    end
  end
  UIHelper.RefreshLayout(item:GetComponent("RectTransform"))
  return item
end

function UITrailLevelRewardController:_RefreshRewardItemInfo(itemWidget, index)
  itemWidget:Refresh(self._rewardData[index])
end

function UITrailLevelRewardController:MaskOnClick()
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TalePetTrailLevelRewardChange)
  GameGlobal.EventDispatcher():Dispatch(GameEventType.TalePetRedStatusChange)
  self:CloseDialog()
end
