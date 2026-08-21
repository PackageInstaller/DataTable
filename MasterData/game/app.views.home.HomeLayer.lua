local HeroRes = "ui/hero/"
local HomeRes = "ui/home/"
local GlobalRes = "ui/global/"
local BtnsRes = "ui/home/btns/"
local PendantRes = "ui/home/pendant/"
local RewardRes = "ui/common/reward/"
local channelConfigs = require("sdk.ChannelConfigs")
local config = channelConfigs[CHANNEL_KEY]
local UnitCsv = require("csvdata.unit")
local TalkCsv = require("csvdata.talk")
local TalkFCsv = require("csvdata.talk_f")
local SkinCsv = require("csvdata.home_skin")
local unionBattleRewardCsv = require("csvdata.union_battle_reward")
local RoleInfoNode = import(".RoleInfoNode")
local HomeLayer = class("HomeLayer", function()
  return UIHelper.extend(ccui.Layout:create())
end)
local SkinRes

function HomeLayer:ctor(params)
  self.params = params or {}
  self:size(display.width, display.height)
  self.handlers = {}
  self.redPoints = {}
  self.unionRankValue = {}
  self.formationUpdate = true
  self:enableNodeEvents()
end

function HomeLayer:onEnter()
  self:showUI()
  self:initEvents()
  self:autoPopupLayer(self.params)
end

function HomeLayer:showUI()
  SkinRes = BtnsRes
  if game.role.homeBgTag == 6 then
    SkinRes = "ui/home/lty/"
    self.pendantType = globalCsv.pendant or 0
  elseif game.role.homeBgTag == 42 then
    SkinRes = "ui/home/fouryear/"
    self.pendantType = globalCsv.pendant or 0
  else
    self.pendantType = globalCsv.pendant or 0
  end
  self.skinNode = display.newNode():pos(display.cx, display.cy):addTo(self)
  self.homeBg = UIHelper.extend(ccui.Layout:create())
  self.homeBg:size(display.width, display.height):pos(0, 0):addTo(self)
  self.crownNode = display.newNode():pos(338, 180):addTo(self.homeBg)
  self.crownNode:setCascadeOpacityEnabled(true)
  self.skinEffectNode = display.newNode():pos(display.cx, display.cy):addTo(self)
  self.bgmNode = display.newNode():pos(display.cx, display.cy):addTo(self)
  self:showHomeSkin()
  TopBar:show(TopBarType.money)
  self.leftBg = display.newSprite(SkinRes .. "home_left.png"):anch(0, 0):addTo(self)
  self.rightBg = display.newScale9Sprite(SkinRes .. "home_right.png", 0, 0, cc.size(475, 35)):anch(1, 0):pos(display.width + 10, 0):addTo(self)
  self.centerBg = display.newNode():pos(840, display.height / 2 - 10):addTo(self)
  self.centerBg:setCascadeOpacityEnabled(true)
  game.role:checkAutoBattleError()
  self:showHeroCard()
  self:layoutMainBottom()
  self:showPendants()
  self:layoutIcons()
  self:getRankValue()
  self.formationInfoLayer = game:createView("home.ShowFormationInfoLayer", {scene = self})
  RoleInfoNode:showView(self)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.skinNode)
    self.formationInfoLayer:hide()
    self.leftBg:setPositionX(self.leftBg:getPositionX() - UIHelper.getMoveXForX())
    self.eyeBtn:setPositionX(self.eyeBtn:getPositionX() - UIHelper.getMoveXForX())
    self.rightBg:setPositionX(self.rightBg:getPositionX() + UIHelper.getMoveXForX() - 35)
  end
  self:showAnimation()
  if not self.params.skipMusic then
    CommonHelper.playHomeBGM()
  end
  self:initRedPoint()
  self:initTimeLimitGiftLayer()
end

function HomeLayer:initEvents()
  self.timerHandler = scheduler.scheduleGlobal(function()
    if self.formationUpdate then
      self.formationInfoLayer:update()
    end
    if next(game.role.buildListJson) then
      game.role:setRedDirty("kitchen")
    end
    if game.role:activityIsOpen(89) and game.role:activityIsOpen(90) then
      game.role:setRedDirty("unionBattle")
    end
    if game.role:activityIsOpen(63) or game.role:activityIsOpen(91) then
      game.role:setRedDirty("pass")
    end
    if next(game.role.redDirty) then
      for field, _ in pairs(game.role.redDirty) do
        game.role:checkRedPoint(field)
      end
      game.role.redDirty = {}
    end
    self:showChatRed()
  end, 1)
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    self:handlerRedPoint(event)
  end))
  table.insert(self.handlers, game.role:addEventListener("set_crown", function(event)
    self:showHeroCard()
  end))
  table.insert(self.handlers, game.role:addEventListener("hero_cure", function(event)
    if event.heroId ~= game.role.crown then
      return
    end
    self:showHeroCard()
  end))
  table.insert(self.handlers, game.role:addEventListener("set_homeBgTag", function(event)
    if event.oldValue == 6 or event.newValue == 6 then
      self:removeAllChildren()
      self:showUI()
    else
      self:showHomeSkin()
    end
  end))
  table.insert(self.handlers, game.role:addEventListener("onChangeDress", function(event)
    if event.heroId ~= game.role.crown then
      return
    end
    self:showHeroCard()
  end))
  table.insert(self.handlers, game.role:addEventListener("updateChat", function(event)
    self:updateChats(event)
  end))
  table.insert(self.handlers, game.role:addEventListener("set_activityBackStatus", function(event)
    if not self.scrollView then
      return
    end
    self.scrollView:showData()
  end))
end

function HomeLayer:autoPopupLayer(params)
  local popupLayers = {
    carbon = {
      callback = handler(self, self.showCarbon),
      name = "carbon"
    },
    heros = {
      callback = handler(self, self.showHeros),
      name = "heros"
    },
    carbonTask = {
      callback = handler(self, self.showCarbonTask),
      name = "carbon"
    },
    treat = {
      callback = handler(self, self.showTreat),
      name = "treat"
    },
    mission = {
      callback = handler(self, self.showMission),
      name = "mission"
    },
    farm = {
      callback = handler(self, self.showFarm),
      name = "farm"
    },
    diner = {
      callback = handler(self, self.showDiner),
      name = "diner"
    },
    friend = {
      callback = handler(self, self.showFriend),
      name = "friend"
    },
    activity = {
      callback = handler(self, self.showActivity),
      name = "activity"
    },
    union = {
      callback = handler(self, self.showUnion),
      name = "union"
    },
    chat = {
      callback = handler(self, self.showChat)
    },
    worldboss = {
      callback = handler(self, self.showWorldBoss),
      name = "worldboss"
    },
    act_carbon = {
      callback = handler(self, self.showActCarbon),
      name = "act_carbon"
    },
    unionBattle = {
      callback = handler(self, self.showUnionBattle)
    },
    rouge = {
      callback = handler(self, self.showRouGe)
    },
    jieji = {
      callback = handler(self, self.showJieji)
    },
    jieji2 = {
      callback = handler(self, self.showJieji2)
    }
  }
  local popupLayer = popupLayers[params.layer]
  if popupLayer then
    if popupLayer.name then
      self:openUI(popupLayer.name)
    end
    popupLayer.callback(params)
  elseif params.guideId then
    NewGuideLayer.new({
      step = params.guideId,
      majorGuideStep = params.guideId,
      minorGuideStep = params.minorStep or 1
    })
    self.formationUpdate = false
  else
    self:checkGuide()
    if game.role.majorGuideStep > MAX_MAJOR_STEP then
      local activeGuide = json.decode(game.role.activeGuideJson)
      if activeGuide["10024"] == 1 or CommonHelper.funcOpen("extraStar") then
      end
      
      local function showNotice()
        if (CHANNEL_NAME or "") ~= "appstore" and game.noticeUrl and game.noticeUrl ~= "none" and not _G.firstNoticeTag then
          game:createView("activity.NoticeLayer", {
            callback = function()
              self:checkHomePopupActivity()
            end
          })
          _G.firstNoticeTag = true
        end
      end
      
      local nT = CommonHelper.date(nil, nil, true)
      local signData = json.decode(game.role.sign)
      if not signData[tostring(nT.day)] or nT.month ~= signData[tostring(nT.day)] then
        self.formationUpdate = false
        game:createView("farm.SignLayer", {
          callback = function()
            self.formationUpdate = true
            showNotice()
          end
        })
      else
        showNotice()
      end
    end
  end
end

function HomeLayer:checkHomePopupActivity()
  if game.role:activityIsOpen(109) then
    local status = game.role.activityStatus["109"]
    if status.get ~= 0 then
      return
    end
    game:createView("home.PopActivity109Layer")
  end
end

function HomeLayer:layoutMainBottom()
  self.scrollView = game:createView("home.ScrollShowLayer", {
    scene = self.centerBg,
    root = self,
    pos = {22, 126},
    table = {
      {},
      {}
    }
  })
  local carbonDatas = {
    [1] = {
      name = "cook",
      redType = "kitchen",
      pos = {-114, -4},
      callback = handler(self, self.showCook)
    },
    [2] = {
      name = "farm",
      redType = "trade=plant=collect=sign",
      pos = {-114, -73},
      callback = handler(self, self.showFarm)
    },
    [3] = {
      name = "carbon",
      redType = "progress",
      pos = {120, -38},
      callback = handler(self, self.showCarbon)
    },
    [4] = {
      name = "chat",
      redType = "",
      pos = {20, -152},
      callback = handler(self, self.showChat)
    },
    [5] = {
      name = "question",
      redType = "",
      pos = {-150, 206},
      callback = handler(self, self.showQuestion)
    },
    [6] = {
      name = "notice",
      redType = "",
      pos = {100, 206},
      callback = handler(self, self.showNotice)
    },
    [7] = {
      name = "activity",
      redType = "activity",
      pos = {200, 206},
      callback = handler(self, self.showActivity)
    },
    [8] = {
      name = "friend",
      redType = "friend",
      pos = {0, 206},
      callback = handler(self, self.showFriend)
    }
  }
  for index, btnData in ipairs(carbonDatas) do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(btnData.res or SkinRes, {
      btnData.name .. "_a.png",
      btnData.name .. "_a.png"
    })
    btn:name(btnData.name .. "Btn")
    btn:pos(btnData.pos[1], btnData.pos[2]):addTo(self.centerBg)
    btn:setCascadeOpacityEnabled(true)
    if btnData.name == "chat" then
      self.chatList = ccui.ListView:create()
      self.chatList:size(cc.size(446, 76))
      self.chatList:setInnerContainerSize(cc.size(446, 76))
      self.chatList:setClippingEnabled(true)
      self.chatList:pos(4, 4):addTo(btn)
      self.chatList:setCascadeOpacityEnabled(true)
      local mask = UIHelper.extend(ccui.Layout:create())
      mask:size(454, 84):addTo(btn)
      mask:setTouchEnabled(true)
      mask:setSwallowTouches(true)
      mask:setCallback(function()
        btnData.callback()
      end)
      local chatB = UIHelper.extend(ccui.Button:create())
      chatB:setCascadeOpacityEnabled(true)
      chatB:setImages(btnData.res or SkinRes, {"chat_b.png", "chat_b.png"})
      chatB:pos(447, 12):addTo(btn)
      chatB:setTouchScale()
      chatB:setCallback(function()
        btnData.callback()
      end)
      self.chatC = display.newSprite((btnData.res or SkinRes) .. "chat_c.png"):anch(0.5, 0):pos(18, 5):addTo(chatB)
      if self:getNewChat() then
        local action = self.chatC:runAction(cc.RepeatForever:create(transition.sequence({
          cc.RotateBy:create(0.05, -25),
          cc.RotateBy:create(0.1, 50),
          cc.RotateBy:create(0.1, -50),
          cc.RotateBy:create(0.05, 25),
          cc.DelayTime:create(2.5)
        })))
        action:setTag(99)
      end
      self:updateChats()
    elseif btnData.name == "notice" then
      btn:setTouchScale()
      btn:setCallback(function()
        btnData.callback()
      end)
    else
      btn:setTouchScale()
      btn:setCallback(function()
        self:openUI(btnData.name)
        btnData.callback()
      end)
      if btnData.name == "carbon" then
        if game.role:activityIsOpen(16) then
          btn:setImages(btnData.res or SkinRes, {
            "carbon_moon.png",
            "carbon_moon.png"
          })
        elseif game.role:activityIsOpen(38) then
          btn:setImages(btnData.res or SkinRes, {
            "carbon_newyear.png",
            "carbon_newyear.png"
          })
        end
      end
    end
    self[btnData.name .. "Btn"] = btn
    if btnData.redType ~= "" then
      table.insert(self.redPoints, btnData.redType)
    end
  end
  if not game.noticeUrl or game.noticeUrl == "none" then
    local noticeBtn = self.centerBg:getChildByName("noticeBtn")
    noticeBtn:hide()
    local friendBtn = self.centerBg:getChildByName("friendBtn")
    friendBtn:pos(100, 206)
  end
  self:initEntrance()
end

function HomeLayer:initEntrance()
  local xPos, yPos = -270, 170
  local dalteY = "60=5 10=5"
  local args = "21=hallowmas 60=general2 29=LtyScene 85=TopDinerScene 37=lover.LoverDayLayer 50=year.YearBackLayer 54=newyear 58=general1 69=worldboss.WorldBossLayer 78=wasteland.WastelandLayer 84=mysterybox.MysteryBoxLayer"
  local reds = {
    [21] = "halloween",
    [54] = "newyear",
    [58] = "general1",
    [60] = "general2",
    [84] = "mysteryBoxHome",
    [85] = "topDiner"
  }
  self.entranceBtns = {}
  local types = "21=3 60=3 10=1 37=2 29=4 50=2 54=3 58=3 66=5 68=1 59=1 69=6 17=1 78=2 84=2 85=4 89=7 2=1 86=1 42=1 71=1 94=9 96=10 101=11 108=12 75=1 999=8"
  for idx, actType in ipairs(globalCsv.ActivityEntrance:toArray("=", true)) do
    if game.role:activityIsOpen(actType) or actType == 999 then
      local btn
      if actType == 17 then
        btn = UIHelper.newImageView(BtnsRes .. string.format("btn_homeskin.png", actType)):pos(xPos, yPos):addTo(self.centerBg)
      else
        btn = UIHelper.newImageView(BtnsRes .. string.format("btn_%s.png", actType)):pos(xPos, yPos):addTo(self.centerBg)
      end
      btn:setCascadeOpacityEnabled(true)
      btn:setCallback(function()
        local jumpType = types:getv(actType, 0)
        if jumpType == 0 then
          print("no type no jump")
          return
        end
        local arg = args:tomap()[tostring(actType)]
        if jumpType == 1 then
          self:showActivity({selected = actType})
        elseif jumpType == 2 then
          game:createView(arg)
        elseif jumpType == 3 then
          game:enterScene("MidAutumnScene", {sceneType = arg})
        elseif jumpType == 4 then
          game:enterScene(arg)
        elseif jumpType == 5 then
          self:showDrawSign()
        elseif jumpType == 6 then
          local layer = game:createView(arg)
          BackManager:push(function()
            layer:close()
            self:closeUI()
          end)
        elseif jumpType == 7 then
          self:showUnionBattle()
        elseif jumpType == 8 then
          game:createView("home.HomePopLayer", {activityId = 1})
        elseif jumpType == 9 then
          self:showRouGe()
        elseif jumpType == 10 then
          self:showJieji()
        elseif jumpType == 11 then
          self:showJieji2()
        elseif jumpType == 12 then
          game:enterScene("ActCarbonScene")
        end
      end)
      yPos = yPos - 100 - dalteY:getv(actType, 0)
      self["Btn" .. actType] = btn
      self.entranceBtns[actType] = reds[actType]
    end
  end
end

function HomeLayer:showUnionBattle()
  local arg1 = "union.UnionBattlePrepareLayer"
  local arg2 = "UnionBattleScene"
  local curStatus = game.role.activityStatus["89"]
  if not self:CheckUnionBattleRegist() then
    SysError(SYS_ERR_UNIONBATTLE_TIMEOUT)
    return
  end
  if not self:CheckUnionBattleStage() then
    game:createView(arg1)
  else
    if game.role.level < globalCsv.unionUnlockLevel or game.role.union == 0 then
      SysError(SYS_ERR_UNIONBATTLE_SIGNUP_LIMIT)
      return
    end
    local curStatus = game.role.activityStatus["89"]
    if not curStatus or curStatus.status ~= 1 then
      return
    end
    local opponent = game.role.activityStatus["89"].opponent or {}
    if not next(opponent) then
      game:sendData(actionCodes.Activity_unionBattleRandOpponentRpc, MsgPack.pack({}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_unionBattleRandOpponentRpc, function(event)
        UIHelper.removeWaiting()
        local newmsg = MsgPack.unpack(event.data)
        game:enterScene(arg2, {
          enemyData = newmsg.opponent
        })
      end)
    else
      game:enterScene(arg2, {enemyData = opponent})
    end
  end
end

function HomeLayer:getRankValue()
  if game.role:activityIsOpen(89) and game.role:activityIsOpen(90) then
    game:sendData(actionCodes.Activity_unionBattleQueryRankValueRpc, MsgPack.pack({}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_unionBattleQueryRankValueRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      self.unionRankValue = msg
    end)
  end
end

function HomeLayer:CheckUnionBattleRegist()
  local curStatus = game.role.activityStatus["89"]
  local backStatus = json.decode(game.role.activityBackStatus)
  local openStatus = backStatus["90"] and backStatus["90"].start < game:nowTime() and backStatus["90"].close > game:nowTime()
  if curStatus and curStatus.status ~= 1 and openStatus then
    return false
  end
  return true
end

function HomeLayer:CheckUnionBattleStage()
  local curStatus = game.role.activityStatus["89"]
  local backStatus = json.decode(game.role.activityBackStatus)
  local openStatus = backStatus["90"] and backStatus["90"].start < game:nowTime() and backStatus["90"].close > game:nowTime()
  if not curStatus or curStatus.status ~= 1 or not openStatus then
    return false
  end
  return true
end

function HomeLayer:layoutIcons()
  local xPos, interval = 130, 105
  local mainBtnDatas = {
    [1] = {
      name = "team",
      redType = "",
      callback = handler(self, self.showTeam)
    },
    [2] = {
      name = "treat",
      redType = "",
      callback = handler(self, self.showTreat)
    },
    [3] = {
      name = "heros",
      redType = "",
      callback = handler(self, self.showHeros)
    },
    [4] = {
      name = "equips",
      redType = "",
      callback = handler(self, self.showEquip)
    },
    [5] = {
      name = "box",
      redType = "box",
      callback = handler(self, self.showBox)
    }
  }
  for index, btnData in ipairs(mainBtnDatas) do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(SkinRes, {
      btnData.name .. "_a.png",
      btnData.name .. "_a.png"
    })
    btn:name(btnData.name .. "Btn")
    btn:pos(xPos + (index - 1) * interval, 55):addTo(self.leftBg)
    btn:setTouchScale()
    btn:setCallback(function()
      if btnData.name == "equips" or btnData.name == "box" then
        btnData.callback()
      else
        self:openUI(btnData.name)
        btnData.callback()
      end
    end)
    if btnData.musicId then
      btn:setMusicId(btnData.musicId)
    end
    if btnData.redType ~= "" then
      table.insert(self.redPoints, btnData.redType)
    end
  end
  xPos, interval = 47, 76
  local leftBtnDatas = {
    [1] = {
      name = "union",
      reaType = "union",
      callback = handler(self, self.showUnion)
    },
    [2] = {
      name = "diner",
      redType = "diner",
      callback = handler(self, self.showDiner)
    },
    [3] = {
      name = "mission",
      redType = "mission=achieve",
      callback = handler(self, self.showMission)
    },
    [4] = {
      name = "menu",
      redType = "",
      musicId = 1014,
      callback = handler(self, self.showMenu)
    },
    [5] = {
      name = "story",
      redType = "story",
      callback = handler(self, self.showStory)
    },
    [6] = {
      name = "shop",
      redType = "",
      callback = handler(self, self.showShop)
    }
  }
  for index, btnData in ipairs(leftBtnDatas) do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(SkinRes, {
      btnData.name .. "_a.png",
      btnData.name .. "_a.png"
    })
    btn:pos(xPos + (index - 1) * interval, 40):addTo(self.rightBg)
    btn:name(btnData.name .. "Btn"):setTouchScale()
    btn:setCallback(function()
      if btnData.name == "diner" or btnData.name == "union" then
        btnData.callback()
      else
        self:openUI(btnData.name)
        btnData.callback()
      end
    end)
    if btnData.musicId then
      btn:setMusicId(btnData.musicId)
    end
    if btnData.redType ~= "" then
      table.insert(self.redPoints, btnData.redType)
    end
    if btnData.name == "mission" then
      display.newSprite(SkinRes .. "mission_b.png"):pos(50, 30):addTo(btn, nil, 99)
    elseif btnData.name == "story" then
      display.newSprite(SkinRes .. "story_b.png"):pos(36, 33):addTo(btn, nil, 99)
      display.newSprite(SkinRes .. "story_c.png"):pos(35, 37):addTo(btn)
    elseif btnData.name == "shop" then
      btn:setPositionY(47)
    end
  end
  self.mailBtn = UIHelper.extend(ccui.Button:create())
  self.mailBtn:setImages(SkinRes, {"mail_a.png", "mail_a.png"})
  self.mailBtn:anch(0, 0.5):pos(-3, 490):addTo(self)
  self.mailBtn:setTouchScale()
  self.mailBtn:setCallback(function()
    self:showMail()
  end)
  self.taskBtn = UIHelper.extend(ccui.Button:create())
  self.taskBtn:setImages(SkinRes, {"pass_a.png", "pass_a.png"})
  self.taskBtn:anch(0, 0.5):pos(-3, 395):addTo(self):hide()
  self.taskBtn:setTouchScale()
  self.taskBtn:setCallback(function()
    self:showPassActivity()
  end)
  if game.role:activityIsOpen(63) or game.role:activityIsOpen(91) then
    self.taskBtn:show()
    table.insert(self.redPoints, "pass")
  end
  self.extraBtn = UIHelper.extend(ccui.Button:create())
  self.extraBtn:setImages(SkinRes, {
    "lucky_a.png",
    "lucky_a.png"
  })
  self.extraBtn:anch(0, 0.5):pos(-3, 220):addTo(self):hide()
  self.extraBtn:setTouchScale()
  self.extraBtn:setCallback(function()
    self:showExtraActivity()
  end)
  if game.role:activityIsOpen(61) then
    self.extraBtn:show()
    table.insert(self.redPoints, "lucky")
  end
  if UIHelper.isiPhoneX() then
    self.taskBtn:setPositionX(self.taskBtn:getPositionX() - 75)
    self.taskBtn:setPositionY(self.taskBtn:getPositionY() - 60)
    self.mailBtn:setPositionX(self.mailBtn:getPositionX() - 75)
    self.mailBtn:setPositionY(self.mailBtn:getPositionY() - 60)
    self.extraBtn:setPositionX(self.extraBtn:getPositionX() - 75)
    self.extraBtn:setPositionY(self.extraBtn:getPositionY() - 60)
  end
  display.newSprite(SkinRes .. "mail_b.png"):pos(70, 40):addTo(self.mailBtn, nil, 99)
  display.newSprite(SkinRes .. "pass_b.png"):pos(60, 40):addTo(self.taskBtn, nil, 99)
  self.click = 1
  self.eyeBtn = UIHelper.extend(ccui.Button:create())
  self.eyeBtn:setImages(SkinRes, {"eye_a.png", "eye_a.png"})
  self.eyeBtn:pos(30, 35):addTo(self)
  self.eyeBtn:setTouchScale()
  self.eyeBtn:setCallback(function()
    self:changeUI()
  end)
end

function HomeLayer:changeUI()
  if self.click == 1 then
    self.bgmNode:show()
    self:showMask(0.5)
    RoleInfoNode:getBg():runAction(cc.MoveBy:create(0.4, cc.p(-360, 0)))
    TopBar:moveOut(true)
    self.mailBtn:runAction(cc.MoveBy:create(0.3, cc.p(-165, 0)))
    self.extraBtn:runAction(cc.MoveBy:create(0.3, cc.p(-165, 0)))
    self.taskBtn:runAction(cc.MoveBy:create(0.3, cc.p(-165, 0)))
    self.eyeBtn:runAction(cc.MoveBy:create(0.3, cc.p(-80, 0)))
    self.leftBg:runAction(cc.MoveBy:create(0.45, cc.p(-self.leftBg:getContentSize().width, 0)))
    self.rightBg:runAction(cc.MoveBy:create(0.45, cc.p(self.rightBg:getContentSize().width, 0)))
    self.centerBg:runAction(transition.sequence({
      cc.Spawn:create(cc.MoveBy:create(0.3, cc.p(80, 0)), cc.FadeOut:create(0.5)),
      cc.CallFunc:create(function()
        self.click = 2
        self.centerBg:hide()
        self.homeBg:setCallback(function()
          self:changeUI()
        end)
      end)
    }))
    if self.content and not tolua.isnull(self.content) then
      self.content:setCascadeOpacityEnabled(true)
      self.content:runAction(cc.Spawn:create(cc.MoveTo:create(0.25, cc.p(160, 175)), cc.FadeOut:create(0.25)))
    end
    self.formationInfoLayer:MoveToLeft()
  else
    self.bgmNode:hide()
    self:showMask(0.5)
    self.homeBg:setTouchEnabled(false)
    RoleInfoNode:getBg():runAction(cc.MoveBy:create(0.4, cc.p(360, 0)))
    TopBar:moveIn(true)
    self.mailBtn:runAction(cc.MoveBy:create(0.3, cc.p(165, 0)))
    self.extraBtn:runAction(cc.MoveBy:create(0.3, cc.p(165, 0)))
    self.taskBtn:runAction(cc.MoveBy:create(0.3, cc.p(165, 0)))
    self.eyeBtn:runAction(cc.MoveBy:create(0.3, cc.p(80, 0)))
    self.leftBg:runAction(cc.MoveBy:create(0.45, cc.p(self.leftBg:getContentSize().width, 0)))
    self.rightBg:runAction(cc.MoveBy:create(0.45, cc.p(-self.rightBg:getContentSize().width, 0)))
    self.centerBg:runAction(transition.sequence({
      cc.CallFunc:create(function()
        self.centerBg:show()
      end),
      cc.Spawn:create(cc.MoveBy:create(0.3, cc.p(-80, 0)), cc.FadeIn:create(0.3)),
      cc.CallFunc:create(function()
        self.click = 1
      end)
    }))
    if self.content and not tolua.isnull(self.content) then
      self.content:setOpacity(0)
      self.content:runAction(cc.Spawn:create(cc.MoveTo:create(0.25, cc.p(265, 175)), cc.FadeIn:create(0.25)))
    end
    self.formationInfoLayer:MoveToRight()
  end
end

function HomeLayer:showAnimation()
  if self.mask then
    return
  end
  self:showMask(1.2)
  UIHelper.MoveToRight({
    node = RoleInfoNode:getBg(),
    time = 0.45,
    pos = {180, 0}
  })
  TopBar:showAnimation(nil, nil, nil, true)
  local mainBtnNames = {
    [1] = "team",
    [2] = "treat",
    [3] = "heros",
    [4] = "equips",
    [5] = "box"
  }
  local delay = 0.25
  for index, name in ipairs(mainBtnNames) do
    local btn = self.leftBg:getChildByName(name .. "Btn")
    if btn then
      UIHelper.MoveToUp({
        node = btn,
        delay = delay,
        time = 0.24
      })
      delay = delay + 0.06
    end
  end
  UIHelper.MoveToRight({
    node = self.leftBg,
    time = 0.45
  })
  UIHelper.MoveToRight({
    node = self.centerBg,
    delay = 1,
    time = 0.3,
    pos = {50, 0}
  })
  local leftBtnNames = {
    [1] = "union",
    [2] = "diner",
    [3] = "mission",
    [4] = "menu",
    [5] = "story",
    [6] = "shop"
  }
  local delay = 0.6
  for index, name in ipairs(leftBtnNames) do
    local btn = self.rightBg:getChildByName(name .. "Btn")
    if btn then
      UIHelper.MoveToUp({
        node = btn,
        delay = delay,
        time = 0.24
      })
      delay = delay + 0.06
    end
  end
  UIHelper.MoveToLeft({
    node = self.rightBg,
    time = 0.45
  })
  UIHelper.MoveToLeft({
    node = self.crownNode,
    time = 0.6,
    delay = 0.2,
    pos = {60, 0}
  })
  UIHelper.MoveToRight({
    node = self.mailBtn,
    delay = 0.4,
    time = 0.3
  })
  UIHelper.MoveToRight({
    node = self.extraBtn,
    delay = 0.4,
    time = 0.3
  })
  UIHelper.MoveToRight({
    node = self.taskBtn,
    delay = 0.4,
    time = 0.3
  })
  UIHelper.MoveToRight({
    node = self.eyeBtn,
    time = 0.45
  })
  if self.content and not tolua.isnull(self.content) then
    self.content:setCascadeOpacityEnabled(true)
    UIHelper.MoveToRight({
      node = self.content,
      delay = 0.2,
      pos = {30, 0}
    })
  end
  self.formationInfoLayer:showAnimation()
  if game.role.majorGuideStep == 10 then
    self.crownNode:hide()
  end
end

function HomeLayer:showHomeSkin()
  self.skinNode:removeAllChildren()
  self.skinEffectNode:removeAllChildren()
  self.bgmNode:removeAllChildren()
  self.bgmNode:hide()
  local skinData = SkinCsv[game.role.homeBgTag]
  if skinData.changeByTime == 1 then
    local nowtime = game:nowTime()
    local bgmList = skinData.bgmList:toArray("=", true)
    if skinData.spine ~= "" then
      local spineSkin
      if nowtime % 86400 <= 25200 then
        spineSkin = UIHelper.createSpineNodeByRes(string.format(skinData.spine, 1))
        spineSkin:pos(0, 0):addTo(self.skinNode)
        game:playMusic(bgmList[1] or 1)
      elseif nowtime % 86400 <= 46800 then
        spineSkin = UIHelper.createSpineNodeByRes(string.format(skinData.spine, 2))
        spineSkin:pos(0, 0):addTo(self.skinNode)
        game:playMusic(bgmList[2] or 1)
      else
        spineSkin = UIHelper.createSpineNodeByRes(string.format(skinData.spine, 3))
        spineSkin:pos(0, 0):addTo(self.skinNode)
        game:playMusic(bgmList[3] or 1)
      end
      local action = cc.Sequence:create({
        cc.DelayTime:create(60),
        cc.CallFunc:create(function()
          local oldTime = nowtime
          nowtime = game:nowTime()
          if oldTime % 86400 <= 25200 and nowtime % 86400 > 25200 then
            spineSkin = UIHelper.createSpineNodeByRes(string.format(skinData.spine, 2))
            spineSkin:pos(0, 0):addTo(self.skinNode)
            game:playMusic(bgmList[2] or 1)
          elseif oldTime % 86400 <= 46800 and nowtime % 86400 > 46800 then
            spineSkin = UIHelper.createSpineNodeByRes(string.format(skinData.spine, 3))
            spineSkin:pos(0, 0):addTo(self.skinNode)
            game:playMusic(bgmList[3] or 1)
          elseif oldTime % 86400 > 46800 and nowtime % 86400 < 25200 then
            spineSkin = UIHelper.createSpineNodeByRes(string.format(skinData.spine, 1))
            spineSkin:pos(0, 0):addTo(self.skinNode)
            game:playMusic(bgmList[1] or 1)
          end
        end)
      })
      local roundAction = cc.RepeatForever:create(action)
      spineSkin:runAction(roundAction)
      spineSkin:setAnimation(0, "change", false)
      spineSkin:addAnimation(0, "idle", true)
    else
      local bg
      if nowtime % 86400 <= 25200 then
        bg = UIHelper.newImageView(string.format(skinData.res, 1)):pos(0, 0):addTo(self.skinNode)
        game:playMusic(bgmList[1] or 1)
      elseif nowtime % 86400 <= 46800 then
        bg = UIHelper.newImageView(string.format(skinData.res, 2)):pos(0, 0):addTo(self.skinNode)
        game:playMusic(bgmList[2] or 1)
      else
        bg = UIHelper.newImageView(string.format(skinData.res, 3)):pos(0, 0):addTo(self.skinNode)
        game:playMusic(bgmList[3] or 1)
      end
      local action = cc.Sequence:create({
        cc.DelayTime:create(60),
        cc.CallFunc:create(function()
          local oldTime = nowtime
          nowtime = game:nowTime()
          if oldTime % 86400 <= 25200 and nowtime % 86400 > 25200 then
            bg:setImage(string.format(skinData.res, 2))
            game:playMusic(bgmList[2] or 1)
          elseif oldTime % 86400 <= 46800 and nowtime % 86400 > 46800 then
            bg:setImage(string.format(skinData.res, 3))
            game:playMusic(bgmList[3] or 1)
          elseif oldTime % 86400 > 46800 and nowtime % 86400 < 25200 then
            bg:setImage(string.format(skinData.res, 1))
            game:playMusic(bgmList[1] or 1)
          end
        end)
      })
      local roundAction = cc.RepeatForever:create(action)
      bg:runAction(roundAction)
    end
  elseif skinData.spine ~= "" then
    local spineSkin = UIHelper.createSpineNodeByRes(skinData.spine)
    spineSkin:pos(0, 0):addTo(self.skinNode)
    spineSkin:setAnimation(0, "change", false)
    spineSkin:addAnimation(0, "idle", true)
  else
    UIHelper.newImageView(skinData.res):pos(0, 0):addTo(self.skinNode)
  end
  if skinData.effect ~= "" then
    local yinghuo = cc.ParticleSystemQuad:create(skinData.effect .. ".plist")
    yinghuo:setPositionType(cc.POSITION_TYPE_RELATIVE)
    yinghuo:pos(0, -340):addTo(self.skinNode)
  end
  if skinData.spineEffect ~= "" then
    local spineEffect = UIHelper.createSpineNodeByRes(skinData.spineEffect)
    spineEffect:pos(0, 0):addTo(skinData.zorder == 1 and self.skinEffectNode or self.skinNode)
    spineEffect:setAnimation(0, "change", true)
    spineEffect:addAnimation(0, "idle", true)
  end
  if skinData.bgmList ~= "" and skinData.changeByTime ~= 1 then
    local touchLayer = UIHelper.newMask({
      size = cc.size(300, 250)
    }):pos(120, -250):addTo(self.bgmNode)
    local lastTime = 0
    touchLayer:setCallback(function()
      if game:nowTime() < lastTime + 5 then
        return
      end
      lastTime = game:nowTime()
      local bgmIndexStr = UserData.homeBgm or ""
      local index = bgmIndexStr:getv(game.role.homeBgTag, 1)
      local bgmList = skinData.bgmList:toArray("=", true)
      index = index + 1
      if index > #bgmList then
        index = 1
      end
      UserData.homeBgm = bgmIndexStr:setv(game.role.homeBgTag, index)
      GameState.save(UserData)
      CommonHelper.playHomeBGM()
    end)
  end
end

function HomeLayer:showTeam()
  local layer = game:createView("hero.TeamListLayer")
  BackManager:push(function()
    layer:close()
    self:closeUI("hero")
    self:checkGuide()
  end)
end

function HomeLayer:showTreat()
  local layer = game:createView("treat.TreatHeroLayer")
  BackManager:push(function()
    layer:close()
    self:closeUI("treat")
  end)
end

function HomeLayer:showHeros(params)
  local param = params or {}
  local layer = game:createView("kitchen.KitchenLayer1", {
    selected = param.selected
  })
  BackManager:push(function()
    layer:close()
    self:closeUI("kitchen1")
  end)
end

function HomeLayer:showUnion(params)
  if game.role.level < globalCsv.unionUnlockLevel and game.role.union == 0 then
    SysError(SYS_ERR_UNION_LEVEL_LIMIT)
    return
  end
  if game.role.union ~= 0 then
    game:sendData(actionCodes.Union_unionInfoRpc, MsgPack.pack({
      union = game.role.union
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Union_unionInfoRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      if msg.code then
        SysError(msg.code)
        return
      end
      game.role.unionData = msg.result
      local layer = game:createView("union.UnionManageLayer", params)
      self:openUI("union")
      BackManager:push(function()
        layer:close()
        self:closeUI("union")
      end)
    end)
    return
  end
  local layer = game:createView("union.UnionMainLayer", params)
  self:openUI("union")
  BackManager:push(function()
    layer:close()
    self:closeUI("union")
  end)
end

function HomeLayer:showEquip()
  local cx, cy, width, height = display.cx, display.cy, display.width, display.height
  if UIHelper.isiPhoneX() then
    local movex = UIHelper.getMoveXForX(true)
    cx, cy, width = cx + movex, cy, width + movex * 2
  end
  local mask = UIHelper.newMask({
    size = cc.size(width, height),
    color = "#000000",
    opacity = 110
  })
  mask:anch(0.5, 0.5):pos(cx, cy):addTo(display.getRunningScene(), 100)
  display.newSprite(imgPath):pos(width / 2, height / 2):addTo(mask)
  mask:setTouchEnabled(true)
  mask:setSwallowTouches(true)
  mask:setCallback(function()
    mask:removeSelf()
  end)
  local equipBtn = UIHelper.extend(ccui.Button:create())
  equipBtn:setImages(SkinRes, {
    "equip_a.png",
    "equip_a.png"
  })
  equipBtn:pos(390, 150):addTo(mask):name("equipBtn")
  equipBtn:setTouchScale()
  equipBtn:setCallback(function()
    if not CommonHelper.funcOpen("equip") then
      SysError(SYS_ERR_FUNCOPEN_EQUIP)
      return
    end
    mask:removeSelf()
    local layer = game:createView("equip.EquipHomeLayer")
    self:openUI("equip")
    BackManager:push(function()
      layer:close()
      self:closeUI("equip")
    end)
  end)
  local sauceBtn = UIHelper.extend(ccui.Button:create())
  sauceBtn:setImages(SkinRes, {
    "sauce_a.png",
    "sauce_a.png"
  })
  sauceBtn:pos(495, 150):addTo(mask):name("sauceBtn")
  sauceBtn:setTouchScale()
  sauceBtn:setCallback(function()
    if not CommonHelper.funcOpen("sauce") then
      SysError(SYS_ERR_FUNCOPEN_SAUCE)
      return
    end
    mask:removeSelf()
    local layer = game:createView("sauce.SauceHomeLayer")
    self:openUI("sauce")
    BackManager:push(function()
      layer:close()
      self:closeUI("sauce")
    end)
  end)
end

function HomeLayer:showBox()
  if not CommonHelper.funcOpen("box") then
    SysError(SYS_ERR_FUNCOPEN_DINER_BOX)
    return
  end
  game.role:requestDinerInfo(function()
    game:enterScene("DinerScene")
    BackManager:push(function()
      game:enterScene("MainScene", {})
    end)
  end)
end

function HomeLayer:showPassActivity()
  local layer = game:createView("pass.PassMainLayer", {select = 1})
  self:openUI("pass")
  BackManager:push(function()
    layer:close()
    CommonHelper.playHomeBGM()
    self:closeUI("pass")
  end)
end

function HomeLayer:showDiner()
  if game.role.createTime < CommonHelper.toUnixtime("201801040930") then
    if not CommonHelper.funcOpen("dinerCar") then
      SysError(SYS_ERR_FUNCOPEN_DINER_CAR)
      return
    end
  elseif not CommonHelper.funcOpen("dinerCarNew") then
    SysError(SYS_ERR_FUNCOPEN_DINER_CAR_NEW)
    return
  end
  game.role:requestDinerInfo(function()
    self:openUI("diner")
    local layer = game:createView("diner.DinerMainLayer")
    BackManager:push(function()
      CommonHelper.playHomeBGM()
      layer:close()
      self:closeUI("diner")
    end)
  end)
end

function HomeLayer:showAchievement()
  local layer = game:createView("achieve.AchievementMainLayer")
  BackManager:push(function()
    layer:close()
    self:closeUI("achieve")
  end)
end

function HomeLayer:showMission(params)
  local layer = game:createView("mission.MissionLayer", params)
  BackManager:push(function()
    layer:close()
    self:closeUI("mission")
  end)
end

function HomeLayer:showShop(params)
  local layer = game:createView("shop.ShopLayer", params)
  BackManager:push(function()
    layer:close()
    self:closeUI("shop")
  end)
end

function HomeLayer:showMenu()
  local layer = game:createView("hero.HandBook")
  BackManager:push(function()
    layer:close()
    self:closeUI("menu")
  end)
end

function HomeLayer:showCarbonTask()
  local layer = game:createView("carbon.CarbonTaskLayer")
  BackManager:push(function()
    layer:close()
    local mainLayer = game:createView("carbon.CarbonMainLayer")
    BackManager:push(function()
      mainLayer:close()
      CommonHelper.playHomeBGM()
      self:closeUI("carbonTask")
    end)
  end)
end

function HomeLayer:showCarbon(params)
  local layer = game:createView("carbon.CarbonMainLayer", params)
  BackManager:push(function()
    layer:close()
    CommonHelper.playHomeBGM()
    self:closeUI("carbon")
  end)
end

function HomeLayer:showFarm()
  self:show()
  if not CommonHelper.funcOpen("farm") then
    self.formationUpdate = true
    self:show()
    SysError(SYS_ERR_FUNCOPEN_FARM)
    return
  end
  game.role:requestFarmInfo(function()
    self:hide()
    local layer = game:createView("farm.FarmMainLayer")
    BackManager:push(function()
      CommonHelper.playHomeBGM()
      layer:close()
      self:closeUI("fram")
    end)
  end)
end

function HomeLayer:showFarmDraw()
  if not CommonHelper.funcOpen("box") then
    SysError(SYS_ERR_FUNCOPEN_DINER_DRAW)
    self:closeUI("framDraw")
    return
  end
  local layer = game:createView("diner.DinerDrawLayer")
  BackManager:push(function()
    layer:close()
    self:closeUI("framDraw")
  end)
end

function HomeLayer:showCook(params)
  local param = params or {}
  local layer = game:createView("kitchen.KitchenLayer2", {
    selected = param.selected
  })
  BackManager:push(function()
    layer:close()
    self:closeUI("kitchen2")
  end)
end

function HomeLayer:showNotice()
  game:createView("activity.NoticeLayer")
end

function HomeLayer:showActivity(params)
  self:hide()
  local layer = game:createView("activity.ActivityMainLayer", params)
  BackManager:push(function()
    layer:close()
    self:show()
    self:closeUI("activity")
    self:showHeroCard()
  end)
end

function HomeLayer:showFriend()
  local layer = game:createView("friend.FriendMainLayer")
  BackManager:push(function()
    layer:close()
    self:closeUI("friend")
  end)
end

function HomeLayer:showExtraActivity()
  game:enterScene("MidAutumnScene", {sceneType = "activity"})
end

function HomeLayer:showChat(params)
  game:createView("chat.ChatMainLayer", params)
end

function HomeLayer:showRouGe(params)
  game:enterScene("RouGeScene")
end

function HomeLayer:showJieji(params)
  game:enterScene("JiejiScene")
end

function HomeLayer:showJieji2(params)
  game:enterScene("JiejiScene", {type = "101"})
end

function HomeLayer:showWorldBoss(params)
  local layer = game:createView("worldboss.WorldBossLayer", params)
  BackManager:push(function()
    layer:close()
    self:closeUI("worldboss")
  end)
end

function HomeLayer:showActCarbon(params)
  local layer = game:createView("act_carbon.ActCarbonMainLayer", params)
  BackManager:push(function()
    layer:close()
    self:closeUI("act_carbon")
  end)
end

function HomeLayer:showMail()
  game:sendData(actionCodes.Email_listRpc, MsgPack.pack({}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Email_listRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    game.role.mails = msg
    local layer = game:createView("mail.MailLayer", {mails = msg})
    BackManager:push(function()
      layer:close()
      self:closeUI("mail")
    end)
  end)
end

function HomeLayer:showQuestion()
  self:openUI("question")
  local layer = game:createView("talk.QuestionLayer")
  BackManager:push(function()
    layer:close()
    self:closeUI("question")
  end)
end

function HomeLayer:showStory()
  local layer = game:createView("talk.TalkLayer")
  BackManager:push(function()
    layer:close()
    self:closeUI("story")
  end)
end

function HomeLayer:openUI(layer)
  self.formationUpdate = false
  self:hide()
end

function HomeLayer:closeUI(layer)
  self:show()
  self:showAnimation()
  self.formationInfoLayer:showData()
  TopBar:show(TopBarType.money)
  self.formationUpdate = true
end

function HomeLayer:showHeroCard(cure)
  self:stopAllActions()
  self.crownNode:removeAllChildren()
  if self.content and not tolua.isnull(self.content) then
    self.content:stopAllActions()
    self.content:removeSelf()
    self.content = nil
  end
  local heroId = game.role.crown
  if heroId == 0 then
    return
  end
  local hero = game.role.heros[heroId]
  local unitType = hero:getDressType()
  local unitData = UnitCsv[unitType]
  local live2dModel
  local supportLive2d = false
  if unitData.live2d ~= "" and supportLive2d and not game.role:activityIsOpen(57) then
    local fileName = unitData.live2d
    local loveBreak, value = UIHelper.getMaxLoveBreak(hero.type)
    if hero.hpPercent <= 300 and 5 <= loveBreak then
      fileName = fileName .. "_po"
    end
    local live2d = live2d.LAppView:createDrawNode(string.format("live2d/%s/", fileName), string.format("%s.model.json", fileName))
    live2d:addTo(self.crownNode)
    local posParams = unitData.live2dScale:toArray(" ", true)
    live2d:updateViewMatrix(-1 * posParams[1], -1 * posParams[2], posParams[3], posParams[4], posParams[5])
    local model = live2d:getAppModel()
    model:insertMotion("chest", "tap_chest")
    model:insertMotion("hair", "tap_hair")
    model:insertMotion("skirt", "tap_skirt")
    live2dModel = model
  else
    self.heroSpine = nil
    self.touchTag = 1
    if unitData.live2d ~= "" then
      self.heroSpine = UIHelper.createSpineNodeByRes(unitData.live2d)
      self.heroSpine:setAnimation(0, "idle", true)
      local posParams = unitData.live2dScale:toArray("=", true)
      self.heroSpine:pos(0 + posParams[2], 100 + posParams[3]):scale(0.7 + posParams[4], 0.7 + posParams[5]):addTo(self.crownNode)
      self.touchTag = posParams[1]
    else
      local card = HeroBigCard.new({
        heroId = heroId,
        showPic = true,
        quality = hero.quality
      })
      card:addTo(self.crownNode)
      card:setCascadeOpacityEnabled(true)
      
      local function runSeq()
        card:runAction(transition.sequence({
          cc.EaseSineOut:create(cc.MoveBy:create(3, cc.p(0, 8))),
          cc.EaseSineIn:create(cc.MoveBy:create(3, cc.p(0, -8))),
          cc.EaseSineOut:create(cc.MoveBy:create(3, cc.p(0, -8))),
          cc.EaseSineIn:create(cc.MoveBy:create(3, cc.p(0, 8))),
          cc.CallFunc:create(function()
            runSeq()
          end)
        }))
      end
      
      runSeq()
      card:setCallback(function()
        card:stopAllActions()
        if card:getNumberOfRunningActions() > 0 then
          return
        end
        card:scale(0.99)
        card:runAction(transition.sequence({
          cc.EaseElasticOut:create(cc.ScaleTo:create(0.4, 1)),
          cc.MoveTo:create(math.abs(card:getPositionY()) * 3 / 8, cc.p(0, 0)),
          cc.CallFunc:create(function()
            runSeq()
          end)
        }))
      end)
    end
  end
  local play = false
  local touch = UIHelper.newMask({
    size = cc.size(460, 760)
  })
  touch:anch(0.5, 0.5):pos(0, 0):addTo(self.crownNode)
  touch:setCallback(function()
    if play or self.click == 2 or self.tipBg then
      return
    end
    if self.heroSpine and self.touchTag == 1 then
      play = true
      self.heroSpine:setAnimation(0, "touch", false)
      self.heroSpine:registerSpineEventHandler(function(event)
        if event.type ~= "end" then
          return
        end
        scheduler.performWithDelayGlobal(function()
          self.heroSpine:setAnimation(0, "idle", true)
          play = false
        end, 0.016666666666666666)
        self.heroSpine:unregisterSpineEventHandler(sp.EventType.ANIMATION_END)
      end, sp.EventType.ANIMATION_END)
      CommonHelper.playCV(hero.type, strName)
      return
    end
    local bMarry = hero.loveBreak >= 5 and math.random(0, 100) >= 50 and "marryStandby" or "normalStandby"
    local cvIndex = math.random(1, 3)
    local strName = string.format("%s%d", bMarry, cvIndex)
    local talk = TalkCsv[hero.type][strName]
    local talkF = TalkCsv[hero.type][string.format("f%s%d", bMarry, cvIndex)]
    if talk == "" and talkF == "" then
      return
    end
    play = true
    self.content = display.newSprite(HomeRes .. "talk_bg.png"):pos(265, 175):addTo(self.homeBg)
    local seq = {}
    if talkF == "" then
      local label = MRichText.new({
        text = talk,
        color = UIHelper.hex2rgb("#000000"),
        size = 18,
        maxWidth = 265
      }):pos(20, 100):addTo(self.content)
      label:playAnimation(20, nil, nil)
      table.insert(seq, cc.DelayTime:create(5))
    else
      for _, data in ipairs(talkF:toTableArray()) do
        local fId, delay = tonumber(data[1]), tonumber(data[2])
        table.insert(seq, cc.CallFunc:create(function()
          self.content:removeAllChildren()
          local label = MRichText.new({
            text = TalkFCsv[fId].content,
            color = UIHelper.hex2rgb("#000000"),
            size = 18,
            maxWidth = 265
          }):pos(20, 100):addTo(self.content)
          label:playAnimation(20, nil, nil)
        end))
        table.insert(seq, cc.DelayTime:create(delay))
      end
    end
    table.insert(seq, cc.CallFunc:create(function()
      if not self.heroSpine then
        play = false
      end
      if self.content and not tolua.isnull(self.content) then
        self.content:stopAllActions()
        self.content:removeSelf()
        self.content = nil
        play = false
      end
    end))
    UIHelper.MoveToLeft({
      node = self.content,
      time = 0.25,
      pos = {28, 0}
    })
    CommonHelper.playCV(hero.type, strName)
    self:runAction(cc.Sequence:create(seq))
  end)
  touch:setSwallowTouches(false)
end

function HomeLayer:updateChats(params)
  if not params then
    return
  end
  if params.crossNewMsg then
    for idx = math.max(#params.crossNewMsg - 3, 1), #params.crossNewMsg do
      if table.nums(self.chatList:getItems()) < 4 then
        self:createChatRow(params.crossNewMsg[idx], params.crossNewMsg[idx].chatType)
      else
        self.chatList:removeItem(0)
        self:createChatRow(params.crossNewMsg[idx], params.crossNewMsg[idx].chatType)
      end
    end
  elseif table.nums(self.chatList:getItems()) < 4 then
    self:createChatRow(params.newMsg, params.chatType)
  else
    self.chatList:removeItem(0)
    self:createChatRow(params.newMsg, params.chatType)
  end
  self.chatList:forceDoLayout()
  self.chatList:scrollToBottom(0.2, true)
end

function HomeLayer:createChatRow(data, chatType)
  local viewNode = ccui.Widget:create()
  viewNode:size(cc.size(448, 20)):addTo(self.chatList)
  viewNode:setCascadeOpacityEnabled(true)
  local label
  if data.player.roleId == -1 then
    label = MRichText.new({
      text = data.content,
      color = UIHelper.hex2rgb("#ffffff"),
      size = 14,
      maxWidth = 416
    }):anch(0, 0.5):pos(22, 9):addTo(viewNode)
    display.newSprite(BtnsRes .. "chat_build.png"):pos(-10, 0):addTo(label)
  else
    label = display.newTTFLabel({
      text = data.player.name .. "：" .. data.content,
      size = 14,
      dimensions = cc.size(416, 12)
    }):anch(0, 0.5):pos(22, 9):addTo(viewNode)
    display.newSprite(BtnsRes .. string.format("chat_%s.png", chatType)):pos(-10, 5):addTo(label)
  end
  if data.serverId then
    display.newSprite(BtnsRes .. "chat_cross.png"):pos(-10, 5):addTo(label)
  end
  label:setCascadeOpacityEnabled(true)
end

function HomeLayer:getNewChat()
  for _, value in pairs(game.role.redPoints.p2pRedPoints or {}) do
    if 0 < value then
      return true
    end
  end
  return false
end

function HomeLayer:handlerRedPoint(params)
  if params.type == "email" and self.mailBtn then
    local letter = self.mailBtn:getChildByTag(99)
    local action = letter:getActionByTag(99)
    local bShow = checkbool(next(game.role.redPoints.email or {}))
    if bShow and not action then
      action = letter:runAction(cc.RepeatForever:create(transition.sequence({
        cc.JumpBy:create(0.5, cc.p(0, 0), 20, 2),
        cc.DelayTime:create(2)
      })))
      action:setTag(99)
    elseif not bShow and action then
      letter:stopAllActions()
      letter:pos(70, 40)
    end
  elseif params.type == "trade" or params.type == "plant" or params.type == "collect" or params.type == "sign" then
    local bShow = checkbool(next(game.role.redPoints.plant or {}) or next(game.role.redPoints.collect or {}) or next(game.role.redPoints.sign or {}) or next(game.role.redPoints.trade or {}))
    self:showFarmRed(bShow)
  end
  self:handlerRed(params.type)
  self:handlerEntranceRed(params.type)
end

function HomeLayer:initRedPoint()
  local ignoreInit = {
    plant = 1,
    collect = 1,
    trade = 1,
    email = 1
  }
  for _, redString in pairs(self.redPoints) do
    local reds = redString:toArray("=", false)
    for _, redType in pairs(reds) do
      if ignoreInit[redType] then
      else
        self:handlerRed(redType)
      end
    end
  end
  self:handlerEntranceRed()
end

function HomeLayer:handlerRed(redType)
  local bShow = checkbool(next(game.role.redPoints[redType] or {}))
  if redType == "mission" or redType == "achieve" then
    bShow = checkbool(next(game.role.redPoints.mission)) or checkbool(next(game.role.redPoints.achieve))
    self:showMissionAnimation(bShow)
  elseif redType == "story" then
    self:showStoryAnimation(bShow)
  elseif redType == "kitchen" then
    self:showCookAnimation(bShow)
  elseif redType == "progress" then
    self:showBossRed(bShow)
  elseif redType == "union" then
    self:showUnionRed(bShow)
  elseif redType == "activity" then
    self:showActivityRed(bShow)
  elseif redType == "sign" then
    self:showFarmRed(bShow)
  elseif redType == "friend" then
    self:showFriendRed(bShow)
  elseif redType == "diner" then
    self:showDinerRed(bShow)
  elseif redType == "box" then
    if not CommonHelper.funcOpen("box") then
      return
    end
    local boxBtn = self.leftBg:getChildByName("boxBtn")
    UIHelper.showRedPoint(boxBtn, bShow, cc.p(7, 7))
  elseif redType == "lucky" then
    self:showLuckyRed(bShow)
  elseif redType == "pass" then
    bShow = checkbool(game.role.redPoints.pass[1]) or checkbool(game.role.redPoints.pass[2]) or checkbool(game.role.redPoints.pass[3])
    self:showPassRed(bShow)
  elseif redType == "unionBattle" then
    local btn = self["Btn" .. 89]
    if btn then
      self:showUnionBattleRed(btn)
    end
  end
end

function HomeLayer:handlerEntranceRed(redType)
  for actType, redStr in pairs(self.entranceBtns) do
    if redType and redType == redStr or not redType then
      local temp = redType and redType or redStr
      local bShow = checkbool(next(game.role.redPoints[temp] or {}))
      UIHelper.showRedPoint(self["Btn" .. actType], bShow, cc.p(-7, -7), 0.6)
    end
  end
end

function HomeLayer:showUnionBattleRed(btn)
  local unionDatas = unionBattleRewardCsv[3]
  local reward_record = game.role.activityStatus["89"].reward_record or {}
  local bShow = false
  for idx, data in ipairs(unionDatas) do
    local done = next(reward_record) and reward_record[tostring(300 + data.rewardId)]
    local canGet = tonumber(self.unionRankValue.unionScore or 0) >= data.condition
    if not done and canGet then
      bShow = true
      break
    end
  end
  local cShow = checkbool(game.role.redPoints.unionBattle.reward) or bShow
  UIHelper.showRedPoint(btn, cShow, cc.p(-7, -7), 0.6)
end

function HomeLayer:showPassRed(bShow)
  if self.taskBtn then
    local letter = self.taskBtn:getChildByTag(99)
    local action = letter:getActionByTag(99)
    if bShow and not action then
      action = letter:runAction(cc.RepeatForever:create(transition.sequence({
        cc.JumpBy:create(0.5, cc.p(0, 0), 15, 2),
        cc.DelayTime:create(2)
      })))
      action:setTag(99)
    elseif not bShow and action then
      letter:stopAllActions()
      letter:pos(60, 40)
    end
  end
end

function HomeLayer:showLuckyRed(mark)
  if self.extraBtn then
    UIHelper.showRedPoint(self.extraBtn, mark, cc.p(-7, -7), 1)
  end
end

function HomeLayer:showMissionAnimation(mark)
  local btn = self.rightBg:getChildByName("missionBtn")
  local letter = btn:getChildByTag(99)
  local action = letter:getActionByTag(99)
  letter:anch(0.2, 0)
  if btn and mark and not action then
    letter:show()
    action = letter:runAction(cc.RepeatForever:create(transition.sequence({
      cc.RotateBy:create(0.1, -25),
      cc.RotateBy:create(0.2, 50),
      cc.RotateBy:create(0.2, -50),
      cc.RotateBy:create(0.1, 25),
      cc.DelayTime:create(2)
    })))
    action:setTag(99)
  elseif btn and not mark then
    letter:stopAllActions()
    letter:hide()
  end
end

function HomeLayer:showStoryAnimation(mark)
  local btn = self.rightBg:getChildByName("storyBtn")
  local letter = btn:getChildByTag(99)
  local action = letter:getActionByTag(99)
  if btn and mark and not action then
    letter:pos(36, 38)
    action = letter:runAction(cc.RepeatForever:create(transition.sequence({
      cc.JumpBy:create(0.8, cc.p(0, 0), 10, 2),
      cc.DelayTime:create(2.5)
    })))
    action:setTag(99)
  elseif btn and not mark then
    letter:stopAllActions()
    letter:pos(36, 33)
  end
end

function HomeLayer:showCookAnimation(mark)
  local btn = self.centerBg:getChildByName("cookBtn")
  local red = btn:getChildByTag(99)
  if btn and mark and not red then
    red = display.newSprite(GlobalRes .. "kitchen_new.png"):scale(0.65):pos(180, 53):addTo(btn, nil, 99)
  elseif not mark and red then
    red:removeSelf()
  end
end

function HomeLayer:showBossRed(mark)
  local btn = self.centerBg:getChildByName("carbonBtn")
  local tip = btn:getChildByTag(99)
  if btn and mark and not tip then
    tip = display.newSprite(GlobalRes .. "boss_new.png"):pos(208, 120):addTo(btn, nil, 99)
    tip:setLocalZOrder(2)
  elseif not mark and tip then
    tip:removeSelf()
  end
end

function HomeLayer:showMoonRed(mark)
  local btn = self.centerBg:getChildByName("carbonBtn")
  local tip = btn:getChildByTag(98)
  if btn and mark and not tip then
    tip = display.newSprite(GlobalRes .. "msg_new.png"):pos(255, 120):addTo(btn, nil, 98)
  elseif not mark and tip then
    tip:removeSelf()
  end
end

function HomeLayer:showFarmRed(mark)
  local btn = self.centerBg:getChildByName("farmBtn")
  local red = btn:getChildByTag(99)
  if mark and not red then
    red = display.newSprite(GlobalRes .. "farm_new.png"):scale(0.65):pos(180, 52):addTo(btn, nil, 99)
  elseif not mark and red then
    red:removeSelf()
  end
end

function HomeLayer:showActivityRed(mark)
  local btn = self.centerBg:getChildByName("activityBtn")
  UIHelper.showRedPoint(btn, mark, cc.p(7, 7), 0.65)
end

function HomeLayer:showFriendRed(mark)
  local btn = self.centerBg:getChildByName("friendBtn")
  UIHelper.showRedPoint(btn, mark, cc.p(7, 7), 0.65)
end

function HomeLayer:showDinerRed(mark)
  local btn = self.rightBg:getChildByName("dinerBtn")
  UIHelper.showRedPoint(btn, mark, cc.p(7, 7), 0.7)
end

function HomeLayer:showUnionRed(mark)
  local btn = self.rightBg:getChildByName("unionBtn")
  UIHelper.showRedPoint(btn, mark, cc.p(7, 7), 0.7)
end

function HomeLayer:showChatRed()
  local action = self.chatC:getActionByTag(99)
  if self:getNewChat() and not action then
    action = self.chatC:runAction(cc.RepeatForever:create(transition.sequence({
      cc.RotateBy:create(0.05, -25),
      cc.RotateBy:create(0.1, 50),
      cc.RotateBy:create(0.1, -50),
      cc.RotateBy:create(0.05, 25),
      cc.DelayTime:create(2.5)
    })))
    action:setTag(99)
  elseif not self:getNewChat() and action then
    self.chatC:stopAllActions()
    self.chatC:setRotation(0)
  end
end

function HomeLayer:showPendants()
  if self.pendantType == 0 then
    return
  end
  local paths = {
    "snow_",
    "newyear_",
    "chunjie_",
    "sakura_",
    "summer_",
    ""
  }
  local posXY = {
    [1] = {
      {
        0,
        9,
        1
      },
      {
        0,
        4,
        1
      },
      {
        0,
        4,
        1
      },
      {
        0,
        4,
        1
      },
      {
        0,
        3,
        1
      },
      {
        -17,
        10,
        1
      },
      {
        4,
        18,
        1
      }
    },
    [2] = {
      {
        0,
        -5,
        1
      },
      {
        0,
        4,
        0
      },
      {
        0,
        4,
        0
      },
      {
        0,
        0,
        0
      },
      {
        0,
        7,
        0
      },
      {
        0,
        12,
        0
      },
      {
        0,
        12,
        0
      }
    },
    [3] = {
      {
        0,
        5,
        1
      },
      {
        8,
        20,
        1
      },
      {
        -5,
        10,
        1
      },
      {
        0,
        8,
        1
      },
      {
        0,
        35,
        1
      },
      {
        20,
        60,
        1
      },
      {
        4,
        18,
        0
      }
    },
    [4] = {
      {
        0,
        12,
        1
      },
      {
        0,
        4,
        1
      },
      {
        0,
        4,
        1
      },
      {
        0,
        0,
        0
      },
      {
        0,
        7,
        0
      },
      {
        0,
        12,
        1
      },
      {
        0,
        12,
        0
      }
    },
    [5] = {
      {
        0,
        12,
        1
      },
      {
        5,
        7,
        1
      },
      {
        -7,
        13,
        1
      },
      {
        0,
        14,
        1
      },
      {
        0,
        7,
        1
      },
      {
        -15,
        90,
        1
      },
      {
        -21,
        24,
        0
      }
    },
    [6] = {
      {
        0,
        12,
        0
      },
      {
        0,
        4,
        0
      },
      {
        0,
        4,
        0
      },
      {
        0,
        0,
        0
      },
      {
        0,
        7,
        0
      },
      {
        0,
        12,
        0
      },
      {
        0,
        12,
        0
      }
    }
  }
  local pathName = paths[self.pendantType]
  if not pathName then
    return
  end
  local names = {
    "scrollView",
    "cookBtn",
    "farmBtn",
    "carbonBtn",
    "chatBtn",
    "leftBg",
    "rightBg"
  }
  for index, name in ipairs(names) do
    local dalte = posXY[self.pendantType]
    if dalte[index][3] == 1 then
      local btn = index == 1 and self[name]:getKuang() or self[name]
      local size = btn:getContentSize()
      display.newSprite(PendantRes .. pathName .. name .. ".png"):anch(0.5, 1):pos(size.width / 2 + dalte[index][1], size.height + dalte[index][2]):addTo(btn)
    end
  end
end

function HomeLayer:showDrawSign()
  local cx, cy, width, height = display.cx, display.cy, display.width, display.height
  local movex = 0
  if UIHelper.isiPhoneX() then
    movex = UIHelper.getMoveXForX(true)
    cx, cy, width = cx + movex, cy, width + movex * 2
  end
  local mask = UIHelper.newMask({
    size = cc.size(width, height),
    color = "#000000",
    opacity = 191
  })
  mask:anch(0.5, 0.5):pos(cx, cy):addTo(display.getRunningScene(), 100)
  mask:setTouchEnabled(true)
  mask:setSwallowTouches(true)
  local node = display.newNode():pos(568 + movex, 10):addTo(mask)
  local sign = UIHelper.createSpineNodeByRes("spine/ui/activity/cqt")
  sign:setAnimation(0, "chuxian", false)
  sign:pos(0, 270):addTo(node)
  display.newTTFLabel({
    text = "1. 活动期间，每日登录游戏即可免费进行抽签，根据签面可获得一定数量的 “烹饪券”（每日仅首抽能够获得道具）\n2. 抽签小游戏仅供娱乐，签面结果不会对游戏内的概率、数字造成实际影响。",
    size = 18,
    color = UIHelper.hex2rgb("#d1bfa9")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(0.5, 0):pos(0, 10):addTo(node)
  local status = game.role.activityStatus["66"] or ""
  local res, sum = 0, {
    4,
    6,
    7
  }
  local waitting = false
  local signRes = "ui/activity/66/"
  local animat = {
    "yaojiang",
    "zhongji",
    "xiaoji"
  }
  
  local function showAnimation(gift)
    node:runAction(transition.sequence({
      cc.CallFunc:create(function()
        sign:setToSetupPose()
        sign:setAnimation(0, animat[res], false)
      end),
      cc.DelayTime:create(4),
      cc.CallFunc:create(function()
        sign:removeSelf()
        local imgStr = signRes .. string.format("%d_%d.png", res, math.random(1, sum[res]))
        local image = display.newSprite(imgStr):pos(0, 350):addTo(node)
        image:scale(0.4)
        image:runAction(cc.EaseElasticOut:create(cc.ScaleTo:create(0.8, 1)))
        local btnClose = UIHelper.extend(ccui.Button:create())
        btnClose:setImages(signRes, {
          "btn_close.png",
          "btn_close.png"
        })
        btnClose:pos(265, 530):addTo(image):setTouchScale()
        btnClose:setCallback(function()
          mask:removeFromParent()
        end)
        local btnShare = UIHelper.extend(ccui.Button:create())
        btnShare:setImages(signRes, {
          "btn_share.png",
          "btn_share.png"
        })
        btnShare:pos(250, 130):addTo(node):setTouchScale()
        btnShare:setCallback(function()
          btnShare:setTouchEnabled(false)
          btnShare:runAction(transition.sequence({
            cc.DelayTime:create(0.2),
            cc.CallFunc:create(function()
              btnShare:setTouchEnabled(true)
            end)
          }))
          local path = self:getShareScreen(signRes, imgStr)
          local content = textByKey("activity_66_share")
          scheduler.performWithDelayGlobal(function()
            umeng.shareContent({content = content, image = path})
          end, 0.08333333333333333)
          if status:getv(2, 0) < 0 then
            return
          end
          game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({type = 66, id = 2}))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
            UIHelper.removeWaiting()
            local msg = MsgPack.unpack(event.data)
            image:runAction(transition.sequence({
              cc.DelayTime:create(5),
              cc.CallFunc:create(function()
                MedalRewardLayer.new({
                  items = msg.reward
                })
                mask:removeFromParent()
              end)
            }))
          end)
        end)
        btnShare:hide()
      end),
      cc.DelayTime:create(1),
      cc.CallFunc:create(function()
        if gift then
          MedalRewardLayer.new({items = gift})
        end
      end)
    }))
  end
  
  mask:setCallback(function()
    if waitting then
      return
    end
    waitting = true
    if status:getv(1, 0) < 0 then
      res = math.random(1, 3)
      showAnimation()
    else
      game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({type = 66, id = 1}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        res = msg.result
        showAnimation(msg.reward)
      end)
    end
  end)
end

function HomeLayer:initTimeLimitGiftLayer()
  game:addResponseHandler(actionCodes.Activity_timeLimitGiftRpc, function(event)
    local msg = MsgPack.unpack(event.data)
    local activityType = msg.type
    local startTime = msg.startTime
    local layer = game:createView("timelimitgift.TimeLimitGiftLayer", {type = activityType, startTime = startTime})
  end)
end

function HomeLayer:getShareScreen(res, img)
  local path = "shareScreen.png"
  local renderTexture = cc.RenderTexture:create(display.width, display.height)
  renderTexture:begin()
  local mainBg = display.newSprite(res .. string.format("share_bg_%d.png", math.random(1, 3))):anch(0, 0)
  display.newSprite(img):pos(780, 320):addTo(mainBg)
  mainBg:visit()
  renderTexture:endToLua()
  if renderTexture:saveToFile(path, kCCImageFormatPNG) then
    return string.gsub(device.writablePath, "[\\\\/]+$", "") .. device.directorySeparator .. path
  end
end

function HomeLayer:showMask(time)
  time = time or 1.5
  self.mask = true
  local mask = UIHelper.newMask({
    size = cc.size(display.width * 2, display.height),
    opacity = 0
  })
  mask:anch(0.5, 0.5):pos(display.width / 2, display.height / 2):addTo(self)
  mask:setTouchEnabled(true)
  mask:setSwallowTouches(true)
  mask:runAction(transition.sequence({
    cc.DelayTime:create(time),
    cc.CallFunc:create(function()
      self.mask = nil
    end),
    cc.RemoveSelf:create()
  }))
end

function HomeLayer:checkGuide()
  NewGuideLayer.new({step = 10})
  NewGuideLayer.new({step = 11})
  NewGuideLayer.new({step = 12})
  NewGuideLayer.new({step = 13})
  NewGuideLayer.new({step = 14})
  NewGuideLayer.new({step = 15})
  NewGuideLayer.new({step = 16})
end

function HomeLayer:onExit()
  for _, tag in ipairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
  if self.timerHandler then
    scheduler.unscheduleGlobal(self.timerHandler)
  end
end

return HomeLayer
