--[[ 
-----------------------------------------------------
@filename       : ManualStoryView
@Description    : 图鉴-故事
@date           : 2023-3-5 17:43:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualStoryView", Class.impl(TabView))
UIRes = UrlManager:getUIPrefabPath("manual/ManualStoryView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setBg("manual_bg.jpg", false, "manual")
    self:setTxtTitle("故事")--故事
end
--析构  
function dtor(self)
    super.dtor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.showTabType = 2
end

-- 初始化
function configUI(self)
    super.configUI(self)
end

-- 页签父节点
function getTabBarParent(self)
    return self:getChildTrans("mTabBarTrans")
end

-- 父节点
function getTabViewParent(self)
    return self:getChildTrans("mTabViewTrans")
end

function getTabDatas(self)
    self.tabDataList = {}
    for _, tabVo in pairs(manual.ManualStoryConst:getTabStoryList()) do
        if funcopen.FuncOpenManager:isOpen(tabVo.funcId, false) then
            self.tabDataList[tabVo.page] = { type = tabVo.page, content = { tabVo.nomalLan } }
        end
    end
    return self.tabDataList
end

function getTabClass(self)
    self.tabClassDic[manual.ManualStoryType.mainStory] = manual.ManualStoryListView
    self.tabClassDic[manual.ManualStoryType.ActivityStory] = manual.ManualStoryListView
    return self.tabClassDic
end

--激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})
    self:updateNew()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
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

function updateNew(self)
    for _, vo in ipairs(manual.ManualStoryConst:getTabStoryList()) do
        if manual.ManualStoryManager:getNewStateByType(vo.page) then
            self:addBubble(vo.page)
        else
            self:removeBubble(vo.page)
        end
    end
end

function isHorizon(self)
    return false
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]