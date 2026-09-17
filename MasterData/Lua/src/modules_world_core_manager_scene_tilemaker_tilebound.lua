local this = {}

function this.new(...)
  local cls = {}
  cls.__index = this
  cls.__cname = "tileBound"
  
  function cls.__sub(a, b)
  end
  
  local ins = {}
  setmetatable(ins, cls)
  ins:ctor(...)
  return ins
end

function this:ctor(x, y, width, height, maxWidth, maxHeight)
  self.maxWidth = maxWidth
  self.maxHeight = maxHeight
  self:refresh(x or 0, y or 0, width or 0, height or 0)
end

function this:refresh(x, y, width, height)
  self.x = x or self.x
  self.y = y or self.y
  self.width = width or self.width
  self.height = height or self.height
  self.x1 = math.clamp(self.x - self.width, 1)
  self.x2 = math.clamp(self.x + self.width, 1, self.maxWidth)
  self.y1 = math.clamp(self.y - self.height, 1)
  self.y2 = math.clamp(self.y + self.height, 1, self.maxHeight)
end

function this:getDictionaryView(view)
  view = view or {}
  for x = self.x1, self.x2 do
    for y = self.y1, self.y2 do
      local gridID = (y - 1) * self.maxWidth + x
      view[gridID] = gridID
    end
  end
  return view
end

function this:getCircleView(view)
  view = view or {}
  local list = {}
  
  local function _surround(x, y, queue, box)
    for i = math.clamp(x - 1, self.x1), math.clamp(x + 1, 1, self.x2) do
      for j = math.clamp(y - 1, self.y1), math.clamp(y + 1, 1, self.y2) do
        local gridID = (j - 1) * self.maxWidth + i
        if not box[gridID] then
          box[gridID] = gridID
          table.insert(queue, gridID)
        end
      end
    end
    local first = table.remove(queue)
    if first then
      table.insert(list, first)
      local x = (first - 1) % self.width + 1
      local y = math.ceil(first / self.width)
      _surround(x, y, queue)
    end
  end
  
  _surround(self.x, self.y, {}, {})
  return list
end

return this
