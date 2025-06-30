-- @FileName:   HeroResonanceSkillItem.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-08-23 17:20:27
-- @Copyright:   (LY) 2023 雷焰网络

module("hero.HeroResonanceSkillItem", Class.impl(SimpleInsItem))

-- 设置data
function setData(self, data)
    self.m_data = data

    GameDispatcher:addEventListener(EventName.HERO_RESONANCE_SELECT, self.onResonanceSelect, self)

    self.mSelect = self:getChildGO("mSelect")
    self:unSelect()

    self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(data.configVo:getIcon(), false)
    self:getChildGO("mImgColor"):GetComponent(ty.Image).color = gs.ColorUtil.GetColor(data.configVo:getQualityColor())
    local mask = self:getChildGO("mImgMask")
    if mask then
        mask:SetActive(not data.isActive)
    end

    local rayEmpty = self.m_go:GetComponent(ty.RaycastEmptyEvent)
    if rayEmpty and not gs.GoUtil.IsCompNull(rayEmpty) then
        self:addUIEvent(nil, self.onClick)
    end

    local redGo = self:getChildGO("redParent")
    if redGo and not gs.GoUtil.IsGoNull(redGo) then
        redGo:SetActive(data.isCanActive and not data.isActive)
    end
end

function onClick(self)
    GameDispatcher:dispatchEvent(EventName.HERO_RESONANCE_SELECT, self.m_data.configVo.pos)
end

function onResonanceSelect(self, resonanace_pos)
    if resonanace_pos == self.m_data.configVo.pos then
        self:select()
    else
        self:unSelect()
    end
end

function select(self)
    if self.mSelect then
        self:getChildGO("mSelect"):SetActive(true)
    end
end

function unSelect(self)
    if self.mSelect then
        self:getChildGO("mSelect"):SetActive(false)
    end
end

-- 回收
function destroy(self)
    local redGo self:getChildGO("redParent")
    if redGo and not gs.GoUtil.IsTransNull(redGo) then
        redGo:SetActive(false)
    end

    super.destroy(self)
    GameDispatcher:removeEventListener(EventName.HERO_RESONANCE_SELECT, self.onResonanceSelect, self)
end

return _M
