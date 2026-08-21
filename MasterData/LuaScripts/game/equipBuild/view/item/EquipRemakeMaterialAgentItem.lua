module("equipBuild.EquipRemakeMaterialAgentItem", Class.impl("game/equipBuild/view/item/EquipMaterialItem"))

function onInit(self, go)
    super.onInit(self, go)
end

function getTrans(self)
    return self:getChildTrans("mBtnClick")
end

function setData(self, param)
    super.setData(self, param)

    local scrollEquipVo = self.data
    local propsVo = scrollEquipVo:getDataVo()
    if (propsVo) then
        if propsVo._NAME == equip.EquipVo._NAME then
            if self.m_propsGrid and self.m_propsGrid._NAME == PropsGrid._NAME then
                self.m_propsGrid:poolRecover()
                self.m_propsGrid = nil
            end
            if (not self.m_propsGrid) then
                self.m_propsGrid = EquipGrid:poolGet()
            end
            self.m_propsGrid:setData(propsVo, self:getChildTrans("mGroupGrid2"))
            self.m_propsGrid:setShowEquipStrengthenLvl(true)
            self.m_propsGrid:setScale(1)
            self.m_propsGrid:setShowHeroIcon(true)
            self:getChildGO("mTxtCount"):GetComponent(ty.Text).text = HtmlUtil:size("LV.", 14) .. propsVo.strengthenLvl
        else

            if self.m_propsGrid and self.m_propsGrid._NAME == EquipGrid._NAME then
                self.m_propsGrid:poolRecover()
                self.m_propsGrid = nil
            end
            if (not self.m_propsGrid) then
                self.m_propsGrid = PropsGrid:poolGet()
            end
            self.m_propsGrid:setData(propsVo, self:getChildTrans("mGroupGrid"))
            self.m_propsGrid:setIsShowCount(false)
            self:updateSelectCount()
            self:addOnClick(self:getChildGO("mBtnCut"), self.__onClickCutHandler)
        end
        self.m_propsGrid:setClickEnable(false)
        self.m_propsGrid:setScale(1)

        self:getChildGO("mImgSelectIcon"):SetActive(propsVo.type == PropsType.EQUIP)
        self:getChildGO("mImgTxtSelectCount"):SetActive(propsVo.type == PropsType.NORMAL)

        self:setSelectState(scrollEquipVo:getSelect())

        self:addOnClick(self:getChildGO("mBtnClick"), self.onClickGridHandler)
    else
        self:deActive()
    end
end

function onClickGridHandler(self, args)
    local equipVo = self.data:getDataVo()

    local scrollEquipVo = self.data
    local propsVo = scrollEquipVo:getDataVo()
    -- if scrollEquipVo:getSelect() then
    --     return
    -- end

    self.isNew = read.ReadManager:isModuleRead(ReadConst.NEW_EQUIP, propsVo.id)
    if self.isNew and propsVo.type == PropsType.EQUIP then
        self.m_propsGrid:setIsNew(false)
        GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.NEW_EQUIP, id = propsVo.id })
    end
    TipsFactory:closeEquipTips()

    if propsVo.heroId > 0 then
        gs.Message.Show(_TT(71437))
        return
    end
    if propsVo.isLock == 1 then
        TipsFactory:openEquipTips({ equipVo = propsVo })
        gs.Message.Show("无法选择锁定的装备")
        return
    end
    -- if propsVo.type == PropsType.NORMAL then
    --     local count = (scrollEquipVo:getArgs() or 0) + 1
    --     scrollEquipVo:setArgs(count)
    --     scrollEquipVo:setSelect(true)
    -- else
        scrollEquipVo:setArgs(1)
        scrollEquipVo:setSelect(not scrollEquipVo:getSelect())

        if scrollEquipVo:getSelect() then
            TipsFactory:openEquipTips({ equipVo = propsVo })
        end
    --end
    equipBuild.EquipRemakeManager:changePropsInfo(propsVo)
    equipBuild.EquipRemakeManager:dispatchEvent(equipBuild.EquipRemakeManager.EQUIP_REMAKE_MATERIAL_SELECT_MUL, propsVo)
end

function __onClickCutHandler(self)
    local scrollEquipVo = self.data
    local propsVo = scrollEquipVo:getDataVo()
    local count = (scrollEquipVo:getArgs() or 0) - 1
    scrollEquipVo:setArgs(count)
    if scrollEquipVo:getArgs() <= 0 then
        scrollEquipVo:setSelect(false)
    end
    equipBuild.EquipRemakeManager:dispatchEvent(equipBuild.EquipRemakeManager.EQUIP_REMAKE_MATERIAL_SELECT_MUL, scrollEquipVo)
end

function setSelectState(self, cusIsSelect)
    self.isSelect = cusIsSelect
    self:getChildGO("mImgSelect"):SetActive(cusIsSelect)
    self:getChildGO("mBtnCut"):SetActive(cusIsSelect and self.data:getDataVo().type == PropsType.NORMAL)

end

function getSelectState(self)
    return self.isSelect
end

function deActive(self)
    super.deActive(self)
    self:removeOnClick(self.UIObject)
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
	语言包: _TT(71437):	"此装备已被穿戴,无法进行改造"
]]