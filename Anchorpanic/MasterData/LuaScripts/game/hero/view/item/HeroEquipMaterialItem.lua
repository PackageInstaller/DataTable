module("hero.HeroEquipMaterialItem", Class.impl("game/equipBuild/view/item/EquipMaterialItem"))

function onClickGridHandler(self, args)
    local equipVo = self.data:getDataVo()
    if self:getSelectState() then 
        -- equipBuild.EquipBuildManager:setNowSelectEquip(nil) -- 重复选择不用关闭
    else

        if read.ReadManager:isModuleRead(ReadConst.NEW_EQUIP,self.data:getDataVo().id) then
            GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, {  type = ReadConst.NEW_EQUIP,id = self.data:getDataVo().id })
            self:__updateIsNew(false)
        end
        GameDispatcher:dispatchEvent(EventName.CLOSE_BRACELETS_CONTRAST_TIPS)
        equipBuild.EquipBuildManager:setNowSelectEquip(equipVo)
    end
    hero.HeroEquipManager:dispatchEvent(hero.HeroEquipManager.HERO_EQUIP_MATERIAL_VIEW_SELECT_EQUIP, {equipVo = equipVo, scrollVo = self.data})
end

function __updateIsNew(self,isNew)
    self.m_propsGrid:updateIsNew()
end

function setData(self,param)
    super.setData(self, param.scrollVo)
    self.m_imgHero = self:getChildGO("ImgHero"):GetComponent(ty.AutoRefImage)
    self.m_curHeroId = param.heroId
    local equipVo = param.scrollVo:getDataVo()

    self:getChildGO("GridHeroIcon"):SetActive(false)
    self.m_imgNow = self:getChildGO("mImgNow")
    self.m_imgNow:SetActive(equipVo.heroId == self.m_curHeroId)

    self:__updateGuide()
    if not read.ReadManager:isModuleRead(ReadConst.NEW_EQUIP,self.data:getDataVo().id) then
        -- GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, {  type = ReadConst.NEW_EQUIP,id = self.data:getDataVo().id })
        self:__updateIsNew(false)
    end
    if self.data:getDataVo().tid == 5401 then
        self:setGuideTrans("funcTips_guide_HeroEquipMaterial_equip_" .. 5401, self:getChildTrans("mBtnClick"))
    elseif self.data:getDataVo().tid == 5402 then
        self:setGuideTrans("funcTips_guide_HeroEquipMaterial_equip_" .. 5402, self:getChildTrans("mBtnClick"))
    end
end

function onClickCutHandler(self)
    return
end

function __updateGuide(self)
    local equipVo = self.data:getDataVo()
    if(equipVo.tid == 5011)then
        local curHeroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
        if curHeroVo.tid == 1110 then
            self:setGuideTrans("Equip_Load_3", self:getTrans())
        end
    elseif (equipVo.tid == 5012)then
        local curHeroVo = hero.HeroManager:getHeroVo(self.m_curHeroId)
        if curHeroVo.tid == 1110 then
            self:setGuideTrans("Equip_Load_6", self:getTrans())
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
