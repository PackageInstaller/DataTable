local ItemCsv = require("csvdata.item")
local UnionCreateRes = "ui/union/main/"
local IconRes = "ui/union/create/"
local SysErrCsv = require("csvdata.sys_codes")
local uiData = {
  csbFile = "ui/union/UnionCreateLayer.csb",
  mask = true,
  popup = true,
  widgets = {
    touch = "touch",
    panel1 = "panel1",
    mask1 = "panel1/mask1",
    btnClose = "panel1/btnClose",
    title = "panel1/title",
    bigUnionBg = "panel1/bigUnionBg",
    buyDescBg = "panel1/buyDescBg",
    okBtn = "panel1/confirm",
    cancelBtn = "panel1/cancel",
    btnBuy = "panel1/btnBuy",
    btnRename = "panel1/btnRename",
    panel2 = "panel2",
    mask2 = "panel2/mask2"
  }
}
local UnionCreateLayer = class("UnionCreateLayer", UIBase)
local iconData = {
  [1] = {
    title = "厨艺攻坚",
    text = "遍巡天下，但求一败"
  },
  [2] = {
    title = "爱与和平",
    text = "澹泊明志，宁静致远"
  },
  [3] = {
    title = "厨艺交流",
    text = "如切如磋，如琢如磨"
  }
}

function UnionCreateLayer:ctor(params)
  UIBase.ctor(self, uiData, params)
end

function UnionCreateLayer:init(params)
  self.mask2:setSwallowTouches(true)
  self.mask2:setLocalZOrder(-1)
  self.mask1:setSwallowTouches(true)
  self.okBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.cancelBtn:getTitleRenderer():enableOutline(UIHelper.hex2rgb("#502801"), 1)
  self.okBtn:setTouchScale()
  self.cancelBtn:setTouchScale()
  if UIHelper.isiPhoneX() then
    UIHelper.fitForiPhoneX(self.touch)
  end
  self.showDown = false
  self.btnClose:setCallback(function()
    BackManager:pop()
  end)
  self.touch:setCallback(function()
    self:closeShowDown()
  end)
  self.cancelBtn:setCallback(function()
    BackManager:pop()
  end)
  display.newTTFLabel({
    text = "点击改变头像",
    size = 18,
    color = UIHelper.hex2rgb("#6f4925")
  }):pos(-425, -85):addTo(self.btnRename)
  local unionName = "请输入协会名字"
  local userInput = ccui.EditBox:create(cc.size(388, 38), "ui/home/roleDetail/name_bg.png")
  userInput:setReturnType(cc.KEYBOARD_RETURNTYPE_DONE)
  userInput:setFontSize(26)
  userInput:setMaxLength(16)
  userInput:setPlaceHolder(unionName)
  userInput:setPlaceholderFontSize(26)
  userInput:setPlaceholderFontColor(UIHelper.hex2rgb("#fdfdfc"))
  userInput:anch(0.5, 0.5):pos(-124, 19):addTo(self.btnRename)
  userInput:setFontColor(UIHelper.hex2rgb("#6f4925"))
  userInput:setInputMode(cc.EDITBOX_INPUT_MODE_ANY)
  local createId, createCount = globalCsv.UnionCreateCost:match("(%d+)=(%d+)")
  local costId = tonumber(createId)
  local buyTxt1 = display.newTTFLabel({
    text = "创建协会需要消耗",
    size = 20,
    color = UIHelper.hex2rgb("#6f4925")
  }):pos(112, 15):addTo(self.buyDescBg)
  local buyImage1 = UIHelper.newImageView(ItemCsv[costId].icon):pos(218, 15):addTo(self.buyDescBg):scale(0.4)
  local buyTxt2 = display.newTTFLabel({
    text = createCount,
    size = 20,
    color = UIHelper.hex2rgb("#6f4925")
  }):pos(246, 15):addTo(self.buyDescBg)
  local buyTxt3 = display.newTTFLabel({
    text = "购买",
    size = 20,
    color = UIHelper.hex2rgb("#ffffff")
  }):enableOutline(UIHelper.hex2rgb("#431b05"), 1):pos(42, 19):addTo(self.btnBuy)
  
  local function masterOk()
    self.okBtn:setCallback(function()
      local nameStr = userInput:getText()
      local len = self:getLength(self:stringToTab(nameStr))
      if len == 0 then
        SysError(SYS_ERR_UNION_INPUT_NOT_NULL)
        return
      end
      if 16 < len then
        local content = SysErrCsv[SYS_ERR_ROLE_CHANGE_NAME_OVERLENGTH].content
        MFlashMsg:show({
          text = string.format(content, 8)
        })
        return
      end
      local chars = MRichText:stringToChars(nameStr)
      for _, char in ipairs(chars) do
        if not char:isNormalWords() then
          SysError(SYS_ERR_UNION_INPUT_ILLEGAL)
          return
        end
      end
      if not self.tempId then
        self.tempId = 1
      end
      local cost = globalCsv.UnionCreateCost:toArray("=", true)
      if cost[1] == 5 then
        if cost[2] > game.role.diamond then
          SysError(SYS_ERR_DIAMOND_SHORTAGE)
          return
        end
      elseif cost[2] > (game.role.items[cost[1]] or 0) then
        SysError(SYS_ERR_UNION_CREATE_ITEM_NULL)
        return
      end
      game:sendData(actionCodes.Union_createUnionRpc, MsgPack.pack({
        name = nameStr,
        headId = self.tempId
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Union_createUnionRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        if msg.code then
          SysError(msg.code)
          return
        end
        SysError(SYS_ERR_UNION_CREATE_SUCCESS)
        BackManager:pop()
      end)
    end)
  end
  
  self.isCreatFirst = params.change or false
  if not self.isCreatFirst then
    local index = 1
    self:refreshIcon(index)
    self.title:setString("创建协会")
    self.btnBuy:setCallback(function()
      local layer = game:createView("shop.ShopLayer", {curType = 1, selected = 1})
      self:hide()
      BackManager:push(function()
        TopBar:show(TopBarType.full, "协会")
        layer:close()
        self:show()
      end)
    end)
    masterOk()
  else
    self.union = game.role.unionData or {}
    self:refreshIconModify(self.union.headId)
    local manageLevel = self.union.managers:getv(game.role.id, 0)
    local visibleGroup = {
      userInput,
      buyImage1,
      self.btnBuy,
      self.buyDescBg,
      self.btnBuy,
      self.btnRename,
      self.cancelBtn,
      self.okBtn
    }
    local txtGroup = {
      buyTxt1,
      buyTxt1,
      buyTxt1
    }
    self.title:setString("更改协会")
    if manageLevel ~= 1 then
      for i, v in ipairs(visibleGroup) do
        v:setVisible(false)
      end
      for i, v in ipairs(txtGroup) do
        v:setString("")
      end
      local modifyImage = display.newSprite("ui/union/detail/desc_bg.png"):pos(325, 189):addTo(self.panel1)
      display.newTTFLabel({
        text = "协会名称： " .. self.union.name,
        size = 18,
        color = UIHelper.hex2rgb("#6f4925")
      }):pos(70, 13):addTo(modifyImage)
    else
      local costRename = globalCsv.UnionNameChange:toArray("=", true)
      buyTxt1:setString("更改协会名需要消耗")
      buyImage1:setImage(ItemCsv[costRename[1]].icon)
      buyTxt2:setString(costRename[2])
      self.btnBuy:setVisible(false)
      if 1 > self.union.changeNameCount then
        local visibleGroup2 = {
          buyImage1,
          self.btnBuy,
          self.buyDescBg
        }
        local txtGroup2 = {
          buyTxt1,
          buyTxt1,
          buyTxt1
        }
        for i, v in ipairs(visibleGroup2) do
          v:setVisible(false)
        end
        for i, v in ipairs(txtGroup2) do
          v:setString("")
        end
      end
      self.okBtn:setCallback(function()
        local str = userInput:getText()
        if str == self.union.name then
          SysError(SYS_ERR_UNION_CREATE_NAME_REPEAT)
          return
        end
        if str == "" then
          SysError(SYS_ERR_UNION_INPUT_NOT_NULL)
          return
        end
        local len = self:getLength(self:stringToTab(str))
        if 16 < len then
          local content = SysErrCsv[SYS_ERR_ROLE_CHANGE_NAME_OVERLENGTH].content
          MFlashMsg:show({
            text = string.format(content, 8)
          })
          return
        end
        local chars = MRichText:stringToChars(str)
        for _, char in ipairs(chars) do
          if not char:isNormalWords() then
            SysError(SYS_ERR_UNION_INPUT_ILLEGAL)
            return
          end
        end
        
        local function sendStringMessage()
          game:sendData(actionCodes.Union_changeSetRpc, MsgPack.pack({type = 6, desc = str}))
          UIHelper.showWaiting()
          game:addResponseHandler(actionCodes.Union_changeSetRpc, function(event)
            UIHelper.removeWaiting()
            local msg = MsgPack.unpack(event.data)
            if msg.code then
              SysError(msg.code)
              return
            end
            SysError(SYS_ERR_UNION_HANDLE_SUCCESS)
            BackManager:pop()
          end)
        end
        
        if self.union.changeNameCount > 0 then
          if costRename[1] == 5 then
            if costRename[2] > game.role.diamond then
              SysError(SYS_ERR_DIAMOND_SHORTAGE)
              return
            end
          elseif costRename[2] > (game.role.items[costRename[1]] or 0) then
            SysError(SYS_ERR_UNION_CREATE_ITEM_NULL)
            return
          end
          MDialog:double({
            text = string.format("是否要花费%d钻石改名？", costRename[2]),
            size = 24,
            color = UIHelper.hex2rgb("#430602"),
            cancelCallback = function()
              return true
            end,
            okCallback = function()
              sendStringMessage()
              return true
            end
          })
          return
        else
          sendStringMessage()
        end
      end)
    end
  end
end

function UnionCreateLayer:showDetail()
  local posx = 130
  for i, value in pairs(iconData) do
    local viewNode = ccui.Widget:create()
    viewNode:size(180, 236):pos(posx, 150):addTo(self.panel2)
    local cell = UIHelper.newImageView(IconRes .. "icon_bg.png"):center(viewNode):addTo(viewNode)
    display.newSprite(UnionCreateRes .. string.format("icon_%d.png", i)):pos(95, 143):addTo(cell)
    display.newTTFLabel({
      text = value.title,
      size = 22,
      color = UIHelper.hex2rgb("#6f4925")
    }):anch(0, 0.5):pos(51, 235):addTo(cell)
    display.newTTFLabel({
      text = value.text,
      size = 14,
      color = UIHelper.hex2rgb("#6f4925"),
      dimensions = cc.size(166, 39)
    }):anch(0, 0.5):pos(30, 38):addTo(cell)
    cell:setCallback(function()
      self:refreshIcon(i)
      self.tempId = i
    end)
    posx = posx + 206
  end
end

function UnionCreateLayer:showDetailModify()
  local posx = 130
  for i, value in pairs(iconData) do
    local viewNode = ccui.Widget:create()
    viewNode:size(180, 236):pos(posx, 150):addTo(self.panel2)
    local cell = UIHelper.newImageView(IconRes .. "icon_bg.png"):center(viewNode):addTo(viewNode)
    display.newSprite(UnionCreateRes .. string.format("icon_%d.png", i)):pos(95, 143):addTo(cell)
    display.newTTFLabel({
      text = value.title,
      size = 22,
      color = UIHelper.hex2rgb("#6f4925")
    }):anch(0, 0.5):pos(51, 235):addTo(cell)
    display.newTTFLabel({
      text = value.text,
      size = 14,
      color = UIHelper.hex2rgb("#6f4925"),
      dimensions = cc.size(166, 39)
    }):anch(0, 0.5):pos(30, 38):addTo(cell)
    cell:setCallback(function()
      self:refreshIconModify(i)
      self.tempId = i
      game:sendData(actionCodes.Union_changeSetRpc, MsgPack.pack({
        type = 7,
        value = self.tempId
      }))
      UIHelper.showWaiting()
      game:addResponseHandler(actionCodes.Union_changeSetRpc, function(event)
        UIHelper.removeWaiting()
        local msg = MsgPack.unpack(event.data)
        if msg.code then
          SysError(msg.code)
          return
        end
        SysError(SYS_ERR_UNION_HANDLE_SUCCESS)
      end)
    end)
    posx = posx + 206
  end
end

function UnionCreateLayer:refreshIconModify(index)
  self.bigUnionBg:removeAllChildren()
  self.unionIcon = UIHelper.newImageView(UnionCreateRes .. string.format("icon_%d.png", index)):pos(74, 94):addTo(self.bigUnionBg)
  self.unionIcon:setCallback(function()
    if not self.showDown then
      self:changeLayOut()
    end
    self:showDetailModify()
  end)
end

function UnionCreateLayer:refreshIcon(index)
  self.bigUnionBg:removeAllChildren()
  self.unionIcon = UIHelper.newImageView(UnionCreateRes .. string.format("icon_%d.png", index)):pos(74, 94):addTo(self.bigUnionBg)
  self.unionIcon:setCallback(function()
    if not self.showDown then
      self:changeLayOut()
    end
    self:showDetail()
  end)
end

function UnionCreateLayer:changeLayOut()
  if self.showDown then
    self.showDown = false
    self.panel1:runAction(cc.MoveBy:create(0.2, cc.p(0, -147)))
    self.panel2:runAction(cc.MoveBy:create(0.2, cc.p(0, 147)))
  else
    self.panel1:runAction(cc.MoveBy:create(0.2, cc.p(0, 147)))
    self.panel2:runAction(cc.MoveBy:create(0.2, cc.p(0, -147)))
    self.showDown = true
  end
end

function UnionCreateLayer:closeShowDown()
  if not self.showDown then
    return
  end
  self:changeLayOut()
end

function UnionCreateLayer:stringToTab(str)
  local tab = {}
  if not str then
    return tab
  end
  for utfChar in string.gmatch(str, "[%z\001-\127�-�][�-�]*") do
    table.insert(tab, utfChar)
  end
  return tab
end

function UnionCreateLayer:getLength(strs)
  local width = 0
  for _, str in pairs(strs) do
    local len = string.len(str)
    if 1 < len then
      width = width + 2
    else
      width = width + 1
    end
  end
  return width
end

return UnionCreateLayer
