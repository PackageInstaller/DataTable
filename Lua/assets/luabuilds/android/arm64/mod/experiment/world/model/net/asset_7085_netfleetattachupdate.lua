local NetFleetAttachUpdate = class("NetFleetAttachUpdate", import("....BaseEntity"))

NetFleetAttachUpdate.Fields = {
	row = "number",
	column = "number",
	id = "number"
}

function NetFleetAttachUpdate:Setup(arg_1_1)
	self.id = arg_1_1.item_id
	self.row = arg_1_1.pos.row
	self.column = arg_1_1.pos.column

	return
end

return NetFleetAttachUpdate
