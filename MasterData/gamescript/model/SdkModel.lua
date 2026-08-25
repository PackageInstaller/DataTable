local function createSdkModelState()
  local state = {}
  
  state.uid = ""
  state.pid = ""
  state.tipAgeText = ""
  state.tipIconUrl = nil
  state.reportData = nil
  state.payProducts = {}
  state.packageChannel = CommonDefine.PackageChannel.CN
  state.finishSurveyMap = {}
  state.machineCPUScore = nil
  state.machineGPUScore = nil
  state.channelPackageMap = {
    [CommonDefine.SdkPublishArea.tw] = CommonDefine.PackageChannel.TW,
    [CommonDefine.SdkPublishArea.hk] = CommonDefine.PackageChannel.HK,
    [CommonDefine.SdkPublishArea.global] = CommonDefine.PackageChannel.HK
  }
  state.countryCode = CommonDefine.CountryCode.CN
  return state
end

local function createSdkModelViews(_)
  local views = {}
  
  function views:IsSurveyFinish(surveyId)
    return self.finishSurveyMap[surveyId]
  end
  
  function views:HasEmail()
    return self.hasEmail
  end
  
  function views:HasMobile()
    return self.hasMobile
  end
  
  return views
end

local function createSdkModelActions(data)
  local actions = {}
  
  function actions:SetUid(uid)
    data.uid = uid
  end
  
  function actions:SetPid(pid)
    data.pid = pid
  end
  
  function actions:SetUserInfoState(hasEmail, hasMobile)
    data.hasEmail = hasEmail
    data.hasMobile = hasMobile
  end
  
  function actions:ResetPid()
    data.pid = nil
  end
  
  function actions:SetMachineCPUScore(val)
    if not val then
      return
    end
    data.machineCPUScore = tonumber(val)
  end
  
  function actions:SetMachineGPUScore(val)
    if not val then
      return
    end
    data.machineGPUScore = tonumber(val)
  end
  
  function actions:SetPackageChannel(val)
    if not val then
      Logger.Info("Error PackageChannel")
      return
    end
    Logger.Info("Set PackageChannel val ", val)
    data.packageChannel = data.channelPackageMap[val] or CommonDefine.PackageChannel.CN
    Logger.Info("IsJPChargeOpen", ZoneFeatureUtils.IsZoneFeatureOpen(CommonDefine.ZoneFeature.JPCharge))
    if ZoneFeatureUtils.IsZoneFeatureOpen(CommonDefine.ZoneFeature.JPCharge) then
      if ApplicationUtils.IsIOS() then
        Logger.Info("Set JP AppleChannel as ios", DT.GetConstant("JPAppleChannel"))
        data.packageChannel = DT.GetConstant("JPAppleChannel")
      elseif ApplicationUtils.IsAndroid() then
        Logger.Info("Set JP GoogleChannel as android", DT.GetConstant("JPGoogleChannel"))
        data.packageChannel = DT.GetConstant("JPGoogleChannel")
      else
        Logger.Info("Set JP GoogleChannel as other platform")
        data.packageChannel = DT.GetConstant("JPGoogleChannel")
      end
    end
    if SdkMgr.Instance:IsXiao7() then
      data.packageChannel = CommonDefine.PackageChannel.XIAO_7
    end
    Logger.Info("Set PackageChannel Final Value", data.packageChannel)
  end
  
  function actions:SetCountryCode(val)
    Logger.Info("Set CountryCode val", val)
    data.countryCode = CommonDefine.CountryCode[val] or CommonDefine.CountryCode.US
  end
  
  function actions:SetTipAgeText(tipText)
    if not tipText then
      return
    end
    data.tipAgeText = tipText
  end
  
  function actions:SetTipAgeIconUrl(iconUrl)
    if not iconUrl then
      return
    end
    data.tipIconUrl = iconUrl
  end
  
  function actions:AddToFinishSurvey(surveyId)
    self.finishSurveyMap[surveyId] = true
  end
  
  function actions.SetPayProducts(tblData)
    if not tblData then
      return
    end
    data.payProducts = tblData
  end
  
  function actions.SetReportData(tblData)
    if not tblData then
      return
    end
    data.reportData = tblData
  end
  
  return actions
end

local function onSetup(_, _)
end

local SdkModel = Vue.model("SdkModel", createSdkModelState):views(createSdkModelViews):actions(createSdkModelActions):setup(onSetup)
return SdkModel
