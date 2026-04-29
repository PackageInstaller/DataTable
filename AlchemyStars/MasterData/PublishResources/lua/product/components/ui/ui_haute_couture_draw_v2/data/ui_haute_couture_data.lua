_class("UIHauteCoutureData", Object)
UIHauteCoutureData = UIHauteCoutureData

function UIHauteCoutureData:Constructor()
  self.hauteCouture = {
    [1038] = UIHauteCoutureKR,
    [1041] = UIHauteCoutureBLH,
    [1048] = UIHauteCoutureQT,
    [1114] = UIHauteCouturePLM,
    END = nil
  }
  self.hauteCoutureReview = {
    [1040] = UIHauteCoutureKL_Review,
    [1086] = UIHauteCoutureGL_Review,
    [1124] = UIHauteCoutureGL_Review_Review,
    [1051] = UIHauteCoutureKR_Review,
    [1111] = UIHauteCoutureBLH_Review,
    [1122] = UIHauteCoutureKL_Review_Review,
    [1155] = UIHauteCoutureQTReview,
    [1133] = UIHauteCoutureBLH_Review2,
    [3004] = UIHauteCouturePLM_Review,
    END = nil
  }
  self:RefreshCurInfo()
end

function UIHauteCoutureData:GetCurHauteCouture()
  return self._curHauteCouture
end

function UIHauteCoutureData:GetCurHauteCoutureReview()
  return self._curReviewHauteCouture
end

function UIHauteCoutureData:RefreshCurInfo()
  local module = GameGlobal.GetModule(CampaignModule)
  local campSample = module:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_SENIOR_SKIN)
  if campSample then
    local id = campSample.id
    if not self._curHauteCouture or self._curHauteCouture:CampaignID() ~= id then
      if self.hauteCouture[id] then
        self._curHauteCouture = self.hauteCouture[id]:New(id)
        Log.info("[HauteCouture] 更新高级时装数据:", id)
      else
        Log.exception("[HauteCouture] 高级时装活动未注册:", id)
      end
    else
      Log.info("[HauteCouture] 高级时装数据不用更新:", id)
    end
  else
    if self._curHauteCouture ~= nil then
      self._curHauteCouture = nil
      Log.info("[HauteCouture] 当前没有开放中的高级时装活动,将数据置空")
    end
    Log.info("[HauteCouture] 当前没有开放中的高级时装活动")
  end
  local campReviewSample = module:GetSampleByType(ECampaignType.CAMPAIGN_TYPE_SENIOR_SKIN_COPY)
  if campReviewSample then
    local id = campReviewSample.id
    if not self._curReviewHauteCouture or self._curReviewHauteCouture:CampaignID() ~= id then
      if self.hauteCoutureReview[id] then
        self._curReviewHauteCouture = self.hauteCoutureReview[id]:New(id)
        Log.info("[HauteCouture] 更新高级时装复刻数据:", id)
      else
        Log.exception("[HauteCouture] 高级时装复刻活动未注册:", id)
      end
    else
      Log.info("[HauteCouture] 高级时装复刻数据不用更新:", id)
    end
  else
    if self._curReviewHauteCouture ~= nil then
      self._curReviewHauteCouture = nil
      Log.info("[HauteCouture] 当前没有开放中的高级复刻时装活动,将数据置空")
    end
    Log.info("[HauteCouture] 当前没有开放中的高级时装复刻活动")
  end
end
