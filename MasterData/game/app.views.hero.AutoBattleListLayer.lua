local ChapterInfoCsv = require("csvdata.chapter_info")
local ChapterBattleCsv = require("csvdata.chapter_battle")
local AutoBattleCsv = require("csvdata.auto_battle")
local ChapterDropCsv = require("csvdata.loop_activity.chapter_drop")
local heroRes = "ui/hero/"
local treatRes = "ui/treat/"
local uiData = {
  csbFile = "ui/hero/AutoBattleListLayer.csb",
  mask = true,
  widgets = {
    btnList = "btnList",
    content = "content",
    btnOther = "btnOther",
    exitBtn = "exitBtn",
    top_bar_angle = "top_bar_angle"
  }
}
local AutoBattleListLayer = class("AutoBattleListLayer", UIBase)

function AutoBattleListLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function AutoBattleListLayer:init(params)
  TopBar:show(TopBarType.full, "编队")
  self.battleCallback = params.callback
  self.battleType = params.battleType
  self.modeType = params.modeType
  self.specialHero = params.specialHero or {}
  self.isAutoBattle = params.isAuto or false
  self.autoBattleList = {}
  local tempList = game.role.autoBattle.teams and game.role.autoBattle.teams:toArray("=", true) or {}
  if tempList then
    for i, value in ipairs(tempList) do
      self.autoBattleList[value] = i
    end
  end
  self.selectNum = self.autoBattleList and table.nums(self.autoBattleList) or 0
  self.carbonId = params.carbonId
  if UIHelper.isiPhoneX() then
    self.top_bar_angle:setPositionX(self.top_bar_angle:getPositionX() + UIHelper.getMoveXForX())
  end
  self:initBtn()
end

function AutoBattleListLayer:initBtn()
  self.bufferLabels = {}
  self.group = MRadioGroup:create()
  local btnSize = display.newSprite(heroRes .. "taocan_1.png"):getContentSize()
  local battleInfo = json.decode(game.role.battleInfo)
  local delay = 0.4
  for index = 1, game.role.teamMaxNum do
    local needShow = true
    if not game.role.formation[tostring(index)] or not game.role.formation[tostring(index)].list["1"] then
      needShow = false
    end
    local status = game.role:getFormationState(index)
    if status[2] or status[3] then
      needShow = false
    end
    if not needShow and self.autoBattleList[index] then
      self.autoBattleList[index] = nil
    end
    if needShow then
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(btnSize):addTo(self.btnList):setName(string.format("%d", index))
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(heroRes, {
        "taocan_1.png",
        "taocan_2.png"
      })
      btn:center(viewNode):addTo(viewNode)
      if self.autoBattleList[index] and self.autoBattleList[index] ~= 0 and self.autoBattleList[index] < 4 then
        btn:setString({
          text = string.format("套餐%d出战(%d)", index, self.autoBattleList[index]),
          size = 18,
          color = UIHelper.hex2rgb("#ffffff")
        })
      else
        btn:setString({
          text = string.format("套餐%d", index),
          size = 22,
          color = UIHelper.hex2rgb("#ffffff")
        })
      end
      btn:setCallback(function()
        self:showFormation(index)
        if self.selectNum < 3 and 3 > table.nums(self.autoBattleList) and not self.autoBattleList[index] then
          self.selectNum = self.selectNum + 1
          self.autoBattleList[index] = self.selectNum
        end
        if self.autoBattleList[index] and self.autoBattleList[index] ~= 0 and self.autoBattleList[index] < 4 then
          btn:setString({
            text = string.format("套餐%d出战(%d)", index, self.autoBattleList[index]),
            size = 18,
            color = UIHelper.hex2rgb("#ffffff")
          })
        else
          btn:setString({
            text = string.format("套餐%d", index),
            size = 22,
            color = UIHelper.hex2rgb("#ffffff")
          })
        end
      end)
      btn:setName(string.format("套餐%d", index))
      btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#630c07"), 1)
      btn:setGroup(self.group)
      UIHelper.MoveToRight({
        node = btn,
        delay = delay,
        time = 0.2
      })
      delay = delay + 0.1
    end
  end
  self.exitBtn:setCallback(function()
    BackManager:pop()
  end)
end

function AutoBattleListLayer:showData(params)
  local selected = params.selected or self.selected
  if selected then
    self.group:chooseByName(string.format("套餐%d", selected))
  end
  local needShow = true
  if not game.role.formation[tostring(params.selected)] or not game.role.formation[tostring(params.selected)].list["1"] then
    needShow = false
  end
  local status = game.role:getFormationState(params.selected)
  if status[2] or status[3] then
    needShow = false
  end
  local needIndex
  for index = 1, game.role.teamMaxNum do
    if game.role.formation[tostring(index)] and game.role.formation[tostring(index)].list["1"] then
      local status = game.role:getFormationState(index)
      if not status[2] and not status[3] then
        needIndex = index
        break
      end
    end
  end
  if selected and needShow then
    self:showFormation(selected)
  else
    self:showFormation(needIndex)
  end
end

function AutoBattleListLayer:updateBtns()
  self.autoBattleList = {}
  self.selectNum = 0
  self.btnList:removeAllChildren()
  self:initBtn()
end

function AutoBattleListLayer:showFormation(index)
  self.content:removeAllChildren()
  self.selected = index
  local xPos, interval = -45, 172
  local totalBattle = 0
  local formationData = game.role.formation[tostring(index)] or {
    list = {},
    pos = {}
  }
  for slot = 1, 5 do
    local card
    local heroId = formationData.list[tostring(slot)]
    if heroId then
      local hero = game.role.heros[heroId]
      totalBattle = totalBattle + hero:getAllValue()
      card = TeamHeroCard.new({
        heroId = heroId,
        captain = slot == 1,
        isSpecial = self.specialHero[hero.type],
        detail = function()
          local layer = game:createView("hero.HeroDetailLayer", {heroId = heroId})
          self:hide()
          BackManager:push(function()
            self:show()
            layer:close()
            TopBar:show(TopBarType.full)
            self:showFormation(self.selected)
          end)
        end
      }):pos(xPos + (slot - 1) * interval, 10):addTo(self.content)
    else
      card = UIHelper.newImageView(heroRes .. "add_bg.png"):pos(xPos + (slot - 1) * interval, 10):addTo(self.content)
      display.newSprite(heroRes .. "show.png"):pos(78, 275):addTo(card)
    end
    self:cardAnimation(card, slot, xPos + (slot - 1) * interval)
  end
  self:InfoPanel(totalBattle, index)
end

function AutoBattleListLayer:showDes(ma1, ma2)
  local bg = UIHelper.newImageView("ui/global/top_bar_value.png"):pos(812, -10):name("info"):addTo(self.content)
  UIHelper.newImageView("ui/global/base_1.png"):pos(20, 15):addTo(bg)
  display.newTTFLabel({
    text = tostring(ma1),
    size = 24,
    color = UIHelper.hex2rgb("#ffffff")
  }):pos(65, 15):addTo(bg)
  local bg2 = UIHelper.newImageView("ui/global/top_bar_value.png"):pos(812, -45):name("info"):addTo(self.content)
  UIHelper.newImageView("ui/global/base_2.png"):pos(20, 15):addTo(bg2)
  display.newTTFLabel({
    text = tostring(ma2),
    size = 24,
    color = UIHelper.hex2rgb("#ffffff")
  }):pos(65, 15):addTo(bg2)
  bg:runAction(transition.sequence({
    cc.FadeIn:create(0.5),
    cc.DelayTime:create(1),
    cc.FadeOut:create(0.5),
    cc.RemoveSelf:create()
  }))
  bg2:runAction(transition.sequence({
    cc.FadeIn:create(0.5),
    cc.DelayTime:create(1),
    cc.FadeOut:create(0.5),
    cc.RemoveSelf:create()
  }))
end

function AutoBattleListLayer:ShowAutoTime(node, btn, text, callBack)
  local time = 5
  local label = display.newTTFLabel({
    text = string.format(text, time),
    size = 18
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(node:getContentSize().width / 2 + 3, -30):addTo(node)
  
  local function timeTick()
    btn:runAction(transition.sequence({
      cc.DelayTime:create(1),
      cc.CallFunc:create(function()
        if 0 < time then
          label:setString(string.format(text, time))
          time = time - 1
          timeTick()
        else
          if type(callBack) == "function" then
            callBack()
          end
          label:removeSelf()
        end
      end)
    }))
  end
  
  timeTick()
end

function AutoBattleListLayer:InfoPanel(value, index)
  local bg = UIHelper.newImageView(heroRes .. "info_bar_1.png"):pos(808, -40):name("info"):addTo(self.content)
  display.newTTFLabel({
    text = value,
    size = 30,
    color = UIHelper.hex2rgb("#ffffff")
  }):pos(bg:getContentSize().width / 2, 222):addTo(bg)
  if UIHelper.isiPhoneX() then
    bg:setPositionX(bg:getPositionX() + UIHelper.getMoveXForX())
  end
  if not self.firstShow then
    bg:setOpacity(0)
    bg:setCascadeOpacityEnabled(true)
    UIHelper.MoveToLeft({
      node = bg,
      delay = 0.4,
      time = 0.18
    })
    self.firstShow = 0
  end
  local btn1 = UIHelper.extend(ccui.Button:create())
  btn1:setImages(heroRes, {
    "btns_1.png",
    "btns_1.png",
    "btns_3.png"
  })
  btn1:pos(bg:getContentSize().width / 2 + 3, 155):addTo(bg)
  btn1:setString({
    text = "重新选择出战",
    size = 18
  })
  btn1:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#000000"), 1)
  btn1:setCallback(function()
    self:updateBtns()
  end)
  
  local function treatQuick()
    game:createView("treat.TreatQuickCostLayer", {
      index = index,
      autoBattle = self.isAutoBattle,
      battleType = BattleType.PvE,
      callback = function(heroIds)
        if not next(heroIds) then
          return
        end
        game:sendData(actionCodes.Hero_quickTreatRpc, MsgPack.pack({ids = heroIds}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Hero_quickTreatRpc, function(event)
          UIHelper.removeWaiting()
          local result = MsgPack.unpack(event.data)
          local count = 1
          for slot, data in pairs(result) do
            game.role:dispatchEvent({
              name = "hero_cure",
              heroId = data.heroId
            })
          end
          SysError(SYS_ERR_TREAT_SUCCESS)
          self:showFormation(self.selected)
        end)
      end
    })
  end
  
  local btn2 = UIHelper.extend(ccui.Button:create())
  btn2:setImages(heroRes, {
    "btns_2.png",
    "btns_2.png",
    "btns_3.png"
  })
  btn2:pos(bg:getContentSize().width / 2 + 3, 95):addTo(bg)
  btn2:setString({
    text = "快速治疗",
    size = 20
  })
  btn2:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#000000"), 1)
  btn2:setCallback(function()
    treatQuick()
  end)
  local formationData = game.role.formation[tostring(index)] or {
    list = {},
    pos = {}
  }
  local haveHurt = false
  for slot = 1, 5 do
    local heroId = formationData.list[tostring(slot)]
    if heroId then
      local hero = game.role.heros[heroId]
      if hero.hpPercent < 1000 then
        haveHurt = true
        break
      end
    end
  end
  if not haveHurt then
    btn2:setEnabled(false)
  end
  local fixbtn = UIHelper.extend(ccui.Button:create()):setCascadeOpacityEnabled(true)
  fixbtn:setImages("ui/global/", {
    "btn_common_green.png",
    "btn_common_green.png"
  })
  fixbtn:pos(bg:getContentSize().width / 2 + 3, 15):addTo(bg):name("battleListBtn")
  fixbtn:setTouchScale()
  UIHelper.newText({
    text = "出击",
    size = 32,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#07552a"), 1):pos(76, 34):addTo(fixbtn)
  
  local function goBattle()
    if game.role:getFormationState(self.selected)[1] then
      SysError(SYS_ERR_HERO_LOCKED_CURE_FIGHT)
      return
    end
    for id, count in pairs(AutoBattleCsv[self.carbonId].cost:toNumMap()) do
      local choose = id < 5 and game.role["material" .. id] or game.role.items[id] or 0
      if count > choose then
        SysError(SYS_ERR_CAEBON_HAPPY_SOURCE_NOT_ENOUGH)
        return
      end
    end
    if self.autoBattleList[1] == 0 then
      self.autoBattleList[1] = nil
    end
    if not self.autoBattleList or not next(self.autoBattleList) then
      SysError(SYS_ERR_FIGHT_NO_TEAM_SET)
      return
    end
    local newList = {}
    for idx, count in pairs(self.autoBattleList) do
      if not (count ~= 0 and count) or 3 < count then
        table.remove(self.autoBattleList, idx)
      else
        newList[count] = idx
      end
    end
    if 3 < table.nums(newList) then
      SysError(SYS_ERR_AUTOHEROS_OVERTHREE)
      return
    end
    for idx, formatId in pairs(newList) do
      local format = game.role.formation[tostring(formatId)]
      if format then
        for _, heroId in pairs(format.list) do
          local hero = game.role.heros[heroId]
          if hero:getProperty("hpPercent") == 0 then
            if UserData.autoBattleLoop == 1 and UserData.autoBattleLoopCure == 1 and self.isAutoBattle and self.battleType == BattleType.PvE then
              self:ShowAutoTime(bg, btn2, "%d秒后治疗", function()
                treatQuick()
              end)
            else
              SysError(SYS_ERR_FIGHT_SET_NO_HP)
            end
            return
          end
        end
      end
    end
    self.battleInfo = json.decode(game.role.battleInfo)
    self.battleInfo.carbonId = self.battleInfo.carbonId or 0
    if self.battleInfo.carbonId ~= 0 then
      SysError(SYS_ERR_CARBON_MAIN_ON_BATTLE)
      return
    end
    if next(json.decode(game.role.moonBattleInfo) or {}) then
      SysError(SYS_ERR_CARBON_ACTIVITY_ON_BATTLE)
      return
    end
    if next(json.decode(game.role.paradiseBattleInfo) or {}) then
      SysError(SYS_ERR_CARBON_HAPPY_ON_BATTLE)
      return
    end
    local temp = {}
    if not newList[1] and not newList[2] and newList[3] then
      temp[1] = newList[3]
      newList = temp
    elseif not newList[1] and newList[2] and newList[3] then
      temp[1] = newList[2]
      temp[2] = newList[3]
      newList = temp
    elseif newList[1] and not newList[2] and newList[3] then
      temp[1] = newList[1]
      temp[2] = newList[3]
      newList = temp
    elseif not newList[1] and newList[2] and not newList[3] then
      temp[1] = newList[2]
      newList = temp
    end
    game:sendData(actionCodes.Carbon_autoBeginRpc, MsgPack.pack({
      chapterId = self.carbonId,
      teams = table.concat(newList, "=")
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Carbon_autoBeginRpc, function(event)
      UIHelper.removeWaiting()
      self.battleCallback()
    end)
  end
  
  fixbtn:setCallback(function()
    goBattle()
  end)
  if self.isAutoBattle and self.battleType == BattleType.PvE and UserData.autoBattleLoop == 1 then
    self:ShowAutoTime(bg, fixbtn, "%d秒后出击", function()
      goBattle()
    end)
  end
end

function AutoBattleListLayer:cardAnimation(card, slot, xPos)
  card:hide()
  local mask = display.newSprite(heroRes .. "card_mask.png"):pos(xPos, 10):addTo(self.content)
  mask:setOpacity(0)
  mask:runAction(transition.sequence({
    cc.DelayTime:create(0.03 * (slot - 1)),
    cc.MoveBy:create(0, cc.p(-8, -8)),
    cc.Spawn:create(cc.FadeIn:create(0.06), cc.MoveBy:create(0.06, cc.p(8, 8))),
    cc.CallFunc:create(function()
      card:show()
    end),
    cc.FadeOut:create(0.18),
    cc.CallFunc:create(function()
      mask:removeSelf()
    end)
  }))
end

return AutoBattleListLayer
