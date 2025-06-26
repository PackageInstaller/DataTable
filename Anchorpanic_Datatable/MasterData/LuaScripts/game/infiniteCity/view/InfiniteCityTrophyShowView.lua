--[[ 
-----------------------------------------------------
@filename       : InfiniteCityTrophyShowView
@Description    : 无限城拥有的战利品展示
@date           : 2021-03-05 18:46:37
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.infiniteCity.view.InfiniteCityTrophyShowView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("infiniteCity/InfiniteCityTrophyShowView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mScroller = self:getChildGO("mScroller"):GetComponent(ty.LyScroller)
    self.mScroller:SetItemRender(infiniteCity.InfiniteCityTrophyShowItem)

end

--激活
function active(self)
    super.active(self)

    self.trophyList = infiniteCity.InfiniteCityManager:getOwnTrophyList()
    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.aa,self.onClick)
end

function updateView(self)
    if self.mScroller.Count <= 0 then
        self.mScroller.DataProvider = self.trophyList
    else
        self.mScroller:ReplaceAllDataProvider(self.trophyList)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
