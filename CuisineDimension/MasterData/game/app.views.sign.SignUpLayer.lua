local MFlashMsg = require("uicontrols.MFlashMsg")
local MDiaLog = require("uicontrols.MDialog")
local crypto = require(cc.PACKAGE_NAME .. ".crypto")
local json = require(cc.PACKAGE_NAME .. ".json")
local uiData = {
  csbFile = "ui/sign/SignUpLayer.csb",
  mask = true,
  popup = true,
  widgets = {
    mainbg = "mainbg",
    btn_confirm = "mainbg/btn_confirm",
    btn_send = "mainbg/btn_send",
    leftTimeText = "mainbg/leftTimeText",
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
  self.leftTimeText:hide()
  self.signUpUI(self)
  self.btn_confirm:setTouchScale()
  self.btn_confirm:setCallback(function()
    self:checkParams()
  end)
  self.btn_close:setCallback(function()
    self:close()
  end)
  
  local function setTime(endTime)
    local leftTime = endTime - os.time()
    if 0 <= leftTime then
      self.leftTimeText:show()
      self.leftTimeText:setString(string.format("请等待(%s)", leftTime))
      self.leftTimeText:runAction(transition.sequence({
        cc.DelayTime:create(1),
        cc.CallFunc:create(function()
          setTime(endTime)
        end)
      }))
    else
      cc.UserDefault:getInstance():setIntegerForKey("SignUpEndTime", 0)
      self.btn_send:show()
      self.btn_send:setTouchEnabled(true)
      self.leftTimeText:hide()
    end
  end
  
  local endTime = cc.UserDefault:getInstance():getIntegerForKey("SignUpEndTime", 0)
  if endTime ~= 0 then
    self.btn_send:setTouchEnabled(false)
    self.btn_send:hide()
    setTime(endTime)
  end
  self.btn_send:setTouchScale()
  self.btn_send:setCallback(function()
    if not self:checkAccount() then
      return
    end
    endTime = os.time() + 60
    cc.UserDefault:getInstance():setIntegerForKey("SignUpEndTime", os.time() + 60)
    self:sendRequest(true)
    self.btn_send:setTouchEnabled(false)
    self.btn_send:hide()
    setTime(endTime)
  end)
  self.btn_info:hide()
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

function SignUpNewLayer:encode(secret)
  local pase = 10
  local long = math.floor(#secret / pase)
  local temp = {}
  for i = 1, pase - 1 do
    local str = string.sub(secret, (i - 1) * long + 1, i * long)
    table.insert(temp, str)
  end
  local str = string.sub(secret, (pase - 1) * long + 1, #secret)
  table.insert(temp, str)
  local middle = #temp / 2
  for i = 2, middle do
    local line = temp[i]
    temp[i] = temp[pase - i + 1]
    temp[pase - i + 1] = line
  end
  for i = 2, middle do
    local line = temp[i]
    temp[i] = temp[middle + i - 1]
    temp[middle + i - 1] = line
  end
  return table.concat(temp)
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
  local url = "http://cuisine.zhaolugame.com:7001/"
  local deviceid = self:getDeviceId()
  
  local function jiami(str)
    str = "zhaolu" .. str
    local length = string.len(str)
    local temp = ""
    for i = 1, length do
      local ascii = string.byte(str, i)
      if 48 <= ascii and ascii <= 57 or 65 <= ascii and ascii <= 90 or 97 <= ascii and ascii <= 122 then
        local tempAscii
        if ascii <= 57 then
          tempAscii = ascii - 48
        elseif ascii <= 90 then
          tempAscii = ascii - 55
        elseif ascii <= 122 then
          tempAscii = ascii - 61
        end
        tempAscii = tempAscii + i
        tempAscii = tempAscii % 62
        if tempAscii <= 9 then
          tempAscii = tempAscii + 48
        elseif tempAscii <= 35 then
          tempAscii = tempAscii + 55
        elseif tempAscii <= 61 then
          tempAscii = tempAscii + 61
        end
        temp = temp .. string.char(tempAscii)
      else
        temp = temp .. string.char(ascii)
      end
    end
    return string.reverse(temp)
  end
  
  local function encodeBase64(source_str)
    local b64chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    local s64 = ""
    local str = source_str
    while 0 < #str do
      local bytes_num = 0
      local buf = 0
      for byte_cnt = 1, 3 do
        buf = buf * 256
        if 0 < #str then
          buf = buf + string.byte(str, 1, 1)
          str = string.sub(str, 2)
          bytes_num = bytes_num + 1
        end
      end
      for group_cnt = 1, bytes_num + 1 do
        local b64char = math.fmod(math.floor(buf / 262144), 64) + 1
        s64 = s64 .. string.sub(b64chars, b64char, b64char)
        buf = buf * 64
      end
      for fill_cnt = 1, 3 - bytes_num do
        s64 = s64 .. "="
      end
    end
    return s64
  end
  
  if code then
    local args = {
      phone = self.params.account,
      time = os.time() + 1,
      device = deviceid,
      random = math.randomFloat(0, 1)
    }
    local str = ""
    for _, key in ipairs({
      "phone",
      "time",
      "device",
      "random"
    }) do
      str = str .. string.format("%s=%s#", key, args[key])
    end
    str = str .. "eyJwaG9uZSI6IjE3MjAwMzQ1NzkzIiwiZGV2aWNlIjoiOWViZmYzYTZkYTkwZTQyYjdkODE1NDQyMTA3ZWVjNTlkNjc5Mzg3MyIsInRpbWUiOjE2MDgwMTMxMDEsIm1kNSI6ImEwYmNmMmZjMjk3YmU3ZTdjYzc0OGQxMWY3ZDRhYzA3In0"
    local md5 = crypto.md5(str)
    args.md5 = self:encode(md5)
    url = "http://cuisine.zhaolugame.com:7001/" .. string.format("authcode?body=%s", self:encode(ZZBase64.encode(json.encode(args))))
  else
    url = url .. string.format("account?phone=%s&passwd=%s&uid=%s&code=%s&v=1", string.urlencode(encodeBase64(jiami(self.params.account))), string.urlencode(encodeBase64(jiami(self.params.passwd))), string.urlencode(encodeBase64(jiami(game.platform_uid or ""))), string.urlencode(encodeBase64(jiami(self.params.code))))
    url = url .. string.format("&deviceid=%s", string.urlencode(encodeBase64(jiami(deviceid))))
  end
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
