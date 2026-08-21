local rougeBattleCsv = require("csvdata.rouge.rouge_battle")
local unitCsv = require("csvdata.unit")
local itemCsv = require("csvdata.item")
local RouGeMainRes = "ui/rouge/main/"
local uiData = {
  csbFile = "ui/rouge/RouGeShowBossLayer.csb",
  mask = true,
  popup = true,
  maskClick = true,
  widgets = {
    infoBg = "infoBg",
    okBtn = "infoBg/okBtn"
  }
}
local RouGeShowBossLayer = class("RouGeShowBossLayer", UIBase)

function RouGeShowBossLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function RouGeShowBossLayer:init(params)
  game:playMusic(1022)
  local level = params.level
  display.newTTFLabel({
    text = level .. "层",
    size = 16,
    color = UIHelper.hex2rgb("#e6c971")
  }):pos(568, 305):addTo(self.infoBg)
  display.newTTFLabel({
    text = "关卡怪物",
    size = 22,
    color = UIHelper.hex2rgb("#ffffff")
  }):pos(568, 280):addTo(self.infoBg)
  local text = "<div color=#c2c2c2>小提示：拥有 </div><img src='ui/rouge/main/boss_tip.png' scale=0.5 /><div color=#c2c2c2>的为领袖敌人,通关后选项中有概率出现游戏中的资源道具哦！</div>"
  local richText = MRichText.new({text = text, size = 12}):anch(0.5, 0.5):pos(568, -84):addTo(self.infoBg)
  local mapList = rougeBattleCsv[level]
  local num = #mapList or 1
  local xPos, interval = (num - 1) / 2 * -165, 165
  for index = 1, num do
    self:createBossCell(mapList[index]):pos(xPos + (index - 1) * interval + 568, 131):addTo(self.infoBg)
  end
  self.okBtn:setCallback(function()
    self:close()
  end)
end

function RouGeShowBossLayer:createBossCell(data, pos)
  local unitData = unitCsv[data.unitType]
  if not unitData then
    return
  end
  local bg = display.newSprite(RouGeMainRes .. "showboss_bg.png")
  
  local function showDesc()
    local descbg = UIHelper.newImageView(RouGeMainRes .. "showboss_label_bg.png"):center(bg):addTo(bg)
    descbg:setCallback(function()
      descbg:removeSelf()
    end)
    local size = cc.size(110, 90)
    local list = ccui.ListView:create():size(size)
    list:setInnerContainerSize(size)
    list:setClippingEnabled(true)
    list:anch(0, 0):pos(25, 42):addTo(descbg)
    local viewNode = ccui.Widget:create()
    local label = MRichText.new({
      text = data.bossDesc,
      color = UIHelper.hex2rgb("#cccccc"),
      size = 13,
      maxWidth = 110
    })
    label:pos(0, label:getContentSize().height):addTo(viewNode)
    viewNode:setContentSize(label:getContentSize()):addTo(list)
    print(label:getPositionX(), label:getPositionY(), label:getContentSize().width, label:getContentSize().height)
    list:requestDoLayout()
  end
  
  local boneRes = unitData.boneRes
  local spine = UIHelper.createSpineNodeByRes(boneRes)
  spine:setAnimation(0, "idle", true)
  spine:pos(80, 58):scale(1, 1):addTo(bg)
  local nameLabel = display.newTTFLabel({
    text = unitData.name,
    size = 14,
    color = UIHelper.hex2rgb("#a6a6a6")
  }):pos(74, 47):addTo(bg)
  local size = nameLabel:getContentSize()
  local lookBtn = UIHelper.newImageView(RouGeMainRes .. "look.png"):pos(74 + size.width / 2 + 10, 47):addTo(bg)
  lookBtn:setCallback(function()
    showDesc()
  end)
  if 0 < data.condition then
    local itemDada = itemCsv[data.condition]
    display.newSprite(RouGeMainRes .. "boss_tip.png"):pos(80, 10):addTo(bg)
    display.newSprite(itemDada.icon):pos(135, 211):scale(0.2):addTo(bg)
  end
  return bg
end

return RouGeShowBossLayer
