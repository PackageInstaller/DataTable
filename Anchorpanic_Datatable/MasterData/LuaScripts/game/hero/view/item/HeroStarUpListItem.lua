module("hero.HeroStarUpListItem", Class.impl(hero.HeroMilitaryRankListItem))

function __updateContent(self)
    if(self.m_data.showType == 4)then
        self.m_groupMilitaryRank:SetActive(false)
        self.m_groupAttr:SetActive(true)
        self.m_imgArrowGo:SetActive(false)
        self.m_textAttrName.text = AttConst.getName(self.m_data.dataVo.key)
        self.m_textCurAttrValue.text = ""
        self.m_textNextAttrValue.text = AttConst.getValueStr(self.m_data.dataVo.key, self.m_data.nextDataDic[self.m_data.dataVo.key])
    end
    super.__updateContent(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
