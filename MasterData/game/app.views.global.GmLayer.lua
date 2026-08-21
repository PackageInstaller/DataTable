local uiData = {
  csbFile = "ui/global/GMLayer.csb",
  order = GM_LAYER_ORDER,
  widgets = {
    center = "center",
    sendBtn = "sendBtn",
    closeBtn = "closeBtn"
  }
}
local GmLayer = class("GmLayer", UIBase)

function GmLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function GmLayer:init(...)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.center, true)
    self.sendBtn:setPositionX(self.sendBtn:getPositionX() + UIHelper.getMoveXForX())
    self.closeBtn:setPositionX(self.closeBtn:getPositionX() - UIHelper.getMoveXForX())
  end
  local path = cc.FileUtils:getInstance():fullPathForFilename("csvdata/gm.txt")
  local str = "GM指令使用指南:\n\n" .. "更换账号          reset后重启客户端\n" .. "添加食灵          hero+空格+食灵id+空格+等级+空格+品质等级\n" .. "添加道具\t         get+空格+道具id+空格+数量\n\n" .. "可用食灵id:     101\t  水饺               401   帝王蛋糕\n" .. "                     102   扬州炒饭        402   甜甜圈\n" .. "                     103   热香饼           403   九层糕\n" .. "                     104   墨西哥卷饼\t    404   焦糖布丁\n" .. "                     201   麻婆豆腐        408   提拉米苏\n" .. "                     202   宫爆鸡丁        502   薯条\n" .. "                     301   天妇罗           601   奶油蘑菇汤\n" .. "                     304   玉子烧           602   蓝色玛格丽特\n\n" .. "可用道具id:     1   食油    31  快速烹饪    91  蓝色种子    71  种植加速1小时\n" .. "                     2   魔力    32  快速治疗    92  绿色种子    72  种植加速2小时\n" .. "                     3   食材    33  快速研究    93  红色种子    73  种植加速3小时\n" .. "                     4   调料    34  快速委托    99  种植材料    74  种植加速4小时\n" .. "                     28  料理券\n\n" .. "                     81~86 种植产出职业偏向道具\n" .. "                     801~808 低、中、高好感度道具"
  local text = display.newTTFLabel({
    text = str,
    size = 22,
    color = UIHelper.hex2rgb("#ffffff")
  }):anch(0, 1):pos(165, 530):addTo(self)
  local gmEditBox = ccui.EditBox:create(cc.size(300, 60), "ui/global/base_bg.png")
  gmEditBox:setReturnType(cc.KEYBOARD_RETURNTYPE_SEND)
  gmEditBox:setFontSize(18)
  gmEditBox:setPlaceHolder("gm command")
  gmEditBox:anch(0, 0.5):pos(360, self.sendBtn:getPositionY()):addTo(self, 10)
  self.closeBtn:setCallback(function(sender)
    self:close()
  end)
  self.sendBtn:setCallback(function(sender)
    local msg = string.split(gmEditBox:getText(), " ")
    if not msg[1] then
      return
    end
    local cmd = string.lower(msg[1])
    local cmds = {
      q = function()
        self:close()
      end,
      red = function()
        dump(game.role.redPoints)
        print(game.role.dailyTaskStatusNew)
        dump(game.role.dailyTasks)
        self:close()
      end,
      check = function()
        self:hide()
        HeroRewardLayer.new({
          type = tonumber(msg[2]),
          callback = function()
            self:show()
          end
        })
      end,
      reset = function()
        UserData = {
          music = 100,
          sound = 100,
          cv = 100,
          auto = 0
        }
        GameState.save(UserData)
      end,
      robot = function()
        self:sweepCarbons()
        self:close()
      end,
      ["break"] = function()
        for index = 1, msg[2] do
          local bin = MsgPack.pack({
            cmd = "get",
            token = GmToken,
            pm1 = 3000 + index,
            pm2 = 1000,
            pm3 = nil,
            pm4 = nil,
            pm5 = nil
          })
          game:sendData(actionCodes.Gm_clientRequest, bin, #bin)
          game:addResponseHandler(actionCodes.Gm_receiveResponse, function(event)
            local msg = MsgPack.unpack(event.data)
            MFlashMsg:show({
              text = msg.cmd
            })
          end)
        end
      end,
      bat = function()
        local bin = MsgPack.pack({
          cmd = string.lower(msg[1]),
          token = GmToken,
          pm1 = string.lower(msg[2]),
          pm2 = string.lower(msg[3] or "")
        })
        game:sendData(actionCodes.Gm_clientRequest, bin, #bin)
        game:addResponseHandler(actionCodes.Gm_receiveResponse, function(event)
          local msg = MsgPack.unpack(event.data)
          MFlashMsg:show({
            text = msg.cmd
          })
          self:close()
        end)
      end,
      testplayer = function()
        self:createTestAccount("pvpTest", 13066, 13150)
      end,
      autobattle = function()
        game:sendData(actionCodes.Carbon_autoCleanFormsRpc, MsgPack.pack({}))
      end
    }
    if cmds[cmd] then
      cmds[cmd](self)
    else
      local bin = MsgPack.pack({
        cmd = string.lower(msg[1]),
        token = GmToken,
        pm1 = tonumber(msg[2]),
        pm2 = tonumber(msg[3]),
        pm3 = tonumber(msg[4]),
        pm4 = tonumber(msg[5]),
        pm5 = tonumber(msg[6])
      })
      game:sendData(actionCodes.Gm_clientRequest, bin, #bin)
      game:addResponseHandler(actionCodes.Gm_receiveResponse, function(event)
        local msg = MsgPack.unpack(event.data)
        MFlashMsg:show({
          text = msg.cmd
        })
      end)
    end
  end)
  local dinerBtn = UIHelper.extend(ccui.Button:create())
  dinerBtn:setImages("ui/global/", {
    "ok_normal.png",
    "ok_selected.png"
  })
  dinerBtn:pos(75, 120):addTo(self)
  dinerBtn:setString({
    text = "家具设置"
  })
  dinerBtn:setCallback(function()
    self:showDinerLayer()
  end)
end

function GmLayer:createTestAccount(name, rank, rankEnd)
  local host = "127.0.0.1"
  local port = 9898
  if rankEnd < rank then
    return
  end
  NetManager:removeEventListenersByEvent("networkConnected")
  NetManager:addEventListener("networkConnected", function(e1)
    e1.stop(e1)
    NetManager:removeEventListenersByEvent("networkConnected")
    local bin = MsgPack.pack({
      uid = name .. rank,
      subId = 1
    })
    NetManager:removeResponseHandler(actionCodes.Role_queryLoginRpc)
    local result = NetManager:sendData(actionCodes.Role_queryLoginRpc, bin)
    print("查询账号")
    NetManager:setTimeout(15)
    NetManager:addResponseHandler(actionCodes.Role_queryLoginRpc, function(e2)
      local msg = MsgPack.unpack(e2.data)
      NetManager:clearTimeout()
      if msg.ret == "RET_NOT_EXIST" then
        local bin = MsgPack.pack({
          uid = name .. rank,
          subId = 1,
          device = device.getOpenUDID()
        })
        NetManager:removeResponseHandler(actionCodes.Role_createRpc)
        NetManager:sendData(actionCodes.Role_createRpc, bin)
        print("创建账号")
        NetManager:setTimeout(30)
        NetManager:addResponseHandler(actionCodes.Role_createRpc, function(e3)
          local msg = MsgPack.unpack(e3.data)
          NetManager:clearTimeout()
          if msg.result == "SUCCESS" then
            print("成功创建")
            local bin = MsgPack.pack({
              name = msg.roleName,
              device = device.getOpenUDID()
            })
            NetManager:removeResponseHandler(actionCodes.Role_loginRpc)
            NetManager:sendData(actionCodes.Role_loginRpc, bin)
            print("登录")
            NetManager:setTimeout(60)
            NetManager:addResponseHandler(actionCodes.Role_loginRpc, function(event)
              local msg = MsgPack.unpack(event.data)
              if msg.result == "GM_TIP" then
                print("登录失败")
              end
              if msg.result == "BAN_TIP" then
                print("登录失败_封号")
              end
              NetManager:removeResponseHandler(actionCodes.Role_loginRpc)
              print("登录成功")
              print("pvp 上阵")
              game:sendData(actionCodes.Pvp_changeFormatRpc, MsgPack.pack({slot = 1, heroId = 1}))
              game:addResponseHandler(actionCodes.Pvp_changeFormatRpc, function(event)
                print("pvp 队伍上阵成功")
                print("调整 pvp 分数")
                local bin = MsgPack.pack({
                  cmd = string.lower("pvp"),
                  token = GmToken,
                  pm1 = 3,
                  pm2 = rank
                })
                game:sendData(actionCodes.Gm_clientRequest, bin, #bin)
                game:addResponseHandler(actionCodes.Gm_receiveResponse, function(event)
                  local msg = MsgPack.unpack(event.data)
                  print(msg.cmd)
                  print("调整完成  " .. rank)
                  NetManager:closeSocket()
                  print("断开连接")
                  self:createTestAccount(name, rank + 1, rankEnd)
                end)
              end)
            end, true)
          else
            print("失败")
          end
        end)
      elseif msg.ret == "RET_HAS_EXISTED" then
        print("已经存在")
        NetManager:closeSocket()
        print("断开连接")
        self:createTestAccount(name, rank + 1, rankEnd)
      elseif msg.ret == "RET_SERVER_FULL" then
        print("失败")
      elseif msg.ret == "INNER_ERROR" then
        print("错误")
      end
    end)
  end)
  print("正在连接")
  NetManager:setTimeout(15, function()
    print("连接失败")
    NetManager:removeEventListenersByEvent("networkConnected")
  end)
  if not NetManager:newSocket(host, port) then
    NetManager:removeEventListenersByEvent("networkConnected")
    print("连接失败")
    return
  end
end

function GmLayer:showDinerLayer()
  local mask = UIHelper.newMask({
    size = cc.size(display.width, display.height),
    color = "#000000"
  })
  mask:addTo(self)
  local list = ccui.ListView:create()
  list:size(cc.size(300, 640))
  list:setInnerContainerSize(cc.size(300, 640))
  list:setClippingEnabled(true)
  list:setBounceEnabled(true)
  list:setItemsMargin(10)
  list:anch(0, 0):pos(0, 0):addTo(mask)
  self.dinerNode = display.newNode():pos(300, 0):addTo(mask)
  local path = cc.FileUtils:getInstance():fullPathForFilename("../documents/csv/diner_fitment.csv")
  local file = {}
  self.keys = {}
  for line in io.lines(path) do
    table.insert(file, line)
    local data = line:split(",")
    if 0 < #data and 0 < checknumber(data[1]) then
      local key = checknumber(data[1])
      self.keys[key] = {
        row = #file,
        type = checknumber(data[3]),
        bgRes = data[4],
        center = data[5]
      }
      local viewNode = ccui.Widget:create()
      viewNode:size(300, 40):addTo(list)
      local cell = UIHelper.newMask({
        size = cc.size(300, 40),
        color = "#ffffff"
      })
      cell:addTo(viewNode)
      display.newTTFLabel({
        text = data[1],
        size = 20,
        color = UIHelper.hex2rgb("#000000")
      }):anch(0, 0.5):pos(5, 20):addTo(cell)
      display.newTTFLabel({
        text = string.format("res=%s", data[4]),
        size = 20,
        color = UIHelper.hex2rgb("#000000")
      }):anch(0, 0.5):pos(60, 20):addTo(cell)
      cell:setCallback(function()
        self.model = 1
        self:selectFitment(cell, key)
      end)
    end
  end
  local saveBtn = UIHelper.extend(ccui.Button:create())
  saveBtn:setImages("ui/global/", {
    "ok_normal.png",
    "ok_selected.png"
  })
  saveBtn:pos(1050, 600):addTo(mask)
  saveBtn:setString({
    text = "保存退出"
  })
  saveBtn:setCallback(function()
    for key, data in pairs(self.keys) do
      if data.newCenter then
        local fileLine = file[data.row]
        file[data.row] = fileLine:gsub(data.center, data.newCenter)
      end
    end
    local content = table.concat(file, "\n")
    content = content .. "\n"
    io.writefile(path, content)
    mask:removeSelf()
  end)
end

function GmLayer:selectFitment(cell, key)
  self.dinerNode:removeAllChildren()
  selected = nil
  local modelBtn = UIHelper.extend(ccui.Button:create())
  modelBtn:setImages("ui/global/", {
    "ok_normal.png",
    "ok_selected.png"
  })
  modelBtn:pos(300, 600):addTo(self.dinerNode)
  modelBtn:setString({
    text = "模式" .. self.model
  })
  modelBtn:setCallback(function()
    self.model = self.model + 1
    if self.model > 2 then
      self.model = 1
    end
    self:selectFitment(cell, key)
  end)
  local data = self.keys[key]
  local fitment = display.newSprite("diner/fit/" .. data.bgRes)
  local size = fitment:getContentSize()
  local bg = UIHelper.newMask({size = size, color = "#ffffff"}):anch(0.5, 0.5):pos(300, 320):addTo(self.dinerNode)
  fitment:center(bg):addTo(bg)
  if data.type ~= 3 then
    local row = math.ceil(size.height / 25)
    local col = math.ceil(size.width / 50)
    for r = 1, row do
      for l = 1, col do
        local x = 100 * (l - 1)
        local y = 25 * (r - 1)
        if r % 2 == 0 then
          x = x + 50
        end
        if self.model == 2 then
          y = y + 25
        end
        if x - 50 < size.width then
          local floor = UIHelper.newImageView("ui/diner/box/debug_floor.png"):pos(x, y):addTo(bg)
          local touchLayer = UIHelper.newMask({
            size = cc.size(50, 25)
          }):anch(0.5, 0.5):pos(x, y):addTo(bg)
          touchLayer:setCallback(function()
            if selected then
              selected:setImage("ui/diner/box/debug_floor.png")
            end
            floor:setImage("ui/diner/box/rect_ok.png")
            selected = floor
            data.newCenter = string.format("%d=%d", x, y)
          end)
        end
      end
    end
  else
    local row = math.ceil(size.height / 50) + 1
    local col = math.ceil(size.width / 50) + 1
    for l = 1, col do
      for r = 1, row do
        local x = 50 * (l - 1)
        local y = 50 * (r - 1) - (l - 1) * 25
        if self.model == 2 then
          y = y + 25
        end
        local wall = UIHelper.newImageView("ui/diner/box/debug_wall.png"):anch(0, 0):pos(x, y):addTo(bg)
        local touchLayer = UIHelper.newMask({
          size = cc.size(50, 40)
        }):anch(0.5, 0.5):pos(25, 37.5):addTo(wall)
        touchLayer:setCallback(function()
          if selected then
            selected:setImage("ui/diner/box/debug_wall.png")
          end
          wall:setImage("ui/diner/box/wall_ok.png")
          selected = wall
          data.newCenter = string.format("%d=%d", x + 25, y + 37.5)
        end)
      end
    end
  end
end

return GmLayer
