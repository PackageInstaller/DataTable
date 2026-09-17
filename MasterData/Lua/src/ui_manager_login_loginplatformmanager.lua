local manager = class("loginPlatformManager")

function manager:openNetWorkMask(oprnNum, descStr)
  L_GameUtil.httpMask(true, descStr)
end

function manager:closeNetWorkMask(oprnNum, descStr)
  L_GameUtil.httpMask(false, descStr)
end

function manager:showAgreementInfo(agreeType, callback)
  if C_AppConfigManager.Platform == C_EAppPlatform.Harmony then
    C_MJSDKManager.GetAgreement(agreeType, function(agreeInfo)
      if agreeInfo then
        local onClose
        if callback then
          function onClose()
            callback()
          end
        end
        CS.Lens.Gameplay.UI.WebView.WebViewManager.OpenCommonWebOH(agreeInfo.webPageUrl, onClose)
      end
    end)
    return
  end
  local agreeInfo = C_MJSDKManager.GetAgreement(agreeType)
  local resolutionVal = 0.7
  if agreeInfo then
    local data = {
      url = agreeInfo.webPageUrl,
      title = agreeInfo.title,
      callback = callback,
      resolution = resolutionVal
    }
    L_UI:open("pageCommonWeb", data)
  end
end

function manager:showUserCenter()
  if C_AppConfigManager.Platform == C_EAppPlatform.Harmony then
    C_MJSDKManager.ShowUserCenter(function(_)
    end)
    return
  end
  C_MJSDKManager.ShowUserCenter()
end

function manager:haveUserCenter()
  if C_AppConfigManager.Platform == C_EAppPlatform.Harmony then
    return false
  end
  return C_MJSDKManager.HaveUserCenter()
end

function manager:haveUserCenterAsync(callback)
  if C_AppConfigManager.Platform == C_EAppPlatform.Harmony then
    C_MJSDKManager.HaveUserCenter(callback)
    return
  end
  if callback then
    callback(C_MJSDKManager.HaveUserCenter())
  end
end

function manager:closeAccount()
  C_MJSDKManager.CloseAccount()
end

function manager:hasCustomer()
  if C_AppConfigManager.Platform == C_EAppPlatform.Harmony then
    return false
  end
  return C_MJSDKManager.HaveCustomer()
end

function manager:hasCustomerAsync(callback)
  if C_AppConfigManager.Platform == C_EAppPlatform.Harmony then
    C_MJSDKManager.HaveCustomer(callback)
    return
  end
  if callback then
    callback(C_MJSDKManager.HaveCustomer())
  end
end

function manager:showCustomer()
  if C_AppConfigManager.Platform == C_EAppPlatform.Harmony then
    C_MJSDKManager.ShowCustomer(function(_)
    end)
    return
  end
  return C_MJSDKManager.ShowCustomer()
end

function manager:convertHtmlTag(str)
  if not str then
    return nil
  end
  str = string.gsub(str, "<p>", "")
  str = string.gsub(str, "</p>", "\n")
  str = string.gsub(str, "<br>", "\n")
  str = string.gsub(str, "style=\"color: rgb%((%d+), (%d+), (%d+)%);\"", function(s1, s2, s3)
    local color = C_Color(tonumber(s1) / 255, tonumber(s2) / 255, tonumber(s3) / 255)
    return "color=#" .. C_ColorUtility.ToHtmlStringRGB(color)
  end)
  local taggedText = C_TextMarkupParser.Parse(str)
  if taggedText == nil or taggedText.words == nil then
    return nil
  end
  local result = ""
  for _, word in pairs(taggedText.words) do
    local text = word.text
    if not string.isEmpty(text) then
      local tagList = word.data
      if tagList and tagList.Count > 0 then
        for _, tagData in pairs(tagList) do
          local tagName = tagData.name
          local tagParams = tagData.pms
          if tagParams and tagParams.Count > 0 then
            for pk, pv in pairs(tagParams) do
              if pk == "color" then
                text = string.format("<color=%s>%s</color>", pv, text)
              end
            end
          end
          if tagName == "strong" then
            text = string.format("<b>%s</b>", text)
          elseif tagName == "em" then
            text = string.format("<i>%s</i>", text)
          elseif tagName == "u" then
            text = string.format("<u>%s</u>", text)
          end
        end
      end
      result = result .. text
    end
  end
  return result
end

return manager
