local MFlashMsg = require("uicontrols.MFlashMsg")
local MDiaLog = require("uicontrols.MDialog")
local uiData = {
  csbFile = "ui/sign/SignUpLayer.csb",
  mask = true,
  popup = true,
  widgets = {
    mainbg = "mainbg",
    btn_confirm = "mainbg/btn_confirm",
    btn_send = "mainbg/btn_send",
    btn_pcdclick = "mainbg/btn_pcdclick",
    btn_passcode = "mainbg/btn_passcode",
    btn_message = "mainbg/btn_message",
    btn_account = "mainbg/btn_account",
    btn_info = "mainbg/btn_info",
    btn_close = "mainbg/btn_close"
  }
}
local signUpText = {
  [1] = {
    name = "手机号",
    desc = "11位",
    key = "account",
    longth = 11
  },
  [2] = {
    name = "密码",
    desc = "8~18位(数字大小写字母)",
    key = "passwd1",
    longth = 18
  },
  [3] = {
    name = "确认密码",
    desc = "",
    key = "passwd2",
    longth = 18
  },
  [4] = {
    name = "验证码",
    desc = "",
    key = "code",
    longth = 10
  }
}
local SignUpNewLayer = class("SignUpNewLayer", UIBase)

function SignUpNewLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function SignUpNewLayer:init(params)
  self.dalteX = 0
  if UIHelper.isiPhoneX() then
    self.dalteX = UIHelper.getMoveXForX()
    UIHelper.fitForiPhoneX(self.mainbg)
  end
  self:refreshUI()
end

function SignUpNewLayer:refreshUI()
  self.params = {}
  self.signUpUI(self)
  self.btn_confirm:setCallback(function()
    self:checkParams()
  end)
  self.btn_close:setCallback(function()
    self:close()
  end)
  self.btn_send:setCallback(function()
    if not self:checkAccount() then
      return
    end
    self:sendRequest(true)
    self.btn_send:setTouchEnabled(false)
    local endTime = game:nowTime() + 120
    
    local function setTime()
      local leftTime = endTime - game:nowTime()
      if 0 <= leftTime then
        label:setString(string.format("请等待(%s)", leftTime))
        label:runAction(transition.sequence({
          cc.DelayTime:create(1),
          cc.CallFunc:create(function()
            setTime()
          end)
        }))
      else
        self.btn_send:setTouchEnabled(true)
      end
    end
    
    setTime()
  end)
  self.btn_info:setCallback(function()
    UIHelper.showOnleImgTip("ui/sign/instruction.png", 1001)
  end)
end

function SignUpNewLayer:signUpUI()
  local btn = {
    self.btn_account,
    self.btn_passcode,
    self.btn_pcdclick,
    self.btn_message
  }
  local delay = 0
  for idx, data in ipairs(signUpText) do
    local text = display.newTTFLabel({
      text = data.name .. data.desc,
      size = 24,
      color = UIHelper.hex2rgb("#b9957a")
    }):center(btn[idx]):addTo(btn[idx])
    btn[idx]:setCallback(function()
      local layer = game:createView("common.InputLayer", {
        longth = 20,
        content = self.params[data.key],
        callback = function(str)
          if data.key == "passwd1" or data.key == "passwd2" then
            text:setString("......")
          else
            text:setString(str)
          end
          self.params[data.key] = str
          BackManager:pop()
        end
      })
      BackManager:push(function()
        layer:close()
      end)
    end)
    self:animation(btn[idx], delay)
  end
end

function SignUpNewLayer:getDeviceId()
  if UserData.deviceId then
    return UserData.deviceId
  end
  
  function randomId()
    local time = os.time() + 28800
    local timeTab = os.date("!*t", time)
    local timeStr = string.format("%d%02d%02d", timeTab.year, timeTab.month, timeTab.day)
    local secret = crypto.md5(math.randomFloat(0, 1))
    local id = string.format("%s%s", timeStr, secret)
    UserData.deviceId = id
    GameState.save(UserData)
    return id
  end
  
  return randomId()
end

function SignUpNewLayer:sendRequest(code)
  local url = "http://llcy.appget.cn/"
  if code then
    url = url .. string.format("code?phone=%s", self.params.account)
  else
    url = url .. string.format("account?phone=%s&passwd=%s&uid=%s&code=%s", self.params.account, self.params.passwd, game.platform_uid or "", self.params.code)
  end
  local deviceid = self:getDeviceId()
  deviceid = string.gsub(deviceid, ":", "")
  url = url .. string.format("&deviceid=%s", deviceid)
  local xhr = cc.XMLHttpRequest:new()
  xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
  xhr:open("POST", url)
  xhr:registerScriptHandler(function()
    if xhr.status ~= 200 then
      MDiaLog:single({
        text = "网络连接异常，请检查网络后重新尝试。",
        okText = "重试"
      }, function()
      end)
      return
    end
    local jsonResult = json.decode(xhr.response)
    if jsonResult.errorCode == 100 then
      MDiaLog:single({
        text = jsonResult.errorMsg
      }, function()
      end)
      return
    end
    if jsonResult.errorMsg then
      MFlashMsg:show({
        text = jsonResult.errorMsg
      })
    end
    if code then
      return
    end
    self:close()
  end)
  xhr:send()
end

function SignUpNewLayer:animation(node, delay)
  node:setCascadeOpacityEnabled(true)
  node:setOpacity(0)
  node:runAction(transition.sequence({
    cc.DelayTime:create(delay),
    cc.Spawn:create(cc.FadeIn:create(0.1), cc.MoveBy:create(0.1, cc.p(0, 5)))
  }))
end

function SignUpNewLayer:checkParams()
  if not self:checkAccount() then
    MFlashMsg:show({
      text = "账号格式错误"
    })
    return
  end
  if not self:checkPasswd() then
    MFlashMsg:show({
      text = "密码格式错误"
    })
    return
  end
  if not self:checkCode() then
    MFlashMsg:show({
      text = "验证码错误"
    })
    return
  end
  self:sendRequest()
end

function SignUpNewLayer:checkAccount()
  local account = self.params.account
  if not account or #account ~= 11 or string.match(account, "(%d+)") ~= account then
    MFlashMsg:show({
      text = "手机号错误"
    })
    return
  end
  return true
end

function SignUpNewLayer:checkPasswd()
  if self.params.passwd1 ~= self.params.passwd2 then
    MFlashMsg:show({
      text = "两次密码不一致"
    })
    return
  end
  self.params.passwd = self.params.passwd1
  local passwd = self.params.passwd
  if #passwd < 8 or 18 < #passwd then
    MFlashMsg:show({
      text = "密码长度错误"
    })
    return
  end
  if string.match(passwd, "([0-9a-zA-Z]+)") ~= passwd then
    MFlashMsg:show({
      text = "密码包含特殊字符"
    })
    return
  end
  return true
end

function SignUpNewLayer:checkCode()
  local code = self.params.code
  if not code or code == "" then
    return
  end
  return true
end

return SignUpNewLayer
