module("systemSetting.systemSettingPanel", Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath("systemSetting/systemSettingPanel.prefab")
panelType = 1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isShow3DBg = 1
--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    -- self:setBg("common_bg_015.jpg", false)
    self:setUICode(LinkCode.Setting)
end
-- 初始化数据
function initData(self)
    super.initData(self)
    self.mTabDataList = {
        { type = systemSetting.SettingTabKey.QualitySetting, content = { _TT(62059) }, nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_16.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_16.png")},
        { type = systemSetting.SettingTabKey.SoundSetting, content = { _TT(62060) }, nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_18.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_18.png")},
        -- { type = systemSetting.SettingTabKey.OtherSetting, content = { _TT(62003) }, nomalIcon = UrlManager:getIconPath("tabIcon/tabIcon_17.png"), selectIcon = UrlManager:getIconPath("tabIcon/tabIcon_17.png")},
    }
    self.showTabType = 2
end
--获取UI组件
function configUI(self)
    super.configUI(self)
end 
--active设置BG高度
function active (self)
    super.active(self)
end

function initViewText(self)
    self:setTxtTitle(_TT(25117))
end

function getTabDatas(self)
    return self.mTabDataList
end

-- 父节点
function getTabViewParent(self)
    return self:getChildTrans("mTabViewTrans")
end

-- 设置货币栏
function setMoneyBar(self)
end

function getTabClass(self)
    self.tabClassDic[systemSetting.SettingTabKey.QualitySetting] = systemSetting.QualitySettingTabView
    self.tabClassDic[systemSetting.SettingTabKey.SoundSetting] = systemSetting.SoundSettingTabView
    self.tabClassDic[systemSetting.SettingTabKey.OtherSetting] = systemSetting.OtherSettingTabView
    return self.tabClassDic
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
