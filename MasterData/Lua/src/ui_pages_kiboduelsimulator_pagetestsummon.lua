local this = class("pageTestSummon", G_UIPageBase)

function this.bind()
  return {
    scrollList = {
      moduleName = "pages/kiboDuelSimulator/cellItem/cellKDTestSummonItem"
    },
    scrollSelectList = {
      moduleName = "pages/kiboDuelSimulator/cellItem/kiboDuelSimulatorClickItem"
    },
    txt_input1 = "",
    txt_input2 = "",
    txt_input3 = "",
    txt_input4 = "",
    txt_input5 = "",
    txt_input1_lock = false,
    txt_input2_lock = false,
    txt_input3_lock = false,
    txt_input4_lock = false,
    txt_input5_lock = false
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      L_UI:close(self.pageName)
    end,
    onClick_add = function(self)
      local item = L_KiboDuelSimulatorStore:getDefaultSummonItem()
      table.insert(self.list, item)
      self:refreshScrollList(item)
    end,
    scrollList = {
      onClick = function(self, bind)
        self.selectIndex = bind.id
        self:refreshInput(self.list[self.selectIndex])
      end,
      onClickDelete = function(self, bind)
        table.remove(self.list, bind.id)
        self:refreshScrollList()
      end
    },
    scrollSelectList = {
      onClick = function(self, bind)
        if self.selectIndex == 0 then
          return
        end
        self.list[self.selectIndex][4] = bind.id
        self:refreshScrollList()
      end
    },
    onChanged_input1 = function(self, text)
      if self.selectIndex == 0 or not tonumber(text) then
        return
      end
      self.list[self.selectIndex][1] = tonumber(text)
      self:refreshScrollList()
    end,
    onChanged_input2 = function(self, text)
      if self.selectIndex == 0 or not tonumber(text) then
        return
      end
      self.list[self.selectIndex][2] = tonumber(text)
      self:refreshScrollList()
    end,
    onChanged_input3 = function(self, text)
      if self.selectIndex == 0 or not tonumber(text) then
        return
      end
      self.list[self.selectIndex][3] = tonumber(text)
      self:refreshScrollList()
    end,
    onChanged_input4 = function(self, text)
      if self.selectIndex == 0 or not tonumber(text) then
        return
      end
      self.list[self.selectIndex][4] = tonumber(text)
      self:refreshScrollList()
    end,
    onChanged_input5 = function(self, text)
      if self.selectIndex == 0 or not tonumber(text) then
        return
      end
      self.list[self.selectIndex][5] = tonumber(text)
      self:refreshScrollList()
    end
  }
end

function this:ctor()
  this.super.ctor(self)
  self.selectIndex = 0
  self.param = {}
end

function this:open(options)
  this.super.open(self, options)
  self.list = L_KiboDuelSimulatorStore:getData().summonList
  self:refreshScrollList()
  self:refreshScrollSelectList()
end

function this:refreshScrollList(item)
  self.bind.scrollList:clear()
  local selectItem
  if self.selectIndex > 0 then
    selectItem = self.list[self.selectIndex]
  end
  if item then
    selectItem = table.clone(item)
  end
  table.sort(self.list, function(a, b)
    for i = 1, 5 do
      if a[i] ~= b[i] then
        return a[i] < b[i]
      end
    end
  end)
  self.selectIndex = 0
  if selectItem then
    for i, v in ipairs(self.list) do
      for j = 1, 5 do
        if v[j] ~= selectItem[j] then
          break
        end
        if j == 5 then
          self.selectIndex = i
          do break end
          break
        end
      end
    end
  end
  for i, v in pairs(self.list) do
    self.bind.scrollList:insert({
      id = i,
      txt_name = table.concat(v, "_")
    })
  end
  self:refreshInput(self.list[self.selectIndex])
end

function this:refreshScrollSelectList()
  self.bind.scrollSelectList:clear()
  local list = L_GameTpl:getPetTpl().data
  for _, v in pairs(list) do
    local name = v.id .. "_" .. L_GameTpl:getPetTpl():getName(v)
    self.bind.scrollSelectList:insert({
      id = v.id,
      txt_name = name
    })
  end
end

function this:refreshInput(item)
  self.bind.txt_input1_lock = item and true or false
  self.bind.txt_input2_lock = item and true or false
  self.bind.txt_input3_lock = item and true or false
  self.bind.txt_input4_lock = item and true or false
  self.bind.txt_input5_lock = item and true or false
  item = item or {
    "",
    "",
    "",
    "",
    ""
  }
  self.bind.txt_input1 = tostring(item[1])
  self.bind.txt_input2 = tostring(item[2])
  self.bind.txt_input3 = tostring(item[3])
  self.bind.txt_input4 = tostring(item[4])
  self.bind.txt_input5 = tostring(item[5])
end

return this
