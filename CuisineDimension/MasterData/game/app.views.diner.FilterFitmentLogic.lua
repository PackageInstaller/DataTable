local ItemCsv = require("csvdata.item")
local FitCsv = require("csvdata.diner_fitment")
local FilterFitmentLogic = class("FilterFitmentLogic")
local SortRules = {
  default = function(a, b)
    return ItemCsv[FitCsv[a.id].item].star > ItemCsv[FitCsv[b.id].item].star
  end,
  Asc = function(a, b)
    return ItemCsv[FitCsv[a.id].item].star < ItemCsv[FitCsv[b.id].item].star
  end
}

function FilterFitmentLogic:ctor(params)
  cc(self):addComponent("components.behavior.EventProtocol"):exportMethods()
  self.source = params.fits
  self.result = params.fits
  self.fitType = 0
  self.themeType = 0
  self.sortRule = "default"
end

function FilterFitmentLogic:setSource(fits)
  self.source = fits
  self:filter()
  self:dispatchEvent({name = "filter"})
end

function FilterFitmentLogic:filterByRule(rule)
  self.sortRule = rule
  self:filter()
  self:dispatchEvent({name = "filter"})
end

function FilterFitmentLogic:filterByType(params)
  self.fitType = params.fit or self.fitType
  self.themeType = params.theme or self.themeType
  self:filter()
  self:dispatchEvent({name = "filter"})
end

function FilterFitmentLogic:filter()
  self.result = {}
  for _, data in pairs(self.source) do
    if (self.fitType == 0 or self.fitType == FitCsv[data.id].type) and (self.themeType == 0 or self.themeType == FitCsv[data.id].box) then
      table.insert(self.result, data)
    end
  end
  table.sort(self.result, SortRules[self.sortRule])
end

function FilterFitmentLogic:getResult()
  return self.result
end

return FilterFitmentLogic
