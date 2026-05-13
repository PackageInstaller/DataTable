local MDiaLog = require("uicontrols.MDialog")
local uiData = {
  csbFile = "ui/login/ActivationLayer.csb",
  mask = true,
  widgets = {okBtn = "okBtn", input = "input"}
}
local ActivationLayer = class("ActivationLayer", UIBase)

function ActivationLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ActivationLayer:init(params)
  local sdkInterface = params.sdk
  self.okBtn:setCallback(function()
    local text = self.input:getString()
    text = string.upper(text)
    if text == "" then
      return
    end
    local uname = string.gsub(string.trim(text), "([^%w ])", function(c)
      return string.format("%%%02X", string.byte(c))
    end)
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr:open("GET", sdkInterface:getLoginUrl({token = uname}))
    xhr:registerScriptHandler(function()
      if xhr.status ~= 200 then
        return
      end
      if tolua.isnull(self) then
        return
      end
      local jsonResult = json.decode(xhr.response)
      if jsonResult.errorCode == 1 then
        MFlashMsg:show({
          text = "此激活码不可用"
        })
      end
      if jsonResult.errorCode == 2 then
        MFlashMsg:show({
          text = "此激活码已经被其他人使用了"
        })
      end
      if jsonResult.errorCode == 100 then
        MDiaLog:single({
          text = jsonResult.errorMsg
        }, function()
          sharedDirector:endToLua()
        end)
      end
      if jsonResult.errorCode ~= 0 then
        return
      end
      game.platform_uid = jsonResult.userid
      game.platform_sid = jsonResult.sid
      local serverList = jsonResult.serverList
      local noticeUrl = string.gsub(jsonResult.noticeUrl, "%%(%x%x)", function(hex)
        return string.char(tonumber(hex, 16))
      end)
      UserData.user = uname
      GameState.save(UserData)
      if params.callback then
        params.callback(serverList, noticeUrl)
      end
      self:removeSelf()
    end)
    xhr:send()
  end)
  self.input:addEventListener(function(sender, type)
    if type == ccui.TextFiledEventType.insert_text then
      local text = self.input:getString()
      text = string.upper(text)
      self.input:setString(text)
    end
  end)
end

function ActivationLayer:showData(params)
end

return ActivationLayer
