local ActivityManager = require("app.models.ActivityManager")
local ItemCsv = require("csvdata.item")
local LoginGiftCsv = require("csvdata.activity_88_logingift")
local activityType = "88"
local ResPath = "ui/activity/88/"
local LoginRes = "ui/activity/login/"
local Activity88Layer = {}
Activity88Layer.Cells = {}
Activity88Layer.Dates = {}
Activity88Layer.mainLayer = null

function Activity88Layer:init(mainLayer)
  Activity88Layer.mainLayer = mainLayer
  local list = ccui.ListView:create()
  list:size(cc.size(916, 516))
  list:setInnerContainerSize(cc.size(916, 516))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:anch(0.5, 0.5):pos(5, 0):addTo(mainLayer.content)
  local selected
  local cellSize = display.newSprite(ResPath .. "cell_bg.png"):getContentSize()
  cellSize.height = cellSize.height + 4
  for _, data in ipairs(LoginGiftCsv) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cellSize):addTo(list)
    local cell = display.newSprite(ResPath .. "cell_bg.png"):center(viewNode):addTo(viewNode)
    display.newTTFLabel({
      text = string.format("累计登陆%d天", data.day),
      size = 20
    }):pos(741, 97):addTo(cell)
    local xPos = 110
    for index, item in pairs(data.gift:toTableArray()) do
      local itemId = tonumber(item[1])
      local isTip = 4 < itemId and true or false
      ItemIcon.new({
        type = itemId,
        count = tonumber(item[2]),
        showTip = isTip
      }):scale(0.76):pos(xPos, 58):addTo(cell)
      xPos = xPos + 75
    end
    local state = game.role.activityStatus["88"]:getv(data.day, 0)
    local done = state == -1
    local text = done and "已领取" or state >= data.day and "领取" or "未达成"
    local btnImage = done and "btn_2.png" or state >= data.day and "btn_1.png" or "btn_3.png"
    local bTouch = not done and state >= data.day
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(LoginRes, {btnImage, btnImage})
    btn:pos(825, 40):addTo(cell):setTouchScale()
    btn:setString({
      text = text,
      size = 22,
      color = UIHelper.hex2rgb("#ffffff")
    })
    btn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 1)
    btn:setCallback(function()
      local items = data.gift:toNumMap()
      local boxId
      
      local function send(itemId)
        game:sendData(actionCodes.Activity_getRewardRpc, MsgPack.pack({
          type = 88,
          id = data.id,
          chooseId = itemId
        }))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Activity_getRewardRpc, function(event)
          UIHelper.removeWaiting()
          btn:setString({
            text = "已领取",
            size = 22,
            color = UIHelper.hex2rgb("#ffffff")
          })
          btn:setImages(LoginRes, {"btn_2.png", "btn_2.png"})
          btn:setTouchEnabled(false)
          if itemId then
            items[itemId] = 1
            items[boxId] = nil
          end
          MedalRewardLayer.new({items = items})
        end)
      end
      
      for itemId, num in pairs(items) do
        if ItemCsv[itemId].type == ItemType.ChooseBox then
          boxId = itemId
          break
        end
      end
      if boxId then
        local item = ItemCsv[boxId]
        local layer = game:createView("shop.ChooseItemLayer", {
          items = item.content,
          callback = function(itemId)
            if itemId ~= 0 then
              send(itemId)
            end
          end
        })
      else
        send()
      end
    end)
    btn:setTouchEnabled(bTouch)
    if not selected and bTouch then
      selected = data.day
    end
  end
  list:doLayout()
  if selected then
    list:scrollToItem(selected - 1, cc.p(0, 0.53), cc.p(0, -1))
  end
end

return Activity88Layer
