local PolyhedronTerminalLine = class("PolyhedronTerminalLine", ReduxView)

function PolyhedronTerminalLine:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.id_list = {}

	for iter_1_0, iter_1_1 in pairs((string.split(arg_1_2, "_"))) do
		table.insert(self.id_list, tonumber(iter_1_1))
	end

	self:Init()
end

function PolyhedronTerminalLine:Init()
	self.stateController = ControllerUtil.GetController(self.transform_, "state")
end

function PolyhedronTerminalLine:SetData(arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(self.id_list) do
		if iter_3_1 ~= 0 and not table.indexof(arg_3_1, iter_3_1) then
			self.stateController:SetSelectedIndex(0)

			return
		end
	end

	self.stateController:SetSelectedIndex(1)
end

function PolyhedronTerminalLine:Dispose()
	PolyhedronTerminalLine.super.Dispose(self)
end

return PolyhedronTerminalLine
