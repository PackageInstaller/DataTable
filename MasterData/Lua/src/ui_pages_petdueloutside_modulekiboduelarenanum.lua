local this = class("moduleKiboDuelArenaNum", G_UIModuleBase)

function this.bind()
  return {
    active_root = false,
    txt_curNum = "",
    txt_maxNum = "",
    color_curNum = C_Color(0, 0, 0, 0)
  }
end

function this.methods()
  return {}
end

function this:initModule()
  local _gameConstTpl = L_GameTpl:getGameConstTpl()
  self.maxNum = _gameConstTpl:getData("KIBO_DUEL_ARENA_MODE_COST_LIMIT", L_Const.GameTplType.int)
  self.curNum = 0
end

function this:setCurNum(num)
  self.curNum = num
  self:refreshView()
end

function this:getCurNum()
  return self.curNum
end

function this:setActive(active)
  self.bind.active_root = active
  if active then
    self:refreshView()
  end
end

function this:refreshView()
  self.bind.txt_curNum = tostring(self.curNum)
  if self.curNum > self.maxNum then
    local _, curColor = C_ColorUtility.TryParseHtmlString("#ca5252")
    self.bind.color_curNum = curColor
  else
    local _, curColor = C_ColorUtility.TryParseHtmlString("#FFFFFF")
    self.bind.color_curNum = curColor
  end
  self.bind.txt_maxNum = string.format("/%s", tostring(self.maxNum))
end

return this
