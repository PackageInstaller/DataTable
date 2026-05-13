local HeadframCsv = require("csvdata.head_circle")
local HeadpicCsv = require("csvdata.head_pic")
local MainRes = "ui/union/main/"
local uiData = {
  csbFile = "ui/union/UnionRecruitLayer.csb",
  mask = true,
  popup = true,
  widgets = {
    touch = "touch",
    panel = "panel",
    list = "panel/list",
    title = "panel/title",
    btnClose = "panel/btnClose"
  }
}
local UnionRecruitLayer = class("UnionRecruitLayer", UIBase)

function UnionRecruitLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function UnionRecruitLayer:init(params)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.touch)
  end
  self.title:setString("招募")
  self.listData = params.list or {}
  self.touch:setSwallowTouches(true)
  self.touch:setTouchEnabled(true)
  self.btnClose:setCallback(function()
    BackManager:pop()
  end)
  self:initExtra()
end

function UnionRecruitLayer:initExtra()
  local status = game.role.unionData.auto or 0
  local blockBg = UIHelper.newImageView("ui/treat/block_bg.png"):pos(912, 90):addTo(self.panel)
  local imageYes = display.newSprite("ui/treat/yes.png"):pos(30, 30):addTo(blockBg)
  display.newTTFLabel({
    text = "自动通过符合要求的申请",
    size = 20
  }):enableOutline(UIHelper.hex2rgb("#472e25"), 2):anch(0, 0.5):pos(662, 90):addTo(self.panel)
  imageYes:setVisible(status == 1)
  blockBg:setCallback(function()
    game:sendData(actionCodes.Union_changeSetRpc, MsgPack.pack({type = 1}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Union_changeSetRpc, function(event)
      UIHelper.removeWaiting()
      status = status == 1 and 0 or 1
      imageYes:setVisible(status == 1)
    end)
  end)
  display.newTTFLabel({
    text = "请输入等级限制",
    size = 24,
    color = UIHelper.hex2rgb("#6f4925")
  }):anch(1, 0.5):pos(200, 87):addTo(self.panel)
  display.newTTFLabel({
    text = "级",
    size = 24,
    color = UIHelper.hex2rgb("#6f4925")
  }):anch(0, 0.5):pos(470, 87):addTo(self.panel)
  local levelBg = display.newSprite(MainRes .. "recruit_level_bg.png"):pos(337, 87):addTo(self.panel)
  local level = game.role.unionData.limit
  local levelContent = display.newTTFLabel({text = level, size = 26}):pos(22, 22):addTo(levelBg)
  local xPos = {
    230,
    285,
    390,
    445
  }
  local values = {
    -10,
    -1,
    1,
    10
  }
  for idx, count in ipairs(values) do
    local btn = UIHelper.newImageView("ui/union/recruit/btn_2.png"):pos(xPos[idx], 87):addTo(self.panel)
    btn:setCallback(function()
      local temp = level
      level = math.min(100, math.max(level + count, 1))
      levelContent:setString(level)
      if temp == level then
        return
      end
      game:sendData(actionCodes.Union_changeSetRpc, MsgPack.pack({type = 4, value = level}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Union_changeSetRpc, function(event)
        UIHelper.removeWaiting()
      end)
    end)
    display.newTTFLabel({
      text = string.format(idx < 3 and "%d" or "+%d", count),
      size = 20
    }):enableOutline(UIHelper.hex2rgb("#8A450E"), 1):pos(25, 25):addTo(btn)
  end
  display.newTTFLabel({
    text = "入团宣言",
    size = 24
  }):anch(1, 0.5):pos(157, 43):addTo(self.panel)
  local descInput = ccui.EditBox:create(cc.size(590, 42), MainRes .. "recruit_desc_bg.png")
  descInput:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
  descInput:setFontSize(20)
  descInput:setMaxLength(40)
  descInput:setPlaceHolder("请输入宣言")
  descInput:setPlaceholderFontSize(20)
  descInput:setPlaceholderFontColor(UIHelper.hex2rgb("#998271"))
  descInput:anch(1, 0.5):pos(810, 42):addTo(self.panel)
  descInput:setFontColor(UIHelper.hex2rgb("#dea826"))
  if game.role.unionData.desc ~= "" then
    descInput:setText(game.role.unionData.desc)
  end
  local btnSave = UIHelper.extend(ccui.Button:create())
  btnSave:setImages("ui/union/recruit/", {"btn_3.png", "btn_3.png"})
  btnSave:setString({text = "确定", size = 24})
  btnSave:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#8A450E"), 1)
  btnSave:pos(890, 44):addTo(self.panel):setTouchScale()
  btnSave:setCallback(function()
    local str = descInput:getText()
    if str == "" then
      return
    end
    game:sendData(actionCodes.Union_changeSetRpc, MsgPack.pack({type = 2, desc = str}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Union_changeSetRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      if msg.code then
        SysError(msg.code)
        return
      end
      SysError(SYS_ERR_UNION_HANDLE_SUCCESS)
    end)
  end)
end

function UnionRecruitLayer:showData(params)
  if self.refreshHandler then
    scheduler.unscheduleGlobal(self.refreshHandler)
  end
  self.curIndex = 0
  self.list:removeAllChildren()
  self.refreshHandler = scheduler.scheduleGlobal(function()
    self:showList()
  end, 0.016666666666666666)
end

function UnionRecruitLayer:showList()
  for idx = self.curIndex + 1, self.curIndex + 10 do
    if idx > #self.listData then
      if self.refreshHandler then
        scheduler.unscheduleGlobal(self.refreshHandler)
        self.refreshHandler = nil
      end
      if not next(self.listData) then
        display.newTTFLabel({
          text = "暂无加入申请",
          size = 24,
          color = UIHelper.hex2rgb("#6f4925")
        }):center(self.list):addTo(self.list)
      end
      self.list:requestDoLayout()
      self.list:jumpToTop()
      return
    end
    local data = self.listData[idx]
    self:createCell(data, idx):addTo(self.list)
  end
  self.curIndex = self.curIndex + 10
end

function UnionRecruitLayer:createCell(data, index)
  local viewNode = ccui.Widget:create()
  viewNode:setContentSize(cc.size(934, 126))
  local cell = display.newSprite(MainRes .. "cell.png"):center(viewNode):addTo(viewNode)
  local bg = UIHelper.newImageView(HeadpicCsv[data.headIconTag].res):scale(0.8):pos(60, 63):addTo(cell)
  display.newSprite(HeadframCsv[data.headFrameTag].res):center(bg):addTo(bg)
  display.newTTFLabel({
    text = "Lv" .. data.level,
    size = 36,
    color = UIHelper.hex2rgb("#ba471a")
  }):anch(0, 0.5):pos(140, 85):addTo(cell)
  display.newTTFLabel({
    text = data.name,
    size = 28,
    color = UIHelper.hex2rgb("#ba471a")
  }):anch(0, 0.5):pos(257, 85):addTo(cell)
  display.newTTFLabel({
    text = data.desc == "" and "无" or data.desc,
    size = 16,
    color = UIHelper.hex2rgb("#fdfffa"),
    dimensions = cc.size(642, 0)
  }):enableOutline(UIHelper.hex2rgb("#1e0b03"), 1):anch(0, 1):pos(120, 44):addTo(cell)
  local btnAgree = UIHelper.extend(ccui.Button:create())
  btnAgree:setImages("ui/friend/main/", {
    "btn_agree.png",
    "btn_agree.png"
  })
  btnAgree:setString({text = "同意", size = 20})
  btnAgree:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#000000"), 1)
  btnAgree:pos(855, 92):addTo(cell):setTouchScale()
  local btnAgainst = UIHelper.extend(ccui.Button:create())
  btnAgainst:setImages("ui/friend/main/", {
    "btn_against.png",
    "btn_against.png"
  })
  btnAgainst:setString({text = "拒绝", size = 20})
  btnAgainst:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#000000"), 1)
  btnAgainst:pos(855, 33):addTo(cell):setTouchScale()
  btnAgree:setCallback(function()
    game:sendData(actionCodes.Union_changeMemberRpc, MsgPack.pack({
      type = 1,
      id = data.id
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Union_changeMemberRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      if msg.code then
        SysError(msg.code)
        return
      end
      table.remove(self.listData, index)
      self:showData()
    end)
  end)
  btnAgainst:setCallback(function()
    game:sendData(actionCodes.Union_changeMemberRpc, MsgPack.pack({
      type = 4,
      id = data.id
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Union_changeMemberRpc, function(event)
      UIHelper.removeWaiting()
      table.remove(self.listData, index)
      self:showData()
    end)
  end)
  return viewNode
end

function UnionRecruitLayer:onExit()
  if self.refreshHandler then
    scheduler.unscheduleGlobal(self.refreshHandler)
  end
end

return UnionRecruitLayer
