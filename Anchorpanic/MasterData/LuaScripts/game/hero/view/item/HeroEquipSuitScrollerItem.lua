module('hero.HeroEquipSuitScrollerItem', Class.impl(bag.BagEquipSuitScrollerItem))

function onInit(self, go)
	super.onInit(self, go)
end

function updateDataView(self)
	self.mTxtHad_1.text = _TT(25019)--"持有"
	self.mTxtHad_2.text = _TT(25019)--"持有"

	local suitConfigVo = self.data.data
	local slotPos = self.data.slotPos

	if(suitConfigVo.suitId == equip.EquipSuitManager.All_SUIT_EQUIP_ID) then
		-- 所有装备
		self.mGroupAllEquip:SetActive(true)
		self.mGroupNormal:SetActive(false)
		
		local equipList = bag.BagManager:getPropsListByType(PropsType.EQUIP)
		local hasCount = 0
		local equipList = bag.BagManager:getPropsListByType(PropsType.EQUIP)
		for i = 1, #equipList do
			local equipConfigVo = equip.EquipManager:getEquipConfigVo(equipList[i].tid)
			local propConfigVo = props.PropsManager:getPropsConfigVo(equipList[i].tid)
			if slotPos == propConfigVo.subType then
				hasCount = hasCount + 1
			end
		end
		self.mTxtAllCount.text =  hasCount
		self.mImgSuitIcon:SetImg(UrlManager:getEquipSuitIconUrl(0), false)
	else
		-- 对应套装装备
		self.mGroupAllEquip:SetActive(false)
		self.mGroupNormal:SetActive(true)
		
		self.mTxtName.text = suitConfigVo.name
		self.mTxtEnglishName.text = suitConfigVo.englishName
		self.mTxtEffect.text = suitConfigVo.effectDes
		self.mImgSuitIcon:SetImg(UrlManager:getEquipSuitIconUrl(suitConfigVo.suitId), false)
		
		local hasCount = 0
		local equipList = bag.BagManager:getPropsListByType(PropsType.EQUIP)
		for i = 1, #equipList do
			local equipConfigVo = equip.EquipManager:getEquipConfigVo(equipList[i].tid)
			local propConfigVo = props.PropsManager:getPropsConfigVo(equipList[i].tid)
			if(suitConfigVo.suitId == equipConfigVo.suitId and slotPos == propConfigVo.subType) then
				hasCount = hasCount + 1
			end
		end
		self.mTxtCount.text = hasCount
	end
end

function onClickItemHandler(self)
	local suitConfigVo = self.data.data
	hero.HeroEquipManager:dispatchEvent(hero.HeroEquipManager.HERO_BAG_SUIT_SELECT, {suitId = suitConfigVo.suitId})
end

function deActive(self)
	super.deActive(self)
end

function onDelete(self)
	super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
