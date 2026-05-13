local uiData = {
  csbFile = "ui/kitchen/CookNoteLayer.csb",
  mask = true,
  maskClick = true,
  popup = true,
  widgets = {
    center = "center",
    btn1 = "btn1",
    btn2 = "btn2",
    btn3 = "btn3",
    btn4 = "btn4",
    btn5 = "btn5",
    list = "mainBg/list"
  }
}
local UnitCsv = require("csvdata.unit")
local CookNoteRes = "ui/kitchen/note/"
local GlobalRes = "ui/global/"
local DetailRes = "ui/hero/detail/"
local CookNoteLayer = class("CookNoteLayer", UIBase)

function CookNoteLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function CookNoteLayer:init(params)
  self.callback = params.callback
  local names = {
    "收\n藏",
    "5\n星",
    "4\n星",
    "1~3\n星",
    "全\n部"
  }
  self.group = MRadioGroup:create({
    chooseCb = function(sender)
      sender:setPositionX(sender:getPositionX() + 5)
    end,
    unchooseCb = function(sender)
      sender:setPositionX(sender:getPositionX() - 5)
    end
  })
  for index, name in ipairs(names) do
    local btn = self["btn" .. index]
    display.newTTFLabel({
      text = name,
      size = 20,
      color = UIHelper.hex2rgb("#ffffff"),
      align = cc.TEXT_ALIGNMENT_CENTER
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(20, 40):addTo(btn)
    btn:setCallback(function()
      self.selected = index
      self:showData()
    end)
    btn:setSwallowTouches(true)
    btn:setGroup(self.group)
    btn:name("btn" .. index)
  end
  self.selected = 2
  local cookNotes = game.role.cookNotes
  if game.role.majorGuideStep == 14 then
    self.mainNotes = {
      {
        type = 103,
        name = "guide",
        time = game:nowTime(),
        m1 = 100,
        m2 = 100,
        m3 = 100,
        m4 = 100,
        roleId = 0
      }
    }
    self.favorites = {}
  elseif not cookNotes or game:nowTime() - cookNotes.time > 30 then
    game:sendData(actionCodes.Role_cookNotesRpc, MsgPack.pack({}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Role_cookNotesRpc, function(event)
      UIHelper.removeWaiting()
      if tolua.isnull(self) then
        return
      end
      local data = MsgPack.unpack(event.data)
      local mainNotes = {}
      for star, notes in pairs(data.mainNotes) do
        for index, noteData in ipairs(notes) do
          mainNotes[#mainNotes + 1] = json.decode(noteData)
        end
      end
      table.sort(mainNotes, function(a, b)
        return UnitCsv[a.type].star > UnitCsv[b.type].star
      end)
      local favorites = {}
      for index, noteData in ipairs(data.favorites) do
        favorites[#favorites + 1] = noteData
      end
      game.role.cookNotes = {
        time = game:nowTime(),
        mainNotes = mainNotes,
        favorites = favorites
      }
      self.mainNotes = mainNotes
      self.favorites = favorites
      self:showData()
    end)
  else
    self.mainNotes = cookNotes.mainNotes
    self.favorites = cookNotes.favorites
  end
end

function CookNoteLayer:showData(params)
  self.group:chooseByName("btn" .. self.selected)
  if not self.mainNotes then
    return
  end
  self.filterStar = self:getfilterStar()
  if self.selected == 1 then
    self:showFavorites()
  else
    self:showMainNode()
  end
end

local cellSize = display.newSprite(CookNoteRes .. "cell_1.png"):getContentSize()

function CookNoteLayer:showMainNode()
  self.list:removeAllChildren()
  local count = 1
  for index, note in ipairs(self.mainNotes) do
    local unitData = UnitCsv[note.type]
    if unitData.star >= self.filterStar[1] and unitData.star <= self.filterStar[2] then
      local viewNode = ccui.Widget:create()
      viewNode:size(cellSize):addTo(self.list)
      local res = count % 2 == 0 and "cell_2.png" or "cell_1.png"
      local cell = UIHelper.newImageView(CookNoteRes .. res)
      cell:center(viewNode):addTo(viewNode)
      count = count + 1
      display.newTTFLabel({
        text = note.name,
        size = 20,
        color = UIHelper.hex2rgb("#532c1b")
      }):anch(0, 0.5):pos(10, cellSize.height / 2 + 10):addTo(cell)
      display.newTTFLabel({
        text = CommonHelper.date(note.time, "x"),
        size = 18,
        color = UIHelper.hex2rgb("#532c1b")
      }):anch(0, 0.5):pos(10, cellSize.height / 2 - 10):addTo(cell)
      for m = 1, 4 do
        local bg = display.newSprite(CookNoteRes .. "base_bg.png"):pos(220 + (m % 2 == 1 and 0 or 90), 75 + (m <= 2 and 0 or -40)):addTo(cell)
        display.newSprite(string.format("ui/global/base_%d.png", m)):pos(10, 12):addTo(bg)
        display.newTTFLabel({
          text = note["m" .. m],
          size = 18,
          color = UIHelper.hex2rgb("#9d5615")
        }):anch(1, 0.5):pos(62, 12):addTo(bg)
      end
      display.newSprite(UIHelper.getCardRes("book", note.type)):scale(0.88):pos(473, cellSize.height / 2):addTo(cell)
      local proTag = UIHelper.getProfessionTag(unitData.profession, 0):pos(378, 86):addTo(cell)
      display.newTTFLabel({
        text = unitData.name,
        size = 20,
        color = UIHelper.hex2rgb("#9d5615")
      }):anch(1, 0.5):pos(cellSize.width - 25, cellSize.height - 20):addTo(cell)
      local isBlack = globalCsv.blackHeroUnitIds[unitData.type] == 1
      local isMengJing = globalCsv.mengJingHeroUnitIds[unitData.type] == 1
      local star, interval = unitData.star, 25
      local temStar = math.min(star, 5)
      for index = 1, temStar do
        display.newSprite(DetailRes .. (isMengJing and "star_extra.png" or isBlack and "star_black.png" or "star.png")):anch(1, 0.5):addTo(cell):pos(cellSize.width - 25 - (index - 1) * interval, cellSize.height - 45)
      end
      local useBtn = UIHelper.newImageView(CookNoteRes .. "use_a.png"):pos(755, 32):addTo(cell):name("useBtn" .. index)
      display.newTTFLabel({
        text = "套用配方",
        size = 20
      }):enableOutline(UIHelper.hex2rgb("#803603"), 1):center(useBtn):addTo(useBtn)
      useBtn:setCallback(function()
        self.callback(note.m1, note.m2, note.m3, note.m4)
        self:close()
      end)
      local saved = self:find(note.roleId, note.time)
      local saveBtn = UIHelper.newImageView(CookNoteRes .. (saved and "save_b.png" or "save_a.png")):pos(635, 32):addTo(cell)
      display.newTTFLabel({
        text = saved and "已收藏" or "收藏",
        size = 20
      }):enableOutline(UIHelper.hex2rgb(saved and "#026c67" or "#4c3605"), 1):center(saveBtn):addTo(saveBtn)
      if not saved then
        saveBtn:setCallback(function()
          local noteData = json.encode(note)
          game:sendData(actionCodes.Role_cookAddFavoritesRpc, MsgPack.pack({note = noteData}))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Role_cookAddFavoritesRpc, function(event)
            UIHelper.removeWaiting()
            table.insert(self.favorites, noteData)
            saveBtn:setImage(CookNoteRes .. "save_b.png")
            saveBtn:removeAllChildren()
            display.newTTFLabel({text = "已收藏", size = 20}):enableOutline(UIHelper.hex2rgb("#026c67"), 1):center(saveBtn):addTo(saveBtn)
            saveBtn:setTouchEnabled(false)
          end)
        end)
      end
    end
  end
  self.list:requestDoLayout()
end

function CookNoteLayer:showFavorites()
  self.list:removeAllChildren()
  local count = 1
  for index, noteData in ipairs(self.favorites) do
    local note = json.decode(noteData)
    local unitData = UnitCsv[note.type]
    if unitData.star >= self.filterStar[1] and unitData.star <= self.filterStar[2] then
      local viewNode = ccui.Widget:create()
      viewNode:size(cellSize):addTo(self.list)
      local res = count % 2 == 0 and "cell_2.png" or "cell_1.png"
      local cell = UIHelper.newImageView(CookNoteRes .. res)
      cell:center(viewNode):addTo(viewNode)
      count = count + 1
      display.newTTFLabel({
        text = note.name,
        size = 20,
        color = UIHelper.hex2rgb("#532c1b")
      }):anch(0, 0.5):pos(10, cellSize.height / 2 + 10):addTo(cell)
      display.newTTFLabel({
        text = CommonHelper.date(note.time, "x"),
        size = 18,
        color = UIHelper.hex2rgb("#532c1b")
      }):anch(0, 0.5):pos(10, cellSize.height / 2 - 10):addTo(cell)
      for m = 1, 4 do
        local bg = display.newSprite(CookNoteRes .. "base_bg.png"):pos(220 + (m % 2 == 1 and 0 or 90), 75 + (m <= 2 and 0 or -40)):addTo(cell)
        display.newSprite(string.format("ui/global/base_%d.png", m)):pos(10, 12):addTo(bg)
        display.newTTFLabel({
          text = note["m" .. m],
          size = 18,
          color = UIHelper.hex2rgb("#9d5615")
        }):anch(1, 0.5):pos(62, 12):addTo(bg)
      end
      display.newSprite(UIHelper.getCardRes("book", note.type)):scale(0.88):pos(473, cellSize.height / 2):addTo(cell)
      local proTag = UIHelper.getProfessionTag(unitData.profession, 0):pos(378, 86):addTo(cell)
      display.newTTFLabel({
        text = unitData.name,
        size = 20,
        color = UIHelper.hex2rgb("#9d5615")
      }):anch(1, 0.5):pos(cellSize.width - 25, cellSize.height - 20):addTo(cell)
      local isBlack = globalCsv.blackHeroUnitIds[unitData.type] == 1
      local isMengJing = globalCsv.mengJingHeroUnitIds[unitData.type] == 1
      local star, interval = unitData.star, 25
      local temStar = math.min(star, 5)
      for index = 1, temStar do
        display.newSprite(DetailRes .. (isMengJing and "star_extra.png" or isBlack and "star_black.png" or "star.png")):anch(1, 0.5):addTo(cell):pos(cellSize.width - 25 - (index - 1) * interval, cellSize.height - 45)
      end
      local useBtn = UIHelper.newImageView(CookNoteRes .. "use_a.png"):pos(755, 32):addTo(cell)
      display.newTTFLabel({
        text = "套用配方",
        size = 20
      }):enableOutline(UIHelper.hex2rgb("#803603"), 1):center(useBtn):addTo(useBtn)
      useBtn:setCallback(function()
        self.callback(note.m1, note.m2, note.m3, note.m4)
        self:close()
      end)
      local cancelBtn = UIHelper.newImageView(CookNoteRes .. "save_a.png"):pos(635, 32):addTo(cell)
      display.newTTFLabel({
        text = "取消收藏",
        size = 20
      }):enableOutline(UIHelper.hex2rgb("#4c3605"), 1):center(cancelBtn):addTo(cancelBtn)
      cancelBtn:setCallback(function()
        game:sendData(actionCodes.Role_cookDelFavoritesRpc, MsgPack.pack({note = noteData}))
        UIHelper.showWaiting()
        game:addResponseHandler(actionCodes.Role_cookDelFavoritesRpc, function(event)
          UIHelper.removeWaiting()
          table.remove(self.favorites, index)
          self:showFavorites()
        end)
      end)
    end
  end
  self.list:requestDoLayout()
end

function CookNoteLayer:getfilterStar()
  if self.selected == 2 then
    return {5, 5}
  elseif self.selected == 3 then
    return {4, 4}
  elseif self.selected == 4 then
    return {1, 3}
  else
    return {1, 5}
  end
end

function CookNoteLayer:find(roleId, time)
  for _, noteData in ipairs(self.favorites) do
    local note = json.decode(noteData)
    if note.roleId == roleId and note.time == time then
      return true
    end
  end
  return false
end

return CookNoteLayer
