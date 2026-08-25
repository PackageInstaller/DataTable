local AwakerBreakthroughReward, Super = System.NewComponent("AwakerBreakthroughReward")

function AwakerBreakthroughReward:ctor(awakerModel, go, itemInfo)
  Super.ctor(self)
  self.model = awakerModel
  self.ui = UI_Common_Item_WuPin_Type1Resource(go)
  self.itemInfo = itemInfo
end

function AwakerBreakthroughReward:OnBind(binder)
  self.binder = binder
  binder:BindToVisible(self.ui.uiNode, function()
    return self.itemInfo ~= nil
  end)
  binder:BindToImage(self.ui.Icon_Common, function()
    if self.itemInfo ~= nil then
      do return ItemDataUtils.GetItemIcon end
      return ItemDataUtils.GetItemIcon, self.itemInfo.id
    else
      return ""
    end
  end)
  binder:BindToImage(self.ui.Image_Quality, function()
    if self.itemInfo ~= nil then
      local config = DT.Item[self.itemInfo.id]
      do return ItemDataUtils.GetCommonItemBottomQualityFrame, config end
      return ItemDataUtils.GetCommonItemBottomQualityFrame, config, self.ui.Image_Bg_Black
    else
      return ""
    end
  end)
  binder:BindToText(self.ui.Text_Article_Number, function()
    if self.itemInfo ~= nil then
      return self.itemInfo.count
    else
      return 0
    end
  end)
  binder:BindLongPressButton(self.ui.Btn_Click, function()
  end, System.fn(self, self.OnTodoFunc), tonumber(DT.GetConstant("Role_Press_Time")))
  binder:BindToVisible(self.ui.Group_Get, function()
    local state = self.model:GetAwakerBreakthroughRewardReceiveStatePreview(self.model.selectAwakerId)
    return state == CommonDefine.AwakerBreakThrough.RewardReceived
  end)
end

function AwakerBreakthroughReward:OnTodoFunc()
  if self.itemInfo ~= nil then
    ItemDataUtils.ShowItemDetailTips(self.binder, self.ui.uiNode, nil, self.itemInfo.id)
  end
end

return AwakerBreakthroughReward
