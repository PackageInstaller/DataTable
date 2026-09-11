local MatrixRotationDiagram2D = class("MatrixRotationDiagram2D", ReduxView)

function MatrixRotationDiagram2D:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform
	self.particle = arg_1_2

	self:Init()
end

function MatrixRotationDiagram2D:Init()
	self:InitUI()
end

function MatrixRotationDiagram2D:InitUI()
	self:BindCfgUI()

	self.itemSize = Vector2.New(650, 700)
	self.itemOffset = 350
	self.itemCount = 6

	self:CalulateDataStatic()
	self:CreatItem()
end

function MatrixRotationDiagram2D:SetData(arg_4_1)
	self:Change(arg_4_1, true)
end

function MatrixRotationDiagram2D:CreatItem()
	self.itemList = {}

	for iter_5_0 = 1, self.itemCount do
		local var_5_0 = MatrixRotationDiagramItem.New(self.m_ratationItem, self.m_ratationContent)

		var_5_0:SetData(iter_5_0)
		table.insert(self.itemList, var_5_0)
	end
end

function MatrixRotationDiagram2D:Change(arg_6_1, arg_6_2)
	for iter_6_0, iter_6_1 in ipairs(self.itemList) do
		iter_6_1:SetPosId((iter_6_1:GetIndex() - arg_6_1 + #self.itemList) % #self.itemList + 1)
	end

	table.sort(self.itemList, function(arg_7_0, arg_7_1)
		return self.itemPosList[arg_7_0:GetPosId()].order < self.itemPosList[arg_7_1:GetPosId()].order
	end)

	for iter_6_2, iter_6_3 in ipairs(self.itemList) do
		local var_6_0 = self.itemPosList[iter_6_3:GetPosId()]

		if arg_6_2 then
			SetActive(self.particle, true)
			iter_6_3:InitPosData(var_6_0)
		else
			SetActive(self.particle, false)
			TimeTools.StartAfterSeconds(0.5, function()
				if self.particle then
					SetActive(self.particle, true)
				end
			end, {})
			iter_6_3:SetPosData(var_6_0)
		end
	end
end

function MatrixRotationDiagram2D:Dispose()
	for iter_9_0, iter_9_1 in ipairs(self.itemList) do
		iter_9_1:Dispose()
	end

	MatrixRotationDiagram2D.super.Dispose(self)
end

function MatrixRotationDiagram2D:CalulateDataStatic()
	self.itemPosList = {
		{
			scale = 1,
			order = 6,
			pos = Vector3.New(0, -100, 0),
			color = Color.New(1, 1, 1)
		},
		{
			scale = 0.7,
			order = 5,
			pos = Vector3.New(500, -30, 0),
			color = Color.New(0.3325, 0.3613, 0.4433)
		},
		{
			scale = 0.53,
			order = 3,
			pos = Vector3.New(325, 40, 0),
			color = Color.New(0.2448, 0.2448, 0.3962)
		},
		{
			scale = 0.375,
			order = 1,
			pos = Vector3.New(0, 100, 0),
			color = Color.New(0.2314, 0.2314, 0.3207)
		},
		{
			scale = 0.53,
			order = 2,
			pos = Vector3.New(-325, 40, 0),
			color = Color.New(0.2448, 0.2448, 0.3962)
		},
		{
			scale = 0.7,
			order = 4,
			pos = Vector3.New(-500, -30, 0),
			color = Color.New(0.3325, 0.3613, 0.4433)
		}
	}
end

return MatrixRotationDiagram2D
