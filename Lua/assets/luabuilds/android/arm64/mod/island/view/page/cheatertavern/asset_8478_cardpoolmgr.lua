local CardPoolMgr = class("CardPoolMgr")
local var_0_1 = 5
local var_0_2 = 3

function CardPoolMgr:Ctor()
	self.poolRoot = GameObject.New("CardPoolRoot")
	self.poolDic = {}

	return
end

function CardPoolMgr:GetCardGameObjectById(arg_2_1, arg_2_2, arg_2_3)
	self.poolDic[arg_2_1] = self.poolDic[arg_2_1] or {}

	if #self.poolDic[arg_2_1] == 0 then
		if arg_2_3 then
			arg_2_2((Object.Instantiate((LoadAny(pg.island_unit_item[pg.bar_card[arg_2_1].unit_res].model, nil)))))
		else
			LoadAnyAsync(pg.island_unit_item[pg.bar_card[arg_2_1].unit_res].model, "", nil, function(arg_3_0)
				arg_2_2((Object.Instantiate(arg_3_0)))

				return
			end)
		end
	else
		local var_2_0 = self.poolDic[arg_2_1][1]

		if IsNil(self.poolDic[arg_2_1][1]) then
			table.remove(self.poolDic[arg_2_1], 1)
			self:GetCardGameObjectById(arg_2_1, arg_2_2, arg_2_3)
		else
			setActive(var_2_0.transform, true)
			table.remove(self.poolDic[arg_2_1], 1)
			arg_2_2(var_2_0)
		end
	end

	return
end

function CardPoolMgr:ReturnGameObjectById(arg_4_1, arg_4_2)
	if IsNil(arg_4_2) then
		return
	end

	if arg_4_1 == 0 then
		if (var_0_1 or var_0_2) <= #self.poolDic[arg_4_1] then
			GameObject.Destroy(arg_4_2.gameObject)

			goto label_4_0
		end
	end

	table.insert(self.poolDic[arg_4_1], arg_4_2)
	setActive(arg_4_2.transform, false)
	setParent(arg_4_2.transform, self.poolRoot.transform, false)

	::label_4_0::

	return
end

function CardPoolMgr:Destroy()
	for iter_5_0, iter_5_1 in pairs(self.poolDic) do
		for iter_5_2 = #iter_5_1, 1, -1 do
			GameObject.Destroy(iter_5_1[iter_5_2].gameObject)
		end
	end

	self.poolDic = {}

	if self.poolRoot then
		GameObject.Destroy(self.poolRoot)

		self.poolRoot = nil
	end

	return
end

return CardPoolMgr
