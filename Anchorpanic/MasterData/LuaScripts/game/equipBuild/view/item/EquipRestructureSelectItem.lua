module('equipBuild.EquipRestructureSelectItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
	super.onInit(self, go)
end

function setData(self, param)
	super.setData(self, param)
	
	local scrollEquipVo = self.data
    local equipVo = scrollEquipVo:getDataVo()
	if (equipVo) then
		if(not self.m_propsSelectGrid) then
			self.m_propsSelectGrid = PropsSelectGrid:poolGet()
		end
		self.m_propsSelectGrid:setData(equipVo, true)
		self.m_propsSelectGrid:setParent(self.UIObject.transform)
		self.m_propsSelectGrid:setCallBack(self, self.onClickGridHandler)
		self:setSelectState(scrollEquipVo:getSelect())
	else
		self:deActive()
	end
end

function onClickGridHandler(self, args)
	local scrollEquipVo = self.data
	local equipVo = scrollEquipVo:getDataVo()
	-- scrollEquipVo:setSelect(not scrollEquipVo:getSelect())
	equipBuild.EquipRestructureManager:dispatchEvent(equipBuild.EquipRestructureManager.EQUIP_RESTRUCTURE_MATERIAL_SELECT, equipVo)
end

function setSelectState(self, cusIsSelect)
	if(self.m_propsSelectGrid) then
		self.m_propsSelectGrid:setSelectState(cusIsSelect)
	end
end

function getSelectState(self)
	if(self.m_propsSelectGrid) then
		return self.m_propsSelectGrid:getSelectState()
	end
end

function deActive(self)
	super.deActive(self)
	if(self.m_propsSelectGrid) then
		self.m_propsSelectGrid:poolRecover()
		self.m_propsSelectGrid = nil
	end
end

function onDelete(self)
	super.onDelete(self)
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
