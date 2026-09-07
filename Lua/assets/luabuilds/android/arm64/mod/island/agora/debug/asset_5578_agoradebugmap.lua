local AgoraDebugMap = class("AgoraDebugMap", import("Mod.Island.Core.View.IslandBaseOpView"))
local var_0_1 = Color.New(1, 0, 0, 1)
local var_0_2 = Color.New(0, 1, 0, 1)

function AgoraDebugMap:GetUIName()
	return "IslandAgoraDebugUI"
end

function AgoraDebugMap:OnInit(arg_2_1)
	self._go = arg_2_1

	setParent(arg_2_1, pg.UIMgr.GetInstance().UIMain)

	self.tpl = arg_2_1.transform:Find("Image")
	self.items = {}
	self.isInited = false

	self:GenMap(self.view.agora.map)

	return
end

function AgoraDebugMap:GenMap(arg_3_1)
	local var_3_0 = {}
	local var_3_1 = 0

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		for iter_3_2, iter_3_3 in pairs(iter_3_1) do
			table.insert(var_3_0, function(arg_4_0)
				var_3_1 = var_3_1 + 1

				if self.exited then
					arg_4_0()

					return
				end

				self:CreateItem({
					position = Vector2(iter_3_0, iter_3_2),
					flag = iter_3_3
				})

				if var_3_1 % 50 == 0 then
					onNextTick(arg_4_0)
				else
					arg_4_0()
				end

				return
			end)
		end
	end

	seriesAsync(var_3_0, function()
		self.isInited = true

		self:FlushAll(arg_3_1)

		return
	end)

	return
end

function AgoraDebugMap:FlushAll(arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_1) do
		for iter_6_2, iter_6_3 in pairs(iter_6_1) do
			self:UpdateItem(Vector2(iter_6_0, iter_6_2), iter_6_3)
		end
	end

	return
end

function AgoraDebugMap:CreateItem(arg_7_1)
	local var_7_0 = cloneTplTo(self.tpl, self.tpl.transform.parent)

	var_7_0.name = arg_7_1.position.x .. "_" .. arg_7_1.position.y

	local var_7_1 = Vector3(10, 10, 0)

	var_7_0.transform.localPosition = Vector3(arg_7_1.position.x * var_7_1.x, arg_7_1.position.y * var_7_1.y, 0)
	self.items[arg_7_1.position.x] = self.items[arg_7_1.position.x] or {}
	self.items[arg_7_1.position.x][arg_7_1.position.y] = var_7_0

	return
end

function AgoraDebugMap:UpdateItem(arg_8_1, arg_8_2)
	if not self.isInited then
		return
	end

	if arg_8_2 then
		self.items[arg_8_1.x][arg_8_1.y]:GetComponent(typeof(Image)).color = var_0_2 or var_0_1
	end

	return
end

function AgoraDebugMap:OnDestroy()
	self.exited = true

	return
end

return AgoraDebugMap
