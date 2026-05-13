local heroRes = "ui/hero/"
local BoxMainRes = "ui/diner/box/"
local SpeakRes = "speakFrame/"
local uiData = {
  csbFile = "ui/diner/DinerBoxHerosLayer.csb",
  mask = true,
  maskClick = true,
  widgets = {
    panel1 = "heroBg/panel1",
    node1 = "heroBg/panel1/node1",
    node2 = "heroBg/panel1/node2",
    node3 = "heroBg/panel1/node3",
    node4 = "heroBg/panel1/node4",
    node5 = "heroBg/panel1/node5",
    panel2 = "heroBg/panel2",
    list = "heroBg/panel2/list",
    touch = "heroBg/touch",
    btnsNode = "heroBg/btnsNode"
  }
}
local btnsData = {
  [1] = {
    name = "属性显示",
    func = function(self)
      self:reflashUILayer()
    end
  },
  [2] = {
    name = "台词设定",
    func = function(self)
      self:reflashUILayer()
    end
  }
}
local DinerBoxHerosLayer = class("DinerBoxHerosLayer", UIBase)

function DinerBoxHerosLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function DinerBoxHerosLayer:init(params)
  self.boxId = params.boxId
  self.callback = params.callback
  self.select = params.select or 1
  local xPos = 0
  local group = MRadioGroup:create()
  for index, data in ipairs(btnsData) do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(BoxMainRes, {"btn_a.png", "btn_b.png"})
    btn:anch(0, 1):pos(xPos, 0):addTo(self.btnsNode)
    btn:setCallback(function()
      self.select = index
      data.func(self)
    end)
    btn:setName(string.format("btn%d", index))
    btn:setGroup(group)
    display.newTTFLabel({
      text = data.name,
      size = 26
    }):enableOutline(UIHelper.hex2rgb("#863b09"), 2):pos(71, 33):addTo(btn)
    xPos = xPos + 155
  end
  group:chooseByName("btn" .. self.select)
end

function DinerBoxHerosLayer:showData(params)
  self:reflashUILayer()
end

function DinerBoxHerosLayer:reflashUILayer()
  if self.select == 1 then
    self.panel1:show()
    self.panel2:hide()
  else
    self.panel2:show()
    self.panel1:hide()
  end
  self.Data = json.decode(game.role.diner["box" .. self.boxId])
  if self.select == 1 then
    self:showHerosLayer()
  else
    self:showWordsLayer()
  end
end

function DinerBoxHerosLayer:showHerosLayer()
  self.heros = self.Data.heros or {}
  for slot = 1, 5 do
    local card
    local heroId = self.heros[slot]
    local node = self["node" .. slot]
    node:removeAllChildren()
    if heroId then
      local hero = game.role.heros[heroId]
      card = TeamHeroCard.new({
        heroId = heroId,
        callback = function()
          self:addHero(slot, heroId)
        end
      })
      card:addTo(node)
      self:cardAnimation(card, slot)
    else
      card = UIHelper.newImageView(heroRes .. "add_bg.png"):addTo(node)
      UIHelper.newImageView(heroRes .. "add.png"):pos(78, 275):addTo(card)
      UIHelper.newText({
        text = "选择食灵",
        size = 16,
        color = UIHelper.hex2rgb("#bf9a77")
      }):pos(78, 236):addTo(card)
      card:setCallback(function()
        self:addHero(slot)
      end)
    end
  end
end

function DinerBoxHerosLayer:addHero(slot, heroId)
  local function rule(hero)
    for _, id in pairs(self.heros) do
      if hero.id == id then
        return true
      end
    end
    return false
  end
  
  local layer = game:createView("diner.ChooseBoxHeroLayer", {
    heroId = heroId,
    rule = rule,
    max = 5,
    choosedList = self.heros,
    callback = function(choose)
      local list = {}
      if type(choose) == "table" then
        for id, _ in pairs(choose) do
          local hero = game.role.heros[id]
          if hero then
            table.insert(list, id)
          end
        end
      else
        if choose ~= 0 then
          self.heros[slot] = choose
        else
          for index, id in pairs(self.heros) do
            if id == heroId then
              table.remove(self.heros, index)
              break
            end
          end
        end
        list = self.heros
      end
      local endList = {}
      for _, id in pairs(list) do
        table.insert(endList, id)
      end
      game:sendData(actionCodes.Diner_heroToBoxRpc, MsgPack.pack({
        slot = self.boxId,
        heros = endList
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Diner_heroToBoxRpc, function(event)
        UIHelper.removeWaiting()
        self:showData()
      end)
    end
  })
  self:hide()
  BackManager:push(function()
    self:show()
    layer:close()
  end)
end

function DinerBoxHerosLayer:cardAnimation(card, slot)
  card:hide()
  local mask = display.newSprite(heroRes .. "card_mask.png"):addTo(self["node" .. slot])
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

local cellSize = cc.size(856, 116)

function DinerBoxHerosLayer:showWordsLayer()
  self.list:removeAllChildren()
  local had = false
  for slot = 1, 5 do
    local heroId = self.heros[slot]
    if heroId then
      had = true
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(cellSize):addTo(self.list)
      local cell = display.newSprite(BoxMainRes .. "box_hero_cell.png"):center(viewNode):addTo(viewNode)
      HeroHead.new({heroId = heroId}):pos(62, 56):addTo(cell)
      local frameIndex = self.Data.talkBg and self.Data.talkBg[slot] or 1
      local btnFrame = UIHelper.extend(ccui.Button:create())
      btnFrame:setImages(SpeakRes, {
        string.format("frame_%d.png", frameIndex),
        string.format("frame_%d.png", frameIndex)
      })
      btnFrame:pos(667, 56):addTo(cell)
      btnFrame:setTouchScale()
      btnFrame:setCallback(function()
        game:createView("diner.DinerBoxSpeakFrameLayer", {
          selected = frameIndex,
          callback = function(index)
            if index == frameIndex then
              return
            end
            game:sendData(actionCodes.Diner_changeTalkBgRpc, MsgPack.pack({
              slot = self.boxId,
              index = slot,
              talkBg = index
            }))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Diner_changeTalkBgRpc, function(event)
              UIHelper.removeWaiting()
              frameIndex = index or 1
              btnFrame:setImages(SpeakRes, {
                string.format("frame_%d.png", frameIndex),
                string.format("frame_%d.png", frameIndex)
              })
            end)
          end
        })
      end)
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(BoxMainRes, {
        "btn_cell_edit.png",
        "btn_cell_edit.png"
      })
      btn:pos(780, 56):addTo(cell)
      btn:setTouchScale()
      local oriContent = self.Data.talk and self.Data.talk[slot] or ""
      local content = display.newTTFLabel({
        text = oriContent,
        size = 18,
        color = UIHelper.hex2rgb("#60271a"),
        dimensions = cc.size(374, 24)
      }):anch(0, 1):pos(162, 67):addTo(cell)
      local label = display.newTTFLabel({text = "编辑", size = 20}):enableOutline(UIHelper.hex2rgb("#bc7217"), 1):pos(34, 25):addTo(btn)
      btn:setCallback(function()
        btn:setImages(BoxMainRes, {
          "btn_cell_save.png",
          "btn_cell_save.png"
        })
        label:setString("保存")
        label:enableOutline(UIHelper.hex2rgb("#226112"), 1)
        local input = ccui.EditBox:create(cc.size(384, 32), BoxMainRes .. "input_bg.png")
        input:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
        input:setText(oriContent)
        input:setFontSize(18)
        input:setMaxLength(14)
        input:anch(0, 1):pos(content:getPosition()):addTo(cell)
        input:setFontColor(UIHelper.hex2rgb("#60271a"))
        input:touchDownAction(input, 2)
        content:removeFromParent()
        btn:setCallback(function()
          local text = input:getText()
          if oriContent == text then
            self:showData()
            return
          end
          text = string.gsub(text, "\n", " ")
          local textTemp = string.gsub(text, " ", "")
          if textTemp:len() == 0 then
            input:setText("")
          end
          local result = self:checkStr(text)
          if not result then
            SysError(SYS_ERR_CHAT_CONTENT_NOT_SUPPORT)
            return
          end
          local chars = text:stringToChars()
          for _, char in ipairs(chars) do
            if not char:checkChatWords() then
              SysError(SYS_ERR_CHAT_CONTENT_NOT_SUPPORT)
              return
            end
          end
          game:sendData(actionCodes.Diner_changeTalkRpc, MsgPack.pack({
            slot = self.boxId,
            index = slot,
            talk = text
          }))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Diner_changeTalkRpc, function(event)
            UIHelper.removeWaiting()
            self:showData()
          end)
        end)
      end)
    end
  end
  if not had then
    display.newTTFLabel({
      text = "还没有添加任何食灵哦",
      size = 20,
      color = UIHelper.hex2rgb("#f6edd8")
    }):enableOutline(UIHelper.hex2rgb("#373535"), 1):center(self.list):addTo(self.list)
  end
end

function DinerBoxHerosLayer:checkStr(str)
  if not str then
    return
  end
  local patten = {
    "http",
    "ftp",
    "www.",
    ".com",
    ".cn",
    ".net",
    ".org",
    ".cc",
    ".info"
  }
  for _, p in ipairs(patten) do
    if str:match(p) then
      return
    end
  end
  return true
end

function DinerBoxHerosLayer:onExit()
  self.callback()
end

return DinerBoxHerosLayer
