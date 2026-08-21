local AwakenCsv = require("csvdata.awaken")
local awakeSkillCsv = require("csvdata.skill_awake")
local specialCsv = require("csvdata.skill_special")
local blockCsv = require("csvdata.skill_block")
local detailRes = "ui/hero/detail/"
local awakeRes = "ui/hero/awake/"
local qulaityRes = "ui/kitchen/quality/"
local uiData = {
  csbFile = "ui/sauce/AwakeDetailLayer.csb",
  widgets = {
    mainBg1 = "mainBg1",
    descBg = "descBg",
    panel1 = "panel1",
    nameNode = "panel1/nameNode",
    leftNode = "panel1/leftNode",
    rightNode = "panel1/rightNode",
    list = "panel2/list",
    addNode = "descBg/addNode"
  }
}
local AwakeDetailLayer = class("AwakeDetailLayer", UIBase)

function AwakeDetailLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function AwakeDetailLayer:init(params)
  self.type = params.type
  self.data = params.data
  self.hero = params.hero
  self.awakeCallback = params.callback
  self.chooseList = {}
  self.chooseAlready = {}
  self.chooseNum = {}
  self.needNum = {}
  self.addImages = {}
  self.addTexts = {}
end

function AwakeDetailLayer:showData(params)
  self:showAttrs()
  self:showAdd()
end

function AwakeDetailLayer:showAdd()
  local posX = -166
  local costNum = {}
  self.costHeros = {}
  local heroList
  for index, item in pairs(self.data.cost:toArray()) do
    self.chooseAlready[index] = false
    self.chooseList[index] = {}
    self.chooseNum[index] = 0
    local itemData = item:toArray("=", true)
    heroList = {}
    costNum[index] = 0
    for idx, heroData in pairs(game.role.heros) do
      if self.hero.unit.profession == heroData.unit.profession and self.hero.id ~= idx then
        if itemData[1] == 0 and itemData[2] == heroData.unit.star and itemData[3] == heroData.awake then
          table.insert(heroList, idx, heroData)
          costNum[index] = costNum[index] + 1
        elseif itemData[1] == 1 and self.hero.type == heroData.type and itemData[3] == heroData.awake then
          table.insert(heroList, idx, heroData)
          costNum[index] = costNum[index] + 1
        end
      elseif heroData.type == 97 and index ~= 3 then
        table.insert(heroList, idx, heroData)
        costNum[index] = costNum[index] + 1
      end
    end
    table.insert(self.costHeros, index, heroList)
    local bg = display.newNode():pos(posX, -8):addTo(self.addNode)
    local addBg
    if index == 1 then
      addBg = HeroHead.new({
        heroId = self.hero.id,
        level = 0,
        quality = 0
      }):pos(58, 75):addTo(bg)
    else
      addBg = UIHelper.newImageView(awakeRes .. self.hero.unit.profession .. ".png"):pos(58, 75):addTo(bg)
      local awakeStar = itemData[2]
      if 0 < awakeStar then
        local xInterval = 14
        local xBegin = addBg:getContentSize().width / 2 - (awakeStar - 1) * xInterval / 2
        for index = 1, awakeStar do
          UIHelper.newImageView("ui/global/small_star.png"):pos(xBegin + (index - 1) * xInterval, 11):addTo(addBg)
        end
      end
      local awakeLogoPath = CommonHelper.getAwakeNoTypePath(1, self.hero.type, itemData[3], itemData[2])
      if awakeLogoPath and itemData[3] and 0 < itemData[3] then
        display.newSprite(string.format("ui/hero/awake/awake%d.png", awakeLogoPath)):pos(25, 70):addTo(addBg)
      end
    end
    local addImagePath = self.hero.awake >= self.type and awakeRes .. "add_mask.png" or awakeRes .. "btn_add.png"
    local addImage = UIHelper.newImageView(addImagePath):pos(90, 107):addTo(bg)
    local countTxt = display.newTTFLabel({
      text = string.format("%d/%d", self.chooseNum[index], itemData[4]),
      size = 22,
      color = UIHelper.hex2rgb("#703902")
    }):enableOutline(UIHelper.hex2rgb("#ffffff"), 1):pos(58, 0):addTo(bg)
    if self.hero.awake >= self.type then
      countTxt:hide()
    else
      countTxt:show()
    end
    self.addImages[index] = addImage
    self.needNum[index] = itemData[4] or 0
    self.addTexts[index] = countTxt
    addBg:setCallback(function()
      if self.hero.awake < self.type then
        self:chooseAdd(index, costNum[index], itemData[4])
      end
      self:updateImage()
    end)
    posX = posX + 110
  end
  local awakeBtn = UIHelper.newImageView(awakeRes .. "btn.png"):scale(0.8):pos(0, -75):addTo(self.addNode)
  awakeBtn:setCallback(function()
    if self.hero.awake < self.type then
      for _, data in pairs(self.chooseAlready) do
        if not data then
          SysError(SYS_ERR_SHOP_ACTIVITY_SCORE_NOT_ENOUGH)
          return
        end
        if not self.chooseList then
          SysError(SYS_ERR_SHOP_ACTIVITY_SCORE_NOT_ENOUGH)
          return
        end
        local awakeData = AwakenCsv[self.hero.type][self.type]
        if not AwakenCsv[self.hero.type] or not AwakenCsv[self.hero.type][self.type] then
          SysError(SYS_ERR_HERO_AWAKE_NOT_OPEN)
          return
        end
      end
      game:sendData(actionCodes.Hero_awakeUpRpc, MsgPack.pack({
        cost = self.chooseList,
        id = self.hero.id
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Hero_awakeUpRpc, function(event)
        self.awakeCallback(true)
        UIHelper.removeWaiting()
        SysError(SYS_ERR_HERO_AWAKE_SUCCESS)
      end)
    else
      SysError(SYS_ERR_HERO_AWAKE_STAGE_SUCCESS)
      return
    end
  end)
end

function AwakeDetailLayer:updateImage()
  for index, image in pairs(self.addImages) do
    if self.chooseAlready[index] then
      image:setImage(awakeRes .. "add_mask.png")
    end
  end
  for index, txt in pairs(self.addTexts) do
    local context = string.format("%d/%d", self.chooseNum[index], self.needNum[index])
    txt:setString(context)
  end
end

function AwakeDetailLayer:chooseAdd(index, costNum, needNum)
  local multiChoose = false
  if 1 < needNum then
    multiChoose = true
  end
  local tempChoose = {
    [1] = {},
    [2] = {},
    [3] = {}
  }
  for idx, heroData in pairs(self.costHeros[index]) do
    for chooseIdx, inData in pairs(self.chooseList) do
      for _, data in pairs(inData) do
        if idx == data then
          table.insert(tempChoose[chooseIdx], idx, idx)
        end
      end
    end
  end
  local layer = game:createView("hero.ChooseAwakeHeroLayer", {
    needNum = needNum,
    stage = index,
    multiChoose = multiChoose,
    type = index,
    heros = self.costHeros[index],
    tempChoose = tempChoose,
    callback = function(choose, sendChoose)
      local function judgeHero(hero)
        if hero then
          local state = hero:getState()
          
          if state[1] then
            SysError(SYS_ERR_HERO_LOCKED_CURE_QUAILTY_UP)
            return true
          end
          if state[2] then
            SysError(SYS_ERR_HERO_LOCKED_FIGHT_QUAILTY_UP)
            return true
          end
          if state[3] then
            SysError(SYS_ERR_HERO_LOCKED_CONSIGATION_QUAILTY_UP)
            return true
          end
        end
      end
      
      local chooseType = type(choose)
      if chooseType == "number" then
        if choose == 0 then
          self.chooseNum[index] = 0
          choose = nil
        else
          local hero = game.role.heros[choose]
          judgeHero(hero)
          self.chooseAlready[index] = true
          self.chooseNum[index] = 1
          if self.chooseList[index] then
            self.chooseList[index] = {}
          end
          table.insert(self.chooseList[index], choose)
        end
      elseif choose then
        local countHero = 0
        for heroId, value in pairs(choose) do
          if value then
            countHero = countHero + 1
            if sendChoose then
              table.insert(self.chooseList[index], heroId)
              local hero = game.role.heros[heroId]
              judgeHero(hero)
              if countHero == table.nums(choose) then
                self.chooseAlready[index] = true
              end
            end
          end
        end
        self.chooseNum[index] = countHero
      end
      self:updateImage()
      return false
    end
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(TopBarType.full, "食灵资料")
  end)
end

function AwakeDetailLayer:showAttrs()
  self.leftNode:removeAllChildren()
  self.rightNode:removeAllChildren()
  display.newTTFLabel({
    text = "觉醒提升",
    size = 22,
    color = UIHelper.hex2rgb("#703902")
  }):center(self.nameNode):addTo(self.nameNode)
  local awakeLogoPath = CommonHelper.getAwakeNoTypePath(2, self.hero.type, self.type - 1, self.hero.unit.star)
  if awakeLogoPath then
    display.newSprite(string.format(awakeRes .. "awake%d.png", awakeLogoPath)):pos(-85, -47):addTo(self.nameNode)
    for i = 1, 4 do
      display.newSprite(qulaityRes .. "arrow.png"):pos(-60 + (i - 1) * 6, -47):addTo(self.nameNode)
    end
    display.newSprite(string.format(awakeRes .. "awake%d.png", awakeLogoPath + 1 > 4 and 4 or awakeLogoPath + 1)):pos(-10, -47):addTo(self.nameNode)
  end
  for index, data in pairs(AwakenCsv) do
    if self.hero.type == index then
      open = true
      awakeData = data
    end
  end
  local totalAttr = self.data.type:toNumMap()
  local totalAttrLast
  if self.type > 1 then
    for index, data in pairs(AwakenCsv) do
      if self.hero.type == index then
        for i, attrData in pairs(data) do
          if i == self.type - 1 then
            totalAttrLast = attrData.type:toNumMap()
          end
        end
      end
    end
  end
  local baseAttr = self.hero:getBaseAttrValues()
  for index = 1, 5 do
    local name = AttsEnumEx[index]
    local attrBg = display.newNode():anch(0, 0.5):pos(-100, 15 + (index - 1) * -21):addTo(self.leftNode)
    display.newSprite(detailRes .. name .. ".png"):pos(20, 10):addTo(attrBg)
    display.newTTFLabel({
      text = AttrDesc[index] .. ":",
      size = 18,
      color = UIHelper.hex2rgb("#703902")
    }):anch(0, 0.5):pos(30, 10):addTo(attrBg)
    local value = ROUND[index] and math.ceil(baseAttr[name]) or math.floor(baseAttr[name])
    if totalAttrLast and totalAttrLast[index] then
      value = value + totalAttrLast[index]
    end
    display.newTTFLabel({
      text = value,
      size = 18,
      color = UIHelper.hex2rgb("#703902")
    }):anch(0, 0.5):pos(90, 10):addTo(attrBg)
    local add = totalAttr[index]
    if add then
      for index = 1, 4 do
        display.newSprite(qulaityRes .. "arrow.png"):anch(0, 0.5):pos(133 + (index - 1) * 6, 11):addTo(attrBg)
      end
      display.newTTFLabel({
        text = string.format("       %.01f", add + value),
        size = 18,
        color = UIHelper.hex2rgb("#228801")
      }):anch(0, 0.5):pos(130, 11):addTo(attrBg)
    end
  end
  local skillNum = 0
  local levels = self.hero:getTotalAttrFactors()
  local specialId = self.hero:getSpecialId()
  local blockId = self.hero:getBlockId()
  local awakeId = self.hero:getAwakeIdShow()
  for k, skillAdd in pairs(totalAttr) do
    if k == 6 and specialId ~= 0 or k == 7 and blockId ~= 0 or k == 8 then
      skillNum = skillNum + 1
    end
  end
  if specialId ~= 0 and totalAttr[6] then
    local level = levels.specialLv
    local specialData = specialCsv[specialId][level]
    display.newTTFLabel({
      text = string.format("%dLv      %dLv", level, 6 < level + totalAttr[7] and 6 or level + totalAttr[7]),
      size = 16,
      color = UIHelper.hex2rgb("#703902")
    }):anch(0, 0.5):pos(-6, 40):addTo(self.rightNode)
    for index = 1, 4 do
      display.newSprite(qulaityRes .. "arrow.png"):anch(0, 0.5):pos(19 + (index - 1) * 6, 40):addTo(self.rightNode)
    end
    local txt = display.newTTFLabel({
      text = "料理技",
      size = 18,
      color = UIHelper.hex2rgb("#703902")
    }):anch(0, 0.5):pos(-55, 0):addTo(self.rightNode)
    UIHelper.getClipNode({
      steRes = detailRes .. "skill_mask.png",
      clipRes = specialData.icon
    }):scale(0.47):anch(0, 0.5):pos(24, 50):addTo(txt)
    display.newSprite(detailRes .. "mask.png"):anch(0, 0.5):pos(-4, 50):addTo(txt)
  end
  if blockId ~= 0 and totalAttr[7] then
    local level = levels.blockLv
    local blockData = blockCsv[blockId][level]
    display.newTTFLabel({
      text = string.format("%dLv      %dLv", level, 6 < level + totalAttr[7] and 6 or level + totalAttr[7]),
      size = 16,
      color = UIHelper.hex2rgb("#703902")
    }):anch(0, 0.5):pos(-6, 40 - 80 * (skillNum - 1)):addTo(self.rightNode)
    for index = 1, 4 do
      display.newSprite(qulaityRes .. "arrow.png"):anch(0, 0.5):pos(19 + (index - 1) * 6, 40 - 80 * (skillNum - 1)):addTo(self.rightNode)
    end
    local txt = display.newTTFLabel({
      text = "固有技",
      size = 18,
      color = UIHelper.hex2rgb("#703902")
    }):anch(0, 0.5):pos(-55, 0 - 80 * (skillNum - 1)):addTo(self.rightNode)
    UIHelper.getClipNode({
      steRes = detailRes .. "skill_mask.png",
      clipRes = blockData.icon
    }):scale(0.47):anch(0, 0.5):pos(24, 50):addTo(txt)
    display.newSprite(detailRes .. "mask.png"):anch(0, 0.5):pos(-4, 50):addTo(txt)
  end
  if totalAttr[8] then
    local level = 1
    local awakeData = awakeSkillCsv[awakeId][level]
    for index = 1, 4 do
      display.newSprite(qulaityRes .. "arrow.png"):anch(0, 0.5):pos(20 + (index - 1) * 6, -5):addTo(self.rightNode)
    end
    local txt = display.newTTFLabel({
      text = "解锁觉醒技",
      size = 18,
      color = UIHelper.hex2rgb("#703902")
    }):anch(0, 0.5):pos(-40, -45):addTo(self.rightNode)
    UIHelper.getClipNode({
      steRes = detailRes .. "skill_mask.png",
      clipRes = awakeData.icon
    }):scale(0.47):anch(0, 0.5):pos(24, 50):addTo(txt)
    display.newSprite(detailRes .. "mask.png"):anch(0, 0.5):pos(-4, 50):addTo(txt)
  end
end

return AwakeDetailLayer
