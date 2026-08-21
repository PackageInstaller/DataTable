local ReDefineCsv = require("csvdata.equip_refine")
local uiData = {
  csbFile = "ui/equip/EquipRecycleLayer.csb",
  widgets = {
    mainBg1 = "mainBg1",
    list = "mainBg1/list",
    backBtn = "mainBg1/backBtn",
    titleBg = "mainBg1/titleBg",
    ren = "ren",
    mainBg2 = "mainBg2",
    circle = "mainBg2/circle2",
    angel = "angel",
    mainBg = "mainBg",
    items = "mainBg/items",
    angel = "angel"
  }
}
local EquipRecycleLayer = class("EquipRecycleLayer", UIBase)

function EquipRecycleLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function EquipRecycleLayer:init(params)
  if UIHelper.isiPhoneX() then
    self.mainBg1:setPositionX(self.mainBg1:getPositionX() + UIHelper.getMoveXForX() + 80)
    self.angel:setPositionX(self.angel:getPositionX() + UIHelper.getMoveXForX() + 80)
  end
  self.titleBg:hide()
  UIHelper.MoveToLeft({
    node = self.mainBg1
  })
  UIHelper.MoveToUp({
    node = self.mainBg
  })
  UIHelper.MoveToRight({
    node = self.mainBg2,
    time = 0.3
  })
  UIHelper.MoveToRight({
    node = self.ren,
    time = 0.3
  })
  UIHelper.MoveToUp({
    node = self.angel,
    time = 0.3
  })
  self.circle:runAction(cc.RepeatForever:create(cc.RotateBy:create(20, 360)))
  self.eatList = {}
  self:showList()
  self.backBtn:setTouchScale()
  self.backBtn:setCallback(function()
    if not next(self.eatList) then
      SysError(SYS_ERR_EQUIP_CHOOSE_FIRST)
      return
    end
    local bHero = false
    for _, equipId in pairs(self.eatList) do
      local equip = game.role.equips[equipId]
      if equip and equip.masterId ~= 0 then
        bHero = true
        break
      end
    end
    local showTip = {}
    for _, equipId in pairs(self.eatList) do
      local equip = game.role.equips[equipId]
      if equip and equip:getStrengthLevel() > 1 then
        showTip[1] = "强化过"
      end
      if equip and equip.csvData.star >= 4 then
        showTip[2] = "高品质"
      end
    end
    
    local function send()
      table.remove(self.eatList, #self.eatList)
      local list = table.concat(self.eatList, "=")
      if list == "" then
        SysError(SYS_ERR_EQUIP_CHOOSE_FIRST)
        return
      end
      game:sendData(actionCodes.Equip_decomposEquipRpc, MsgPack.pack({ids = list}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Equip_decomposEquipRpc, function(event)
        UIHelper.removeWaiting()
        self.eatList = {}
        self:showList()
        self:showBackNum()
        local msg = MsgPack.unpack(event.data)
        MedalRewardLayer.new({
          items = msg.nums
        })
      end)
    end
    
    local function showTips()
      if next(showTip) then
        MDialog:double({
          text = string.format("选择的材料装备中有<div color=#ff0000>%s</div>的装备\n \n仍要进行分解吗？", table.concat(table.values(showTip), "/"))
        }, function()
          send()
        end)
      else
        send()
      end
    end
    
    if bHero then
      MDialog:double({
        text = "有些装备还在食灵身上穿着，确定要废弃吗？"
      }, function()
        showTips()
      end)
    else
      showTips()
    end
  end)
  self:showBackNum()
end

function EquipRecycleLayer:showList()
  if self.refreshHandler then
    scheduler.unscheduleGlobal(self.refreshHandler)
  end
  self.rowCount = 0
  self.list:removeAllChildren()
  table.insert(self.eatList, 0)
  self.refreshHandler = scheduler.scheduleGlobal(function()
    self:refreshListWithDelay()
  end, 0.016666666666666666)
end

function EquipRecycleLayer:refreshListWithDelay()
  if self.rowCount > math.ceil(table.nums(self.eatList) / 5) then
    if self.refreshHandler then
      scheduler.unscheduleGlobal(self.refreshHandler)
      self.refreshHandler = nil
    end
    self.list:requestDoLayout()
    return
  end
  local row, colCount = self.rowCount, 5
  local interval = 3
  local cellSize = display.newSprite("ui/global/item_bg.png"):getContentSize()
  local nodeSize = cc.size(cellSize.width * 5 + 4 * interval, cellSize.height + 12)
  local viewNode = ccui.Widget:create()
  viewNode:size(nodeSize):addTo(self.list)
  for index = row * colCount + 1, colCount * (row + 1) do
    if index <= table.nums(self.eatList) then
      local col = index - row * colCount
      if self.eatList[index] == 0 then
        local card = UIHelper.newImageView("ui/kitchen/quality/bg_1.png")
        UIHelper.newImageView("ui/global/item_frame.png"):center(card):addTo(card)
        UIHelper.newImageView("ui/global/add.png"):pos(46, 53):addTo(card)
        card:anch(0, 0):pos((cellSize.width + interval) * (col - 1), 0):addTo(viewNode)
        local desc = display.newTTFLabel({
          text = "添加装备",
          size = 14,
          color = UIHelper.hex2rgb("#b3a27e")
        }):pos(45, 25):addTo(card)
        card:setCallback(function()
          self:add()
        end)
      else
        local equip = game.role.equips[self.eatList[index]]
        local card = ItemIcon.new({
          type = equip:getItemId()
        })
        card:anch(0, 0):pos((cellSize.width + interval) * (col - 1), 0):addTo(viewNode)
        card:setCallback(function()
          table.remove(self.eatList, table.nums(self.eatList))
          table.remove(self.eatList, index)
          self:showList()
          self:showBackNum()
        end)
      end
    end
  end
  self.rowCount = self.rowCount + 1
end

function EquipRecycleLayer:add()
  local function rule(equip)
    if equip.lock == 1 then
      return true
    end
    local msaterId = equip.masterId
    if msaterId ~= 0 then
      local hero = game.role.heros[msaterId]
      local states = hero:getState()
      if states[2] or states[3] then
        return true
      end
    end
    return false
  end
  
  local layer = game:createView("equip.ChooseEquipLayer", {
    multiChoose = true,
    rule = rule,
    type = 5,
    quickChose = true,
    max = 50,
    callback = function(chooseList)
      self.eatList = {}
      for id, _ in pairs(chooseList) do
        self.eatList[#self.eatList + 1] = id
      end
      self:showList()
      self:showBackNum()
    end
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(TopBarType.full, "厨房")
  end)
end

function EquipRecycleLayer:showBackNum()
  self.items:removeAllChildren()
  local nums = {
    0,
    0,
    0,
    0,
    0
  }
  for _, id in pairs(self.eatList) do
    local equip = game.role.equips[id]
    if equip then
      local redefData = ReDefineCsv[equip.csvData.profession]
      nums[5] = nums[5] + redefData.decompose_refine:getv(equip.csvData.star, 0)
      for i = 1, 4 do
        nums[i] = nums[i] + redefData["decompose_material" .. i]:getv(equip.csvData.star, 0)
      end
    end
  end
  local xPos = -160
  for i = 1, 5 do
    local index = i < 5 and i or 501
    local itemBg = display.newSprite("ui/equip/recycle/item_bg.png"):pos(xPos + (i - 1) * 80, 0):addTo(self.items)
    local image = i < 5 and string.format("ui/global/%d.png", i) or "ui/global/icon_equiprepair.png"
    display.newSprite(image):scale(0.9):center(itemBg):addTo(itemBg)
    display.newTTFLabel({
      text = nums[i],
      size = 20
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):anch(1, 0.5):pos(70, 15):addTo(itemBg)
  end
end

function EquipRecycleLayer:onExit()
  if self.refreshHandler then
    scheduler.unscheduleGlobal(self.refreshHandler)
  end
end

return EquipRecycleLayer
