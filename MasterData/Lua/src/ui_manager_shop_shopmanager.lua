local this = class("shopManager")

function this:buyGoods(param, callback)
  L_ShopStore:req_purchaseShopItem(param, function(sData, errCode)
    if errCode == L_Const.errorCode.ErrCodeShopOldVersion then
      local data_tip = {
        txtTitle = L_WordsTpl:getValue("ui_goods_01"),
        txtContent = L_WordsTpl:getValue("ui_goods_02"),
        confirmCallback = function()
          if callback then
            callback()
          end
        end
      }
      L_GameUtil.showCommonTip(data_tip)
    elseif errCode == L_Const.errorCode.ErrCodeSucc then
      if callback then
        callback()
      end
      local merged = {}
      local rewards = sData.rewards
      for k, v in pairs(rewards) do
        for k2, v2 in pairs(v.rewards) do
          local item = v2
          if not merged[item.itemid] then
            merged[item.itemid] = item
          else
            merged[item.itemid].itemnum = merged[item.itemid].itemnum + item.itemnum
          end
        end
      end
      local newData = {}
      newData.ignoreQueueCheck = true
      for _, v in pairs(merged) do
        table.insert(newData, v)
      end
      local rewards = require("ui.manager.reward.rewardData").new()
      rewards.rewardShowType = L_Const.rewardShowType.full
      local data = L_DataUtil.parseRewardConfig(newData, true, true, nil, false, true)
      rewards:constructList(data)
      L_RewardManager:ShowReward(rewards)
    end
  end)
end

function this:getShopTplEndTime(shopId)
  local shopTpl = L_GameTpl:getShopTpl()
  local tpl = shopTpl:getTplById(shopId)
  local endTime = shopTpl:getEndTime(tpl)
  if string.isEmpty(endTime) then
    return
  end
  return L_TimeUtil.getDateTimeStamp(endTime)
end

return this
