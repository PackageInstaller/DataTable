local itemCsv = require("csvdata.item")
local GlobalRes = "ui/global/"
local JiejiMainRes = "ui/jieji/main2/"
local uiData = {
  csbFile = "ui/jieji/JiejiRewardDialog2.csb",
  mask = true,
  maskClick = true,
  popup = true,
  widgets = {
    popAction = "popAction",
    touch = "popAction/touch",
    rewardList = "popAction/rewardList"
  }
}
local JiejiRewardDialog = class("JiejiRewardDialog", UIBase)

function JiejiRewardDialog:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function JiejiRewardDialog:init(params)
  game:playMusic(1023)
  local callBack = params.callBack
  self.touch:setCallback(function()
    if callBack then
      callBack()
    end
    self:close()
  end)
  local rewards = params.rewards
  local rows = math.ceil(#rewards / 5)
  local cols = #rewards == 1 and 1 or 5
  for row = 1, rows do
    local viewNode = ccui.Widget:create()
    viewNode:setContentSize(cc.size(600, 110)):addTo(self.rewardList)
    for col = 1, cols do
      local index = (row - 1) * 5 + col
      local data = rewards[index]
      for id, count in pairs(data) do
        local item = self:createCell(id, count):pos(55 + (col - 1) * 120, 55):addTo(viewNode)
      end
    end
  end
  self.rewardList:requestDoLayout()
end

function JiejiRewardDialog:createCell(id, count)
  local bg = UIHelper.newImageView(JiejiMainRes .. "pop_item_bg.png")
  local itemData = itemCsv[tonumber(id)]
  UIHelper.getClipNode({
    steRes = GlobalRes .. "mask_1.png",
    clipRes = itemData.icon
  }):scale(0.65):pos(54, 60):addTo(bg)
  local str = string.format("<div shadow=0,-2,0.5,#8c4e24 outline=1,#aa5c28 >%s</div>", itemData.name .. "*" .. count)
  MRichText.new({
    text = str,
    size = 18,
    color = UIHelper.hex2rgb("#ffffff")
  }):anch(0.5, 0.5):pos(56, 23):addTo(bg)
  bg:setCallback(function()
    MTip:show({
      type = MTipType.item,
      node = bg,
      itemType = tonumber(id),
      itemData = itemCsv[tonumber(id)]
    })
  end)
  return bg
end

return JiejiRewardDialog
