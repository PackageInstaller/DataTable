local EquipCsv = require("csvdata.equip")
local EntryCsv = require("csvdata.equip_entry")
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
  csbFile = "ui/equip/EquipEntryLayer.csb",
  widgets = {
    rightPanel = "rightPanel",
    leftPanel = "leftPanel",
    angel1 = "angel1",
    angel2 = "angel2",
    buttom = "buttom",
    desc = "desc",
    entryNode = "rightPanel/entryNode",
    beforeNode = "rightPanel/entryNode/beforeNode",
    afterNode = "rightPanel/entryNode/afterNode",
    limitBg = "rightPanel/entryNode/limitBg",
    mainBg3 = "rightPanel/mainBg3",
    cancelBtn = "rightPanel/cancelBtn",
    okBtn = "rightPanel/okBtn",
    forgeBtn = "rightPanel/forgeBtn",
    washBtn = "rightPanel/washBtn",
    circle = "leftPanel/circle",
    itemNode = "leftPanel/itemNode",
    frame = "leftPanel/ren/frame",
    equipNode = "leftPanel/ren/equipNode",
    detailNode = "detailNode"
  }
}
local EquipEntryLayer = class("EquipEntryLayer", UIBase)

function EquipEntryLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function EquipEntryLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.buttom, true)
    self.rightPanel:setPositionX(self.rightPanel:getPositionX() + 200)
    self.angel2:setPositionX(self.angel2:getPositionX() + 185)
  end
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setTouchScale()
  btnInfo:pos(480, 300):addTo(self.mainBg3)
  btnInfo:setImages(ForgeRes, {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:setCallback(function()
    game:createView("equip.EquipShowInfoLayer")
  end)
  self.cancelBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#630c07"), 1)
  self.okBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#630c07"), 1)
  self.frame:runAction(cc.RepeatForever:create(cc.RotateBy:create(30, -360)))
  self.circle:runAction(cc.RepeatForever:create(cc.RotateBy:create(20, 360)))
  self.desc:hide()
  local names = {
    "cancelBtn",
    "okBtn",
    "forgeBtn",
    "washBtn"
  }
  for _, name in pairs(names) do
    self[name]:setTouchScale()
  end
  
  local function rule(equip)
    return self.equip and equip.id == self.equip.id
  end
  
  self.frame:setCallback(function()
    local layer = game:createView("equip.ChooseEquipLayer", {
      rule = rule,
      type = 2,
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
      TopBar:show(TopBarType.full, "装备")
      layer:close()
    end)
  end)
  self.washBtn:setCallback(function()
    local layer = game:createView("equip.EquipWashLayer", {
      equipId = self.equip.id
    })
    BackManager:push(function()
      if not tolua.isnull(layer) then
        layer:close()
      end
      self.washBtn:hide()
      local temp = self.tempIndex
      self:showEntryDetail(nil, temp)
      self.tempIndex = nil
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
  local guideLayer = display.getRunningScene():getChildByTag(NEW_GUIDE_LAYER_TAG)
  if guideLayer then
    self.guideStep = guideLayer.guideStep
  end
end

function EquipEntryLayer:showData()
  if not self.equip then
    self:showEmpty()
  else
    self.washBtn:hide()
    self:showEntryDetail()
  end
end

local btnNames = {
  "cancelBtn",
  "okBtn",
  "forgeBtn",
  "itemNode",
  "limitBg",
  "washBtn"
}

function EquipEntryLayer:showEmpty()
  self.equipNode:removeAllChildren()
  self.entryNode:show()
  display.newSprite(ForgeRes .. "add.png"):addTo(self.equipNode)
  display.newTTFLabel({
    text = "添加装备",
    size = 22,
    color = UIHelper.hex2rgb("#b4f730")
  }):pos(0, -55):addTo(self.equipNode)
  display.newSprite(ForgeRes .. "unReforge.png"):addTo(self.afterNode)
  local textBg = display.newSprite(ForgeRes .. "entry_attr_bg.png"):addTo(self.beforeNode)
  display.newTTFLabel({
    text = "请先添加装备",
    size = 20,
    color = UIHelper.hex2rgb("#bcaf97")
  }):center(textBg):addTo(textBg)
  for _, name in pairs(btnNames) do
    self[name]:hide()
  end
end

function EquipEntryLayer:showEquip(skip)
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
  if not skip then
    for _, name in pairs(btnNames) do
      self[name]:show()
    end
  end
end

function EquipEntryLayer:showEntryDetail(newAttrId, attrSlot)
  self.beforeNode:removeAllChildren()
  self.afterNode:removeAllChildren()
  if self.equip.csvData.entryNum <= 0 or self.equip.attrEx == "" then
    self.okBtn:hide()
    self.cancelBtn:hide()
    self.forgeBtn:hide()
    self.limitBg:show()
    self.limitBg:removeAllChildren()
    local desc = ""
    if self.equip.csvData.entryNum <= 0 then
      desc = string.format("%d星装备不能改造", 2)
    else
      desc = "暂时没有改造次数"
    end
    display.newTTFLabel({
      text = desc,
      size = 18,
      color = UIHelper.hex2rgb("#703802")
    }):pos(self.limitBg:getContentSize().width / 2, self.limitBg:getContentSize().height / 2 + 2):addTo(self.limitBg)
    display.newSprite(DetailRes .. "lock.png"):addTo(self.beforeNode)
    display.newSprite(DetailRes .. "lock.png"):addTo(self.afterNode)
    self:showItem(0)
    return
  end
  attrSlot = attrSlot or 1
  local attrs = self.equip.attrEx:toNumMap()
  local num = table.nums(attrs)
  local group = MRadioGroup:create()
  local yPos, interval = (num - 1) / 2 * 90, 90
  for index = 1, 2 do
    local attrId = attrs[index]
    if attrId then
      local btn = UIHelper.extend(ccui.Button:create())
      btn:setImages(ForgeRes, {
        "btn_attr_a.png",
        "btn_attr_b.png"
      })
      btn:pos(0, yPos - (index - 1) * interval):addTo(self.beforeNode)
      btn:setName("attr" .. index)
      btn:setGroup(group)
      if not newAttrId then
        btn:setCallback(function()
          attrSlot = index
          group:chooseByName("attr" .. index)
        end)
      end
      MRichText.new({
        text = EntryCsv[attrId][string.format("star%ddesc", self.equip.star)] or "",
        size = 18,
        color = UIHelper.hex2rgb("#703802"),
        maxWidth = 146
      }):anch(0.5, 0.5):pos(105, 35):addTo(btn)
    end
  end
  group:chooseByName("attr" .. attrSlot)
  if newAttrId then
    for index = 1, 2 do
      local attrId = index == attrSlot and newAttrId or attrs[index]
      if attrId then
        local attrBg = display.newSprite(ForgeRes .. "entry_attr_bg.png"):pos(0, yPos - (index - 1) * interval):addTo(self.afterNode)
        local color = index == attrSlot and "#457f0c" or "#703802"
        MRichText.new({
          text = EntryCsv[attrId][string.format("star%ddesc", self.equip.star)] or "",
          size = 18,
          color = UIHelper.hex2rgb(color),
          maxWidth = 146
        }):anch(0.5, 0.5):center(attrBg):addTo(attrBg)
      end
    end
    self.okBtn:show()
    self.cancelBtn:show()
    self.forgeBtn:hide()
    self.itemNode:hide()
    self.cancelBtn:setCallback(function()
      self:showEntryDetail(nil, attrSlot)
    end)
    self.okBtn:setCallback(function()
      game:sendData(actionCodes.Equip_replaceEquipAttrRpc, MsgPack.pack({
        equipId = self.equip.id
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Equip_replaceEquipAttrRpc, function(event)
        UIHelper.removeWaiting()
        self:showSuccess()
        self:showEntryDetail(nil, attrSlot)
        if self.guideStep and self.guideStep == 10009 then
          NewGuideLayer.new({
            step = 10009,
            majorGuideStep = 10009,
            minorGuideStep = 13,
            callback = function()
              game:enterScene("MainScene", {guideId = 10009, minorStep = 14})
            end
          })
        end
      end)
    end)
    self.limitBg:hide()
  else
    self.okBtn:hide()
    self.cancelBtn:hide()
    display.newSprite(ForgeRes .. "unReforge.png"):addTo(self.afterNode)
    local defineData = ReDefineCsv[self.equip.csvData.profession]
    local cost = defineData.refine_material:getv(self.equip.csvData.star, 0)
    if self.equip.washCount == 0 and self.equip.csvData.entryNum > 0 then
      self.tempIndex = attrSlot
      self.washBtn:show()
      self.forgeBtn:hide()
      cost = 0
    else
      self.forgeBtn:show()
    end
    self:showItem(cost)
    self.limitBg:show()
    self.limitBg:removeAllChildren()
    display.newTTFLabel({
      text = "剩余改造次数：" .. self.equip.washCount,
      size = 18,
      color = UIHelper.hex2rgb("#703802")
    }):pos(self.limitBg:getContentSize().width / 2, self.limitBg:getContentSize().height / 2 + 2):addTo(self.limitBg)
  end
  self.forgeBtn:setCallback(function()
    if self.equip.washCount < 1 then
      SysError(SYS_ERR_EQUIP_WASHCOUNT_NOT_ENOUGH)
      return
    end
    if not self.costEnough then
      SysError(SYS_ERR_EQUIP_FORGE_MATERIAL_NOT_ENOUGH)
      return
    end
    game:sendData(actionCodes.Equip_forgeEquipAttrsRpc, MsgPack.pack({
      type = 1,
      index = attrSlot,
      equipId = self.equip.id
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Equip_forgeEquipAttrsRpc, function(event)
      UIHelper.removeWaiting()
      self.forgeBtn:hide()
      local flash = UIHelper.loadAnimation(ForgeRes, "suit_flash", 24, 30)
      flash.sprite:scale(2.2):pos(0, 26):addTo(self.entryNode, 100)
      flash.sprite:setBlendFunc(cc.blendFunc(gl.ONE_MINUS_DST_COLOR, gl.ONE))
      flash.sprite:playAnimationOnce(flash.animation, true)
      flash.sprite:runAction(transition.sequence({
        cc.DelayTime:create(0.3),
        cc.CallFunc:create(function()
          if self.guideStep and self.guideStep == 10009 then
            NewGuideLayer.new({
              step = 10009,
              majorGuideStep = 10009,
              minorGuideStep = 12
            })
          end
          local msg = MsgPack.unpack(event.data)
          game:playMusic(1002)
          self:showEntryDetail(msg.attrId, attrSlot)
        end)
      }))
    end)
  end)
end

function EquipEntryLayer:showSuccess()
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

function EquipEntryLayer:showItem(cost)
  self.itemNode:removeAllChildren()
  self.itemNode:show()
  local itemSet = ItemCsv[501]
  display.newSprite("ui/equip/fix/source_bg_2.png"):addTo(self.itemNode)
  display.newSprite(itemSet.icon):addTo(self.itemNode)
  local itemNum = game.role.items[501] or 0
  display.newTTFLabel({
    text = string.format("%d/%d", itemNum, cost),
    size = 28,
    color = UIHelper.hex2rgb(cost <= itemNum and "2dff7c" or "ff4b2d")
  }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(0, -23):addTo(self.itemNode)
  self.costEnough = cost <= itemNum
end

return EquipEntryLayer
