_class("UIHauteCoutureDataBase", Object)
UIHauteCoutureDataBase = UIHauteCoutureDataBase

function UIHauteCoutureDataBase:Constructor(campaignID)
  self._id = campaignID
end

function UIHauteCoutureDataBase:CostItemID()
  Log.exception("CostItemID()方法必须重写：", debug.traceback())
end

function UIHauteCoutureDataBase:ShopGoodsOnClick()
  Log.exception("ShopGoodsOnClick()方法必须重写：", debug.traceback())
end

function UIHauteCoutureDataBase:BuyItem()
  Log.exception("BuyItem()方法必须重写：", debug.traceback())
end

function UIHauteCoutureDataBase:IsReview()
  Log.exception("IsReview()方法必须重写：", debug.traceback())
end

function UIHauteCoutureDataBase:GetSkinId()
  return nil
end

function UIHauteCoutureDataBase:HC_Type()
  Log.exception("HC_Type()方法必须重写：", debug.traceback())
end

function UIHauteCoutureDataBase:GetMainUIInfo()
  Log.exception("GetMainUIInfo()方法必须重写：", debug.traceback())
end

function UIHauteCoutureDataBase:GetMainUIBgInfo()
  Log.exception("GetMainUIInfo()方法必须重写：", debug.traceback())
end

function UIHauteCoutureDataBase:GetGetItemUIInfo()
  Log.exception("GetGetItemUIInfo()方法必须重写：", debug.traceback())
end

function UIHauteCoutureDataBase:GetChargeUIInfo()
  Log.exception("GetChargeUIInfo()方法必须重写：", debug.traceback())
end

function UIHauteCoutureDataBase:GetChargeUIBgInfo()
  Log.exception("GetChargeUIBgInfo()方法必须重写：", debug.traceback())
end

function UIHauteCoutureDataBase:GetRulesUIInfo()
  Log.exception("GetRulesUIInfo()方法必须重写：", debug.traceback())
end

function UIHauteCoutureDataBase:GetRulesUIBgInfo()
  Log.exception("GetRulesUIBgInfo()方法必须重写：", debug.traceback())
end

function UIHauteCoutureDataBase:GetVideoUIInfo()
  Log.exception("GetVideoUIInfo()方法必须重写：", debug.traceback())
end

function UIHauteCoutureDataBase:GetDynamicProbablityUIInfo()
  Log.exception("GetDynamicProbablityUIInfo()方法必须重写：", debug.traceback())
end

function UIHauteCoutureDataBase:GetDynamicProbablityUIBgInfo()
  Log.exception("GetDynamicProbablityUIBgInfo()方法必须重写：", debug.traceback())
end

function UIHauteCoutureDataBase:SideEnterText()
  Log.exception("SideEnterText()方法必须重写：", debug.traceback())
end

function UIHauteCoutureDataBase:Review_DuplicateRewardBgInfo()
  if not self:IsReview() then
    Log.exception("非复刻的活动不可调用Review_DuplicateRewardBgInfo()方法:", debug.traceback())
    return
  end
  Log.exception("Review_DuplicateRewardBgInfo()方法必须重写：", debug.traceback())
end

function UIHauteCoutureDataBase:Review_DuplicateRewardUIInfo()
  if not self:IsReview() then
    Log.exception("非复刻的活动不可调用Review_DuplicateRewardUIInfo()方法:", debug.traceback())
    return
  end
  Log.exception("Review_DuplicateRewardUIInfo()方法必须重写：", debug.traceback())
end

function UIHauteCoutureDataBase:ReqDetailInfo(TT, res)
  if not res then
    res = AsyncRequestRes:New()
    res:SetSucc(false)
  end
  local module = GameGlobal.GetModule(CampaignModule)
  local campType, cmpIDs
  if self:IsReview() then
    campType = ECampaignType.CAMPAIGN_TYPE_SENIOR_SKIN_COPY
  else
    campType = ECampaignType.CAMPAIGN_TYPE_SENIOR_SKIN
  end
  self._campaign = UIActivityCampaign:New()
  self._campaign:LoadCampaignInfo(TT, res, campType)
  if res and not res:GetSucc() then
    module:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return nil
  end
  self._campaign:ReLoadCampaignInfo_Force(TT, res)
  if res and not res:GetSucc() then
    module:CheckErrorCode(res.m_result, self._campaign._id, nil, nil)
    return nil
  end
  self._buyGiftCmp = nil
  self._seniorSkinCmp = nil
  if self:IsReview() then
    self._buyGiftCmp = self._campaign:GetComponentByType(ECampaignSeniorSkinCopyComponentID.ECAMPAIGN_COPY_BUY_GIFT)
  else
    self._buyGiftCmp = self._campaign:GetComponentByType(ECampaignSeniorSkinComponentID.ECAMPAIGN_BUY_GIFT)
  end
  return self._campaign
end

function UIHauteCoutureDataBase:MinDrawCount()
  return 5
end

function UIHauteCoutureDataBase:CampaignID()
  return self._id
end

function UIHauteCoutureDataBase:GetBgm()
  return CriAudioIDConst.BGSeniorSkin
end

function UIHauteCoutureDataBase:SpecailAwardIdx()
  return 10
end

function UIHauteCoutureDataBase:GetBuyGiftCmp()
  if not self._campaign then
    Log.exception("必须先调用ReqDetailInfo()请求详细数据，才能调用GetBuyGiftCmp()。", debug.traceback())
    return nil
  end
  if self:IsReview() then
    return self._campaign:GetComponent(ECampaignSeniorSkinCopyComponentID.ECAMPAIGN_COPY_BUY_GIFT)
  else
    return self._campaign:GetComponent(ECampaignSeniorSkinComponentID.ECAMPAIGN_BUY_GIFT)
  end
end

function UIHauteCoutureDataBase:GetSeniorSkinCmp()
  if not self._campaign then
    Log.exception("必须先调用ReqDetailInfo()请求详细数据，才能调用GetSeniorSkinCmp()。", debug.traceback())
    return nil
  end
  if self:IsReview() then
    return self._campaign:GetComponent(ECampaignSeniorSkinCopyComponentID.ECAMPAIGN_COPY_SENIOR_SKIN)
  else
    return self._campaign:GetComponent(ECampaignSeniorSkinComponentID.ECAMPAIGN_SENIOR_SKIN)
  end
end

function UIHauteCoutureDataBase:GetPrizeCfgs()
  if not self._cfg_prizes then
    local cmpID = self:GetSeniorSkinCmp():GetComponentCfgId()
    self._cfg_prizes = Cfg.cfg_component_senior_skin_weight({ComponentID = cmpID})
    if not self._cfg_prizes or not next(self._cfg_prizes) then
      Log.exception("[HauteCouture] cfg_component_senior_skin_weight中缺少配置:", cmpID)
    end
    table.sort(self._cfg_prizes, function(a, b)
      return a.RewardSortOrder > b.RewardSortOrder
    end)
  end
  return self._cfg_prizes
end

function UIHauteCoutureDataBase:GetUICampaign()
  return self._campaign
end

function UIHauteCoutureDataBase:GetSeniorSkinCfg()
  if not self._cfg_senior_skin then
    local cmpID = self:GetSeniorSkinCmp():GetComponentCfgId()
    local cfgs = Cfg.cfg_senior_skin_draw({ComponentId = cmpID})
    if not cfgs or not next(cfgs) then
      Log.exception("[HauteCouture] cfg_senior_skin_draw中缺少配置:", cmpID)
    end
    self._cfg_senior_skin = cfgs[1]
  end
  return self._cfg_senior_skin
end
