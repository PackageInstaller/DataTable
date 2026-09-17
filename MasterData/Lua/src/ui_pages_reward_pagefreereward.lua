local this = class("pageFreeReward", G_UIPageBase)

function this.bind()
  return {
    txt_title = L_WordsTpl:getValue("residual_code_pagefreereward_01"),
    scrollRectReward = L_Const.ModuleInfo.CellIconBag,
    size_scroll = C_Vector2(1595, 250)
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self.callback = options.callback
  if options.itemList then
    self:refreshReward(options.itemList)
  end
  if options.title then
    self.bind.txt_title = options.title
  end
end

function this:close(options)
  this.super.close(self, options)
  L_TimerManager:clearTimer(self)
  if self.callback then
    self.callback()
  end
end

function this:refreshReward(itemList)
  self.bind.size_scroll = C_Vector2(math.min(1595, 212 * #itemList), 250)
  self.bind.scrollRectReward:clear()
  local list = {}
  for i = 1, #itemList do
    local cell = self:parseCellItemData(itemList[i])
    table.insert(list, cell)
  end
  self.bind.scrollRectReward:insert_array(list)
  L_TimerManager:newOrResetTimer(self, "closeFreeReward", function()
    L_UI:close(self.pageName)
  end, 3)
end

function this:onEvent_storyStartHandle()
  L_UI:close(self.pageName)
end

function this:parseCellItemData(data)
  local cell = {
    guid = data.guid,
    itemId = data.itemId,
    itemType = data.itemType,
    itemNumTxt = data.txt_count,
    noReddot = true
  }
  return cell
end

return this
