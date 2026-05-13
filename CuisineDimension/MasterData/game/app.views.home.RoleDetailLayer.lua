local FramCsv = require("csvdata.head_circle")
local PicCsv = require("csvdata.head_pic")
local SkinCsv = require("csvdata.home_skin")
local RoleInfoCsv = require("csvdata.role_info")
local TalkCsv = require("csvdata.talk_bubble")
local TapCsv = require("csvdata.tap_effect")
local RoleRes = "ui/home/roleDetail/"
local TapRes = "tap_effect/"
local uiData = {
  csbFile = "ui/home/RoleDetailLayer.csb",
  mask = true,
  popup = true,
  widgets = {
    touch = "touch",
    panel1 = "panel1",
    mask1 = "panel1/mask1",
    roleNode = "panel1/roleNode",
    name = "panel1/name",
    level = "panel1/level",
    exp = "panel1/exp",
    bar = "panel1/barBg/bar",
    id = "panel1/id",
    rename = "panel1/rename",
    btnInfo = "panel1/btnInfo",
    btnSkin = "panel1/btnSkin",
    btnTap = "panel1/btnTap",
    btnClose = "panel1/btnClose",
    panel2 = "panel2",
    mask2 = "panel2/mask2",
    btn1 = "panel2/btn1",
    btn2 = "panel2/btn2",
    btn3 = "panel2/btn3",
    iconNode = "panel2/iconNode",
    infoNode = "panel2/infoNode",
    skinNode = "panel2/skinNode",
    tapNode = "panel2/tapNode",
    collectBg = "panel2/infoNode/collectBg",
    travelBg = "panel2/infoNode/travelBg",
    iconList = "panel2/iconNode/iconList",
    skinList = "panel2/skinNode/skinList",
    tapList = "panel2/tapNode/tapList",
    changeIcon = "panel2/iconNode/changeIcon",
    changeSkin = "panel2/skinNode/changeSkin",
    changeTap = "panel2/tapNode/changeTap"
  }
}
local RoleDetailLayer = class("RoleDetailLayer", UIBase)

function RoleDetailLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function RoleDetailLayer:init(params)
  self.mask2:setSwallowTouches(true)
  self.mask2:setLocalZOrder(-1)
  self.mask1:setSwallowTouches(true)
  self.showDown = false
  self.showType = 0
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.touch)
  end
  local btnsNames = {
    "btnClose",
    "changeIcon",
    "changeSkin",
    "rename"
  }
  for _, name in pairs(btnsNames) do
    self[name]:setTouchScale()
  end
  self.changeIcon:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c36050"), 1)
  local names = {
    [1] = "头\n像",
    [2] = "像\n框",
    [3] = "气\n泡"
  }
  self.group = MRadioGroup:create({
    chooseCb = function(sender)
      sender:setPositionX(sender:getPositionX() - 5)
    end,
    unchooseCb = function(sender)
      sender:setPositionX(sender:getPositionX() + 5)
    end
  })
  for index, name in ipairs(names) do
    local btn = self["btn" .. index]
    btn:setGroup(self.group)
    btn:name("btn" .. index)
    btn:setCallback(function()
      self:showIcon(index)
    end)
    display.newTTFLabel({
      text = name,
      size = 24,
      color = UIHelper.hex2rgb("#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#3a200a"), 1):pos(25, 40):addTo(btn)
    btn:setLocalZOrder(-1)
    btn:hide()
  end
  self.btnClose:setCallback(function()
    BackManager:pop()
  end)
  self.rename:setCallback(function()
    local layer = game:createView("home.ChangeNameLayer")
    self:hide()
    BackManager:push(function()
      self:show()
      layer:close()
      self:showData()
    end)
  end)
  self.touch:setCallback(function()
    self:closeShowDown()
  end)
  local btnNames = {
    [1] = "btnInfo",
    [2] = "btnSkin",
    [3] = "btnTap"
  }
  for type, name in pairs(btnNames) do
    self[name]:setCallback(function()
      if self.showType == type then
        self:closeShowDown()
        return
      end
      self.showType = type
      if not self.showDown then
        self:changeLayOut()
      end
      if type == 1 then
        self.group:chooseByName("btn1")
        self:showIcon(1)
      elseif type == 2 then
        self:showSkin(2)
      else
        self:showTap(3)
      end
    end)
  end
end

function RoleDetailLayer:closeShowDown()
  self.group:hide()
  if not self.showDown then
    return
  end
  self:changeLayOut()
  self.showType = 0
end

function RoleDetailLayer:showData(params)
  self.name:setString(game.role.name)
  self.level:setString("Lv" .. game.role.level)
  self.id:setString(game.role.union == 0 and game.role.id or string.format("%s 协会：%s", game.role.id, game.role.unionName))
  local curExp = game.role.exp
  local allExp = RoleInfoCsv[game.role.level].exp
  self.exp:setString(string.format("%d/%d", curExp, allExp))
  self.bar:setPercent(curExp / allExp * 100)
  self:refreshHead()
end

function RoleDetailLayer:refreshHead()
  self.roleNode:removeAllChildren()
  local bg = UIHelper.newImageView(PicCsv[game.role.headIconTag].res):addTo(self.roleNode)
  display.newSprite(FramCsv[game.role.headFrameTag].res):center(bg):addTo(bg)
end

function RoleDetailLayer:showTalkFrame()
  local origin = game.role.talkFrameTag
  local selected = origin
  local size = display.newSprite(RoleRes .. "cell_bg.png"):getContentSize()
  size.width = self.iconList:getContentSize().width
  local Csv = table.values(TalkCsv)
  table.sort(Csv, function(a, b)
    local lockA = game.role.items[a.item] and 0 or 1000
    local lockB = game.role.items[b.item] and 0 or 1000
    return lockA + a.order < lockB + b.order
  end)
  for idx, data in ipairs(Csv) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(size):addTo(self.iconList)
    local cell = UIHelper.newImageView(RoleRes .. "cell_bg.png"):center(viewNode):addTo(viewNode)
    local bg = UIHelper.newImageView(PicCsv[game.role.headIconTag].res):scale(0.5):pos(50, 50):addTo(cell)
    display.newSprite(FramCsv[game.role.headFrameTag].res):center(bg):addTo(bg)
    display.newSprite(RoleRes .. "image_gray.png"):pos(575, 50):addTo(cell)
    local talkBg = UIHelper.newImageView(Csv[idx].res):anch(0, 0.5):pos(85, 40):addTo(cell)
    display.newSprite("ui/chat/world.png"):pos(123, 84):addTo(cell)
    display.newTTFLabel({
      text = game.role.name,
      size = 18,
      color = UIHelper.hex2rgb("#867473")
    }):anch(0, 0.5):pos(135, 84):addTo(cell)
    display.newTTFLabel({
      text = "欢迎来到料理次元",
      size = 18,
      color = UIHelper.hex2rgb("#065151")
    }):anch(0, 0.5):pos(123, 40):addTo(cell)
    if not game.role.items[data.item] then
      display.newSprite("ui/global/lock.png"):pos(525, 50):addTo(cell)
      cell:setCallback(function()
        MFlashMsg:show({
          text = data.unlockDesc
        })
      end)
    else
      cell:setCallback(function()
        if self.circle then
          self.circle:removeSelf()
        end
        self.circle = display.newSprite(RoleRes .. "image_green.png"):pos(568, 50):addTo(viewNode)
        selected = data.id
      end)
      if data.id == origin then
        self.circle = display.newSprite(RoleRes .. "image_green.png"):pos(568, 50):addTo(viewNode)
      end
    end
  end
  self.iconList:requestDoLayout()
  self.changeIcon:setCallback(function()
    if origin == selected then
      SysError(SYS_ERR_ROLE_CHANGE_TALK_USED)
      return
    end
    game:sendData(actionCodes.Role_changeTalkFrameRpc, MsgPack.pack({index = selected}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Role_changeTalkFrameRpc, function(event)
      UIHelper.removeWaiting()
      origin = game.role.talkFrameTag
      SysError(SYS_ERR_ROLE_CHANGE_TALK_SUCCESS)
    end)
  end)
end

function RoleDetailLayer:showIcon(type)
  self.iconList:removeAllChildren()
  self.group:show()
  self.iconNode:show()
  self.infoNode:hide()
  self.skinNode:hide()
  self.tapNode:hide()
  self.btnInfo:setImage(RoleRes .. "detail_b.png")
  self.btnSkin:setImage(RoleRes .. "detail_a.png")
  self.btnTap:setImage(RoleRes .. "detail_a.png")
  if type == 3 then
    self:showTalkFrame()
    return
  end
  local bFirst = type == 1
  local tempCsv = bFirst and PicCsv or FramCsv
  local origin = bFirst and game.role.headIconTag or game.role.headFrameTag
  local selected = origin
  local scale = bFirst and 0.7 or 0.5
  local size = display.newSprite(RoleRes .. "select_1.png"):getContentSize()
  size.width = self.iconList:getContentSize().width
  local Csv = table.values(tempCsv)
  table.sort(Csv, function(a, b)
    local lockA = game.role.items[a.item] and 0 or 1000
    local lockB = game.role.items[b.item] and 0 or 1000
    return lockA + a.order < lockB + b.order
  end)
  local rows = math.ceil(#Csv / 6)
  for row = 1, rows do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(size):addTo(self.iconList)
    for col = 1, 6 do
      local index = (row - 1) * 6 + col
      local xPos, yPos = 60 + (col - 1) * 100, 40
      local picData = Csv[index]
      if picData then
        if not bFirst then
          display.newSprite(RoleRes .. "icon_bg.png"):pos(xPos, yPos):addTo(viewNode)
        end
        local headIcon = UIHelper.newImageView(Csv[index].res):pos(xPos, yPos):addTo(viewNode)
        if bFirst then
          display.newSprite("ui/global/head_circle_bg.png"):center(headIcon):addTo(headIcon)
        end
        headIcon:scale(scale)
        if not game.role.items[picData.item] then
          display.newSprite("ui/global/lock.png"):pos(xPos, yPos):addTo(viewNode)
          headIcon:setCallback(function()
            MFlashMsg:show({
              text = picData.unlockDesc
            })
          end)
        else
          headIcon:setCallback(function()
            if self.circle then
              self.circle:removeSelf()
            end
            self.circle = display.newSprite(RoleRes .. "select_1.png"):pos(xPos, yPos):addTo(viewNode)
            selected = picData.id
          end)
          if picData.id == origin then
            self.circle = display.newSprite(RoleRes .. "select_1.png"):pos(xPos, yPos):addTo(viewNode)
          end
        end
      end
    end
  end
  self.iconList:requestDoLayout()
  self.changeIcon:setCallback(function()
    if origin == selected then
      local err = bFirst and SYS_ERR_ROLE_CHANGE_HEAD_USED or SYS_ERR_ROLE_CHANGE_FRAME_USED
      SysError(err)
      return
    end
    local rpc = bFirst and "Role_changeHeadIconRpc" or "Role_changeHeadFrameRpc"
    local err = bFirst and SYS_ERR_ROLE_CHANGE_HEAD_SUCCESS or SYS_ERR_ROLE_CHANGE_FRAME_SUCCESS
    game:sendData(actionCodes[rpc], MsgPack.pack({index = selected}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes[rpc], function(event)
      UIHelper.removeWaiting()
      origin = bFirst and game.role.headIconTag or game.role.headFrameTag
      self:refreshHead()
      SysError(err)
    end)
  end)
end

function RoleDetailLayer:showInfo(type)
  self.iconNode:hide()
  self.infoNode:show()
  self.skinNode:hide()
  self.tapNode:hide()
  self.group:hide()
  self.btnInfo:setImage(RoleRes .. "detail_b.png")
  self.btnSkin:setImage(RoleRes .. "detail_a.png")
  self.btnTap:setImage(RoleRes .. "detail_a.png")
  if not self.hadAddLab then
    display.newTTFLabel({
      text = "暂无资料",
      size = 20,
      color = UIHelper.hex2rgb("#702803")
    }):center(self.collectBg):addTo(self.collectBg)
    display.newTTFLabel({
      text = "暂无资料",
      size = 20,
      color = UIHelper.hex2rgb("#702803")
    }):center(self.travelBg):addTo(self.travelBg)
    self.hadAddLab = true
  end
end

function RoleDetailLayer:showSkin(type)
  self.iconNode:hide()
  self.infoNode:hide()
  self.skinNode:show()
  self.tapNode:hide()
  self.group:hide()
  self.btnInfo:setImage(RoleRes .. "detail_a.png")
  self.btnSkin:setImage(RoleRes .. "detail_b.png")
  self.btnTap:setImage(RoleRes .. "detail_a.png")
  self.skinList:removeAllChildren()
  local origin = game.role.homeBgTag
  local selected = origin
  local sortData = {}
  for _, data in ipairs(SkinCsv) do
    local temp = clone(data)
    if game.role.items[data.item] then
      temp.had = 1
    else
      temp.had = 0
    end
    table.insert(sortData, temp)
  end
  table.sort(sortData, function(a, b)
    return a.order - a.had * 10000 < b.order - b.had * 10000
  end)
  local size = display.newSprite(RoleRes .. "select_3.png"):getContentSize()
  size.height = self.skinList:getContentSize().height
  size.width = size.width + 10
  for index, data in ipairs(sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(size):addTo(self.skinList)
    local card = UIHelper.newImageView(data.smallRes):anch(0, 0):pos(5, 27):addTo(viewNode)
    display.newTTFLabel({
      text = data.name,
      size = 18,
      color = UIHelper.hex2rgb("#6f4925")
    }):pos(130, -12):addTo(card)
    if data.had > 0 then
      card:setCallback(function()
        self.block:removeSelf()
        self.block = display.newSprite(RoleRes .. "select_3.png"):center(card):addTo(card, 5)
        selected = data.id
      end)
    else
      local lookBtn = UIHelper.extend(ccui.Button:create())
      lookBtn:setImages(RoleRes, {"send.png", "send.png"})
      lookBtn:pos(218, 130):addTo(card)
      lookBtn:setCallback(function()
        self:hide()
        CommonHelper.playHomeBGM(data.id)
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
        local skinNode = display.newNode():pos(width / 2, height / 2):addTo(mask)
        local skinEffectNode = display.newNode():pos(width / 2, height / 2):addTo(mask)
        if UIHelper.isiPhoneX() then
          UIHelper.fitForiPhoneX(skinNode, true)
        end
        if data.changeByTime == 1 then
          local nowtime = game:nowTime()
          if data.spine ~= "" then
            local spineSkin
            if nowtime % 86400 <= 25200 then
              spineSkin = UIHelper.createSpineNodeByRes(string.format(data.spine, 1))
            elseif nowtime % 86400 <= 46800 then
              spineSkin = UIHelper.createSpineNodeByRes(string.format(data.spine, 2))
            else
              spineSkin = UIHelper.createSpineNodeByRes(string.format(data.spine, 3))
            end
            spineSkin:pos(0, 0):addTo(skinNode)
            spineSkin:addAnimation(0, "idle", true)
          elseif nowtime % 86400 <= 25200 then
            UIHelper.newImageView(string.format(data.res, 1)):pos(0, 0):addTo(skinNode)
          elseif nowtime % 86400 <= 46800 then
            UIHelper.newImageView(string.format(data.res, 2)):pos(0, 0):addTo(skinNode)
          else
            UIHelper.newImageView(string.format(data.res, 3)):pos(0, 0):addTo(skinNode)
          end
        elseif data.spine ~= "" then
          spineSkin = UIHelper.createSpineNodeByRes(data.spine)
          spineSkin:pos(0, 0):addTo(skinNode)
          spineSkin:addAnimation(0, "idle", true)
        else
          UIHelper.newImageView(data.res):pos(0, 0):addTo(skinNode)
        end
        if data.effect ~= "" then
          local yinghuo = cc.ParticleSystemQuad:create(data.effect .. ".plist")
          yinghuo:setPositionType(cc.POSITION_TYPE_RELATIVE)
          yinghuo:pos(0, -340):addTo(skinNode)
        end
        if data.spineEffect ~= "" then
          local spineEffect = UIHelper.createSpineNodeByRes(data.spineEffect)
          spineEffect:pos(0, 0):addTo(data.zorder == 1 and skinEffectNode or skinNode)
          spineEffect:addAnimation(0, "idle", true)
        end
        mask:setCallback(function()
          CommonHelper.playHomeBGM()
          self:show()
          mask:removeFromParent()
        end)
      end)
      display.newTTFLabel({
        text = "预览",
        size = 22,
        color = UIHelper.hex2rgb("#6F4925")
      }):pos(46, 17):addTo(lookBtn)
      display.newSprite("ui/global/lock.png"):pos(20, 120):addTo(card)
      local lockDes = display.newSprite(RoleRes .. "unlock_bg.png"):pos(136, 21):addTo(card)
      display.newTTFLabel({
        text = data.unlockDesc,
        size = 18,
        color = UIHelper.hex2rgb("#ffffff")
      }):enableOutline(UIHelper.hex2rgb("#000000"), 1):center(lockDes):addTo(lockDes)
    end
    display.newSprite(RoleRes .. "normal.png"):center(card):addTo(card)
    if data.id == origin then
      self.using = display.newSprite(RoleRes .. "using.png"):anch(0, 1):pos(7, 150):addTo(card)
      self.block = display.newSprite(RoleRes .. "select_3.png"):center(card):addTo(card, 5)
    end
  end
  self.skinList:requestDoLayout()
  self.changeSkin:setCallback(function()
    if origin == selected then
      SysError(SYS_ERR_ROLE_CHANGE_SKIN_USED)
      return
    end
    game:sendData(actionCodes.Role_changeHomeBgRpc, MsgPack.pack({index = selected}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Role_changeHomeBgRpc, function(event)
      UIHelper.removeWaiting()
      origin = game.role.homeBgTag
      self.using:removeSelf()
      self.using = display.newSprite(RoleRes .. "using.png"):anch(0, 1):pos(5, 150):addTo(self.block:getParent(), 0)
      CommonHelper.playHomeBGM()
      SysError(SYS_ERR_ROLE_CHANGE_SKIN_SUCCESS)
    end)
  end)
end

function RoleDetailLayer:showTap()
  self.iconNode:hide()
  self.infoNode:hide()
  self.skinNode:hide()
  self.tapNode:show()
  self.group:hide()
  self.btnInfo:setImage(RoleRes .. "detail_a.png")
  self.btnSkin:setImage(RoleRes .. "detail_a.png")
  self.btnTap:setImage(RoleRes .. "detail_b.png")
  self.tapList:removeAllChildren()
  local origin = game.role.tapTag or 1
  local selected = origin
  local sortData = {}
  for _, data in ipairs(TapCsv) do
    local temp = clone(data)
    if game.role.items[data.item] or data.id == 1 then
      temp.had = 1
    else
      temp.had = 0
    end
    table.insert(sortData, temp)
  end
  table.sort(sortData, function(a, b)
    return a.order - a.had * 10000 < b.order - b.had * 10000
  end)
  local size = display.newSprite("tap_effect/circle.png"):getContentSize()
  size.height = self.tapList:getContentSize().height
  size.width = size.width + 10
  for index, data in ipairs(sortData) do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(size):addTo(self.tapList)
    local circle = UIHelper.newImageView(TapRes .. data.res .. ".png"):anch(0, 0):pos(5, 37):addTo(viewNode)
    display.newTTFLabel({
      text = data.name,
      size = 18,
      color = UIHelper.hex2rgb("#6f4925")
    }):pos(70, -12):addTo(circle)
    if data.had > 0 then
      circle:setCallback(function()
        if self.block then
          self.block:removeSelf()
        end
        self.block = display.newSprite("tap_effect/chosen.png"):center(circle):addTo(circle, 5)
        selected = data.id
      end)
    else
      display.newSprite("ui/global/lock.png"):pos(70, 70):scale(1.7):addTo(circle)
      circle:setCallback(function()
        MFlashMsg:show({
          text = data.unlockDesc
        })
      end)
    end
    if data.id == origin then
      self.block = display.newSprite("tap_effect/chosen.png"):center(circle):addTo(circle, 5)
    end
  end
  self.tapList:requestDoLayout()
  self.changeTap:setCallback(function()
    if origin == selected then
      SysError(SYS_ERR_ROLE_CHANGE_TAP_USED)
      return
    end
    game:sendData(actionCodes.Role_changeTagEffectRpc, MsgPack.pack({index = selected}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Role_changeTagEffectRpc, function(event)
      UIHelper.removeWaiting()
      origin = game.role.tapTag
      UserData.tapTag = game.role.tapTag
      GameState.save(UserData)
      SysError(SYS_ERR_ROLE_CHANGE_TAP_SUCCESS)
    end)
  end)
end

function RoleDetailLayer:changeLayOut()
  local x, y = self.panel1:getPosition()
  if 320 < y and y < 460 then
    return
  end
  if self.showDown then
    self.group:hide()
    self.btnInfo:setImage(RoleRes .. "detail_a.png")
    self.btnSkin:setImage(RoleRes .. "detail_a.png")
    self.btnTap:setImage(RoleRes .. "detail_a.png")
    self.panel1:runAction(cc.MoveBy:create(0.2, cc.p(0, -147)))
    self.panel2:runAction(cc.MoveBy:create(0.2, cc.p(0, 147)))
    self.showDown = false
  else
    self.panel1:runAction(cc.MoveBy:create(0.2, cc.p(0, 147)))
    self.panel2:runAction(cc.MoveBy:create(0.2, cc.p(0, -147)))
    self.showDown = true
  end
end

return RoleDetailLayer
