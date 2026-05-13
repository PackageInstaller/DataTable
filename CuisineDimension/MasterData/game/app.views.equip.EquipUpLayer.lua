local EquipCsv = require("csvdata.equip")
local SuitCsv = require("csvdata.equip_suit")
local ReDefineCsv = require("csvdata.equip_refine")
local ItemCsv = require("csvdata.item")
local ReforgeCsv = require("csvdata.equip_reforge")
local LevelCsv = require("csvdata.equip_level")
local EntryCsv = require("csvdata.equip_entry")
local StarExpCsv = require("csvdata.equip_starexp")
local EquipRes = "ui/equip/card/"
local DetailRes = "ui/equip/detail/"
local ForgeRes = "ui/equip/reforge/"
local FixRes = "ui/equip/fix/"
local UpRes = "ui/equip/up/"
local strengthRes = "ui/kitchen/strength/"
local qulaityRes = "ui/kitchen/quality/"
local globalRes = "ui/global/"
local uiData = {
  csbFile = "ui/equip/EquipUpLayer.csb",
  widgets = {
    mainBg = "mainBg",
    rightPanel = "rightPanel",
    leftPanel = "leftPanel",
    angel1 = "angel1",
    angel2 = "angel2",
    buttom = "buttom",
    baseBtn = "rightPanel/baseBtn",
    exBtn = "rightPanel/exBtn",
    upBtn = "rightPanel/upBtn",
    addEquip = "rightPanel/addEquip",
    addSpr = "rightPanel/addEquip/addSpr",
    equipList = "rightPanel/addEquip/equipList",
    attr1 = "rightPanel/attr1",
    attr2 = "rightPanel/attr2",
    circle1 = "leftPanel/circle1",
    circle2 = "leftPanel/circle2",
    circle3 = "leftPanel/circle3",
    frame = "leftPanel/ren/frame",
    equipNode = "leftPanel/ren/equipNode",
    detailNode = "detailNode"
  }
}
local EquipUpLayer = class("EquipUpLayer", UIBase)

function EquipUpLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function EquipUpLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.buttom, true)
    self.rightPanel:setPositionX(self.rightPanel:getPositionX() + 200)
    self.mainBg:setPositionX(self.mainBg:getPositionX() + 200)
    self.buttom:setPositionX(self.buttom:getPositionX() + 205)
    self.angel2:setPositionX(self.angel2:getPositionX() + 185)
  end
  self.frame:runAction(cc.RepeatForever:create(cc.RotateBy:create(30, -360)))
  self.circle1:runAction(cc.RepeatForever:create(cc.RotateBy:create(20, 360)))
  self.circle2:runAction(cc.RepeatForever:create(cc.RotateBy:create(20, 360)))
  self.circle3:runAction(cc.RepeatForever:create(cc.RotateBy:create(20, 360)))
  self.addSpr:hide()
  
  local function rule(equip)
    return self.equip and equip.id == self.equip.id
  end
  
  self.frame:setCallback(function()
    local layer = game:createView("equip.ChooseEquipLayer", {
      rule = rule,
      type = 3,
      callback = function(choose)
        local equip = game.role.equips[choose]
        if equip then
          self.equip = equip
          self:showData()
        end
      end
    })
    BackManager:push(function()
      layer:close()
      TopBar:show(TopBarType.full, "装备")
    end)
  end)
  self.select = 0
  self.slot = 0
  self.eatList = {}
  self.group = MRadioGroup:create()
  self.baseBtn:setGroup(self.group)
  self.baseBtn:setCallback(function()
    self.select = 1
    self:showDetail()
  end)
  self.exBtn:setGroup(self.group)
  self.exBtn:setCallback(function()
    self.select = 2
    self:showDetail()
  end)
  self.upBtn:setTouchScale()
  self.upBtn:setCallback(function()
    if self.select == 0 then
      return
    end
    if self.slot == 0 then
      SysError(SYS_ERR_EQUIP_UP_NO_CHOOSE)
      return
    end
    if not LevelCsv[self.equip:getAttrLevel(self.slot, self.select == 1) + 1] then
      SysError(SYS_ERR_EQUIP_UP_MAX_LEVEL)
      return
    end
    if #self.eatList == 0 then
      SysError(SYS_ERR_EQUIP_UP_NEED_ADD)
      return
    end
    local bHero = false
    for _, equipId in pairs(self.eatList) do
      local equip = game.role.equips[equipId]
      if equip and equip.masterId ~= 0 then
        bHero = true
        break
      end
    end
    local showTip = {}
    for _, equipId in pairs(self.eatList) do
      local equip = game.role.equips[equipId]
      if equip and 1 < equip:getStrengthLevel() then
        showTip[1] = "强化过"
      end
      if equip and equip.csvData.star >= 4 then
        showTip[2] = "高品质"
      end
    end
    
    local function send()
      local list = table.concat(self.eatList, "=")
      game:sendData(actionCodes.Equip_upEquipRpc, MsgPack.pack({
        equipId = self.equip.id,
        type = self.select,
        slot = self.slot,
        eats = list
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Equip_upEquipRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        self.eatList = {}
        self:initOneAttr("ok", msg.oldLevel)
        self:showList()
      end)
    end
    
    local function showTips()
      if next(showTip) then
        MDialog:double({
          text = string.format("选择的材料装备中有<div color=#ff0000>%s</div>的装备\n \n仍要进行强化吗？", table.concat(table.values(showTip), "/"))
        }, function()
          send()
        end)
      else
        send()
      end
    end
    
    if bHero then
      MDialog:double({
        text = "有些装备还在食灵身上穿着，确定要作为材料吗？"
      }, function()
        showTips()
      end)
    else
      showTips()
    end
  end)
  self.addEquip:setCallback(function()
    if self.select == 0 then
      return
    end
    if self.slot == 0 then
      SysError(SYS_ERR_EQUIP_UP_NO_CHOOSE)
      return
    end
    
    local function rule(_equip)
      if _equip.lock == 1 then
        return true
      end
      if _equip.id == self.equip.id then
        return true
      end
      local msaterId = _equip.masterId
      if msaterId ~= 0 then
        return true
      end
    end
    
    local layer = game:createView("equip.ChooseEquipLayer", {
      choosedList = self.eatList,
      multiChoose = true,
      quickChose = true,
      type = 4,
      rule = rule,
      strengthId = self.equip.id,
      slot = self.slot,
      isBase = self.select == 1,
      callback = function(chooseList)
        self.eatList = {}
        for id, _ in pairs(chooseList) do
          table.insert(self.eatList, id)
        end
        self:initOneAttr("choose")
        self:showList()
      end,
      newRule = newrule
    })
    BackManager:push(function()
      layer:close()
      TopBar:show(TopBarType.full, "装备")
    end)
  end)
  UIHelper.MoveToRight({
    node = self.leftPanel
  })
  UIHelper.MoveToLeft({
    node = self.rightPanel
  })
  UIHelper.MoveToUp({
    node = self.buttom,
    delay = 0.2
  })
  UIHelper.MoveToUp({
    node = self.angel1,
    delay = 0.3
  })
  UIHelper.MoveToUp({
    node = self.angel2,
    delay = 0.3
  })
end

function EquipUpLayer:showData()
  self.equipNode:removeAllChildren()
  self.equipList:removeAllChildren()
  self.eatList = {}
  if not self.equip then
    self:showEmpty()
  else
    self.select = 1
    self.upBtn:show()
    self:showEquip()
    self.group:chooseByName("baseBtn")
    self:showDetail()
    self:showList()
  end
end

function EquipUpLayer:showEmpty()
  self.attr1:removeAllChildren()
  self.attr2:removeAllChildren()
  self.upBtn:hide()
  self.select = 0
  self.slot = 0
  if self.group.currentName then
    self.group:unchooseByName(self.group.currentName)
  end
  self.baseBtn:setTouchEnabled(false)
  self.exBtn:setTouchEnabled(false)
  display.newSprite(ForgeRes .. "add.png"):addTo(self.equipNode)
  display.newTTFLabel({
    text = "添加装备",
    size = 22,
    color = UIHelper.hex2rgb("#b4f730")
  }):pos(0, -55):addTo(self.equipNode)
  for i = 1, 2 do
    local node = self["attr" .. i]
    display.newSprite(UpRes .. "qh_2.png"):addTo(node)
    display.newSprite(UpRes .. "qh_3.png"):addTo(node):pos(0, 13)
    display.newTTFLabel({
      text = "请先选择需要强化的装备",
      size = 16,
      color = UIHelper.hex2rgb("#703802")
    }):pos(0, -18):addTo(node)
  end
  display.newSprite(UpRes .. "qh_4.png"):addTo(self.equipList):pos(208, 0)
end

function EquipUpLayer:showDetail()
  self.attr1:removeAllChildren()
  self.attr2:removeAllChildren()
  local haveNum = 0
  local group = MRadioGroup:create()
  if self.select == 1 then
    local baseValue = self.equip.csvData.baseValue
    for index, data in ipairs(baseValue:toTableArray()) do
      haveNum = haveNum + 1
      local node = self["attr" .. haveNum]
      if not node then
        break
      end
      local level = self.equip:getAttrLevel(haveNum, true)
      local exp = self.equip:getAttrExp(haveNum, true)
      self:createOneAttr(tonumber(data[1]), tonumber(data[2]), level, exp, group, haveNum, node, false)
    end
  elseif self.select == 2 then
    for slot = 1, self.equip.csvData.entryNum do
      local attrId = self.equip.attrEx:getv(slot, 0)
      if 0 < attrId then
        haveNum = haveNum + 1
        local node = self["attr" .. haveNum]
        local attrData = EntryCsv[attrId]
        local level = self.equip:getAttrLevel(haveNum, false)
        local exp = self.equip:getAttrExp(haveNum, false)
        self:createOneAttr(attrData.effectType, attrData.effectValue, level, exp, group, haveNum, node, attrData.valueType == 1)
      end
    end
  end
  if 0 < haveNum then
    group:chooseByName("btn1")
    self.slot = 1
    if 0 < #self.eatList then
      self:initOneAttr("choose")
    end
  else
    self.slot = 0
    self.eatList = {}
    self:showList()
  end
  for i = haveNum + 1, 2 do
    if 2 < i then
      break
    end
    local node = self["attr" .. i]
    display.newSprite(UpRes .. "qh_2.png"):addTo(node)
    display.newSprite(UpRes .. "qh_3.png"):addTo(node):pos(0, 0)
  end
end

function EquipUpLayer:showEquip()
  local magic = UIHelper.loadAnimation(ForgeRes, "magic", 29, 30)
  magic.sprite:addTo(self.equipNode)
  magic.sprite:setBlendFunc(cc.blendFunc(gl.ONE, gl.ONE))
  magic.sprite:playAnimationForever(magic.animation)
  display.newSprite(self.equip.csvData.cardName):scale(0.5):addTo(self.equipNode)
  local nameBg = display.newSprite(UpRes .. "zb_1.png"):pos(0, 200):addTo(self.equipNode)
  local proBg = UIHelper.newImageView(string.format("%sprofession_bg_%d.png", globalRes, self.equip.csvData.star - 2)):pos(0, 22):addTo(nameBg)
  display.newSprite(string.format("%sprofession_tag_%d.png", EquipRes, self.equip.csvData.profession)):center(proBg):addTo(proBg)
  MRichText.new({
    text = self.equip:getName(),
    size = 24
  }):anch(0.5, 0.5):pos(115, 22):addTo(nameBg)
  local look = UIHelper.extend(ccui.Button:create())
  look:setImages("ui/global/", {"look.png", "look.png"})
  look:pos(232, 22):addTo(nameBg)
  look:setTouchScale()
  look:setCallback(function()
    local x, y = self.detailNode:getPosition()
    local mask = UIHelper.extend(ccui.Layout:create()):pos(-x, -y):addTo(self.detailNode)
    mask:size(display.width, display.height)
    mask:setBackGroundColorType(1)
    mask:setBackGroundColor(cc.c3b(0, 0, 0))
    mask:setBackGroundColorOpacity(191)
    mask:setTouchEnabled(true)
    mask:setCallback(function()
      self.detailNode:removeAllChildren()
    end)
    if UIHelper.isiPhoneX() then
      UIHelper.fitForiPhoneX(mask)
    end
    game:createView("equip.EquipDetailLayer", {
      scene = self.detailNode,
      equipId = self.equip.id,
      showHero = true,
      showBg = 1
    })
  end)
end

function EquipUpLayer:createOneAttr(type, value, level, exp, group, index, node, isPercent)
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(UpRes, {"qh_8.png", "qh_6.png"})
  btn:center(node):addTo(node)
  btn:setCallback(function()
    self:initOneAttr("unchoose")
    self.slot = index
    if #self.eatList > 0 then
      self:initOneAttr("choose")
    end
  end)
  btn:setName(string.format("btn%d", index))
  btn:setGroup(group)
  display.newTTFLabel({
    text = string.format("%s+%d%s", AttrDesc[type], value, isPercent and "%" or ""),
    size = 20,
    color = UIHelper.hex2rgb("#703802")
  }):anch(0, 0.5):pos(-181, 25):addTo(node):name("title")
  display.newTTFLabel({
    text = "x" .. LevelCsv[level].strengthValue,
    size = 19,
    color = UIHelper.hex2rgb("#159415")
  }):anch(0, 0.5):pos(-73, 23):addTo(node):name("value")
  display.newTTFLabel({
    text = "强化等级：" .. (LevelCsv[level + 1] and "Lv" .. level .. "/" .. LevelCsv[#LevelCsv].id or "MAX"),
    size = 17,
    color = UIHelper.hex2rgb("#703802")
  }):anch(0, 0.5):pos(-184, -8):addTo(node):name("level")
  display.newTTFLabel({
    text = "强化系数：" .. LevelCsv[level].strengthValue,
    size = 17,
    color = UIHelper.hex2rgb("#703802")
  }):anch(0, 0.5):pos(-184, -32):addTo(node):name("valueNow")
  display.newSprite(strengthRes .. "bar_bg.png"):addTo(node):pos(90, -8)
  progress = display.newProgressTimer(strengthRes .. "progress.png", 1):pos(90, -8):addTo(node):name("progress")
  progress:setMidpoint(cc.p(0, 0.5))
  progress:setBarChangeRate(cc.p(1, 0))
  progress:setPercentage(LevelCsv[level + 1] and (exp - LevelCsv[level].exp) / (LevelCsv[level + 1].exp - LevelCsv[level].exp) * 100 or 100)
  bar = display.newProgressTimer(strengthRes .. "bar.png", 1):pos(90, -8):addTo(node):name("bar")
  bar:setMidpoint(cc.p(0, 0.5))
  bar:setBarChangeRate(cc.p(1, 0))
  bar:setPercentage(LevelCsv[level + 1] and (exp - LevelCsv[level].exp) / (LevelCsv[level + 1].exp - LevelCsv[level].exp) * 100 or 100)
  if LevelCsv[level + 1] then
    display.newSprite(UpRes .. "qh_9.png"):addTo(node):pos(-21, -34):name("arrow")
    display.newTTFLabel({
      text = LevelCsv[level + 1].strengthValue,
      size = 17,
      color = UIHelper.hex2rgb("#703802")
    }):anch(0, 0.5):pos(7, -32):addTo(node):name("valueTo")
    display.newTTFLabel({
      text = math.floor(exp - LevelCsv[level].exp) .. "/" .. LevelCsv[level + 1].exp - LevelCsv[level].exp,
      size = 16,
      color = UIHelper.hex2rgb("#ffffff")
    }):anch(0.5, 0.5):pos(90, -8):addTo(node):name("exp"):enableOutline(UIHelper.hex2rgb("#000000"), 1)
  end
end

function EquipUpLayer:showList()
  self.equipList:removeAllChildren()
  if #self.eatList == 0 then
    local card = UIHelper.newImageView(qulaityRes .. "bg_1.png")
    UIHelper.newImageView(globalRes .. "item_frame.png"):center(card):addTo(card)
    UIHelper.newImageView(globalRes .. "add.png"):pos(46, 53):addTo(card)
    card:anch(0.5, 0.5):pos(0, 0):addTo(self.equipList)
    display.newTTFLabel({
      text = "添加材料",
      size = 14,
      color = UIHelper.hex2rgb("#b3a27e")
    }):pos(45, 25):addTo(card)
  else
    local cellSize = display.newSprite("ui/global/item_bg.png"):getContentSize()
    local MaxX = 300
    local xPos = 0
    local interval = MaxX / (#self.eatList - 1)
    if interval > cellSize.width + 5 then
      interval = cellSize.width + 5
    end
    for index = 1, #self.eatList do
      local equip = game.role.equips[self.eatList[index]]
      local card = ItemIcon.new({
        type = equip:getItemId()
      })
      card:anch(0.5, 0.5):pos(xPos, 0):addTo(self.equipList)
      card:setCallback(function()
        table.remove(self.eatList, index)
        self:showList()
        self:initOneAttr("choose")
      end)
      xPos = xPos + interval
    end
    local card = UIHelper.newImageView(qulaityRes .. "bg_1.png")
    UIHelper.newImageView(globalRes .. "item_frame.png"):center(card):addTo(card)
    UIHelper.newImageView(globalRes .. "add.png"):pos(46, 53):addTo(card)
    card:anch(0.5, 0.5):pos(xPos - interval + cellSize.width, 0):addTo(self.equipList)
    display.newTTFLabel({
      text = "添加材料",
      size = 14,
      color = UIHelper.hex2rgb("#b3a27e")
    }):pos(45, 25):addTo(card)
  end
end

function EquipUpLayer:initOneAttr(type, oldLevel)
  local node = self["attr" .. self.slot]
  local progress = node:getChildByName("progress")
  local bar = node:getChildByName("bar")
  local newLevel = self.equip:getAttrLevel(self.slot, self.select == 1)
  local expLab = node:getChildByName("exp")
  local perect, max, oldexp, exp = self:getPerectTemp()
  if type == "choose" then
    if LevelCsv[newLevel + 1] then
      progress:stopAllActions()
      progress:setPercentage(perect)
      progress:runAction(cc.RepeatForever:create(transition.sequence({
        cc.FadeTo:create(0.5, 100),
        cc.FadeTo:create(0.5, 255)
      })))
      expLab:setString(math.floor(exp) .. "/" .. max)
    end
  elseif type == "unchoose" then
    if LevelCsv[newLevel + 1] then
      progress:stopAllActions()
      progress:setPercentage(0)
      expLab:setString(math.floor(oldexp) .. "/" .. max)
    end
  elseif type == "ok" then
    node:getChildByName("value"):setString("x" .. LevelCsv[newLevel].strengthValue)
    node:getChildByName("level"):setString("强化等级：" .. (LevelCsv[newLevel + 1] and "Lv" .. newLevel .. "/" .. LevelCsv[#LevelCsv].id or "MAX"))
    node:getChildByName("valueNow"):setString("强化系数：" .. LevelCsv[newLevel].strengthValue)
    if LevelCsv[newLevel + 1] then
      node:getChildByName("valueTo"):setString(LevelCsv[newLevel + 1].strengthValue)
      expLab:setString(math.floor(oldexp) .. "/" .. max)
    else
      node:getChildByName("arrow"):hide()
      node:getChildByName("valueTo"):hide()
      expLab:hide()
    end
    local action = {}
    if oldLevel < newLevel then
      table.insert(action, cc.ProgressTo:create(0.5, 100))
      if LevelCsv[newLevel + 1] then
        table.insert(action, cc.ProgressTo:create(0, 0))
      end
    end
    if LevelCsv[newLevel + 1] then
      table.insert(action, cc.ProgressTo:create(1, oldexp / max * 100))
    end
    bar:runAction(cc.Sequence:create(action))
    progress:stopAllActions()
    progress:setPercentage(0)
  end
end

function EquipUpLayer:getUpExp()
  local exp = 0
  for index = 1, #self.eatList do
    local equip = game.role.equips[self.eatList[index]]
    exp = exp + StarExpCsv[equip.csvData.star].selfexp + (equip:getAttrExp(1, false) + equip:getAttrExp(2, false) + equip:getAttrExp(1, true) + equip:getAttrExp(2, true)) * globalCsv.equipStrength_ExpLose
  end
  return exp
end

function EquipUpLayer:getPerectTemp()
  local level = self.equip:getAttrLevel(self.slot, self.select == 1)
  local oldexp = self.equip:getAttrExp(self.slot, self.select == 1) - LevelCsv[level].exp
  local exp = oldexp + self:getUpExp()
  local perect = LevelCsv[level + 1] and exp / (LevelCsv[level + 1].exp - LevelCsv[level].exp) * 100 or 100
  if 100 < perect then
    perect = 100
  end
  return perect, LevelCsv[level + 1] and LevelCsv[level + 1].exp - LevelCsv[level].exp or 0, oldexp, exp
end

function EquipUpLayer:showAnimation(up, old)
  self.heroNode:runAction(transition.sequence({
    cc.CallFunc:create(function()
    end),
    cc.DelayTime:create(0.3),
    cc.CallFunc:create(function()
      self.eatList = {}
      self:initOneAttr("ok", up)
      self:showList()
    end)
  }))
end

return EquipUpLayer
