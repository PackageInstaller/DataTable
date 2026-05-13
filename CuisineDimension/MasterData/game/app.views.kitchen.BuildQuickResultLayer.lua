local ItemCsv = require("csvdata.item")
local UnitCsv = require("csvdata.unit")
local ResultRes = "ui/kitchen/buildResult/"
local RewardRes = "ui/common/reward/"
local GlobalRes = "ui/global/"
local uiData = {
  popup = true,
  csbFile = "ui/kitchen/BuildQuickResultLayer.csb",
  widgets = {
    mainBg = "mainBg",
    itemsBg = "mainBg/itemsBg",
    tipBg = "tipBg",
    node1 = "mainBg/node1",
    node2 = "mainBg/node2"
  }
}
local BuildQuickResultLayer = class("BuildQuickResultLayer", UIBase)

function BuildQuickResultLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function BuildQuickResultLayer:init(params)
  self.mainBg:setTouchEnabled(true)
  self.mainBg:setSwallowTouches(true)
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.mainBg)
  end
  display.newSprite(ResultRes .. "image_tip.png"):center(self.tipBg):addTo(self.tipBg)
  self.heros = params.heros or {}
  self.isExtraTen = params.isExtraTen or false
  if self.isExtraTen then
    self.tipBg:hide()
    self.mainBg:setImage(ResultRes .. "main_bg_extra.png")
    self.itemsBg:setImage(ResultRes .. "items_bg_extra.png")
  end
end

function BuildQuickResultLayer:showData(params)
  local count = table.nums(self.heros)
  local root = count <= 5 and self.node1 or self.node2
  local xPos = 5 < count and 0 or (count - 1) / 2 * -120
  local yPos, index = 0, 1
  
  local function createIcon()
    local data = ItemCsv[self.heros[index].unitId + ItemStartId.hero]
    local icon = HeroHead.new({
      type = self.heros[index].unitId,
      showTip = true,
      special = true
    }):scale(0.3):pos(xPos, yPos):addTo(root)
    local effect = UIHelper.loadAnimation(RewardRes, "show", 21, 15)
    effect.sprite:center(icon):addTo(icon)
    effect.sprite:playAnimationOnce(effect.animation, true)
    if data.star >= 4 then
      local flash = UIHelper.loadAnimation(RewardRes, data.star == 4 and "reward_blue" or data.star == 5 and "gold" or "rainbow", 30, 30)
      flash.sprite:pos(46, 48):addTo(icon)
      flash.sprite:playAnimationForever(flash.animation)
    end
    if self.heros[index].first then
      display.newSprite(ResultRes .. "image_new.png"):pos(80, 80):addTo(icon)
    end
    icon:runAction(cc.ScaleTo:create(0.2, 1))
    xPos = xPos + 120
    if index == 5 then
      xPos = 0
      yPos = -136
    end
    index = index + 1
  end
  
  self:runAction(transition.sequence({
    cc.Repeat:create(transition.sequence({
      cc.CallFunc:create(function()
        createIcon()
      end),
      cc.DelayTime:create(0.15)
    }), count),
    cc.DelayTime:create(0.5),
    cc.CallFunc:create(function()
      if self.isExtraTen then
        self:initExtraTenButton()
      else
        self.mainBg:setCallback(function()
          self:close()
        end)
      end
    end)
  }))
end

function BuildQuickResultLayer:initExtraTenButton()
  local reBuildBtn = UIHelper.extend(ccui.Button:create())
  reBuildBtn:setImages(ResultRes, {
    "btn_select1.png",
    "btn_select1.png"
  })
  reBuildBtn:pos(223, 13):addTo(self.itemsBg)
  reBuildBtn:setCallback(function()
    if (game.role.items[43001] or 0) < 10 then
      SysError(SYS_ERR_DREAM_TICKETS_NOT_ENOUGH)
      return
    end
    local haveExtraStar = false
    for i, data in pairs(self.heros) do
      if UnitCsv[data.unitId].star == 6 then
        haveExtraStar = true
        break
      end
    end
    if haveExtraStar then
      MDialog:double({
        text = "本次结果已出梦境食灵，重新呼唤将失去本次十连结果，是否继续？",
        size = 24,
        color = UIHelper.hex2rgb("#430602"),
        cancelCallback = function()
          return true
        end,
        okCallback = function()
          game:sendData(actionCodes.Hero_extraStarRebuildRpc, MsgPack.pack({}))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Hero_extraStarRebuildRpc, function(event)
            UIHelper.removeWaiting()
            local msg = MsgPack.unpack(event.data)
            local tempCount = 10
            local rewards = {}
            local isFirsts = {}
            for _, data in ipairs(msg.newHeroList or {}) do
              table.insert(rewards, data.unitId)
              table.insert(isFirsts, data.first)
            end
            
            local function checkHero()
              if next(rewards) then
                HeroRewardLayer.new({
                  type = rewards[1],
                  showSkip = 1 < tempCount and true or false,
                  bFirst = isFirsts[1],
                  skipFunc = function()
                    tempCount = 1
                    local tempRewards = {}
                    local tempIsFirsts = {}
                    for k, res in ipairs(isFirsts) do
                      if k == 1 or res or UnitCsv[rewards[k]].star == 6 then
                        table.insert(tempRewards, rewards[k])
                        table.insert(tempIsFirsts, res)
                      end
                    end
                    rewards = tempRewards
                    isFirsts = tempIsFirsts
                  end,
                  callback = function()
                    if next(rewards) then
                      table.remove(rewards, 1)
                      table.remove(isFirsts, 1)
                    end
                    checkHero()
                  end
                })
              else
                game:createView("kitchen.BuildQuickResultLayer", {
                  heros = msg.newHeroList,
                  isExtraTen = true
                })
              end
            end
            
            checkHero()
            self:close()
          end)
          return true
        end
      })
    else
      game:sendData(actionCodes.Hero_extraStarRebuildRpc, MsgPack.pack({}))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Hero_extraStarRebuildRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        local tempCount = 10
        local rewards = {}
        local isFirsts = {}
        for _, data in ipairs(msg.newHeroList or {}) do
          table.insert(rewards, data.unitId)
          table.insert(isFirsts, data.first)
        end
        
        local function checkHero()
          if next(rewards) then
            HeroRewardLayer.new({
              type = rewards[1],
              showSkip = 1 < tempCount and true or false,
              bFirst = isFirsts[1],
              skipFunc = function()
                tempCount = 1
                local tempRewards = {}
                local tempIsFirsts = {}
                for k, res in ipairs(isFirsts) do
                  if k == 1 or res or UnitCsv[rewards[k]].star == 6 then
                    table.insert(tempRewards, rewards[k])
                    table.insert(tempIsFirsts, res)
                  end
                end
                rewards = tempRewards
                isFirsts = tempIsFirsts
              end,
              callback = function()
                if next(rewards) then
                  table.remove(rewards, 1)
                  table.remove(isFirsts, 1)
                end
                checkHero()
              end
            })
          else
            game:createView("kitchen.BuildQuickResultLayer", {
              heros = msg.newHeroList,
              isExtraTen = true
            })
          end
        end
        
        checkHero()
        self:close()
      end)
    end
  end)
  local getBtn = UIHelper.extend(ccui.Button:create())
  getBtn:setImages(ResultRes, {
    "btn_select2.png",
    "btn_select2.png"
  })
  getBtn:pos(591, 13):addTo(self.itemsBg)
  getBtn:setCallback(function()
    game:sendData(actionCodes.Hero_extraStarGetRpc, MsgPack.pack({}))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Hero_extraStarGetRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      self:close()
    end)
  end)
end

return BuildQuickResultLayer
