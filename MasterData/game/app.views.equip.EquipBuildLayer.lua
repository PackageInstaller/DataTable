local BuildCsv = require("csvdata.equip_build")
local ItemCsv = require("csvdata.item")
local EquipCsv = require("csvdata.equip")
local RewardRes = "ui/common/reward/"
local BuildRes = "ui/equip/build/"
local uiData = {
  csbFile = "ui/equip/EquipBuildLayer.csb",
  widgets = {
    ren = "ren",
    mainBg = "mainBg2",
    bg1 = "key1",
    bg2 = "key2",
    value1 = "key1/value",
    value2 = "key2/value",
    di = "di",
    buy1 = "di/buy1",
    buy2 = "di/buy2",
    btn1 = "di/btn1",
    btn2 = "di/btn2",
    text1 = "di/buy1/text1",
    text2 = "di/buy2/text2",
    text3 = "di/buy2/text3"
  }
}
local EquipBuildLayer = class("EquipBuildLayer", UIBase)

function EquipBuildLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function EquipBuildLayer:init(params)
  self.countType = 1
  self:initSelectBtns()
  self.bg1:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.bg1,
      itemType = globalCsv.buildEquip,
      itemData = ItemCsv[globalCsv.buildEquip]
    })
  end)
  self.bg2:setCallback(function()
    MTip:show({
      type = MTipType.path,
      node = self.bg2,
      itemType = globalCsv.quickEquip,
      itemData = ItemCsv[globalCsv.quickEquip]
    })
  end)
  local btnInfo = UIHelper.extend(ccui.Button:create())
  btnInfo:setImages("ui/tower/main/", {
    "btn_info.png",
    "btn_info.png"
  })
  btnInfo:pos(760, 464):addTo(self.di)
  btnInfo:setTouchScale()
  btnInfo:setCallback(function()
    game:loadView("kitchen.CookInfoLayer").new({
      res = BuildRes .. "image_info.png"
    })
  end)
  display.newSprite(BuildRes .. "image.png"):pos(472, 20):addTo(self.di)
  self.bg1:setCascadeOpacityEnabled(true)
  self.bg2:setCascadeOpacityEnabled(true)
  UIHelper.MoveToLeft({
    node = self.bg1,
    time = 0.3
  })
  UIHelper.MoveToLeft({
    node = self.bg2,
    time = 0.3
  })
  UIHelper.MoveToLeft({
    node = self.di,
    time = 0.5
  })
  UIHelper.MoveToRight({
    node = self.mainBg,
    time = 0.3
  })
  UIHelper.MoveToRight({
    node = self.ren,
    time = 0.3
  })
  local lastDi1 = display.newSprite(BuildRes .. "last1.png"):pos(140, 125):addTo(self.buy1)
  local lastDi2 = display.newSprite(BuildRes .. "last2.png"):pos(140, 125):addTo(self.buy2)
  self.lastLab1 = display.newTTFLabel({
    text = "",
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  }):addTo(lastDi1):center(lastDi1)
  self.lastLab2 = display.newTTFLabel({
    text = "",
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  }):addTo(lastDi2):center(lastDi2)
  local guideLayer = display.getRunningScene():getChildByTag(NEW_GUIDE_LAYER_TAG)
  if guideLayer then
    self.guideStep = guideLayer.guideStep
  end
end

function EquipBuildLayer:refreshLastLab()
  local ensureEquip5Star = json.decode(game.role.ensureEquip5Star)
  self.lastLab1:setString(string.format("再采购%d次必得紫装", globalCsv.EquipAssure[1] - (ensureEquip5Star["1"] or ""):getv(0, 0)))
  self.lastLab2:setString(string.format("再采购%d次必得紫装", globalCsv.EquipAssure[2] - (ensureEquip5Star["2"] or ""):getv(0, 0)))
  UIHelper.makeFontClear(self.lastLab1)
  UIHelper.makeFontClear(self.lastLab2)
end

function EquipBuildLayer:initSelectBtns()
  local group = MRadioGroup:create({
    chooseCb = function(sender)
      local text = sender:getChildByName("name")
      text:setTextColor(UIHelper.hex2rgb("#ffffff"))
      text:enableOutline(UIHelper.hex2rgb("#6c1e06"), 1)
    end,
    unchooseCb = function(sender)
      local text = sender:getChildByName("name")
      text:setTextColor(UIHelper.hex2rgb("#c6c6c6"))
      text:enableOutline(UIHelper.hex2rgb("#4c1203"), 1)
    end
  })
  local names = {
    "采\n购\n一\n次",
    "采\n购\n十\n次"
  }
  local xPos = 0
  for i, name in ipairs(names) do
    local btn = self["btn" .. i]
    display.newTTFLabel({text = name, size = 26}):pos(18, 72):addTo(btn):name("name")
    btn:setLocalZOrder(-1)
    btn:name("btn" .. i)
    btn:setGroup(group)
    btn:setCallback(function()
      self.countType = i
      local num = i == 2 and 10 or 1
      for index = 1, 3 do
        self["text" .. index]:setString("x" .. num)
      end
    end)
    xPos = xPos + 130
  end
  group:chooseByName("btn" .. self.countType)
end

function EquipBuildLayer:showData(params)
  self.value1:setString(game.role.items[globalCsv.buildEquip] or 0)
  self.value2:setString(game.role.items[globalCsv.quickEquip] or 0)
  local bg = display.newSprite(BuildRes .. "talk_bg_1.png"):pos(310, 540):addTo(self.ren)
  display.newTTFLabel({
    text = "主厨，请选购",
    size = 22,
    color = UIHelper.hex2rgb("#3e1700")
  }):pos(130, 45):addTo(bg)
  bg:runAction(transition.sequence({
    cc.DelayTime:create(1),
    cc.Spawn:create(cc.MoveBy:create(0.3, cc.p(0, 20)), cc.FadeOut:create(0.3)),
    cc.RemoveSelf:create()
  }))
  self.buy1:setCallback(function()
    self:buy(1)
  end)
  self.buy2:setCallback(function()
    self:buy(2)
  end)
  self:refreshLastLab()
end

function EquipBuildLayer:buy(type)
  if game.role:isMaxEquip() then
    UIHelper.showExtraTip({type = 2, parent = self})
    return
  end
  if (game.role.items[globalCsv.buildEquip] or 0) < (self.countType == 1 and 1 or 10) then
    UIHelper.showCookTip({
      type = type == 1 and 3 or self.countType == 1 and 4 or 6,
      callback = function()
        self.value1:setString(game.role.items[globalCsv.buildEquip] or 0)
        self.value2:setString(game.role.items[globalCsv.quickEquip] or 0)
      end
    })
    return
  end
  if type == 2 and (game.role.items[globalCsv.quickEquip] or 0) < (self.countType == 1 and 1 or 10) then
    SysError(SYS_ERR_EQUIP_BUILD_QUICK_MATERIAL_NOT_ENOUGH)
    return
  end
  game:sendData(actionCodes.Equip_buildEquipRpc, MsgPack.pack({
    type = type,
    countType = self.countType
  }))
  UIHelper.showWaiting()
  game:addResponseHandler(actionCodes.Equip_buildEquipRpc, function(event)
    UIHelper.removeWaiting()
    self.value1:setString(game.role.items[globalCsv.buildEquip] or 0)
    self.value2:setString(game.role.items[globalCsv.quickEquip] or 0)
    local msg = MsgPack.unpack(event.data)
    local equipTypes = msg.equipTypes
    local width = display.width
    local posx = display.width / 2
    if UIHelper.isiPhoneX() then
      width = display.width + UIHelper.getMoveXForX(true) * 2
      posx = posx + 50
    end
    local maskLayer = UIHelper.newMask({
      size = cc.size(width, display.height)
    })
    maskLayer:addTo(display.getRunningScene()):zorder(POPUP_LAYER_ORDER + 1)
    maskLayer:setTouchEnabled(true)
    maskLayer:setSwallowTouches(true)
    local spine = UIHelper.createSpineNodeByRes(RewardRes .. "zbhd")
    spine:pos(posx, display.height / 2):addTo(maskLayer)
    if type == 1 then
      spine:setAnimation(0, "special", false)
    elseif type == 2 then
      spine:setAnimation(0, "special2", false)
    end
    self:refreshLastLab()
    spine:registerSpineEventHandler(function(event)
      if event.type ~= "end" then
        return
      end
      scheduler.performWithDelayGlobal(function()
        maskLayer:removeSelf()
      end, 0.016666666666666666)
    end, sp.EventType.ANIMATION_END)
    maskLayer:runAction(transition.sequence({
      cc.DelayTime:create(1),
      cc.CallFunc:create(function()
        EquipRewardLayer.new({
          countType = self.countType,
          type = equipTypes[1],
          equips = equipTypes,
          callback1 = function()
            local reward = {}
            reward[(game.role.equips[equipTypes[1]].type > 1000 and ItemStartId.newEquip or ItemStartId.equip) + game.role.equips[equipTypes[1]].type] = equipTypes[1]
            reward[501] = 1
            MedalRewardLayer.new({
              items = reward,
              equip = true,
              callback = function()
                if self.guideStep and self.guideStep == 10009 then
                  NewGuideLayer.new({
                    step = 10009,
                    majorGuideStep = 10009,
                    minorGuideStep = 4,
                    callback = function()
                      game:enterScene("MainScene", {guideId = 10009, minorStep = 5})
                    end
                  })
                end
              end
            })
          end
        })
      end)
    }))
  end)
end

return EquipBuildLayer
