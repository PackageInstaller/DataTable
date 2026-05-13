MTipType = {
  skill = 1,
  item = 2,
  talent = 3,
  manster = 4,
  halo = 5,
  path = 6,
  acc = 7,
  hero = 8
}
local MTip = {}
local GlobalRes = "ui/global/"
local EntryCsv = require("csvdata.diner_entry")

function MTip:show(params)
  self.type = params.type
  self.labels = {}
  self:initElements(params)
  local types = {
    [MTipType.skill] = handler(self, self.showSkillTip),
    [MTipType.item] = handler(self, self.showItemTip),
    [MTipType.talent] = handler(self, self.showTalentTip),
    [MTipType.manster] = handler(self, self.showMansterTip),
    [MTipType.halo] = handler(self, self.showHaloTip),
    [MTipType.path] = handler(self, self.showPathTip),
    [MTipType.acc] = handler(self, self.showAccTip),
    [MTipType.hero] = handler(self, self.showHeroTip)
  }
  if types[self.type] then
    types[self.type](params)
  end
  self:fixPosition(params)
end

function MTip:initElements(params)
  local bgColor = params.bgColor or cc.c3b(255, 255, 255)
  local opacity = params.opacity or 0
  if self.layer and not tolua.isnull(self.layer) then
    self.layer:removeFromParent()
    self.layer = nil
  end
  self.layer = UIHelper.extend(ccui.Layout:create())
  local width = display.width
  if UIHelper.isiPhoneX() then
    width = width + UIHelper.getMoveXForX() * 2
  end
  self.layer:size(width, display.height)
  self.layer:setBackGroundColor(bgColor)
  self.layer:setBackGroundColorType(1)
  self.layer:setBackGroundColorOpacity(opacity)
  self.layer:setCallback(function(sender)
    if self.layer and not tolua.isnull(self.layer) then
      self.layer:removeFromParent()
      self.layer = nil
    end
  end)
  self.layer:setSwallowTouches(false)
  self.defaultSize = cc.size(310, 80)
  if self.type == MTipType.acc then
    self.defaultSize.width = 400
  end
  self.realSize = nil
  self.bg = display.newScale9Sprite(GlobalRes .. "tip_bg.png", 0, 0, self.defaultSize, cc.rect(20, 20, 1, 1))
  self.bg:anch(0, 1):pos(0, 0):addTo(self.layer)
  self.arrow = display.newSprite(GlobalRes .. "tip_arrow.png")
  self.arrow:anch(0.5, 0.5):pos(0, 0):addTo(self.layer)
  self.layer:addTo(display.getRunningScene(), POPUP_LAYER_ORDER)
  self.layer:name("mtip")
end

function MTip:fixPosition(params)
  local node = params.node
  local nodeSize = node:getContentSize()
  local nodePos = node:convertToWorldSpace(cc.p(0, 0))
  local scaleY = node:getScaleY()
  local scaleX = node:getScaleX()
  local arrowSize = self.arrow:getContentSize()
  local realSize = self:getRealSize()
  nodeSize.height = nodeSize.height * scaleY / 1
  nodeSize.width = nodeSize.width * scaleX / 1
  local xpos, ypos = 0, 0
  local xSpace, ySpace = 30, 30
  local x, y = 0, 0
  local maxW, maxH = display.width, display.height
  if UIHelper.isiPhoneX() then
    maxW = maxW + UIHelper.getMoveXForX() * 2
  end
  y = nodePos.y + nodeSize.height + realSize.height + arrowSize.height
  if maxH < y then
    ypos = nodePos.y - arrowSize.height + 10 + (params.fixOffset or 0)
    x = nodePos.x - nodeSize.width + realSize.width + xSpace
    if maxW >= x then
      xpos = nodePos.x - nodeSize.width / 2
    else
      xpos = maxW - realSize.width - xSpace
    end
    if xpos < 0 then
      xpos = xSpace
    end
    self.arrow:anch(0.5, 1):flipY(true):pos(nodePos.x + nodeSize.width / 2, ypos + self.arrow:getContentSize().height - 2)
  else
    ypos = nodePos.y + nodeSize.height + arrowSize.height + realSize.height - 10 - (params.fixOffset or 0)
    x = nodePos.x - nodeSize.width / 2 + realSize.width + xSpace
    if maxW >= x then
      xpos = nodePos.x - nodeSize.width / 2
    else
      xpos = maxW - realSize.width - xSpace
    end
    if xpos < 0 then
      xpos = xSpace
    end
    self.arrow:anch(0.5, 1):flipY(false):pos(nodePos.x + nodeSize.width / 2, ypos - realSize.height + 2)
  end
  self.bg:pos(xpos, ypos)
  if realSize.height > self.defaultSize.height then
    self.bg:size(realSize)
    local yPos, yOffset = 10, 0
    for index, node in ipairs(self.labels) do
      node:setPositionY(realSize.height - yPos - yOffset)
      yOffset = yOffset + node:getContentSize().height
    end
  end
end

function MTip:addLabel(label)
  local size = label:getContentSize()
  local lableSize = label:getContentSize()
  local xPos, yPos = 10, 10
  local yOffset = 0
  for _, node in pairs(self.labels) do
    yOffset = yOffset + node:getContentSize().height
  end
  yPos = yPos + yOffset
  yPos = self:getRealSize().height - yPos
  local height = yOffset + lableSize.height + 10
  if height > self.defaultSize.height then
    self.realSize = cc.size(self.defaultSize.width, height + 15)
  end
  label:anch(0, 1):pos(xPos, yPos):addTo(self.bg)
  table.insert(self.labels, label)
end

function MTip:getRealSize()
  return self.realSize or self.defaultSize
end

function MTip:showSkillTip(params)
  local skillData = params.skillType == "block" and blockCCsv[params.skillId] or blockSCsv[params.skillId]
  local extraInfo = params.skillType == "block" and breakCsv[params.breakLevel] or starCsv[params.star]
  local name = string.format("<div color=fffc00 size=22>%s</div> <div color=0bff3f size=22>Lv%d</div>%s", skillData.name, extraInfo.skillLevel, extraInfo.desc)
  local title = MRichText.new({
    text = name,
    size = 18,
    color = UIHelper.hex2rgb("#b6e7ff"),
    maxWidth = 450
  })
  local desc = MRichText.new({
    text = " \n" .. skillCsv[params.skillId][extraInfo.skillLevel].desc,
    size = 17,
    maxWidth = 440,
    color = UIHelper.hex2rgb("#b6e7ff")
  })
  self:addLabel(title)
  self:addLabel(desc)
end

function MTip:showItemTip(params)
  local name = params.itemData.name
  if params.equipId then
    local equip = game.role.equips[params.equipId]
    name = equip:getSuitName() .. name
  end
  local nameLabel = display.newTTFLabel({
    text = name,
    size = 20,
    color = UIHelper.hex2rgb("#f6bf02")
  })
  local desc = MRichText.new({
    text = params.itemData.desc,
    size = 18,
    maxWidth = 280
  })
  self:addLabel(nameLabel)
  self:addLabel(desc)
end

function MTip:showTalentTip(params)
  local title = display.newTTFLabel({
    text = params.talentData.name .. "  Lv" .. params.talentData.level,
    size = 23,
    color = UIHelper.hex2rgb("#d5d5d5")
  })
  local desc = MRichText.new({
    text = params.talentData.descri,
    size = 20,
    color = UIHelper.hex2rgb("#d0c29a"),
    maxWidth = 440
  })
  self:addLabel(title)
  self:addLabel(desc)
end

function MTip:showMansterTip(params)
  local title = display.newTTFLabel({
    text = params.itemData.name,
    size = 20,
    color = UIHelper.hex2rgb("#f6bf02")
  })
  local desc = MRichText.new({
    text = params.itemData.desc,
    size = 20,
    maxWidth = 280
  })
  self:addLabel(title)
  self:addLabel(desc)
end

function MTip:showHaloTip(params)
  local title = MRichText.new({
    text = params.talentData.name,
    size = 22,
    color = UIHelper.hex2rgb("#fffc00"),
    maxWidth = 450
  })
  local desc = MRichText.new({
    text = " \n" .. params.talentData.descri,
    size = 18,
    maxWidth = 440,
    color = UIHelper.hex2rgb("#b6e7ff")
  })
  self:addLabel(title)
  self:addLabel(desc)
end

function MTip:showPathTip(params)
  local nameLabel = display.newTTFLabel({
    text = params.itemData.name,
    size = 20,
    color = UIHelper.hex2rgb("#f6bf02")
  })
  local desc = MRichText.new({
    text = params.itemData.path,
    size = 18,
    maxWidth = 280
  })
  self:addLabel(nameLabel)
  self:addLabel(desc)
end

function MTip:showAccTip(params)
  local access = params.access or {}
  display.newTTFLabel({
    text = params.itemData.name,
    size = 20,
    color = UIHelper.hex2rgb("#f6bf02")
  }):anch(0, 1):pos(20, 70):addTo(self.bg)
  local texts = {
    "基础属性:",
    "额外属性:"
  }
  local attrs = {"baseAttr", "extraAttr"}
  local yPos = 38
  for i, text in ipairs(texts) do
    display.newTTFLabel({text = text, size = 18}):anch(0, 0.5):pos(20, yPos):addTo(self.bg)
    if access[attrs[i]] and access[attrs[i]] ~= "" then
      local id, value = access[attrs[i]]:match("(%d+)=(%d+%.?%d*)")
      local entry = EntryCsv[tonumber(id)]
      local label
      if i == 1 then
        local num = globalCsv.dinnerEntryStrengthRange:getv(access.level, 1)
        local str = string.format("%0.1f", tonumber(value) * num)
        label = display.newTTFLabel({
          text = string.format(entry.desc, str),
          size = 18
        }):anch(0, 0.5):pos(100, yPos):addTo(self.bg)
      else
        label = display.newTTFLabel({
          text = string.format(entry.desc, value),
          size = 18
        }):anch(0, 0.5):pos(100, yPos):addTo(self.bg)
      end
      if label:getContentSize().width > 290 then
        label:setScaleX(290 / label:getContentSize().width)
      end
    else
      display.newTTFLabel({text = "无属性", size = 18}):anch(0, 0.5):pos(100, yPos):addTo(self.bg)
    end
    yPos = yPos - 20
  end
end

function MTip:showHeroTip(params)
  local title = display.newTTFLabel({
    text = params.itemData.name,
    size = 20,
    color = UIHelper.hex2rgb("#f6bf02")
  })
  local desc = MRichText.new({
    text = params.itemData.desc,
    size = 20,
    maxWidth = 280
  })
  self:addLabel(title)
  self:addLabel(desc)
end

function MTip:close()
  if self.layer and not tolua.isnull(self.layer) then
    self.layer:removeFromParent()
    self.layer = nil
  end
end

return MTip
