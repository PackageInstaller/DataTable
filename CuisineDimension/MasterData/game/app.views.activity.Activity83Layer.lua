local ActivityManager = require("app.models.ActivityManager")
local ItemCsv = require("csvdata.item")
local activityType = "83"
local ResPath = "ui/activity/83/"
local Activity83Layer = {}
Activity83Layer.Cells = {}
Activity83Layer.Dates = {}
Activity83Layer.mainLayer = null

function Activity83Layer:init(mainLayer)
  Activity83Layer.mainLayer = mainLayer
  self.background = display.newSprite(ResPath .. "background.png"):anch(0, 0):pos(-455, -254):addTo(mainLayer.content)
  local StartX = 55
  local StartY = 260
  for i = 1, 5 do
    Activity83Layer:createCell(self.background, StartX + (i - 1) * 170, StartY, i)
  end
  Activity83Layer:updateAll()
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages(ResPath, {
    "description.png",
    "description.png"
  })
  btnInfo:setTouchScale()
  btnInfo:setCallback(function()
    game:createView("global.RuleLayer", {
      typeStr = "activity_83"
    })
  end)
  btnInfo:pos(880, 357):addTo(self.background)
  self.btnInfo = btnInfo
  Activity83Layer.selectStage = nil
end

function Activity83Layer:createCell(parent, posX, posY, index)
  local cell = {}
  cell.layout = UIHelper.extend(ccui.Layout:create())
  cell.layout:addTo(parent)
  cell.layout:pos(posX, posY)
  cell.stage = UIHelper.extend(ccui.Button:create()):anch(0, 0):pos(0, 0):addTo(cell.layout)
  cell.stage:setImages(ResPath, {
    "stageBg.png",
    "stageBg.png"
  })
  cell.stage:setCallback(function()
    Activity83Layer:changeSelect(index)
  end)
  cell.label = UIHelper.extend(ccui.ImageView:create()):anch(0, 0):pos(5, -15):addTo(cell.layout)
  cell.label:setImage(ResPath .. "label" .. index .. ".png")
  cell.stage = UIHelper.extend(ccui.ImageView:create()):anch(0, 0):pos(10, 5):addTo(cell.layout)
  cell.stage:setImage(ResPath .. "stage" .. index .. ".png")
  cell.bg2 = UIHelper.extend(ccui.ImageView:create()):anch(0, 0):pos(5, -230):addTo(cell.layout)
  cell.bg2:setImage(ResPath .. "no" .. index .. "di.png")
  cell.title = display.newTTFLabel({
    text = "累计充值888元",
    size = 16
  }):anch(0.5, 0.5):enableOutline(UIHelper.hex2rgb("#541c06"), 2):pos(83, -47):addTo(cell.layout)
  cell.getBtn = UIHelper.extend(ccui.Button:create())
  cell.getBtn:setImages(ResPath, {"target.png", "target.png"})
  cell.getBtn:anch(0.5, 0.5):pos(88, -190):addTo(cell.layout):setTouchScale()
  cell.itemIcon = UIHelper.extend(ccui.ImageView:create()):anch(0.5, 0.5):pos(88, -110):scale(0.8):addTo(cell.layout)
  cell.itemIcon:setImage(ItemCsv[21005].icon)
  cell.itemNum = display.newTTFLabel({text = "100", size = 20}):anch(0.5, 0):enableOutline(UIHelper.hex2rgb("#541c06"), 2):pos(85, -165):addTo(cell.layout)
  cell.progress = display.newTTFLabel({text = "1000/1000", size = 19}):anch(0.5, 0.5):enableOutline(UIHelper.hex2rgb("#541c06"), 2):pos(55, 18):addTo(cell.getBtn)
  Activity83Layer.Cells[index] = cell
end

function Activity83Layer:changeSelect(index)
  Activity83Layer.selectStage = index
  Activity83Layer:updateAll()
end

function Activity83Layer:updateAll()
  Activity83Layer.Datas = ActivityManager:GetActivity83Datas()
  local lastStage = 1
  for x = 1, #Activity83Layer.Datas do
    local dataList = Activity83Layer.Datas[x]
    for y = 1, #dataList do
      local data = dataList[y]
      if not data.isUnlockPre and not Activity83Layer.selectStage then
        Activity83Layer.selectStage = lastStage
      end
      lastStage = data.task.stage
    end
  end
  if not Activity83Layer.selectStage then
    Activity83Layer.selectStage = lastStage
  end
  for i = 1, 5 do
    Activity83Layer:updateCell(i)
  end
end

function Activity83Layer:updateCell(i)
  local cell = Activity83Layer.Cells[i]
  local stageData = Activity83Layer.Datas[Activity83Layer.selectStage]
  local data = stageData[i]
  cell.label:scale(Activity83Layer.selectStage == i and 1 or 0)
  cell.title:setString(data.task.desc)
  local itemData = ItemCsv[data.rewardId]
  if data.rewardId == 1099 then
    cell.itemIcon:setImage(ItemCsv[303].icon)
  elseif data.rewardId == 1098 then
    cell.itemIcon:setImage(ItemCsv[400].icon)
  elseif data.rewardId == 1097 then
    cell.itemIcon:setImage(ItemCsv[400].icon)
  else
    cell.itemIcon:setImage(itemData.icon)
  end
  cell.itemNum:setString(data.rewardCount)
  cell.progress:setString(data.progressStr)
  if data.canGet then
    cell.getBtn:setImages(ResPath, {"get.png", "get.png"})
  elseif data.isFinishAll then
    cell.getBtn:setImages(ResPath, {
      "received.png",
      "received.png"
    })
  else
    cell.getBtn:setImages(ResPath, {"target.png", "target.png"})
  end
  if data.isUnlockPre then
    cell.bg2:setImage(ResPath .. "no" .. data.task.stage .. "di.png")
    cell.getBtn:scale(1)
    cell.progress:scale(1)
    if itemData.type == 19 or itemData.type == 9 then
      cell.itemIcon:scale(0.66)
    else
      cell.itemIcon:scale(1)
    end
    cell.itemNum:scale(1)
    cell.title:scale(1)
  else
    cell.bg2:setImage(ResPath .. "lock.png")
    cell.getBtn:scale(0)
    cell.progress:scale(0)
    cell.itemIcon:scale(0)
    cell.itemNum:scale(0)
    cell.title:scale(0)
  end
  cell.getBtn:setCallback(function()
    if data.canGet then
      Activity83Layer:getAward(data)
    elseif data.isFinishAll then
    else
      Activity83Layer:showForward(data.task)
    end
  end)
end

function Activity83Layer:getAward(data)
  game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({
    type = 83,
    part = data.task.stage,
    id = data.task.id
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
    UIHelper.removeWaiting()
    Activity83Layer.selectStage = nil
    Activity83Layer:updateAll()
    local msg = MsgPack.unpack(event.data)
    MedalRewardLayer.new({
      items = msg.reward
    })
    game.role:setRedDirty("activity")
  end)
end

function Activity83Layer:showForward(data)
  local jumpType, cond = TaskHelper.GetJumpType(data.type)
  CommonHelper.jumpLayer(jumpType, function()
    Activity83Layer.mainLayer:hide()
  end, function()
    TopBar:show(TopBarType.full, "活动")
    Activity83Layer.mainLayer:show()
    Activity83Layer:updateAll()
  end, cond)
end

return Activity83Layer
