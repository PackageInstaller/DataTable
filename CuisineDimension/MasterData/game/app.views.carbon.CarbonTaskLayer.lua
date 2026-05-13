local chapterInfoCsv = require("csvdata.chapter_info")
local consignationCsv = require("csvdata.consignation")
local unitCsv = require("csvdata.unit")
local itemCsv = require("csvdata.item")
local heroRes = "ui/hero/"
local taskRes = "ui/carbon/task/"
local uiData = {
  csbFile = "ui/carbon/CarbonTaskLayer.csb",
  mask = true,
  widgets = {
    bg_1 = "bg_1",
    upBar = "upBar",
    btnsBg = "btnsBg",
    btnList = "btnsBg/btnList",
    toolCount = "cardBg/toolCount",
    teamCount = "cardBg/teamCount",
    content = "cardBg/content"
  }
}
local CarbonTaskLayer = class("CarbonTaskLayer", UIBase)

function CarbonTaskLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function CarbonTaskLayer:init(params)
  self.entrust = json.decode(game.role.entrustJson)
  self.autoClose = true
  TopBar:show(TopBarType.full, "委托")
  local angle = display.newSprite("ui/global/angle.png"):setFlippedX(true):setFlippedY(true):anch(0, 0):pos(0, 0):addTo(self)
  local clock = display.newSprite("ui/kitchen/angle_clock.png"):anch(0, 0):pos(0, 0):addTo(self)
  local hourHand = UIHelper.newImageView("ui/kitchen/hour_hand.png"):anch(0.5, 0.7):pos(53, 58):addTo(clock)
  hourHand:runAction(cc.RepeatForever:create(cc.RotateBy:create(20, 360)))
  clock:setCascadeOpacityEnabled(true)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.bg_1)
    UIHelper.fitForiPhoneX(self.upBar, true)
    self.btnsBg:setPositionX(self.btnsBg:getPositionX() - 75)
    clock:setPositionX(clock:getPositionX() - UIHelper.getMoveXForX())
    angle:setPositionX(angle:getPositionX() - UIHelper.getMoveXForX())
  end
  UIHelper.MoveToUp({node = clock, time = 0.3})
  self.group = MRadioGroup:create()
  local chapters = {}
  for key, _ in pairs(consignationCsv) do
    chapters[#chapters + 1] = key
  end
  table.sort(chapters, function(a, b)
    return a < b
  end)
  local chapterNames = {
    [101] = "欧罗巴大陆",
    [102] = "美利坚大陆",
    [103] = "和风岛",
    [104] = "次元小屋",
    [105] = "中华大陆",
    [106] = "次元壁",
    [107] = "蔷薇王朝",
    [108] = "和风战国",
    [109] = "黎明之都",
    [110] = "戈戟华夏",
    [111] = "神木幻境",
    [301] = "异界"
  }
  local btnSize = display.newSprite("ui/talk/main/chapter_a.png"):getContentSize()
  local select, delay = 101, 0.2
  for _, chapterId in ipairs(chapters) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(btnSize):addTo(self.btnList)
    local lock = chapterId ~= 301 and game.role.carbons[chapterId * 100 + 1] or CommonHelper.funcOpen("awake")
    local iamgeA = lock and "chapter_a.png" or "chapter_lock.png"
    local iamgeB = lock and "chapter_b.png" or "chapter_lock.png"
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages("ui/talk/main/", {iamgeA, iamgeB})
    btn:center(viewNode):addTo(viewNode)
    btn:setString({
      text = chapterNames[chapterId],
      size = 24,
      color = UIHelper.hex2rgb("#61270b")
    })
    btn:setCallback(function()
      if not lock then
        SysError(SYS_ERR_CARBON_MAP_NOT_OPEN)
        self.group:chooseByName(tostring(select))
        return
      end
      select = chapterId
      self:showTaskInfo(chapterId)
    end)
    btn:setName(tostring(chapterId))
    btn:setGroup(self.group)
    delay = delay + 0.03
    UIHelper.MoveToRight({
      node = btn,
      delay = delay,
      time = 0.2
    })
  end
  local di = ccui.Widget:create()
  di:setContentSize(cc.size(btnSize.width, btnSize.height)):addTo(self.btnList)
end

function CarbonTaskLayer:showData(params)
  local chapterId = params.chapterId or 101
  self.group:chooseByName(tostring(chapterId))
  self:showTaskInfo(chapterId)
end

function CarbonTaskLayer:showTaskInfo(chapterId)
  self.isShow = false
  self.chapterId = chapterId
  self.content:removeAllChildren()
  self.toolCount:setString(game.role.items[globalCsv.quickConsignation] or 0)
  local taskData = consignationCsv[chapterId]
  if not taskData then
    return
  end
  for index, data in ipairs(taskData) do
    local posX = (index - 1) * 240
    local chapterData = game.role.carbons[data.unlock]
    local bg
    if chapterData and chapterData.score > -1 or data.unlock == 0 then
      bg = display.newSprite(taskRes .. "unlock_bg.png"):pos(posX, 0):addTo(self.content)
      self:showDetail(index, data, bg)
    else
      bg = display.newSprite(taskRes .. "lock_bg.png"):pos(posX, 0):addTo(self.content)
      display.newTTFLabel({
        text = data.lockDesc,
        size = 16,
        color = UIHelper.hex2rgb("#75381b")
      }):pos(115, 35):addTo(bg)
    end
    bg:setCascadeOpacityEnabled(true)
    UIHelper.MoveToUp({node = bg, time = 0.3})
  end
  self:checkUsedFormatNum()
end

function CarbonTaskLayer:showDetail(cur, data, parent)
  display.newTTFLabel({
    text = data.name,
    size = 25,
    color = UIHelper.hex2rgb("#af4a19")
  }):pos(120, 370):addTo(parent)
  display.newTTFLabel({
    text = "资源报酬:",
    size = 16,
    color = UIHelper.hex2rgb("#75381b")
  }):pos(45, 325):addTo(parent)
  display.newSprite(taskRes .. "clock.png"):pos(135, 123):addTo(parent)
  for index = 1, 4 do
    HuoBiIcon.new({
      count = data["material" .. index],
      base = index
    }):scale(0.7):pos(35 + 55 * (index - 1), 285):addTo(parent)
  end
  if data.gift2see ~= "" then
    local x = 0
    display.newTTFLabel({
      text = "概率追加:",
      size = 16,
      color = UIHelper.hex2rgb("#75381b")
    }):pos(45, 245):addTo(parent)
    for itemId, count in pairs(data.gift2see:toNumMap()) do
      ItemIcon.new({type = itemId, showTip = true}):scale(0.6):pos(40 + x * 70, 204):addTo(parent)
      x = x + 1
    end
  end
  if data.playerExp ~= 0 then
    display.newTTFLabel({
      text = string.format("主厨经验: %d", data.playerExp),
      size = 16,
      color = UIHelper.hex2rgb("#75381b")
    }):anch(0, 0.5):pos(15, 165):addTo(parent)
  end
  if data.heroExp ~= 0 then
    display.newTTFLabel({
      text = string.format("套餐经验: %d", data.heroExp),
      size = 16,
      color = UIHelper.hex2rgb("#75381b")
    }):anch(0, 0.5):pos(15, 148):addTo(parent)
  end
  local entrustData = self.entrust[tostring(self.chapterId)] or {}
  local indexData = entrustData[tostring(cur)]
  if indexData then
    self:showTwoBtn(cur, indexData, parent, data)
  else
    self:showOneBtn(cur, data, parent)
  end
end

function CarbonTaskLayer:showTwoBtn(cur, data, parent, taskSet)
  local curTime = display.newTTFLabel({
    text = "00:00:00",
    size = 22,
    color = UIHelper.hex2rgb("#0f7d03")
  }):pos(185, 124):addTo(parent)
  display.newTTFLabel({
    text = string.format("套餐%d", data.form),
    size = 18,
    color = UIHelper.hex2rgb("#b33b1b")
  }):pos(80, 124):addTo(parent)
  local captainId = self:findCaptainId(data.form)
  local time = game:nowTime()
  if time < data.time then
    local function setTime()
      local leftTimeVal = data.time - game:nowTime()
      
      if 0 <= leftTimeVal then
        curTime:setString(UIHelper.getTimeStr(leftTimeVal))
        curTime:runAction(transition.sequence({
          cc.DelayTime:create(1),
          cc.CallFunc:create(function()
            setTime()
          end)
        }))
      elseif not self.isShow then
        self.isShow = true
        self:sendRequest(data, cur)
      end
    end
    
    setTime()
    local quickBtn = UIHelper.extend(ccui.Button:create())
    quickBtn:setImages(taskRes, {
      "quick_bg.png",
      "quick_bg.png"
    })
    quickBtn:pos(120, 85):addTo(parent)
    quickBtn:setString({
      text = "快速完成",
      size = 26,
      color = UIHelper.hex2rgb("#ffffff")
    })
    quickBtn:setCallback(function()
      local str = string.format("确定消耗 <img src='ui/global/icon_quick4.png' scale=0.5 />x%d 立即完成委托么？", taskSet.quickConsignation)
      self.MDiaLog = MDialog:double({
        title = "快速委托",
        text = str
      }, function()
        self.autoClose = false
        local count = game.role.items[globalCsv.quickConsignation] or 0
        if count < taskSet.quickConsignation then
          SysError(SYS_ERR_CONSIGANATION_NO_QUICK_TOOLS)
        else
          curTime:stopAllActions()
          self:sendRequest(data, cur, true)
          self.autoClose = true
        end
      end)
    end)
    quickBtn:setTouchScale()
    display.newSprite("ui/global/icon_quick4.png"):scale(0.4):pos(20, 20):addTo(quickBtn)
    display.newTTFLabel({
      text = taskSet.quickConsignation,
      size = 20,
      color = UIHelper.hex2rgb("#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(25, 13):addTo(quickBtn)
    local stopBtn = UIHelper.extend(ccui.Button:create())
    stopBtn:setImages(taskRes, {
      "stop_bg.png",
      "stop_bg.png"
    })
    stopBtn:pos(120, 35):addTo(parent)
    stopBtn:setString({
      text = "终止委托",
      size = 26,
      color = UIHelper.hex2rgb("#ffffff")
    })
    stopBtn:setCallback(function()
      self.MDiaLog = MDialog:double({
        text = "终止委托将不会获得任何收益，确定要终止该委托？"
      }, function()
        self.autoClose = false
        self:sendRequest(data, cur, nil, true)
        self.autoClose = true
      end)
    end)
    stopBtn:setTouchScale()
  elseif not self.isShow then
    self.isShow = true
    self:sendRequest(data, cur)
  end
end

function CarbonTaskLayer:showOneBtn(cur, data, parent)
  local curTime = display.newTTFLabel({
    text = UIHelper.getTimeStr(data.time),
    size = 22,
    color = UIHelper.hex2rgb("#0f7d03")
  }):pos(185, 124):addTo(parent)
  local startBtn = UIHelper.extend(ccui.Button:create())
  startBtn:setImages(taskRes, {
    "start_bg.png",
    "start_bg.png"
  })
  startBtn:pos(120, 35):addTo(parent)
  startBtn:setString({
    text = "接受委托",
    size = 26,
    color = UIHelper.hex2rgb("#ffffff")
  })
  startBtn:name("startBtn" .. cur)
  startBtn:setCallback(function()
    if self.forCount >= globalCsv.consignationLimit then
      SysError(SYS_ERR_CONSIGANATION_AREA_FULL)
      return
    end
    if not self:getBattleNum() then
      SysError(SYS_ERR_CARBON_NO_TEAM_AVAILABLE)
      return
    end
    local tip = false
    local result = CommonHelper.checkSourceFull()
    for type = 1, 4 do
      local num = data["material" .. type]
      if 0 < num and result[type] then
        tip = true
        break
      end
    end
    
    local function goTo()
      local layer = game:createView("hero.TaskHeroListLayer", {
        task = data,
        callback = function(choose)
          local formation = game.role.formation[tostring(choose)]
          if formation.lock.carbon then
            return
          end
          local csv = consignationCsv[self.chapterId][cur]
          local info, minLevel, firstLevel, num = {}, 1000, 0, 0
          local condtion = csv.require:toNumMap()
          local awakeNumMap = {
            0,
            0,
            0
          }
          for slot, heroId in pairs(formation.list) do
            local hero = game.role.heros[heroId]
            if hero then
              local unit = unitCsv[hero.type]
              info[unit.profession] = (info[unit.profession] or 0) + 1
              if minLevel > hero.level then
                minLevel = hero.level
              end
              if tonumber(slot) == 1 then
                firstLevel = hero.level
              end
              for i = 1, 3 do
                awakeNumMap[i] = i <= hero.awake and awakeNumMap[i] + 1 or awakeNumMap[i]
              end
              num = num + 1
            end
          end
          for key, value in pairs(condtion) do
            if key == 9 then
              if value > firstLevel then
                SysError(SYS_ERR_CONSIGANATION_REQUIRE_NOT_ENOUGH)
                return
              end
            elseif key == 8 then
              if value > minLevel then
                SysError(SYS_ERR_CONSIGANATION_REQUIRE_NOT_ENOUGH)
                return
              end
            elseif key == 7 then
              if value > num then
                SysError(SYS_ERR_CONSIGANATION_REQUIRE_NOT_ENOUGH)
                return
              end
            elseif key == 10 then
              if value > awakeNumMap[1] then
                SysError(SYS_ERR_CONSIGANATION_REQUIRE_NOT_ENOUGH)
                return
              end
            elseif key == 11 then
              if value > awakeNumMap[2] then
                SysError(SYS_ERR_CONSIGANATION_REQUIRE_NOT_ENOUGH)
                return
              end
            elseif key == 12 then
              if value > awakeNumMap[3] then
                SysError(SYS_ERR_CONSIGANATION_REQUIRE_NOT_ENOUGH)
                return
              end
            elseif value > (info[key] or 0) then
              SysError(SYS_ERR_CONSIGANATION_REQUIRE_NOT_ENOUGH)
              return
            end
          end
          game:sendData(actionCodes.Role_entrustRpc, MsgPack.pack({
            formationId = choose,
            chapter = self.chapterId,
            id = cur
          }))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Role_entrustRpc, function(event)
            UIHelper.removeWaiting()
            game:playMusic(1500)
            CommonHelper.playCV(game.role.heros[self:findCaptainId(choose)].type, "consignationStart")
            self.entrust = json.decode(game.role.entrustJson)
            self:checkUsedFormatNum()
            self:showTaskInfo(self.chapterId)
            if game.role.majorGuideStep == 16 then
              game.role.minorGuideStep = 7
              NewGuideLayer.new({step = 16})
            end
          end)
          return true
        end
      })
      self:hide()
      BackManager:push(function()
        self:show()
        layer:close()
      end)
    end
    
    if tip then
      MDialog:double({
        text = "主厨，您有资源已经到达存储上限了\n \n本次委托将无法获得对应资源的报酬",
        okCallback = function()
          goTo()
          return true
        end,
        cancelCallback = function()
          return true
        end
      })
    else
      goTo()
    end
  end)
  startBtn:setTouchScale()
end

function CarbonTaskLayer:sendRequest(data, index, quick, cancel)
  if self.MDiaLog and not tolua.isnull(self.MDiaLog) and self.autoClose then
    self.MDiaLog:close()
  end
  game:sendData(actionCodes.Role_finishEntrustRpc, MsgPack.pack({
    chapter = self.chapterId,
    id = index,
    needQuick = quick,
    cancel = cancel
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Role_finishEntrustRpc, function(event)
    UIHelper.removeWaiting()
    self.entrust = json.decode(game.role.entrustJson)
    self:checkUsedFormatNum()
    if cancel then
      self:showTaskInfo(self.chapterId)
    else
      local msg = MsgPack.unpack(event.data)
      msg.format = data.form
      if tolua.isnull(self) then
        return
      end
      CommonHelper.playCV(game.role.heros[self:findCaptainId(data.form)].type, "consignationFinish")
      local heros = {}
      for itemId, count in pairs(msg.dropItems) do
        local item = itemCsv[tonumber(itemId)]
        if item.type == ItemType.Hero then
          table.insert(heros, tonumber(itemId))
        end
      end
      self:checkHero(heros, msg)
    end
  end)
end

function CarbonTaskLayer:checkHero(heros, msg)
  local function check(heros)
    if next(heros) then
      HeroRewardLayer.new({
        type = heros[1] - ItemStartId.hero,
        
        callback = function()
          table.remove(heros, 1)
          check(heros)
        end
      })
    else
      local layer = game:createView("carbon.TaskResultLayer", msg)
      TopBar:hide()
      BackManager:push(function()
        TopBar:show(TopBarType.full, "委托")
        layer:close()
        self.isShow = false
        self:showTaskInfo(self.chapterId)
      end)
    end
  end
  
  check(heros)
end

function CarbonTaskLayer:checkUsedFormatNum()
  self.forCount = 0
  for index, data in pairs(game.role.formation) do
    if data.lock.entrust then
      self.forCount = self.forCount + 1
    end
  end
  self.teamCount:setString(string.format("%d/%d", self.forCount, globalCsv.consignationLimit))
end

function CarbonTaskLayer:findCaptainId(form)
  return game.role.formation[tostring(form)].list[tostring(1)]
end

function CarbonTaskLayer:getBattleNum()
  local newNum = 0
  for index, data in pairs(game.role.formation) do
    if data.list["1"] then
      local states = game.role:getFormationState(tonumber(index))
      if not states[1] and not states[2] and not states[3] then
        newNum = newNum + 1
      end
    end
  end
  return 0 < newNum
end

return CarbonTaskLayer
