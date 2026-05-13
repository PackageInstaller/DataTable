local MFlashMsg = require("uicontrols.MFlashMsg")
local MDiaLog = require("uicontrols.MDialog")
local crypto = require(cc.PACKAGE_NAME .. ".crypto")
local uiData = {
  csbFile = "ui/carbon/NewBattleResultLayer.csb",
  mask = true,
  popup = true,
  widgets = {touch = "touch"}
}
local signInText = {
  [1] = {
    name = "手机号",
    desc = "11位",
    key = "account",
    longth = 20
  },
  [2] = {
    name = "密码",
    desc = "8~18位",
    key = "passwd",
    longth = 20
  }
}
local SignInLayer = class("SignInLayer", UIBase)

function SignInLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function SignInLayer:init(params)
  self.params = {}
  self.dalteX = 0
  self.callback = params.callback or function()
  end
  if UIHelper.isiPhoneX() then
    self.delteX = UIHelper.getMoveXForX()
    UIHelper.fitForiPhoneX(self.touch)
  end
  self.mainBg = UIHelper.newImageView("ui/sign/signIn/main_bg.png"):pos(568 - self.dalteX, 330):addTo(self.touch)
  local btnLogin = UIHelper.extend(ccui.Button:create())
  btnLogin:setImages("ui/sign/signIn/", {
    "login_btn.png",
    "login_btn.png"
  })
  btnLogin:pos(333, 100):addTo(self.mainBg)
  btnLogin:setTouchScale()
  btnLogin:setCallback(function()
    print("sign.SignUpLayer 1")
    self:checkParams()
    print("sign.SignUpLayer 111")
  end)
  local btnUp = UIHelper.extend(ccui.Button:create())
  btnUp:setImages("ui/sign/signIn/", {
    "zhaolu_btn.png",
    "zhaolu_btn.png"
  })
  btnUp:pos(513, 45):addTo(self.mainBg)
  btnUp:setTouchScale()
  btnUp:setCallback(function()
    game:createView("sign.SignUpLayer")
  end)
  self:initUI()
end

function SignInLayer:initUI()
  local xpos, ypos = 360, 240
  local delay = 0
  for idx, data in ipairs(signInText) do
    local path = idx == 1 and "account_bg.png" or "code_bg.png"
    local bg = UIHelper.newImageView("ui/sign/signIn/" .. path):pos(xpos, ypos):addTo(self.mainBg)
    local had = UserData[data.key]
    self.params[data.key] = had
    local text = display.newTTFLabel({
      text = had or data.name .. data.desc,
      size = 24,
      color = UIHelper.hex2rgb("#b9957a")
    }):center(bg):addTo(bg)
    if data.key == "passwd" and had then
      text:setString("......")
    end
    bg:setCallback(function()
      local layer = game:createView("common.InputLayer", {
        longth = data.longth,
        content = self.params[data.key],
        callback = function(str)
          if data.key == "passwd" then
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
    self:animation(bg, delay)
    ypos = ypos - 80
    delay = delay + 0.1
  end
  local btnClose = UIHelper.extend(ccui.Button:create())
  btnClose:setImages("ui/activity/66/", {
    "btn_close.png",
    "btn_close.png"
  })
  btnClose:pos(626, 331):addTo(self.mainBg):setTouchScale()
  btnClose:setCallback(function()
    self:close()
  end)
end

function SignInLayer:getDeviceId()
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

function SignInLayer:sendRequest(visit)
  print("sign.SignUpLayer 10")
  local deviceid = self:getDeviceId()
  local url
  
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
  
  if visit then
    url = string.format("http://cuisine.zhaolugame.com:7001/visit?deviceid=%s", deviceid)
  else
    url = string.format("http://cuisine.zhaolugame.com:7001/signin?phone=%s&passwd=%s&device=%s&deviceid=%s&v=1", string.urlencode(encodeBase64(jiami(self.params.account))), string.urlencode(encodeBase64(jiami(self.params.passwd))), device.platform, string.urlencode(encodeBase64(jiami(deviceid))))
    print("sign.SignUpLayer 11")
    print(">>>>>", url)
  end
  print("sign.SignUpLayer 12")
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
    print("登录朝露account signInfo " .. xhr.response)
    game.account = jsonResult.account
    game.phone = jsonResult.phone
    if not jsonResult.visit and jsonResult.age == 0 then
      game:createView("sign.SignAuthLayer", {
        callback = function()
          self.callback(jsonResult)
          self:close()
        end
      })
      return
    end
    self.callback(jsonResult)
    self:close()
  end)
  print("sign.SignUpLayer 13")
  xhr:send()
end

function SignInLayer:checkParams()
  print("sign.SignUpLayer 11")
  if not self:checkAccount() then
    return
  end
  if not self:checkPasswd() then
    return
  end
  print("sign.SignUpLayer 2")
  UserData.account = self.params.account
  UserData.passwd = self.params.passwd
  print("sign.SignUpLayer 5")
  GameState.save(UserData)
  print("sign.SignUpLayer 6")
  self:sendRequest()
  print("sign.SignUpLayer 7")
end

function SignInLayer:checkAccount()
  local account = self.params.account
  if not account or #account ~= 11 or string.match(account, "(%d+)") ~= account then
    MFlashMsg:show({
      text = "手机号错误"
    })
    return
  end
  return true
end

function SignInLayer:animation(node, delay)
  node:setCascadeOpacityEnabled(true)
  node:setOpacity(0)
  node:runAction(transition.sequence({
    cc.DelayTime:create(delay),
    cc.Spawn:create(cc.FadeIn:create(0.1), cc.MoveBy:create(0.1, cc.p(0, 5)))
  }))
end

function SignInLayer:checkPasswd()
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

return SignInLayer
