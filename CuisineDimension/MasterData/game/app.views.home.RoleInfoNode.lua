local PicCsv = require("csvdata.head_pic")
local FramCsv = require("csvdata.head_circle")
local roleInfo = require("csvdata.role_info")
local homeRes = "ui/home/"
local uiData = {
  csbFile = "ui/home/RoleNode.csb",
  widgets = {
    mainBg = "mainBg",
    black = "black",
    node = "node",
    name = "name",
    level = "level",
    barBg = "barBg",
    expBar = "barBg/bar",
    headBarFrame = "barBg/headBarFrame",
    desBg = "mainBg/desBg",
    headFram = "headFram"
  }
}
local RoleInfoNode = clone(UIController)

function RoleInfoNode:__init()
  local posX = UIHelper.isiPhoneX() and display.left - UIHelper.getMoveXForX() + 20 or display.left
  self.mainBg:pos(posX, display.height)
  self.eventHandlers = {
    game.role:addEventListener("set_exp", function(event)
      self.expBar:setPercent(event.newValue / roleInfo[game.role.level].exp * 100)
    end),
    game.role:addEventListener("set_level", function(event)
      self.expBar:setPercent(game.role.exp / roleInfo[game.role.level].exp * 100)
      self.level:removeAllChildren()
      MRichText.new({
        text = string.format("<div color=#ffcf46 outline=1,#000000 fontsize=24>Lv</div><div color=#ffffff outline=1,#000000 fontsize=30>%d</div>", event.newValue)
      }):anch(0.5, 0.5):addTo(self.level)
    end),
    game.role:addEventListener("set_name", function(event)
      self.name:setString(event.newValue)
    end),
    game.role:addEventListener("set_headIconTag", function(event)
      self:showData()
    end),
    game.role:addEventListener("set_headFrameTag", function(event)
      self:showData()
    end)
  }
  local bShow = false
  
  local function ShowDetail()
    if bShow then
      return
    end
    bShow = true
    local layer = game:createView("home.RoleDetailLayer")
    BackManager:push(function()
      layer:close()
      self:showData()
      bShow = false
    end)
  end
  
  self.black:setCallback(function()
    ShowDetail()
  end)
  self.desBg:setCallback(function()
    ShowDetail()
  end)
  self.expBar:setPercent(game.role.exp / roleInfo[game.role.level].exp * 100)
  self.name:setString(game.role.name)
  self.level:removeAllChildren()
  MRichText.new({
    text = string.format("<div color=#ffcf46 outline=1,#000000 fontsize=24>Lv</div><div color=#ffffff outline=1,#000000 fontsize=30>%d</div>", game.role.level)
  }):anch(0.5, 0.5):addTo(self.level)
  if game.role.homeBgTag == 6 then
    self.desBg:setImage("ui/home/lty/head_name_bg.png")
    self.barBg:setTexture("ui/home/lty/head_bar_bg.png")
    self.headBarFrame:setTexture("ui/home/lty/head_bar_frame.png")
    self.expBar:loadTexture("ui/home/lty/head_bar.png")
  elseif game.role.homeBgTag == 42 then
    self.desBg:setImage("ui/home/fouryear/head_name_bg.png")
    self.barBg:setTexture("ui/home/fouryear/head_bar_bg.png")
    self.headBarFrame:setTexture("ui/home/fouryear/head_bar_frame.png")
    self.expBar:loadTexture("ui/home/fouryear/head_bar.png")
  end
  if game.role.homeType ~= nil and game.role.homeType == 2 and globalCsv.newHomeOpen == 1 then
    self.desBg:setImage("ui/newhome/btns/head_bg.png")
  end
end

function RoleInfoNode:showData()
  self.node:removeAllChildren()
  local picData = PicCsv[game.role.headIconTag]
  local framData = FramCsv[game.role.headFrameTag]
  display.newSprite(picData.res):addTo(self.node)
  self.headFram:setTexture(framData.res)
end

function RoleInfoNode:showView(scene, ...)
  self.uiView = UIView:create(uiData, self)
  self.uiView:show(scene)
end

function RoleInfoNode:getBg()
  return self.mainBg
end

function RoleInfoNode:onExit()
  for _, handler in ipairs(self.eventHandlers) do
    game.role:removeEventListener(handler)
  end
end

function RoleInfoNode:close()
  self.uiView:close()
  for _, handler in ipairs(self.eventHandlers) do
    game.role:removeEventListener(handler)
  end
end

return RoleInfoNode
