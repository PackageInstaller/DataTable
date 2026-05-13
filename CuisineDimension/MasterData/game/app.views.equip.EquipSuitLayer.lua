local EquipCsv = require("csvdata.equip")
local SuitCsv = require("csvdata.equip_suit")
local ReDefineCsv = require("csvdata.equip_refine")
local ItemCsv = require("csvdata.item")
local ReforgeCsv = require("csvdata.equip_reforge")
local DetailRes = "ui/equip/detail/"
local ForgeRes = "ui/equip/reforge/"
local FixRes = "ui/equip/fix/"
local globalRes = "ui/global/"
local UpRes = "ui/equip/up/"
local EquipRes = "ui/equip/card/"
local uiData = {
  csbFile = "ui/equip/EquipSuitLayer.csb",
  widgets = {
    rightPanel = "rightPanel",
    leftPanel = "leftPanel",
    angel1 = "angel1",
    angel2 = "angel2",
    buttom = "buttom",
    desc = "desc",
    suitNode = "rightPanel/suitNode",
    suitTitle = "rightPanel/suitNode/suitTitle",
    suitBg2 = "rightPanel/suitNode/suitBg2",
    forgeBtn = "rightPanel/forgeBtn",
    circle = "leftPanel/circle",
    itemNode = "leftPanel/itemNode",
    frame = "leftPanel/ren/frame",
    equipNode = "leftPanel/ren/equipNode",
    detailNode = "detailNode"
  }
}
local EquipSuitLayer = class("EquipSuitLayer", UIBase)

function EquipSuitLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function EquipSuitLayer:init(params)
  self.forgeBtn:setTouchScale()
  self.frame:runAction(cc.RepeatForever:create(cc.RotateBy:create(30, -360)))
  self.circle:runAction(cc.RepeatForever:create(cc.RotateBy:create(20, 360)))
  
  local function rule(equip)
    return self.equip and equip.id == self.equip.id
  end
  
  self.frame:setCallback(function()
    local layer = game:createView("equip.ChooseEquipLayer", {
      rule = rule,
      callback = function(choose)
        local equip = game.role.equips[choose]
        if equip then
          self.equip = equip
          self:showEquip()
          self:showData()
        end
      end
    })
    BackManager:push(function()
      layer:close()
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
    node = self.desc,
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

function EquipSuitLayer:showData()
  if not self.equip then
    self:showEmpty()
  else
    self:showSuitDetail()
  end
end

local btnNames = {"forgeBtn", "itemNode"}

function EquipSuitLayer:showEmpty()
  self.equipNode:removeAllChildren()
  display.newSprite(ForgeRes .. "add.png"):addTo(self.equipNode)
  display.newTTFLabel({
    text = "添加装备",
    size = 22,
    color = UIHelper.hex2rgb("#b4f730")
  }):pos(0, -55):addTo(self.equipNode)
  self.suitTitle:setString("暂无")
  local textBg = display.newSprite(ForgeRes .. "entry_attr_bg.png"):pos(207, 70):addTo(self.suitBg2)
  display.newTTFLabel({
    text = "请先添加装备",
    size = 20,
    color = UIHelper.hex2rgb("#bcaf97")
  }):center(textBg):addTo(textBg)
  for _, name in pairs(btnNames) do
    self[name]:hide()
  end
end

function EquipSuitLayer:showEquip(skip)
  self.equipNode:removeAllChildren()
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
    game:createView("equip.EquipDetailLayer", {
      scene = self.detailNode,
      equipId = self.equip.id,
      showHero = true,
      showBg = 1
    })
  end)
  if not skip then
    for _, name in pairs(btnNames) do
      self[name]:show()
    end
  end
end

function EquipSuitLayer:showSuitDetail()
  self.forgeBtn:show()
  self.suitBg2:removeAllChildren()
  if self.equip.suitId == 0 then
    self.suitTitle:setString("暂无装饰效果")
    display.newSprite(ForgeRes .. "unReforge.png"):pos(207, 65):addTo(self.suitBg2)
  else
    local suitData = SuitCsv[self.equip.suitId]
    self.suitTitle:setString(suitData.name)
    local xPos, yPos = 207, 113
    for index = 1, 3 do
      local desc = suitData["desc" .. index]
      if desc ~= "" then
        local image = index < 3 and "suit_attr_1.png" or "suit_attr_2.png"
        local dalte = index == 1 and 32 or 46
        local attrBg = display.newSprite(ForgeRes .. image):pos(xPos, yPos):addTo(self.suitBg2)
        MRichText.new({
          text = desc,
          size = 18,
          color = UIHelper.hex2rgb("#703802"),
          maxWidth = 380
        }):anch(0, 0.5):pos(15, attrBg:getContentSize().height / 2 + 2):addTo(attrBg)
        yPos = yPos - dalte
      end
    end
  end
  local defineData = ReDefineCsv[self.equip.csvData.profession]
  local cost = defineData.decorate_material:getv(self.equip.csvData.star, 0)
  self:showItem(cost)
  self.forgeBtn:setCallback(function()
    if not self.costEnough then
      SysError(SYS_ERR_EQUIP_FORGE_MATERIAL_NOT_ENOUGH)
      return
    end
    game:sendData(actionCodes.Equip_forgeEquipAttrsRpc, MsgPack.pack({
      type = 2,
      equipId = self.equip.id
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Equip_forgeEquipAttrsRpc, function(event)
      UIHelper.removeWaiting()
      game:playMusic(1004)
      local flash = UIHelper.loadAnimation(ForgeRes, "suit_flash", 24, 30)
      flash.sprite:scale(2):addTo(self.suitNode, 100)
      flash.sprite:setBlendFunc(cc.blendFunc(gl.ONE_MINUS_DST_COLOR, gl.ONE))
      flash.sprite:playAnimationOnce(flash.animation, true)
      flash.sprite:runAction(transition.sequence({
        cc.DelayTime:create(0.3),
        cc.CallFunc:create(function()
          self:showSuccess()
          self.equip = game.role.equips[self.equip.id]
          self:showSuitDetail()
          self:showEquip(true)
        end)
      }))
    end)
  end)
end

function EquipSuitLayer:showSuccess()
  local bg = display.newSprite(FixRes .. "success_bg.png"):pos(505, 300):addTo(self)
  display.newSprite(ForgeRes .. "success.png"):center(bg):addTo(bg)
  bg:setOpacity(0)
  bg:setCascadeOpacityEnabled(true)
  bg:runAction(transition.sequence({
    cc.Spawn:create(cc.MoveBy:create(0.2, cc.p(0, 25)), cc.FadeIn:create(0.2)),
    cc.DelayTime:create(0.5),
    cc.Spawn:create(cc.MoveBy:create(0.2, cc.p(0, 25)), cc.FadeOut:create(0.2)),
    cc.RemoveSelf:create()
  }))
end

function EquipSuitLayer:showItem(cost)
  self.itemNode:removeAllChildren()
  self.itemNode:show()
  local itemSet = ItemCsv[541]
  display.newSprite("ui/equip/fix/source_bg_2.png"):addTo(self.itemNode)
  display.newSprite(itemSet.icon):addTo(self.itemNode)
  local itemNum = game.role.items[541] or 0
  display.newTTFLabel({
    text = string.format("%d/%d", itemNum, cost),
    size = 28,
    color = UIHelper.hex2rgb(cost <= itemNum and "2dff7c" or "ff4b2d")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(0, -23):addTo(self.itemNode)
  self.costEnough = cost <= itemNum
end

return EquipSuitLayer
