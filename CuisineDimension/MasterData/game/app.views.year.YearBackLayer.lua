local ChapterCsv = require("csvdata.chapter_battle")
local UnitCsv = require("csvdata.unit")
local BackCsv = require("csvdata.anniversary")
local channelConfigs = require("sdk.ChannelConfigs")
local config = channelConfigs[CHANNEL_KEY]
local RewardRes = "ui/common/reward/"
local BackRes = "ui/year/back/"
local PosData = {
  [1] = {
    [1] = {
      xPos = 488,
      yPos = 438,
      longth = 390
    },
    [2] = {
      xPos = 488,
      yPos = 349,
      longth = 470
    },
    [3] = {
      xPos = 488,
      yPos = 262,
      longth = 470
    },
    [4] = {
      xPos = 488,
      yPos = 166,
      longth = 470
    }
  },
  [2] = {
    [1] = {
      xPos = 158,
      yPos = 437,
      longth = 470
    },
    [2] = {
      xPos = 158,
      yPos = 345,
      longth = 470
    },
    [3] = {
      xPos = 158,
      yPos = 263,
      longth = 470
    },
    [4] = {
      xPos = 158,
      yPos = 157,
      longth = 470
    }
  },
  [3] = {
    [1] = {
      xPos = 310,
      yPos = 437,
      longth = 470
    },
    [2] = {
      xPos = 310,
      yPos = 345,
      longth = 470
    },
    [3] = {
      xPos = 310,
      yPos = 163,
      longth = 470
    }
  }
}
local YearBackLayer = class("YearBackLayer", function()
  return UIHelper.extend(ccui.Layout:create())
end)

function YearBackLayer:ctor(params)
  self:uiLayout(params)
end

function YearBackLayer:uiLayout(params)
  local width = display.width
  local moveX = 0
  local xPos = 1080
  if UIHelper.isiPhoneX() then
    width = width + UIHelper.getMoveXForX() * 2
    moveX = UIHelper.getMoveXForX()
  end
  self:size(cc.size(width, display.height))
  self:addTo(display.getRunningScene(), POPUP_LAYER_ORDER)
  self.mask = UIHelper.newMask({
    size = cc.size(width, display.height),
    color = "#000000",
    opacity = 120
  })
  self.mask:pos(-moveX, 0):addTo(self)
  self.mask:setTouchEnabled(true)
  self.mask:setSwallowTouches(true)
  self.pageView = ccui.PageView:create()
  self.pageView:setContentSize(width, 590)
  self.pageView:setTouchEnabled(true)
  self.pageView:anch(0.5, 0.5):pos(width / 2, display.height / 2):addTo(self.mask)
  local btnClose = UIHelper.extend(ccui.Button:create())
  btnClose:setTouchScale()
  btnClose:setImages(BackRes, {
    "btn_close.png",
    "btn_close.png"
  })
  btnClose:pos(1075 + moveX, 585):addTo(self.mask)
  btnClose:setCallback(function()
    self:removeFromParent()
  end)
  local msg = game.role.activityStatus["50"]
  local contents3
  if msg[1][3] == 0 then
    contents3 = ""
  else
    contents3 = ChapterCsv[tonumber(msg[1][3])].name
  end
  local contents = {
    [1] = CommonHelper.date(game.role.createTime, "ymd"),
    [2] = string.format("%s天", msg[1][1]),
    [3] = contents3,
    [4] = msg[2][1],
    [5] = string.format("%s次", msg[2][5]),
    [6] = string.format("%s件", msg[3][3]),
    [7] = string.format("%s名", msg[3][4])
  }
  local btnShare = UIHelper.extend(ccui.Button:create())
  btnShare:setTouchScale()
  btnShare:setImages(BackRes, {
    "btn_share.png",
    "btn_share.png"
  })
  btnShare:pos(1010 + moveX, 105):addTo(self.mask)
  btnShare:setCallback(function()
    local function getShareScreen()
      local name = "shareScreen.png"
      
      local renderTexture = cc.RenderTexture:create(width, display.height)
      renderTexture:begin()
      local bg = display.newSprite(BackRes .. "bg_5.png"):pos(width / 2, display.height / 2)
      display.newTTFLabel({
        text = game.role.name,
        size = 30,
        color = UIHelper.hex2rgb("#623212")
      }):anch(0, 0.5):pos(840, 470):addTo(bg)
      local yPos = 401
      for idx, str in ipairs(contents) do
        display.newTTFLabel({
          text = str,
          size = 30,
          color = UIHelper.hex2rgb("#623212")
        }):anch(0, 0.5):pos(880, yPos):addTo(bg)
        yPos = yPos - 38
      end
      bg:visit()
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
      if renderTexture:saveToFile(name, kCCImageFormatPNG) then
        return string.gsub(device.writablePath, "[\\\\/]+$", "") .. device.directorySeparator .. name
      end
    end
    
    local path = getShareScreen()
    local content = "#料理次元# #料理次元两周年# 我的主厨生涯履历书"
    umeng.shareContent({content = content, image = path})
  end)
  btnShare:hide()
  self:initContent(width)
end

function YearBackLayer:initContent(width)
  local msg = game.role.activityStatus["50"] or {
    {},
    {},
    {},
    {0}
  }
  local contents3
  if msg[1][3] == 0 then
    contents3 = ""
  else
    contents3 = ChapterCsv[tonumber(msg[1][3])].name
  end
  local contents = {
    [1] = {
      [1] = {
        game.role.name
      },
      [2] = {
        CommonHelper.date(game.role.createTime, "ymd"),
        game.serverInfo.name,
        msg[1][1]
      },
      [3] = {
        msg[1][2],
        contents3
      },
      [4] = {
        msg[1][4]
      }
    },
    [2] = {
      [1] = {
        msg[2][1],
        string.gsub(TitleData[tonumber(msg[2][2])], "\n", ""),
        msg[2][3]
      },
      [2] = {
        msg[2][4]
      },
      [3] = {
        msg[2][5]
      },
      [4] = {
        msg[2][6]
      }
    },
    [3] = {
      [1] = {
        tonumber(msg[3][1]) == 0 and "无" or UnitCsv[tonumber(msg[3][1])].name,
        msg[3][2]
      },
      [2] = {
        msg[3][3],
        msg[3][4]
      },
      [3] = {}
    }
  }
  for page = 1, 3 do
    local layout = ccui.Layout:create()
    layout:setContentSize(cc.size(width, 590))
    local bg = display.newSprite(BackRes .. string.format("bg_%d.png", page)):pos(width / 2, 291):addTo(layout)
    for idx, data in ipairs(BackCsv[page]) do
      local content = contents[page][idx]
      local str = next(content) and string.format(data.desc, content[1], content[2], content[3]) or data.desc
      MRichText.new({
        text = str,
        size = 20,
        color = UIHelper.hex2rgb("#8d716e"),
        maxWidth = PosData[page][idx].longth
      }):anch(0, 0.5):pos(PosData[page][idx].xPos, PosData[page][idx].yPos):addTo(bg)
    end
    self.pageView:addPage(layout)
  end
  local layout = ccui.Layout:create()
  layout:setContentSize(cc.size(width, 590))
  display.newSprite(BackRes .. "bg_4.png"):pos(width / 2, 291):addTo(layout)
  self.pageView:addPage(layout)
end

return YearBackLayer
