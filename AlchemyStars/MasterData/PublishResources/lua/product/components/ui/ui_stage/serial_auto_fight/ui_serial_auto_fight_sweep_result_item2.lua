_class("UISerialAutoFightSweepResultItem2", UICustomWidget)
UISerialAutoFightSweepResultItem2 = UISerialAutoFightSweepResultItem2

function UISerialAutoFightSweepResultItem2:SetData(type, asset, svRect, tipsCallback)
  local item = UIWidgetHelper.SpawnObject(self, "_item", "UIItem")
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
  item:SetForm(UIItemForm.Result, 0.6)
  item:SetData({
    icon = award.icon,
    text1 = award.count,
    quality = award.color,
    itemId = award.id,
    resultType = param.resultType,
    activityText = param.activityText,
    returnHelpText = param.returnHelpText
  })
  item:SetClickCallBack(function(go)
    tipsCallback(award.id, go.transform.position)
  end)
  self:_SetUiDragScrollViewRect(item, svRect)
end

function UISerialAutoFightSweepResultItem2:PlayAnimationInSequence(index)
  local idx = index < 6 and index or 6
  local animName = "uieff_UISerialAutoFightSweepResult_Item2_in"
  local delay = 0 + (index - 1) * 66
  local duration, callback, doNotLock = nil, nil, true
  UIWidgetHelper.PlayAnimationInSequence(self, "_anim", "_item", animName, delay, duration, callback, doNotLock)
end

function UISerialAutoFightSweepResultItem2:_SetUiDragScrollViewRect(uiItem, svRect)
  local go = uiItem:GetBtn()
  local uiDrags = go:GetComponents(typeof(UIDrag))
  if uiDrags and uiDrags.Length == 1 then
    go:AddComponent(typeof(UIDrag))
  end
  local uiDrag = go:GetComponent("UIDrag")
  uiDrag.mScrollViewRect = svRect
end
