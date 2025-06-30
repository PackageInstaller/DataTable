--[[ 
-----------------------------------------------------
@filename       : EquipPlanVo
@Description    : 模组方案数据vo
@date           : 2023-12-6 00:00:00
@Author         : Zzz
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("equipBuild.EquipPlanVo", Class.impl())

function ctor(self)
end

function parseData(self, cusData)
	-- 方案编号（这里和后端约定直接按照时间戳发）
	self.id = cusData.id
	-- 方案名称
	self.name = cusData.name
	-- 模组方案列表
	self.equipPosDic = {}
	for i = 1, #cusData.chip_list do
		self.equipPosDic[cusData.chip_list[i].pos] = cusData.chip_list[i].equip_id
	end

	-- 唯一key，对比装备列表是否一致
	self.key = ""
	for pos = 1, 6 do
		local equipId = self.equipPosDic[pos]
		if(equipId ~= nil)then
			self.key = self.key .. string.format("%s_%s_", pos, equipId)
		end
	end
end

-- 判断是否和战员身上穿戴的装备是同等位置内容
function equalHeroEquipList(self, heroId)
	local key = ""
	local heroVo = hero.HeroManager:getHeroVo(heroId)
	if(heroVo)then
		for pos = 1, 6 do
			local equipVo = heroVo:getEquipByPos(pos)
			if(equipVo ~= nil)then
				key = key .. string.format("%s_%s_", pos, equipVo.id)
			end
		end
	end
	if(self.key == "" and key == "")then
		return false
	else
		return self.key == key
	end
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
