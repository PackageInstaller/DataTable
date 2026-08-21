local UnitCsv = require("csvdata.unit")
local ChapterBattleCsv = require("csvdata.chapter_battle")
local TaskCsv = require("csvdata.consignation")
local ItemCsv = require("csvdata.item")
local infoOldRes = "ui/home/formatInfo/"
local infoNewRes = "ui/newhome/formatInfo/"
local HomeRes = "ui/home/"
local uiData = {
  csbFile = "ui/home/ShowFormationInfoLayer.csb",
  widgets = {
    mask = "mask",
    listBg = "listBg",
    list = "listBg/list"
  }
}
local infoRes
local ShowFormationInfoLayer = class("ShowFormationInfoLayer", UIBase)

function ShowFormationInfoLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function ShowFormationInfoLayer:init(params)
  local posy = 271
  infoRes = infoOldRes
  if game.role.homeType ~= nil and game.role.homeType == 2 and globalCsv.newHomeOpen == 1 then
    infoRes = infoNewRes
    posy = 460
  end
  self.scene = params.scene
  self.width = self.listBg:getContentSize().width
  self.listBg:setPositionX(-self.width)
  self.state = 1
  self.isTip = false
  self.mask:hide()
  self.tips = {}
  self.handlers = {}
  table.insert(self.handlers, NetManager:addEventListener("networkLogin", function(event)
    self:showData()
  end))
  self.mask:setTouchEnabled(true)
  self.mask:setSwallowTouches(true)
  self.mask:setCallback(function()
    self:changeUI()
  end)
  self.change = UIHelper.newImageView(infoRes .. "btn_a.png"):anch(0, 0.5):pos(507, posy):addTo(self.listBg)
  self.change:setCallback(function()
    self:changeUI()
  end)
end

function ShowFormationInfoLayer:showData(params)
  self.isShow = false
  self.timeFunc = {}
  self.list:removeAllChildren()
  local size = display.newSprite(infoRes .. "cell_battle.png"):getContentSize()
  size.height = size.height + 10
  
  function addCellBg(form, cell)
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(size):addTo(self.list)
    cell:center(viewNode):addTo(viewNode)
    display.newTTFLabel({
      text = string.format("套餐%d", form),
      size = 32,
      color = UIHelper.hex2rgb("#ffffff")
    }):enableOutline(UIHelper.hex2rgb("#3c1d07"), 2):pos(50, 35):addTo(cell)
  end
  
  for format = 1, game.role.teamMaxNum do
    if self:checkBattle(format) then
      local cell = UIHelper.newImageView(infoRes .. "cell_battle.png")
      addCellBg(format, cell)
      self:showBattleInfo(format, cell)
    elseif self:checkTask(format) then
      local cell = UIHelper.newImageView(infoRes .. "cell_task.png")
      addCellBg(format, cell)
      self:showTaskInfo(format, cell)
    else
      if self:checkOther(format) then
        local cell = UIHelper.newImageView(infoRes .. "cell_other.png")
        addCellBg(format, cell)
        self:showOtherInfo(format, cell)
      else
      end
    end
  end
  self.list:doLayout()
end

function ShowFormationInfoLayer:update()
  for index, data in pairs(self.timeFunc) do
    local time = data.endTime
    local func = data.callback
    local label = data.label
    local leftTime = time - game:nowTime()
    if 0 <= leftTime then
      label:setString(UIHelper.getTimeStr(leftTime))
    else
      label:setString("00:00:00")
      table.remove(self.timeFunc, index)
      if func then
        func()
      end
    end
  end
end

function ShowFormationInfoLayer:showBattleInfo(form, parent)
  display.newSprite(infoRes .. "text_battle.png"):pos(180, 35):addTo(parent)
  local carbonData = ChapterBattleCsv[self.battleInfo.carbonId]
  if not carbonData then
    return
  end
  local name = display.newTTFLabel({
    text = carbonData.name,
    size = 24,
    color = UIHelper.hex2rgb("#5f000b")
  }):anch(0, 0.5):pos(250, 33):addTo(parent)
  local timeLabel = display.newTTFLabel({
    text = "",
    size = 24,
    color = display.COLOR_WHITE
  }):enableOutline(UIHelper.hex2rgb("#8b0000"), 1):pos(447, 32):addTo(parent)
  table.insert(self.timeFunc, {
    label = timeLabel,
    endTime = self.battleInfo.moveTime
  })
  parent:setCallback(function()
    game:enterScene("MainScene", {
      layer = "carbon",
      carbonId = self.battleInfo.carbonId,
      skipMusic = true
    })
  end)
end

function ShowFormationInfoLayer:showTaskInfo(form, parent)
  display.newSprite(infoRes .. "text_task.png"):pos(180, 35):addTo(parent)
  local taskData = TaskCsv[self.taskInfo.carbonId][self.taskInfo.index]
  local carbonId, index = self.taskInfo.carbonId, self.taskInfo.index
  if not taskData then
    return
  end
  local name = display.newTTFLabel({
    text = taskData.name,
    size = 24,
    color = UIHelper.hex2rgb("#5f000b")
  }):anch(0, 0.5):pos(250, 33):addTo(parent)
  local timeLabel = display.newTTFLabel({
    text = "",
    size = 24,
    color = display.COLOR_WHITE
  }):enableOutline(UIHelper.hex2rgb("#8b0000"), 1):pos(447, 32):addTo(parent)
  table.insert(self.timeFunc, {
    label = timeLabel,
    endTime = self.taskInfo.time,
    callback = function()
      if self.isShow or self.isTip then
        return
      end
      self.isShow = true
      if game:sendData(actionCodes.Role_finishEntrustRpc, MsgPack.pack({chapter = carbonId, id = index})) then
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Role_finishEntrustRpc, function(event)
          UIHelper.removeWaiting()
          local msg = MsgPack.unpack(event.data)
          msg.format = form
          local heroId = game.role.formation[tostring(form)].list[tostring(1)]
          game:playMusic(1501)
          CommonHelper.playCV(game.role.heros[heroId].type, "consignationFinish")
          local heros = {}
          for itemId, count in pairs(msg.dropItems) do
            local item = ItemCsv[tonumber(itemId)]
            if item.type == ItemType.Hero then
              table.insert(heros, tonumber(itemId))
            end
          end
          if tolua.isnull(self) then
            return
          end
          self:checkRewardHero(heros, msg, form, carbonId, index)
        end)
      end
    end
  })
  parent:setCallback(function()
    game:enterScene("MainScene", {layer = "carbonTask"})
  end)
end

function ShowFormationInfoLayer:showOtherInfo(form, parent)
  local count = 0
  
  local function create(value, fram)
    local timeLabel = display.newTTFLabel({
      text = "",
      size = 18,
      color = display.COLOR_WHITE
    }):enableOutline(UIHelper.hex2rgb("#293800"), 1):pos(35, 15):addTo(fram)
    
    local function refresh()
      if fram and not tolua.isnull(fram) then
        fram:removeAllChildren()
        fram:setTouchEnabled(false)
        display.newSprite(infoRes .. "other_hold.png"):center(fram):addTo(fram)
      end
      count = count + 1
      if count == 5 then
        self:showData()
      end
    end
    
    table.insert(self.timeFunc, {
      label = timeLabel,
      endTime = value[2],
      callback = function()
        if self.isSend or self.isShow then
          return
        end
        self.isSend = true
        if value[1] == 2 then
          game:sendData(actionCodes.Hero_finishTreatRpc, MsgPack.pack({
            slot = value[3]
          }))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Hero_finishTreatRpc, function(event)
            UIHelper.removeWaiting()
            if tolua.isnull(self) then
              return
            end
            game.role:dispatchEvent({
              name = "hero_cure",
              heroId = value[5]
            })
            self:showTips(value[4] .. "治疗完成", self.isTip)
            self.isSend = false
            refresh()
          end)
        elseif value[1] == 3 then
          game:sendData(actionCodes.Hero_finishResearchRpc, MsgPack.pack({
            slot = value[3]
          }))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Hero_finishResearchRpc, function(event)
            UIHelper.removeWaiting()
            if tolua.isnull(self) then
              return
            end
            self:showTips(value[4] .. "阵型研究完成", self.isTip)
            self.isSend = false
            refresh()
          end)
        else
          refresh()
        end
      end
    })
  end
  
  local xPos, interval = 147, 78
  for index, value in ipairs(self.otherInfo) do
    local fram = UIHelper.newImageView(infoRes .. "other_fram.png"):pos(xPos + (index - 1) * interval, 38):addTo(parent)
    if value == 0 then
      count = count + 1
      display.newSprite(infoRes .. "other_nil.png"):center(fram):addTo(fram)
    elseif value == 1 then
      count = count + 1
      display.newSprite(infoRes .. "other_hold.png"):center(fram):addTo(fram)
    elseif value[1] == 2 then
      local image = display.newSprite(infoRes .. "text_treat.png"):pos(38, 40):addTo(fram)
      fram:setCallback(function()
        game:enterScene("MainScene", {layer = "treat"})
      end)
      create(value, fram)
    elseif value[1] == 3 then
      local image = display.newSprite(infoRes .. "text_research.png"):pos(38, 40):addTo(fram)
      fram:setCallback(function()
        game:enterScene("MainScene", {layer = "heros", selected = 3})
      end)
      create(value, fram)
    end
  end
end

function ShowFormationInfoLayer:checkBattle(form)
  self.battleInfo = json.decode(game.role.battleInfo) or {}
  for _, data in pairs(self.battleInfo.playerList or {}) do
    if data.format == form then
      return true
    end
  end
  return false
end

function ShowFormationInfoLayer:checkTask(form)
  self.entrust = json.decode(game.role.entrustJson) or {}
  self.taskInfo = {}
  for carbonId, data in pairs(self.entrust) do
    for index, info in pairs(data) do
      if info.form == form then
        self.taskInfo.time = info.time
        self.taskInfo.carbonId = tonumber(carbonId)
        self.taskInfo.index = tonumber(index)
        return true
      end
    end
  end
  return false
end

function ShowFormationInfoLayer:checkOther(form)
  local formationData = game.role.formation[tostring(form)] or {
    list = {},
    pos = {}
  }
  local treatCsv = json.decode(game.role.treatJson) or {}
  local researchCsv = json.decode(game.role.researchJson) or {}
  self.otherInfo = {}
  local result = false
  for slot = 1, 5 do
    local heroId = formationData.list[tostring(slot)]
    if heroId then
      local hero = game.role.heros[heroId]
      local state = hero:getState()
      if state[1] then
        for index, Data in pairs(treatCsv) do
          if Data and heroId == Data.id then
            result = true
            self.otherInfo[slot] = {
              2,
              Data.time,
              tonumber(index),
              hero:getName(),
              heroId
            }
          end
        end
      elseif state[4] then
        for index, Data in pairs(researchCsv) do
          if Data and heroId == Data.heroId then
            result = true
            self.otherInfo[slot] = {
              3,
              Data.time,
              tonumber(index),
              hero:getName()
            }
          end
        end
      else
        self.otherInfo[slot] = 1
      end
    else
      self.otherInfo[slot] = 0
    end
  end
  return result
end

function ShowFormationInfoLayer:checkRewardHero(heros, msg, formId, chapterId, idx)
  local function check(heros)
    if next(heros) then
      HeroRewardLayer.new({
        type = heros[1] - ItemStartId.hero,
        
        callback = function()
          table.remove(heros, 1)
          check(heros)
        end
      })
    else
      local layer = game:createView("carbon.TaskResultLayer", msg)
      TopBar:hide()
      BackManager:push(function()
        TopBar:show()
        layer:close()
        MDialog:double({
          title = "委托",
          text = "确定使用原来的队伍和任务再次进行委托吗？",
          cancelCallback = function()
            self.isShow = false
            self:showData()
            return true
          end,
          okCallback = function()
            local tip = false
            local result = CommonHelper.checkSourceFull()
            for type = 1, 4 do
              local num = TaskCsv[chapterId][idx]["material" .. type]
              if 0 < num and result[type] then
                tip = true
                break
              end
            end
            
            local function send()
              game:sendData(actionCodes.Role_entrustRpc, MsgPack.pack({
                formationId = formId,
                chapter = chapterId,
                id = idx
              }))
              UIHelper.showWaiting()
              game:addResponseHandler(actionCodes.Role_entrustRpc, function(event)
                UIHelper.removeWaiting()
                game:playMusic(1500)
                self.isShow = false
                self:showData()
              end)
            end
            
            if tip then
              MDialog:double({
                text = "主厨，您有资源已经到达存储上限了\n \n本次委托将无法获得对应资源的报酬",
                okCallback = function()
                  send()
                  return true
                end,
                cancelCallback = function()
                  return true
                end
              })
            else
              send()
            end
            return true
          end
        })
      end)
    end
  end
  
  check(heros)
end

function ShowFormationInfoLayer:changeUI()
  local xPos = self.listBg:getPositionX()
  if xPos < 0 and xPos > -self.width then
    return
  end
  if self.state == 1 then
    self.state = 2
    self.mask:show()
    if game.role.homeType ~= nil and game.role.homeType == 2 and globalCsv.newHomeOpen == 1 then
      self.change:setImage(infoNewRes .. "btn_b.png")
    else
      self.change:setImage(infoRes .. "btn_b.png")
    end
    self.listBg:runAction(cc.EaseOut:create(cc.MoveTo:create(0.3, cc.p(0, 305)), 0.8))
  else
    self.state = 1
    self.mask:hide()
    self.change:setImage(infoRes .. "btn_a.png")
    self.listBg:runAction(cc.EaseOut:create(cc.MoveTo:create(0.3, cc.p(-self.width, 305)), 0.8))
  end
end

function ShowFormationInfoLayer:showTips(tip)
  self.isTip = true
  table.insert(self.tips, tip)
  
  local function checkTipCount()
    if self.scene.content and not tolua.isnull(self.scene.content) then
      self.scene.content:removeSelf()
    end
    local num = table.nums(self.tips)
    if num == 0 then
      self.tipBg:removeSelf()
      self.tipBg = nil
      self.isTip = false
      self:showData()
      return
    end
    if self.tipBg then
      self.tipBg:stopAllActions()
      local label = self.tipBg:getChildByName("label")
      label:runAction(transition.sequence({
        cc.Spawn:create(cc.MoveBy:create(0.5, cc.p(0, 20)), cc.FadeOut:create(0.5)),
        cc.CallFunc:create(function()
          label:removeSelf()
        end)
      }))
      local newLabel = display.newTTFLabel({
        text = self.tips[1],
        size = 20,
        color = UIHelper.hex2rgb("#000000")
      }):anch(0, 0.5):pos(25, 35):addTo(self.tipBg):name("label")
      newLabel:setOpacity(0)
      newLabel:runAction(cc.Spawn:create(cc.MoveTo:create(0.5, cc.p(25, 55)), cc.FadeIn:create(0.5)))
    else
      self.tipBg = display.newSprite(HomeRes .. "talk_bg.png"):pos(195, 175):addTo(self.scene.homeBg)
      local newLabel = display.newTTFLabel({
        text = self.tips[1],
        size = 20,
        color = UIHelper.hex2rgb("#000000")
      }):anch(0, 0.5):pos(25, 55):name("label"):addTo(self.tipBg)
    end
    table.remove(self.tips, 1)
    self.tipBg:runAction(transition.sequence({
      cc.DelayTime:create(1),
      cc.CallFunc:create(function()
        checkTipCount()
      end)
    }))
  end
  
  checkTipCount()
end

function ShowFormationInfoLayer:MoveToRight()
  self.listBg:runAction(cc.MoveTo:create(0.3, cc.p(self.listBg:getPositionX() + 60, 305)))
end

function ShowFormationInfoLayer:MoveToLeft()
  self.listBg:runAction(cc.MoveTo:create(0.3, cc.p(self.listBg:getPositionX() - 60, 305)))
end

function ShowFormationInfoLayer:showAnimation()
  UIHelper.MoveToRight({
    node = self.listBg,
    delay = 0.45,
    time = 0.3,
    pos = {60, 0}
  })
end

function ShowFormationInfoLayer:onExit()
  for _, tag in ipairs(self.handlers) do
    NetManager:removeEventListener(tag)
  end
end

return ShowFormationInfoLayer
