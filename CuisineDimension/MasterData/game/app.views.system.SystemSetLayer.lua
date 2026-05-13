local SysRes = "ui/system/"
local HeroRes = "ui/hero/"
local sdkInterface = require("sdk.SDKInterface")
local uiData = {
  csbFile = "ui/system/SystemSetLayer.csb",
  widgets = {
    up = "up",
    touch = "touch",
    mainBg = "mainBg",
    btnList = "btnList",
    btnsBg = "btnsBg",
    content = "content",
    downBar = "downBar"
  }
}
local btnsData = {
  [1] = {
    name = "游戏",
    callback = function(self)
      self:showGameSet()
    end,
    open = function()
      return true
    end
  },
  [2] = {
    name = "推送",
    callback = function(self)
      self:showPushSet()
    end,
    open = function()
      return false
    end
  },
  [3] = {
    name = "音效",
    callback = function(self)
      self:showMusicSetting()
    end,
    open = function()
      return true
    end
  },
  [4] = {
    name = "礼品码",
    callback = function(self)
      self:showGiftCode()
    end,
    open = function()
      return true
    end
  }
}
local images = {
  [0] = "off.png",
  [1] = "on.png"
}
local SystemSetLayer = class("SystemSetLayer", UIBase)

function SystemSetLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function SystemSetLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    UIHelper.fitForiPhoneX(self.touch)
    UIHelper.fitForiPhoneX(self.downBar, true)
    self.btnList:setPositionX(self.btnList:getPositionX() - UIHelper.getMoveXForX() + 50)
    self.btnsBg:setPositionX(self.btnsBg:getPositionX() - UIHelper.getMoveXForX() + 50)
  end
  TopBar:show(TopBarType.full, "设置")
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up
  })
  self.selected = params.selected or 1
  self.touch:setTouchEnabled(true)
  self.touch:setSwallowTouches(true)
  self.needSave = false
  local btnSize = UIHelper.newImageView(HeroRes .. "taocan_1.png"):getContentSize()
  self.group = MRadioGroup:create()
  local delay = 0.4
  for index, data in ipairs(btnsData) do
    local open = data.open()
    if open then
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(btnSize):addTo(self.btnList)
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(HeroRes, {
        "taocan_1.png",
        "taocan_2.png"
      })
      btn:setString({
        text = data.name,
        size = 22,
        color = UIHelper.hex2rgb("#ffffff")
      })
      btn:setCallback(function()
        self.selected = index
        self:showData()
      end)
      btn:center(viewNode):addTo(viewNode)
      btn:setName(string.format("btn%d", index))
      btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#630c07"), 1)
      btn:setGroup(self.group)
      UIHelper.MoveToRight({
        node = btn,
        delay = delay,
        time = 0.2
      })
    end
  end
end

function SystemSetLayer:showData(params)
  self.content:removeAllChildren()
  self.group:chooseByName("btn" .. self.selected)
  btnsData[self.selected].callback(self)
end

local types = {
  [1] = {
    name = "自动补给:",
    type = 1
  },
  [2] = {
    name = "锁定新角色:",
    type = 3
  },
  [3] = {name = "语音包:", type = 11},
  [4] = {
    name = "关闭战斗技能演出:",
    type = 12
  },
  [5] = {
    name = "连续自动战斗:",
    type = 13
  },
  [6] = {
    name = "自动快速治疗:",
    type = 14
  }
}

function SystemSetLayer:showGameSet()
  local mainBg = display.newSprite(SysRes .. "main_bg.png"):pos(0, 0):addTo(self.content)
  local yPos, interval = 420, 40
  for index, data in ipairs(types) do
    display.newTTFLabel({
      text = data.name,
      size = 24,
      color = UIHelper.hex2rgb("#5c2408")
    }):anch(0, 0.5):pos(65, yPos):addTo(mainBg)
    if index <= 6 then
      display.newSprite(SysRes .. "line.png"):anch(0.5, 0.5):pos(390, yPos - 20):addTo(mainBg)
    end
    local slot = data.type
    local btn, callback
    if slot == 11 then
      local state = game.role.autoStatus:getv(slot, 1)
      btn = UIHelper.newImageView(SysRes .. string.format("cv_%d.png", state))
      
      function callback(state)
        btn:setImage(SysRes .. string.format("cv_%d.png", state))
      end
    elseif slot == 12 then
      btn = UIHelper.newImageView(SysRes .. images[UserData.skipSkillAnima or 0])
    elseif slot == 13 then
      btn = UIHelper.newImageView(SysRes .. images[UserData.autoBattleLoop or 0])
    elseif slot == 14 then
      btn = UIHelper.newImageView(SysRes .. images[UserData.autoBattleLoopCure or 0])
    else
      btn = UIHelper.newImageView(SysRes .. images[game.role.autoStatus:getv(slot, 1)])
    end
    btn:pos(680, yPos):addTo(mainBg)
    btn:setCallback(function()
      if slot == 12 then
        UserData.skipSkillAnima = (not UserData.skipSkillAnima or UserData.skipSkillAnima == 0) and 1 or 0
        GameState.save(UserData)
        btn:setImage(SysRes .. images[UserData.skipSkillAnima or 0])
        return
      end
      if slot == 13 then
        UserData.autoBattleLoop = (not UserData.autoBattleLoop or UserData.autoBattleLoop == 0) and 1 or 0
        GameState.save(UserData)
        btn:setImage(SysRes .. images[UserData.autoBattleLoop or 0])
        return
      end
      if slot == 14 then
        UserData.autoBattleLoopCure = (not UserData.autoBattleLoopCure or UserData.autoBattleLoopCure == 0) and 1 or 0
        GameState.save(UserData)
        btn:setImage(SysRes .. images[UserData.autoBattleLoopCure or 0])
        return
      end
      self:changeAutoState(slot, btn, callback)
    end)
    yPos = yPos - interval
  end
  if not UserData.skipHeroAnimation then
    UserData.skipHeroAnimation = ""
  end
  display.newSprite(SysRes .. "line.png"):anch(0.5, 0.5):pos(390, yPos - 30):addTo(mainBg)
  display.newTTFLabel({
    text = "关闭食灵获得特效:",
    size = 24,
    color = UIHelper.hex2rgb("#5c2408")
  }):anch(0, 0.5):pos(65, yPos - 5):addTo(mainBg)
  local xPos = 270
  for star = 2, 5 do
    local status = UserData.skipHeroAnimation:getv(star, 0)
    display.newTTFLabel({
      text = star .. "星",
      size = 24,
      color = UIHelper.hex2rgb("#5c2408")
    }):anch(0, 0.5):pos(xPos, yPos - 5):addTo(mainBg)
    local image = UIHelper.newImageView("ui/treat/block_bg.png"):pos(xPos + 65, yPos - 5):addTo(mainBg)
    if status == 1 then
      display.newSprite("ui/treat/yes.png"):center(image):addTo(image)
    end
    image:setCallback(function()
      self.needSave = true
      if status == 0 then
        display.newSprite("ui/treat/yes.png"):center(image):addTo(image)
        status = 1
        UserData.skipHeroAnimation = UserData.skipHeroAnimation:setv(star, 1)
      else
        image:removeAllChildren()
        status = 0
        UserData.skipHeroAnimation = UserData.skipHeroAnimation:setv(star, 0)
      end
    end)
    xPos = xPos + 90
  end
  display.newSprite(SysRes .. "line.png"):anch(0.5, 0.5):pos(390, yPos - 80):addTo(mainBg)
  display.newTTFLabel({
    text = "解除编队战斗状态:",
    size = 24,
    color = UIHelper.hex2rgb("#5c2408")
  }):anch(0, 0.5):pos(65, yPos - 55):addTo(mainBg)
  local battleResetBtn = UIHelper.newImageView("ui/global/btn_common.png")
  battleResetBtn:pos(360, yPos - 55):addTo(mainBg):scale(0.6)
  battleResetBtn:setCallback(function()
    local time = not UserData.clearBattleCanUseTime and 0 or UserData.clearBattleCanUseTime
    if 0 < time and 0 < time - game:nowTime() then
      MFlashMsg:show({
        text = string.format("解除普通战斗状态冷却中,剩余时间：%d秒", time - game:nowTime())
      })
      return
    end
    game:sendData(actionCodes.Role_clearBattleStateRpc, MsgPack.pack({}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Role_clearBattleStateRpc, function(event)
      UIHelper.removeWaiting()
      MFlashMsg:show({
        text = "解除普通战斗状态成功"
      })
      UserData.clearBattleCanUseTime = game:nowTime() + 300
      GameState.save(UserData)
    end)
  end)
  display.newTTFLabel({
    text = "解除普通战斗",
    size = 22,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#630c07"), 1):center(battleResetBtn):addTo(battleResetBtn)
  local aotuBattleResetBtn = UIHelper.newImageView("ui/global/btn_common.png")
  aotuBattleResetBtn:pos(480, yPos - 55):addTo(mainBg):scale(0.6)
  aotuBattleResetBtn:setCallback(function()
    local time = not UserData.clearAutoBattleCanUseTime and 0 or UserData.clearAutoBattleCanUseTime
    if 0 < time and 0 < time - game:nowTime() then
      MFlashMsg:show({
        text = string.format("解除自动战斗冷却中,剩余时间：%d秒", time - game:nowTime())
      })
      return
    end
    game:sendData(actionCodes.Carbon_autoCleanFormsRpc, MsgPack.pack({}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Carbon_autoCleanFormsRpc, function(event)
      UIHelper.removeWaiting()
      MFlashMsg:show({
        text = "解除自动战斗状态成功"
      })
      UserData.clearAutoBattleCanUseTime = game:nowTime() + 300
      GameState.save(UserData)
    end)
  end)
  display.newTTFLabel({
    text = "解除自动战斗",
    size = 22,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#630c07"), 1):center(aotuBattleResetBtn):addTo(aotuBattleResetBtn)
  local posListX = globalCsv.newHomeOpen == 0 and {
    200,
    390,
    580
  } or {
    145,
    310,
    475,
    640
  }
  if globalCsv.showForum == 1 and globalCsv.newHomeOpen == 0 and (CHANNEL_NAME == "taptap" or CHANNEL_NAME == "iosstore" or CHANNEL_NAME == "haoyou" or CHANNEL_NAME == "mock") then
    posListX = {
      145,
      310,
      475,
      640
    }
  end
  local secretSafe = UIHelper.extend(ccui.Button:create())
  secretSafe:setImages("ui/global/", {
    "btn_common.png",
    "btn_common.png"
  })
  secretSafe:pos(posListX[1], 50):addTo(mainBg)
  secretSafe:scale(0.9)
  secretSafe:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "secret_safe"
    })
  end)
  display.newTTFLabel({
    text = "隐私政策",
    size = 30,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#630c07"), 1):center(secretSafe):addTo(secretSafe)
  local gameEnd = UIHelper.extend(ccui.Button:create())
  gameEnd:setImages("ui/global/", {
    "btn_common.png",
    "btn_common.png"
  })
  gameEnd:pos(posListX[2], 50):addTo(mainBg)
  gameEnd:scale(0.9)
  gameEnd:setCallback(function()
    sdkInterface:logout()
  end)
  display.newTTFLabel({
    text = "退出登录",
    size = 30,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#630c07"), 1):center(gameEnd):addTo(gameEnd)
  local delRole = UIHelper.extend(ccui.Button:create())
  delRole:setImages("ui/global/", {
    "btn_common.png",
    "btn_common.png"
  })
  delRole:pos(posListX[3], 50):addTo(mainBg)
  delRole:scale(0.9)
  delRole:setCallback(function()
    game:sendData(actionCodes.Role_requestDelAccountRpc, MsgPack.pack({}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Role_requestDelAccountRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      if msg.canDel == 0 then
        SysError(SYS_ERR_UNION_MANAGER_REMOVE)
      elseif msg.canDel == 1 then
        game:createView("system.DeleteAccountSecondLayer", {
          okCallback = function()
            game:sendData(actionCodes.Role_requestDelAccountWithConfirmedRpc, MsgPack.pack({
              phone = game.phone
            }))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Role_requestDelAccountWithConfirmedRpc, function(event)
              UIHelper.removeWaiting()
              local msg = MsgPack.unpack(event.data)
              if msg.del == 1 then
                sdkInterface:logout()
              else
                SysError(SYS_ERR_DELETE_COUNT)
              end
            end)
            return true
          end,
          cancelCallback = function()
            return true
          end
        })
      end
    end)
  end)
  display.newTTFLabel({
    text = "注销账号",
    size = 30,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#630c07"), 1):center(delRole):addTo(delRole)
  if globalCsv.newHomeOpen == 1 then
    local changeHome = UIHelper.extend(ccui.Button:create())
    changeHome:setImages("ui/global/", {
      "btn_common.png",
      "btn_common.png"
    })
    changeHome:pos(posListX[4], 50):addTo(mainBg)
    changeHome:scale(0.9)
    changeHome:setCallback(function()
      local homeType = game.role.homeType == 1 and 2 or 1
      game:sendData(actionCodes.Role_changeHomeTypeRpc, MsgPack.pack({homeType = homeType}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Role_changeHomeTypeRpc, function(event)
        UIHelper.removeWaiting()
        self:enterToLogin()
      end)
    end)
    display.newTTFLabel({
      text = "切换风格",
      size = 30,
      color = UIHelper.hex2rgb("#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#630c07"), 1):center(changeHome):addTo(changeHome)
  elseif globalCsv.showForum == 1 and (CHANNEL_NAME == "taptap" or CHANNEL_NAME == "iosstore" or CHANNEL_NAME == "haoyou" or CHANNEL_NAME == "mock") then
    local changeHome = UIHelper.extend(ccui.Button:create())
    changeHome:setImages("ui/global/", {
      "btn_common.png",
      "btn_common.png"
    })
    changeHome:pos(posListX[4], 50):addTo(mainBg)
    changeHome:scale(0.9)
    changeHome:setCallback(function()
      local url = ""
      if CHANNEL_NAME == "taptap" or CHANNEL_NAME == "iosstore" then
        url = "https://www.taptap.cn/app/17784/topic"
      elseif CHANNEL_NAME == "haoyou" then
        url = "https://bbs.3839.com/forum-570.htm"
      end
      if url ~= "" then
        device.openURL(url)
      end
    end)
    display.newTTFLabel({
      text = "前往论坛",
      size = 30,
      color = UIHelper.hex2rgb("#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#630c07"), 1):center(changeHome):addTo(changeHome)
  end
end

function SystemSetLayer:enterToLogin()
  local text = "主城风格切换成功，主厨需要重新登录游戏~"
  MDialog:single({text = text}, function()
    NetManager:closeSocket()
    local child = display.getRunningScene():getChildByTag(NETWORK_WAITING_TAG)
    if child then
      display.getRunningScene():removeChildByTag(NETWORK_WAITING_TAG)
    end
    game:enterScene("LoginScene")
  end)
end

function SystemSetLayer:changeAutoState(index, sender, callback)
  local function send()
    game:sendData(actionCodes.Role_changeAutoSateRpc, MsgPack.pack({id = index}))
    
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Role_changeAutoSateRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      if callback then
        callback(msg.state)
      else
        sender:setImage(SysRes .. images[msg.state])
      end
      if index == 4 then
        if game.role.autoStatus:getv(4, 1) == 0 then
          SysError(SYS_ERR_SYSTEM_NOTIFY_FUNCTION_IS_CLOSED)
        else
          SysError(SYS_ERR_SYSTEM_NOTIFY_FUNCTION_IS_OPEN)
        end
      end
    end)
  end
  
  if index == 1 and game.role.autoStatus:getv(index, 1) == 1 then
    MDialog:double({
      text = "关闭自动补给后，套餐需要在采集点手动补给\n \n确认关闭？",
      okCallback = function()
        send()
        return true
      end,
      cancelCallback = function()
        return true
      end
    })
  else
    send()
  end
end

function SystemSetLayer:showMusicSet(bg)
  local names = {
    [1] = "音乐:",
    [2] = "音效:",
    [3] = "配音:"
  }
  local values = {
    UserData.music,
    UserData.sound,
    UserData.cv
  }
  for index, name in ipairs(names) do
    local yPos = 100 - (index - 1) * 35
    display.newTTFLabel({
      text = name,
      size = 24,
      color = UIHelper.hex2rgb("#5c2408")
    }):pos(60, yPos):addTo(bg)
    local value = display.newTTFLabel({
      text = values[index],
      size = 32,
      color = UIHelper.hex2rgb("#5c2408")
    }):pos(640, yPos + 3):addTo(bg)
    local slider = ccui.Slider:create()
    slider:loadBarTexture(SysRes .. "slider_bg.png")
    slider:loadSlidBallTextures(SysRes .. "slider_bar.png", SysRes .. "slider_bar.png", "")
    slider:loadProgressBarTexture(SysRes .. "slider_bg.png")
    slider:pos(355, yPos):addTo(bg)
    slider:setPercent(values[index])
    slider:addEventListener(function()
      local volume = slider:getPercent()
      value:setString(volume)
      values[index] = volume
      UserData.music = values[1]
      UserData.sound = values[2]
      UserData.cv = values[3]
      self.needSave = true
      game:setMusicVolume(index, volume)
    end)
  end
end

function SystemSetLayer:showPushSet()
  local mainBg = display.newSprite(SysRes .. "main_bg.png"):pos(0, 0):addTo(self.content)
  local texts = {
    [1] = "推送消息",
    [2] = "委托消息",
    [3] = "治疗消息",
    [4] = "种植消息",
    [5] = "餐车消息",
    [6] = "烹饪消息"
  }
  local yPos, interval = 400, 45
  for index, text in ipairs(texts) do
    display.newTTFLabel({
      text = text,
      size = 22,
      color = UIHelper.hex2rgb("#5c2408")
    }):anch(0, 0.5):pos(85, yPos):addTo(mainBg)
    display.newSprite(SysRes .. "line.png"):anch(0.5, 0.5):pos(390, yPos - 23):addTo(mainBg)
    local btn = UIHelper.newImageView(SysRes .. images[game.role.autoStatus:getv(index + 3, 1)]):pos(635, yPos):addTo(mainBg)
    btn:setCallback(function()
      if index + 3 ~= 4 and game.role.autoStatus:getv(4, 1) == 0 then
        SysError(SYS_ERR_SYSTEM_NOTIFY_IS_CLOSED_CAN_NOT_CHANGR)
        return
      end
      self:changeAutoState(index + 3, btn)
    end)
    yPos = yPos - interval
    if index == 1 then
      yPos = yPos - 40
    end
  end
end

function SystemSetLayer:showMusicSetting()
  local mainBg = display.newSprite(SysRes .. "main_bg.png"):pos(0, 0):addTo(self.content)
  local musicBg = display.newSprite(SysRes .. "music_info_bg.png"):pos(390, 360):addTo(mainBg)
  self:showMusicSet(musicBg)
end

function SystemSetLayer:showGiftCode()
  local bg = display.newSprite(SysRes .. "code_bg.png"):pos(0, 30):addTo(self.content)
  local userInput = ccui.EditBox:create(cc.size(340, 38), SysRes .. "text_bg.png")
  userInput:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
  userInput:setFontSize(26)
  userInput:setMaxLength(12)
  userInput:setPlaceHolder("请输入礼品码")
  userInput:anch(0.5, 0.5):pos(502, 172):addTo(bg)
  userInput:setFontColor(UIHelper.hex2rgb("#ffffff"))
  local err = {
    [-1] = SYS_ERR_GIFT_CODE_WRONG,
    [1] = SYS_ERR_GIFT_CODE_WRONG,
    [2] = SYS_ERR_GIFT_CODE_USED,
    [3] = SYS_ERR_GIFT_CODE_NUM_LIMITED,
    [4] = SYS_ERR_GIFT_CODE_OUT_TIME
  }
  local okBtn = UIHelper.extend(ccui.Button:create())
  okBtn:setImages("ui/carbon/boss/", {
    "anniu_1.png",
    "anniu_1.png"
  })
  okBtn:pos(575, 50):addTo(bg)
  okBtn:setTouchScale(true)
  okBtn:setCallback(function()
    local code = userInput:getText()
    if code == "" then
      return
    end
    if code:find("[^0-9a-zA-Z]") then
      SysError(SYS_ERR_GIFT_CODE_WRONG)
      return
    end
    game:sendData(actionCodes.Role_drawCodeRpc, MsgPack.pack({code = code}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Role_drawCodeRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      if msg.result == 0 then
        MedalRewardLayer.new({
          items = msg.items
        })
      else
        SysError(err[msg.result])
      end
    end)
  end)
  display.newTTFLabel({
    text = "兑换",
    size = 30,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#630c07"), 1):center(okBtn):addTo(okBtn)
end

function SystemSetLayer:stringToTab(str)
  local tab = {}
  for utfChar in string.gmatch(str, "[%z-\127�-�][�-�]*") do
    table.insert(tab, utfChar)
  end
  return tab
end

function SystemSetLayer:getLength(strs)
  local width = 0
  for _, str in pairs(strs) do
    local len = string.len(str)
    if 1 < len then
      width = width + 2
    else
      width = width + 1
    end
  end
  return width
end

function SystemSetLayer:onExit()
  if self.needSave then
    GameState.save(UserData)
  end
end

return SystemSetLayer
