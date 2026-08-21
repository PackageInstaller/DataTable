local MainRes = "ui/chat/inform/"
local InformLayer = class("InformLayer", function()
  return UIHelper.extend(ccui.Layout:create())
end)

function InformLayer:ctor(params)
  self.params = params or {}
  self:uiLayout(params)
  self:showData(params)
end

function InformLayer:uiLayout(params)
  self:size(cc.size(display.width, display.height))
  self:setBackGroundColorType(1)
  self:setBackGroundColor(cc.c3b(0, 0, 0))
  self:setBackGroundColorOpacity(191)
  self:setTouchEnabled(true)
  self:addTo(display.getRunningScene(), POPUP_LAYER_ORDER)
  self.Data = {}
  self.mainBg = display.newSprite(MainRes .. "main_bg.png"):pos(display.cx, display.cy - 10):addTo(self)
  local cancelBtn = UIHelper.extend(ccui.Button:create())
  cancelBtn:setImages("ui/global/", {
    "dialog_ok.png",
    "dialog_ok.png"
  })
  cancelBtn:setString({text = "取消", size = 22})
  cancelBtn:setTouchScale()
  cancelBtn:pos(175, 40):addTo(self.mainBg)
  cancelBtn:setCallback(function()
    BackManager:pop()
  end)
  local informBtn = UIHelper.extend(ccui.Button:create())
  informBtn:setImages("ui/global/", {
    "dialog_cancel.png",
    "dialog_cancel.png"
  })
  informBtn:setString({text = "举报", size = 22})
  informBtn:setTouchScale()
  informBtn:pos(525, 40):addTo(self.mainBg)
  informBtn:setCallback(function()
    if not self.Data.type then
      SysError(SYS_ERR_CHAT_CHOOSE_INFORM_TYPE)
      return
    end
    game:sendData(actionCodes.Friend_report, MsgPack.pack(self.Data))
    local str = UserData.informStr or ""
    UserData.informStr = str:setv(params.role.roleId, 1)
    GameState.save(UserData)
    BackManager:pop()
  end)
  cancelBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  informBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
end

function InformLayer:showData(params)
  local role = params.role
  local chat = params.chatData
  self.Data.content = chat.content
  self.Data.targetId = role.roleId
  self.Data.selfId = game.role.id
  display.newTTFLabel({
    text = string.format("举报玩家(屏蔽不可解除):%s", role.name),
    size = 26,
    color = UIHelper.hex2rgb("#d53b1c")
  }):anch(0.5, 0.5):pos(340, 255):addTo(self.mainBg)
  local texts = {
    [1] = "滥发广告信息",
    [2] = "谩骂、人身攻击",
    [3] = "外挂相关",
    [4] = "诈骗、钓鱼、色情等不良信息",
    [5] = "不恰当的游戏昵称",
    [6] = "其他"
  }
  local xPos, yPos = 180, 200
  local group = MRadioGroup:create({
    chooseCb = function(sender)
      local text = sender:getChildByName("text")
      text:setTextColor(UIHelper.hex2rgb("#d53b1c"))
    end,
    unchooseCb = function(sender)
      local text = sender:getChildByName("text")
      text:setTextColor(UIHelper.hex2rgb("#612d06"))
    end
  })
  for i, desc in ipairs(texts) do
    local btn = UIHelper.extend(ccui.Button:create())
    btn:setImages(MainRes, {"btn_1.png", "btn_2.png"})
    btn:name(tostring(i))
    btn:pos(xPos, yPos):addTo(self.mainBg)
    btn:setCallback(function()
      self.Data.type = desc
    end)
    display.newTTFLabel({
      text = desc,
      size = 16,
      color = UIHelper.hex2rgb("#612d06")
    }):anch(0, 0.5):pos(40, 15):addTo(btn):name("text")
    btn:setGroup(group)
    yPos = yPos - 40
    if i == 3 then
      xPos = 465
      yPos = 200
    end
  end
end

function InformLayer:close()
  self:removeSelf()
end

return InformLayer
