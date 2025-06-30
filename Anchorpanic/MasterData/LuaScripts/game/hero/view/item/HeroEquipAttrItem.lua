-- 英雄装备界面的属性预览item
module("hero.HeroEquipAttrItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.m_groupTotalAttr = self.m_childGos["GroupTotalAttr"]
    self.m_groupAttr = self.m_childGos["GroupAttr"]
    
    self.m_imgTotalAttr = self.m_childGos["ImgTotalAttr"]:GetComponent(ty.AutoRefImage)
    self.m_textTotalAttrNameEng = self.m_childGos["TextTotalAttrNameEng"]:GetComponent(ty.Text)
    self.m_textTotalAttrName = self.m_childGos["TextTotalAttrName"]:GetComponent(ty.Text)
    self.m_textTotalAttrValue = self.m_childGos["TextTotalAttrValue"]:GetComponent(ty.Text)
    self.m_textAttrName = self.m_childGos["TextAttrName"]:GetComponent(ty.Text)
    self.m_textAttrValue = self.m_childGos["TextAttrValue"]:GetComponent(ty.Text)
end

function setData(self, param)
    super.setData(self, param)
    local attrVo = self.data
    
    if (attrVo) then
        self.m_groupTotalAttr:SetActive(true)
        self.m_groupAttr:SetActive(true)

        local showAttrData = {}
        showAttrData[AttConst.ATTACK] = {englishName = "ATTACK", iconImg = UrlManager:getAttrIconUrl(AttConst.ATTACK)}
        showAttrData[AttConst.HP_MAX] = {englishName = "LIFE", iconImg = UrlManager:getAttrIconUrl(AttConst.HP_MAX)}
        showAttrData[AttConst.DEFENSE] = {englishName = "DEFENCE", iconImg = UrlManager:getAttrIconUrl(AttConst.DEFENSE)}
        if(showAttrData[attrVo.key])then
            self.m_groupTotalAttr:SetActive(true)
            self.m_groupAttr:SetActive(false)

            self.m_imgTotalAttr:SetImg(showAttrData[attrVo.key].iconImg, true)
            self.m_textTotalAttrNameEng.text = showAttrData[attrVo.key].englishName
            self.m_textTotalAttrName.text = AttConst.getName(attrVo.key)
            self.m_textTotalAttrValue.text = AttConst.getValueStr(attrVo.key, attrVo.value)
        else
            self.m_groupTotalAttr:SetActive(false)
            self.m_groupAttr:SetActive(true)

            self.m_textAttrName.text = AttConst.getName(attrVo.key)
            self.m_textAttrValue.text = AttConst.getValueStr(attrVo.key, attrVo.value)
        end
    else
        self.m_groupTotalAttr:SetActive(false)
        self.m_groupAttr:SetActive(false)
        self:deActive()
    end
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
