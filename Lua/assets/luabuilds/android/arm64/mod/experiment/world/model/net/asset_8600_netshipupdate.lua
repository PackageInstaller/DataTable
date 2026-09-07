local NetShipUpdate = class("NetShipUpdate", import("....BaseEntity"))

NetShipUpdate.Fields = {
	id = "number",
	hpRant = "number"
}

function NetShipUpdate:Setup(arg_1_1)
	self.id = arg_1_1.id
	self.hpRant = arg_1_1.hp_rant

	return
end

return NetShipUpdate
