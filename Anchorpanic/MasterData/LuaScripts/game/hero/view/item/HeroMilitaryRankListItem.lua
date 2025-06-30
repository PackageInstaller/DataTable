module("hero.HeroMilitaryRankListItem", Class.impl(BaseComponent))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("hero/item/HeroMilitaryRankListItem.prefab")

function __initData(self)
    super.__initData(self)

    --一些常用的
    self.m_groupMilitaryRank = nil
    self.m_groupAttr = nil
    self.m_textCurMilitaryRank = nil
    self.m_textNextMilitaryRank = nil
    self.m_iconCurMilitaryRank = nil
    self.m_iconNextMilitaryRank = nil
    self.m_textAttrName = nil
    self.m_textCurAttrValue = nil
    self.m_textNextAttrValue = nil

    --------------------------------------------- 数据源 self.m_data 为 多种类型数据 ---------------------------------------------
end

-- 设置data
function setData(self, curDataVo, nextDataDic, showType, cusIsShowBg, cusIsAsyn)
    self:__reset()
    if(curDataVo and nextDataDic and showType)then
        self.m_data = {}
        self.m_data.dataVo = curDataVo
        self.m_data.nextDataDic = nextDataDic
        self.m_data.showType = showType
        self.m_data.isShowBg = cusIsShowBg

        if (cusIsAsyn == nil) then
            cusIsAsyn = true
        end
        if (cusIsAsyn) then
            if (self.m_isLoadFinish) then
                self:__updateView()
            else
                self:__preLoad(cusIsAsyn)
            end
        else
            self:__preLoad(cusIsAsyn)
            self:__updateView()
        end
    end
end

function __updateCustomView(self)
    self:__initScript()
    self:__updateContent()
end

function __initScript(self)
    self.m_goBg = self.m_childGos["ImgBg"]
    self.m_textMilitaryTip = self.m_childGos["TextMilitaryTip"]:GetComponent(ty.LanText)
    self.m_groupMilitaryRank = self.m_childGos["GroupMilitaryRank"]
    self.m_groupAttr = self.m_childGos["GroupAttr"]
    self.m_textCurMilitaryRank = self.m_childGos["TextCurMilitaryRank"]:GetComponent(ty.Text)
    self.m_textNextMilitaryRank = self.m_childGos["TextNextMilitaryRank"]:GetComponent(ty.Text)
    self.m_iconCurMilitaryRank = self.m_childGos["IconCurMilitaryRank"]:GetComponent(ty.AutoRefImage)
    self.m_iconNextMilitaryRank = self.m_childGos["IconNextMilitaryRank"]:GetComponent(ty.AutoRefImage)

    self.m_imgArrowGo = self.m_childGos["ImgArrow"]
    self.m_textAttrName = self.m_childGos["TextAttrName"]:GetComponent(ty.Text)
    self.m_textCurAttrValue = self.m_childGos["TextCurAttrValue"]:GetComponent(ty.Text)
    self.m_textNextAttrValue = self.m_childGos["TextNextAttrValue"]:GetComponent(ty.Text)
end

function __updateContent(self)
    self.m_goBg:SetActive(self.m_data.isShowBg)
    self.m_textMilitaryTip.text = _TT(1064)--"军阶晋升"
    if(self.m_data.showType == 1)then
        self.m_groupMilitaryRank:SetActive(true)
        self.m_groupAttr:SetActive(false)
        self.m_imgArrowGo:SetActive(true)

        self.m_textCurMilitaryRank.text = self.m_data.dataVo.name
        self.m_iconCurMilitaryRank:SetImg(UrlManager:getHeroMilitaryRankIconUrl(self.m_data.dataVo.lvl), false)
        if(self.m_data.nextDataDic)then
            self.m_childGos["TextNextMilitaryRank"]:SetActive(true)
            self.m_childGos["IconNextMilitaryRank"]:SetActive(true)
            self.m_textNextMilitaryRank.text = self.m_data.nextDataDic.name
            self.m_iconNextMilitaryRank:SetImg(UrlManager:getHeroMilitaryRankIconUrl(self.m_data.nextDataDic.lvl), false)
        else
            self.m_childGos["TextNextMilitaryRank"]:SetActive(false)
            self.m_childGos["IconNextMilitaryRank"]:SetActive(false)
        end
    elseif(self.m_data.showType == 2)then
        self.m_groupMilitaryRank:SetActive(false)
        self.m_groupAttr:SetActive(true)
        self.m_imgArrowGo:SetActive(true)

        self.m_textAttrName.text = _TT(1065)--"最大等级上限"
        self.m_textCurAttrValue.text = self.m_data.dataVo
        if(self.m_data.nextDataDic)then
            self.m_textNextAttrValue.text = self.m_data.nextDataDic
        else
            self.m_textNextAttrValue.text = _TT(1066)--"已最大"
        end

    elseif(self.m_data.showType == 3)then
        self.m_groupMilitaryRank:SetActive(false)
        self.m_groupAttr:SetActive(true)
        self.m_imgArrowGo:SetActive(true)

        self.m_textAttrName.text = AttConst.getName(self.m_data.dataVo.key)
        self.m_textCurAttrValue.text = AttConst.getValueStr(self.m_data.dataVo.key, self.m_data.dataVo.value)
        if(self.m_data.nextDataDic and self.m_data.nextDataDic[self.m_data.dataVo.key])then
            self.m_textNextAttrValue.text = AttConst.getValueStr(self.m_data.dataVo.key, self.m_data.nextDataDic[self.m_data.dataVo.key])
        else
            self.m_textNextAttrValue.text = _TT(1066)--"已最大"
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
