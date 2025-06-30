module('bag.BagEquipSuitScrollerItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
	super.onInit(self, go)

	self.mGroupNormal = self.m_childGos['mGroupNormal'] 

	self.mImgSuitIcon = self:getChildGO('mImgSuitIcon'):GetComponent(ty.AutoRefImage)
	self.mTxtHad_1 = self:getChildGO('mTxtHad_1'):GetComponent(ty.Text)
	self.mTxtHad_2 = self:getChildGO('mTxtHad_2'):GetComponent(ty.Text)
	self.mTxtName = self:getChildGO('mTxtName'):GetComponent(ty.Text)
	self.mTxtEnglishName = self:getChildGO('mTxtEnglishName'):GetComponent(ty.Text)
	self.mTxtCount = self:getChildGO('mTxtCount'):GetComponent(ty.Text)
	self.mTxtEffect = self:getChildGO('mTxtEffect'):GetComponent(ty.Text)
	self.mTxtAllCount = self:getChildGO('mTxtAllCount'):GetComponent(ty.Text)
	self.mGroupAllEquip = self:getChildGO('mGroupAllEquip')
	self:getChildGO('mTxtName2'):GetComponent(ty.Text).text = _TT(4011)--"全部"
	self:addOnClick(self.UIObject, self.onClickItemHandler)
end

function setData(self, param)
	super.setData(self, param)
	self:updateDataView()
end

function updateDataView(self)
	self.mTxtHad_1.text = _TT(25019)--"持有"
	self.mTxtHad_2.text = _TT(25019)--"持有"

	local suitConfigVo = self.data
	if(suitConfigVo.suitId == equip.EquipSuitManager.All_SUIT_EQUIP_ID) then
		-- 所有装备
		self.mGroupAllEquip:SetActive(true)
		self.mGroupNormal:SetActive(false)
		
		local equipList = bag.BagManager:getPropsListByType(PropsType.EQUIP)
		self.mTxtAllCount.text =  #equipList
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
			if(suitConfigVo.suitId == equipConfigVo.suitId) then
				hasCount = hasCount + 1
			end
		end
		self.mTxtCount.text = hasCount
	end
end

function onClickItemHandler(self)
	local suitConfigVo = self.data
	bag.BagManager:dispatchEvent(bag.BagManager.SELECT_EQUIP_SUIT, {suitId = suitConfigVo.suitId})
end

function deActive(self)
	super.deActive(self)
end

function onDelete(self)
	super.onDelete(self)
	self:removeOnClick(self.UIObject.gameObject, self.onClickItemHandler)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
