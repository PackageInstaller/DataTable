local cargo_manager = {}
cargo_manager.cargo_list = {}
cargo_manager.cargo_weight = 0
cargo_manager.cargo_value = 0

function cargo_manager:add_cargo(id, weight, value)
  self.cargo_weight = self.cargo_weight + weight
  self.cargo_value = self.cargo_value + value
  table.insert(self.cargo_list, {
    id = id,
    weight = weight,
    value = value
  })
end

function cargo_manager:drop_cargo()
  local cargo_id = self.cargo_list[#self.cargo_list].id
  self.cargo_weight = self.cargo_weight - self.cargo_list[#self.cargo_list].weight
  self.cargo_value = self.cargo_value - self.cargo_list[#self.cargo_list].value
  table.remove(self.cargo_list, #self.cargo_list)
  return cargo_id
end

function cargo_manager:deliver_cargo()
  local cargo_value = self.cargo_list[#self.cargo_list].value
  self.cargo_weight = self.cargo_weight - self.cargo_list[#self.cargo_list].weight
  self.cargo_value = self.cargo_value - self.cargo_list[#self.cargo_list].value
  table.remove(self.cargo_list, #self.cargo_list)
  return cargo_value
end

function cargo_manager:clear()
  for key, value in pairs(self) do
    key = nil
  end
end

return cargo_manager
