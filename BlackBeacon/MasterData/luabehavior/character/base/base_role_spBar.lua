local roleSpBar = {}
roleSpBar.__index = roleSpBar
roleSpBar.limit = 9

function roleSpBar.new(base, role, list)
  local result = setmetatable({}, base)
  result.base = base
  result.role = role
  result.tool = role.tool
  result.isHide = false
  if not list then
  end
  result.max = #list
  result.list = {}
  result.num = 0
  for i, state in ipairs(list) do
    result.list[i] = state
    if state then
      result.num = result.num + 1
    end
  end
  return result
end

function roleSpBar.insertFun(spBar, funName, newFun)
  spBar.tool.insert(spBar, funName, newFun)
end

function roleSpBar.removeFun(spBar, funName, newFun)
  spBar.tool.remove(spBar, funName, newFun)
end

function roleSpBar.clear(spBar)
  spBar:decrease(spBar.max)
end

function roleSpBar.isFront(spBar)
  return spBar.role:isInControl()
end

function roleSpBar.hide(spBar, needClear)
  if needClear then
    spBar:clear()
  end
  spBar.isHide = true
  if not spBar:isFront() then
    return
  end
  set_ui_object_visible("fight", "SpecialBar", false)
end

function roleSpBar.show(spBar)
  spBar.isHide = false
  if not spBar:isFront() then
    return
  end
  init_special_fight_ui(2, spBar.max, spBar.list, spBar.role.npc.uuid)
  set_ui_object_visible("fight", "SpecialBar", true)
end

function roleSpBar.init(spBar)
  if spBar.role.npc ~= get_come_on_hero() then
    return
  end
  if spBar.isHide then
    spBar:hide()
  else
    spBar:show()
  end
end

function roleSpBar.draw(spBar)
  if spBar.role.npc ~= get_come_on_hero() then
    return
  end
  if spBar.isHide then
    return
  end
  update_point_fight_ui(spBar.max, spBar.list)
end

function roleSpBar.increase(spBar, num)
  if spBar.num == spBar.max then
    return
  end
  num = num or 1
  local startPos = spBar.num + 1
  local finPos = math.min(spBar.max, spBar.num + num)
  for i = startPos, finPos do
    spBar.list[i] = true
  end
  spBar.num = finPos
  spBar:draw()
end

function roleSpBar.decrease(spBar, num)
  if 0 == spBar.num then
    return
  end
  num = num or 1
  local startPos = spBar.num
  local finPos = math.max(1, spBar.num - num + 1)
  for i = startPos, finPos, -1 do
    spBar.list[i] = false
  end
  spBar.num = finPos - 1
  spBar:draw()
end

function roleSpBar.setNum(spBar, num)
  num = math.min(num, spBar.max)
  for i = 1, spBar.max do
    spBar.list[i] = i <= num
  end
  spBar.num = num
  spBar:draw()
end

function roleSpBar.getNum(spBar)
  return spBar.num
end

function roleSpBar.getMax(spBar)
  return spBar.max
end

function roleSpBar.expand(spBar, num)
  num = num or 1
  local startPos = spBar.max + 1
  spBar.max = spBar.max + num
  if spBar.max > spBar.limit then
    Util.debug_output("尝试扩充角色特殊资源条点数时超过上限，上限为 " .. spBar.limit)
    spBar.max = spBar.limit
  end
  for i = startPos, spBar.max do
    spBar.list[i] = false
  end
  spBar:init()
  spBar:draw()
end

function roleSpBar.shrink(spBar, num)
  num = num or 1
  local startPos = spBar.max
  spBar.max = spBar.max - num
  if spBar.max < 1 then
    Util.debug_output("尝试缩减角色特殊资源条点数时超过下限，下限为 1")
    spBar.max = 1
  end
  for i = startPos, spBar.max + 1, -1 do
    spBar.list[i] = nil
  end
  spBar:init()
  spBar:draw()
end

return roleSpBar
