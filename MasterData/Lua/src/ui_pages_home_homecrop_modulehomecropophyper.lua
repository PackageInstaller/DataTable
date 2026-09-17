local module = class("moduleHomeCropOpHyper", G_UIModuleBase)

function module.bind()
  return {
    hyper1 = false,
    hyper2 = false,
    hyper3 = false,
    active_hyper1 = true,
    active_hyper2 = true,
    active_hyper3 = true
  }
end

function module.methods()
  return {}
end

function module:setHyperNum(num)
  for i = 1, 3 do
    self.bind["hyper" .. i] = i <= num
  end
end

function module:setCanHyperNum(num)
  for i = 1, 3 do
    self.bind["active_hyper" .. i] = i <= num
  end
end

return module
