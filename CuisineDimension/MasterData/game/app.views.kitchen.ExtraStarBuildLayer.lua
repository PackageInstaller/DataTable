local UnitCsv = require("csvdata.unit")
local ItemCsv = require("csvdata.item")
local globalRes = "ui/global/"
local extraBuildRes = "ui/kitchen/extraStar/"
local uiData = {
  csbFile = "ui/kitchen/ExtraStarBuildLayer.csb",
  widgets = {
    mainBg = "mainBg",
    secondBg = "mainBg/secondBg",
    upImage = "mainBg/upImage",
    haveDrawCountText = "mainBg/kuang/countText",
    btnInfo = "mainBg/btnInfo",
    baodiCountText = "mainBg/secondBaodi/secondBaodiCount",
    choose1 = "mainBg/choose1",
    choose10 = "mainBg/choose10",
    startBtn = "mainBg/startBtn",
    click1 = "mainBg/click1",
    bigCircle1 = "mainBg/click1/bigCircle",
    heroNode1 = "mainBg/click1/heroNode",
    imageR1 = "mainBg/click1/imageR",
    imageL1 = "mainBg/click1/imageL",
    click2 = "mainBg/click2",
    bigCircle2 = "mainBg/click2/bigCircle",
    heroNode2 = "mainBg/click2/heroNode",
    imageR2 = "mainBg/click2/imageR",
    imageL2 = "mainBg/click2/imageL",
    click3 = "mainBg/click3",
    bigCircle3 = "mainBg/click3/bigCircle",
    heroNode3 = "mainBg/click3/heroNode",
    imageR3 = "mainBg/click3/imageR",
    imageL3 = "mainBg/click3/imageL",
    click4 = "mainBg/click4",
    bigCircle4 = "mainBg/click4/bigCircle",
    heroNode4 = "mainBg/click4/heroNode",
    imageR4 = "mainBg/click4/imageR",
    imageL4 = "mainBg/click4/imageL",
    click5 = "mainBg/click5",
    bigCircle5 = "mainBg/click5/bigCircle",
    heroNode5 = "mainBg/click5/heroNode",
    imageR5 = "mainBg/click5/imageR",
    imageL5 = "mainBg/click5/imageL",
    key1 = "key1",
    value1 = "key1/value",
    keytext = "key1/text"
  }
}
local ExtraStarBuildLayer = class("ExtraStarBuildLayer", UIBase)

function ExtraStarBuildLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ExtraStarBuildLayer:init(params)
  if UIHelper.isiPhoneX() then
    self.mainBg:setPositionX(self.mainBg:getPositionX() + 80)
    self.key1:setPositionX(self.key1:getPositionX() + UIHelper.getMoveXForX() + 80)
  end
  self.btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {typeStr = "dream_draw"})
  end)
  self.light = UIHelper.createSpineNodeByRes("spine/ui/kitchen/extraStarBuild")
  self.light:setAnimation(0, "idle", true)
  self.light:pos(410.5, 253.5):addTo(self.secondBg)
  self:initRepeatAnimation()
  self.buildCount = 1
  self.useHeroList = {}
  self.choose1:setCallback(function()
    self.choose1:setImage(extraBuildRes .. "xuanze2.png")
    self.choose10:setImage(extraBuildRes .. "xuanze1.png")
    self.buildCount = 1
    self.useHeroList = {}
    self:showHeroCard()
  end)
  self.choose10:setCallback(function()
    self.choose10:setImage(extraBuildRes .. "xuanze2.png")
    self.choose1:setImage(extraBuildRes .. "xuanze1.png")
    self.buildCount = 10
    self.useHeroList = {}
    self:showHeroCard()
  end)
  if 0 < #json.decode(game.role.extraStarResultList) then
    local getButton = UIHelper.extend(ccui.Button:create())
    getButton:setImages(extraBuildRes, {
      "yichang.png",
      "yichang.png"
    })
    getButton:pos(910, 10):addTo(self.mainBg):setTouchScale()
    getButton:setCallback(function()
      game:sendData(actionCodes.Hero_extraStarGetRpc, MsgPack.pack({}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Hero_extraStarGetRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        game:createView("kitchen.BuildQuickResultLayer", {
          heros = msg.newHeroList
        })
        getButton:hide()
        self:refreshCount()
      end)
    end)
  end
  self:showHeroCard()
  self.startBtn:setCallback(function()
    if #json.decode(game.role.extraStarResultList) > 0 then
      SysError(SYS_ERR_LAST_TIME_RESULT)
      return
    end
    if (game.role.items[43001] or 0) < self.buildCount then
      SysError(SYS_ERR_DREAM_TICKETS_NOT_ENOUGH)
      return
    end
    for i = 1, #self.useHeroList do
      if self.useHeroList[i].unit.star ~= 4 and self.useHeroList[i].unit.star ~= 5 and self.useHeroList[i].unit.type ~= 98 and self.useHeroList[i].unit.type ~= 99 then
        SysError(SYS_ERR_HERO_STAR)
        return
      end
    end
    if #self.useHeroList ~= self.buildCount * 5 then
      local needCount = self.buildCount * 5 - #self.useHeroList
      local tipstr = ""
      tipstr = "主厨确定要花费" .. needCount * 200 .. "钻石补齐所缺食灵吗？(补齐的食灵按非限定五星算)"
      MDialog:double({
        text = tipstr,
        size = 24,
        color = UIHelper.hex2rgb("#430602"),
        cancelCallback = function()
          return true
        end,
        okCallback = function()
          if game.role.diamond < needCount * 200 then
            SysError(SYS_ERR_DIAMOND_SHORTAGE)
            return true
          else
            self:startBuildExtraStar(needCount * 200)
          end
          return true
        end
      })
      return
    end
    self:startBuildExtraStar(0)
  end)
  self:changeUpImage()
  self:refreshCount()
end

function ExtraStarBuildLayer:changeUpImage()
  local index, all = 1, globalCsv.buildExtraStarUpImage or {1}
  if #all == 1 then
    return
  end
  
  local function createImage()
    self.upImage:setImage(extraBuildRes .. string.format("upImage_%d.png", all[index]))
    self.upImage:setOpacity(1.0E-4)
    self.upImage:runAction(transition.sequence({
      cc.FadeIn:create(0.5),
      cc.DelayTime:create(3),
      cc.FadeOut:create(0.5)
    }))
    index = index + 1
    if index > #all then
      index = 1
    end
  end
  
  self.upImage:runAction(cc.RepeatForever:create(transition.sequence({
    cc.DelayTime:create(4),
    cc.CallFunc:create(function()
      createImage()
    end)
  })))
end

function ExtraStarBuildLayer:startBuildExtraStar(diamondCount)
  local herolist = {}
  for i = 1, #self.useHeroList do
    herolist[i] = self.useHeroList[i].id
  end
  game:sendData(actionCodes.Hero_extraStarBuildRpc, MsgPack.pack({
    useHeroList = herolist,
    count = self.buildCount,
    diamondCount = diamondCount
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Hero_extraStarBuildRpc, function(event)
    UIHelper.removeWaiting()
    local msg = MsgPack.unpack(event.data)
    local tempCount = self.buildCount
    local rewards = {}
    local isFirsts = {}
    local isExtraStar = false
    for _, data in ipairs(msg.newHeroList or {}) do
      table.insert(rewards, data.unitId)
      table.insert(isFirsts, data.first)
      if UnitCsv[data.unitId].star == 6 then
        isExtraStar = true
      end
    end
    
    local function checkHero()
      if next(rewards) then
        HeroRewardLayer.new({
          type = rewards[1],
          showSkip = 1 < tempCount and true or false,
          bFirst = isFirsts[1],
          skipFunc = function()
            tempCount = 1
            local tempRewards = {}
            local tempIsFirsts = {}
            for k, res in ipairs(isFirsts) do
              if k == 1 or res or UnitCsv[rewards[k]].star == 6 then
                table.insert(tempRewards, rewards[k])
                table.insert(tempIsFirsts, res)
              end
            end
            rewards = tempRewards
            isFirsts = tempIsFirsts
          end,
          callback = function()
            if next(rewards) then
              table.remove(rewards, 1)
              table.remove(isFirsts, 1)
            end
            checkHero()
            local activeGuide = game.role.activeGuide
            if activeGuide["10024"] ~= 1 or activeGuide["10025"] == 1 or CommonHelper.funcOpen("extraStar") then
            end
          end
        })
      elseif 1 < self.buildCount then
        game:createView("kitchen.BuildQuickResultLayer", {
          heros = msg.newHeroList,
          isExtraTen = true
        })
      end
    end
    
    local maskLayer = UIHelper.newMask({
      size = cc.size(width, display.height)
    })
    maskLayer:addTo(display.getRunningScene()):zorder(POPUP_LAYER_ORDER + 1)
    maskLayer:setTouchEnabled(true)
    maskLayer:setSwallowTouches(true)
    self.light:setToSetupPose()
    self.light:setAnimation(0, isExtraStar and "touch2" or "touch", false)
    self:runAction(transition.sequence({
      cc.DelayTime:create(1.9),
      cc.CallFunc:create(function()
        self.light:retain()
        self.light:removeFromParent(false)
        self.light:pos(569, 290)
        maskLayer:addChild(self.light)
        self.light:release()
      end)
    }))
    self:runAction(transition.sequence({
      cc.DelayTime:create(2.5),
      cc.CallFunc:create(function()
        checkHero()
        self.useHeroList = {}
        self:showHeroCard()
        self:refreshCount()
      end)
    }))
    self:runAction(transition.sequence({
      cc.DelayTime:create(2.5),
      cc.CallFunc:create(function()
        self.light:retain()
        self.light:removeFromParent(false)
        self.light:pos(410.5, 253.5)
        self.secondBg:addChild(self.light)
        self.light:release()
        self.light:setToSetupPose()
        self.light:setAnimation(0, "idle", true)
        maskLayer:removeSelf()
      end)
    }))
  end)
end

function ExtraStarBuildLayer:initRepeatAnimation()
  for i = 1, 5 do
    self["bigCircle" .. i]:runAction(cc.RepeatForever:create(cc.RotateBy:create(30, -360)))
  end
end

function ExtraStarBuildLayer:showHeroCard()
  local useHeroCount = #self.useHeroList
  for i = 1, 5 do
    self["heroNode" .. i]:removeAllChildren()
  end
  for i = 1, 5 do
    if self.useHeroList[1 + (i - 1) * self.buildCount] then
      local heroCount = useHeroCount > self.buildCount and self.buildCount or useHeroCount
      useHeroCount = useHeroCount > self.buildCount and useHeroCount - self.buildCount or 0
      local card = self:createHeroCard(self.useHeroList[1 + (i - 1) * self.buildCount], heroCount)
      local xPosR = self["imageR" .. i]:getPositionX()
      local xPosL = self["imageL" .. i]:getPositionX()
      self["imageR" .. i]:setPositionX(xPosR + 35)
      self["imageL" .. i]:setPositionX(xPosL - 35)
      self["imageR" .. i]:show()
      self["imageL" .. i]:show()
      self["imageR" .. i]:runAction(cc.MoveBy:create(0.2, cc.p(-35, 0)))
      self["imageL" .. i]:runAction(cc.MoveBy:create(0.2, cc.p(35, 0)))
      card:anch(0.5, 0.5):pos(0, -50):addTo(self["heroNode" .. i])
      card:setCascadeOpacityEnabled(true)
      card:setOpacity(0)
      card:runAction(cc.Spawn:create(cc.MoveBy:create(0.2, cc.p(0, 50)), cc.FadeIn:create(0.2)))
      card:setCallback(function()
        self:showChooseHero()
      end)
    else
      self["imageR" .. i]:hide()
      self["imageL" .. i]:hide()
      display.newTTFLabel({
        text = "添加食灵",
        size = 22,
        color = UIHelper.hex2rgb("#b4f730")
      }):pos(-2, -40):addTo(self["heroNode" .. i])
      local btn = UIHelper.newImageView("ui/equip/reforge/add.png"):pos(0, 16):addTo(self["heroNode" .. i])
      btn:setCallback(function()
        self:showChooseHero()
      end)
    end
  end
end

function ExtraStarBuildLayer:createHeroCard(herodata, heroCount)
  local unitData = UnitCsv[herodata:getDressType()]
  local quality = herodata.quality
  local attrValues = herodata:getTotalAttrValues()
  local hp = attrValues.hp * herodata.hpPercent / 1000
  hp = herodata.hpPercent > 500 and math.floor(hp) or math.ceil(hp)
  local big = herodata.hpPercent <= 300
  local content = UIHelper.newImageView(globalRes .. string.format("small_card_bg_%d.png", quality))
  UIHelper.newImageView(UIHelper.getCardRes("book", unitData.type, big, quality)):scale(0.92):pos(content:getContentSize().width / 2, 146):addTo(content)
  local starBg = UIHelper.newImageView(string.format(globalRes .. "star_bg_%d.png", quality)):pos(98, 85):addTo(content)
  starBg:setCascadeOpacityEnabled(true)
  local star, xInterval = herodata.unit.star, 20
  local temStar = math.min(star, 5)
  local xBegin = starBg:getContentSize().width / 2 - (temStar - 1) * xInterval / 2 + 1
  local bMax = herodata:isTreeMax()
  local isBlack = herodata:isBlackHero()
  local isMengJing = herodata:isMengJingHero()
  local isShengcan = herodata:isShengcanHero()
  if isShengcan then
    for index = 1, temStar do
      UIHelper.newImageView(globalRes .. (bMax and "star_tree_red.png" or "star.png")):pos(xBegin + (index - 1) * xInterval, 14):addTo(starBg)
    end
  else
    for index = 1, temStar do
      UIHelper.newImageView(globalRes .. (bMax and (isBlack and "star_tree_black.png" or "star_tree.png") or isMengJing and "star_extra.png" or isBlack and "star_black.png" or "star.png")):pos(xBegin + (index - 1) * xInterval, 14):addTo(starBg)
    end
  end
  local marryBg = display.newSprite(globalRes .. "small_card_marry_bg.png"):center(content):addTo(content)
  marryBg:setCascadeOpacityEnabled(true)
  if 5 <= herodata.loveBreak then
    display.newSprite(globalRes .. "small_card_marry.png"):center(marryBg):addTo(marryBg)
  end
  local isAdvanceMax = herodata:isSauceAdvanceMax()
  local pro = UIHelper.getProfessionTag(herodata.unit.profession, quality, 18, herodata:showTreeTag()):scale(0.9):pos(176, 193):addTo(content)
  local number = display.newTTFLabel({
    text = "x" .. heroCount,
    size = 40,
    color = UIHelper.hex2rgb("#703902")
  }):pos(97, 46):addTo(content)
  pro:setCascadeOpacityEnabled(true)
  content:scale(1.1)
  return content
end

function ExtraStarBuildLayer:showChooseHero()
  local function rule(_hero)
    local states = _hero:getState()
    
    for key, value in pairs(states) do
      if value then
        return true
      end
    end
    for index, id in ipairs(self.useHeroList) do
      if id == _hero.id then
        return true
      end
    end
    if _hero.lock == 1 or _hero.formation > 0 then
      return true
    end
    if _hero.unit.star ~= 4 and _hero.unit.star ~= 5 and _hero.unit.type ~= 98 and _hero.unit.type ~= 99 then
      return true
    end
  end
  
  local function newrule(heroId)
    local hero = game.role.heros[heroId]
    local state = hero:getState()
    if state[1] then
      SysError(SYS_ERR_HERO_LOCKED_CURE_RECYCLE)
      return true
    end
    if state[2] then
      SysError(SYS_ERR_HERO_LOCKED_FIGHT_RECYCLE)
      return true
    end
    if state[3] then
      SysError(SYS_ERR_HERO_LOCKED_CONSIGNATION_RECYCLE)
      return true
    end
  end
  
  local layer = game:createView("hero.ChooseHeroLayer", {
    multiChoose = true,
    quickChose = true,
    rule = rule,
    type = 11,
    max = self.buildCount * 5,
    callback = function(chooseList)
      self.useHeroList = {}
      for id, _ in pairs(chooseList) do
        table.insert(self.useHeroList, game.role.heros[id])
      end
      self:showHeroCard()
    end,
    newRule = newrule
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(TopBarType.full, "厨房")
  end)
end

function ExtraStarBuildLayer:refreshCount()
  local count = game.role.extraStarCount
  self.baodiCountText:setString(10 - count % 10)
  self.haveDrawCountText:setString(count % 100 .. "/100")
  self.key1:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.key1,
      itemType = 43001,
      itemData = ItemCsv[43001]
    })
  end)
  self.value1:setString(game.role.items[43001] or 0)
end

return ExtraStarBuildLayer
