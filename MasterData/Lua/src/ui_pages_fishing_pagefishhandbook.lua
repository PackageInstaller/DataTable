local this = class("pageFishHandBook", G_UIPageBase)

function this:ctor(...)
  this.super.ctor(self, ...)
  self.data = {selectFishId = nil}
end

function this.bind()
  return {
    go_lockInfo = false,
    txt_lockDesc = "",
    go_info = false,
    txt_fishName = "",
    txt_fishDesc = "",
    txt_fishWeight_max = "",
    txt_fishWeight_min = "",
    txt_fishGetNum = "",
    img_fishIcon = nil,
    txt_progress = "",
    scrollList_fish = {
      moduleName = "pages/Fishing/cellFish"
    }
  }
end

function this.methods()
  return {
    onClick_back = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_root = function(self)
      L_UI:backToRoot()
    end,
    scrollList_fish = {
      onClick_select = function(self, bind)
        self.data.selectFishId = bind.id
        self:initFishInfo()
        self:setFishListActive()
        local serverData = L_FishingStore:getFishHandbook(bind.id)
        if serverData and not serverData:getFishIsRead() then
          L_FishingStore:req_CSProtoFishRead(bind.id, function()
            self:refreshNewImg(bind.id)
          end)
        end
      end
    }
  }
end

function this:preOpen(options)
  this.super.preOpen(self, options)
  self:initPage()
end

function this:close(options)
  this.super.close(self, options)
end

function this:initPage()
  self:initFishList()
  self:initFishInfo()
end

function this:initFishList()
  local commonItemTpl = L_GameTpl:getCommonItemTpl()
  local fish = commonItemTpl:getTypeGroup(L_BagConst.bagItemType.fish)
  local tmp = {}
  for _, v in pairs(fish) do
    local item = L_ItemManager:parseCommonItem(commonItemTpl:getId(v))
    table.insert(tmp, {
      id = commonItemTpl:getId(v),
      parseData = item,
      go_lock = true,
      go_unLock = false,
      img_quality = item.imgQuality,
      select = true
    })
  end
  local unlockNum = 0
  for i, v in pairs(tmp) do
    local serverData = L_FishingStore:getFishHandbook(v.id)
    if not table.isEmpty(serverData) then
      unlockNum = unlockNum + 1
      local item = L_ItemManager:parseCommonItem(commonItemTpl:getId(v))
      v.go_lock = false
      v.go_unLock = true
      v.img_icon = item.icon
      v.go_new = not serverData:getFishIsRead()
    end
  end
  table.sort(tmp, function(a, b)
    local lockA = a.go_lock and 1 or 0
    local lockB = b.go_lock and 1 or 0
    if lockA == lockB then
      local qualityA = a.parseData.quality
      local qualityB = b.parseData.quality
      if qualityA == qualityB then
        return a.id < b.id
      else
        return qualityA > qualityB
      end
    else
      return lockA < lockB
    end
  end)
  self.data.selectFishId = self.data.selectFishId or tmp[1].id
  self.bind.scrollList_fish:clear()
  self.bind.scrollList_fish:insert_array(tmp)
  self:setFishListActive()
  self.bind.txt_progress = L_WordsTpl:getValue("ui_collect_num", {
    [0] = unlockNum,
    [1] = #tmp
  })
end

function this:initFishInfo()
  local serverData = L_FishingStore:getFishHandbook(self.data.selectFishId)
  local item = L_ItemManager:parseCommonItem(self.data.selectFishId)
  local fishTpl = L_GameTpl:getFishTpl()
  local fishId = item.subId
  local tpl_fish = fishTpl:getTplById(fishId)
  if table.isEmpty(serverData) then
    self.bind.go_lockInfo = true
    self.bind.go_info = false
    self.bind.txt_lockDesc = fishTpl:getLockDesc(tpl_fish)
  else
    self.bind.txt_fishName = item.name
    self.bind.txt_fishDesc = item.desc
    self.bind.img_fishIcon = fishTpl:getIconL(tpl_fish)
    self.bind.go_lockInfo = false
    self.bind.go_info = true
    self.bind.txt_fishWeight_min = L_WordsTpl:getValue("info_fish_minimumweight", {
      [0] = serverData:getFishMinWeight() / 10000
    })
    self.bind.txt_fishWeight_max = L_WordsTpl:getValue("info_fish_maxweight", {
      [0] = serverData:getFishMaxWeight() / 10000
    })
    self.bind.txt_fishGetNum = L_WordsTpl:getValue("ui_accumulate_fish_num", {
      [0] = L_GameUtil.fillColor(serverData:getFishHistoryCount(), L_Const.colorHtml.blue001)
    })
  end
end

function this:refreshNewImg(fishId)
  for i = 1, #self.bind.scrollList_fish do
    if self.bind.scrollList_fish:getValue(i, "id") == fishId then
      self.bind.scrollList_fish:change(i, {go_new = false})
      return
    end
  end
end

function this:setFishListActive()
  for i = 1, #self.bind.scrollList_fish do
    local active = false
    if self.bind.scrollList_fish:getValue(i, "id") == self.data.selectFishId then
      active = true
    end
    self.bind.scrollList_fish:change(i, {go_active = active})
  end
end

return this
