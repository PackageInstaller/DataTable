local WeatherCsv = require("csvdata.farm_terms")
local SignCsv = require("csvdata.farm_sign")
local ItemCsv = require("csvdata.item")
local GiftCsv = require("csvdata.farm_sign_month")
local SignRes = "ui/farm/sign/"
local uiData = {
  csbFile = "ui/farm/SignLayer.csb",
  mask = true,
  maskClick = true,
  popup = true,
  widgets = {
    signBg = "signBg",
    daily = "signBg/daily",
    desc = "signBg/desc",
    time = "signBg/time",
    ren = "signBg/ren",
    gift = "signBg/gift"
  }
}
local SignLayer = class("SignLayer", UIBase)

function SignLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function SignLayer:init(params)
  self.signData = json.decode(game.role.sign)
  self.callback = params.callback or function()
  end
  self.tm = CommonHelper.date(nil, nil, true)
  self.time:setString(self.tm.year .. "/" .. self.tm.month .. "/" .. self.tm.day)
  self:initGift()
end

function SignLayer:showData()
  local giftData = SignCsv[self.tm.year * 100 + self.tm.month]
  local ySlot, intervalX, intervalY = 1, 97, -60
  local time = CommonHelper.time({
    year = self.tm.year,
    month = self.tm.month,
    day = 1
  })
  repeat
    local tm = CommonHelper.date(time, nil, true)
    if tm.month ~= self.tm.month then
      break
    end
    local curDay = tm.day
    local xSlot = tm.wday
    local dayData = giftData[curDay]
    local content = UIHelper.newImageView(SignRes .. "icon_bg.png"):pos(49 + (xSlot - 1) * intervalX, -31 + (ySlot - 1) * intervalY):addTo(self.daily)
    content:setCascadeOpacityEnabled(true)
    local items = dayData.item:toTableArray()
    local data = ItemCsv[tonumber(items[1][1])]
    display.newSprite(data.icon):scale(0.5):center(content):addTo(content)
    display.newTTFLabel({
      text = items[1][2],
      size = 20,
      color = UIHelper.hex2rgb("#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(40, 14):addTo(content)
    local color = "#000000"
    if curDay == self.tm.day then
      color = "#ff3734"
    elseif xSlot == 7 or xSlot == 1 then
      color = "#7a7a7a"
    end
    display.newTTFLabel({
      text = curDay,
      size = 24,
      color = UIHelper.hex2rgb(color)
    }):anch(0, 0.5):pos(-20, 50):addTo(content)
    if curDay == self.tm.day then
      self:selectDay(curDay, dayData, content)
      if self.signData[tostring(curDay)] ~= self.tm.month then
        self:sendRequest(nil, dayData, content)
      end
    end
    if self.signData[tostring(curDay)] == self.tm.month then
      local got = display.newSprite(SignRes .. "got.png"):pos(60, 16):addTo(content)
      got:setRotation(-90)
    end
    content:setCallback(function()
      self:selectDay(curDay, dayData, content)
      self:showTip(content, dayData)
    end)
    if tm.wday == 7 then
      ySlot = ySlot + 1
    end
    time = time + 86400
  until false
  self.signBg:setCascadeOpacityEnabled(true)
  self.signBg:setScale(0.1)
  self.signBg:pos(35, 615)
  self.signBg:runAction(cc.Spawn:create(cc.ScaleTo:create(0.15, 1), cc.MoveTo:create(0.15, cc.p(568, 320))))
  self:setOpacity(0)
  self:runAction(cc.FadeIn:create(0.15))
end

function SignLayer:initGift()
  self.gift:removeAllChildren()
  local monthData = GiftCsv[self.tm.month]
  local signStatus = game.role.signStatus
  local days = 0
  for _, v in pairs(self.signData) do
    if v == self.tm.month then
      days = days + 1
    end
  end
  display.newTTFLabel({
    text = "已签到",
    size = 14,
    color = UIHelper.hex2rgb("#ffe400")
  }):enableOutline(UIHelper.hex2rgb("#7c6e6e"), 1):pos(0, -10):addTo(self.gift)
  display.newTTFLabel({
    text = days .. "天",
    size = 18,
    color = UIHelper.hex2rgb("#ffe400")
  }):enableOutline(UIHelper.hex2rgb("#7c6e6e"), 1):pos(-4, -30):addTo(self.gift)
  local yPos = -90
  for index, data in ipairs(monthData) do
    display.newTTFLabel({
      text = data.days .. "天",
      size = 18,
      color = UIHelper.hex2rgb("#ffe400")
    }):enableOutline(UIHelper.hex2rgb("#7c6e6e"), 1):pos(-4, yPos):addTo(self.gift)
    local btn = UIHelper.newImageView(SignRes .. "image_gift.png"):pos(0, yPos - 30):addTo(self.gift)
    local state = signStatus:getv(data.id, 0)
    if state == -1 then
      display.newSprite(SignRes .. "image_got.png"):center(btn):addTo(btn)
    elseif days >= data.days then
      display.newSprite("ui/global/msg_new.png"):anch(0, 0):pos(42, 25):addTo(btn)
      btn:setCallback(function()
        game:sendData(actionCodes.Role_signGiftRpc, MsgPack.pack({
          index = data.id
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Role_signGiftRpc, function(event)
          UIHelper.removeWaiting()
          self:initGift()
          local items = MsgPack.unpack(event.data)
          MedalRewardLayer.new({items = items})
        end)
      end)
    else
      btn:setCallback(function()
        ItemRewardLayer.new({
          items = data.gift:toTableArray(),
          preView = true,
          ignore = true
        })
      end)
    end
    yPos = yPos - 80
  end
end

function SignLayer:selectDay(day, daySet, content)
  self.ren:removeAllChildren()
  self.desc:removeAllChildren()
  if self.selected then
    self.selected:removeSelf()
  end
  display.newSprite(daySet.showPic):anch(0, 0):addTo(self.ren)
  MRichText.new({
    text = self:getWeatherDesc(day),
    size = 20,
    color = UIHelper.hex2rgb("#03aaac")
  }):anch(0, 0.5):pos(0, -33):addTo(self.desc)
  display.newTTFLabel({
    text = daySet.desc,
    size = 18,
    color = UIHelper.hex2rgb("#B5430B")
  }):anch(0, 0.5):pos(0, 0):addTo(self.desc)
  self.selected = display.newSprite(SignRes .. "select.png"):center(content):addTo(content, -10)
  if day >= self.tm.day then
    return
  end
  if self.signData[tostring(day)] == self.tm.month then
    return
  end
  local left = globalCsv.resignChance - game.role.resignNum
  local tip = display.newTTFLabel({
    text = string.format("本月可补签%d次", left),
    size = 14,
    color = UIHelper.hex2rgb("#b5430b")
  }):pos(590, -58):addTo(self.desc)
  local btn = UIHelper.newImageView(SignRes .. "buqian.png"):pos(620, -25):addTo(self.desc)
  display.newTTFLabel({text = "补签", size = 22}):enableOutline(UIHelper.hex2rgb("#435b05"), 1):pos(48, 30):addTo(btn)
  if left < 1 then
    tip:setString("本月补签次数已用完")
    UIHelper.setImageViewGray(btn)
    return
  end
  local cost = globalCsv.resignDiamond:getv(game.role.resignNum + 1, 0)
  display.newSprite("ui/global/base_diamond.png"):pos(530, -24):addTo(self.desc)
  display.newTTFLabel({
    text = cost,
    size = 30,
    color = UIHelper.hex2rgb("#b5430b")
  }):pos(560, -24):addTo(self.desc)
  btn:setCallback(function()
    MDialog:double({
      title = "补签",
      text = string.format("确定花费 <img src='ui/global/5.png' scale=0.5 />x%d 补签么？", cost)
    }, function()
      if game.role.diamond < cost then
        UIHelper.showDiamondTip({parent = self})
        return
      end
      self:sendRequest(day, daySet, content)
    end)
  end)
end

function SignLayer:sendRequest(day, daySet, content)
  game:sendData(actionCodes.Role_signRpc, MsgPack.pack({day = day}))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Role_signRpc, function(event)
    UIHelper.removeWaiting()
    local items = MsgPack.unpack(event.data)
    self.signData = json.decode(game.role.sign)
    self:initGift()
    local bar = display.newProgressTimer(SignRes .. "got.png", display.PROGRESS_TIMER_RADIAL):pos(60, 16):addTo(content)
    bar:setRotation(-90)
    bar:runAction(cc.Sequence:create({
      cc.ProgressTo:create(0.5, 100),
      cc.DelayTime:create(0.2),
      cc.CallFunc:create(function()
        MedalRewardLayer.new({items = items})
      end)
    }))
    if day then
      self:selectDay(day, daySet, content)
    end
  end)
end

function SignLayer:getWeatherDesc(day)
  local weekCount = math.floor(game.role.openDays / 7) + 1
  local curWeek = weekCount % table.nums(WeatherCsv) + 1
  local weatherSet = WeatherCsv[curWeek]
  return weatherSet.desc
end

function SignLayer:showTip(content, data)
  local mask = UIHelper.extend(ccui.Layout:create())
  mask:size(display.width, display.height):addTo(display.getRunningScene(), POPUP_LAYER_ORDER)
  mask:setCallback(function(sender)
    mask:removeFromParent()
  end)
  mask:setSwallowTouches(false)
  local pos = content:getWorldPosition()
  local tipBg = display.newScale9Sprite("ui/global/tip_bg.png", 0, 0, cc.size(310, 80), cc.rect(20, 20, 1, 1)):pos(pos.x, pos.y + 85):addTo(mask)
  display.newSprite("ui/global/tip_arrow.png"):pos(155, -9):addTo(tipBg)
  display.newTTFLabel({
    text = string.format("第%d天", data.day),
    size = 20,
    color = UIHelper.hex2rgb("#f6bf02")
  }):anch(0, 1):pos(20, 70):addTo(tipBg)
  local items, str = data.item:toNumMap(), ""
  for type, count in pairs(items) do
    local item = ItemCsv[type]
    str = str .. string.format("%sx%d  ", item.name, count)
  end
  MRichText.new({
    text = str,
    size = 18,
    color = UIHelper.hex2rgb("#ffffff"),
    maxWidth = 280
  }):pos(20, 45):addTo(tipBg)
end

function SignLayer:close()
  self.signBg:runAction(cc.Spawn:create(cc.ScaleTo:create(0.15, 0.1), cc.MoveTo:create(0.15, cc.p(35, 615)), cc.FadeOut:create(0.15)))
  self:runAction(transition.sequence({
    cc.FadeOut:create(0.15),
    cc.CallFunc:create(function()
      self.callback()
    end),
    cc.RemoveSelf:create()
  }))
end

return SignLayer
