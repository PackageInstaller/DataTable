local this = class("rewardTimesItemOption", G_UIModuleBase)
local _keyCodeTpl = L_GameTpl:getKeyCodeTpl()
local _optionDataTpl = L_GameTpl:getOptionDataTpl()
local COUNT_LIMIT = 5

function this.bind()
  return {
    type8 = false,
    type8Text = "",
    dropdownToggle = false,
    dropdown = false,
    cellChoiceItemList = {
      moduleName = "pages/Option/cellListItem"
    }
  }
end

function this.methods()
  return {
    cellChoiceItemList = {
      onClick = function(self, text, index, num)
        self.bind.type8Text = text
        self:emit("onChange", index)
        self.bind.dropdownToggle = false
      end
    },
    onClick_type8Btn = function(self)
      self:refresh_dropdown()
      self:emit("changeDropdown", function()
        self:refresh_dropdown()
      end)
    end
  }
end

function this:ctor(...)
  this.super.ctor(self, ...)
end

function this:toBind(...)
  self.refreshDirty = true
  this.super.toBind(self, ...)
end

function this:refresh_dropMenu(dataList, selectRate)
  self.bind.type8 = true
  local data = dataList
  local defaultId = selectRate
  local tempData = {}
  self.bind.dropdown = true
  self.bind.type8Text = L_WordsTpl:getValue("dungeon_entrust_stamina_num", {
    [1] = defaultId
  })
  for i = 1, #data do
    local desc = L_WordsTpl:getValue("dungeon_entrust_stamina_num", {
      [1] = data[i]
    })
    table.insert(tempData, {
      textW = desc,
      textG = desc,
      index = i
    })
  end
  self.bind.cellChoiceItemList:insert_array(tempData)
end

function this:refresh_dropdown()
  if not self.bind.dropdownToggle then
    for i = 1, #self.bind.cellChoiceItemList do
      if self.bind.cellChoiceItemList:getValue(i, "textW") == self.bind.type8Text then
        self.bind.cellChoiceItemList[i].wObj = true
        self.bind.cellChoiceItemList[i].gObj = false
      else
        self.bind.cellChoiceItemList[i].wObj = false
        self.bind.cellChoiceItemList[i].gObj = true
      end
    end
    self.bind.dropdownToggle = true
  else
    self.bind.dropdownToggle = false
  end
end

return this
