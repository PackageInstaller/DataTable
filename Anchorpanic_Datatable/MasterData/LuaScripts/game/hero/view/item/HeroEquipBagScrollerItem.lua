module('hero.HeroEquipBagScrollerItem', Class.impl(bag.BagEquipScrollerItem))

function onInit(self, go)
    super.onInit(self, go)
end

function getTrans(self)
    return self:getChildTrans("ImgToucher")
end

function setData(self, param)
    self.data = param
    if (self.data) then
        local equipVo = self.data:getDataVo()
        local isSelect = self.data:getSelect()

        if (not self.mEquipGrid) then
            self.mEquipGrid = EquipGrid:poolGet()
        end
        self.mEquipGrid:setData(equipVo, self.mTransAction)
        self.mEquipGrid:setIsShowUseInTip(true)
        self.mEquipGrid:setShowLockState(true)
        self.mEquipGrid:setClickEnable(false)

        self:setNormalSelect(isSelect)
        self:addOnClick(self:getChildGO("ImgToucher"), self.onClickItemHandler)
    else
        self:deActive()
    end
end

function onClickItemHandler(self)
    local equipVo = self.data:getDataVo()
    hero.HeroEquipManager:dispatchEvent(hero.HeroEquipManager.HERO_BAG_EQUIP_SELECT, { equipId = equipVo.id })
end

-- 设置普通选中状态
function setNormalSelect(self, isSelect)
    if (isSelect) then
        self:getChildGO("mImgSelect"):SetActive(true)
    else
        self:getChildGO("mImgSelect"):SetActive(false)
    end
end

function deActive(self)
    super.deActive(self)
    self:removeOnClick(self:getChildGO("ImgToucher"))
end

function onDelete(self)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]