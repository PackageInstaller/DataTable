local uiData = {
  csbFile = "ui/hero/HeroPresetLayer.csb",
  mask = true,
  maskClick = true,
  popup = true,
  widgets = {
    title = "presetBg/title",
    label1 = "presetBg/label1",
    label2 = "presetBg/label2",
    label3 = "presetBg/label3",
    node1 = "presetBg/node1",
    node2 = "presetBg/node2",
    node3 = "presetBg/node3"
  }
}
local HeroPresetLayer = class("HeroPresetLayer", UIBase)

function HeroPresetLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function HeroPresetLayer:init(params)
  self.callback = params.callback or function()
  end
  self.hero = params.hero
  self.wearGroup = json.decode(self.hero.prefab or "[]")
  self.title:setString("装备预设")
  self.label1:setString("预设1")
  self.label2:setString("预设2")
  self.label3:setString("预设3")
  self.useGroup = 0
end

function HeroPresetLayer:showData(params)
  for i = 1, 3 do
    self:initGroup(i)
  end
end

function HeroPresetLayer:initGroup(line)
  local node = self["node" .. line]
  node:removeAllChildren()
  local wearStr = self.wearGroup[tostring(line)] or ""
  local xPos = 0
  for part = 1, 3 do
    local equipId = wearStr:getv(part, 0)
    equipId = game.role.equips[equipId] and equipId or 0
    local bg
    if equipId ~= 0 then
      bg = EquipIcon.new({id = equipId, big = true}):scale(0.9):pos(xPos, 0):addTo(node)
    else
      bg = UIHelper.newImageView("ui/hero/detail/circle.png"):scale(0.9):pos(xPos, 0):addTo(node)
      UIHelper.newImageView("ui/equip/reforge/add.png"):center(bg):addTo(bg)
    end
    bg:setCallback(function()
      self:showEquipDetail(line, part, equipId)
    end)
    xPos = xPos + 110
  end
  local sauceId = wearStr:getv(4, 0)
  sauceId = game.role.sauces[sauceId] and sauceId or 0
  local bg = UIHelper.newImageView("ui/sauce/card/card_top_bg.png"):scale(0.8):pos(xPos, 5):addTo(node)
  if sauceId == 0 then
    UIHelper.newImageView("ui/equip/reforge/add.png"):pos(58, 75):addTo(bg)
    display.newTTFLabel({
      text = "添加酱料",
      size = 18,
      color = UIHelper.hex2rgb("#b5f831")
    }):enableOutline(UIHelper.hex2rgb("#000000"), 1):pos(58, 23):addTo(bg)
  else
    SauceIcon.new({id = sauceId, big = true}):center(bg):addTo(bg)
  end
  bg:setCallback(function()
    if not CommonHelper.funcOpen("sauce") then
      SysError(SYS_ERR_FUNCOPEN_SAUCE)
      return
    end
    self:showSauceDetail(line, sauceId)
  end)
  xPos = xPos + 160
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages("ui/global/", {
    "dialog_ok.png",
    "dialog_ok.png"
  })
  btn:pos(xPos, 0):addTo(node)
  btn:setCallback(function()
    if self.useGroup == line then
      SysError(SYS_ERR_HERO_USE_PRESET_SUCCESS)
      return
    end
    local states = self.hero:getState()
    if states[2] or states[3] then
      SysError(SYS_ERR_EQUIP_HERO_WEAR_LOCK)
      return
    end
    local showTip = false
    for part = 1, 4 do
      local equipId = wearStr:getv(part, 0)
      local owner = 3 < part and game.role.sauces[equipId] or game.role.equips[equipId]
      if owner and owner.masterId and 0 < owner.masterId then
        showTip = true
        local hero = game.role.heros[owner.masterId]
        local state = hero:getState()
        if state[2] or state[3] then
          SysError(3 < part and SYS_ERR_SAUCE_MONSTER_HERO_WEAR_LOCK or SYS_ERR_EQUIP_MONSTER_HERO_WEAR_LOCK)
          return
        end
      end
    end
    if showTip then
      MDialog:double({
        text = "当前选定的预设中有正在被其他食灵使用的部分，是否继续？",
        cancelCallback = function()
          return true
        end,
        okCallback = function()
          self.useGroup = line
          game:sendData(actionCodes.Hero_replacePrefabRpc, MsgPack.pack({
            heroId = self.hero.id,
            wearGroup = line
          }))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Hero_replacePrefabRpc, function(event)
            UIHelper.removeWaiting()
            SysError(SYS_ERR_HERO_USE_PRESET_SUCCESS)
          end)
          return true
        end
      })
    else
      self.useGroup = line
      game:sendData(actionCodes.Hero_replacePrefabRpc, MsgPack.pack({
        heroId = self.hero.id,
        wearGroup = line
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Hero_replacePrefabRpc, function(event)
        UIHelper.removeWaiting()
        SysError(SYS_ERR_HERO_USE_PRESET_SUCCESS)
      end)
    end
  end)
  display.newTTFLabel({text = "使用", size = 22}):enableOutline(UIHelper.hex2rgb("#502801"), 1):pos(73, 24):addTo(btn)
end

function HeroPresetLayer:showEquipDetail(group, part, equipId)
  if not CommonHelper.funcOpen("equip") then
    SysError(SYS_ERR_FUNCOPEN_EQUIP)
    return
  end
  
  local function rule(equip)
    if self.hero.level < equip.csvData.level then
      return true
    end
    return false
  end
  
  self:hide()
  local barType, barText = TopBar:getShowType()
  local layer = game:createView("equip.EquipWearLayer", {
    profession = part,
    heroId = self.hero.id,
    rule = rule,
    group = group,
    callback = function(choose, part, callback)
      if choose ~= 0 then
        local equip = game.role.equips[choose]
        if part ~= equip.csvData.profession then
          SysError(SYS_ERR_EQUIP_TYPE_NOT_FIT)
          return true
        end
        if self.hero.level < equip.csvData.level then
          SysError(SYS_ERR_EQUIP_HERO_LEVEL_LOW)
          return true
        end
      end
      game:sendData(actionCodes.Hero_wearPrefabRpc, MsgPack.pack({
        wearId = choose,
        wearSlot = part,
        heroId = self.hero.id,
        wearGroup = group
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Hero_wearPrefabRpc, function(event)
        UIHelper.removeWaiting()
        if tolua.isnull(self) then
          return
        end
        self.useGroup = 0
        self.wearGroup = json.decode(self.hero.prefab or "[]")
        self:initGroup(group)
        if callback then
          callback()
        end
      end)
    end
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(barType, barText)
    self:show()
  end)
end

function HeroPresetLayer:showSauceDetail(group, suaceId)
  local function rule(sauce)
    return false
  end
  
  self:hide()
  local barType, barText = TopBar:getShowType()
  local layer = game:createView("sauce.SauceWearLayer", {
    rule = rule,
    sauceId = suaceId,
    heroId = self.hero.id,
    callback = function(choose, callback)
      game:sendData(actionCodes.Hero_wearPrefabRpc, MsgPack.pack({
        wearId = choose,
        wearSlot = 4,
        heroId = self.hero.id,
        wearGroup = group
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Hero_wearPrefabRpc, function(event)
        UIHelper.removeWaiting()
        if tolua.isnull(self) then
          return
        end
        self.useGroup = 0
        self.wearGroup = json.decode(self.hero.prefab or "[]")
        self:initGroup(group)
        if callback then
          callback()
        end
      end)
    end
  })
  BackManager:push(function()
    layer:close()
    TopBar:show(barType, barText)
    self:show()
  end)
end

function HeroPresetLayer:onExit()
  self.callback()
end

return HeroPresetLayer
