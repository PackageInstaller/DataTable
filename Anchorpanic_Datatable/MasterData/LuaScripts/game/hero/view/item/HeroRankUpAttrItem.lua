module("hero.HeroRankUpAttrItem", Class.impl(BaseComponent))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("hero/item/HeroRankUpAttrItem.prefab")

function __initData(self)
    super.__initData(self)

    --一些常用的
    self.mTxtAttrName = nil
    self.mTxtAttrValue = nil
    self.mGoBg = nil
    --------------------------------------------- 数据源 self.m_data 为 属性vo 和 属性权重 ---------------------------------------------
end

-- 设置data
function setData(self, index, cusAttrVo, detal1, cusIsAsyn)
    self:__reset()
    if cusAttrVo then
        self.m_data = {}
        self.m_data.index = index
        self.m_data.attrVo = cusAttrVo
        self.m_data.detal1 = detal1
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

function getData(self)
    return self.m_data.attrVo
end

function __updateCustomView(self)
    self:initView()
    self:updateContent()
end

function initView(self)
    self.mTxtAttrName = self:getChildGO("mTxtAttrName"):GetComponent(ty.Text)
    self.mTxtAttrValue = self:getChildGO("mTxtAttrValue"):GetComponent(ty.Text)
    self.mGoBg = self:getChildGO("mImgBg")
    
    self.mTextAddGo = self:getChildGO("mTxtAddValue")
    self.mTxtAddCanvasGroup = self.mTextAddGo:GetComponent(ty.CanvasGroup)
    self.mTxtAddValue = self.mTextAddGo:GetComponent(ty.Text)
end

function updateContent(self)
    self.mTxtAttrName.text = AttConst.getName(self.m_data.attrVo.key)
    self.mTxtAttrValue.text = AttConst.getValueStr(self.m_data.attrVo.key, self.m_data.attrVo.value)
    self.m_data.detal1 = self.m_data.detal1 and self.m_data.detal1 or 0
    self.mTxtAddValue.text = self.m_data.detal1
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
