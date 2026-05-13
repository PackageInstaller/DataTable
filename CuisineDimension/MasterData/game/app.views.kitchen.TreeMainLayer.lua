local TreeCsv = require("csvdata.tree")
local TreePointCsv = require("csvdata.treepoint")
local SSkillCsv = require("csvdata.skill_special")
local BSkillCsv = require("csvdata.skill_block")
local FormatCsv = require("csvdata.formation")
local MainRes = "ui/kitchen/tree/main/"
local TreeRes = "icon/tree/"
local CgRes = "icon/cg/"
local uiData = {
  csbFile = "ui/kitchen/TreeMainLayer.csb",
  widgets = {
    angel1 = "angel1",
    angel2 = "angel2",
    treeBg = "treeBg",
    cgNode = "treeBg/cgNode",
    levelDesc = "treeBg/levelDesc",
    origin = "treeBg/panel/origin",
    addBg = "treeBg/addBg",
    btnPackage = "treeBg/btnPackage",
    btnLeft = "treeBg/btnLeft",
    btnRight = "treeBg/btnRight",
    descBg = "treeBg/descBg"
  }
}
local type2name = {
  [1] = "hp",
  [2] = "atk",
  [3] = "def",
  [4] = "hit",
  [5] = "miss",
  [6] = "level",
  [7] = "attr",
  [8] = "cg",
  [9] = "",
  [10] = "",
  [11] = "",
  [12] = "format",
  [13] = ""
}
local limitTypeDesc = {
  [1] = "食灵等级达到",
  [2] = "食灵品阶达到"
}
local limitType = {
  [1] = "level",
  [2] = "quality"
}
local qualityDesc = {
  [0] = "白色",
  [1] = "绿色",
  [2] = "蓝色",
  [3] = "紫色",
  [4] = "金色",
  [5] = "彩色"
}
local TreeMainLayer = class("TreeMainLayer", UIBase)

function TreeMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function TreeMainLayer:init(params)
  self.parent = params.parent
  self.size = cc.size(940, 380)
  self.curPageNum = 0
  self.curPage = 0
  self.isMove = false
  self.btnLeft:setTouchScale()
  self.btnLeft:setCallback(function()
    if self.isMove then
      return
    end
    self:changePage(-1)
  end)
  self.btnRight:setTouchScale()
  self.btnRight:setCallback(function()
    if self.isMove then
      return
    end
    self:changePage(1)
  end)
  self.btnPackage:setTouchScale()
  self.btnPackage:setCallback(function()
    game:createView("kitchen.TreePackageLayer")
  end)
  local btnAdd = UIHelper.newImageView(MainRes .. "btn_add.png")
  btnAdd:pos(94, 83):addTo(self.addBg)
  btnAdd:setCallback(function()
    self:chooseHero()
  end)
  if UIHelper.isiPhoneX() then
    self.treeBg:setPositionX(self.treeBg:getPositionX() + UIHelper.getMoveXForX())
    self.angel2:setPositionX(self.angel2:getPositionX() + 200)
  end
  UIHelper.MoveToUp({
    node = self.angel1
  })
  UIHelper.MoveToUp({
    node = self.angel2
  })
  UIHelper.showPageGuide(10021)
end

function TreeMainLayer:showData(params)
  self.btnLeft:hide()
  self.btnRight:hide()
  self.levelDesc:setString("阶段")
  self.descBg:hide()
  local layout = ccui.Widget:create()
  layout:setContentSize(self.size)
  layout:setCascadeOpacityEnabled(true)
  layout:anch(0.5, 0.5):pos(0, 0):addTo(self.origin)
  local xPos, yPos = 130, 25
  for index = 1, 15 do
    local bg = display.newSprite(MainRes .. "circle_bg.png"):anch(0.5, 0):pos(xPos, yPos):addTo(layout)
    display.newSprite(MainRes .. "circle_normal.png"):pos(74, 45):addTo(bg)
    xPos = xPos + 170
    if index % 5 == 0 then
      xPos = 130
      yPos = yPos + 130
    end
  end
  self.curPage = layout
  UIHelper.MoveToLeft({node = layout, time = 0.15})
end

function TreeMainLayer:initCurPageTree(moveDir)
  self.descBg:show()
  self.descBg:removeAllChildren()
  local bLimit = false
  local str = string.format("阶段%d解锁条件:", self.curPageNum)
  for index, set in ipairs(TreeCsv[self.hero.type]["treeOpen" .. self.curPageNum]:toTableArray()) do
    local temp = "(已完成)"
    local color = "#1fd81f"
    local value = set[1] == "1" and set[2] or qualityDesc[tonumber(set[2])]
    if self.hero[limitType[tonumber(set[1])]] < tonumber(set[2]) then
      bLimit = true
      temp = "(未完成)"
      color = "#f55625"
    end
    str = str .. string.format("%d、%s<div size=14 color=%s>%s</div>  ", index, limitTypeDesc[tonumber(set[1])] .. value, color, temp)
  end
  MRichText.new({
    text = str,
    color = UIHelper.hex2rgb("#aca290"),
    size = 18
  }):anch(0, 0.5):pos(30, 20):addTo(self.descBg)
  local sortPoints = {}
  local links = {}
  for step, temp in ipairs(self.Csv[self.curPageNum]) do
    local curLevel = self.hero:getPointLevel(self.curPageNum, step)
    local pointData = temp[curLevel == 0 and #temp or curLevel]
    sortPoints[string.format("%d_%d", pointData.xPos, pointData.yPos)] = pointData
    for _, temp in pairs(pointData.pointFront:toArray("=", true)) do
      links[string.format("%d_%d", temp, pointData.id)] = true
    end
  end
  local dalteX = 0 < moveDir and -self.size.width or self.size.width
  if moveDir == 0 then
    self.curPage:removeFromParent()
    dalteX = 0
  end
  local layout = ccui.Widget:create()
  layout:setContentSize(self.size)
  layout:setCascadeOpacityEnabled(true)
  layout:anch(0.5, 0.5):pos(-dalteX, 0):addTo(self.origin)
  local xPos, yPos, x, y = 140, 78, 170, 130
  for _, data in pairs(sortPoints) do
    local node = display.newNode():pos(xPos + (data.xPos - 1) * x, yPos + (data.yPos - 1) * y):addTo(layout)
    node:setLocalZOrder(-data.xPos * data.yPos)
    local maxLevel = self.hero:checkPointMax(data.step, data.id)
    local types = data.pointType:toTableArray()
    local skillType, value = tonumber(types[1][1]), tonumber(types[1][2])
    local circle, lockImg
    if 9 <= skillType and skillType <= 11 or skillType == 13 then
      circle = UIHelper.newImageView(MainRes .. "skill_gray.png"):scale(0.93)
      UIHelper.getClipNode({
        steRes = "ui/kitchen/tree/main/skill_mask.png",
        clipRes = "icon/skill_special/104.png"
      }):center(circle):addTo(circle)
      display.newSprite(MainRes .. "skill_frame.png"):center(circle):addTo(circle)
      lockImg = "skill_lock.png"
    else
      local imgStr
      if skillType == 7 then
        imgStr = maxLevel and string.format("%s_done_%d.png", type2name[skillType], value) or string.format("%s_able_%d.png", type2name[skillType], value)
      else
        imgStr = maxLevel and string.format("%s_done.png", type2name[skillType]) or string.format("%s_able.png", type2name[skillType])
      end
      circle = UIHelper.newImageView(TreeRes .. imgStr)
      local label = display.newTTFLabel({
        text = "+" .. value,
        size = 24
      }):enableOutline(UIHelper.hex2rgb(maxLevel and "#6d1b0d" or "#51422f"), 1):anch(0.5, 0):pos(62, 20):addTo(circle)
      label:setVisible(skillType < 7)
      lockImg = "circle_lock.png"
    end
    circle:pos(xPos + (data.xPos - 1) * x, yPos + (data.yPos - 1) * y):addTo(layout)
    if not self:getFrontPointStatus(data) or bLimit then
      if skillType == 9 or skillType == 10 or skillType == 11 or skillType == 13 then
        display.newSprite(MainRes .. "skill_gray.png"):center(circle):addTo(circle)
      end
      display.newSprite(MainRes .. lockImg):center(circle):addTo(circle)
      if 5 < skillType then
        circle:setCallback(function()
          self:showInfo(types, circle, data, true)
        end)
      end
    elseif maxLevel then
      circle:setCallback(function()
        self:showInfo(types, circle, data)
      end)
    else
      circle:setCallback(function()
        game:createView("kitchen.TreeLightLayer", {
          curStep = self.curTreeStep,
          step = data.step,
          index = data.id,
          heroId = self.hero.id,
          parent = self.parent,
          callback = function(list, func)
            game:sendData(actionCodes.Hero_treeUpRpc, MsgPack.pack({
              heroId = self.hero.id,
              step = data.step,
              id = data.id,
              costHero = list
            }))
            UIHelper.showWaiting()
            game:addResponseHandler(actionCodes.Hero_treeUpRpc, function(event)
              UIHelper.removeWaiting()
              func()
              if skillType == 8 then
                self:showInfo(types, circle, data)
              end
              self.curTreeStep = self.hero:getTreeStep()
              self:changePage(0)
            end)
          end
        })
      end)
    end
    for i = 1, 4 do
      local tempData = sortPoints[string.format("%d_%d", data.xPos + i, data.yPos)]
      if tempData and links[string.format("%d_%d", data.id, tempData.id)] then
        local line = display.newScale9Sprite(MainRes .. (maxLevel and "line_green.png" or "line_gray.png"), nil, nil, cc.size(i * x, 30)):anch(0, 0.5):pos(0, 0):addTo(node)
        display.newSprite(MainRes .. (maxLevel and "line_green_arrow.png" or "line_gray_arrow.png")):center(line):addTo(line)
        break
      end
    end
    for i = 1, 2 do
      local tempData = sortPoints[string.format("%d_%d", data.xPos, data.yPos + i)]
      if tempData and links[string.format("%d_%d", data.id, tempData.id)] then
        local line = display.newScale9Sprite(MainRes .. (maxLevel and "line_green.png" or "line_gray.png"), nil, nil, cc.size(i * y, 30)):anch(0, 0.5):pos(0, 0):addTo(node)
        display.newSprite(MainRes .. (maxLevel and "line_green_arrow.png" or "line_gray_arrow.png")):center(line):addTo(line)
        line:setRotation(-90)
        break
      end
    end
    for i = 1, 2 do
      local tempData = sortPoints[string.format("%d_%d", data.xPos, data.yPos - i)]
      if tempData and links[string.format("%d_%d", data.id, tempData.id)] then
        local line = display.newScale9Sprite(MainRes .. (maxLevel and "line_green.png" or "line_gray.png"), nil, nil, cc.size(i * y, 30)):anch(0, 0.5):pos(0, 0):addTo(node)
        display.newSprite(MainRes .. (maxLevel and "line_green_arrow.png" or "line_gray_arrow.png")):center(line):addTo(line)
        line:setRotation(90)
        break
      end
    end
  end
  if moveDir == 0 then
    self.curPage = layout
    return
  end
  self.isMove = true
  self.curPage:runAction(transition.sequence({
    cc.MoveBy:create(0.2, cc.p(dalteX, 0)),
    cc.RemoveSelf:create()
  }))
  layout:runAction(transition.sequence({
    cc.MoveBy:create(0.2, cc.p(dalteX, 0)),
    cc.CallFunc:create(function()
      self.curPage = layout
      self.isMove = false
    end)
  }))
end

function TreeMainLayer:showInfo(types, node, data, preview)
  local worldPos = self:convertToWorldSpace({
    x = node:getPositionX(),
    y = node:getPositionY()
  })
  local cx, cy, width, height = display.cx, display.cy, display.width, display.height
  local isIphonex, dalteX = false, 0
  if UIHelper.isiPhoneX() then
    isIphonex = true
    local movex = UIHelper.getMoveXForX(true)
    cx, cy, width = cx + movex, cy, width + movex * 2
  end
  local mask = UIHelper.newMask({
    size = cc.size(width, height),
    color = "#000000",
    opacity = 0
  })
  mask:anch(0.5, 0.5):pos(cx, cy):addTo(display.getRunningScene(), 100)
  display.newSprite(imgPath):pos(width / 2, height / 2):addTo(mask)
  mask:setTouchEnabled(true)
  mask:setSwallowTouches(false)
  mask:setCallback(function()
    mask:removeSelf()
  end)
  local needShowAll = {
    [6] = 1,
    [7] = 1,
    [8] = 1,
    [9] = 1,
    [10] = 1,
    [11] = 1,
    [12] = 1,
    [13] = 1
  }
  local posy = {
    {cy},
    {
      cy + 63,
      cy - 63
    },
    {
      cy + 124,
      cy,
      cy - 124
    }
  }
  local isShowAll = true
  if #types > #posy + 1 then
    isShowAll = false
  else
    for _, attr in ipairs(types) do
      if not needShowAll[tonumber(attr[1])] then
        isShowAll = false
        break
      end
    end
  end
  
  local function showOne(indexType, y, value)
    local Anch = {0.5, 0.5}
    local tip
    if data.showDesc == 1 then
      tip = self:showTipInfo(data, true)
    elseif indexType == 7 or indexType == 6 then
      tip = self:showTipInfo(data, true)
    elseif indexType == 8 then
      tip = self:showCGImage(data, preview)
      if isIphonex and not preview then
        UIHelper.fitForiPhoneX(tip)
      end
    elseif indexType == 9 or indexType == 10 then
      tip = self:showSkillInfo(indexType, value)
    elseif indexType == 12 then
      tip = self:showFormatInfo(value)
    elseif indexType == 11 or indexType == 13 then
    else
      cx, y = worldPos.x + 38, worldPos.y + 155
      Anch = {0.5, 0}
      tip = self:showTipInfo(data)
      if isIphonex then
        dalteX = 120
      end
    end
    if tip then
      tip:anch(Anch[1], Anch[2]):pos(cx + dalteX, y):addTo(mask)
    end
  end
  
  if isShowAll then
    for index = #types, 1, -1 do
      if tonumber(types[index][1]) == 11 and data.showDesc ~= 1 then
        table.remove(types, index)
      end
    end
    for index, attr in ipairs(types) do
      showOne(tonumber(attr[1]), posy[#types][index], tonumber(attr[2]))
    end
  else
    showOne(tonumber(types[1][1]), posy[1][1], tonumber(types[1][2]))
  end
end

function TreeMainLayer:showCGImage(data, preview)
  if preview then
    return self:showTipInfo(data, true)
  else
    return display.newSprite(CgRes .. string.format("%d.png", self.hero.type))
  end
end

function TreeMainLayer:showSkillInfo(skillType, value)
  skillType, value = tonumber(skillType), tonumber(value)
  local levels = self.hero:getTotalAttrFactors()
  local skillCsv = skillType == 9 and SSkillCsv or BSkillCsv
  local level = skillType == 9 and levels.specialLv or levels.blockLv
  local skillData = skillCsv[value][level]
  local tip = display.newSprite(MainRes .. "tip_special_bg.png")
  local content = display.newSprite("ui/hero/detail/skill_bg.png"):pos(55, 60):addTo(tip)
  UIHelper.getClipNode({
    steRes = "ui/hero/detail/skill_mask.png",
    clipRes = skillData.icon
  }):scale(0.47):center(content):addTo(content)
  display.newTTFLabel({
    text = skillData.name,
    size = 12,
    color = UIHelper.hex2rgb("#0d92ae")
  }):anch(0, 0.5):pos(95, 102):addTo(tip)
  display.newSprite("ui/hero/detail/mask.png"):center(content):addTo(content)
  display.newTTFLabel({
    text = skillData.desc,
    size = 12,
    color = UIHelper.hex2rgb("#703803"),
    dimensions = cc.size(350, 60)
  }):anch(0, 1):pos(95, 90):addTo(tip)
  for index = 1, 5 do
    local image = level < index and "star1.png" or "star2.png"
    display.newSprite("ui/hero/detail/" .. image):pos(200 + (index - 1) * 15, 100):addTo(tip)
  end
  if skillType == 9 then
    local bg1 = display.newSprite("ui/hero/detail/func_bg_2.png"):pos(310, 105):addTo(tip)
    display.newTTFLabel({
      text = (skillData.coolDown or 0.3) .. "s",
      size = 20,
      color = UIHelper.hex2rgb("#703803")
    }):pos(54, 17):addTo(bg1)
    local bg2 = display.newSprite("ui/hero/detail/func_bg_1.png"):pos(405, 105):addTo(tip)
    display.newTTFLabel({
      text = "x" .. (skillData.manaCost or 3),
      size = 20,
      color = UIHelper.hex2rgb("#703803")
    }):pos(50, 17):addTo(bg2)
  end
  return tip
end

function TreeMainLayer:showFormatInfo(formatId)
  local formatData = FormatCsv[tonumber(formatId)][1]
  local tip = display.newSprite(MainRes .. "tip_special_bg.png")
  display.newSprite(MainRes .. "tip_special_line.png"):pos(125, 61):addTo(tip)
  display.newSprite(MainRes .. "tip_special_line.png"):pos(330, 61):addTo(tip)
  display.newTTFLabel({
    text = "装盘名称",
    size = 18,
    color = UIHelper.hex2rgb("#703803")
  }):anch(0.5, 0.5):pos(65, 100):addTo(tip)
  display.newTTFLabel({
    text = "装盘效果",
    size = 18,
    color = UIHelper.hex2rgb("#703803")
  }):anch(0.5, 0.5):pos(230, 100):addTo(tip)
  display.newTTFLabel({
    text = "激活条件",
    size = 18,
    color = UIHelper.hex2rgb("#703803")
  }):anch(0.5, 0.5):pos(391, 100):addTo(tip)
  MRichText.new({
    text = formatData.name,
    size = 18,
    color = UIHelper.hex2rgb("#ba6719"),
    maxWidth = 110
  }):anch(0.5, 0.5):pos(64, 57):addTo(tip)
  MRichText.new({
    text = formatData.desc,
    color = UIHelper.hex2rgb("#ba6719"),
    size = 18,
    maxWidth = 180
  }):anch(0.5, 1):pos(226, 85):addTo(tip)
  MRichText.new({
    text = formatData.conDesc,
    size = 18,
    color = UIHelper.hex2rgb("#ba6719"),
    maxWidth = 100
  }):anch(0.5, 1):pos(386, 85):addTo(tip)
  return tip
end

function TreeMainLayer:showTipInfo(data, big)
  if big then
    local tip = display.newSprite(MainRes .. "tip_special_bg.png")
    MRichText.new({
      text = data.desc,
      color = UIHelper.hex2rgb("#918374"),
      size = 16,
      maxWidth = 430
    }):anch(0.5, 0.5):pos(227, 61):addTo(tip)
    return tip
  end
  local tip = display.newSprite(MainRes .. "tip_normal_bg.png")
  local lab = display.newTTFLabel({
    text = data.desc,
    color = UIHelper.hex2rgb("#918374"),
    size = 18
  }):anch(0.5, 0.5):pos(61, 35):addTo(tip)
  UIHelper.setMaxWidth(lab, 118)
  return tip
end

function TreeMainLayer:getFrontPointStatus(data)
  if data.pointFront == "" and self.curTreeStep < data.step - 1 then
    return false
  end
  for _, temp in pairs(data.pointFront:toArray("=", true)) do
    if not self.hero:checkPointMax(data.step, temp) then
      return false
    end
  end
  return true
end

function TreeMainLayer:changePage(dalte)
  if self.curPageNum == 1 and dalte < 0 then
    return
  end
  if self.curPageNum == #self.Csv and 0 < dalte then
    return
  end
  self.btnLeft:removeAllChildren()
  self.btnRight:removeAllChildren()
  self.curPageNum = self.curPageNum + dalte
  self.levelDesc:setString("阶段" .. self.curPageNum)
  self.btnLeft:setVisible(self.curPageNum ~= 1)
  self.btnRight:setVisible(self.curPageNum ~= #self.Csv)
  self:initCurPageTree(dalte)
end

function TreeMainLayer:chooseHero()
  if self.isMove then
    return
  end
  
  local function rule(hero)
    if self.hero and self.hero.id == hero.id then
      return true
    end
    if not TreeCsv[hero.type] then
      return true
    end
    local curStep = hero:getTreeStep()
    if curStep ~= 0 and curStep == #TreePointCsv[hero.type] then
      return true
    end
  end
  
  local function rule1(hero)
    if self.hero and self.hero.id == hero.id then
      return true
    elseif not TreeCsv[hero.type] then
      return true
    end
    return false
  end
  
  local layer = game:createView("hero.ChooseHeroLayer", {
    rule = rule,
    rule1 = rule1,
    tree = true,
    type = 8,
    callback = function(choose)
      local hero = game.role.heros[choose]
      self.btnLeft:show()
      self.btnRight:show()
      self.hero = hero
      self.Csv = TreePointCsv[self.hero.type]
      self.addBg:removeAllChildren()
      local bg = UIHelper.newImageView(MainRes .. "btn_add.png")
      bg:pos(92, 83):addTo(self.addBg)
      bg:setLocalZOrder(-1)
      UIHelper.getClipNode({
        steRes = "ui/global/mask_2.png",
        clipRes = UIHelper.getCardRes("book", self.hero.type, nil, self.hero.quality)
      }):center(bg):addTo(bg)
      bg:setCallback(function()
        self:chooseHero()
      end)
      self.cgNode:removeAllChildren()
      UIHelper.getClipNode({
        steRes = MainRes .. "cg_mask.png",
        clipRes = CgRes .. string.format("%d.png", self.hero.type)
      }):anch(0.5, 0.5):pos(0, 0):addTo(self.cgNode)
      display.newSprite(MainRes .. "cg_gray.png"):anch(0.5, 0.5):pos(0, 0):addTo(self.cgNode)
      self.curTreeStep = self.hero:getTreeStep()
      self.curPageNum = math.min(self.curTreeStep + 1, #self.Csv)
      self:changePage(0)
    end
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(TopBarType.full, "食灵")
  end)
end

return TreeMainLayer
