local ChapterBattleCsv = require("csvdata.chapter_battle")
local MonsterCsv = require("csvdata.monster")
local CarbonRes = "ui/carbon/carbonresult/"
local BattleRes = "ui/carbon/battleresult/"
local uiData = {
  csbFile = "ui/carbon/NewBattleResultLayer.csb",
  mask = true,
  widgets = {touch = "touch"}
}
local AutoCarbonBattleLayer = class("AutoCarbonBattleLayer", UIBase)

function AutoCarbonBattleLayer:ctor(params)
  if not params.isTopBar then
    TopBar:hide()
  end
  UIBase.ctor(self, uiData, params)
end

function AutoCarbonBattleLayer:init(params)
  self.isTopBar = params.isTopBar
  self.dalteX = 0
  if UIHelper.isiPhoneX() then
    self.dalteX = UIHelper.getMoveXForX() + 125
    UIHelper.fitForiPhoneX(self.touch)
  end
end

function AutoCarbonBattleLayer:autoShowResultLayer(result)
  local layer = game:createView("carbon.NewCarbonResultLayer", {
    endResult = result.endResult,
    carbonId = result.carbonId,
    id = result.id,
    autoBattle = true,
    isTopBar = self.isTopBar
  })
  BackManager:push(function()
    game.role.showAutoBattle = result.carbonId
    game:enterScene("MainScene", {
      layer = "carbon",
      carbonId = result.carbonId,
      skipMusic = true
    })
  end)
end

function AutoCarbonBattleLayer:showData(params)
  local function gameOver()
    local selected = game.role.autoBattle.idxs:toArray("=", true)[3]
    
    selected = (selected == 0 or not selected) and game.role.autoBattle.teams:toArray("=", true)[1] or selected
    local result = {
      endResult = params.endResult,
      carbonId = params.carbonId,
      id = selected
    }
    self:autoShowResultLayer(result)
  end
  
  local cx = display.cx
  if UIHelper.isiPhoneX() then
    cx = cx + UIHelper.getMoveXForX()
  end
  local mainBg = display.newSprite("ui/carbon/main/carbon_bg.png"):pos(cx - self.dalteX, display.cy):addTo(self)
  local mask = UIHelper.newMask({
    size = cc.size(display.width, display.height),
    opacity = 0
  })
  mask:addTo(display.getRunningScene()):zorder(POPUP_LAYER_ORDER)
  mask:setTouchEnabled(true)
  
  local function afterEffect()
    if not tolua.isnull(mask) then
      mask:removeSelf()
    end
    gameOver()
  end
  
  if params.endResult.win then
    local spine = UIHelper.createSpineNodeByRes("spine/ui/battle/success")
    spine:pos(cx, display.cy):addTo(mainBg)
    spine:setAnimation(0, "special", false)
    spine:setTimeScale(1)
    spine:registerSpineEventHandler(function(event)
      afterEffect()
      scheduler.performWithDelayGlobal(function()
        spine:removeSelf()
      end, 0.016666666666666666)
    end, sp.EventType.ANIMATION_END)
  else
    self.content = display.newSprite("ui/battle/tip_bg.png"):anch(1, 0.5):pos(0, display.height / 2):addTo(mainBg)
    if UIHelper.isiPhoneX() then
      self.content:setPositionX(self.content:getPositionX() + UIHelper.getMoveXForX())
    end
    local txtpng = "battle_lose.png"
    display.newSprite("ui/battle/" .. txtpng):center(self.content):addTo(self.content)
    self.content:runAction(transition.sequence({
      cc.MoveBy:create(0.1, cc.p(display.width, 0)),
      cc.DelayTime:create(1.3),
      cc.MoveBy:create(0.1, cc.p(display.width, 0)),
      cc.CallFunc:create(function()
        afterEffect()
      end),
      cc.RemoveSelf:create()
    }))
  end
end

return AutoCarbonBattleLayer
