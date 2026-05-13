local BattleCsv = require("csvdata.tower_battle")
local TowerRes = "ui/tower/main/"
local ResultRes = "ui/tower/result/"
local uiData = {
  csbFile = "ui/tower/TowerResultLayer.csb",
  popup = true,
  mask = true,
  widgets = {
    upBar = "upBar",
    upBarP = "upBarP",
    upLine = "upLine",
    floorNode = "floorNode",
    itemsNode = "itemsNode",
    textReward = "textReward",
    herosBg = "herosBg",
    heroNode = "herosBg/heroNode",
    btnBack = "herosBg/btnBack",
    btnNext = "herosBg/btnNext",
    imageBg1 = "imageBg1",
    imageBg2 = "imageBg2",
    imageBg3 = "imageBg3",
    imageBg4 = "imageBg4",
    downBar = "downBar"
  }
}
local TowerResultLayer = class("TowerResultLayer", UIBase)

function TowerResultLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TowerResultLayer:init(params)
  self.btnBack:setTouchScale()
  self.btnNext:setTouchScale()
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.downBar, true)
    UIHelper.fitForiPhoneX(self.upLine, true)
    UIHelper.fitForiPhoneX(self.upBar, true)
  end
  self.challengeFloor = params.win and game.role.towerData.floorId - 1 or game.role.towerData.floorId
  self.btnBack:setCallback(function()
    game:enterScene("MainScene", {
      layer = "carbon",
      selected = 3,
      skipMusic = true
    })
  end)
  for i = 1, 4 do
    UIHelper.MoveToDown({
      node = self["imageBg" .. i]
    })
  end
  UIHelper.MoveToUp({
    node = self.downBar,
    time = 0.2
  })
  UIHelper.MoveToUp({
    node = self.herosBg,
    time = 0.2,
    pos = {0, 220}
  })
  self:showHeros()
end

function TowerResultLayer:showData(params)
  self.formatInfo = json.decode(game.role.towerData.formatInfo) or {}
  self.floorsData = json.decode(game.role.towerData.floorInfo)
  local maxFloor = math.min(self.challengeFloor + 3, #self.floorsData)
  local minFloor = math.max(self.challengeFloor - 2, 1)
  if minFloor == 1 then
    maxFloor = 6
  end
  if maxFloor == #self.floorsData then
    minFloor = maxFloor - 5
  end
  local xPos = (maxFloor - minFloor) / 2 * -120
  for floor = minFloor, maxFloor do
    local btn = UIHelper.createTowerFloor(self.floorsData[floor], floor):pos(xPos, -9):addTo(self.floorNode)
    if floor >= self.challengeFloor then
      if floor == self.challengeFloor and params.win then
        btn:removeChildByName("sheng")
        local signSprite = display.newSprite(TowerRes .. "image_sheng.png"):scale(1.5):pos(90, -10):addTo(btn)
        signSprite:runAction(transition.sequence({
          cc.DelayTime:create(0.2),
          cc.Spawn:create(cc.MoveTo:create(0.4, cc.p(54, 12)), cc.ScaleTo:create(0.4, 1))
        }))
      else
        local data = BattleCsv[floor]
        local items = data.gift2see:toTableArray()
        if 1 < #items then
          local gift = UIHelper.newImageView("ui/carbon/chooseTravel/box_6.png"):pos(54, 0):addTo(btn)
          gift:setCallback(function()
            ItemRewardLayer.new({
              items = data.gift2see:toTableArray(),
              preView = true,
              ignore = true
            })
          end)
        else
          ItemIcon.new({
            type = tonumber(items[1][1]),
            count = tonumber(items[1][2]),
            showTip = true
          }):scale(0.7):pos(54, 12):addTo(btn)
        end
      end
    end
    if floor == game.role.towerData.floorId then
      local image = display.newSprite(ResultRes .. (params.win and "text_new.png" or "text_lose.png")):pos(95, 125):addTo(btn)
      image:setOpacity(0)
      image:runAction(cc.Spawn:create(cc.DelayTime:create(0.3), cc.FadeIn:create(0.3)))
      self:btnFlash(btn)
    end
    xPos = xPos + 120
  end
  if params.win then
    local items = BattleCsv[self.challengeFloor].gift:toTableArray()
    if 1 < #items then
      local xPos = (#items - 1) / 2 * -95
      for _, item in ipairs(items) do
        local bg = display.newSprite(TowerRes .. "head_bg.png"):pos(xPos, 0):addTo(self.itemsNode)
        ItemIcon.new({
          type = tonumber(item[1]),
          count = tonumber(item[2]),
          showTip = true
        }):scale(0.6):center(bg):addTo(bg)
        xPos = xPos + 95
      end
    else
      display.newSprite(TowerRes .. "head_bg.png"):addTo(self.itemsNode)
      ItemIcon.new({
        type = tonumber(items[1][1]),
        count = tonumber(items[1][2]),
        showTip = true
      }):scale(0.6):addTo(self.itemsNode)
    end
    if self.challengeFloor < #self.floorsData then
      self.btnNext:setCallback(function()
        if not self:checkCanChallenge() then
          SysError(SYS_ERR_TOWER_TEAM_NEED_CURE)
          return
        end
        local curFloor = game.role.towerData.floorId
        local floorsData = json.decode(game.role.towerData.floorInfo)
        local leftInfo = game.role:getTowerAttrs(json.decode(game.role.towerData.formatInfo) or {}, self.herosInfo)
        local params = {
          type = BattleType.Tower,
          leftInfo = leftInfo,
          floorId = curFloor,
          floorInfo = floorsData[curFloor]
        }
        game:sendData(actionCodes.Tower_battleBeginRpc, MsgPack.pack(""))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Tower_battleBeginRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          game.role.__battleKey = msg.battleKey
          game:enterScene("BattleScene", params)
        end)
      end)
    else
      self.btnNext:setTouchEnabled(false)
      self.btnNext:setImages(ResultRes, {
        "btn_next_b.png",
        "btn_next_b.png"
      })
    end
  else
    self.textReward:hide()
    self.btnNext:setTouchEnabled(false)
    self.btnNext:setImages(ResultRes, {
      "btn_next_b.png",
      "btn_next_b.png"
    })
  end
end

function TowerResultLayer:showHeros()
  self.herosInfo = {}
  local Info = json.decode(game.role.towerData.formatInfo)
  local heros = json.decode(game.role.towerData.herosInfo)
  local xPos = 3
  for slot = 1, 5 do
    local heroId = Info.list[tostring(slot)]
    if heroId then
      local icon = HeroHead.new({heroId = heroId, loveEffect = true}):pos(xPos, 10):addTo(self.heroNode)
      local cur, all, percent = self:getHeroHp(heroId, heros)
      local card = display.newSprite(TowerRes .. "hp_bar_bg.png"):pos(xPos, -47):addTo(self.heroNode)
      local hpBar = display.newProgressTimer(TowerRes .. "hp_bar.png", 1):center(card):addTo(card)
      hpBar:setMidpoint(cc.p(0, 0.5))
      hpBar:setBarChangeRate(cc.p(1, 0))
      hpBar:setPercentage(percent)
      display.newTTFLabel({
        text = string.format("%d/%d", cur, all),
        size = 14
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(xPos, -58):addTo(self.heroNode)
      self.herosInfo[heroId] = heros[tostring(heroId)]
    else
      local card = UIHelper.newImageView("ui/kitchen/quality/bg_1.png"):pos(xPos, 0):addTo(self.heroNode)
      UIHelper.newImageView("ui/kitchen/quality/cook.png"):center(card):addTo(card)
      UIHelper.newImageView("ui/global/item_frame.png"):center(card):addTo(card)
    end
    xPos = xPos + 110
  end
end

function TowerResultLayer:checkCanChallenge()
  for heroId, hp in pairs(self.herosInfo) do
    if hp == 0 then
      return false
    end
  end
  return true
end

function TowerResultLayer:getHeroHp(heroId, heros)
  local hero = game.role.heros[heroId]
  if not hero then
    return 0, 0, 0
  end
  local attrs = hero:getTotalAttrValues()
  local cur = heros[tostring(heroId)]
  if cur then
    local hp = 500 < cur and math.floor(attrs.hp * cur / 1000) or math.ceil(attrs.hp * cur / 1000)
    return hp, attrs.hp, cur / 10
  end
  return attrs.hp, attrs.hp, 100
end

function TowerResultLayer:btnFlash(btn)
  btn:hide()
  local mask = display.newSprite(TowerRes .. "btn_flash.png"):pos(btn:getPosition()):addTo(self.floorNode)
  mask:setOpacity(0)
  mask:runAction(transition.sequence({
    cc.DelayTime:create(0.03),
    cc.MoveBy:create(0, cc.p(-4, -4)),
    cc.Spawn:create(cc.FadeIn:create(0.06), cc.MoveBy:create(0.06, cc.p(4, 4))),
    cc.CallFunc:create(function()
      btn:show()
    end),
    cc.FadeOut:create(0.1),
    cc.CallFunc:create(function()
      mask:removeSelf()
    end)
  }))
end

return TowerResultLayer
