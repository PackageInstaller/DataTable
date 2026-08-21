local unitCsv = require("csvdata.unit")
local unitbbCsv = require("csvdata.unit_bb")
local storyBookCsv = require("csvdata.storybook")
local guideCsv = require("csvdata.ui_guide")
local MonsterCsv = require("csvdata.tower_monster")
local BackUpCsv = require("csvdata.tower_backup")
local HeadframCsv = require("csvdata.head_circle")
local HeadpicCsv = require("csvdata.head_pic")
local GlobalRes = "ui/global/"
local TowerRes = "ui/tower/main/"
local glView = cc.Director:getInstance():getOpenGLView()
local UIHelper = {}
local CardRes = {
  normal = "card/normal/",
  list = "card/list/",
  book = "card/book/",
  cutin = "card/cutin/"
}
local iPhoneXWidth = {
  2436,
  1218,
  1792,
  2688,
  2532,
  2778,
  2340
}
local iphoneXHeight = {
  1125,
  562,
  828,
  1242,
  808,
  1170,
  1284,
  1080
}

function UIHelper.getCardRes(cardType, heroType, broken, quality)
  quality = quality or 5
  local unit = unitCsv[heroType]
  local loveBreak, value = UIHelper.getMaxLoveBreak(1000 < heroType and math.floor(heroType % 10000 / 10) or heroType)
  if unitbbCsv[heroType] and unitbbCsv[heroType].bbFlag == 1 then
    if unitbbCsv[heroType].love_bbFlag == 1 then
      loveBreak = 5
    end
  else
    loveBreak = 0
  end
  local br = broken and 5 <= loveBreak and "bb" or "n"
  return CardRes[cardType] .. string.format("%s_%s", unit.cardName, br) .. (unit.isTanli == 1 and br == "n" and string.format("_%d", quality + 1) or "") .. ".png"
end

function UIHelper.showOnleImgTip(imgPath, num)
  local cx, cy, width, height = display.cx, display.cy, display.width, display.height
  if UIHelper.isiPhoneX() then
    local movex = UIHelper.getMoveXForX(true)
    cx, cy, width = cx + movex, cy, width + movex * 2
  end
  local mask = UIHelper.newMask({
    size = cc.size(width, height),
    color = "#000000",
    opacity = 110
  })
  mask:anch(0.5, 0.5):pos(cx, cy):addTo(display.getRunningScene(), num or 100)
  local image = UIHelper.newImageView(imgPath):pos(width / 2, height / 2):addTo(mask)
  mask:setTouchEnabled(true)
  mask:setCallback(function()
    mask:removeSelf()
  end)
  return mask, image
end

function UIHelper.showOnleImgUnionTip(imgPath, size)
  local cx, cy, width, height = display.cx, display.cy, display.width, display.height
  if UIHelper.isiPhoneX() then
    local movex = UIHelper.getMoveXForX(true)
    cx, cy, width = cx + movex, cy, width + movex * 2
  end
  local mask = UIHelper.newMask({
    size = cc.size(width, height),
    color = "#000000",
    opacity = 110
  })
  mask:anch(0.5, 0.5):pos(cx, cy):addTo(display.getRunningScene(), 100)
  local image
  if not size then
    image = display.newSprite(imgPath)
  else
    image = display.newScale9Sprite(imgPath, 0, 0, cc.size(size[1], size[2]))
  end
  image:pos(width / 2, height / 2):addTo(mask)
  mask:setTouchEnabled(true)
  mask:setCallback(function()
    mask:removeSelf()
  end)
  return mask, image
end

function UIHelper.isiPhoneX()
  local framesize = glView:getFrameSize()
  if (framesize.width == 2436 or framesize.width == 1218) and (framesize.height == 1125 or framesize.height == 562) then
    return true
  else
    return false
  end
end

function UIHelper.fitForiPhoneX(node, onlyX)
  if not UIHelper.isiPhoneX() then
    return
  end
  local scale = UIHelper.getScaleForX()
  if onlyX then
    node:setScaleX(scale)
  else
    node:scale(scale)
  end
end

function UIHelper.getScaleForX()
  local framesize = glView:getFrameSize()
  return display.height / framesize.height * framesize.width / display.width
end

function UIHelper.getMoveXForX(notInt)
  local framesize = glView:getFrameSize()
  local mx = (display.height / framesize.height * framesize.width - display.width) / 2
  if not notInt then
    mx = math.ceil(mx)
  end
  return mx
end

function UIHelper.makeFontClear(label, uiType)
  if not label then
    return
  end
  uiType = uiType or "label"
  uiType = string.lower(uiType)
  if uiType == "button" then
    label = label:getTitleRenderer()
    label:anch(0.5, 0.5)
  end
  local anchorX = label:getAnchorPoint().x
  if anchorX ~= 0.5 then
    return
  end
  local width = label:getContentSize().width
  local scale = label:getScaleX()
  if scale ~= 1 then
    width = width * scale
  end
  local newX = math.ceil(label:getPositionX() - width / 2)
  label:anch(0, label:getAnchorPoint().y):setPositionX(newX)
end

function UIHelper.showDiamondTip(params)
  params = params or {}
  MDialog:double({
    text = "<img src='ui/global/5.png' scale=0.5 />钻石不足，是否前往商城购买？",
    size = 24,
    okText = "购买",
    title = "提示"
  }, function()
    local showType, showText, showBg = TopBar:getShowType()
    local layer = game:createView("shop.ShopLayer", {
      curType = 1,
      selected = 1,
      isHide = true
    })
    if params.parent and not tolua.isnull(params.parent) then
      params.parent:hide()
    end
    BackManager:push(function()
      if params.parent and not tolua.isnull(params.parent) then
        params.parent:show()
      end
      if params.callback then
        params.callback()
      end
      layer:close()
      TopBar:show(showType, showText, showBg)
    end)
  end)
end

function UIHelper.showCookTip(params)
  local tips = {
    "烹饪券不足，是否前往商城购买？",
    "快速烹饪券不足，是否前往商城购买？",
    "采购券不足，是否前往商城购买？",
    "需要 采购券*1 和 4星特急券*1 \n当前采购券不足，是否前往商城购买？",
    "快速治疗券不足，是否前往商城购买？",
    "需要 采购券*10 和 4星特急券*10 \n当前采购券不足，是否前往商城购买？"
  }
  local tip = tips[params.type]
  MDialog:double({
    text = tip,
    size = 24,
    okText = "购买",
    title = "提示"
  }, function()
    local showType, showText, showBg = TopBar:getShowType()
    local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 3})
    if params.parent and not tolua.isnull(params.parent) then
      params.parent:hide()
    end
    BackManager:push(function()
      if params.parent and not tolua.isnull(params.parent) then
        params.parent:show()
      end
      if params.callback then
        params.callback()
      end
      layer:close()
      TopBar:show(showType, showText, showBg)
    end)
  end)
end

function UIHelper.showGiftTip(params)
  local tips = {
    "再铸石不足，是否前往商城购买？"
  }
  local tip = tips[params.type]
  MDialog:double({
    text = tip,
    size = 24,
    okText = "购买",
    title = "提示"
  }, function()
    local showType, showText, showBg = TopBar:getShowType()
    local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 2})
    if params.parent and not tolua.isnull(params.parent) then
      params.parent:hide()
    end
    BackManager:push(function()
      if params.parent and not tolua.isnull(params.parent) then
        params.parent:show()
      end
      if params.callback then
        params.callback()
      end
      layer:close()
      TopBar:show(showType, showText, showBg)
    end)
  end)
end

function UIHelper.showExtraTip(params)
  local tips = {
    "主厨持有的食灵已经挤满了次元小屋。",
    "主厨，您的装备仓库已经存满啦。",
    "主厨，您的食材收藏已达到上限。",
    "主厨，您的酱料仓库已经存满啦。"
  }
  local forward = {
    [1] = function()
      local layer = game:createView("kitchen.KitchenLayer1", {})
      return layer
    end,
    [2] = function()
      local layer = game:createView("equip.EquipHomeLayer")
      return layer
    end,
    [3] = function()
      local layer = game:createView("kitchen.KitchenLayer1", {selected = 4})
      return layer
    end,
    [4] = function()
      local layer = game:createView("sauce.SauceHomeLayer")
      return layer
    end
  }
  local showType, showText, showBg = TopBar:getShowType()
  
  local function push(layer)
    if params.parent and not tolua.isnull(params.parent) then
      params.parent:hide()
    end
    BackManager:push(function()
      if params.parent and not tolua.isnull(params.parent) then
        params.parent:show()
      end
      layer:close()
      TopBar:show(showType, showText, showBg)
    end)
  end
  
  local tip = tips[params.type]
  local oktext = params.type == 4 and "去回收" or "去扩展"
  MDialog:double({
    text = tip,
    size = 24,
    okText = oktext,
    cancelText = "去整理",
    title = "提示",
    bgClick = true,
    okCallback = function()
      local layer
      if params.type == 4 then
        layer = game:createView("sauce.SauceHomeLayer", {selected = 7})
      else
        layer = game:createView("shop.ShopLayer", {curType = 1, selected = 4})
      end
      push(layer)
      return true
    end,
    cancelCallback = function()
      local layer = forward[params.type]()
      push(layer)
      return true
    end
  })
end

function UIHelper.showSlotExtraTip(params)
  local tips = {
    "车位未解锁，是否去商城购买？\n（车位不包含餐车，请去邮购或集市获得餐车）"
  }
  local showType, showText, showBg = TopBar:getShowType()
  
  local function push(layer)
    if params.parent and not tolua.isnull(params.parent) then
      params.parent:hide()
    end
    BackManager:push(function()
      if params.parent and not tolua.isnull(params.parent) then
        params.parent:show()
      end
      if params.callback then
        params.callback()
      end
      layer:close()
      TopBar:show(showType, showText, showBg)
    end)
  end
  
  local tip = tips[params.type]
  MDialog:double({
    text = tip,
    size = 24,
    okText = "购买",
    cancelText = "取消",
    title = "提示",
    bgClick = true,
    okCallback = function()
      local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 4})
      push(layer)
      return true
    end,
    cancelCallback = function()
      return true
    end
  })
end

function UIHelper.getProfessionTag(profession, quality, size, treeMax)
  quality = quality or 0
  size = size or 16
  local proBg = display.newSprite(GlobalRes .. string.format("profession_bg_%d.png", quality))
  local proTag = treeMax and "profession_s" or "profession"
  display.newSprite(GlobalRes .. string.format("%s_%d.png", proTag, profession)):center(proBg):addTo(proBg)
  local titleBg = display.newSprite(GlobalRes .. string.format("des_bg_%d.png", quality)):pos(proBg:getContentSize().width / 2, -25):addTo(proBg, -1)
  display.newTTFLabel({
    text = TitleData[profession],
    size = size,
    color = display.COLOR_WHITE
  }):enableOutline(display.COLOR_BLACK, 1):pos(10, 24):addTo(titleBg)
  titleBg:setCascadeOpacityEnabled(true)
  return proBg
end

function UIHelper.showPageGuide(majorStep)
  if SKIP_GUIDE then
    return
  end
  local savedData = game.role.activeGuide[tostring(majorStep)]
  if savedData and tonumber(savedData) > 0 then
    return
  end
  local guideSet = guideCsv[majorStep][1]
  game:createView("common.CarbonGuideLayer", {
    guidePic = guideSet.tips
  })
  game.role:saveGuideData({
    master = majorStep,
    slave = 1,
    finish = 1,
    skip = 0
  })
  game.role.activeGuide[tostring(majorStep)] = 1
end

function UIHelper.showGuide(majorStep, node)
  if SKIP_GUIDE then
    return
  end
  if game.role.autoStatus:getv(10, 1) == 0 then
    return
  end
  node:removeChildByName("guide_btn")
  local guideSet = guideCsv[majorStep][1]
  local x, y = string.match(guideSet.tipsOffset, "%s*([-]?%d+)=([-]?%d+)%s*")
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(GlobalRes, {"help.png", "help.png"})
  btn:pos(x, y):addTo(node):name("guide_btn")
  btn:setCallback(function()
    UIHelper.showGuideTip(majorStep, btn)
  end)
  local savedData = game.role.activeGuide[tostring(majorStep)]
  if savedData and 0 < tonumber(savedData) then
    return
  end
  UIHelper.showGuideTip(majorStep, btn)
  game.role:saveGuideData({
    master = majorStep,
    slave = 1,
    finish = 1,
    skip = 0
  })
  game.role.activeGuide[tostring(majorStep)] = 1
end

function UIHelper.showGuideTip(majorStep, node)
  if node and not tolua.isnull(node) then
    node:hide()
  end
  local guideSet = guideCsv[majorStep][1]
  local tip = UIHelper.newImageView(guideSet.tips):pos(display.cx, display.cy):addTo(display.getRunningScene(), NEW_GUIDE_LAYER_ORDER)
  tip:setCallback(function()
    tip:removeSelf()
    if node and not tolua.isnull(node) then
      node:show()
    end
  end)
  tip:setSwallowTouches(false)
end

local glProgramCache = cc.GLProgramCache:getInstance()
local uniformTypes = {
  i = "setUniformInt",
  f = "setUniformFloat",
  v2 = "setUniformVec2",
  v3 = "setUniformVec3",
  v4 = "setUniformVec4",
  texture = "setUniformTexture"
}

function UIHelper.getScreenWithBlur(node)
  local function makeCombine()
    local result = cc.Sprite:createWithTexture(game.blurScreen:getSprite():getTexture())
    
    result:anch(0.5, 0.5):flipY(true)
    UIHelper.setNodeParamsShader(result, "gaussian", {
      u_resolution = {
        type = "f",
        value = display.width
      },
      u_radius = {type = "f", value = 1},
      u_direction = {
        type = "v2",
        value = {x = 2, y = 2}
      }
    })
    local mask = ccui.Layout:create()
    mask:size(display.width, display.height)
    mask:setBackGroundColorType(1)
    mask:setBackGroundColor(cc.c3b(0, 0, 0))
    mask:setBackGroundColorOpacity(150)
    mask:addTo(result)
    return result
  end
  
  if not node then
    return makeCombine()
  end
  local scene = display.getRunningScene()
  local renderTexture = cc.RenderTexture:create(display.width, display.height)
  renderTexture:begin()
  node:visit()
  renderTexture:endToLua()
  if game.blurScreen then
    game.blurScreen:release()
  end
  game.blurScreen = renderTexture
  game.blurScreen:retain()
end

function UIHelper.getFunCost(type, count)
  local data = CostCsv[type]
  local grows = string.toArray(data.cellMoneyGrow, " ")
  return data.cellMoney + (0 < count and (grows[count] and tonumber(grows[count]) or tonumber(grows[#grows])) or 0)
end

function UIHelper.transPos(value)
  return value + (1136 - display.width) / 2
end

function UIHelper.showAwards(items, title, callback)
  local content = display.newSprite(GlobalRes .. "award_bg.png"):pos(display.cx, display.height / 2 - 80):opacity(0):addTo(display.getRunningScene(), MSGBOX_LAYER_ORDER)
  local size = content:getContentSize()
  local interval = 100
  local xPos = size.width / 2 - (table.nums(items) - 1) * interval / 2
  for id, count in pairs(items) do
    ItemIcon.new({type = id, count = count}):anch(0.5, 0.5):pos(xPos, size.height / 2 - 20):addTo(content)
    xPos = xPos + interval
  end
  display.newTTFLabel({
    text = title or "恭喜获得",
    size = 40,
    color = UIHelper.hex2rgb("#f8d134")
  }):pos(size.width / 2, size.height - 30):addTo(content)
  content:runAction(transition.sequence({
    cc.Spawn:create({
      cc.MoveBy:create(0.3, cc.p(0, 80)),
      cc.FadeIn:create(0.3)
    }),
    cc.DelayTime:create(1),
    cc.Spawn:create({
      cc.MoveBy:create(0.1, cc.p(0, display.height / 2 + 100)),
      cc.FadeOut:create(0.1)
    }),
    cc.CallFunc:create(function()
      if callback then
        callback()
      end
    end),
    cc.RemoveSelf:create()
  }))
  return content
end

function UIHelper.getItemIcon(itemId, count)
  local pattern = {
    [ItemType.Diamond] = function()
      return display.newSprite(GlobalRes .. "huobi_1.png")
    end,
    [ItemType.Money] = function(parent)
      return display.newSprite(GlobalRes .. "huobi_2.png")
    end,
    [ItemType.Exp] = function(parent)
      return display.newSprite(GlobalRes .. "huobi_exp.png")
    end,
    [ItemType.TowerCoin] = function()
      return display.newSprite("ui/tower/xinghunbi.png")
    end
  }
  local content
  local itemData = itemCsv[itemId]
  if pattern[itemData.type] then
    content = pattern[itemData.type]()
  else
    content = ItemIcon.new({type = itemId, count = count})
  end
  return content
end

function UIHelper.newMsgTag(node, point, ratio, special)
  local xx, yy = 0, 0
  local tag = node:getChildByTag(9797)
  if not tolua.isnull(tag) then
    return
  end
  local size = node:getContentSize()
  if point then
    xx = size.width + point.x
    yy = size.height + point.y
  else
    xx = size.width - 5
    yy = size.height - 5
  end
  ratio = ratio or 1
  local res = special and "ui/global/story_new.png" or "ui/global/msg_new.png"
  UIHelper.newImageView(res):scale(ratio):anch(1, 1):pos(xx, yy):addTo(node, 10, 9797)
end

function UIHelper.showRedPoint(node, action, point, ratio, special)
  if not node then
    return
  end
  local bshow = false
  if type(action) == "string" then
    bshow = action == "show"
  elseif type(action) == "boolean" then
    bshow = action
  else
    return
  end
  if bshow then
    UIHelper.newMsgTag(node, point, ratio, special)
  elseif node:getChildByTag(9797) then
    node:removeChildByTag(9797)
  end
end

function UIHelper.getPlatformScale()
  local scaleX = display.width / CC_DESIGN_RESOLUTION.width
  local scaleY = display.height / CC_DESIGN_RESOLUTION.height
  local commonScale = scaleX
  if scaleX > scaleY then
    commonScale = scaleY
  end
  return commonScale
end

function UIHelper.getChildControl(root, name)
  local control
  root:enumerateChildren("//" .. name, function(ret)
    control = ret
    return true
  end)
  return control
end

function UIHelper.getParentName(node)
  local parentName = ""
  if node:getParent() then
    parentName = node:getParent():getName()
  end
  return parentName
end

function UIHelper.screenShine(callback)
  display.newSprite("ui/hero/eff/screen_shine.png"):anch(0.5, 0.5):pos(display.cx, display.cy):scale(0):opacity(0):addTo(display.getRunningScene(), MSGBOX_LAYER_ORDER + 1):runAction(transition.sequence({
    cc.Spawn:create({
      cc.ScaleTo:create(0.2, 6),
      cc.FadeIn:create(0.2)
    }),
    cc.FadeOut:create(0.26666666666666666),
    cc.RemoveSelf:create(),
    cc.CallFunc:create(function()
      if callback then
        callback()
      end
    end)
  }))
end

function UIHelper.createJeteWord(params)
  local delTime = params.delTime or 0.15
  local moveTime = params.moveTime or 0.1
  local yOffset = params.yOffset or 8
  local lineTime = params.lineTime or 1
  local words, len = MRichText:stringToChars(params.text)
  local root = display.newNode()
  local content = display.newNode():addTo(root)
  local xPos, interval = 0, 0
  local labelList = {}
  for index, word in ipairs(words) do
    local label = display.newTTFLabel({
      text = word,
      size = params.size,
      color = params.color
    })
    if params.outline then
      label:enableOutline(params.outline, 1)
    end
    table.insert(labelList, label)
    label:anch(0, 0.5):pos(xPos, 0):addTo(content)
    xPos = xPos + label:getContentSize().width + interval
  end
  content:pos(-(xPos - interval) / 2, 0)
  local index = 1
  local jumpAction
  
  function jumpAction()
    content:runAction(transition.sequence({
      cc.CallFunc:create(function()
        labelList[index]:stopAllActions()
        labelList[index]:runAction(transition.sequence({
          cc.MoveBy:create(moveTime, cc.p(0, yOffset)),
          cc.MoveBy:create(moveTime, cc.p(0, -yOffset))
        }))
      end),
      cc.DelayTime:create(delTime),
      cc.CallFunc:create(function()
        index = index + 1
        if index > #words then
          index = 1
          content:runAction(transition.sequence({
            cc.DelayTime:create(lineTime),
            cc.CallFunc:create(jumpAction)
          }))
        else
          jumpAction()
        end
      end)
    }))
  end
  
  jumpAction()
  return root
end

function UIHelper.createParabolaAction(params)
  params = params or {}
  local angle = params.angle or 60
  local time = params.time or 1
  local height = params.height or 300
  local startPos = params.startPos
  local endPos = params.endPos
  local radian = angle * math.pi / 180
  local q1x = startPos.x + (endPos.x - startPos.x) / 4
  local q1 = startPos
  local q2x = startPos.x + (endPos.x - startPos.x) / 2
  local q2 = cc.p(startPos.x + (endPos.x - startPos.x) / 2, startPos.y + (endPos.y - startPos.y) / 2 + height)
  return cc.EaseInOut:create(CCBezierTo:create(time, {
    q1,
    q2,
    endPos
  }), 0.5)
end

function UIHelper.getDaysInMonth(year, month)
  local curTime = game and os.date("*t", game:nowTime()) or os.time()
  year = year or checknumber(curTime.year)
  month = month or checknumber(curTime.month)
  month = (month + 1) % 12
  local calcTime = os.time({
    year = year,
    month = month,
    day = 1,
    hour = 0,
    min = 0,
    sec = 0
  }) - 1
  return checknumber(os.date("*t", calcTime).day)
end

function UIHelper.translateNum(value)
  local NUMS = {
    "",
    "一",
    "二",
    "三",
    "四",
    "五",
    "六",
    "七",
    "八",
    "九"
  }
  local UNITS = {"", "十"}
  local result = ""
  for i = string.len(value) - 1, 0, -1 do
    local r = math.floor(value / math.pow(10, i))
    result = result .. NUMS[r % 10 + 1]
    result = result .. UNITS[i + 1]
  end
  return result
end

function UIHelper.getTimeDayStr(time, short)
  local d = math.floor(time / 24 / 3600)
  local h = math.floor(time / 3600 % 24)
  local m = math.floor(time / 60 % 60)
  if 0 < d then
    return string.format("%d天%02d小时%02d分", d, h, m)
  else
    return string.format("%02d小时%02d分", h, m)
  end
end

function UIHelper.getTimeStr(time, short)
  local h = math.floor(time / 3600)
  local m = math.floor(time / 60 % 60)
  local s = time % 60
  if 0 < h then
    return string.format("%02d:%02d:%02d", h, m, s)
  elseif short then
    return string.format("%02d:%02d", m, s)
  else
    return string.format("00:%02d:%02d", m, s)
  end
end

function UIHelper.getPassTimeDesc(time)
  local day = math.floor(time / 86400)
  local hour = math.floor(time / 3600)
  local min = math.floor(time / 60)
  if 0 < day then
    if 30 < day then
      day = 30
    end
    return string.format("%d天前", day)
  elseif 0 < hour then
    return string.format("%d小时前", hour)
  elseif 0 < min then
    return string.format("%d分钟前", min)
  end
  return "刚刚"
end

function UIHelper.getBreakState(breakLevel)
  local colorNum = breakCsv[breakLevel].ps
  local color = ""
  if string.len(colorNum) == 5 then
    color = string.sub(colorNum, 4, 5)
  end
  return breakCsv[breakLevel].skillLevel, color
end

function UIHelper.isSpecTime(startHour, endHour, specday)
  local tm = os.date("*t", game:nowTime())
  if specday then
    local day = (tm.wday + 6) % 7
    if day == 0 then
      day = 7
    end
    return specday == day and startHour <= tm.hour and endHour > tm.hour
  end
  return startHour <= tm.hour and endHour > tm.hour
end

function UIHelper.showAttrsChange(params)
  params = params or {}
  local curAttrs, oldAttrs = params.curAttrs, params.oldAttrs
  if not curAttrs or not oldAttrs then
    return
  end
  local parent = params.parent or display.getRunningScene()
  local offset = params.offset or cc.p(0, 0)
  local fontSize = params.fontSize or 20
  if not parent or tolua.isnull(parent) then
    return
  end
  local offsetY = 30
  local delayTime = 0
  local time = 0
  for key, value in pairs(AttsEnum) do
    local deltaValue = math.floor((curAttrs[key] or 0) - (oldAttrs[key] or 0))
    if deltaValue ~= 0 then
      local midSymbol = 0 < deltaValue and "+" or "-"
      local color = 0 < deltaValue and display.COLOR_GREEN or display.COLOR_RED
      local deltaY = 0 < deltaValue and offsetY or -offsetY
      local text = display.newTTFLabel({
        text = AttrDesc[value] .. midSymbol .. deltaValue,
        size = fontSize,
        color = color
      }):enableOutline(UIHelper.hex2rgb("#2c0000"), 2):anch(0.5, 0.5):hide():pos(parent:getContentSize().width / 2 + offset.x, parent:getContentSize().height / 2 + offset.y):addTo(parent)
      text:runAction(transition.sequence({
        cc.DelayTime:create(delayTime),
        cc.CallFunc:create(function()
          text:show()
        end),
        cc.MoveBy:create(0.1, cc.p(0, deltaY)),
        cc.DelayTime:create(0.3),
        cc.MoveBy:create(0.1, cc.p(0, deltaY)),
        cc.RemoveSelf:create()
      }))
      delayTime = delayTime + 0.4
      time = time + 0.4
    end
  end
  if oldAttrs.battleValue then
    local deltaValue = game.role.totalBattleValue - oldAttrs.battleValue
    if deltaValue ~= 0 then
      local midSymbol = 0 < deltaValue and "+" or "-"
      local color = 0 < deltaValue and display.COLOR_GREEN or display.COLOR_RED
      local deltaY = 0 < deltaValue and offsetY or -offsetY
      local text = display.newTTFLabel({
        text = "总战力" .. midSymbol .. deltaValue,
        size = fontSize,
        color = color
      }):enableOutline(UIHelper.hex2rgb("#2c0000"), 2):anch(0.5, 0.5):hide():pos(parent:getContentSize().width / 2 + offset.x, parent:getContentSize().height / 2 + offset.y):addTo(parent)
      text:runAction(transition.sequence({
        cc.DelayTime:create(time),
        cc.CallFunc:create(function()
          text:show()
        end),
        cc.MoveBy:create(0.1, cc.p(0, deltaY)),
        cc.DelayTime:create(0.3),
        cc.MoveBy:create(0.1, cc.p(0, deltaY)),
        cc.RemoveSelf:create()
      }))
    end
  end
end

function UIHelper.pvpAttrItem(level)
  local items = {
    [1] = true,
    [2] = true,
    [3] = true
  }
  local index = math.randomInt(1, 3)
  items[index] = nil
  return items
end

function UIHelper.pvpScore2Level(score)
  local level
  for id, levelData in ipairs(require("csvdata.pvp_part")) do
    level = id
    if score < levelData.nextScore then
      break
    end
  end
  return level
end

function UIHelper.bSpecialAttr(attrType)
  local spAttr = {
    5,
    6,
    9,
    13,
    14
  }
  return table.indexof(spAttr, attrType)
end

function UIHelper.attrColor(attr, max)
  local p = attr / max * 100
  if 80 <= p then
    return UIHelper.hex2rgb("#f7f601")
  elseif 60 <= p then
    return UIHelper.hex2rgb("#c844ff")
  elseif 30 <= p then
    return UIHelper.hex2rgb("#69c5ff")
  else
    return UIHelper.hex2rgb("#89ec66")
  end
end

function UIHelper.hex2rgb(hex)
  hex = hex:gsub("#", "")
  return cc.c4b(tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6)), 255)
end

function UIHelper.hex2rgba(hex)
  hex = hex:gsub("#", "")
  return cc.c4b(tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6)), tonumber("0x" .. hex:sub(7, 8)))
end

function UIHelper.numVaryEffect(params)
  params = params or {}
  if not params.node then
    return
  end
  local effectTime = params.effectTime or 0.5
  local repeatTimes = params.repeatTimes or effectTime * (params.fps or 30)
  local stringFormat = params.stringFormat or "%d"
  local orginNum = params.orginNum or 0
  local sub = orginNum > params.endNum
  local count = 1
  params.node:runAction(cc.Repeat:create(transition.sequence({
    cc.CallFunc:create(function()
      local num = orginNum + (params.endNum - orginNum) / repeatTimes * count
      if sub then
        num = num > params.endNum and num or params.endNum
      else
        num = num > params.endNum and params.endNum or num
      end
      params.node:setString(string.format(stringFormat, num))
      count = count + 1
    end),
    cc.DelayTime:create(effectTime / repeatTimes)
  }), repeatTimes + 1))
end

function UIHelper.loadAnimation(res, fileName, frameNum, fps, loadFromCache)
  if not loadFromCache then
    display.addSpriteFrames(res .. fileName .. ".plist", res .. fileName .. ".png")
  end
  local frames = {}
  for index = 1, frameNum do
    local frameId = string.format("%02d", index)
    frames[#frames + 1] = display.newSpriteFrame(fileName .. "_" .. frameId .. ".png")
  end
  fps = fps or frameNum
  local animation = display.newAnimation(frames, 1 / fps)
  local sprite = display.newSprite(frames[1])
  return {sprite = sprite, animation = animation}
end

function UIHelper.getClipNode(params)
  local clip
  local params = params or {}
  local steRes = params.steRes
  local color4 = params.color4
  local clipRes = params.clipRes
  local isInverted = params.isInverted or false
  local node = params.node
  local isFlip = params.isFlip or false
  if params and steRes and (steRes or color4) then
    local sten = display.newSprite(steRes)
    sten:setFlippedX(isFlip)
    clip = cc.ClippingNode:create()
    clip:setStencil(sten)
    clip:setInverted(isInverted)
    clip:setPosition(cc.p(display.cx, display.cy))
    clip:setAlphaThreshold(0)
    if color4 then
      local flayer = cc.LayerColor:create(color4)
      flayer:setPosition(cc.p(-display.cx, -display.cy))
      clip:addChild(flayer)
    elseif clipRes then
      local sten = display.newSprite(clipRes)
      sten:setPosition(cc.p(clip:getContentSize().width / 2, clip:getContentSize().height / 2))
      clip:addChild(sten)
    elseif node then
      node:setFlippedX(isFlip)
      node:setPosition(cc.p(clip:getContentSize().width / 2, clip:getContentSize().height / 2))
      clip:addChild(node)
    end
  end
  return clip
end

function UIHelper.popupNode(node, scale)
  scale = scale or 1
  node:scale(0.1 * scale)
  local actions = transition.sequence({
    CCScaleTo:create(0.1, 1.1 * scale),
    CCScaleTo:create(0.1, 0.95 * scale),
    CCScaleTo:create(0.07, 1 * scale)
  })
  node:runAction(actions)
end

function UIHelper.shrinkNode(node, onComplete)
  local actions = transition.sequence({
    CCScaleTo:create(0.1, 1.2),
    CCScaleTo:create(0.1, 0.1),
    CCRemoveSelf:create(),
    CCCallFunc:create(function()
      onComplete()
    end)
  })
  node:runAction(actions)
end

function UIHelper.shake(target, args)
  local target = target or display.getRunningScene()
  args = args or {}
  local time = args.time or 0.01
  local x = args.x or 5
  local y = args.y or 5
  local shakeCount = args.count or 30
  local actions = {}
  actions[#actions + 1] = cc.MoveBy:create(time, cc.p(-x, -y))
  for count = 1, shakeCount do
    actions[#actions + 1] = cc.MoveBy:create(time * 2, cc.p(x * 2, y * 2))
    actions[#actions + 1] = cc.MoveBy:create(time * 2, cc.p(-x * 2, -y * 2))
  end
  actions[#actions + 1] = cc.MoveBy:create(time, cc.p(x, y))
  if args.callback then
    actions[#actions + 1] = cc.CallFunc:create(function()
      args.callback()
    end)
  end
  return target:runAction(transition.sequence(actions))
end

function UIHelper.setNodeGLProgram(node, shaderKey)
  local glProgram = glProgramCache:getGLProgram(shaderKey)
  if not glProgram or tolua.isnull(glProgram) then
    return
  end
  if tolua.type(node) == "cc.Label" then
    return node
  end
  node:setGLProgram(glProgram)
  for _, child in ipairs(node:getChildren()) do
    UIHelper.setNodeGLProgram(child, shaderKey)
  end
  return node
end

function UIHelper.setNodeShader(node, shaderName)
  local shaderKey = "Shader" .. shaderName
  local glProgram = glProgramCache:getGLProgram(shaderKey)
  if not glProgram or tolua.isnull(glProgram) then
    local vertFile = string.format("shaders/%s.vert", shaderName)
    local fragFile = string.format("shaders/%s.frag", shaderName)
    glProgram = cc.GLProgram:createWithFilenames(vertFile, fragFile)
    glProgramCache:addGLProgram(glProgram, shaderKey)
  end
  UIHelper.setNodeGLProgram(node, shaderKey)
  return node
end

function UIHelper.setImageViewGray(node)
  node:getVirtualRenderer():setState(1)
  for _, child in ipairs(node:getChildren()) do
    if child.getVirtualRenderer and child:getVirtualRenderer().setState then
      child:getVirtualRenderer():setState(1)
    end
  end
end

function UIHelper.setNodeParamsShader(node, shaderName, params)
  local shaderKey = "Shader" .. shaderName
  local glProgram = glProgramCache:getGLProgram(shaderKey)
  if not glProgram or tolua.isnull(glProgram) then
    local vertFile = string.format("shaders/%s.vert", shaderName)
    local fragFile = string.format("shaders/%s.frag", shaderName)
    glProgram = cc.GLProgram:createWithFilenames(vertFile, fragFile)
    glProgramCache:addGLProgram(glProgram, shaderKey)
  end
  node:setGLProgram(glProgram)
  local glProgramState = node:getGLProgramState()
  for key, data in pairs(params) do
    glProgramState[uniformTypes[data.type]](glProgramState, key, data.value)
  end
  for _, child in ipairs(node:getChildren()) do
    UIHelper.setNodeParamsShader(child, shaderName, params)
  end
  return node
end

function UIHelper.loadPlistFrames(plist)
  local content = cc.FileUtils:getInstance():getValueMapFromFile(plist)
  local framesName = table.keys(content.frames) or {}
  table.sort(framesName)
  return framesName
end

function UIHelper.loadPlistTexture(plist)
  local content = cc.FileUtils:getInstance():getValueMapFromFile(plist)
  local dir = string.match(plist, "(.*/).*")
  return dir .. content.metadata.textureFileName
end

function UIHelper.createCommonSpine(params)
  local boneRes = params.res
  local spineNode
  if ResourceMgr and ResourceMgr:existSpineNode(boneRes) then
    spineNode = ResourceMgr:getSpineNode(boneRes)
  else
    if not params.ingonePixelFormat then
    end
    spineNode = sp.SkeletonAnimation:create(boneRes .. ".json", boneRes .. ".atlas", 1)
  end
  local ratio = 1
  return spineNode:scale(ratio), ratio
end

function UIHelper.createHeroCard(type, params)
  local heroData = unitCsv[type]
  if not params.ingonePixelFormat then
  end
  local spineNode = sp.SkeletonAnimation:create(heroData.cardBone .. ".json", heroData.cardBone .. ".atlas", 1)
  local ratio = params.scale or 1
  return spineNode:scale(ratio)
end

function UIHelper.createSpineNode(type, params)
  params = params or {}
  local unitData = unitCsv[type]
  local spineNode
  local star = params.star or unitData.star
  local dress = params.dress or 0
  local dressData = 0 < dress and DressCsv[dress] or nil
  local unitScale = dressData and dressData.boneRatio or unitData.boneRatio
  local boneRes = dressData and dressData.boneRes or unitData.boneRes
  if ResourceMgr and ResourceMgr:existSpineNode(boneRes) then
    spineNode = ResourceMgr:getSpineNode(boneRes)
  else
    if not params.ingonePixelFormat then
    end
    spineNode = sp.SkeletonAnimation:create(boneRes .. ".json", boneRes .. ".atlas", 1)
  end
  local ratio = params.scale or unitScale / 100
  return spineNode:scale(ratio), ratio
end

function UIHelper.createSpineNodeByRes(boneRes, params)
  params = params or {}
  local spineNode
  if ResourceMgr and ResourceMgr:existSpineNode(boneRes) then
    spineNode = ResourceMgr:getSpineNode(boneRes)
  else
    if not params.ingonePixelFormat then
    end
    spineNode = sp.SkeletonAnimation:create(boneRes .. ".json", boneRes .. ".atlas", 1)
  end
  return spineNode
end

function UIHelper.createVideoPlayer(file, callback)
  if device.platform == "ios" or device.platform == "android" then
    local videoPlayer = ccexp.VideoPlayer:create()
    videoPlayer:anch(0.5, 0.5):pos(display.cx, display.cy)
    videoPlayer:size(display.height * 1136 / 640, display.height)
    videoPlayer:setFileName(cc.FileUtils:getInstance():fullPathForFilename(file))
    videoPlayer:setTouchable(false)
    videoPlayer:play()
    videoPlayer:addEventListener(function(sener, eventType)
      if eventType == ccexp.VideoPlayerEvent.STOPPED or eventType == ccexp.VideoPlayerEvent.COMPLETED then
        scheduler.performWithDelayGlobal(function()
          videoPlayer:removeSelf()
          if callback then
            callback()
          end
        end, 0.03333333333333333)
      end
    end)
    return videoPlayer
  end
end

function UIHelper.createMaskSprite(jpg, mask)
  local jpgSprite = display.newSprite(jpg)
  cc.Texture2D:setDefaultAlphaPixelFormat(cc.TEXTURE2D_PIXEL_FORMAT_A8)
  local maskTexture = display.newSprite(mask):getTexture():getName()
  cc.Texture2D:setDefaultAlphaPixelFormat(cc.TEXTURE2D_PIXEL_FORMAT_RGBA8888)
  UIHelper.setNodeParamsShader(jpgSprite, "jpgmask", {
    u_maskTexture = {type = "texture", value = maskTexture}
  })
  return jpgSprite
end

function UIHelper.createUnitCard(type)
  local unitData = unitCsv[type]
  if unitData.cardRes == "" then
    return
  end
  return display.newSprite(unitData.cardRes)
end

function UIHelper.pauseNode(node)
  transition.pauseTarget(node)
  for _, child in ipairs(node:getChildren()) do
    UIHelper.pauseNode(child)
  end
end

function UIHelper.getHotHeroBuff()
  local buffs = {}
  local leftInfo = game.role:battleInfo("tower")
  local hotId = game.role.trialWeek % 3 + 1
  local hotData = towerHotCsv[hotId]
  for id, data in pairs(hotData) do
    local units = data.unit:toArray(" ", true)
    for index = 1, 3 do
      for leftId, hero in pairs(leftInfo.heros or {}) do
        if hero.id == units[index] then
          local type, value = data.type:match("(%d+)=(%d+)")
          buffs[tonumber(type)] = tonumber(value)
        end
      end
    end
  end
  return buffs
end

function UIHelper.resumeNode(node)
  transition.resumeTarget(node)
  for _, child in ipairs(node:getChildren()) do
    UIHelper.resumeNode(child)
  end
end

function UIHelper.showWaiting(hold)
  local layer = UIHelper.extend(ccui.Layout:create())
  layer:size(display.width, display.height)
  layer:setBackGroundColorType(1)
  layer:setBackGroundColor(cc.c3b(0, 0, 0))
  layer:setTouchEnabled(true)
  layer:setSwallowTouches(true)
  layer:setBackGroundColorOpacity(0)
  layer:addTo(display.getRunningScene(), NETWORK_WAITING_ORDER, NETWORK_WAITING_TAG)
  UIHelper.fitForiPhoneX(layer)
  local actions = {
    cc.DelayTime:create(2),
    cc.CallFunc:create(function()
      layer:setBackGroundColorOpacity(115)
      local res = UIHelper.loadAnimation("ui/global/", "waiting", 12, 12)
      res.sprite:center(layer):addTo(layer):runAction(cc.RepeatForever:create(cc.Animate:create(res.animation)))
    end),
    cc.DelayTime:create(15)
  }
  if not hold then
    actions[#actions + 1] = cc.CallFunc:create(function()
      NetManager:showConnectFailTip()
      layer:removeSelf()
    end)
  end
  layer:runAction(transition.sequence(actions))
end

function UIHelper.removeWaiting()
  local layer = display.getRunningScene():getChildByTag(NETWORK_WAITING_TAG)
  if layer then
    layer:stopAllActions()
    layer:removeSelf()
  end
end

function UIHelper.extend(widget)
  local widgetExMap = {
    Widget = require("widget_ext.WidgetEx"),
    Button = require("widget_ext.ButtonEx"),
    Layout = require("widget_ext.LayoutEx"),
    Label = require("widget_ext.TextEx"),
    Text = require("widget_ext.TextEx"),
    TextField = require("widget_ext.TextFieldEx"),
    ScrollView = require("widget_ext.ScrollViewEx"),
    ListView = require("widget_ext.ScrollViewEx"),
    ImageView = require("widget_ext.ImageViewEx")
  }
  local extension = widgetExMap[widget:getDescription()]
  if extension then
    for key, value in pairs(extension) do
      widget[key] = value
    end
  end
  return widget
end

function UIHelper.newImageView(file, texType)
  return UIHelper.extend(ccui.ImageView:create(file, texType or ccui.TextureResType.localType))
end

function UIHelper.newText(params)
  local text = tostring(params.text)
  local font = params.font or display.DEFAULT_TTF_FONT
  local size = params.size or display.DEFAULT_TTF_FONT_SIZE
  local color = params.color or display.COLOR_WHITE
  local result = ccui.Text:create(text, font, size)
  result:setTextColor(color)
  return UIHelper.extend(result)
end

function UIHelper.newMask(params)
  local mask = UIHelper.extend(ccui.Layout:create())
  if params.size then
    mask:size(params.size)
  end
  if params.color or params.color3B then
    mask:setBackGroundColorType(1)
    mask:setBackGroundColor(params.color3B and params.color3B or UIHelper.hex2rgb(params.color))
  end
  if params.opacity then
    mask:setBackGroundColorOpacity(params.opacity)
  end
  return mask
end

function UIHelper.MoveToUp(params)
  local delay = params.delay or 0
  local time = params.time or 0.5
  local node = params.node
  local fadeOut = params.fadeOut or false
  local ignore = params.ignore or false
  local ease = params.ease
  local pos = params.pos
  local orgX, orgY = node:getPosition()
  local size = node:getContentSize()
  if pos then
    size.width = pos[1]
    size.height = pos[2]
  end
  node:pos(orgX, orgY - size.height)
  local actions = {}
  if 0 < delay then
    actions[#actions + 1] = cc.DelayTime:create(delay)
  end
  if not fadeOut and not ignore then
    node:setOpacity(0)
    actions[#actions + 1] = cc.Spawn:create(cc.FadeIn:create(time), cc.MoveTo:create(time, cc.p(orgX, orgY)))
  elseif fadeOut and not ignore then
    actions[#actions + 1] = cc.Spawn:create(cc.FadeOut:create(time), cc.MoveTo:create(time, cc.p(orgX, orgY)))
  else
    actions[#actions + 1] = cc.MoveTo:create(time, cc.p(orgX, orgY))
  end
  if ease then
    actions[#actions] = cc.EaseQuarticActionOut:create(actions[#actions])
  end
  node:runAction(transition.sequence(actions))
end

function UIHelper.MoveToDown(params)
  local delay = params.delay or 0
  local time = params.time or 0.5
  local node = params.node
  local fadeOut = params.fadeOut or false
  local ignore = params.ignore or false
  local ease = params.ease
  local pos = params.pos
  local orgX, orgY = node:getPosition()
  local size = node:getContentSize()
  if pos then
    size.width = pos[1]
    size.height = pos[2]
  end
  node:pos(orgX, orgY + size.height)
  local actions = {}
  if 0 < delay then
    actions[#actions + 1] = cc.DelayTime:create(delay)
  end
  if not fadeOut and not ignore then
    node:setOpacity(0)
    actions[#actions + 1] = cc.Spawn:create(cc.FadeIn:create(time), cc.MoveTo:create(time, cc.p(orgX, orgY)))
  elseif fadeOut and not ignore then
    actions[#actions + 1] = cc.Spawn:create(cc.FadeOut:create(time), cc.MoveTo:create(time, cc.p(orgX, orgY)))
  else
    actions[#actions + 1] = cc.MoveTo:create(time, cc.p(orgX, orgY))
  end
  if ease then
    actions[#actions] = cc.EaseQuarticActionOut:create(actions[#actions])
  end
  node:runAction(transition.sequence(actions))
end

function UIHelper.MoveToLeft(params)
  local delay = params.delay or 0
  local time = params.time or 0.5
  local node = params.node
  local fadeOut = params.fadeOut or false
  local ignore = params.ignore or false
  local ease = params.ease
  local pos = params.pos
  local orgX, orgY = node:getPosition()
  local size = node:getContentSize()
  if pos then
    size.width = pos[1]
    size.height = pos[2]
  end
  node:pos(orgX + size.width, orgY)
  local actions = {}
  if 0 < delay then
    actions[#actions + 1] = cc.DelayTime:create(delay)
  end
  if not fadeOut and not ignore then
    node:setOpacity(0)
    actions[#actions + 1] = cc.Spawn:create(cc.FadeIn:create(time), cc.MoveTo:create(time, cc.p(orgX, orgY)))
  elseif fadeOut and not ignore then
    actions[#actions + 1] = cc.Spawn:create(cc.FadeOut:create(time), cc.MoveTo:create(time, cc.p(orgX, orgY)))
  else
    actions[#actions + 1] = cc.MoveTo:create(time, cc.p(orgX, orgY))
  end
  if ease then
    actions[#actions] = cc.EaseQuarticActionOut:create(actions[#actions])
  end
  node:runAction(transition.sequence(actions))
end

function UIHelper.MoveToRight(params)
  local delay = params.delay or 0
  local time = params.time or 0.5
  local node = params.node
  local fadeOut = params.fadeOut or false
  local ignore = params.ignore or false
  local ease = params.ease
  local pos = params.pos
  local orgX, orgY = node:getPosition()
  local size = node:getContentSize()
  if pos then
    size.width = pos[1]
    size.height = pos[2]
  end
  node:pos(orgX - size.width, orgY)
  local actions = {}
  if 0 < delay then
    actions[#actions + 1] = cc.DelayTime:create(delay)
  end
  if not fadeOut and not ignore then
    node:setOpacity(0)
    actions[#actions + 1] = cc.Spawn:create(cc.FadeIn:create(time), cc.MoveTo:create(time, cc.p(orgX, orgY)))
  elseif fadeOut and not ignore then
    actions[#actions + 1] = cc.Spawn:create(cc.FadeOut:create(time), cc.MoveTo:create(time, cc.p(orgX, orgY)))
  else
    actions[#actions + 1] = cc.MoveTo:create(time, cc.p(orgX, orgY))
  end
  if ease then
    actions[#actions] = cc.EaseQuarticActionOut:create(actions[#actions])
  end
  node:runAction(transition.sequence(actions))
end

function UIHelper.MoveToDownRight(params)
  local delay = params.delay or 0
  local time = params.time or 0.5
  local node = params.node
  local fadeOut = params.fadeOut or false
  local ignore = params.ignore or false
  local ease = params.ease
  local pos = params.pos
  local orgX, orgY = node:getPosition()
  local size = node:getContentSize()
  if pos then
    size.width = pos[1]
    size.height = pos[2]
  end
  node:pos(orgX - size.width, orgY + size.height)
  local actions = {}
  if 0 < delay then
    actions[#actions + 1] = cc.DelayTime:create(delay)
  end
  if not fadeOut and not ignore then
    node:setOpacity(0)
    actions[#actions + 1] = cc.Spawn:create(cc.FadeIn:create(time), cc.MoveTo:create(time, cc.p(orgX, orgY)))
  elseif fadeOut and not ignore then
    actions[#actions + 1] = cc.Spawn:create(cc.FadeOut:create(time), cc.MoveTo:create(time, cc.p(orgX, orgY)))
  else
    actions[#actions + 1] = cc.MoveTo:create(time, cc.p(orgX, orgY))
  end
  if ease then
    actions[#actions] = cc.EaseQuarticActionOut:create(actions[#actions])
  end
  node:runAction(transition.sequence(actions))
end

function UIHelper.getMaxLoveBreak(heroType)
  for id, data in pairs(storyBookCsv[2]) do
    if data.style == heroType then
      local bookSet = game.role.storyBook["2"] or {}
      local heroStoryData = bookSet[tostring(id)]
      if heroStoryData then
        return heroStoryData.loveBreak, heroStoryData.love
      end
    end
  end
  return 0, 0
end

function UIHelper.showRewardView(params)
  local sender = params.sender
  local pos = params.pos or {0, 0}
  local scale = params.scale or 1
  local items = params.itemStr:toTableArray()
  local senderSize = sender:getContentSize()
  local bgColor = params.bgColor or cc.c3b(255, 255, 255)
  local opacity = params.opacity or 0
  local layer = UIHelper.extend(ccui.Layout:create())
  layer:size(display.width, display.height)
  layer:addTo(display.getRunningScene(), POPUP_LAYER_ORDER)
  layer:setBackGroundColor(bgColor)
  layer:setBackGroundColorType(1)
  layer:setBackGroundColorOpacity(opacity)
  layer:setCallback(function(sender)
    layer:removeFromParent()
  end)
  local localPos = {
    x = sender:getPositionX(),
    y = sender:getPositionY()
  }
  local worldPos = sender:convertToWorldSpace(localPos)
  local bgSize = cc.size(452, 122)
  if 5 < #items then
    bgSize.width = bgSize.width + (#items - 5) * 100 * scale
  end
  local bg = display.newScale9Sprite(GlobalRes .. "reward_view_bg.png", 0, 0, bgSize)
  worldPos.x = worldPos.x + pos[1] + senderSize.width / 2
  worldPos.y = worldPos.y + pos[2] + senderSize.height + bgSize.height / 2
  local minX, maxX = bgSize.width / 2, display.width - bgSize.width / 2
  local maxY = display.height - bgSize.height / 2
  worldPos.x = math.min(worldPos.x, maxX)
  worldPos.x = math.max(worldPos.x, minX)
  worldPos.y = math.min(worldPos.y, maxY)
  bg:pos(worldPos.x, worldPos.y):addTo(layer)
  local xPos, yPos = bgSize.width / 2 - (#items - 1) / 2 * 100 * scale, bgSize.height / 2 + 5
  for index, item in ipairs(items) do
    ItemIcon.new({
      type = tonumber(item[1]),
      count = tonumber(item[2]),
      showTip = true
    }):pos(xPos + (index - 1) * 100 * scale, yPos):scale(scale):addTo(bg)
  end
end

function UIHelper.createTowerFloor(floorData, floorId)
  local btn = UIHelper.newImageView(string.format("%sbtn_%d.png", TowerRes, floorData.type))
  MRichText.new({
    text = floorId,
    size = 22,
    color = UIHelper.hex2rgb("#4f1e05")
  }):anch(0.5, 1):pos(54, 208):addTo(btn)
  if floorData.backup then
    local heroSet = BackUpCsv[floorData.backup]
    local bg = display.newSprite(TowerRes .. "head_bg.png"):scale(0.5):pos(54, 195):addTo(btn)
    display.newSprite(HeadpicCsv[heroSet.headIconTag].res):center(bg):addTo(bg)
    display.newSprite(HeadframCsv[heroSet.headFrameTag].res):center(bg):addTo(bg)
    MRichText.new({
      text = heroSet.name,
      size = 16,
      color = UIHelper.hex2rgb("#4f1e05"),
      maxWidth = 20
    }):anch(0.5, 1):pos(53, 162):addTo(btn)
  elseif floorData.member then
    local member = json.decode(floorData.member)
    local head = display.newSprite(HeadpicCsv[member.headIconTag].res):scale(0.5):pos(54, 195):addTo(btn)
    display.newSprite(HeadframCsv[member.headFrameTag].res):center(head):addTo(head)
    MRichText.new({
      text = member.name,
      size = 16,
      color = UIHelper.hex2rgb("#4f1e05"),
      maxWidth = 20
    }):anch(0.5, 1):pos(53, 162):addTo(btn)
  else
    local data = MonsterCsv[floorData.id]
    MRichText.new({
      text = data.desc,
      size = 16,
      color = UIHelper.hex2rgb("#4f1e05"),
      maxWidth = 20
    }):anch(0.5, 1):pos(53, 177):addTo(btn)
  end
  if floorId < game.role.towerData.floorId then
    local index = (floorData.type == 1 or floorData.type == 3) and floorData.type or 2
    display.newSprite(TowerRes .. string.format("btn_%d_mask.png", index)):anch(0.5, 1):pos(54, 237):addTo(btn)
    display.newSprite(TowerRes .. "image_sheng.png"):pos(54, 10):addTo(btn):name("sheng")
  end
  return btn
end

function UIHelper.setMaxWidth(label, maxwidth)
  if not label then
    return
  end
  maxwidth = maxwidth or 9999
  local width = label:getContentSize().width
  label:setScaleX(1)
  if maxwidth < width then
    label:setScaleX(maxwidth / width)
  end
end

function UIHelper.showRewardItem(items)
  local cx, cy, width, height = display.cx, display.cy, display.width, display.height
  if UIHelper.isiPhoneX() then
    local movex = UIHelper.getMoveXForX(true)
    cx, cy, width = cx + movex, cy, width + movex * 2
  end
  local mask = UIHelper.newMask({
    size = cc.size(width, height),
    color = "#000000",
    opacity = 110
  })
  mask:anch(0.5, 0.5):pos(cx, cy):addTo(display.getRunningScene(), 100)
  mask:setTouchEnabled(true)
  mask:setCallback(function()
    mask:removeSelf()
  end)
  local bg = UIHelper.newImageView(GlobalRes .. "reward_bg.png"):pos(width / 2, height / 2):addTo(mask)
  bg:setCallback(function()
    return
  end)
  local list = ccui.ListView:create()
  list:size(cc.size(646, 380)):anch(0, 1):pos(20, 396):addTo(bg)
  list:setInnerContainerSize(cc.size(600, 518))
  list:setBounceEnabled(true)
  local rewardItems = {}
  for _, gift in ipairs(items.itemLeft) do
    local giftData = gift:toArray("=", true)
    table.insert(rewardItems, {
      itemId = giftData[1],
      count = giftData[2],
      tag = 0
    })
  end
  for _, gift in ipairs(items.itemGot) do
    local giftData = gift:toArray("=", true)
    table.insert(rewardItems, {
      itemId = giftData[1],
      count = giftData[2],
      tag = -1
    })
  end
  local cellSize = cc.size(646, 108)
  local interval = 106
  for row = 1, math.ceil(#rewardItems / 6) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cellSize):addTo(list)
    for i = 1, 6 do
      local index = (row - 1) * 6 + i
      if index > #rewardItems then
        break
      end
      local itemData = rewardItems[index]
      local icon = ItemIcon.new({
        type = itemData.itemId,
        count = itemData.count,
        showTip = true
      }):anch(0, 0.5):pos(10 + (i - 1) * interval, 54):addTo(viewNode)
      if itemData.tag ~= 0 then
        display.newSprite(GlobalRes .. "got_mask.png"):anch(0.5, 0):pos(48, 5):addTo(icon)
      end
    end
  end
  list:doLayout()
  return mask
end

function UIHelper.getOperationDayStartTime(currentTime)
  currentTime = currentTime or game:nowTime()
  local operationHour = 4
  local timeTable = os.date("*t", currentTime)
  if operationHour > timeTable.hour then
    timeTable.day = timeTable.day - 1
  end
  timeTable.hour = operationHour
  timeTable.min = 0
  timeTable.sec = 0
  return os.time(timeTable)
end

return UIHelper
