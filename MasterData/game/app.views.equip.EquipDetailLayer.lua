local EquipCsv = require("csvdata.equip")
local EntryCsv = require("csvdata.equip_entry")
local SuitCsv = require("csvdata.equip_suit")
local ProfessionCsv = require("csvdata.profession")
local UnitCsv = require("csvdata.unit")
local LevelCsv = require("csvdata.equip_level")
local CardRes = "ui/equip/card/"
local DetailRes = "ui/equip/detail/"
local uiData = {
  csbFile = "ui/equip/EquipDetailLayer.csb",
  widgets = {
    mainBg1 = "mainBg1",
    mainBg2 = "mainBg2",
    btnCancel = "mainBg2/btnCancel",
    btnOk = "mainBg2/btnOk",
    panel1 = "panel1",
    iconNode = "panel1/iconNode",
    nameNode = "panel1/nameNode",
    countNode = "panel1/countNode",
    levelNode = "panel1/levelNode",
    node1 = "panel2/bgBase/node1",
    node2 = "panel2/bgEx/node2",
    node3 = "panel2/bgSuit/node3",
    suitTip = "panel2/bgSuit/suitTip"
  }
}
local EquipDetailLayer = class("EquipDetailLayer", UIBase)

function EquipDetailLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function EquipDetailLayer:init(params)
  self.wear = params.wear or false
  self.showHero = params.showHero or false
  self.hideLock = params.hideLock or false
  self.callback = params.callback or function()
  end
  local showBg = params.showBg or false
  if showBg then
    self["mainBg" .. showBg % 2 + 1]:hide()
  else
    self.mainBg1:hide()
    self.mainBg2:hide()
  end
  self.btnCancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
  self.btnOk:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
  self.btnCancel:setCallback(function()
    if params.cancelCallback then
      params.cancelCallback()
    end
  end)
  self.btnOk:setCallback(function()
    if params.okCallback then
      params.okCallback()
    end
  end)
end

function EquipDetailLayer:showData(params)
  local equipId = params.equipId
  if not equipId or equipId == 0 then
    self.panel1:setTexture(DetailRes .. "bg_title.png")
    MRichText.new({
      text = "搭配精致的食器、厨具、餐具，会让你烹饪的料理更有味道！        —— 薇琪",
      size = 16,
      color = UIHelper.hex2rgb("#8a6b6b"),
      maxWidth = 280
    }):anch(0, 0.5):pos(-25, 0):addTo(self.iconNode)
    display.newSprite(DetailRes .. "lock.png"):anch(0, 0.5):pos(0, -8):addTo(self.node1)
    display.newSprite(DetailRes .. "lock.png"):anch(0, 0.5):pos(0, -18):addTo(self.node2)
    display.newSprite(DetailRes .. "lock.png"):anch(0, 0.5):pos(0, -32):addTo(self.node3)
    self.suitTip:setString("请选择需要查看的装备")
    self.suitTip:setTextColor(UIHelper.hex2rgb("#b59075"))
  else
    self.equip = game.role.equips[params.equipId]
    local equipData = EquipCsv[self.equip.type]
    self:initPanel1(equipData)
    self:initPanel2(equipData)
  end
end

function EquipDetailLayer:initPanel1(data)
  local icon = EquipIcon.new({
    id = self.equip.id,
    showHero = self.showHero
  }):addTo(self.iconNode)
  if self.wear then
    display.newSprite("ui/equip/wear/take_on.png"):scale(0.68):pos(46, 45):addTo(icon)
  end
  MRichText.new({
    text = self.equip:getName(),
    size = 20
  }):anch(0, 0.5):pos(0, 0):addTo(self.nameNode)
  local color = self.equip.masterId ~= 0 and "#057114" or "#b65c2c"
  display.newTTFLabel({
    text = "所需食灵等级:  Lv" .. data.level,
    size = 16,
    color = UIHelper.hex2rgb(color)
  }):anch(0, 0.5):pos(0, 0):addTo(self.levelNode)
  display.newTTFLabel({
    text = "改造次数：",
    size = 16,
    color = UIHelper.hex2rgb("#703802")
  }):anch(0, 0.5):pos(0, 0):addTo(self.countNode)
  if self.equip.washLimit == 0 then
    display.newTTFLabel({
      text = "无",
      size = 16,
      color = UIHelper.hex2rgb("#703802")
    }):anch(0, 0.5):pos(75, 0):addTo(self.countNode)
    return
  end
  local xPos = 71
  for index = 1, self.equip.washLimit do
    local image = index <= self.equip.washCount and "green.png" or "grey.png"
    display.newSprite(DetailRes .. image):anch(0, 0.5):pos(xPos, -3):addTo(self.countNode)
    xPos = xPos + 20
  end
  if not self.hideLock then
    local lock = self.equip.lock or 0
    local image = UIHelper.newImageView(DetailRes .. "image_unlock.png"):pos(220, 0):addTo(self.nameNode)
    if lock == 1 then
      image:setImage(DetailRes .. "image_lock.png")
    end
    image:setCallback(function()
      game:sendData(actionCodes.Equip_changeLockStatusRpc, MsgPack.pack({
        equipId = self.equip.id
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Equip_changeLockStatusRpc, function(event)
        UIHelper.removeWaiting()
        if lock == 0 then
          lock = 1
          image:setImage(DetailRes .. "image_lock.png")
        else
          lock = 0
          image:setImage(DetailRes .. "image_unlock.png")
        end
        self.callback()
      end)
    end)
  end
end

function EquipDetailLayer:initPanel2(data)
  local color_nomal = UIHelper.hex2rgb("#6e6965")
  local color_special = UIHelper.hex2rgb("#057114")
  local yPos, interval = -2, 23
  for index, value in ipairs(data.baseValue:toTableArray()) do
    local level = self.equip:getAttrLevel(index, true)
    display.newSprite(CardRes .. (1 <= level and "base_on.png" or "base_off.png")):pos(0, yPos - 2):addTo(self.node1)
    display.newTTFLabel({
      text = string.format("%s+%d%s", AttrDesc[tonumber(value[1])], tonumber(value[2]), type == 6 and "%" or ""),
      size = 16,
      color = 1 <= level and color_special or color_nomal
    }):anch(0, 0.5):pos(10, yPos):addTo(self.node1)
    if 1 <= level then
      local descBg = display.newSprite(DetailRes .. "desc_bg_base.png"):pos(225, yPos):addTo(self.node1)
      local str = string.format("x%0.1f[Lv%s]", LevelCsv[level].strengthValue, tostring(level == 10 and "MAX" or level))
      display.newTTFLabel({
        text = str,
        size = 16,
        color = UIHelper.hex2rgb("#703802")
      }):anch(0, 0.5):pos(15, 9):addTo(descBg)
    end
    yPos = yPos - interval
  end
  yPos = -2
  if data.entryNum == 0 then
    display.newSprite(DetailRes .. "lock.png"):anch(0, 0.5):pos(0, -18):addTo(self.node2)
  else
    for index = 1, data.entryNum do
      local level = self.equip:getAttrLevel(index, false)
      display.newSprite(CardRes .. (1 <= level and "ex_on.png" or "ex_off.png")):pos(0, yPos - 2):addTo(self.node2)
      local attrId = self.equip.attrEx:getv(index, 0)
      if 0 < attrId and EntryCsv[attrId] then
        display.newTTFLabel({
          text = EntryCsv[attrId][string.format("star%ddesc", self.equip.star)] or "",
          size = 16,
          color = 1 <= level and color_special or color_nomal
        }):anch(0, 0.5):pos(10, yPos):addTo(self.node2)
        if 1 <= level then
          local descBg = display.newSprite(DetailRes .. "desc_bg_ex.png"):pos(225, yPos):addTo(self.node2)
          local str = string.format("x%0.1f[Lv%s]", LevelCsv[level].strengthValue, tostring(level == 10 and "MAX" or level))
          display.newTTFLabel({
            text = str,
            size = 16,
            color = UIHelper.hex2rgb("#703802")
          }):anch(0, 0.5):pos(15, 9):addTo(descBg)
        end
        yPos = yPos - interval
      end
    end
  end
  yPos, interval = 0, 20
  if 0 >= self.equip.suitId then
    display.newSprite(DetailRes .. "lock.png"):anch(0, 0.5):pos(0, -32):addTo(self.node3)
    self.suitTip:setString("该装备暂时没有装饰效果")
  else
    local list = ccui.ListView:create()
    list:size(cc.size(290, 96)):anch(0, 1):pos(-10, 9):addTo(self.node3)
    list:setInnerContainerSize(cc.size(290, 96))
    list:setBounceEnabled(true)
    local active, count = self:getSuitCount(self.equip.suitId)
    local suitData = SuitCsv[self.equip.suitId]
    local interval = 4
    local title = display.newTTFLabel({
      text = suitData.name .. string.format("（%d/3）", count),
      size = 16,
      color = UIHelper.hex2rgb("#b65c2c")
    })
    local labelHeight = title:getContentSize().height + interval
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(290, labelHeight)):addTo(list)
    title:anch(0, 0.5):pos(6, labelHeight / 2):addTo(viewNode)
    for slot = 1, 3 do
      local desc = suitData["desc" .. slot]
      if desc then
        local icon = display.newSprite(DetailRes .. "tag.png")
        local descLabel = MRichText.new({
          text = desc,
          size = 16,
          maxWidth = 275,
          color = active and color_special or color_nomal
        })
        local labelHeight = descLabel:getContentSize().height + interval
        local viewNode = ccui.Widget:create()
        viewNode:setContentSize(cc.size(290, labelHeight)):addTo(list)
        icon:anch(0, 1):pos(0, labelHeight - 8):addTo(viewNode)
        descLabel:anch(0, 0.5):pos(16, labelHeight / 2):addTo(viewNode)
      end
    end
    self.suitTip:setString(string.format("同时装备3件%s装备激活该效果", suitData.name))
  end
end

function EquipDetailLayer:getSuitCount(suitId)
  local masterId = self.equip.masterId
  local hero = 0 < masterId and game.role.heros[masterId] or nil
  local active = hero and hero:isSuitAcitve(true) or false
  local count = 0
  if hero then
    for slot = 1, 3 do
      local equipId = hero.equips:getv(slot, 0)
      if 0 < equipId then
        local equip = game.role.equips[equipId]
        if equip.suitId == suitId then
          count = count + 1
        end
      end
    end
  end
  return active, count
end

return EquipDetailLayer
