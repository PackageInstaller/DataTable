local this = class("soulessenceLevelTpl")

function this:init(config)
  self.data = config
  self.tableN = {}
  self.tableR = {}
  self.tableSR = {}
  self.tableSSR = {}
  self:splitData()
end

function this:splitData()
  for i, v in pairs(self.data) do
    if v.rarity == L_Const.quality.n then
      table.insert(self.tableN, v)
    elseif v.rarity == L_Const.quality.r then
      table.insert(self.tableR, v)
    elseif v.rarity == L_Const.quality.sr then
      table.insert(self.tableSR, v)
    else
      table.insert(self.tableSSR, v)
    end
  end
end

function this:getTplById(id, quality)
  if quality == L_Const.quality.n then
    return self.tableN[id]
  elseif quality == L_Const.quality.r then
    return self.tableR[id]
  elseif quality == L_Const.quality.sr then
    return self.tableSR[id]
  else
    return self.tableSSR[id]
  end
end

function this:getExp(tpl)
  if tpl.lv == self:getMaxLevel(tpl) then
    return self:getTplById(tpl.lv - 1, tpl.rarity).exp
  end
  return tpl.exp
end

function this:getExpAll(tpl)
  return tpl.exp_all
end

function this:getLv(tpl)
  return tpl.lv
end

function this:getMaxLevel(tpl)
  local quality = tpl.rarity
  if quality == L_Const.quality.n then
    return #self.tableN
  elseif quality == L_Const.quality.r then
    return #self.tableR
  elseif quality == L_Const.quality.sr then
    return #self.tableSR
  elseif quality == L_Const.quality.ssr then
    return #self.tableSSR
  end
end

function this:getTplByExp(exp, quality)
  if quality == L_Const.quality.n then
    return self:getTplByExpN(exp)
  elseif quality == L_Const.quality.r then
    return self:getTplByExpR(exp)
  elseif quality == L_Const.quality.sr then
    return self:getTplByExpSR(exp)
  else
    return self:getTplByExpSSR(exp)
  end
end

function this:getTplByExpN(exp)
  local res = self.tableN[1]
  for i, v in ipairs(self.tableN) do
    if exp >= v.exp_all then
      res = v
    else
      break
    end
  end
  return res
end

function this:getTplByExpR(exp)
  local res = self.tableR[1]
  for i, v in ipairs(self.tableR) do
    if exp >= v.exp_all then
      res = v
    else
      break
    end
  end
  return res
end

function this:getTplByExpSR(exp)
  local res = self.tableSR[1]
  for i, v in ipairs(self.tableSR) do
    if exp >= v.exp_all then
      res = v
    else
      break
    end
  end
  return res
end

function this:getTplByExpSSR(exp)
  local res = self.tableSSR[1]
  for i, v in ipairs(self.tableSSR) do
    if exp >= v.exp_all then
      res = v
    else
      break
    end
  end
  return res
end

return this
