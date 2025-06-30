--[[ 
-----------------------------------------------------
@filename       : CovenantTaskTabView
@Description    : 盟约任务页面
@date           : 2022-04-24 15:11:08
@Author         : Shuai
@copyright      : (LY) 2022 雷焰网络
-----------------------------------------------------
]]
module('covenant.CovenantTaskTabView', Class.impl(TabView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("covenant/CovenantTaskTabView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setBg("common_bg_003.jpg", false)
    self:setUICode(LinkCode.CovenantTask)
end
--析构  
function dtor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.showTabType = 2
end

-- 初始化
function configUI(self)
end

-- 页签父节点
function getTabBarParent(self)
    return self:getChildTrans("TabBarNode")
end

function getTabDatas(self)
    self.tabDataList[covenant.TaskConst.DailyTask] = TabData:poolGet():setData(229, 71, { covenant.TaskName(covenant.TaskConst.DailyTask), _TT(653) }, "common_2201.png", "common_3219.png", 24, nil, covenant.TaskConst.DailyTask, ColorUtil.PURE_BLACK_NUM, ColorUtil.PURE_WHITE_NUM, { 25, 0, 0, 15, 25, 0, 0, 40 }, { 25, 0, 0, 15, 25, 0, 0, 40 })
    return self.tabDataList
end

function getTabClass(self)
    self.tabClassDic[covenant.TaskConst.DailyTask] = covenant.CovenantTaskInfoView
    return self.tabClassDic
end

--激活
function active(self)
    super.active(self)
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

function isHorizon(self)
    return false
end

function close(self)
    super.close(self)
end

function destroyPanel(self)
    super.destroyPanel(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
