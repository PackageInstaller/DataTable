_class("UISerialAutoFightSweepResultItem2S1", UICustomWidget)
UISerialAutoFightSweepResultItem2S1 = UISerialAutoFightSweepResultItem2S1

function UISerialAutoFightSweepResultItem2S1:SetData(type, asset, svRect, tipsCallback)
  local item = UIWidgetHelper.SpawnObject(self, "_item", "UISeasonItem")
  local award = Award:New()
  award:InitWithCount(asset.assetid, asset.count)
  local tb = {
    m_back_rewards = {
      returnHelpText = StringTable.Get("str_return_system_reward_title")
    },
    m_activity_rewards = {
      activityText = StringTable.Get("str_item_xianshi")
    },
    m_coin_ext_rewards = {
      resultType = UIItemResultType.ResCoinExt
    },
    m_vecAwardNormal = {
      resultType = UIItemResultType.None,
      activityText = "",
      returnHelpText = ""
    }
  }
  local param = tb[type] or {}
  local ra = RoleAsset:New()
  ra.assetid = award.id
  ra.count = award.count
  item:Flush(ra)
  self:_SetUiDragScrollViewRect(item, svRect)
end

function UISerialAutoFightSweepResultItem2S1:PlayAnimationInSequence(index)
  local animName = "uieff_UISerialAutoFightSweepResult_Item2_in"
  local delay = 0 + (index - 1) * 66
  local duration, callback, doNotLock = nil, nil, true
  UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_anim", animName, delay, duration, callback, doNotLock)
end

function UISerialAutoFightSweepResultItem2S1:_SetUiDragScrollViewRect(uiItem, svRect)
  local go = uiItem:GetBtn()
  local uiDrags = go:GetComponents(typeof(UIDrag))
  if uiDrags and uiDrags.Length == 1 then
    go:AddComponent(typeof(UIDrag))
  end
  local uiDrag = go:GetComponent("UIDrag")
  uiDrag.mScrollViewRect = svRect
end
