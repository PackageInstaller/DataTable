local CityRebuildProxy = class("CityRebuildProxy", import(".NetProxy"))

CityRebuildProxy.GET_DATA = 1
CityRebuildProxy.REBUILD_OR_START_RECRUIT = 2
CityRebuildProxy.END_RECRUIT = 3
CityRebuildProxy.UPGRADE_BUFF = 4
CityRebuildProxy.RESULT = 5
CityRebuildProxy.CHOOSE_LEVEL = 6
CityRebuildProxy.INIT_TIME = 7

local var_0_1 = pg.activity_ninja_building

function CityRebuildProxy:register()
	self.cityRebuildDataDic = {}

	return
end

function CityRebuildProxy:SetData(arg_2_1, arg_2_2)
	self.cityRebuildDataDic[arg_2_1] = CityRebuildData.New(arg_2_2)

	return
end

function CityRebuildProxy:GetData(arg_3_1)
	return self.cityRebuildDataDic[arg_3_1]
end

function CityRebuildProxy:Adjust(arg_4_1, arg_4_2)
	if not self.cityRebuildDataDic[arg_4_1] then
		return
	end

	self.cityRebuildDataDic[arg_4_1]:Adjust(arg_4_2)

	return
end

function CityRebuildProxy:RebuildOrStartRecruit(arg_5_1, arg_5_2)
	if not self.cityRebuildDataDic[arg_5_1] then
		return
	end

	if var_0_1[arg_5_2].type == 1 then
		self.cityRebuildDataDic[arg_5_1]:RebuildDone(arg_5_2)
	else
		self.cityRebuildDataDic[arg_5_1]:StartRecruit(arg_5_2)
	end

	return
end

function CityRebuildProxy:RecruitDone(arg_6_1, arg_6_2)
	if not self.cityRebuildDataDic[arg_6_1] then
		return
	end

	self.cityRebuildDataDic[arg_6_1]:RecruitDone(arg_6_2)

	return
end

function CityRebuildProxy:UpgradeBuff(arg_7_1, arg_7_2, arg_7_3)
	if not self.cityRebuildDataDic[arg_7_1] then
		return
	end

	self.cityRebuildDataDic[arg_7_1]:UpgradeBuff(arg_7_2, arg_7_3)

	return
end

function CityRebuildProxy:Result(arg_8_1, arg_8_2)
	if not self.cityRebuildDataDic[arg_8_1] then
		return
	end

	self.cityRebuildDataDic[arg_8_1]:Result(arg_8_2)

	return
end

function CityRebuildProxy:UpdateChooseLevel(arg_9_1, arg_9_2)
	if not self.cityRebuildDataDic[arg_9_1] then
		return
	end

	self.cityRebuildDataDic[arg_9_1]:UpdateChooseLevel(arg_9_2)

	return
end

function CityRebuildProxy:ComsumePt(arg_10_1, arg_10_2)
	if not self.cityRebuildDataDic[arg_10_1] then
		return
	end

	self.cityRebuildDataDic[arg_10_1]:ConsumePt(arg_10_2)

	return
end

function CityRebuildProxy:AddPt(arg_11_1, arg_11_2)
	if not self.cityRebuildDataDic[arg_11_1] then
		return
	end

	self.cityRebuildDataDic[arg_11_1]:AddPt(arg_11_2)

	return
end

return CityRebuildProxy
