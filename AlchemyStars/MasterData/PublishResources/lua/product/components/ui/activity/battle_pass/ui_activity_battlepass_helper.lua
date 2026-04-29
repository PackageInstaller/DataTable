_class("UIActivityBattlePassHelper", Object)
UIActivityBattlePassHelper = UIActivityBattlePassHelper

function UIActivityBattlePassHelper.OpenMainController(...)
  GameGlobal.UIStateManager():ShowDialog("UIBattlePassCN1MainController", ...)
end

function UIActivityBattlePassHelper.OpenBuyGiftResultController(...)
  GameGlobal.UIStateManager():ShowDialog("UIBattlePassCN1BuyGiftResultController", ...)
end

function UIActivityBattlePassHelper.OpenBuyGiftController(...)
  GameGlobal.UIStateManager():ShowDialog("UIBattlePassCN1BuyGiftController", ...)
end

function UIActivityBattlePassHelper.OpenBuyLevelController(...)
  GameGlobal.UIStateManager():ShowDialog("UIBattlePassCN1BuyLevelController", ...)
end

function UIActivityBattlePassHelper.OpenPreviewController(...)
  GameGlobal.UIStateManager():ShowDialog("UIBattlePassCN1PreviewController", ...)
end

function UIActivityBattlePassHelper.LoadDataOnEnter(TT, res)
  local campaignType = ECampaignType.CAMPAIGN_TYPE_BATTLEPASS
  local componentIds = {}
  local campaign = UIActivityHelper.LoadDataOnEnter(TT, res, campaignType, componentIds)
  return campaign
end

function UIActivityBattlePassHelper.ComponentId_Quest(idx)
  local tb = {
    ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_1,
    ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_2,
    ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_3
  }
  return tb[idx]
end

function UIActivityBattlePassHelper.Component_Quest(campaign, idx)
  local cmptId = UIActivityBattlePassHelper.ComponentId_Quest(idx)
  local component = campaign:GetComponent(cmptId)
  local componentInfo = campaign:GetComponentInfo(cmptId)
  return cmptId, component, componentInfo
end

function UIActivityBattlePassHelper.Component_LVReward(campaign)
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD
  local component = campaign:GetComponent(cmptId)
  local componentInfo = campaign:GetComponentInfo(cmptId)
  return cmptId, component, componentInfo
end

function UIActivityBattlePassHelper.Component_BuyGift(campaign)
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_BUY_GIFT
  local component = campaign:GetComponent(cmptId)
  local componentInfo = campaign:GetComponentInfo(cmptId)
  return cmptId, component, componentInfo
end

function UIActivityBattlePassHelper.GetAllGiftLocalPrice(campaign)
  local cmptId, component, componentInfo = UIActivityBattlePassHelper.Component_BuyGift(campaign)
  component:GetAllGiftLocalPrice()
end

function UIActivityBattlePassHelper.CheckIsLevelMax(campaign)
  local cmptId, component, componentInfo = UIActivityBattlePassHelper.Component_LVReward(campaign)
  return component and component:CheckIsLevelMax() or false
end

function UIActivityBattlePassHelper.GetLvRewardCfg(campaign)
  local cmptId, component, componentInfo = UIActivityBattlePassHelper.Component_LVReward(campaign)
  if component then
    local cfg1, cfg2 = component:GetSpecialRewardCfg()
    return cfg1, cfg2
  end
end

function UIActivityBattlePassHelper.IsExtraLevelReward(campaign, roleAsset)
  local cmptId, component, componentInfo = UIActivityBattlePassHelper.Component_LVReward(campaign)
  return component and component:IsExtraLevelReward(roleAsset)
end

function UIActivityBattlePassHelper.CheckComponentRedPoint(campaign, ...)
  if not (campaign and campaign:GetLocalProcess()) or not campaign:CheckCampaignOpen() then
    return false
  end
  local extra = not UIActivityBattlePassHelper.CheckIsLevelMax(campaign)
  local componentExtraCondition = {
    [ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD] = true,
    [ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_1] = extra,
    [ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_2] = extra,
    [ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_QUEST_3] = extra
  }
  local args = {
    ...
  }
  for _, v in pairs(args) do
    if componentExtraCondition[v] and campaign:CheckComponentRed(v) then
      return true
    end
  end
  return false
end

function UIActivityBattlePassHelper.CheckCampaignRedPoint(campaign)
  local redQuest = UIActivityBattlePassHelper.CalcRed_Quest(campaign, 1, 2, 3)
  local redReward = UIActivityBattlePassHelper.CalcRed_Reward(campaign)
  return redQuest or redReward
end

function UIActivityBattlePassHelper.CalcRed_Quest(campaign, ...)
  local params = {
    ...
  }
  local tb = {}
  for _, v in ipairs(params) do
    table.insert(tb, UIActivityBattlePassHelper.ComponentId_Quest(v))
  end
  return UIActivityBattlePassHelper.CheckComponentRedPoint(campaign, table.unpack(tb))
end

function UIActivityBattlePassHelper.CalcRed_Reward(campaign)
  local cmptId = ECampaignBattlePassComponentID.ECAMPAIGN_BATTLEPASS_LV_REWARD
  return UIActivityBattlePassHelper.CheckComponentRedPoint(campaign, cmptId)
end

function UIActivityBattlePassHelper.SetSpecialImg(campaign, obj, img, dialogName, desc1, desc2)
  local cfg = UIActivityBattlePassHelper.GetLvRewardCfg(campaign)
  local icon = cfg.SpecialRewardImage
  local descPos1 = cfg.SpeicalRewardDescPos1
  local descPos2 = cfg.SpeicalRewardDescPos2
  if not string.isnullorempty(icon) then
    img:LoadImage(icon)
    UICG.SetTransform(obj.transform, dialogName, icon)
  end
  if desc1 and descPos1 then
    desc1.transform.localPosition = Vector3(descPos1[1] or 0, descPos1[2] or 0, 0)
  end
  if desc2 and descPos2 then
    desc2.transform.localPosition = Vector3(descPos2[1] or 0, descPos2[2] or 0, 0)
  end
end

function UIActivityBattlePassHelper.GetStrIdInCampaign(campaign, strId)
  return strId .. "_campaignid_" .. campaign._id
end

function UIActivityBattlePassHelper.SetSpecialImgInfo(campaign, uiView, widgetName1, widgetName2)
  local id = campaign and campaign._id or -1
  local cfg = Cfg.cfg_battle_pass_special_img[id]
  if cfg == nil then
    return
  end
  local uiName = uiView and uiView:GetName() or ""
  local url = cfg.rawImageName
  local pos = uiName == "UIBattlePassCN1RewardMain" and cfg.RewardMainPos or cfg.BuyGiftPos
  uiView:GetGameObject(widgetName1):SetActive(true)
  UIWidgetHelper.SetAnchoredPosition(uiView, widgetName1, pos[1], pos[2])
  UIWidgetHelper.SetRawImage(uiView, widgetName2, url)
end

function UIActivityBattlePassHelper.SetSkinBtnInfo(campaign, index, uiView, widgetName, callback)
  local id = campaign and campaign._id or -1
  local cfg = Cfg.cfg_battle_pass_skin_btn[id]
  if cfg == nil then
    return
  end
  local className = index == 1 and cfg.SkinAClass or cfg.SkinBClass
  local prefabName = index == 1 and cfg.SkinAPrefab or cfg.SkinBPrefab
  local pos = index == 1 and cfg.SkinAPos or cfg.SkinBPos
  local obj = UIWidgetHelper.SpawnObject(uiView, widgetName, className, prefabName)
  obj:SetData(campaign, index, callback)
  obj:SetPos(pos)
end
