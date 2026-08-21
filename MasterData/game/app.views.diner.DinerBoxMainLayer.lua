local ItemCsv = require("csvdata.item")
local ThemeCsv = require("csvdata.diner_box")
local FitmentCsv = require("csvdata.diner_fitment")
local BoxMainRes = "ui/diner/box/"
local RewardRes = "ui/common/reward/"
local channelConfigs = require("sdk.ChannelConfigs")
local config = channelConfigs[CHANNEL_KEY]
local uiData = {
  csbFile = "ui/diner/DinerBoxMainLayer.csb",
  widgets = {
    content = "content",
    homeBg = "homeBg",
    btnHome = "homeBg/btnHome",
    btnName = "homeBg/btnName",
    name = "homeBg/name",
    mainBgNode = "mainBgNode",
    comfortBg = "comfortBg",
    comfort = "comfortBg/comfort",
    num = "comfortBg/num",
    panel = "panel",
    mask = "mask",
    list = "panel/list",
    btnLeft1 = "panel/btnLeft1",
    btnLeft2 = "panel/btnLeft2",
    btnLeft3 = "panel/btnLeft3",
    btnLeft4 = "panel/btnLeft4",
    btnRight1 = "panel/btnRight1",
    btnRight2 = "panel/btnRight2",
    btnRight3 = "panel/btnRight3",
    btnBack = "btnBack",
    btnRank = "btnRank",
    btnDraw = "btnDraw",
    btnShop = "btnShop",
    btnHero = "btnHero",
    btnStore = "btnStore",
    btnShare = "btnShare",
    btnFriend = "btnFriend",
    btnChange = "btnChange"
  }
}
local leftBtns = {
  [1] = {
    name = "便当盒",
    func = function(self)
      self:showTheme()
    end
  },
  [2] = {
    name = "家具",
    func = function(self)
      self:showFits()
    end
  },
  [3] = {
    name = "墙饰",
    func = function(self)
      self:showWalls()
    end
  },
  [4] = {
    name = "地毯",
    func = function(self)
      self:showRugs()
    end
  }
}
local rightBtns = {
  [1] = {
    name = "清空",
    func = function(self)
      self:showClear()
    end
  },
  [2] = {
    name = "取消",
    func = function(self)
      self:showCancel()
    end
  },
  [3] = {
    name = "保存",
    func = function(self)
      self:showSave()
    end
  }
}
local TYPE_THEME = 1
local TYPE_FITS = 2
local TYPE_WALLS = 3
local TYPE_RUGS = 4
local DinerBoxMainLayer = class("DinerBoxMainLayer", UIBase)

function DinerBoxMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function DinerBoxMainLayer:init(params)
  local spine = UIHelper.createSpineNodeByRes("diner/box/bdh_bg")
  spine:pos(0.5, 0.5):addTo(self.mainBgNode)
  spine:setAnimation(0, "special", true)
  local size = cc.size(display.width, display.height)
  if UIHelper.isiPhoneX() then
    size = cc.size(1386, 640)
    UIHelper.fitForiPhoneX(self.mask, true)
    self.comfortBg:setPositionX(self.comfortBg:getPositionX() - 75)
    self.btnRank:setPositionX(self.btnRank:getPositionX() - 75)
    self.btnDraw:setPositionX(self.btnDraw:getPositionX() - 75)
    self.btnShop:setPositionX(self.btnShop:getPositionX() - 75)
    self.homeBg:setPositionX(self.homeBg:getPositionX() - UIHelper.getMoveXForX())
    self.content:setPositionX(self.content:getPositionX() - UIHelper.getMoveXForX())
    self.mainBgNode:setPositionX(self.mainBgNode:getPositionX() - UIHelper.getMoveXForX())
    self.btnBack:setPositionX(self.btnBack:getPositionX() + UIHelper.getMoveXForX())
    self.btnHero:setPositionX(self.btnHero:getPositionX() + UIHelper.getMoveXForX())
    self.btnStore:setPositionX(self.btnStore:getPositionX() + UIHelper.getMoveXForX())
    self.btnShare:setPositionX(self.btnShare:getPositionX() + UIHelper.getMoveXForX())
    self.btnChange:setPositionX(self.btnChange:getPositionX() + UIHelper.getMoveXForX())
    self.btnFriend:setPositionX(self.btnFriend:getPositionX() + UIHelper.getMoveXForX())
  end
  self.mask:setTouchEnabled(true)
  self.mask:setSwallowTouches(true)
  params = params or {}
  self.nameState = false
  self.isChange = false
  self.curBox = params.boxId or 1
  self.curType = TYPE_FITS
  self.themeId = 0
  self.otherUsingFit = {}
  self.otherUsingTheme = {}
  local Names = {
    "btnHome",
    "btnBack",
    "btnDraw",
    "btnShop",
    "btnHero",
    "btnStore",
    "btnShare",
    "btnChange",
    "btnRank",
    "btnFriend"
  }
  for _, name in pairs(Names) do
    self[name]:setTouchScale()
  end
  self.group = MRadioGroup:create()
  for index, data in ipairs(leftBtns) do
    local btn = self["btnLeft" .. index]
    btn:name("btn" .. index)
    btn:setGroup(self.group)
    btn:setCallback(function()
      self.curType = index
      data.func(self)
    end)
    display.newTTFLabel({
      text = data.name,
      size = 24
    }):enableOutline(UIHelper.hex2rgb("#9c3a13"), 1):pos(59, 19):addTo(btn)
  end
  for index, data in ipairs(rightBtns) do
    local btn = self["btnRight" .. index]
    btn:setCallback(function()
      data.func(self)
    end)
    display.newTTFLabel({
      text = data.name,
      size = 20
    }):enableOutline(UIHelper.hex2rgb("#9c3a13"), 1):pos(45, 24):addTo(btn)
  end
  self.handlers = {}
  self.btns = {}
  table.insert(self.handlers, game.role:addEventListener("notifyNewMessage", function(event)
    if event.type == "box" then
      self:updateRed()
    end
  end))
  self:updateRed()
  self.btnHome:setCallback(function()
    game:enterScene("MainScene")
  end)
  self.btnBack:setCallback(function()
    BackManager:pop()
  end)
  self.btnName:setCallback(function()
    if self.isChange then
      SysError(SYS_ERR_DINER_BOX_IS_CHANGING)
      return
    end
    self:showSelectBox()
  end)
  self.homeBg:setCallback(function()
    if self.isChange then
      SysError(SYS_ERR_DINER_BOX_IS_CHANGING)
      return
    end
    self:showSelectBox()
  end)
  self.comfortBg:setCallback(function()
    local boxData = ThemeCsv[self.themeId][game.role.boxLevel]
    game:createView("diner.DinerTalentLayer", {
      boxData = boxData,
      comfort = self.boxLogic:getHotPoint()
    })
  end)
  self.btnChange:setCallback(function()
    self.curType = TYPE_FITS
    self.group:chooseByName("btn" .. self.curType)
    self:showPanel()
    self:showFits()
  end)
  self.btnHero:setCallback(function()
    game:createView("diner.DinerBoxHerosLayer", {
      boxId = self.curBox,
      callback = function()
        self:showData()
      end
    })
  end)
  self.btnShop:setCallback(function()
    local layer = game:createView("shop.ShopLayer", {curType = 2, selected = 3})
    BackManager:push(function()
      TopBar:hide()
      layer:close()
    end)
  end)
  self.btnStore:setCallback(function()
    local layer = game:createView("diner.DinerBoxFitmentLayer", {})
    BackManager:push(function()
      layer:close()
    end)
  end)
  self.btnShare:setCallback(function()
    self.btnShare:setTouchEnabled(false)
    self.btnShare:runAction(transition.sequence({
      cc.DelayTime:create(0.2),
      cc.CallFunc:create(function()
        self.btnShare:setTouchEnabled(true)
      end)
    }))
    local path = self:getShareScreen()
    local content = "#料理次元#全新版本——“美味满屋”来袭！各位主厨，请在自己设计的便当盒中，与食灵们共度甜蜜的时光吧~"
    umeng.shareContent({content = content, image = path})
  end)
  self.btnDraw:setCallback(function()
    local layer = game:createView("diner.DinerDrawLayer")
    self:hide()
    BackManager:push(function()
      TopBar:hide()
      self:show()
      layer:close()
    end)
  end)
  if not config.showShare then
    self.btnShare:hide()
  end
  self.btnRank:setCallback(function()
    game:sendData(actionCodes.Diner_comfortRankRpc, MsgPack.pack({}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Diner_comfortRankRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      game:createView("diner.DinerBoxRankLayer", {
        rankList = msg.list
      })
    end)
  end)
  self.btnFriend:setCallback(function()
    game:createView("diner.DinerBoxFriendLayer")
  end)
  self.scrollView = cc.ScrollView:create()
  self.scrollView:setViewSize(size)
  self.scrollView:addTo(self.content)
  self.scrollView:setBounceable(false)
  self.scrollView:setMaxScale(1.5)
  self.scrollView:setMinScale(0.6)
  self:updateOtherUseFits()
  UIHelper.showPageGuide(10020)
end

function DinerBoxMainLayer:showData(params)
  params = params or {}
  self.scrollView:getContainer():removeAllChildren()
  local boxData = params.boxData or json.decode(clone(game.role.diner["box" .. self.curBox])) or {}
  self.themeId = boxData.box or 0
  self.boxLogic = game:createView("diner.DinerBoxLogic", {
    boxData = boxData,
    content = self.scrollView,
    boxId = self.curBox,
    isShowReward = true,
    callback = function()
      self:updateConfort()
      leftBtns[self.curType].func(self)
    end
  })
  self.boxLogic:addTo(self.scrollView:getContainer())
  local size = self.boxLogic:getContentSize()
  self.scrollView:setContentSize(size)
  self.scrollView:setContentOffset(cc.p(-size.width / 2 * self.scrollView:getZoomScale() + display.width / 2, -size.height / 2 * self.scrollView:getZoomScale() + display.height / 2))
  self.num:setString(0)
  if self.themeId ~= 0 then
    local hot = self.boxLogic:getHotPoint()
    local boxData = ThemeCsv[self.themeId][game.role.boxLevel]
    for index, data in ipairs(boxData.talent:toTableArray()) do
      if hot >= tonumber(data[1]) then
        self.num:setString(index)
      end
    end
  end
  self.name:setString("便当盒" .. self.curBox)
  self:updateConfort()
end

function DinerBoxMainLayer:getShareScreen()
  local path = "shareScreen.png"
  local renderTexture = cc.RenderTexture:create(display.width, display.height)
  renderTexture:begin()
  self.mainBgNode:visit()
  self.scrollView:getContainer():visit()
  local ma = display.newSprite(RewardRes .. "right_info.png"):anch(0, 0):pos(10, 20)
  local info = display.newSprite(RewardRes .. "left_info.png"):anch(0, 0):pos(ma:getContentSize().width, 0):addTo(ma)
  game.serverInfo = game.serverInfo or {}
  display.newTTFLabel({
    text = "服务器: " .. (game.serverInfo.name or ""),
    size = 18,
    color = UIHelper.hex2rgb("#ffffff")
  }):anch(0, 0.5):pos(2, 63):addTo(info):enableOutline(UIHelper.hex2rgb("#000000"), 1)
  display.newTTFLabel({
    text = game.role.level,
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  }):anch(0, 0.5):pos(35, 39):addTo(info):enableOutline(UIHelper.hex2rgb("#000000"), 1)
  display.newTTFLabel({
    text = game.role.name,
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  }):anch(0, 0.5):pos(2, 17):addTo(info):enableOutline(UIHelper.hex2rgb("#000000"), 1)
  ma:visit()
  renderTexture:endToLua()
  if renderTexture:saveToFile(path, kCCImageFormatPNG) then
    return string.gsub(device.writablePath, "[\\\\/]+$", "") .. device.directorySeparator .. path
  end
end

function DinerBoxMainLayer:showTheme()
  self:refreshContent(TYPE_THEME)
end

function DinerBoxMainLayer:showFits()
  self:refreshContent(TYPE_FITS)
end

function DinerBoxMainLayer:showWalls()
  self:refreshContent(TYPE_WALLS)
end

function DinerBoxMainLayer:showRugs()
  self:refreshContent(TYPE_RUGS)
end

function DinerBoxMainLayer:showClear()
  self.boxLogic:cleanBox()
  leftBtns[self.curType].func(self)
end

function DinerBoxMainLayer:showCancel()
  self:showData()
  self:closePanel()
end

function DinerBoxMainLayer:showSave()
  local boxData = self.boxLogic:getBoxData()
  boxData.slot = self.curBox
  game:sendData(actionCodes.Diner_saveBoxFitmentRpc, MsgPack.pack(boxData))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Diner_saveBoxFitmentRpc, function(event)
    UIHelper.removeWaiting()
    self:showData()
    self:closePanel()
  end)
end

function DinerBoxMainLayer:refreshContent(type)
  if self.refreshHandler then
    scheduler.unscheduleGlobal(self.refreshHandler)
  end
  self.curNum = 0
  self.showList = {}
  self.list:removeAllChildren()
  if type == TYPE_THEME then
    local stash
    for themeId, _ in pairs(game.role.diner.item_box) do
      local boxId = self.otherUsingTheme[themeId]
      local temp = clone(ThemeCsv[themeId][game.role.boxLevel])
      temp.parent = boxId
      if temp.id == self.themeId then
        stash = temp
      else
        table.insert(self.showList, temp)
      end
    end
    table.sort(self.showList, function(a, b)
      local parentA = (a.parent and 1 or 0) * 1000
      local parentB = (b.parent and 1 or 0) * 1000
      return parentA + a.id < parentB + b.id
    end)
    table.insert(self.showList, 1, stash)
    self.refreshHandler = scheduler.scheduleGlobal(function()
      self:refreshListWithDelay()
    end, 0.016666666666666666)
    return
  end
  for fitId, count in pairs(game.role.diner.item_fitment) do
    local themeUseCount = self.boxLogic:getItemCount(fitId)
    if FitmentCsv[fitId].type == type and count > themeUseCount + self.otherUsingFit[fitId] then
      local temp = clone(FitmentCsv[fitId])
      temp.themeUseCount = themeUseCount
      temp.allCount = count
      table.insert(self.showList, temp)
    end
  end
  table.sort(self.showList, function(a, b)
    local limitA = a.themeUseCount < a.limit and 0 or 10000000
    local limitB = b.themeUseCount < b.limit and 0 or 10000000
    local boxA = a.box == self.themeId and 0 or 10000 * a.box
    local boxB = b.box == self.themeId and 0 or 10000 * b.box
    return limitA + boxA + a.id < limitB + boxB + b.id
  end)
  self.refreshHandler = scheduler.scheduleGlobal(function()
    self:refreshListWithDelay()
  end, 0.016666666666666666)
end

function DinerBoxMainLayer:refreshListWithDelay()
  local count = table.nums(self.showList)
  if count < self.curNum then
    if self.refreshHandler then
      scheduler.unscheduleGlobal(self.refreshHandler)
      self.refreshHandler = nil
    end
    if count == 0 then
      display.newTTFLabel({
        text = "暂时没有这个类型的物品",
        size = 20,
        color = UIHelper.hex2rgb("#753213")
      }):center(self.list):addTo(self.list)
    end
    self.list:requestDoLayout()
    return
  end
  local cellSize = display.newSprite(BoxMainRes .. "cell.png"):getContentSize()
  local nodeSize = cc.size(cellSize.width + 6, 132)
  for index = self.curNum + 1, self.curNum + 7 do
    if index > count then
      break
    end
    local viewNode = ccui.Widget:create()
    viewNode:size(nodeSize):addTo(self.list)
    local card = self:createCard(self.showList[index]):center(viewNode):addTo(viewNode)
  end
  self.curNum = self.curNum + 7
end

function DinerBoxMainLayer:createCard(data)
  local card = UIHelper.newImageView(BoxMainRes .. "cell.png")
  local itemData = ItemCsv[data.item]
  display.newSprite(itemData.icon):pos(63, 75):addTo(card)
  display.newTTFLabel({
    text = itemData.name,
    size = 20,
    color = UIHelper.hex2rgb("#753613")
  }):pos(61, 14):addTo(card)
  if self.curType == TYPE_THEME then
    if data.id == self.boxLogic:getThemeId() then
      self.themeId = data.id
      self.usingImage = display.newSprite(BoxMainRes .. "use_bg.png"):pos(63, 41):addTo(card)
      display.newTTFLabel({text = "使用中", size = 24}):enableOutline(UIHelper.hex2rgb("#1c8112"), 1):center(self.usingImage):addTo(self.usingImage)
    elseif data.parent then
      image = display.newSprite(BoxMainRes .. "use_bg.png"):pos(63, 41):addTo(card)
      display.newTTFLabel({
        text = string.format("便当盒%d", data.parent),
        size = 24
      }):enableOutline(UIHelper.hex2rgb("#1c8112"), 1):center(image):addTo(image)
    end
    local btnHot = UIHelper.extend(ccui.Button:create())
    btnHot:setImages(BoxMainRes, {
      "btn_hot.png",
      "btn_hot.png"
    })
    btnHot:pos(14, 112):addTo(card)
    btnHot:setTouchScale()
    btnHot:setCallback(function()
      game:createView("diner.DinerTalentLayer", {
        boxId = data.id
      })
    end)
    card:setCallback(function()
      if self.themeId == data.id then
        return
      end
      if data.parent then
        SysError(SYS_ERR_DINER_BOX_THEME_USED)
        return
      end
      self.usingImage:removeSelf()
      self.usingImage = display.newSprite(BoxMainRes .. "use_bg.png"):pos(63, 41):addTo(card)
      display.newTTFLabel({text = "使用中", size = 24}):enableOutline(UIHelper.hex2rgb("#1c8112"), 1):center(self.usingImage):addTo(self.usingImage)
      self:showData({
        boxData = {
          box = data.id
        }
      })
      self.boxLogic:onBoxChange()
    end)
    return card
  end
  display.newTTFLabel({
    text = "满足度+" .. (data.box == self.themeId and data.point2 or data.point1),
    size = 16,
    color = UIHelper.hex2rgb("#65120e")
  }):enableOutline(UIHelper.hex2rgb("#ffffff"), 1):anch(0, 0.5):pos(3, 113):addTo(card)
  if data.themeUseCount >= data.limit then
    display.newSprite(BoxMainRes .. "limit_mask.png"):center(card):addTo(card)
    local bg = display.newSprite(BoxMainRes .. "limit_bg.png"):pos(63, 41):addTo(card)
    display.newTTFLabel({
      text = "已达上限",
      size = 24
    }):enableOutline(UIHelper.hex2rgb("#641393"), 1):center(bg):addTo(bg)
    return card
  end
  local count = data.allCount - self.otherUsingFit[data.id] - data.themeUseCount
  local num = display.newTTFLabel({
    text = "x" .. count,
    size = 30
  }):enableOutline(UIHelper.hex2rgb("#734949"), 1):anch(1, 0.5):pos(120, 39):addTo(card)
  card:setCallback(function()
    self.boxLogic:addItem(data.id)
    self:updateConfort()
    local useCount = self.boxLogic:getItemCount(data.id)
    count = data.allCount - self.otherUsingFit[data.id] - useCount
    if count < 1 or useCount >= data.limit then
      leftBtns[self.curType].func(self)
      return
    end
    num:setString("x" .. count)
  end)
  return card
end

function DinerBoxMainLayer:updateOtherUseFits()
  self.otherUsingFit = {}
  self.otherUsingTheme = {}
  for boxId = 1, game.role.diner.dinerBoxMaxNum do
    if boxId ~= self.curBox then
      local temp = json.decode(game.role.diner["box" .. boxId]) or {}
      for _, data in pairs(temp.fitments or {}) do
        self.otherUsingFit[data.item] = (self.otherUsingFit[data.item] or 0) + 1
      end
      for _, data in pairs(temp.wallItems or {}) do
        self.otherUsingFit[data.item] = (self.otherUsingFit[data.item] or 0) + 1
      end
      for _, data in pairs(temp.rugs or {}) do
        self.otherUsingFit[data.item] = (self.otherUsingFit[data.item] or 0) + 1
      end
      if temp.box and temp.box > 0 then
        self.otherUsingTheme[temp.box] = boxId
      end
    end
  end
  for _, fit in pairs(FitmentCsv) do
    if not self.otherUsingFit[fit.id] then
      self.otherUsingFit[fit.id] = 0
    end
  end
end

function DinerBoxMainLayer:updateConfort()
  self.comfort:setString(string.format("满足度:%d", self.boxLogic:getHotPoint()))
end

function DinerBoxMainLayer:showPanel()
  self.isChange = true
  self.btnChange:setTouchEnabled(false)
  self.panel:runAction(transition.sequence({
    cc.MoveTo:create(0.1, cc.p(0, 0)),
    cc.CallFunc:create(function()
      self.boxLogic:onBoxChange()
      self.btnChange:setTouchEnabled(true)
    end)
  }))
end

function DinerBoxMainLayer:closePanel()
  self.boxLogic:onBoxShow()
  self.panel:runAction(transition.sequence({
    cc.MoveTo:create(0.1, cc.p(0, -210)),
    cc.CallFunc:create(function()
      self.isChange = false
    end)
  }))
end

function DinerBoxMainLayer:showSelectBox()
  self.btns = {}
  self.nameState = not self.nameState
  if not self.nameState then
    self.homeBg:removeChildByTag(1000)
    self.btnName:setImage(BoxMainRes .. "image_up.png")
    self.btns = {}
    return
  end
  self.btnName:setImage(BoxMainRes .. "image_down.png")
  local mask = UIHelper.extend(ccui.Layout:create())
  mask:size(1388, display.height)
  mask:setBackGroundColorType(1)
  mask:setBackGroundColor(cc.c3b(0, 0, 0))
  mask:setTouchEnabled(true)
  mask:setSwallowTouches(true)
  mask:setBackGroundColorOpacity(191)
  mask:pos(0, -display.height + 78):addTo(self.homeBg, -1, 1000)
  local xPos = 175
  local yPos = 540
  local delay = 0.1
  local limit = game.role.diner.dinerBoxMaxNum
  for i = 1, globalCsv.dinerBoxNumMax do
    local btn = UIHelper.newImageView(BoxMainRes .. "box_name_bg.png"):pos(xPos, yPos):addTo(mask)
    btn:setLocalZOrder(limit - i)
    btn:setCallback(function()
      if i > limit then
        MDialog:double({
          title = "便当盒扩展",
          text = "这个便当盒位尚未开启，是否前往商城扩展便当盒位？\n（便当盒位不包含便当盒，可去邮购获得便当盒）",
          okCallback = function()
            local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 4})
            BackManager:push(function()
              TopBar:hide()
              layer:close()
              self:updateOtherUseFits()
              self:showSelectBox()
            end)
            return true
          end,
          cancelCallback = function()
            return true
          end
        })
        return
      end
      if self.curBox == i then
        self:showSelectBox()
        return
      end
      local boxData = json.decode(game.role.diner["box" .. i]) or {}
      if not boxData.box or boxData.box < 1 then
        SysError(SYS_ERR_DINER_BOX_NOT_ENOUGH_THEME)
        return
      end
      self.curBox = i
      self.name:setString(string.format("便当盒%d", i))
      self:updateOtherUseFits()
      self:showSelectBox()
      self:showData()
    end)
    if i > limit then
      display.newSprite(BoxMainRes .. "image_lock.png"):pos(31, 27):addTo(btn)
      display.newTTFLabel({
        text = "暂未解锁",
        size = 24,
        color = UIHelper.hex2rgb("#986339")
      }):center(btn):addTo(btn)
    else
      local bShow = checkbool(game.role.redPoints.box and game.role.redPoints.box[i])
      UIHelper.showRedPoint(btn, bShow, cc.p(12, 6), 0.8)
      self.btns[i] = btn
      display.newTTFLabel({
        text = string.format("便当盒%d", i),
        size = 24,
        color = UIHelper.hex2rgb("#440b0b")
      }):center(btn):addTo(btn)
    end
    UIHelper.MoveToDownRight({
      node = btn,
      time = 0.15,
      delay = delay,
      pos = {
        10 < i and 220 or 0,
        56 * ((i - 1) % 10 + 1)
      }
    })
    delay = delay + 0.15
    yPos = yPos - 56
    if i == 10 then
      xPos = xPos + 220
      yPos = 540
    end
  end
end

function DinerBoxMainLayer:updateRed()
  if not game.role.redPoints.box then
    return
  end
  for boxId, btn in pairs(self.btns) do
    local bShow = checkbool(game.role.redPoints.box[boxId])
    UIHelper.showRedPoint(btn, bShow, cc.p(12, 6), 0.8)
  end
  UIHelper.showRedPoint(self.btnName, checkbool(next(game.role.redPoints.box or {})), cc.p(7, 7), 0.6)
end

function DinerBoxMainLayer:onEnter()
  _G.touchMaskEnabled = false
end

function DinerBoxMainLayer:onExit()
  _G.touchMaskEnabled = true
  if self.refreshHandler then
    scheduler.unscheduleGlobal(self.refreshHandler)
  end
end

function DinerBoxMainLayer:onExit()
  for _, tag in pairs(self.handlers) do
    game.role:removeEventListener(tag)
  end
end

return DinerBoxMainLayer
