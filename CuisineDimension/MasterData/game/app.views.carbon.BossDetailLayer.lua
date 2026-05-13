local BossCsv = require("csvdata.ghost")
local uiData = {
  csbFile = "ui/carbon/BossDetailLayer.csb",
  mask = true,
  popup = true,
  maskClick = function()
    BackManager:pop()
  end,
  widgets = {
    name = "name",
    heroNode = "heroNode",
    desc = "desc",
    skill = "skill",
    itemNode = "itemNode",
    progressNode = "progressNode",
    giveup = "giveupBtn",
    goBtn = "goBtn",
    exitBtn = "exitBtn"
  }
}
local BossDetailLayer = class("BossDetailLayer", UIBase)

function BossDetailLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function BossDetailLayer:init(params)
  local extraBattle = json.decode(game.role.extraBattle)
  self.bossId = extraBattle.bossId
  self.bossData = BossCsv[self.bossId]
  self.giveup:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 2)
  self.goBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#4c3605"), 2)
  self.goBtn:setCallback(function()
    local mapId = math.floor(extraBattle.carbonId / 100)
    BackManager:pop()
    local layer = game:createView("carbon.CarbonDetailLayer", {
      mapId = mapId,
      carbonId = extraBattle.carbonId
    })
    BackManager:push(function()
      layer:close()
    end)
  end)
  self.exitBtn:setCallback(function()
    if self.bossData.story2 == 0 then
      return
    end
    self:hide()
    local layer = game:createView("talk.TalkLayer", {
      selected = 3,
      type = self.bossData.killTag
    })
    BackManager:push(function()
      TopBar:show(TopBarType.full, "战斗")
      layer:close()
      self:show()
    end)
  end)
  local Spine = UIHelper.createSpineNodeByRes(self.bossData.cardSpine):pos(0, -50):addTo(self.heroNode)
  Spine:setAnimation(0, "moren", true)
  self.name:setString(self.bossData.name)
  self.desc:setString(self.bossData.desc)
  self.skill:setString(self.bossData.advice)
  local x = 0
  for _, itemId in pairs(self.bossData.gift2see:toArray("=", true)) do
    ItemIcon.new({type = itemId, showTip = true}):pos(10 + x * 70, 0):scale(0.75):addTo(self.itemNode)
    x = x + 1
  end
  local x = 0
  for index = 1, self.bossData.killTime do
    if index > extraBattle.curTime then
      UIHelper.newImageView("ui/carbon/boss/boss_7.png"):pos(10 + (index - 1) * 70, 20):addTo(self.progressNode)
    else
      UIHelper.newImageView("ui/carbon/boss/boss_8.png"):pos(10 + (index - 1) * 70, 20):addTo(self.progressNode)
    end
  end
  if extraBattle.curTime >= self.bossData.killTime then
    self.goBtn:setTitleText("领取奖励")
    self.giveup:hide()
    self.goBtn:setCallback(function()
      game:sendData(actionCodes.Carbon_drawBossAward, MsgPack.pack({}))
      game:addResponseHandler(actionCodes.Carbon_drawBossAward, function(event)
        local msg = MsgPack.unpack(event.data)
        local dropItems = msg.dropItems
        MedalRewardLayer.new({
          items = dropItems,
          callback = function()
            if msg.trade then
              local layer = game:createView("trade.TradeSellLayer", {
                items = game.role.tradeItems
              })
              BackManager:push(function()
                layer:close()
                BackManager:pop()
              end)
            else
              BackManager:pop()
            end
          end
        })
      end)
    end)
  else
    self.giveup:setTitleText("放弃净化")
    self.giveup:setCallback(function()
      MDialog:double({
        text = string.format("放弃净化将只保留%d异变线索\n \n主厨，确定要放弃净化吗？", globalCsv.ghostReturn)
      }, function()
        game:sendData(actionCodes.Carbon_givpUpBoss, MsgPack.pack({}))
        game:addResponseHandler(actionCodes.Carbon_givpUpBoss, function(event)
          BackManager:pop()
        end)
      end)
    end)
  end
end

function BossDetailLayer:showData()
end

return BossDetailLayer
