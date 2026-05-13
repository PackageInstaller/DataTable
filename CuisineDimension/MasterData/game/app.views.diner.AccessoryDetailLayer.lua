local AccessCsv = require("csvdata.diner_accessory")
local EntryCsv = require("csvdata.diner_entry")
local MainRes = "ui/diner/main/"
local DetailRes = "ui/diner/detail/"
local AccessoryDetailLayer = class("AccessoryDetailLayer", function()
  return UIHelper.newImageView(DetailRes .. "detail_bg.png")
end)

function AccessoryDetailLayer:ctor(params)
  self:pos(315, 0):addTo(params.root)
  self:showData(params)
end

function AccessoryDetailLayer:showData(params)
  local curDiner = game.role.diner.diners[params.dinerId]
  local access = game.role.diner.accessories[params.curId]
  local data = AccessCsv[access.type]
  AccessIcon.new({
    id = params.curId
  }):pos(-56, 63):addTo(self)
  local btnWear = UIHelper.extend(ccui.Button:create())
  btnWear:setImages(MainRes, {
    "btn_common.png",
    "btn_common.png"
  })
  btnWear:pos(493, 87):addTo(self)
  btnWear:setTouchScale()
  btnWear:setCallback(function()
    game:sendData(actionCodes.Diner_wearAccessoryRpc, MsgPack.pack({
      slot = params.oriId == params.curId and 0 or params.dinerId,
      id = params.curId,
      index = params.index
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Diner_wearAccessoryRpc, function(event)
      UIHelper.removeWaiting()
      BackManager:pop()
    end)
  end)
  display.newTTFLabel({
    text = params.oriId == params.curId and "卸下" or "装备",
    size = 18
  }):enableOutline(UIHelper.hex2rgb("#886213"), 1):pos(61, 23):addTo(btnWear)
  local btnUp = UIHelper.extend(ccui.Button:create())
  btnUp:setImages(MainRes, {
    "btn_common.png",
    "btn_common.png"
  })
  btnUp:pos(493, 37):addTo(self)
  btnUp:setTouchScale()
  btnUp:setCallback(function()
    if data.type == 3 then
      SysError(SYS_ERR_DINER_ACCESS_TYPE_NOT_UP)
      return
    end
    if access.level >= data.maxLevel then
      SysError(SYS_ERR_DINER_ACCESS_UP_MAX)
      return
    end
    local layer = game:createView("diner.DinerUpAccessoryLayer", {
      id = params.curId
    })
    BackManager:push(function()
      layer:close()
      params.callback()
    end)
  end)
  display.newTTFLabel({text = "升级", size = 18}):enableOutline(UIHelper.hex2rgb("#886213"), 1):pos(61, 23):addTo(btnUp)
  local texts = {
    "基础属性:",
    "额外属性:"
  }
  local attrs = {"baseAttr", "extraAttr"}
  local yPos = 80
  for i, text in ipairs(texts) do
    display.newSprite("ui/diner/info/image_block.png"):pos(30, yPos):addTo(self)
    display.newTTFLabel({
      text = text,
      size = 16,
      color = UIHelper.hex2rgb("#765b44")
    }):anch(0, 0.5):pos(45, yPos):addTo(self)
    if access[attrs[i]] and access[attrs[i]] ~= "" then
      local id, value = access[attrs[i]]:match("(%d+)=(%d+%.?%d*)")
      local entry = EntryCsv[tonumber(id)]
      if i == 1 then
        local num = globalCsv.dinnerEntryStrengthRange:getv(access.level, 1)
        local str = string.format("%0.1f", tonumber(value) * num)
        display.newTTFLabel({
          text = string.format(entry.desc, str),
          size = 16,
          color = UIHelper.hex2rgb("#765b44")
        }):anch(0, 0.5):pos(125, yPos):addTo(self)
      else
        display.newTTFLabel({
          text = string.format(entry.desc, value),
          size = 16,
          color = UIHelper.hex2rgb("#765b44")
        }):anch(0, 0.5):pos(125, yPos):addTo(self)
      end
    else
      display.newTTFLabel({
        text = "无属性",
        size = 16,
        color = UIHelper.hex2rgb("#765b44")
      }):anch(0, 0.5):pos(125, yPos):addTo(self)
    end
    yPos = yPos - 35
  end
end

return AccessoryDetailLayer
