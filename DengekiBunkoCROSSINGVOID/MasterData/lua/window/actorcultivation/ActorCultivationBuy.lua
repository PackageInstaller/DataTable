local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local m_vipInfo

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonConfirm, OnClickConfirm)
  WU.BindButtonEvent(REF.ButtonCancel, OnClickCancel)
end

function InitWindow()
  WU.TraverseChildren(REF.SpriteCostBG, function(go)
    go:SetActive(false)
  end)
end

function SetData(info)
  m_vipInfo = info
  WU.SetActive(REF.NodeNotActivated, not m_vipInfo.isVip)
  WU.SetActive(REF.LabelAlreadyActivated, m_vipInfo.isVip)
  local costs = m_vipInfo.cost
  if costs[1].type == PB.enum.ResourceType.ResPlayerMoney then
    REF.WidgetIconCost["$SetData"](costs[1].count, costs[1].type)
    REF.WidgetIconCost.gameObject:SetActive(true)
  else
    REF.WidgetIconCost.gameObject:SetActive(false)
    for i = 1, #costs do
      REF["LabelCost" .. i].gameObject:SetActive(true)
      REF["LabelCost" .. i].ResourcePrinter:SetResource(costs[i].type, costs[i].id, costs[i].count)
    end
  end
  REF.SpriteCostBG.UIGrid:Reposition()
end

function OnClickConfirm()
  if m_vipInfo then
    local costs = m_vipInfo.cost
    local tryToPaySuccess = true
    local lackMoney = {}
    for i = 1, #costs do
      local cost = costs[i]
      WU.TryToPay(cost.type, cost.id, cost.count, function()
      end, function()
        tryToPaySuccess = false
        table.insert(lackMoney, cost.type)
      end)
    end
    if tryToPaySuccess then
      if m_vipInfo.activityType == PB.enum.ActivityType.ActorCultivation then
        RequestBuyVipActorCultivation()
      elseif m_vipInfo.activityType == PB.enum.ActivityType.CustomActorCultivation then
        RequestBuyVipCustomActorCultivation()
      end
      this:SetData("fci/actorCultivationTasks", this:GetData("fci/actorCultivationTasks"))
    else
      do
        local bLackGold = false
        local MoneyLack = false
        local failedDesc = ""
        for i = 1, #lackMoney do
          if lackMoney[i] == PB.enum.ResourceType.ResPlayerGold then
            failedDesc = WU.GetString("WindowShopBuy_PurchaseFailedA") .. "\n"
            bLackGold = true
          elseif lackMoney[i] == PB.enum.ResourceType.ResPlayerPayMoney or lackMoney[i] == PB.enum.ResourceType.ResPlayerMoney then
            MoneyLack = true
            local tip = WU.GetString("Window_ResourceTypeNotEnough", WU.GetString("ResourceTypeName_" .. lackMoney[i]))
            DB:BroadcastGameEvent("ShowMessageYesNo", tip, function(result)
              if result == "YES" then
                WU.AcquireWindowAsync("Purchase")
              end
            end, WU.GetString("Window_Recharge"))
          else
            failedDesc = WU.GetString("WindowShopBuy_PurchaseFailedC") .. "\n"
          end
        end
        if bLackGold == true then
          WU.ShowMessageYesNo(WU.GetString("Purchase_Tips8"), function(msg)
            if msg == "YES" then
              WU.Exchange(PB.enum.ResourceType.ResPlayerGold)
            end
          end)
        else
          WU.RecycleWindow(this)
          if not MoneyLack then
            WU.ShowHintText(failedDesc)
          end
        end
      end
    end
  end
end

function RequestBuyVipActorCultivation()
  this:GameRequest("fci/actor-cultivation/" .. m_vipInfo.activityId .. "/upgrade-vip/"):Post({}, function(result)
    DBH.ResChange(result.resChange)
    local info = this:GetData("ActorCultivation")
    local hasExtraRewards = false
    for _, v in pairs(info) do
      if v.activityId == m_vipInfo.activityId then
        v.vip = true
        v.progressRewardVip = result.info.progressRewardVip
        break
      end
    end
    if table.find(result.resChange, function(_, v)
      return v.baseRes and v.baseRes.countDelta > 0
    end) then
      WU.ShowRewards(result.resChange, nil, "result_title_09", WU.GetString("ActorCultivation_VipProgressReward"))
    else
      WU.AcquireWindowAsync("ActorCultivationVipActivated")
    end
    this:SetData("ActorCultivation", info)
    WU.RecycleWindow(this)
  end)
end

function RequestBuyVipCustomActorCultivation()
  this:GameRequest(string.format("fci/custom-actor-cultivation/%s/upgrade-vip/", m_vipInfo.activityId)):Post({}, function(resp)
    DBH.ResChange(resp.resChange)
    local data = this:GetData("fci/custom-actor-cultivation/")
    DBH.DBUpdate(data.culPlans, "activityId", resp.info)
    this:SetData("fci/custom-actor-cultivation/", data)
    if table.find(resp.resChange, function(_, v)
      return v.baseRes and v.baseRes.countDelta > 0
    end) then
      WU.ShowRewards(resp.resChange, nil, "result_title_09", WU.GetString("ActorCultivation_VipProgressReward"))
    else
      WU.AcquireWindowAsync("ActorCultivationVipActivated")
    end
    WU.RecycleWindow(this)
  end)
end

function OnClickCancel()
  WU.RecycleWindow(this)
end
