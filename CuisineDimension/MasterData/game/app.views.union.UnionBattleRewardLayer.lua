local rankRes = "ui/tower/rank/"
local PicCsv = require("csvdata.head_pic")
local unionBattleRewardCsv = require("csvdata.union_battle_reward")
local ItemCsv = require("csvdata.item")
local UnionBattleRes = "ui/union/battle/"
local uiData = {
  csbFile = "ui/union/UnionBattleRewardLayer.csb",
  mask = true,
  popup = true,
  maskClick = true,
  widgets = {
    title = "popAction/title",
    rewardNode = "rewardNode",
    closeBtn = "closeBtn"
  }
}
local UnionBattleRewardLayer = class("UnionBattleRewardLayer", UIBase)

function UnionBattleRewardLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function UnionBattleRewardLayer:init(params)
  local pValue = params.value or 0
  local unionScore = params.unionScore or 0
  local activityStatus = game.role.activityStatus["89"]
  if not activityStatus then
    return
  end
  local winCount = activityStatus.win_count or 0
  local battleCount = activityStatus.battle_count or 0
  local generalDatas = unionBattleRewardCsv[1]
  local winDatas = unionBattleRewardCsv[2]
  local unionDatas = unionBattleRewardCsv[3]
  local posx = -250
  local posy = 100
  local offsetX = 100
  local reward_record = game.role.activityStatus["89"].reward_record or {}
  for idx, data in ipairs(generalDatas) do
    local done = next(reward_record) and reward_record[tostring(100 + data.rewardId)]
    local canGet = battleCount >= data.condition
    self:CreateOne(1, data, done, canGet):pos(posx, posy):addTo(self.rewardNode)
    posx = posx + offsetX
  end
  for idx, data in ipairs(winDatas) do
    local done = next(reward_record) and reward_record[tostring(200 + data.rewardId)]
    local canGet = winCount >= data.condition
    self:CreateOne(2, data, done, canGet):pos(posx, posy):addTo(self.rewardNode)
    posx = posx + offsetX
  end
  posx = -250
  posy = -65
  for idx, data in ipairs(unionDatas) do
    local done = next(reward_record) and reward_record[tostring(300 + data.rewardId)]
    local canGet = tonumber(unionScore) >= data.condition
    self:CreateOne(3, data, done, canGet):pos(posx, posy):addTo(self.rewardNode)
    posx = posx + offsetX
  end
  self.closeBtn:setTouchScale(true)
  self.closeBtn:setCallback(function()
    self:close()
  end)
end

function UnionBattleRewardLayer:CreateOne(idx, data, done, canGet)
  local items = data.rewards:toArray("=", true)
  local giftImage = ItemIcon.new({
    type = tonumber(items[1]),
    count = tonumber(items[2])
  }):scale(0.9)
  local btnImage = done and "had.png" or canGet and "get.png" or "cant.png"
  local bTouch = not done and canGet
  local btn = UIHelper.extend(ccui.Button:create())
  btn:setImages(UnionBattleRes, {btnImage, btnImage})
  btn:pos(46, -20):addTo(giftImage):setTouchScale()
  btn:setTouchEnabled(bTouch)
  
  local function getReward()
    game:sendData(actionCodes.Activity_unionBattleGetRewardRpc, MsgPack.pack({
      id = idx,
      index = data.rewardId
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Activity_unionBattleGetRewardRpc, function(event)
      UIHelper.removeWaiting()
      btn:setTouchEnabled(false)
      bTouch = false
      btn:setImages(UnionBattleRes, {"had.png", "had.png"})
      MedalRewardLayer.new({
        items = data.rewards:toNumMap()
      })
    end)
  end
  
  local titleStr = idx == 1 and "参与次数:" or idx == 2 and "胜利次数:" or "协会积分:"
  display.newTTFLabel({
    text = titleStr .. data.condition,
    size = 16,
    color = UIHelper.hex2rgb("#b76f46")
  }):pos(46, -50):addTo(giftImage)
  giftImage:setCallback(function()
    if bTouch then
      getReward()
    else
      MTip:show({
        type = MTipType.item,
        node = giftImage,
        itemType = items[1],
        itemData = ItemCsv[items[1]]
      })
    end
  end)
  btn:setCallback(function()
    getReward()
  end)
  return giftImage
end

return UnionBattleRewardLayer
