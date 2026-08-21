local ItemCsv = require("csvdata.item")
local ThemeCsv = require("csvdata.diner_box")
local FitmentCsv = require("csvdata.diner_fitment")
local HeadframCsv = require("csvdata.head_circle")
local HeadpicCsv = require("csvdata.head_pic")
local BoxMainRes = "ui/diner/box/"
local RewardRes = "ui/common/reward/"
local channelConfigs = require("sdk.ChannelConfigs")
local config = channelConfigs[CHANNEL_KEY]
local uiData = {
  csbFile = "ui/diner/DinerBoxLookLayer.csb",
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
    btnBack = "btnBack",
    detailBg = "detailBg",
    roleName = "detailBg/roleName",
    comfortCount = "detailBg/comfortCount",
    likeCount = "detailBg/likeCount",
    likeBtn = "likeBtn",
    nextBox = "nextBox"
  }
}
local DinerBoxLookLayer = class("DinerBoxLookLayer", UIBase)

function DinerBoxLookLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function DinerBoxLookLayer:init(params)
  local spine = UIHelper.createSpineNodeByRes("diner/box/bdh_bg")
  spine:pos(0.5, 0.5):addTo(self.mainBgNode)
  spine:setAnimation(0, "special", true)
  local size = cc.size(display.width, display.height)
  if UIHelper.isiPhoneX() then
    size = cc.size(1386, 640)
    self.comfortBg:setPositionX(self.comfortBg:getPositionX() - 75)
    self.homeBg:setPositionX(self.homeBg:getPositionX() - UIHelper.getMoveXForX())
    self.content:setPositionX(self.content:getPositionX() - UIHelper.getMoveXForX())
    self.mainBgNode:setPositionX(self.mainBgNode:getPositionX() - UIHelper.getMoveXForX())
    self.detailBg:setPositionX(self.detailBg:getPositionX() - 75)
    self.btnBack:setPositionX(self.btnBack:getPositionX() + UIHelper.getMoveXForX())
    self.likeBtn:setPositionX(self.likeBtn:getPositionX() + UIHelper.getMoveXForX())
    self.nextBox:setPositionX(self.nextBox:getPositionX() + UIHelper.getMoveXForX())
  end
  self.allData = params or {}
  self.nameState = false
  self.isChange = false
  self.curBox = params.boxId or 1
  local Names = {
    "btnHome",
    "btnBack",
    "likeBtn",
    "nextBox"
  }
  for _, name in pairs(Names) do
    self[name]:setTouchScale()
  end
  self.btnHome:setCallback(function()
    game:enterScene("MainScene")
  end)
  self.btnBack:setCallback(function()
    BackManager:pop()
  end)
  self.nextBox:setCallback(function()
    self:lookNext()
  end)
  if not (self.allData.allList and next(self.allData.allList)) or #self.allData.allList == 1 then
    self.nextBox:hide()
  else
    self.nextBox:runAction(cc.RepeatForever:create(transition.sequence({
      cc.FadeOut:create(0.5),
      cc.DelayTime:create(0.2),
      cc.FadeIn:create(0.5),
      cc.DelayTime:create(0.2)
    })))
  end
  self.likeBtn:setCallback(function()
    if 0 < game.role.dailyBoxLikeRecord:getv(self.allData.roleId, 0) then
      return
    end
    game:sendData(actionCodes.Diner_likeOtherBoxRpc, MsgPack.pack({
      roleId = self.allData.roleId
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Diner_likeOtherBoxRpc, function(event)
      UIHelper.removeWaiting()
      local spr = display.newSprite("ui/diner/box/like_small.png"):addTo(self.likeBtn):pos(30, 40)
      spr:setCascadeOpacityEnabled(true)
      display.newTTFLabel({
        text = "+1",
        size = 20,
        color = UIHelper.hex2rgb("#ba471a")
      }):anch(0, 0.5):addTo(spr):pos(30, 9)
      spr:runAction(transition.sequence({
        cc.MoveBy:create(0.5, cc.p(0, 50)),
        cc.Spawn:create({
          cc.MoveBy:create(0.5, cc.p(0, 100)),
          cc.FadeOut:create(0.5)
        }),
        cc.RemoveSelf:create()
      }))
      self.allData.like = self.allData.like + 1
      self.likeCount:setString(self.allData.like)
      self.likeBtn:setTouchEnabled(false)
      self.likeBtn:setBright(false)
    end)
  end)
  if 0 < game.role.dailyBoxLikeRecord:getv(self.allData.roleId, 0) then
    self.likeBtn:setTouchEnabled(false)
    self.likeBtn:setBright(false)
  end
  local bg = UIHelper.newImageView(HeadpicCsv[self.allData.headIconTag].res):pos(65, 60):addTo(self.detailBg)
  display.newSprite(HeadframCsv[self.allData.headFrameTag].res):scale(0.8):center(bg):addTo(bg)
  self.roleName:setString(self.allData.name)
  self.comfortCount:setString("满足度: " .. self.allData.comfortPoint)
  self.likeCount:setString(self.allData.like)
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
    local boxData = ThemeCsv[self.allData.boxes[self.curBox].box][self.allData.boxLevel]
    game:createView("diner.DinerTalentLayer", {
      boxData = boxData,
      comfort = self.boxLogic:getHotPoint()
    })
  end)
  self.scrollView = cc.ScrollView:create()
  self.scrollView:setViewSize(size)
  self.scrollView:addTo(self.content)
  self.scrollView:setBounceable(false)
  self.scrollView:setMaxScale(1.5)
  self.scrollView:setMinScale(0.6)
end

function DinerBoxLookLayer:showData(params)
  self.scrollView:getContainer():removeAllChildren()
  self.boxLogic = game:createView("diner.DinerBoxLogic", {
    boxData = self.allData.boxes[self.curBox],
    boxLevel = self.allData.boxLevel,
    heroInfo = self.allData.heroInfo,
    content = self.scrollView,
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
  if self.allData.boxes[self.curBox].box ~= 0 then
    local hot = self.boxLogic:getHotPoint()
    local boxData = ThemeCsv[self.allData.boxes[self.curBox].box][self.allData.boxLevel]
    for index, data in ipairs(boxData.talent:toTableArray()) do
      if hot >= tonumber(data[1]) then
        self.num:setString(index)
      end
    end
  end
  self.name:setString("便当盒" .. self.curBox)
  self:updateConfort()
end

function DinerBoxLookLayer:updateConfort()
  self.comfort:setString(string.format("满足度:%d", self.boxLogic:getHotPoint()))
end

function DinerBoxLookLayer:showPanel()
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

function DinerBoxLookLayer:closePanel()
  self.boxLogic:onBoxShow()
  self.panel:runAction(transition.sequence({
    cc.MoveTo:create(0.1, cc.p(0, -210)),
    cc.CallFunc:create(function()
      self.isChange = false
    end)
  }))
end

function DinerBoxLookLayer:showSelectBox()
  self.nameState = not self.nameState
  if not self.nameState then
    self.homeBg:removeChildByTag(1000)
    self.btnName:setImage(BoxMainRes .. "image_up.png")
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
  for i = 1, globalCsv.dinerBoxNumMax do
    if not (self.allData.boxes[i] and self.allData.boxes[i].box) or 1 > self.allData.boxes[i].box then
      break
    end
    local btn = UIHelper.newImageView(BoxMainRes .. "box_name_bg.png"):pos(xPos, yPos):addTo(mask)
    btn:setLocalZOrder(globalCsv.dinerBoxNumMax - i)
    btn:setCallback(function()
      if self.curBox == i then
        self:showSelectBox()
        return
      end
      self.curBox = i
      self.name:setString(string.format("便当盒%d", i))
      self:showSelectBox()
      self:showData()
    end)
    display.newTTFLabel({
      text = string.format("便当盒%d", i),
      size = 24,
      color = UIHelper.hex2rgb("#440b0b")
    }):center(btn):addTo(btn)
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

function DinerBoxLookLayer:lookNext()
  if not (self.allData.allList and next(self.allData.allList)) or #self.allData.allList == 1 then
    return
  end
  local cur
  for i = 1, #self.allData.allList do
    if self.allData.roleId == self.allData.allList[i] then
      cur = i
      break
    end
  end
  
  local function getNextRoleId()
    local nextOne = (cur + 1) % #self.allData.allList
    if nextOne == 0 then
      nextOne = #self.allData.allList
    end
    cur = nextOne
    return self.allData.allList[cur]
  end
  
  local function getCanUseId()
    local newId = getNextRoleId()
    if newId == game.role.id then
      newId = getNextRoleId()
    end
    return newId
  end
  
  local enterBox
  
  function enterBox()
    game:sendData(actionCodes.Diner_getBoxDataRpc, MsgPack.pack({
      roleId = getCanUseId()
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Diner_getBoxDataRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      if msg.boxData then
        if not msg.boxData.boxes[1].box then
          enterBox()
          return
        end
        msg.boxData.allList = self.allData.allList
        local popCallBack = BackManager:front()
        game:enterScene("DinerScene", {
          boxData = msg.boxData,
          layerType = "look"
        })
        BackManager:push(popCallBack)
      else
        enterBox()
      end
    end)
  end
  
  enterBox()
end

function DinerBoxLookLayer:onEnter()
  _G.touchMaskEnabled = false
end

function DinerBoxLookLayer:onExit()
  _G.touchMaskEnabled = true
end

return DinerBoxLookLayer
