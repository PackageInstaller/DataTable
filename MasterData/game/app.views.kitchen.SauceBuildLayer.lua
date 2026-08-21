local ItemCsv = require("csvdata.item")
local DrawPoolCsv = require("csvdata.sauce_draw")
local MainRes = "ui/kitchen/sauce/"
local uiData = {
  csbFile = "ui/kitchen/SauceBuildLayer.csb",
  widgets = {
    mainBg = "mainBg",
    btnsNode = "mainBg/btnsNode",
    titleNode = "mainBg/middleBg/titleNode",
    lab1 = "mainBg/panelBg/lab1",
    lab2 = "mainBg/panelBg/lab2",
    lab3 = "mainBg/panelBg/lab3",
    lab4 = "mainBg/panelBg/lab4",
    lab5 = "mainBg/panelBg/lab5",
    desc = "mainBg/descBg/desc",
    count = "mainBg/countBg/count",
    btnInfo = "mainBg/countBg/btnInfo",
    btnMax = "mainBg/btnMax",
    btnSub = "mainBg/btnSub",
    btnAdd = "mainBg/btnAdd",
    btnStart = "mainBg/btnStart",
    num = "mainBg/btnStart/num",
    bg1 = "key1",
    value1 = "key1/value"
  }
}
local SauceBuildLayer = class("SauceBuildLayer", UIBase)

function SauceBuildLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function SauceBuildLayer:init(params)
  if UIHelper.isiPhoneX() then
    self.mainBg:setPositionX(self.mainBg:getPositionX() + 80)
    self.bg1:setPositionX(self.bg1:getPositionX() + UIHelper.getMoveXForX() + 80)
  end
  self.bg1:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.bg1,
      itemType = globalCsv.buildDrawing,
      itemData = ItemCsv[globalCsv.buildDrawing]
    })
  end)
  UIHelper.MoveToLeft({
    node = self.bg1,
    time = 0.3
  })
  self.curCount = 1
  self.maxCount = 10
  self.pool = 1
  if not game.role.buildSauceShow then
    game.role.buildSauceShow = game.role:activityIsOpen(52) and 0 or math.random(1, 4)
  end
  for _, name in pairs({
    "btnInfo",
    "btnMax",
    "btnSub",
    "btnAdd",
    "btnStart"
  }) do
    self[name]:setTouchScale()
  end
  self.btnAdd:setCallback(function()
    self:changeBuildCount(1)
  end)
  self.btnSub:setCallback(function()
    self:changeBuildCount(-1)
  end)
  self.btnMax:setCallback(function()
    self:changeBuildCount(self.maxCount)
  end)
  self.btnStart:setCallback(function()
    self:checkCanBuild()
  end)
  self.btnInfo:setCallback(function()
    game:loadView("kitchen.CookInfoLayer").new({
      res = string.format(MainRes .. "info_%d.png", self.pool)
    })
  end)
  local group = MRadioGroup:create({
    chooseCb = function(sender)
      sender:setPositionY(sender:getPositionY() - 6)
      local text = sender:getChildByName("name")
      text:setTextColor(UIHelper.hex2rgb("#fe5b22"))
      local tag = sender:getChildByName("tag")
      tag.func(1)
    end,
    unchooseCb = function(sender)
      sender:setPositionY(sender:getPositionY() + 6)
      local text = sender:getChildByName("name")
      text:setTextColor(UIHelper.hex2rgb("#8d4e24"))
      local tag = sender:getChildByName("tag")
      tag.func(-1)
    end
  })
  local xPos, interval = 0, 230
  for i, data in ipairs(DrawPoolCsv) do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(MainRes, {
      "btn_pool_a.png",
      "btn_pool_b.png"
    })
    btn:anch(0, 1):pos(xPos, 0):addTo(self.btnsNode)
    display.newTTFLabel({
      text = data.name,
      size = 30
    }):pos(120, 27):addTo(btn):name("name")
    local tag = display.newSprite(MainRes .. string.format("image_type_%s_a.png", 1 < i and "s" or "n")):pos(30, 25):addTo(btn):name("tag")
    
    function tag.func(num)
      tag:setTexture(MainRes .. string.format("image_type_%s_%s.png", 1 < i and "s" or "n", 0 < num and "b" or "a"))
    end
    
    btn:name("poolBtn" .. i)
    btn:setGroup(group)
    btn:setCallback(function()
      self.pool = i
      self:showData()
    end)
    xPos = xPos + interval
  end
  group:chooseByName("poolBtn" .. self.pool)
  self:initKeyValue()
end

function SauceBuildLayer:showData(params)
  self.costs = DrawPoolCsv[self.pool].cost:toNumMap()
  display.newSprite(MainRes .. string.format("title_image_%d_%d.png", self.pool, self.pool == 1 and game.role.buildSauceShow or "1")):addTo(self.titleNode)
  self:changeBuildCount(0)
end

function SauceBuildLayer:initKeyValue()
  self.count:setString(string.format("%d/%d次", game.role.ensureSauce:getv(2, 0), globalCsv.goldSauceEnsure))
  self.desc:setString(string.format("再烹饪%d次必得紫色或以上酱料", globalCsv.purpleSauceEnsure - game.role.ensureSauce:getv(1, 0)))
  self.value1:setString(game.role.items[globalCsv.buildDrawing] or 0)
  UIHelper.setMaxWidth(self.value1, 55)
end

function SauceBuildLayer:changeBuildCount(dalte)
  self.enough = true
  self.curCount = self.curCount + dalte
  if self.curCount > self.maxCount then
    self.curCount = self.maxCount
  end
  if self.curCount < 1 then
    self.curCount = 1
  end
  self.num:setString(self.curCount)
  self.lab5:setString("x" .. self.curCount * self.costs[globalCsv.buildDrawing])
  if (game.role.items[globalCsv.buildDrawing] or 0) >= self.curCount * self.costs[globalCsv.buildDrawing] then
    self.lab5:setTextColor(UIHelper.hex2rgb("#833809"))
  else
    self.enough = false
    self.lab5:setTextColor(UIHelper.hex2rgb("#fc4e01"))
  end
  for i = 1, 4 do
    local need = self.costs[i] * self.curCount
    self["lab" .. i]:setString(self.costs[i] .. "x" .. self.curCount)
    if need <= game.role["material" .. i] then
      self["lab" .. i]:setTextColor(UIHelper.hex2rgb("#833809"))
    else
      self.enough = false
      self["lab" .. i]:setTextColor(UIHelper.hex2rgb("#fc4e01"))
    end
  end
end

function SauceBuildLayer:checkCanBuild()
  if game.role:isMaxSauce() then
    UIHelper.showExtraTip({type = 4, parent = self})
    return
  end
  if not self.enough then
    SysError(SYS_ERR_SAUCE_BUILD_COST_NOT_ENOUGH)
    return
  end
  game:sendData(actionCodes.Sauce_drawRpc, MsgPack.pack({
    pool = self.pool,
    buildCount = self.curCount
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Sauce_drawRpc, function(event)
    UIHelper.removeWaiting()
    self:initKeyValue()
    self:changeBuildCount(0)
    local msg = MsgPack.unpack(event.data)
    local rewards = clone(msg.reward or {})
    
    local function checkSauce()
      if next(rewards) then
        SauceRewardLayer.new({
          type = rewards[1],
          showSkip = 1 < #rewards and true or false,
          skipFunc = function()
            rewards = {}
            SauceRewardLayer.new({
              countType = 2,
              sauces = msg.reward,
              callback = function()
                checkSauce()
              end
            })
          end,
          callback = function()
            if next(rewards) then
              table.remove(rewards, 1)
            end
            checkSauce()
          end
        })
      elseif 1 < table.nums(msg.reward) then
        SauceRewardLayer.new({
          countType = 2,
          sauces = msg.reward,
          callback = function()
            checkSauce()
          end
        })
      end
    end
    
    checkSauce()
  end)
end

return SauceBuildLayer
