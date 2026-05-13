local TechCsv = require("csvdata.union_tech")
local UnionTechBtnImageRes = "ui/union/tech/"
local ShopRes = "ui/shop/main/"
local GlobalRes = "ui/global/"
local IconRes = "icon/union_shop/"
local uiData = {
  csbFile = "ui/shop/ShopItemCountLayer.csb",
  popup = true,
  mask = true,
  maskClick = true,
  widgets = {
    popAction = "popAction",
    btnAdd = "btnAdd",
    btnSub = "btnSub",
    cancel = "cancel",
    confirm = "confirm",
    title = "title",
    itemNode = "itemNode",
    moneyBg = "moneyBg",
    descBg = "descBg",
    desc = "descBg/desc",
    numBg = "numBg",
    money = "moneyBg/money",
    num = "numBg/num",
    name = "name",
    count = "count"
  }
}
local UnionTechCountLayer = class("UnionTechCountLayer", UIBase)

function UnionTechCountLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function UnionTechCountLayer:init(params)
  self.title:setString("确认点亮")
  self.confirm:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancel:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.confirm:setTouchScale()
  self.cancel:setTouchScale()
  self.btnAdd:setTouchScale()
  self.btnSub:setTouchScale()
  self.cancel:setCallback(function()
    self:close()
  end)
  self.data = TechCsv[params.index]
  self.desc:setString(self.data.desc)
  self.union = game.role.unionData
  self:refreshContent()
end

function UnionTechCountLayer:showData(params)
  local costStr = IconRes .. "hexin.png"
  display.newSprite(costStr):scale(0.5):pos(10, 13):addTo(self.moneyBg)
  display.newSprite(ShopRes .. "cell_image_bg.png"):addTo(self.itemNode)
  if self.data.fileName and self.data.fileName ~= "" then
    display.newSprite(UnionTechBtnImageRes .. self.data.fileName):pos(0, 0):addTo(self.itemNode)
  end
  self.numBg:hide()
  self.btnAdd:hide()
  self.btnSub:hide()
  self.itemNode:setPositionY(self.itemNode:getPositionY() - 25)
  self.moneyBg:setPositionY(self.moneyBg:getPositionY() - 25)
  self.name:setPositionY(self.name:getPositionY() - 25)
  self.count:setPositionY(self.count:getPositionY() - 25)
  self.descBg:setPositionY(self.descBg:getPositionY() - 35)
  self.callback = params.func
  self.confirm:setCallback(function()
    if self.union.techCore < self.data.needTechCore then
      SysError(SYS_ERR_UNION_CORE_NOT_ENOUGH)
      return
    end
    game:sendData(actionCodes.Union_changeTechRpc, MsgPack.pack({
      id = self.data.id
    }))
    UIHelper.showWaiting()
    game:addResponseHandler(actionCodes.Union_changeTechRpc, function(event)
      UIHelper.removeWaiting()
      local msg = MsgPack.unpack(event.data)
      self.callback()
      self:close()
    end)
  end)
end

function UnionTechCountLayer:refreshContent()
  self.name:setString(self.data.name)
  self.count:setString("维护费用为每日" .. self.data.dailyCost .. "协会财富")
  self.money:setString(self.data.needTechCore)
  self.richText = MRichText.new({
    text = "当前有" .. self.union.techCore .. "个<img src='icon/union_shop/hexin.png' scale=0.5 />",
    color = UIHelper.hex2rgb("#703902"),
    size = 26,
    maxWidth = 440
  })
  self.richText:anch(0.5, 0.5):pos(333, 50):addTo(self.popAction)
end

return UnionTechCountLayer
