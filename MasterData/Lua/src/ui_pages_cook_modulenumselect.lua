local this = class("moduleNumSelect", G_UIModuleBase)
local commonItemTpl = L_GameTpl:getCommonItemTpl()
local foodCookTpl = L_GameTpl:getFoodCookTpl()

function this.bind()
  return {
    curFoodNum = "",
    foodIcon = "",
    propItem = {
      moduleName = "modulePages/cellIcon"
    },
    moduleInputNum = {
      moduleName = "modulePages/moduleSelectNum"
    }
  }
end

function this.methods()
  return {
    onClick_close = function(self)
      self.closeModule()
    end,
    onClick_confirm = function(self)
      self.closeModule()
      local data = {
        id = self.cookId,
        count = tonumber(self.curValue)
      }
      self.confirm(data)
    end
  }
end

function this:initModule(options)
  self.maxValue = options.maxValue
  self.cookId = options.cookId
  self.foodId = foodCookTpl:getNormal(foodCookTpl:getTplById(self.cookId))[1][2]
  self.closeModule = options.closeCurModule
  self.confirm = options.confirm
  self.material = options.material
  self.curValue = 1
  local itemFood = commonItemTpl:getTplById(self.foodId)
  self.bind.curFoodNum = L_WordsTpl:getValue("ui_systemMessage_09") .. C_BagMgr:getItemNumByItemId(self.foodId)
  self.bind.foodIcon = commonItemTpl:getIcon(itemFood)
  
  local function func(num)
    self.curValue = num
    self:choiceNum()
  end
  
  local max = 1
  if self.maxValue ~= 0 then
    max = self.maxValue
  end
  self.modules.moduleInputNum:initModule(func, max, 1)
  self:initMaterialList()
  self:choiceNum()
end

function this:choiceNum()
  self.bind.text = tostring(self.curValue)
  for i = 1, #self.bind.propItem do
    local requireNum = self.bind.propItem:getValue(i, "requireNum")
    self.bind.propItem:getItemCls(i):setNum(requireNum * self.curValue)
  end
end

function this:initMaterialList()
  local data = {}
  local itemList = self.material
  for i = 1, #itemList do
    table.insert(data, {
      requireNum = itemList[i][3],
      itemNumTxt = tostring(itemList[i][3] * self.curValue),
      itemType = L_Const.resType.commonItem,
      itemId = itemList[i][2]
    })
  end
  self.bind.propItem:clear()
  self.bind.propItem:insert_array(data)
end

return this
