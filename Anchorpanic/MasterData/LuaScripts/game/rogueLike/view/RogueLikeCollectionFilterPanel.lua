--[[ 
-----------------------------------------------------
@filename       : RogueLikeCollectionFilterPanel
@Description    : 肉鸽收藏品筛选界面
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module("rogueLike.RogueLikeCollectionFilterPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeCollectionFilterPanel.prefab")

panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

-- 构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    -- 排序是否降序
    self.mSortDescending = false
    -- 是否显示全部
    self.mIsShowAll = false
    -- 是否过滤相同
    self.mIsFilterSame = false
    -- 是否过滤使用状态
    self.mIsFilterUseState = false

    -- 菜单列表
    self.mMenuList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)
    -- -- 菜单
    -- self.mGroupMenu = self.m_uiTrans["GroupMenu"]
    -- self.mMenuSort = self.m_uiGos["MenuSort"]
    -- self.mMenuCommon = self.m_uiGos["MenuCommon"]
    -- self.mMenuCommonRound = self.m_uiGos["MenuCommonRound"]
    -- -- 子菜单
    -- self.mSubMenuCommon = self.m_uiGos["SubMenuCommon"]
    -- self.mSubMenuFilter = self.m_uiGos["SubMenuFilter"]

    -- self.mGoToucher = self.m_uiGos["ImgToucher"]
end

-- 激活
function active(self)
    super.active(self)
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
