module("role.RoleHeroShowEquipGrid", Class.impl(EquipGrid))


function __initData(self)
    super.__initData(self)
end

function __updateName(self)
end

function __updateCustomTypeView(self)
    super.__updateCustomTypeView(self)
    
    self.m_childGos["ImgBg"]:SetActive(false)
    self.m_childGos["ImgBg"]:SetActive(false)
end

-- 设置锁定状态
function setShowEquipStrengthenLvl(self, isShow)
    self.m_isShowEquipStrengthenLvl = isShow
    self:__updateEquipStrengthenLvl()
end

-- 更新装备强化等级
function __updateEquipStrengthenLvl(self)
    super.__updateEquipStrengthenLvl(self)
    if (self.m_isLoadFinish) then
        gs.TransQuick:SizeDelta(self.m_childGos["ImgLvlBg"]:GetComponent(ty.RectTransform), 126, 28)
    end
end

function getSize(self)
    return 174, 210
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
