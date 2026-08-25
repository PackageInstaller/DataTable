local UIAdditionalRewardUtils = {}

function UIAdditionalRewardUtils.BindAdditionalReward(binder, textComp, imageComp, tid, num)
  binder:BindToText(textComp, function()
    do return LT.Text end
    return LT.Text, num
  end)
  binder:BindToImage(imageComp, function()
    do return ItemDataUtils.GetItemIcon end
    return ItemDataUtils.GetItemIcon, tid
  end)
end

return UIAdditionalRewardUtils
