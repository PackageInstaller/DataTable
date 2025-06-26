module('equipBuild.EquipRemakeSelectItem', Class.impl('lib.component.BaseItemRender'))

function onInit(self, go)
    super.onInit(self, go)
end

function setData(self, param)
    super.setData(self, param)

    local scrollEquipVo = self.data
    local equipVo = scrollEquipVo:getDataVo()
    if (equipVo) then
        if (not self.m_propsGrid) then
            self.m_propsGrid = EquipGrid:poolGet()
        end
        self.m_propsGrid:setData(equipVo, self.m_childTrans["mGroupGrid"])
		self.m_propsGrid:setShowEquipStrengthenLvl(false)
		self.m_propsGrid:setScale(1)
		self.m_propsGrid:setClickEnable(false)
		self:getChildGO("mTxtLvl"):GetComponent(ty.Text).text = "Lv." .. equipVo.strengthenLvl
		self:addOnClick(self:getChildGO("mBtnClick"), self.onClickGridHandler)

        self:setSelectState(scrollEquipVo:getSelect())
    else
        self:deActive()
    end
end

function onClickGridHandler(self, args)
    local scrollEquipVo = self.data
    local equipVo = scrollEquipVo:getDataVo()
    -- scrollEquipVo:setSelect(not scrollEquipVo:getSelect())
    equipBuild.EquipRemakeManager:dispatchEvent(equipBuild.EquipRemakeManager.EQUIP_REMAKE_MATERIAL_SELECT, equipVo)
end

function setSelectState(self, cusIsSelect)
	self.isSelect = cusIsSelect
	self:getChildGO("mImgSelect"):SetActive(cusIsSelect)
end

function getSelectState(self)
    return self.isSelect
end

function deActive(self)
    super.deActive(self)
    if (self.m_propsGrid) then
        self.m_propsGrid:poolRecover()
        self.m_propsGrid = nil
    end
end

function onDelete(self)
    super.onDelete(self)
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
