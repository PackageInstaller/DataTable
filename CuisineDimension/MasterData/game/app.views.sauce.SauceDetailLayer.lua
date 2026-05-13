local SkillPassiveCsv = require("csvdata.skill_passive")
local ItemCsv = require("csvdata.item")
local DetailRes = "ui/sauce/detail/"
local uiData = {
  csbFile = "ui/sauce/SauceDetailLayer.csb",
  widgets = {
    mainBg1 = "mainBg1",
    mainBg2 = "mainBg2",
    descBg = "descBg",
    btnCancel = "mainBg2/btnCancel",
    btnOk = "mainBg2/btnOk",
    panel1 = "panel1",
    iconNode = "panel1/iconNode",
    nameNode = "panel1/nameNode",
    countNode = "panel1/countNode",
    levelNode = "panel1/levelNode",
    list = "panel2/list"
  }
}
local SauceDetailLayer = class("SauceDetailLayer", UIBase)

function SauceDetailLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function SauceDetailLayer:init(params)
  self.wear = params.wear or false
  self.showHero = params.showHero or false
  self.skipTitle = params.skipTitle or false
  self.showFrame = params.showFrame or false
  self.ignore = params.ignore or false
  self.hideLock = params.hideLock or false
  self.callback = params.callback or function()
  end
  local showBg = params.showBg or false
  if showBg then
    self["mainBg" .. showBg % 2 + 1]:hide()
  else
    self.mainBg1:hide()
    self.mainBg2:hide()
    self.list:setPositionY(self.list:getPositionY() - 3)
  end
  self.descBg:setVisible(self.showFrame)
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

function SauceDetailLayer:showData(params)
  local sauceId = params.sauceId
  if not sauceId or sauceId == 0 then
    self.panel1:setTexture(DetailRes .. "bg_title.png")
    MRichText.new({
      text = "选用合适的酱料，可以从食灵那里得到更多的爱哦~             —— 薇琪",
      size = 16,
      color = UIHelper.hex2rgb("#8a6b6b"),
      maxWidth = 280
    }):anch(0, 0.5):pos(-25, 0):addTo(self.iconNode)
    local hights, content = {
      26,
      137,
      26,
      137
    }, {
      "酱料祝福技",
      "",
      "酱料调制技",
      ""
    }
    for idx, hight in ipairs(hights) do
      local viewNode = ccui.Widget:create()
      viewNode:setContentSize(cc.size(330, hight)):addTo(self.list)
      if idx % 2 == 1 then
        local bg = display.newSprite(DetailRes .. "desc_bg.png"):center(viewNode):addTo(viewNode)
        display.newTTFLabel({
          text = content[idx],
          size = 18,
          color = UIHelper.hex2rgb("#703802")
        }):anch(0, 0.5):pos(7, 12):addTo(bg)
      else
        display.newSprite(DetailRes .. "lock.png"):center(viewNode):addTo(viewNode)
      end
    end
  else
    self.sauce = params.sauce or game.role.sauces[params.sauceId]
    if not self.skipTitle then
      self:initPanel1()
    end
    self:initPanel2()
    if self.ignore then
      self:showMasterHero()
    end
  end
end

function SauceDetailLayer:initPanel1()
  local icon = SauceIcon.new({
    id = self.sauce.id,
    showHero = self.showHero
  }):addTo(self.iconNode)
  display.newTTFLabel({
    text = self.sauce:getName(),
    size = 26,
    color = UIHelper.hex2rgb("#df410a")
  }):anch(0, 0.5):pos(5, 0):addTo(self.nameNode)
  if self.wear then
    display.newSprite("ui/equip/wear/take_on.png"):scale(0.68):pos(46, 45):addTo(icon)
  end
  local xPos = 5
  for index = 1, 6 do
    local image = index <= self.sauce.advanceL and "green.png" or "grey.png"
    display.newSprite(DetailRes .. image):anch(0, 0.5):pos(xPos, 8):addTo(self.levelNode)
    xPos = xPos + 20
  end
  display.newSprite(DetailRes .. "image_line.png"):anch(0, 0.5):pos(5, 28):addTo(self.countNode)
  local xPos = 75
  if self.sauce.csvData.type == "" then
    display.newTTFLabel({
      text = "强化材料，不可穿戴",
      size = 18,
      color = UIHelper.hex2rgb("#df410a")
    }):anch(0, 0.5):pos(xPos - 45, 0):addTo(self.countNode)
  elseif self.sauce.csvData.type == "9999" then
    display.newTTFLabel({
      text = "特殊通用酱料",
      size = 18,
      color = UIHelper.hex2rgb("#df410a")
    }):anch(0, 0.5):pos(xPos - 45, 0):addTo(self.countNode)
  else
    for _, heroType in ipairs(self.sauce.csvData.type:toArray("=", true)) do
      UIHelper.getClipNode({
        steRes = "ui/global/mask_2.png",
        clipRes = UIHelper.getCardRes("book", heroType)
      }):scale(0.36):pos(xPos, 0):addTo(self.countNode)
      local headIcon = UIHelper.newImageView(DetailRes .. "hero_circle.png"):scale(0.78):pos(xPos + 1, 0):addTo(self.countNode)
      headIcon:setCallback(function()
        itemType = heroType + 1000
        MTip:show({
          type = MTipType.hero,
          node = headIcon,
          itemType = itemType,
          itemData = ItemCsv[itemType]
        })
      end)
      xPos = xPos + 45
    end
    display.newSprite(DetailRes .. "image_desc.png"):anch(0, 0.5):pos(2, 0):addTo(self.countNode)
  end
  if not self.hideLock then
    local lock = self.sauce.lock or 0
    local image = UIHelper.newImageView("ui/equip/detail/image_unlock.png"):pos(260, 40):addTo(self.iconNode)
    if lock == 1 then
      image:setImage("ui/equip/detail/image_lock.png")
    end
    image:setCallback(function()
      game:sendData(actionCodes.Sauce_changeLockStatusRpc, MsgPack.pack({
        id = self.sauce.id
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Sauce_changeLockStatusRpc, function(event)
        UIHelper.removeWaiting()
        if lock == 0 then
          lock = 1
          image:setImage("ui/equip/detail/image_lock.png")
        else
          lock = 0
          image:setImage("ui/equip/detail/image_unlock.png")
        end
        self.callback()
      end)
    end)
  end
end

function SauceDetailLayer:initPanel2()
  local BreakBuffIdx = {
    "speciallv",
    "blocklv",
    "damageup",
    "shieldup",
    "damage1",
    "shield1",
    "damage2",
    "shield2",
    "damage3",
    "shield3",
    "extradamageup",
    "extrashieldup"
  }
  local BreakBuffKV = {
    speciallv = "料理技等级+%d",
    blocklv = "固有技等级+%d",
    damageup = "造成的全伤害提高%0.1f%%",
    shieldup = "受到的全伤害降低%0.1f%%",
    damage1 = "对魔法属性敌人造成的伤害提高%0.1f%%",
    shield1 = "受到魔法属性敌人的伤害降低%0.1f%%",
    damage2 = "对物理属性敌人造成的伤害提高%0.1f%%",
    shield2 = "受到物理属性敌人的伤害降低%0.1f%%",
    damage3 = "对异能属性敌人造成的伤害提高%0.1f%%",
    shield3 = "受到异能属性敌人的伤害降低%0.1f%%",
    extradamageup = "满级时 造成的全伤害额外增加%0.1f%%",
    extrashieldup = "满级时 受到的全伤害额外降低%0.1f%%"
  }
  local AdvanceBuffKV = {
    [1] = "生命+%d",
    [2] = "攻击+%d",
    [3] = "防御+%d",
    [4] = "命中+%d",
    [5] = "闪避+%d",
    [6] = "暴击+%d",
    [7] = "暴伤+%d",
    [8] = "攻速+%d",
    [9] = "料理技等级+%d",
    [10] = "固有技等级+%d",
    [11] = "造成的全伤害提高%d%%",
    [12] = "受到的全伤害降低%d%%"
  }
  local BreakResult, AdvanceResult = {}, {}
  
  local function getHight(index)
    local sum = 1
    if index == 2 then
      BreakResult = self.sauce:getAllBreakBuff()
      for _, Type in ipairs({
        "unlock",
        "lock",
        "extra"
      }) do
        for key, value in pairs(BreakResult[Type] or {}) do
          local lab = display.newTTFLabel({
            text = string.format(BreakBuffKV[key], math.abs(value)),
            size = 16,
            dimensions = cc.size(290, 0)
          })
          sum = sum + lab:getContentSize().height
        end
      end
    else
      AdvanceResult = self.sauce:getAllAdvanceBuff()
      for _, Type in ipairs({"unlock", "lock"}) do
        for key, value in pairs(AdvanceResult[Type] or {}) do
          if AdvanceBuffKV[key] then
            local lab = display.newTTFLabel({
              text = string.format(AdvanceBuffKV[key], math.abs(value)),
              size = 16,
              dimensions = cc.size(290, 0)
            })
            sum = sum + lab:getContentSize().height
          elseif SkillPassiveCsv[key].name ~= "" then
            local lab = display.newTTFLabel({
              text = SkillPassiveCsv[key].name,
              size = 16,
              dimensions = cc.size(290, 0)
            })
            sum = sum + lab:getContentSize().height
          end
        end
      end
    end
    return sum
  end
  
  local heights, content = {
    26,
    0,
    26,
    0
  }, {
    "酱料祝福技",
    "",
    "酱料调制技",
    ""
  }
  for idx, height in ipairs(heights) do
    local tempH = height ~= 0 and height or getHight(idx)
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(330, tempH)):addTo(self.list)
    if idx % 2 == 1 then
      local bg = display.newSprite(DetailRes .. "desc_bg.png"):center(viewNode):addTo(viewNode)
      display.newTTFLabel({
        text = content[idx],
        size = 18,
        color = UIHelper.hex2rgb("#703802")
      }):anch(0, 0.5):pos(7, 12):addTo(bg)
    elseif idx == 2 then
      for _, Type in ipairs({
        "unlock",
        "lock",
        "extra"
      }) do
        local temp = BreakResult[Type] or {}
        for _, buffKey in ipairs(BreakBuffIdx) do
          if temp[buffKey] then
            local lab = display.newTTFLabel({
              text = string.format(BreakBuffKV[buffKey], math.abs(temp[buffKey])),
              size = 16,
              color = UIHelper.hex2rgb(not self.ignore and Type == "unlock" and "#057114" or "#6e6965"),
              dimensions = cc.size(290, 0)
            })
            lab:anch(0, 1):pos(23, tempH):addTo(viewNode)
            display.newSprite(DetailRes .. (not self.ignore and Type == "unlock" and "tag_green.png" or "tag_gray.png")):pos(16, tempH - 9):addTo(viewNode)
            tempH = tempH - lab:getContentSize().height
          end
        end
      end
    else
      for _, Type in ipairs({"unlock", "lock"}) do
        local temp = AdvanceResult[Type] or {}
        for buffType = 1, #AdvanceBuffKV do
          if temp[buffType] then
            local lab = display.newTTFLabel({
              text = string.format(AdvanceBuffKV[buffType], math.abs(temp[buffType])),
              size = 16,
              color = UIHelper.hex2rgb(not self.ignore and Type == "unlock" and "#057114" or "#6e6965"),
              dimensions = cc.size(290, 0)
            })
            lab:anch(0, 1):pos(23, tempH):addTo(viewNode)
            display.newSprite(DetailRes .. (not self.ignore and Type == "unlock" and "tag_green.png" or "tag_gray.png")):pos(16, tempH - 9):addTo(viewNode)
            tempH = tempH - lab:getContentSize().height
          end
        end
        for key, value in pairs(temp) do
          if 30000 < key and SkillPassiveCsv[key].name ~= "" then
            local lab = display.newTTFLabel({
              text = SkillPassiveCsv[key].name,
              size = 16,
              dimensions = cc.size(290, 0),
              color = UIHelper.hex2rgb(not self.ignore and Type == "unlock" and "#057114" or "#6e6965")
            })
            lab:anch(0, 1):pos(23, tempH):addTo(viewNode)
            display.newSprite(DetailRes .. (not self.ignore and Type == "unlock" and "tag_green.png" or "tag_gray.png")):pos(16, tempH - 9):addTo(viewNode)
            tempH = tempH - lab:getContentSize().height
          end
        end
      end
    end
  end
end

function SauceDetailLayer:showMasterHero()
  local viewNode = ccui.Widget:create()
  viewNode:setContentSize(cc.size(330, 26)):addTo(self.list)
  local bg = display.newSprite(DetailRes .. "desc_bg.png"):center(viewNode):addTo(viewNode)
  if self.sauce.csvData.id >= 100 and self.sauce.csvData.id <= 108 then
    local descString = ""
    if self.sauce.csvData.id == 100 or self.sauce.csvData.id == 101 then
      descString = "强化材料，不可穿戴"
    elseif self.sauce.csvData.type == "9999" then
      descString = "所有食灵均可触发调制技"
    end
    display.newTTFLabel({
      text = descString,
      size = 18,
      color = UIHelper.hex2rgb("#703802")
    }):anch(0, 0.5):pos(7, 12):addTo(bg)
    return
  end
  display.newTTFLabel({
    text = "专属食灵",
    size = 18,
    color = UIHelper.hex2rgb("#703802")
  }):anch(0, 0.5):pos(7, 12):addTo(bg)
  viewNode = ccui.Widget:create()
  viewNode:setContentSize(cc.size(330, 86)):addTo(self.list)
  local xPos = 45
  for _, heroType in ipairs(self.sauce.csvData.type:toArray("=", true)) do
    HeroHead.new({type = heroType, showTip = true}):scale(0.8):pos(xPos, 45):addTo(viewNode)
    xPos = xPos + 80
  end
end

return SauceDetailLayer
