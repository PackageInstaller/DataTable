local MFlashMsg = require("uicontrols.MFlashMsg")
local MDiaLog = require("uicontrols.MDialog")
local uiData = {
  csbFile = "ui/carbon/NewBattleResultLayer.csb",
  mask = true,
  popup = true,
  widgets = {touch = "touch"}
}
local signInText = {
  [1] = {
    name = "姓名",
    desc = "",
    key = "name",
    longth = 20
  },
  [2] = {
    name = "身份证号",
    desc = "18位",
    key = "pid",
    longth = 20
  }
}
local SignAuthLayer = class("SignAuthLayer", UIBase)

function SignAuthLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function SignAuthLayer:init(params)
  self.params = {}
  self.dalteX = 0
  self.callback = params.callback or function()
  end
  if UIHelper.isiPhoneX() then
    self.delteX = UIHelper.getMoveXForX()
    UIHelper.fitForiPhoneX(self.touch)
  end
  self.mainBg = UIHelper.newImageView("ui/sign/signIn/auth_bg.png"):pos(568 - self.dalteX, 330):addTo(self.touch)
  
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
  
  local btnUp = UIHelper.extend(ccui.Button:create())
  btnUp:setImages("ui/global/", {
    "dialog_cancel.png",
    "dialog_cancel.png"
  })
  btnUp:pos(333, 35):addTo(self.mainBg)
  btnUp:setTouchScale()
  btnUp:setCallback(function()
    if not self.params.name then
      MFlashMsg:show({
        text = "姓名不能为空"
      })
      return
    elseif not self.params.pid then
      MFlashMsg:show({
        text = "身份证号不能为空"
      })
      return
    end
    local url = "http://cuisine.zhaolugame.com:7001/authentication?"
    url = url .. string.format("account=%s&name=%s&pid=%s&v=1", string.urlencode(encodeBase64(jiami(game.account))), string.urlencode(encodeBase64(jiami(self.params.name))), string.urlencode(encodeBase64(jiami(self.params.pid))))
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
      self:close()
    end)
    xhr:send()
  end)
  display.newTTFLabel({text = "认证", size = 24}):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(70, 23):addTo(btnUp)
  self:initUI()
end

function SignAuthLayer:initUI()
  local xpos, ypos = 380, 145
  for idx, data in ipairs(signInText) do
    local bg = UIHelper.newImageView("ui/sign/signIn/code_bg.png"):pos(xpos, ypos):addTo(self.mainBg)
    local had = UserData[data.key]
    self.params[data.key] = had
    local text = display.newTTFLabel({
      text = had or data.name .. data.desc,
      size = 24,
      color = UIHelper.hex2rgb("#b9957a")
    }):center(bg):addTo(bg)
    bg:setCallback(function()
      local layer = game:createView("common.InputLayer", {
        longth = data.longth,
        content = self.params[data.key],
        callback = function(str)
          text:setString(str)
          self.params[data.key] = str
          BackManager:pop()
        end
      })
      BackManager:push(function()
        layer:close()
      end)
    end)
    ypos = ypos - 55
  end
  local btnClose = UIHelper.extend(ccui.Button:create())
  btnClose:setImages("ui/activity/66/", {
    "btn_close.png",
    "btn_close.png"
  })
  btnClose:pos(626, 493):addTo(self.mainBg):setTouchScale()
  btnClose:setCallback(function()
    self.callback()
    self:close()
  end)
  local btnClose1 = UIHelper.extend(ccui.Button:create())
  btnClose1:setImages("ui/activity/66/", {
    "btn_close.png",
    "btn_close.png"
  })
  btnClose1:pos(626, 40):addTo(self.mainBg):setTouchScale()
  btnClose1:setCallback(function()
    self.callback()
    self:close()
  end)
end

return SignAuthLayer
