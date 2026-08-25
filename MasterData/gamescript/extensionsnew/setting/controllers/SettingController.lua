local SettingController = NewClass("SettingController", BaseController)

function SettingController:OnInit()
end

function SettingController:OnReset()
end

function SettingController:OnOpenSettingMainView()
  UIManager.Instance:Reopen(Urls.SettingMainPanel)
end

function SettingController:OnOpenRedemptionCodeView()
  UIManager.Instance:Reopen(Urls.SettingRedemptionCodePanel)
end

function SettingController:ReqUseActiveCode(code, onFinish)
  ProtoManager.Instance:ReqServer("GameRequest", "UseActiveCode", nil, function(_, retCode)
    local id = retCode.code
    local isSuccessful = 200 == id
    local languageKey = "RedemptionTips_" .. id
    local showStr = LT.Text("RedemptionTips_other")
    if DT.LanguageConfig[languageKey] then
      showStr = LT.Text(languageKey)
    end
    Alert.ShowStr(showStr)
    if onFinish then
      onFinish(isSuccessful)
    end
  end, code)
end

function SettingController:ReqChangeLanguage(code)
  ProtoManager.Instance:ReqServer("SettingRequest", "ReqChangeLanguage", function(data)
    Logger.Info("========== 通知服务器修改语言成功 ==========\n", table.tostring(data or {}))
  end, function(data)
    Logger.Info("========== 通知服务器修改语言失败 ==========\n", table.tostring(data or {}))
  end, code)
end

function SettingController:ReqGetOSLoginReward(loginRewardType)
  ProtoManager.Instance:ReqServer("SettingRequest", "ReqGetOSLoginReward", function(data)
    Logger.Info("========== SettingRequest ReqGetOSLoginReward success ==========\n", table.tostring(data or {}))
    local statsType = SettingDefine.LoginRewardType2StatsTypeDict[loginRewardType]
    PlayerDataUtils.SetBaseStatsData(statsType, 1)
    self:Notify(NotifyId.OnSettingBindRewardStateChanged)
  end, function(data)
    Logger.Info("========== SettingRequest ReqGetOSLoginReward failed ==========\n", table.tostring(data or {}))
  end, loginRewardType)
end

return SettingController
