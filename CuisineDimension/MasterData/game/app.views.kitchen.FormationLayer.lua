local formationCsv = require("csvdata.formation")
local formationRes = "ui/kitchen/formation/"
local qulaityRes = "ui/kitchen/quality/"
local uiData = {
  csbFile = "ui/kitchen/FormationLayer.csb",
  widgets = {
    listNode = "listNode",
    value = "key/value",
    list = "listNode/list",
    detailNode = "detailNode",
    ok = "detailNode/mainBg/ok",
    time = "detailNode/mainBg/time",
    notes = "detailNode/mainBg/notes",
    heroPos = "detailNode/mainBg/heroPos",
    attrPos = "detailNode/mainBg/attrPos",
    circleBig = "detailNode/mainBg/circleBig",
    circleSmall = "detailNode/mainBg/circleSmall"
  }
}
local FormationLayer = class("FormationLayer", UIBase)

function FormationLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function FormationLayer:init(params)
  self.endPos = {
    x = self.detailNode:getPositionX(),
    y = self.detailNode:getPositionY()
  }
  self.ok:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#722c02"), 1)
  self.cards = {}
  self.pop = true
end

function FormationLayer:showData(params)
  self.listNode:removeAllChildren()
  self.researchData = json.decode(game.role.researchJson) or {}
  self.value:setString(game.role.items[globalCsv.quickResearsh] or 0)
  local itemSize = UIHelper.newImageView(formationRes .. "house.png"):getContentSize()
  local width = itemSize.width + 25
  for index = 1, 2 do
    local card = UIHelper.newImageView(formationRes .. "house.png"):anch(0, 0):pos((index - 1) * width, 100):addTo(self.listNode)
    self.cards[index] = card
    self:showCardDetail(index)
  end
end

function FormationLayer:showCardDetail(slot)
  local card = self.cards[slot]
  local Data = self.researchData[tostring(slot)]
  card:removeAllChildren()
  local pz = UIHelper.createSpineNodeByRes("spine/ui/kitchen/paizi"):name("pz"):pos(95, 20):addTo(card)
  local wz = UIHelper.createSpineNodeByRes("spine/ui/kitchen/dt"):name("wz"):pos(190, -15):addTo(card)
  wz:setAnimation(0, "idle", true)
  UIHelper.newImageView(formationRes .. "zhuan.png"):pos(187, 0):addTo(card)
  if Data then
    pz:setAnimation(0, "1", false)
    self:showResearchState(slot, Data, card)
  else
    pz:setAnimation(0, "2", false)
    self:showNormalState(slot, card)
  end
end

function FormationLayer:showResearchState(index, Data, card)
  local hero = game.role.heros[Data.heroId]
  local spineNode = UIHelper.createSpineNode(hero.type)
  spineNode:pos(185, 25):addTo(card)
  spineNode:setAnimation(0, "idle", true)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages("ui/global/", {
    "btn_common.png",
    "btn_common.png"
  })
  btn:setString({
    text = "快速研究"
  })
  btn:pos(185, -30):addTo(card)
  local timeBg = UIHelper.newImageView(formationRes .. "clock_bg.png"):pos(160, 315):addTo(card)
  local time = display.newTTFLabel({
    text = "",
    size = 14,
    color = UIHelper.hex2rgb("#0f7d03")
  }):pos(50, 14):addTo(timeBg)
  local newTime = game:nowTime()
  if newTime < Data.time then
    local function setTime1()
      local leftTimeVal = Data.time - game:nowTime()
      
      if 0 <= leftTimeVal then
        time:setString(UIHelper.getTimeStr(leftTimeVal))
        time:runAction(transition.sequence({
          cc.DelayTime:create(1),
          cc.CallFunc:create(function()
            setTime1()
          end)
        }))
      else
        time:setString("完成")
        btn:setString({text = "完成"})
        spineNode:setAnimation(0, "cheer", true)
        btn:setCallback(function()
          self:sendFinishRequest(index, hero.type)
        end)
      end
    end
    
    setTime1()
    btn:setCallback(function()
      if 0 < (game.role.items[globalCsv.quickResearsh] or 0) then
        MDialog:double({
          text = "确定使用加速卷轴吗？"
        }, function()
          self:sendFinishRequest(slot, hero.type, true)
        end)
      else
        MDialog:double({
          text = "没有加速卷轴"
        }, function()
        end)
      end
    end)
  else
    time:setString("完成")
    btn:setString({text = "完成"})
    spineNode:setAnimation(0, "cheer", true)
    btn:setCallback(function()
      self:sendFinishRequest(index, hero.type)
    end)
  end
end

function FormationLayer:showNormalState(index, card)
  local addBtn = UIHelper.newImageView("ui/global/blackman.png")
  local jianying = UIHelper.newImageView("ui/global/jianying.png"):center(addBtn):addTo(addBtn)
  jianying:setOpacity(0)
  jianying:runAction(cc.RepeatForever:create(transition.sequence({
    cc.FadeIn:create(1),
    cc.FadeOut:create(1)
  })))
  addBtn:pos(185, 88):addTo(card)
  addBtn:setCallback(function()
    local function rule(hero)
      local states = hero:getState()
      
      if states[1] or states[2] or states[3] then
        return true
      end
      return formationCsv[hero:getFormationId()][hero.fieldLevel].levelLimit <= hero.fieldLevel
    end
    
    local layer = game:createView("hero.ChooseHeroLayer", {
      rule = rule,
      callback = function(choose)
        self:showHeroDetail(index, choose)
      end
    })
    self:hide()
    BackManager:push(function()
      self:show()
      layer:close()
    end)
  end)
end

function FormationLayer:showHeroDetail(slot, heroId)
  local hero = game.role.heros[heroId]
  local data = formationCsv[hero:getFormationId()][hero.fieldLevel]
  self.heroPos:removeAllChildren()
  self.attrPos:removeAllChildren()
  self.notes:removeAllChildren()
  self.time:removeAllChildren()
  self.detailNode:runAction(transition.sequence({
    cc.MoveBy:create(0.2, cc.p(-970, 0)),
    cc.CallFunc:create(function()
      BackManager:push(function()
        if self.pop then
          self.detailNode:runAction(cc.MoveTo:create(0.2, cc.p(self.endPos)))
        else
          BackManager:pop()
        end
      end)
    end)
  }))
  self.circleSmall:runAction(cc.RepeatForever:create(cc.RotateBy:create(15, 360)))
  self.circleBig:runAction(cc.RepeatForever:create(cc.RotateBy:create(20, 360)))
  local spineNode = UIHelper.createSpineNode(hero.type, {})
  spineNode:addTo(self.heroPos)
  spineNode:setAnimation(0, "idle", true)
  display.newTTFLabel({
    text = "耗时:  " .. UIHelper.getTimeStr(data.researchTime),
    size = 20,
    color = UIHelper.hex2rgb("#532c1b")
  }):anch(0, 0.5):addTo(self.time)
  for index = 1, 5 do
    display.newSprite(qulaityRes .. "arrow.png"):pos(125, (index - 1) * -24):addTo(self.attrPos)
    display.newSprite(qulaityRes .. "arrow.png"):pos(132, (index - 1) * -24):addTo(self.attrPos)
    display.newSprite(qulaityRes .. "arrow.png"):pos(139, (index - 1) * -24):addTo(self.attrPos)
    display.newSprite(qulaityRes .. "arrow.png"):pos(146, (index - 1) * -24):addTo(self.attrPos)
  end
  display.newTTFLabel({
    text = "lv" .. tostring(hero.fieldLevel),
    size = 26,
    color = UIHelper.hex2rgb("#532c1b")
  }):pos(95, 3):addTo(self.attrPos)
  display.newTTFLabel({
    text = "lv" .. tostring(hero.fieldLevel + 1),
    size = 26,
    color = UIHelper.hex2rgb("#532c1b")
  }):pos(181, 3):addTo(self.attrPos)
  local nameTable = {
    [1] = "攻速提升",
    [2] = "命中增加",
    [3] = "闪避增加",
    [4] = "暴击增加"
  }
  for index, name in ipairs(nameTable) do
    display.newTTFLabel({
      text = name .. tostring(index * 10) .. "%",
      size = 16,
      color = UIHelper.hex2rgb("#532c1b")
    }):pos(60, index * -24):addTo(self.attrPos)
    MRichText.new({
      text = string.format(name .. "<div color=#fd611c>%d</div>", index * 10 + 3) .. "%",
      size = 16,
      color = UIHelper.hex2rgb("#532c1b")
    }):anch(0.5, 0.5):pos(210, index * -24):addTo(self.attrPos)
  end
  local needItem = data.researchUse:toNumMap()
  for id, count in pairs(needItem) do
    local total = game.role.items[id] or 0
    local color = count < total and "#158000" or "#fd611c"
    if id == 21 then
    else
      display.newTTFLabel({
        text = string.format("%d/%d", total, count),
        size = 20,
        color = UIHelper.hex2rgb(color)
      }):anch(0.5, 0.5):pos(self.notes:getContentSize().width / 2, -25):addTo(self.notes)
    end
  end
  self.ok:setCallback(function()
    for id, count in pairs(needItem) do
      if count > (game.role.items[id] or 0) then
        SysError(SYS_ERR_RESEARCH_MATERIAL_NOT_ENOUGH)
        return
      end
    end
    if hero.fieldLevel >= data.levelLimit then
      SysError(SYS_ERR_RESEARCH_FORMATION_LEVEL_MAX)
      return
    end
    game:sendData(actionCodes.Hero_researchRpc, MsgPack.pack({
      slot = tostring(slot),
      heroId = heroId
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Hero_researchRpc, function(event)
      UIHelper.removeWaiting()
      self.researchData = json.decode(game.role.researchJson) or {}
      self:showCardDetail(slot)
      BackManager:pop()
    end)
  end)
end

function FormationLayer:sendFinishRequest(slot, type, now)
  game:sendData(actionCodes.Hero_finishResearchRpc, MsgPack.pack({
    slot = tostring(slot),
    rightNow = now
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Hero_finishResearchRpc, function(event)
    UIHelper.removeWaiting()
    self.researchData = json.decode(game.role.researchJson) or {}
    local msg = MsgPack.unpack(event.data)
    HeroRewardLayer.new({
      type = type,
      callback = function()
        self:showCardDetail(slot)
      end
    })
  end)
end

return FormationLayer
