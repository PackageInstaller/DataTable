local FramCsv = require("csvdata.head_circle")
local PicCsv = require("csvdata.head_pic")
local UnionExpCsv = require("csvdata.union_exp")
local ManageRes = "ui/union/manage/"
local uiData = {
  csbFile = "ui/union/UnionManageLayer.csb",
  widgets = {
    mainBg = "mainBg",
    up = "up",
    mask = "mask",
    btnsNode = "btnsNode",
    leftBg = "leftBg",
    rightBg = "rightBg",
    list = "rightBg/list"
  }
}
local UnionManageLayer = class("UnionManageLayer", UIBase)

function UnionManageLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function UnionManageLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    UIHelper.fitForiPhoneX(self.up, true)
    self.rightBg:setPositionX(self.rightBg:getPositionX() + 75)
    self.btnsNode:setPositionX(self.btnsNode:getPositionX() + 75)
  end
  self.union = game.role.unionData
  TopBar:show(TopBarType.full, "协会")
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up
  })
  self.mask:setTouchEnabled(true)
  self.mask:setSwallowTouches(true)
  self.mask:hide()
end

function UnionManageLayer:showData(params)
  local texts = {
    "会员名单",
    "道场美味度",
    "累计捐献财富",
    "状态"
  }
  local xPoss = {
    125,
    310,
    485,
    670
  }
  for idx, key in ipairs(texts) do
    display.newTTFLabel({
      text = texts[idx],
      size = 22
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(xPoss[idx], 460):addTo(self.rightBg)
  end
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(ManageRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(20, 492):addTo(self.rightBg)
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {typeStr = "union"})
  end)
  self:initLeft()
  self:initRight()
  self:initDown()
end

function UnionManageLayer:initDown()
  self.btnData = {
    [1] = {
      name = "协会副本",
      callback = handler(self, self.newWorldBossFunc)
    },
    [2] = {
      name = "协会竞赛",
      callback = handler(self, self.showUnionBattle)
    },
    [3] = {
      name = "协会科技",
      callback = handler(self, self.techFunc)
    },
    [4] = {
      name = "协会捐献",
      callback = handler(self, self.donateFunc)
    },
    [5] = {
      name = "协会商店",
      callback = handler(self, self.shopFunc)
    }
  }
  btnFunc = {
    self.emptyFunc,
    self.emptyFunc,
    self.emptyFunc,
    self.DonateFunc
  }
  local posX = 152
  for k, data in ipairs(self.btnData) do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(ManageRes, {"btn_a.png", "btn_b.png"})
    btn:pos(posX, -30):addTo(self.rightBg):setTouchScale()
    btn:setString({
      text = data.name,
      size = 24
    })
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
    btn:setCallback(function()
      data.callback(self)
    end)
    posX = posX + 136
  end
end

function UnionManageLayer:newWorldBossFunc()
  if not game.role:activityIsOpen(107) then
    SysError(SYS_ERR_UNIONBATTLE_NOT_OPEN)
    return
  end
  local layer = game:createView("worldboss.NewWorldBossLayer")
  BackManager:push(function()
    layer:close()
    TopBar:show(TopBarType.full, "协会")
    self:refreshCallback()
  end)
end

function UnionManageLayer:emptyFunc()
  SysError(SYS_ERR_FUNCTION_NOT_OPEN)
end

function UnionManageLayer:CheckUnionBattleStage()
  local curStatus = game.role.activityStatus["89"]
  local backStatus = json.decode(game.role.activityBackStatus)
  local openStatus = backStatus["90"] and backStatus["90"].start < game:nowTime() and backStatus["90"].close > game:nowTime()
  if not curStatus or curStatus.status ~= 1 or not openStatus then
    return false
  end
  return true
end

function UnionManageLayer:CheckUnionBattleRegist()
  local curStatus = game.role.activityStatus["89"]
  local backStatus = json.decode(game.role.activityBackStatus)
  local openStatus = backStatus["90"] and backStatus["90"].start < game:nowTime() and backStatus["90"].close > game:nowTime()
  if curStatus and curStatus.status ~= 1 and openStatus then
    return false
  end
  return true
end

function UnionManageLayer:showUnionBattle()
  if not game.role:activityIsOpen(89) then
    SysError(SYS_ERR_UNIONBATTLE_NOT_OPEN)
    return
  end
  local arg1 = "union.UnionBattlePrepareLayer"
  local arg2 = "UnionBattleScene"
  local curStatus = game.role.activityStatus["89"]
  if not self:CheckUnionBattleRegist() then
    SysError(SYS_ERR_UNIONBATTLE_TIMEOUT)
    return
  end
  if not self:CheckUnionBattleStage() then
    game:createView(arg1, {layer = "union"})
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

function UnionManageLayer:refreshCallback()
  self.union = game.role.unionData
  self.scoreText:setString("协会总贡献:" .. (self.union.score or 0))
  self.moneyText:setString("协会财富:" .. (self.union.money or 0))
  self:initRight()
end

function UnionManageLayer:donateFunc()
  game:createView("union.UnionDonateLayer", {
    money = self.union.money,
    callback = function()
      self:refreshCallback()
    end
  })
end

function UnionManageLayer:shopFunc()
  local layer = game:createView("union.UnionShopLayer", {
    money = self.union.money
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(TopBarType.full, "协会")
    self:refreshCallback()
  end)
end

function UnionManageLayer:techFunc()
  local layer = game:createView("union.UnionTechLayer")
  BackManager:push(function()
    layer:close()
    TopBar:show(TopBarType.full, "协会")
    self:refreshCallback()
  end)
end

function UnionManageLayer:initLeft()
  local nameLab = display.newTTFLabel({
    text = self.union.name,
    size = 26,
    color = UIHelper.hex2rgb("#fdfffa")
  }):enableOutline(UIHelper.hex2rgb("#431b05"), 2):pos(129, 542):addTo(self.leftBg)
  local icon = UIHelper.newImageView(string.format("ui/union/main/icon_%d.png", self.union.headId)):pos(129, 460):addTo(self.leftBg)
  icon:setCallback(function()
    if self.union.managers:getv(game.role.id, 0) <= 0 then
      return
    end
    local layer = game:createView("union.UnionCreateLayer", {change = true})
    BackManager:push(function()
      layer:close()
      nameLab:setString(self.union.name)
      icon:setImage(string.format("ui/union/main/icon_%d.png", self.union.headId))
    end)
  end)
  display.newTTFLabel({text = "Lv:", size = 30}):enableOutline(UIHelper.hex2rgb("#4a1406"), 2):anch(1, 0.5):pos(129, 384):addTo(self.leftBg)
  self.level = display.newTTFLabel({
    text = self.union.level,
    size = 30,
    color = UIHelper.hex2rgb("#f3db0c")
  }):enableOutline(UIHelper.hex2rgb("#4a1406"), 2):anch(0, 0.5):pos(129, 384):addTo(self.leftBg)
  local barBg = display.newSprite(ManageRes .. "bar_bg.png"):pos(129, 347):addTo(self.leftBg)
  self.bar = display.newProgressTimer(ManageRes .. "bar.png", 1):center(barBg):addTo(barBg)
  self.bar:setMidpoint(cc.p(0, 0.5))
  self.bar:setBarChangeRate(cc.p(1, 0))
  self.bar:setPercentage(0)
  self.exp = display.newTTFLabel({
    text = string.format("%d/%d", self.union.exp, 0),
    size = 20
  }):enableOutline(UIHelper.hex2rgb("#140901"), 1):pos(110, 12):addTo(barBg)
  display.newTTFLabel({
    text = string.format("协会ID:%s", self.union.id),
    size = 18,
    color = UIHelper.hex2rgb("#fdfffa")
  }):enableOutline(UIHelper.hex2rgb("#431b05"), 1):anch(0, 0.5):pos(40, 323):addTo(self.leftBg)
  display.newTTFLabel({
    text = string.format("协会成员:%s/%s", self.union.had, self.union.level * 5),
    size = 18,
    color = UIHelper.hex2rgb("#fdfffa")
  })
  display.newTTFLabel({
    text = string.format("协会成员:%s/%s", self.union.had, CommonHelper.getUnionMemberMax(self.union.level, self.union.unionTech)),
    size = 18,
    color = UIHelper.hex2rgb("#fdfffa")
  }):enableOutline(UIHelper.hex2rgb("#431b05"), 1):anch(0, 0.5):pos(40, 289):addTo(self.leftBg)
  self.scoreText = display.newTTFLabel({
    text = string.format("协会总贡献:%s", self.union.score or 0),
    size = 18,
    color = UIHelper.hex2rgb("#fdfffa")
  }):enableOutline(UIHelper.hex2rgb("#431b05"), 1):anch(0, 0.5):pos(40, 255):addTo(self.leftBg)
  self.moneyText = display.newTTFLabel({
    text = string.format("协会财富:%s", self.union.money or 0),
    size = 18,
    color = UIHelper.hex2rgb("#fdfffa")
  }):enableOutline(UIHelper.hex2rgb("#431b05"), 1):anch(0, 0.5):pos(40, 223):addTo(self.leftBg)
  display.newTTFLabel({
    text = "协会守则",
    size = 20,
    color = UIHelper.hex2rgb("#fdfffa")
  }):enableOutline(UIHelper.hex2rgb("#1e0b03"), 1):pos(129, 195):addTo(self.leftBg)
  local btn = UIHelper.newImageView(ManageRes .. "order_bg.png"):anch(0, 0):pos(21, 91):addTo(self.leftBg)
  local temp = self.union.order == "" and "请输入内容" or self.union.order
  local orderLab = display.newTTFLabel({
    text = temp,
    size = 16,
    color = UIHelper.hex2rgb("#fdfffa"),
    dimensions = cc.size(214, 0)
  }):enableOutline(UIHelper.hex2rgb("#1e0b03"), 1):anch(0, 1):pos(20, 179):addTo(self.leftBg)
  btn:setCallback(function()
    if self.union.managers:getv(game.role.id, 0) <= 0 then
      return
    end
    local layer = game:createView("common.InputLayer", {
      longth = 20,
      callback = function(str)
        game:sendData(actionCodes.Union_changeSetRpc, MsgPack.pack({type = 3, desc = str}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Union_changeSetRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          if msg.code then
            SysError(msg.code)
            return
          end
          SysError(SYS_ERR_UNION_HANDLE_SUCCESS)
          orderLab:setString(str)
          BackManager:pop()
        end)
      end
    })
    BackManager:push(function()
      layer:close()
    end)
  end)
  local btnLog = UIHelper.extend(ccui.Button:create())
  btnLog:setImages(ManageRes, {
    "btn_log.png",
    "btn_log.png"
  })
  btnLog:pos(54, 48):addTo(self.leftBg)
  btnLog:setTouchScale()
  btnLog:setCallback(function()
    if self.refreshHandler then
      scheduler.unscheduleGlobal(self.refreshHandler)
    end
    local mask, listBg = UIHelper.showOnleImgUnionTip(ManageRes .. "log_bg.png", {760, 430})
    self.logList = ccui.ListView:create()
    self.logList:size(cc.size(740, 418))
    self.logList:setInnerContainerSize(cc.size(740, 418))
    self.logList:setClippingEnabled(true)
    self.logList:setBounceEnabled(true)
    self.logList:anch(0, 0):pos(4, 4):addTo(listBg)
    game:sendData(actionCodes.Union_unionLogRpc, MsgPack.pack({}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Union_unionLogRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      self.logData = msg.result
      table.sort(self.logData, function(a, b)
        if a.time == b.time and a.name == b.name then
          return a.type < b.type
        else
          return a.time < b.time
        end
      end)
      self.curRow = 0
      self.tempTime = ""
      self.logList:removeAllChildren()
      self.refreshHandler = scheduler.scheduleGlobal(function()
        self:showLog()
      end, 0.016666666666666666)
    end)
  end)
  local btnManage = UIHelper.extend(ccui.Button:create())
  btnManage:setImages(ManageRes, {
    "btn_manage.png",
    "btn_manage.png"
  })
  btnManage:pos(170, 48):addTo(self.leftBg)
  btnManage:setTouchScale()
  display.newTTFLabel({
    text = "协会管理",
    size = 24
  }):enableOutline(UIHelper.hex2rgb("#81450b"), 1):pos(70, 32):addTo(btnManage)
  local extraNode
  btnManage:setCallback(function()
    if not tolua.isnull(extraNode) then
      extraNode:removeFromParent()
      return
    end
    extraNode = display.newNode():pos(170, 48):addTo(self.leftBg)
    local btnExit = UIHelper.extend(ccui.Button:create())
    btnExit:setImages(ManageRes, {
      "btn_normal.png",
      "btn_normal.png"
    })
    btnExit:pos(0, 70):addTo(extraNode)
    btnExit:setTouchScale()
    btnExit:setCallback(function()
      local function sendQuitMessage()
        if self.union.managers:getv(game.role.id, 0) == 1 and 1 < #self.union.members then
          SysError(SYS_ERR_UNION_MANAGE_TRANSFER_RIGHT)
          
          return
        end
        game:sendData(actionCodes.Union_changeMemberRpc, MsgPack.pack({
          type = 3,
          id = game.role.id
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Union_changeMemberRpc, function(event)
          UIHelper.removeWaiting()
          game.role.unionData = nil
          game.role.union = 0
          game:enterScene("MainScene")
        end)
      end
      
      MDialog:double({
        text = "主厨确定要退出协会吗？",
        size = 24,
        color = UIHelper.hex2rgb("#430602"),
        cancelCallback = function()
          return true
        end,
        okCallback = function()
          sendQuitMessage()
          return true
        end
      })
    end)
    display.newTTFLabel({
      text = "退出协会",
      size = 24,
      color = UIHelper.hex2rgb("#8c3711")
    }):pos(73, 30):addTo(btnExit)
    if 0 >= self.union.managers:getv(game.role.id, 0) then
      return
    end
    local leftTime = math.max(0, self.union.adTime - game:nowTime())
    local btnAD = UIHelper.extend(ccui.Button:create())
    btnAD:setImages(ManageRes, {
      " btn_special.png",
      " btn_special.png"
    })
    btnAD:pos(0, 190):addTo(extraNode)
    btnAD:setTouchScale()
    btnAD:setCallback(function()
      if 0 < leftTime then
        return
      end
      extraNode:removeFromParent()
      local layer = game:createView("union.UnionAdvertiseLayer", {
        callback = function()
          BackManager:pop()
        end
      })
      BackManager:push(function()
        layer:close()
      end)
    end)
    display.newTTFLabel({
      text = string.format("剩余%d天", math.ceil(leftTime / 86400)),
      size = 14
    }):enableOutline(UIHelper.hex2rgb("#532a0b"), 1):pos(73, 16):addTo(btnAD)
    display.newTTFLabel({
      text = "广告",
      size = 24,
      color = UIHelper.hex2rgb("#8c3711")
    }):pos(73, 40):addTo(btnAD)
    local btnJoin = UIHelper.extend(ccui.Button:create())
    btnJoin:setImages(ManageRes, {
      "btn_normal.png",
      "btn_normal.png"
    })
    btnJoin:pos(0, 130):addTo(extraNode)
    btnJoin:setTouchScale()
    btnJoin:setCallback(function()
      game:sendData(actionCodes.Union_applyListRpc, MsgPack.pack({}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Union_applyListRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        extraNode:removeFromParent()
        local layer = game:createView("union.UnionRecruitLayer", {
          list = msg.result,
          callback = function()
            BackManager:pop()
          end
        })
        BackManager:push(function()
          layer:close()
          self:initRight()
        end)
      end)
    end)
    display.newTTFLabel({
      text = "招募",
      size = 24,
      color = UIHelper.hex2rgb("#8c3711")
    }):pos(73, 30):addTo(btnJoin)
  end)
  self:updateUnionExp()
end

function UnionManageLayer:updateUnionExp()
  if self.union.level > #UnionExpCsv then
    self.bar:setPercentage(100)
    self.exp:setString("Max")
    self.level:setString("Max")
    return
  end
  local levelData = UnionExpCsv[self.union.level]
  self.bar:setPercentage(self.union.exp / levelData.exp * 100)
  self.exp:setString(string.format("%d/%d", self.union.exp, levelData.exp))
  self.level:setString(self.union.level)
end

function UnionManageLayer:initRight()
  self.list:removeAllChildren()
  table.sort(self.union.members, function(a, b)
    local mLeveA = self.union.managers:getv(a.id, 0)
    local mLeveB = self.union.managers:getv(b.id, 0)
    local factorA = (mLeveA == 1 and 5 or mLeveA) * 1000000 + (a.online and 1 or 0) * 100000 + (a.unionDonateWealthCount or 0)
    local factorB = (mLeveB == 1 and 5 or mLeveB) * 1000000 + (b.online and 1 or 0) * 100000 + (b.unionDonateWealthCount or 0)
    if factorA == factorB then
      return a.level * 100000 + a.battle > b.level * 100000 + b.battle
    end
    return factorA > factorB
  end)
  local clickIdx, cellMask = 0
  for idx, data in ipairs(self.union.members) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(770, 80)):addTo(self.list)
    local cell = UIHelper.newImageView(ManageRes .. "cell.png"):center(viewNode):addTo(viewNode)
    display.newSprite(PicCsv[data.headIconTag or 1].res):scale(0.5):pos(40, 41):addTo(cell)
    display.newSprite(FramCsv[data.headFrameTag or 1].res):scale(0.5):pos(40, 41):addTo(cell)
    display.newTTFLabel({
      text = string.format("Lv %d", data.level),
      size = 18,
      color = UIHelper.hex2rgb("#ba471a")
    }):anch(0, 0.5):pos(90, 64):addTo(cell)
    local name = display.newTTFLabel({
      text = data.name,
      size = 20,
      color = UIHelper.hex2rgb(game.role.id == data.id and "#4aa60c" or "#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#431b05"), 1):anch(0, 0.5):pos(90, 44):addTo(cell)
    UIHelper.setMaxWidth(name, 136)
    local rightLevel = self.union.managers:getv(data.id, 0)
    display.newTTFLabel({
      text = rightLevel == 1 and "会长" or rightLevel == 0 and "会员" or "副会长",
      size = 17
    }):enableOutline(UIHelper.hex2rgb("#431b05"), 1):pos(125, 19):addTo(cell)
    display.newTTFLabel({
      text = data.battle or 0,
      size = 30
    }):enableOutline(UIHelper.hex2rgb("#532a0b"), 1):anch(1, 0.5):pos(342, 40):addTo(cell)
    display.newTTFLabel({
      text = data.unionDonateWealthCount or 0,
      size = 30
    }):enableOutline(UIHelper.hex2rgb("#532a0b"), 1):anch(1, 0.5):pos(524, 40):addTo(cell)
    if data.online then
      display.newTTFLabel({
        text = "在线",
        size = 16,
        color = UIHelper.hex2rgb("#4aa60c")
      }):pos(655, 40):addTo(cell)
    else
      display.newTTFLabel({
        text = "最后上线: " .. UIHelper.getPassTimeDesc(game:nowTime() - data.lastLoginTime),
        size = 16,
        color = UIHelper.hex2rgb("#ba471a")
      }):anch(0, 0.5):pos(600, 40):addTo(cell)
    end
    cell:setCallback(function()
      if game.role.id == data.id then
        return
      end
      if clickIdx == data.id then
        clickIdx = 0
        cellMask:removeFromParent()
        return
      end
      if not tolua.isnull(cellMask) then
        cellMask:removeFromParent()
      end
      clickIdx = data.id
      cellMask = display.newSprite(ManageRes .. "cell_mask.png"):center(cell):addTo(cell)
      local manageLevel = self.union.managers:getv(game.role.id, 0)
      local xPos = 655
      local btn1 = UIHelper.extend(ccui.Button:create())
      btn1:setImages(ManageRes, {
        "btn_extra.png",
        "btn_extra.png"
      })
      btn1:pos(xPos, 36):addTo(cellMask)
      btn1:setTouchScale()
      btn1:setCallback(function()
        MDialog:double({
          text = "确定要申请添加好友吗？",
          size = 24,
          color = UIHelper.hex2rgb("#430602"),
          cancelCallback = function()
            return true
          end,
          okCallback = function()
            game:sendData(actionCodes.Friend_applyRpc, MsgPack.pack({
              roleId = data.id
            }))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Friend_applyRpc, function(event)
              UIHelper.removeWaiting()
              local msgRes = MsgPack.unpack(event.data)
              if not msgRes.result then
                SysError(SYS_ERROR_FRIEND_APPLIED)
                return
              end
              SysError(msgRes.result)
            end)
            return true
          end
        })
      end)
      display.newTTFLabel({
        text = "好友添加",
        size = 14
      }):enableOutline(UIHelper.hex2rgb("#8a450e"), 1):pos(46, 23):addTo(btn1)
      xPos = xPos - 100
      if rightLevel == 0 and manageLevel ~= 0 then
        local btn2 = UIHelper.extend(ccui.Button:create())
        btn2:setImages(ManageRes, {
          "btn_extra.png",
          "btn_extra.png"
        })
        btn2:pos(xPos, 36):addTo(cellMask)
        btn2:setTouchScale()
        btn2:setCallback(function()
          MDialog:double({
            text = "确定要将该玩家逐出协会吗？",
            size = 24,
            color = UIHelper.hex2rgb("#430602"),
            cancelCallback = function()
              return true
            end,
            okCallback = function()
              game:sendData(actionCodes.Union_changeMemberRpc, MsgPack.pack({
                id = data.id,
                type = 2
              }))
              UIHelper.showWaiting()
              game:addResponseHandler(actionCodes.Union_changeMemberRpc, function(event)
                UIHelper.removeWaiting()
                table.remove(self.union.members, idx)
                self:initRight()
              end)
              return true
            end
          })
        end)
        display.newTTFLabel({
          text = "逐出协会",
          size = 14
        }):enableOutline(UIHelper.hex2rgb("#8a450e"), 1):pos(46, 23):addTo(btn2)
        xPos = xPos - 100
      end
      if manageLevel == 1 then
        local btn3 = UIHelper.extend(ccui.Button:create())
        btn3:setImages(ManageRes, {
          "btn_extra.png",
          "btn_extra.png"
        })
        btn3:pos(xPos, 36):addTo(cellMask)
        btn3:setTouchScale()
        btn3:setCallback(function()
          MDialog:double({
            text = "确定要变更副会长权利吗？",
            size = 24,
            color = UIHelper.hex2rgb("#430602"),
            cancelCallback = function()
              return true
            end,
            okCallback = function()
              ame:sendData(actionCodes.Union_setManagerRightRpc, MsgPack.pack({
                id = data.id,
                type = rightLevel == 2 and 3 or 2
              }))
              UIHelper.showWaiting()
              game:addResponseHandler(actionCodes.Union_setManagerRightRpc, function(event)
                UIHelper.removeWaiting()
                self:initRight()
              end)
              return true
            end
          })
        end)
        display.newTTFLabel({
          text = rightLevel == 2 and "取消副会长" or "任命副会长",
          size = 14
        }):enableOutline(UIHelper.hex2rgb("#8a450e"), 1):pos(46, 23):addTo(btn3)
        xPos = xPos - 100
        local btn4 = UIHelper.extend(ccui.Button:create())
        btn4:setImages(ManageRes, {
          "btn_extra.png",
          "btn_extra.png"
        })
        btn4:pos(xPos, 36):addTo(cellMask)
        btn4:setTouchScale()
        btn4:setCallback(function()
          MDialog:double({
            text = "主厨确定要移交会长权利吗？",
            size = 24,
            color = UIHelper.hex2rgb("#430602"),
            cancelCallback = function()
              return true
            end,
            okCallback = function()
              game:sendData(actionCodes.Union_setManagerRightRpc, MsgPack.pack({
                id = data.id,
                type = 1
              }))
              UIHelper.showWaiting()
              game:addResponseHandler(actionCodes.Union_setManagerRightRpc, function(event)
                UIHelper.removeWaiting()
                self:initRight()
              end)
              return true
            end
          })
        end)
        display.newTTFLabel({
          text = "转移会长",
          size = 14
        }):enableOutline(UIHelper.hex2rgb("#8a450e"), 1):pos(46, 23):addTo(btn4)
      end
    end)
  end
end

function UnionManageLayer:showLog()
  for row = self.curRow + 1, self.curRow + 10 do
    if row > #self.logData then
      if self.refreshHandler then
        scheduler.unscheduleGlobal(self.refreshHandler)
        self.refreshHandler = nil
      end
      if not next(self.logData) then
        local bg = display.newSprite("ui/hero/tip_bg.png"):center(self.logList):addTo(self.logList)
        display.newTTFLabel({
          text = "暂时没有数据",
          size = 26,
          color = UIHelper.hex2rgb("#842c17")
        }):pos(395, 120):addTo(bg)
      end
      self.logList:requestDoLayout()
      self.logList:jumpToBottom()
      return
    end
    local data = self.logData[row]
    local tempTime = CommonHelper.date(data.time, "ymd")
    if self.tempTime ~= tempTime then
      if self.tempTime ~= "" then
        local viewNode = ccui.Widget:create()
        viewNode:setContentSize(cc.size(740, 14)):addTo(self.logList)
        display.newSprite(ManageRes .. "log_line.png"):center(viewNode):addTo(viewNode)
      end
      self.tempTime = tempTime
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(cc.size(740, 20)):addTo(self.logList)
      display.newTTFLabel({
        text = tempTime,
        size = 20,
        color = UIHelper.hex2rgb("#f9b616")
      }):enableOutline(UIHelper.hex2rgb("#1e0b03"), 1):anch(0, 0.5):pos(20, 13):addTo(viewNode)
    end
    self:createLogContent(data):addTo(self.logList)
  end
  self.curRow = self.curRow + 10
end

local typeDescs = {
  "加入了协会",
  "退出了协会",
  "通过捐献增加了",
  "成为副会长",
  "被取消副会长",
  "成为会长",
  "通过捐献为协会增加了"
}

function UnionManageLayer:createLogContent(params)
  local viewNode = ccui.Widget:create()
  viewNode:setContentSize(cc.size(740, 24))
  local xPos = 55
  local name = display.newTTFLabel({
    text = params.name,
    size = 18,
    color = UIHelper.hex2rgb("#cb6528")
  }):enableOutline(UIHelper.hex2rgb("#1e0b03"), 1):anch(0, 0.5):pos(xPos, 13):addTo(viewNode)
  xPos = xPos + name:getContentSize().width
  if params.type == 2 and params.name1 then
    display.newTTFLabel({text = "被", size = 18}):anch(0, 0.5):pos(xPos, 14):addTo(viewNode)
    local name1 = display.newTTFLabel({
      text = params.name1,
      size = 18,
      color = UIHelper.hex2rgb("#cb6528")
    }):enableOutline(UIHelper.hex2rgb("#1e0b03"), 1):anch(0, 0.5):pos(xPos + 18, 14):addTo(viewNode)
    xPos = xPos + name1:getContentSize().width
    display.newTTFLabel({
      text = "踢出了协会",
      size = 18
    }):enableOutline(UIHelper.hex2rgb("#1e0b03"), 1):anch(0, 0.5):pos(xPos + 18, 14):addTo(viewNode)
  elseif params.type == 3 then
    local desc = display.newTTFLabel({
      text = typeDescs[params.type],
      size = 18
    }):enableOutline(UIHelper.hex2rgb("#1e0b03"), 1):anch(0, 0.5):pos(xPos, 14):addTo(viewNode)
    xPos = xPos + desc:getContentSize().width
    local value = display.newTTFLabel({
      text = params.value,
      size = 18,
      color = UIHelper.hex2rgb("#f7bb58")
    }):enableOutline(UIHelper.hex2rgb("#1e0b03"), 1):anch(0, 0.5):pos(xPos, 14):addTo(viewNode)
    xPos = xPos + value:getContentSize().width
    display.newTTFLabel({
      text = "点贡献！",
      size = 18
    }):enableOutline(UIHelper.hex2rgb("#1e0b03"), 1):anch(0, 0.5):pos(xPos, 14):addTo(viewNode)
  elseif params.type == 7 then
    local desc = display.newTTFLabel({
      text = typeDescs[params.type],
      size = 18
    }):enableOutline(UIHelper.hex2rgb("#1e0b03"), 1):anch(0, 0.5):pos(xPos, 14):addTo(viewNode)
    xPos = xPos + desc:getContentSize().width
    local value = display.newTTFLabel({
      text = params.value,
      size = 18,
      color = UIHelper.hex2rgb("#f7bb58")
    }):enableOutline(UIHelper.hex2rgb("#1e0b03"), 1):anch(0, 0.5):pos(xPos, 14):addTo(viewNode)
    xPos = xPos + value:getContentSize().width
    display.newTTFLabel({
      text = "点财富！",
      size = 18
    }):enableOutline(UIHelper.hex2rgb("#1e0b03"), 1):anch(0, 0.5):pos(xPos, 14):addTo(viewNode)
  else
    display.newTTFLabel({
      text = typeDescs[params.type],
      size = 18
    }):enableOutline(UIHelper.hex2rgb("#1e0b03"), 1):anch(0, 0.5):pos(xPos, 14):addTo(viewNode)
  end
  return viewNode
end

function UnionManageLayer:onExit()
  if self.refreshHandler then
    scheduler.unscheduleGlobal(self.refreshHandler)
  end
end

return UnionManageLayer
