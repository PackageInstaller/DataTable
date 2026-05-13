local ItemCsv = require("csvdata.item")
local ManageRes = "ui/union/manage/"
local DonateRes = "ui/union/donate/"
local ShopRes = "ui/shop/main"
local IconRes = "icon/union_shop/"
local uiData = {
  csbFile = "ui/union/UnionDonateLayer.csb",
  mask = true,
  popup = true,
  widgets = {
    touch = "touch",
    panel = "panel",
    mask = "panel/mask",
    itemNode = "panel/itemNode",
    confirm = "panel/confirm",
    cancel = "panel/cancel"
  }
}
local UnionDonateLayer = class("UnionDonateLayer", UIBase)

function UnionDonateLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function UnionDonateLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.touch)
  end
  self.selfDonateNum = game.role.unionScore
  self.unionMoney = params.money
  self.canGetDonateNum = game.role.dailyDonateMax
  self.donateNum = 0
  self.wealthNum = 0
  self.donateCount = {
    0,
    0,
    0,
    0,
    0
  }
  self.itemDonateCount = {
    0,
    0,
    0,
    0,
    0
  }
  self.itemWealthCount = {
    0,
    0,
    0,
    0,
    0
  }
  self.itemDonateList = {}
  self.itemWealthList = {}
  self.itemNumList = {}
  local canGetDonateNumBg = display.newSprite(DonateRes .. "limitBg.png"):pos(220, 507):addTo(self.panel)
  self.canGetDonateNumText = display.newTTFLabel({
    text = self.canGetDonateNum .. "/" .. globalCsv.UnionDonateMax,
    size = 22
  }):enableOutline(UIHelper.hex2rgb("#502801"), 1):anch(0, 0.5):pos(222, 19):addTo(canGetDonateNumBg)
  local selfDonateNumBg = UIHelper.newImageView(DonateRes .. "numBg.png"):pos(900, 507):addTo(self.panel)
  selfDonateNumBg:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = selfDonateNumBg,
      itemType = 124,
      itemData = ItemCsv[124]
    })
  end)
  local donateIcon = display.newSprite(IconRes .. "gongxian.png"):pos(25, 17.5):addTo(selfDonateNumBg)
  self.selfDonateNumText = display.newTTFLabel({
    text = self.selfDonateNum,
    size = 22
  }):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(90, 17.5):addTo(selfDonateNumBg)
  local unionMoneyNumBg = UIHelper.newImageView(DonateRes .. "numBg.png"):pos(690, 507):addTo(self.panel)
  unionMoneyNumBg:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = unionMoneyNumBg,
      itemType = 123,
      itemData = ItemCsv[123]
    })
  end)
  local donateIcon = display.newSprite(IconRes .. "caifu.png"):pos(25, 17.5):addTo(unionMoneyNumBg)
  self.unionMoneyNumText = display.newTTFLabel({
    text = self.unionMoney,
    size = 22
  }):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(90, 17.5):addTo(unionMoneyNumBg)
  for i = 1, 5 do
    local cell = display.newSprite(DonateRes .. "cell.png"):pos(-81 + i * 210, 294.5):addTo(self.panel)
    ItemIcon.new({type = i}):pos(97, 293):addTo(cell)
    local donateImg = display.newSprite(IconRes .. "gongxian.png"):pos(50, 197):addTo(cell)
    local donateText = display.newTTFLabel({
      text = self.itemDonateCount[i],
      size = 22
    }):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(122, 197):addTo(cell)
    table.insert(self.itemDonateList, donateText)
    local wealthImg = display.newSprite(IconRes .. "caifu.png"):pos(50, 130):addTo(cell)
    local wealthText = display.newTTFLabel({
      text = self.itemWealthCount[i],
      size = 22
    }):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(122, 130):addTo(cell)
    table.insert(self.itemWealthList, wealthText)
    local itemNumText = display.newTTFLabel({
      text = self.donateCount[i],
      size = 22
    }):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(97, 62.5):addTo(cell)
    table.insert(self.itemNumList, itemNumText)
    local btnSub = UIHelper.extend(ccui.Button:create())
    btnSub:setImages(DonateRes, {"sub.png", "sub.png"})
    btnSub:pos(30, 62.5):addTo(cell)
    btnSub:setTouchScale()
    btnSub:setCallbackTotal(function()
      self.addHandler = scheduler.scheduleGlobal(function()
        self:changeNum(i, -1)
      end, 0.1)
    end, nil, function()
      if self.addHandler then
        scheduler.unscheduleGlobal(self.addHandler)
      end
      self:changeNum(i, -1)
    end, function()
      if self.addHandler then
        scheduler.unscheduleGlobal(self.addHandler)
      end
      self:changeNum(i, -1)
    end)
    local btnAdd = UIHelper.extend(ccui.Button:create())
    btnAdd:setImages(DonateRes, {"add.png", "add.png"})
    btnAdd:pos(164, 62.5):addTo(cell)
    btnAdd:setTouchScale()
    btnAdd:setCallbackTotal(function()
      self.addHandler = scheduler.scheduleGlobal(function()
        self:changeNum(i, 1)
      end, 0.1)
    end, nil, function()
      if self.addHandler then
        scheduler.unscheduleGlobal(self.addHandler)
      end
      self:changeNum(i, 1)
    end, function()
      if self.addHandler then
        scheduler.unscheduleGlobal(self.addHandler)
      end
      self:changeNum(i, 1)
    end)
  end
  self.confirm:setTouchScale()
  self.confirm:setCallback(function()
    local str = ""
    local canDonate = false
    for i = 1, 5 do
      if self.donateCount[i] > 0 then
        canDonate = true
      end
      if i < 5 then
        if game.role["material" .. i] < self.donateCount[i] then
          SysError(SYS_ERR_UNION_NOT_ENOUGT)
          return
        end
      elseif i == 5 and game.role.diamond < self.donateCount[i] then
        SysError(SYS_ERR_DIAMOND_SHORTAGE)
        return
      end
      str = str .. i .. "=" .. self.donateCount[i] .. " "
    end
    if not canDonate then
      SysError(SYS_ERR_UNION_CANNOT_ZERO)
      return
    end
    game:sendData(actionCodes.Union_donateRpc, MsgPack.pack({item = str}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Union_donateRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      params.callback()
    end)
    self:close()
  end)
  self.cancel:setTouchScale()
  self.cancel:setCallback(function()
    self:close()
  end)
end

function UnionDonateLayer:changeNum(index, num)
  self.donateCount[index] = math.max(self.donateCount[index] + globalCsv.UnionDonateUnit[index] * num, 0)
  self.itemNumList[index]:setString(self.donateCount[index])
  local temp = 0
  for i = 1, 5 do
    self.itemDonateCount[i] = self.donateCount[i] / globalCsv.UnionDonateUnit[i] * globalCsv.UnionDonateRate[i]
    if temp >= globalCsv.UnionDonateMax - self.canGetDonateNum then
      self.itemDonateList[i]:setString(0)
    elseif temp + self.itemDonateCount[i] >= globalCsv.UnionDonateMax - self.canGetDonateNum then
      self.itemDonateList[i]:setString(globalCsv.UnionDonateMax - self.canGetDonateNum - temp)
      temp = temp + self.itemDonateCount[i]
    else
      self.itemDonateList[i]:setString(self.itemDonateCount[i])
      temp = temp + self.itemDonateCount[i]
    end
  end
  self.itemWealthCount[index] = math.max(self.itemWealthCount[index] + globalCsv.UnionWealthRate[index] * num, 0)
  self.itemWealthList[index]:setString(self.itemWealthCount[index])
  self.canGetDonateNumText:setString(self.canGetDonateNum .. "/" .. globalCsv.UnionDonateMax)
end

return UnionDonateLayer
