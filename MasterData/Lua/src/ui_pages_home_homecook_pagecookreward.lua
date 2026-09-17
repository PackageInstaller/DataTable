local this = class("pageCookReward", G_UIPageBase)

function this.bind()
  return {
    moduleCookAnim = false,
    rewardList = {
      moduleName = "pages/home/homeCook/cellCookReward"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end
  }
end

function this:preOpen(options)
  self.bind.moduleCookAnim = true
  self:refreshView(options.itemList)
end

function this:close(options)
  L_UI:close("pageCookAnim")
end

function this:refreshView(data)
  self.bind.rewardList:clear()
  local temp = {}
  for i, v in pairs(data) do
    local item = v
    local conf = L_ItemTplManager:getItemConfig(item.itemtype, item.itemid)
    local rightTxt = string.format("<size=22> %s </size>%d", "x", item.itemnum)
    local nameTxt = string.format("<size=24>%s</size>", conf.name)
    local allTxt = string.format("%s%s", nameTxt, rightTxt)
    table.insert(temp, {
      name = allTxt,
      evaluate = "Page/Cook/tex_cooking_word_perfect",
      iconBg = "Page/Food/tex_foodgame_bg_yellowbg",
      isFirst = false,
      effects = false,
      isMultiple = 1 < #data,
      icon = n.conf.icon
    })
  end
  for i, v in ipairs(temp) do
    v.isFirst = i ~= 1 and 1 < #data
  end
  self.bind.rewardList:insert_array(temp)
end

return this
