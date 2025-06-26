-- @FileName:   BraceletEmpowerTipsPanel.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-09-21 11:55:20
-- @Copyright:   (LY) 2023 雷焰网络

module('braceletBuild.BraceletEmpowerTipsPanel', Class.impl(View))
UIRes = UrlManager:getUIPrefabPath('braceletBuild/BraceletEmpowerTipsPanel.prefab')

destroyTime = 0 -- 自动销毁时间-1默认
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗 3 不应用遮罩的常驻页面(事影循回)
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

-- 构造函数
function ctor(self)
    super.ctor(self)

end

-- 初始化数据
function initData(self)

end

function initViewText(self)
    self.mTxtTitle.text = _TT(93107)
    self.mTextTips.text = _TT(93108)

end

-- 初始化
function configUI(self)
    self.mTextTips = self:getChildGO("mTextTips"):GetComponent(ty.Text)
    self.DescContent = self:getChildTrans("DescContent")
    self.DescItem = self:getChildGO("DescItem")

    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

end

-- 激活
function active(self, args)
    super.active(self, args)

    self:clearPropsItem()
    self:createPropsItem()
end

function createPropsItem(self)
    local tipConfig = braceletBuild.BraceletBuildManager:getBraceletsRemakeShowConfig()

    self.m_ItemList = {}
    for attrType, data in pairs(tipConfig) do
        local attrItem = SimpleInsItem:create(self.DescItem, self.DescContent, "BraceletEmpowerTipsPanel_attrItem")
        table.insert(self.m_ItemList, attrItem)

        local minValue = data.min_value
        local maxValue = data.max_value

        local valueStr = ""
        if(AttConst.isAttrPercent(attrType))then
            minValue = AttConst.getPreciseDecimal(minValue / 100, 2)
            maxValue = AttConst.getPreciseDecimal(maxValue / 100, 2)

            valueStr = string.format("%s%% - %s%%", minValue, maxValue)
        else
            valueStr = string.format("%s - %s", minValue, maxValue)
        end

        attrItem:getChildGO("mTextValue"):GetComponent(ty.Text).text = valueStr
        attrItem:getChildGO("mTextDesc"):GetComponent(ty.Text).text = AttConst.getName(attrType)
    end
end

function clearPropsItem(self)
    if self.m_ItemList then
        for k, v in pairs(self.m_ItemList) do
            v:poolRecover()
        end
        self.m_ItemList = nil
    end
end

-- 非激活
function deActive(self)
    super.deActive(self)
    self:clearPropsItem()

end

return _M
