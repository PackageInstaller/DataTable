-- chunkname: @IQIGame\\Config\\CfgNPCTable.lua

local CfgNPCTable = {
	[321001] = {
		ID = 321001,
		Picture = "/DataResource/RoleResources/HeroResource/Yuan/OtherImg_Yuan/Friend_HeadImg_0_300301.png",
		Scale = 1,
		Name = getI18NValue(180003945)
	},
	[321002] = {
		ID = 321002,
		Picture = "/DataResource/RoleResources/HeroResource/Yuan/OtherImg_Yuan/Warlock_Icon_0_300301.png",
		Scale = 1,
		Name = getI18NValue(180003946)
	},
	[321003] = {
		ID = 321003,
		Picture = "/DataResource/RoleResources/HeroResource/Yuan/VerticalDrawImg/HeroVerticalDraw_100301.png",
		Scale = 1,
		Name = getI18NValue(180003947)
	},
	[321004] = {
		ID = 321004,
		Picture = "/DataResource/RoleResources/HeroResource/Yuan/VerticalDrawImg/HeroVerticalDraw_100301.png",
		Name = getI18NValue(180003948)
	},
	[321005] = {
		ID = 321005,
		Picture = "/DataResource/RoleResources/HeroResource/An/OtherImg_An/Warlock_Icon_0_300101.png",
		Scale = 1,
		Name = getI18NValue(180041100)
	},
	[321006] = {
		ID = 321006,
		Picture = "/DataResource/RoleResources/HeroResource/Liao/OtherImg_Liao/Friend_HeadImg_0_301301.png",
		Name = getI18NValue(180041101)
	},
	[321007] = {
		ID = 321007,
		Picture = "/DataResource/RoleResources/HeroResource/Liao/VerticalDrawImg/HeroVerticalDraw_101301.png",
		Name = getI18NValue(180041102)
	},
	[321008] = {
		ID = 321008,
		Picture = "/DataResource/RoleResources/HeroResource/Zhao/OtherImg_Zhao/Friend_HeadImg_0_301701.png",
		Name = getI18NValue(180041103)
	},
	[321009] = {
		ID = 321009,
		Picture = "/DataResource/RoleResources/HeroResource/Zhao/VerticalDrawImg/HeroVerticalDraw_101701.png",
		Name = getI18NValue(180041104)
	},
	[321010] = {
		ID = 321010,
		Picture = "/DataResource/RoleResources/HeroResource/LongShanSi/OtherImg_LongShanSi/Friend_HeadImg_0_300201.png",
		Name = getI18NValue(180041105)
	},
	[321011] = {
		ID = 321011,
		Picture = "/DataResource/RoleResources/HeroResource/LongShanSi/VerticalDrawImg/HeroVerticalDraw_100201.png",
		Name = getI18NValue(180041106)
	},
	[321012] = {
		ID = 321012,
		Picture = "/DataResource/RoleResources/NPCResources/NPC_321003.png",
		Name = getI18NValue(180041107)
	},
	[321013] = {
		ID = 321013,
		Picture = "/DataResource/RoleResources/NPCResources/Warlock_NPC_321002.png",
		Name = getI18NValue(180041108)
	},
	[321014] = {
		ID = 321014,
		Picture = "/DataResource/RoleResources/HeroResource/An/VerticalDrawImg/HeroVerticalDraw_100101.png",
		Scale = 1,
		Name = getI18NValue(180041109)
	}
}

setmetatable(CfgNPCTable, {
	__index = function(t, k)
		error("config error :not find key: [" .. tostring(k) .. "] in table: " .. "[CfgNPCTable]")
	end
})

local defaultMetaTable = {
	__index = {
		Scale = 0,
		LIve2D = "",
		Name = "",
		Spine = "",
		Picture = ""
	}
}

for i, data in pairs(CfgNPCTable) do
	setmetatable(data, defaultMetaTable)
end

return CfgNPCTable
