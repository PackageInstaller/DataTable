local CURRENT_MODULE = (...)
local dotindex = string.find(CURRENT_MODULE, "%.%w+$")
local currentpath = string.sub(CURRENT_MODULE, 1, dotindex - 1)
local parserpath = string.format("%s.labelparser", currentpath, label)
local labelparser = require(parserpath)
local RichLabel = class("RichLabel", function()
  return display.newNode()
end)
RichLabel._default = nil
RichLabel._maxWidth = nil
RichLabel._currentWidth = nil
RichLabel._currentHeight = nil
RichLabel._containerNode = nil
RichLabel._allnodelist = nil
RichLabel._currentText = nil
RichLabel._parsedtable = nil
RichLabel._alllines = nil
RichLabel._animationCounter = nil
local shared_parserlist = {}
local ANIM_WORD_PER_SEC = 15
local DEBUG_MARK = "richlabel.debug.drawnodes"

function RichLabel:ctor(params)
  params = params or {}
  local fontName = params.font or display.DEFAULT_TTF_FONT
  local fontSize = params.size or params.fontSize or display.DEFAULT_TTF_FONT_SIZE
  local fontColor = params.color or params.fontColor or display.COLOR_WHITE
  local maxWidth = params.maxWidth or 0
  local linespace = params.lineSpace or 0
  local charspace = params.charSpace or 0
  local containerNode = cc.Node:create()
  self:addChild(containerNode)
  self._maxWidth = maxWidth
  self._containerNode = containerNode
  self._animationCounter = 0
  self._default = {}
  self._default.font = fontName
  self._default.size = fontSize
  self._default.color = fontColor
  self._default.lineSpace = linespace
  self._default.charSpace = charspace
  self:setAnchorPoint(cc.p(0, 1))
  self:setCascadeOpacityEnabled(true)
  self:setCascadeColorEnabled(true)
  containerNode:setCascadeOpacityEnabled(true)
  containerNode:setCascadeColorEnabled(true)
  if params.text then
    self:setString(params.text)
  end
end

function RichLabel:setString(text)
  text = text or ""
  if self._currentText == text then
    return
  end
  if self._currentText then
    self._allnodelist = nil
    self._parsedtable = nil
    self._alllines = nil
    self._containerNode:removeAllChildren()
  end
  self._currentText = text
  local parsedtable = labelparser.parse(text)
  self._parsedtable = parsedtable
  if parsedtable == nil then
    return self:printf("parser text error")
  end
  local containerNode = self._containerNode
  local allnodelist = self:charsToNodes_(parsedtable, containerNode)
  if not allnodelist then
    return
  end
  self._allnodelist = allnodelist
  self:layout()
end

function RichLabel:getString()
  return self._currentText
end

function RichLabel:setMaxWidth(maxwidth)
  self._maxWidth = maxwidth
  self:layout()
end

function RichLabel:setAnchorPoint(anchor, anchor_y)
  if type(anchor) == "number" then
    anchor = cc.p(anchor, anchor_y)
  end
  local super_setAnchorPoint = getmetatable(self).setAnchorPoint
  if super_setAnchorPoint then
    super_setAnchorPoint(self, anchor)
  end
  if self._currentText then
    self:layout()
  end
end

function RichLabel:getSize()
  return cc.size(self._currentWidth, self._currentHeight)
end

function RichLabel:getLineHeight(rowindex)
  local line = self._alllines[rowindex]
  if not line then
    return 0
  end
  local maxheight = 0
  for _, node in pairs(line) do
    local box = node:getBoundingBox()
    if maxheight < box.height then
      maxheight = box.height
    end
  end
  return maxheight
end

function RichLabel:getElementWithIndex(index)
  return self._allnodelist[index]
end

function RichLabel:getElementWithRowCol(rowindex, colindex)
  local line = self._alllines[rowindex]
  if line then
    return line[colindex]
  end
end

function RichLabel:getElementsWithLetter(letter)
  local nodelist = {}
  for _, node in pairs(self._allnodelist) do
    if node.getString then
      local str = node:getString()
      if str == letter then
        table.insert(nodelist, node)
      end
    end
  end
  return nodelist
end

function RichLabel:getElementsWithGroup(groupIndex)
  return self._parsedtable[groupIndex].nodelist
end

function RichLabel:walkElements(callback)
  assert(callback)
  for index, node in pairs(self._allnodelist) do
    if callback(node, index) ~= nil then
      return
    end
  end
end

function RichLabel:walkLineElements(callback)
  assert(callback)
  for rowindex, line in pairs(self._alllines) do
    for colindex, node in pairs(line) do
      if callback(node, rowindex, colindex) ~= nil then
        return
      end
    end
  end
end

function RichLabel:playAnimation(wordpersec, callback, cpCallback)
  wordpersec = wordpersec or ANIM_WORD_PER_SEC
  if self:isAnimationPlaying() then
    return
  end
  local counter = 0
  
  local function animationCreator(node, rowindex, colindex)
    counter = counter + 1
    return cc.Sequence:create(cc.DelayTime:create(counter / wordpersec), cc.CallFunc:create(function()
      if callback then
        callback(node, rowindex, colindex)
      end
    end), cc.FadeIn:create(0.2), cc.CallFunc:create(function()
      self._animationCounter = self._animationCounter - 1
      if self._animationCounter <= 0 and cpCallback then
        cpCallback()
      end
    end))
  end
  
  self:walkLineElements(function(node, rowindex, colindex)
    self._animationCounter = self._animationCounter + 1
    node:setOpacity(0)
    node:runAction(animationCreator(node, rowindex, colindex))
  end)
end

function RichLabel:isAnimationPlaying()
  return self._animationCounter > 0
end

function RichLabel:stopAnimation()
  self._animationCounter = 0
  self:walkElements(function(node, index)
    node:setOpacity(255)
    node:stopAllActions()
  end)
end

function RichLabel:layout()
  local parsedtable = self._parsedtable
  local basepos = cc.p(0, 0)
  local col_idx = 0
  local row_idx = 0
  local containerNode = self._containerNode
  local allnodelist = self._allnodelist
  local linespace = self._default.lineSpace
  local charspace = self._default.charSpace
  local maxwidth = 0
  local maxheight = 0
  local alllines = self:adjustLineBreak_(allnodelist, charspace)
  self._alllines = alllines
  for index, line in pairs(alllines) do
    local linewidth, lineheight = self:layoutLine_(basepos, line, 1, charspace)
    local offset = lineheight + linespace
    basepos.y = basepos.y - offset
    maxheight = maxheight + offset
    if maxwidth < linewidth then
      maxwidth = linewidth
    end
  end
  maxheight = maxheight - linespace
  self._currentWidth = maxwidth
  self._currentHeight = maxheight
  local anchor = self:getAnchorPoint()
  local origin_x, origin_y = 0, maxheight
  local result_x = origin_x - anchor.x * maxwidth
  local result_y = origin_y - anchor.y * maxheight
  containerNode:setPosition(result_x, result_y)
end

function RichLabel:debugDraw(level)
  level = level or 2
  local containerNode = self._containerNode
  local debugdrawnodes1 = cc.utils:findChildren(containerNode, DEBUG_MARK)
  local debugdrawnodes2 = cc.utils:findChildren(self, DEBUG_MARK)
  
  function table_insertto(dest, src, begin)
    if begin <= 0 then
      begin = #dest + 1
    end
    local len = #src
    for i = 0, len - 1 do
      dest[i + begin] = src[i + 1]
    end
  end
  
  table_insertto(debugdrawnodes1, debugdrawnodes2, #debugdrawnodes1 + 1)
  for k, v in pairs(debugdrawnodes1) do
    v:removeFromParent()
  end
  local labelSize = self:getSize()
  local anchorpoint = self:getAnchorPoint()
  local pos_x, pos_y = 0, 0
  local origin_x = pos_x - labelSize.width * anchorpoint.x
  local origin_y = pos_y - labelSize.height * anchorpoint.y
  local frame = cc.rect(origin_x, origin_y, labelSize.width, labelSize.height)
  self:drawrect(self, frame, 1):setName(DEBUG_MARK)
  self:drawdot(self, cc.p(0, 0), 5):setName(DEBUG_MARK)
  if 1 < level then
    local allnodelist = self._allnodelist
    local drawcolor = cc.c4f(0, 0, 1, 0.5)
    for _, node in pairs(allnodelist) do
      local box = node:getBoundingBox()
      local pos = cc.p(node:getPositionX(), node:getPositionY())
      self:drawrect(containerNode, box, 1, drawcolor):setName(DEBUG_MARK)
      self:drawdot(containerNode, pos, 2, drawcolor):setName(DEBUG_MARK)
    end
  end
end

function RichLabel:loadLabelParser_(label)
  local labelparserlist = shared_parserlist
  local parser = labelparserlist[label]
  if parser then
    return parser
  end
  local dotindex = string.find(CURRENT_MODULE, "%.%w+$")
  if not dotindex then
    return
  end
  local currentpath = string.sub(CURRENT_MODULE, 1, dotindex - 1)
  local parserpath = string.format("%s.labels.label_%s", currentpath, label)
  local parser = require(parserpath)
  if parser then
    labelparserlist[label] = parser
  end
  return parser
end

function RichLabel:charsToNodes_(parsedtable, containerNode)
  local default = self._default
  local allnodelist = {}
  for index, params in pairs(parsedtable) do
    local labelname = params.labelname
    local parser = self:loadLabelParser_(labelname)
    if not parser then
      return self:printf("not support label %s", labelname)
    end
    local nodelist = parser(self, params, default)
    params.nodelist = nodelist
    for _, node in pairs(nodelist) do
      table.insert(allnodelist, node)
      containerNode:addChild(node)
    end
  end
  return allnodelist
end

function RichLabel:layoutLine_(basepos, line, anchorpy, charspace)
  anchorpy = anchorpy or 0.5
  local pos_x = basepos.x
  local pos_y = basepos.y
  local lineheight = 0
  local linewidth = 0
  for index, node in pairs(line) do
    local box = node:getBoundingBox()
    node:setPosition(pos_x + linewidth + box.width / 2, pos_y)
    linewidth = linewidth + box.width + charspace
    if lineheight < box.height then
      lineheight = box.height
    end
  end
  if anchorpy ~= 0.5 then
    local offset = (anchorpy - 0.5) * lineheight
    for index, node in pairs(line) do
      local yy = node:getPositionY()
      node:setPositionY(yy - offset)
    end
  end
  return linewidth - charspace, lineheight
end

function RichLabel:adjustLineBreak_(allnodelist, charspace)
  local maxwidth = self._maxWidth
  if maxwidth <= 0 then
    maxwidth = 999999999999
  end
  local alllines = {
    {},
    {},
    {}
  }
  local addwidth = 0
  local rowindex = 1
  local colindex = 0
  for _, node in pairs(allnodelist) do
    colindex = colindex + 1
    local box = node:getBoundingBox()
    addwidth = addwidth + box.width
    local totalwidth = addwidth + (colindex - 1) * charspace
    local breakline = false
    if maxwidth < totalwidth then
      rowindex = rowindex + 1
      addwidth = box.width
      colindex = 1
      breakline = true
    end
    local curline = alllines[rowindex] or {}
    alllines[rowindex] = curline
    table.insert(curline, node)
    if not breakline and self:adjustContentLinebreak_(node) then
      rowindex = rowindex + 1
      colindex = 0
      addwidth = 0
    end
  end
  return alllines
end

function RichLabel:adjustContentLinebreak_(node)
  if node.getString then
    local str = node:getString()
    if str == "\n" then
      return true
    end
  end
  return false
end

function RichLabel:convertColor(xstr)
  if not xstr then
    return
  end
  
  local function toTen(v)
    return tonumber("0x" .. v)
  end
  
  local b = string.sub(xstr, -2, -1)
  local g = string.sub(xstr, -4, -3)
  local r = string.sub(xstr, -6, -5)
  local red = toTen(r)
  local green = toTen(g)
  local blue = toTen(b)
  if red and green and blue then
    return cc.c4b(red, green, blue, 255)
  end
end

function RichLabel:stringToChars(str)
  local list = {}
  local len = string.len(str)
  local i = 1
  while len >= i do
    local c = string.byte(str, i)
    local shift = 1
    if 0 < c and c <= 127 then
      shift = 1
    elseif 192 <= c and c <= 223 then
      shift = 2
    elseif 224 <= c and c <= 239 then
      shift = 3
    elseif 240 <= c and c <= 247 then
      shift = 4
    end
    local char = string.sub(str, i, i + shift - 1)
    i = i + shift
    table.insert(list, char)
  end
  return list, len
end

function RichLabel:split(str, delimiter)
  if delimiter == "" then
    return false
  end
  local pos, arr = 0, {}
  for st, sp in function()
    return string.find(str, delimiter, pos, true)
  end, nil, nil do
    table.insert(arr, string.sub(str, pos, st - 1))
    pos = sp + 1
  end
  table.insert(arr, string.sub(str, pos))
  return arr
end

function RichLabel:printf(fmt, ...)
  return print(string.format("RichLabel# " .. fmt, ...))
end

function RichLabel:drawdot(canvas, pos, radius, color4f)
  radius = radius or 2
  color4f = color4f or cc.c4f(1, 0, 0, 0.5)
  local drawnode = cc.DrawNode:create()
  drawnode:drawDot(pos, radius, color4f)
  canvas:addChild(drawnode)
  return drawnode
end

function RichLabel:drawrect(canvas, rect, borderwidth, color4f, isfill)
  local bordercolor = color4f or cc.c4f(1, 0, 0, 0.5)
  local fillcolor = isfill and bordercolor or cc.c4f(0, 0, 0, 0)
  borderwidth = borderwidth or 2
  local posvec = {
    cc.p(rect.x, rect.y),
    cc.p(rect.x, rect.y + rect.height),
    cc.p(rect.x + rect.width, rect.y + rect.height),
    cc.p(rect.x + rect.width, rect.y)
  }
  local drawnode = cc.DrawNode:create()
  drawnode:drawPolygon(posvec, 4, fillcolor, borderwidth, bordercolor)
  canvas:addChild(drawnode)
  return drawnode
end

function RichLabel:getSprite(filename)
  local spriteFrameCache = cc.SpriteFrameCache:getInstance()
  local spriteFrame = spriteFrameCache:getSpriteFrame(filename)
  if spriteFrame then
    return cc.Sprite:createWithSpriteFrame(spriteFrame)
  end
  return cc.Sprite:create(filename)
end

function RichLabel:getContentSize()
  return self:getSize()
end

return RichLabel
