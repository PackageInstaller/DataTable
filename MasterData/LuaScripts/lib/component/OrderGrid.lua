module("OrderGrid", Class.impl(PropsGrid))
-- 序列物格子
-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("commonGrid/OrderGrid.prefab")

function __initData(self)
    super.__initData(self)
    -- 一些常用的脚本
    self.m_imgColorBg = nil
    self.m_propsIcon = nil
    self.m_imgSubType = nil

    --------------------------------------------- 数据源 self.m_data 为 props.PropsConfigVo 或 props.PropsVo 或 {tid,num} ---------------------------------------------
end

function __updateCustomView(self)
    self:__updateCustomTypeView()
end

function __updateCustomTypeView(self)
    self:__updateSubType()
    self:__updateColorBg()
    self:__updatePropsIcon()
end

function __updateSubType(self)
    if (self.m_isLoadFinish) then
        if (self.m_imgSubType == nil) then
            self.m_imgSubType = self.m_childTrans["ImgSubType"]:GetComponent(ty.AutoRefImage)
        end
        self.m_imgSubType:SetImg(bag.getOrderSubTypeIcon(self:getData().subType), false)
    end
end

function __updatePropsIcon(self)
    if (self.m_isLoadFinish) then
        if (self.m_propsIcon == nil) then
            self.m_propsIcon = self.m_childTrans["ImgIcon"]:GetComponent(ty.AutoRefImage)
        end
        self.m_propsIcon:SetImg(UrlManager:getPropsIconUrl(self:getData().tid), true)
        if self.m_isGary ~= nil then
            self.m_propsIcon:SetGray(self.m_isGary)
        end
    end
end

function __updateColorBg(self)
    if (self.m_isLoadFinish) then
        if (self.m_imgColorBg == nil) then
            self.m_imgColorBg = self.m_childTrans["ImgColorBg"]:GetComponent(ty.AutoRefImage)
        end

        self.m_imgColorBg:SetImg(UrlManager:getPropsBgUrl(self:getData().color), false)
    end
end

return _M