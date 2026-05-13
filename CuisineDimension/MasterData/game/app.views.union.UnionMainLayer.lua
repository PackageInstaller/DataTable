local ItemCsv = require("csvdata.item")
local MainRes = "ui/union/main/"
local uiData = {
  csbFile = "ui/union/UnionMainLayer.csb",
  widgets = {
    mainBg = "mainBg",
    btnsBg = "btnsBg",
    up = "up",
    mask = "mask",
    btnList = "btnsBg/btnList",
    list = "panel/list",
    extra = "panel/extra",
    rightBg = "panel/extra/rightBg",
    btnSearch = "panel/extra/btnSearch",
    btnRefresh = "panel/extra/btnRefresh"
  }
}
local btnsData = {
  [1] = {
    name = "协会预览"
  },
  [2] = {
    name = "系统推荐"
  },
  [3] = {
    name = "协会广告"
  }
}
local UnionMainLayer = class("UnionMainLayer", UIBase)

function UnionMainLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function UnionMainLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
    UIHelper.fitForiPhoneX(self.up, true)
    self.btnsBg:setPositionX(self.btnsBg:getPositionX() - 75)
  end
  TopBar:show(TopBarType.full, "协会")
  TopBar:showAnimation(true)
  UIHelper.MoveToDown({
    node = self.up
  })
  local renameId, renameCount = globalCsv.UnionCreateCost:match("(%d+)=(%d+)")
  local costId = tonumber(renameId)
  local countBg = UIHelper.newImageView("ui/kitchen/cook/paper_bg.png"):pos(0, 0):addTo(self.btnsBg)
  local countLab = display.newTTFLabel({
    text = game.role.items[costId] or 0,
    size = 22
  }):pos(104, 17):addTo(countBg)
  display.newSprite(ItemCsv[costId].icon):scale(0.7):pos(17, 18):addTo(countBg)
  countBg:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = countBg,
      itemType = costId,
      itemData = ItemCsv[costId]
    })
  end)
  self.selectType = 1
  self.listData = game.role.unionListData or {}
  self.lastRequestTimes = {}
  self.delayTimes = {
    300,
    60,
    60
  }
  self.group = MRadioGroup:create()
  local btnSize = display.newSprite("ui/hero/taocan_1.png"):getContentSize()
  local delay = 0.4
  for index, data in ipairs(btnsData) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(btnSize):addTo(self.btnList)
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages("ui/hero/", {
      "taocan_1.png",
      "taocan_2.png"
    })
    btn:center(viewNode):addTo(viewNode)
    btn:setString({
      text = data.name,
      size = 20
    })
    btn:setCascadeOpacityEnabled(true)
    btn:setCallback(function()
      self.selectType = index
      self:showData()
    end)
    btn:setName(string.format("name%d", index))
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#630c07"), 1)
    UIHelper.makeFontClear(btn, "button")
    btn:setGroup(self.group)
    if self.listData[index] then
      self.lastRequestTimes[index] = game:nowTime()
    else
      self.listData[index] = {}
    end
    UIHelper.MoveToRight({
      node = btn,
      delay = delay,
      time = 0.18
    })
    delay = delay + 0.1
  end
  self.group:chooseByName("name" .. self.selectType)
  local btnCreate = UIHelper.extend(ccui.Button:create())
  btnCreate:setImages(MainRes, {
    "btn_create.png",
    "btn_create.png"
  })
  btnCreate:pos(60, 60):addTo(self.btnsBg)
  btnCreate:setCallback(function()
    local layer = game:createView("union.UnionCreateLayer")
    BackManager:push(function()
      layer:close()
      if game.role.union ~= 0 then
        game:enterScene("MainScene", {layer = "union"})
      end
    end)
  end)
  display.newTTFLabel({
    text = "创建\n协会",
    size = 26
  }):enableOutline(UIHelper.hex2rgb("#8a450e"), 1):setLineSpacing(-7):pos(50, 43):addTo(btnCreate)
  local userInput = ccui.EditBox:create(cc.size(290, 26), "ui/friend/main/text_bg.png")
  userInput:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
  userInput:setFontSize(20)
  userInput:setMaxLength(16)
  userInput:setPlaceHolder("请输入协会ID或者名称")
  userInput:setPlaceholderFontSize(20)
  userInput:setPlaceholderFontColor(UIHelper.hex2rgb("#86522a"))
  userInput:center(self.rightBg):addTo(self.rightBg)
  userInput:setFontColor(UIHelper.hex2rgb("#dea826"))
  self.btnSearch:setTouchScale()
  self.btnSearch:setCallback(function()
    local str = userInput:getText()
    if str == "" then
      return
    end
    if type(tonumber(str)) ~= "number" then
      local len = self:getLength(self:stringToTab(str))
      if len == 0 then
        SysError(SYS_ERR_UNION_INPUT_NOT_NULL)
        return
      end
      local chars = MRichText:stringToChars(str)
      for _, char in ipairs(chars) do
        if not char:isNormalWords() then
          SysError(SYS_ERR_UNION_INPUT_ILLEGAL)
          return
        end
      end
    end
    game:sendData(actionCodes.Union_searchUnionRpc, MsgPack.pack({str = str}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Union_searchUnionRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      if msg.code then
        SysError(msg.code)
        return
      end
      local layer = game:createView("union.UnionSearchLayer", {
        data = msg.result,
        callback = function()
          BackManager:pop()
          self:sendData(msg.result)
        end
      })
      BackManager:push(function()
        layer:close()
      end)
    end)
  end)
  self.btnRefresh:setTouchScale()
  self.btnRefresh:setCallback(function()
    if self.selectType == 1 then
      return
    end
    self.lastRequestTimes[self.selectType] = 0
    self:showData()
  end)
  local renameId, renameCount = globalCsv.UnionCreateCost:match("(%d+)=(%d+)")
  local costId = tonumber(renameId)
  local countBg = UIHelper.newImageView("ui/kitchen/cook/paper_bg.png"):pos(940, 576):addTo(self.btnsBg)
  local countLab = display.newTTFLabel({
    text = game.role.items[costId] or 0,
    size = 22
  }):pos(104, 17):addTo(countBg)
  display.newSprite(ItemCsv[costId].icon):scale(0.6):pos(17, 18):addTo(countBg)
  countBg:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = countBg,
      itemType = costId,
      itemData = ItemCsv[costId]
    })
  end)
  self.mask:setTouchEnabled(true)
  self.mask:setSwallowTouches(true)
  self.mask:hide()
end

function UnionMainLayer:showData(params)
  if self.refreshHandler then
    scheduler.unscheduleGlobal(self.refreshHandler)
  end
  self.createIdx = 0
  self.btnRefresh:setVisible(self.selectType ~= 1)
  if game:nowTime() - (self.lastRequestTimes[self.selectType] or 0) > self.delayTimes[self.selectType] then
    if self.selectType == 1 then
      game:sendData(actionCodes.Union_unionsListRpc, MsgPack.pack({}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Union_unionsListRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        self:initData(msg.result)
      end)
    elseif self.selectType == 2 then
      game:sendData(actionCodes.Union_randomListRpc, MsgPack.pack({}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Union_randomListRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        self:initData(msg.result)
      end)
    else
      game:sendData(actionCodes.Union_randomListRpc, MsgPack.pack({ad = true}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Union_randomListRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        self:initData(msg.result)
      end)
    end
  else
    self.list:removeAllChildren()
    self.refreshHandler = scheduler.scheduleGlobal(function()
      self:showList()
    end, 0.016666666666666666)
  end
end

function UnionMainLayer:initData(list)
  if self.selectType == 1 then
    table.sort(list, function(a, b)
      local factorA = a.level * 10000000 + a.score
      local factorB = b.level * 10000000 + b.score
      if factorA == factorB then
        return a.createTime < b.createTime
      end
      return factorA > factorB
    end)
  end
  self.listData[self.selectType] = list
  self.lastRequestTimes[self.selectType] = game:nowTime()
  self.list:removeAllChildren()
  self.refreshHandler = scheduler.scheduleGlobal(function()
    self:showList()
  end, 0.016666666666666666)
end

function UnionMainLayer:showList()
  for row = self.createIdx + 1, self.createIdx + 10 do
    if row > #self.listData[self.selectType] then
      if self.refreshHandler then
        scheduler.unscheduleGlobal(self.refreshHandler)
        self.refreshHandler = nil
      end
      if not next(self.listData[self.selectType]) then
        local bg = display.newSprite("ui/hero/tip_bg.png"):center(self.list):addTo(self.list)
        display.newTTFLabel({
          text = "暂时没有数据",
          size = 26,
          color = UIHelper.hex2rgb("#842c17")
        }):pos(395, 120):addTo(bg)
      end
      self.list:requestDoLayout()
      self.list:jumpToTop()
      return
    end
    self.data = self.listData[self.selectType][row]
    if self.data then
      self:createCell(self.data)
    end
  end
  self.createIdx = self.createIdx + 10
end

function UnionMainLayer:createCell(data)
  local viewNode = ccui.Widget:create()
  viewNode:setContentSize(cc.size(912, 130)):addTo(self.list)
  local cell = display.newSprite(MainRes .. "cell.png"):center(viewNode):addTo(viewNode)
  local iconBg = display.newSprite(MainRes .. string.format("icon_bg_%d.png", data.headId)):pos(56, 63):addTo(cell)
  display.newSprite(MainRes .. string.format("icon_%d.png", data.headId)):scale(0.75):pos(53, 53):addTo(iconBg)
  display.newTTFLabel({text = "Lv:", size = 30}):enableOutline(UIHelper.hex2rgb("#4a1406"), 2):anch(0, 0.5):pos(120, 87):addTo(cell)
  display.newTTFLabel({
    text = data.level,
    size = 30,
    color = UIHelper.hex2rgb("#f3db0c")
  }):enableOutline(UIHelper.hex2rgb("#4a1406"), 2):anch(0, 0.5):pos(165, 87):addTo(cell)
  display.newTTFLabel({
    text = data.name,
    size = 28,
    color = UIHelper.hex2rgb("#fdfffa")
  }):enableOutline(UIHelper.hex2rgb("#431b05"), 1):anch(0, 0.5):pos(257, 87):addTo(cell)
  display.newTTFLabel({
    text = data.desc == "" and "無" or data.desc,
    size = 16,
    color = UIHelper.hex2rgb("#fdfffa"),
    dimensions = cc.size(640, 0)
  }):enableOutline(UIHelper.hex2rgb("#e0b03"), 1):anch(0, 0.5):pos(124, 27):addTo(cell)
  local descBg1 = display.newSprite(MainRes .. "cell_desc_bg.png"):anch(0, 0.5):pos(600, 100):addTo(cell)
  local descBg2 = display.newSprite(MainRes .. "cell_desc_bg.png"):anch(0, 0.5):pos(600, 70):addTo(cell)
  display.newTTFLabel({
    text = string.format("Lv%d以上", data.limit),
    size = 20,
    color = UIHelper.hex2rgb("#fdfffa")
  }):enableOutline(UIHelper.hex2rgb("#431b05"), 1):anch(0, 0.5):pos(10, 15):addTo(descBg1)
  display.newTTFLabel({
    text = string.format("成员: %d/%d", data.had, CommonHelper.getUnionMemberMax(data.level, data.unionTech)),
    size = 20,
    color = UIHelper.hex2rgb("#fdfffa")
  }):enableOutline(UIHelper.hex2rgb("#431b05"), 1):anch(0, 0.5):pos(10, 15):addTo(descBg2)
  local btnApply = UIHelper.extend(ccui.Button:create())
  btnApply:setImages(MainRes, {
    "btn_apply.png",
    "btn_apply.png"
  })
  btnApply:pos(855, 63):addTo(cell)
  btnApply:setCallback(function()
    self:sendData(data)
  end)
  display.newTTFLabel({text = "申请", size = 28}):enableOutline(UIHelper.hex2rgb("#431b05"), 1):pos(45, 48):addTo(btnApply)
end

function UnionMainLayer:sendData(union)
  local layer = game:createView("union.UnionDeclarationLayer", {
    callback = function(descStr)
      if game.role.union ~= 0 then
        SysError(SYS_ERR_UNION_CREATE_IN_UNION)
        return
      end
      if game.role.unionTimes ~= nil and game.role.unionTimes >= 2 and game:nowTime() - game.role.unionTime < 86400 then
        SysError(SYS_ERR_UNION_APPLY_IN_WAITING_TIME)
        return
      end
      if game.role.level < tonumber(union.limit) then
        SysError(SYS_ERR_UNION_APPLY_CONDITION_FAILED)
        return
      end
      if union.had >= CommonHelper.getUnionMemberMax(tonumber(union.level), union.unionTech) then
        SysError(SYS_ERR_UNION_MEMBER_FULL)
        return
      end
      game:sendData(actionCodes.Union_applyJoinRpc, MsgPack.pack({
        union = tonumber(union.id),
        desc = descStr
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Union_applyJoinRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        if msg.code then
          SysError(msg.code)
          BackManager:pop()
          return
        end
        game:enterScene("MainScene", {layer = "union"})
      end)
    end
  })
  BackManager:push(function()
    layer:close()
  end)
end

function UnionMainLayer:onExit()
  if self.refreshHandler then
    scheduler.unscheduleGlobal(self.refreshHandler)
  end
end

function UnionMainLayer:stringToTab(str)
  local tab = {}
  if not str then
    return tab
  end
  for utfChar in string.gmatch(str, "[%z-\127�-�][�-�]*") do
    table.insert(tab, utfChar)
  end
  return tab
end

function UnionMainLayer:getLength(strs)
  local width = 0
  for _, str in pairs(strs) do
    local len = string.len(str)
    if 1 < len then
      width = width + 2
    else
      width = width + 1
    end
  end
  return width
end

return UnionMainLayer
