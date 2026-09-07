local WSEntranceTpl = class("WSEntranceTpl", import("...BaseEntity"))

WSEntranceTpl.Fields = {
	markSigns = "table",
	markTFs = "table",
	world = "table",
	transform = "userdata",
	portCamp = "number",
	entrance = "table",
	tfMap = "userdata",
	tfArea = "userdata"
}
WSEntranceTpl.Listeners = {
	onUpdateDisplayMarks = "OnUpdateDisplayMarks"
}
WSEntranceTpl.DisplayOrder = {
	"step",
	"task_main",
	"task_collecktion",
	"task",
	"sairen",
	"treasure_sairen",
	"treasure",
	"task_following_main",
	"task_following_boss",
	"task_following"
}
WSEntranceTpl.prefabName = {
	task_main = "DSJ_BX05_3D",
	task = "DSJ_BX03_3D",
	port_gray_2 = "mark_port_gray_2",
	port_mark = "mark_port_tip",
	task_following_boss = "DSJ_BX07_3D",
	buff_a = "buff_a",
	buff_h = "buff_h",
	buff_a2 = "buff_a2",
	buff_h2 = "buff_h2",
	port_mark_new = "mark_port_tip_new",
	treasure_sairen = "DSJ_BX06_3D",
	port_2 = "mark_port_2",
	buff_d2 = "buff_d2",
	currency = "currency",
	port_gray_1 = "mark_port_gray_1",
	port_1 = "mark_port_1",
	mate = "mate",
	buff_d = "buff_d",
	task_collecktion = "DSJ_BX08_3D",
	task_following = "DSJ_BX03_3D",
	treasure = "DSJ_BX01_3D",
	sairen = "guangzhu",
	core = "core",
	task_following_main = "DSJ_BX05_3D",
	step = "DSJ_BX05_3D"
}
WSEntranceTpl.offsetField = {
	task_main = "offset_pos",
	task_following_main = "offset_pos",
	task_following_boss = "offset_pos",
	task_following = "offset_pos",
	task_collecktion = "offset_pos",
	task = "offset_pos",
	treasure = "offset_pos",
	treasure_sairen = "offset_pos",
	step = "offset_pos"
}

function WSEntranceTpl:Build()
	self.transform = tf(GameObject.New())

	return
end

function WSEntranceTpl:Setup()
	pg.DelegateInfo.New(self)
	self:Init()

	return
end

function WSEntranceTpl:Dispose()
	pg.DelegateInfo.Dispose(self)
	self:RemoveEntranceListener()

	local var_3_0 = PoolMgr.GetInstance()

	for iter_3_0, iter_3_1 in pairs(self.markTFs) do
		iter_3_1.localPosition = Vector3.zero

		var_3_0:ReturnPrefab("world/mark/" .. WSEntranceTpl.prefabName[iter_3_0], WSEntranceTpl.prefabName[iter_3_0], go(iter_3_1), true)
	end

	Destroy(self.transform)
	self:Clear()

	return
end

function WSEntranceTpl:Init()
	self.markTFs = {}

	return
end

function WSEntranceTpl:UpdateEntrance(arg_5_1, arg_5_2)
	if arg_5_2 or self.entrance ~= arg_5_1 then
		self:RemoveEntranceListener()
		_.each(self.markTFs, function(arg_6_0)
			setActive(arg_6_0, false)

			return
		end)

		self.entrance = arg_5_1

		if self.entrance:HasPort() then
			self.portCamp = pg.world_port_data[self.entrance.config.port_map_icon].port_camp or nil
		end

		self:AddEntranceListener()
		self:InitMarksValue()

		if self.portCamp then
			self.transform.name = "port_" .. arg_5_1.id or arg_5_1:GetColormaskUniqueID()
		end

		self:DoUpdateMark(self:GetShowMark(), true)
	end

	return
end

function WSEntranceTpl:InitMarksValue()
	self.markSigns = {}

	for iter_7_0, iter_7_1 in pairs((self.entrance:GetDisplayMarks())) do
		self.markSigns[iter_7_0] = iter_7_1 > 0
	end

	return
end

function WSEntranceTpl:AddEntranceListener()
	if self.entrance then
		self.entrance:AddListener(WorldEntrance.EventUpdateDisplayMarks, self.onUpdateDisplayMarks)
	end

	return
end

function WSEntranceTpl:RemoveEntranceListener()
	if self.entrance then
		self.entrance:RemoveListener(WorldEntrance.EventUpdateDisplayMarks, self.onUpdateDisplayMarks)
	end

	return
end

function WSEntranceTpl:LoadPrefab(arg_10_1, arg_10_2)
	local var_10_0 = PoolMgr.GetInstance()

	var_10_0:GetPrefab("world/mark/" .. WSEntranceTpl.prefabName[arg_10_1], WSEntranceTpl.prefabName[arg_10_1], true, function(arg_11_0)
		if self.markTFs and not self.markTFs[arg_10_1] then
			self.markTFs[arg_10_1] = tf(arg_11_0)

			SetParent(self.markTFs[arg_10_1], self.transform, false)

			self.markTFs[arg_10_1].localPosition = self:GetPrefabOffset(arg_10_1)

			if arg_10_2 then
				SetParent(self.markTFs[arg_10_1], arg_10_2, true)
			end

			setActive(self.markTFs[arg_10_1], true)
		else
			var_10_0:ReturnPrefab("world/mark/" .. WSEntranceTpl.prefabName[arg_10_1], WSEntranceTpl.prefabName[arg_10_1], arg_11_0, true)
		end

		return
	end)

	return
end

function WSEntranceTpl:GetPrefabOffset(arg_12_1)
	local var_12_0

	if WSEntranceTpl.offsetField[arg_12_1] then
		var_12_0 = self.entrance.config[WSEntranceTpl.offsetField[arg_12_1]] or {
			0,
			0
		}
	end

	return Vector3(var_12_0[1] / PIXEL_PER_UNIT, 0, var_12_0[2] / PIXEL_PER_UNIT)
end

function WSEntranceTpl:UpdateMark(arg_13_1, arg_13_2)
	self:DoUpdateMark(self:GetShowMark(), false)

	self.markSigns[arg_13_1] = arg_13_2

	self:DoUpdateMark(self:GetShowMark(), true)

	return
end

function WSEntranceTpl:OnUpdateDisplayMarks(arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	self:UpdateMark(arg_14_3, arg_14_4)

	return
end

function WSEntranceTpl:DoUpdateMark(arg_15_1, arg_15_2, arg_15_3)
	if arg_15_1 then
		if self.markTFs[arg_15_1] then
			setActive(self.markTFs[arg_15_1], arg_15_2)
		elseif arg_15_2 then
			self:LoadPrefab(arg_15_1, arg_15_3)
		end
	end

	return
end

function WSEntranceTpl:GetShowMark()
	for iter_16_0, iter_16_1 in ipairs(WSEntranceTpl.DisplayOrder) do
		if self.markSigns[iter_16_1] then
			return iter_16_1
		end
	end

	return
end

function WSEntranceTpl:UpdatePort(arg_17_1, arg_17_2, arg_17_3)
	self:DoUpdateMark("port_" .. self.portCamp, arg_17_1)
	self:DoUpdateMark("port_gray_" .. self.portCamp, not arg_17_1)
	self:DoUpdateMark("port_mark", arg_17_2)
	self:DoUpdateMark("port_mark_new", arg_17_3)

	return
end

function WSEntranceTpl:UpdatePressingAward()
	local var_18_0 = nowWorld():GetPressingAward(self.entrance.id)

	if var_18_0 then
		self:DoUpdateMark(pg.world_event_complete[var_18_0.id].map_icon, var_18_0.flag, self.tfMap)
	end

	return
end

return WSEntranceTpl
