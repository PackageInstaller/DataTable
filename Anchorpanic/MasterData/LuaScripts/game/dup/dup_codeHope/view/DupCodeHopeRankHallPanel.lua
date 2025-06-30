--[[ 
-----------------------------------------------------
@filename       : DupCodeHopeRankHallPanel
@Description    : 代号希望排行奖励主页
@date           : 2021-07-14 20:05:08
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('dup.DupCodeHopeRankHallPanel', Class.impl(TabView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupCodeHope/DupCodeHopeRankHallPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setBg("common_bg_5.jpg", false)
end
--析构  
function dtor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

-- 初始化
function configUI(self)
    -- self.aa = self:getChildGO(""):GetComponent(ty.Image)
    -- self.aa = self:getChildTrans("")
end

-- 页签父节点
function getTabBarParent(self)
    return self:getChildTrans("TabBarNode")
end

function getTabDatas(self)
    self.tabDataList[1] = TabData:poolGet():setData(178, 70, { arena.getRanHallTabName(arena.RankHallTabType.RANK_LIST), _TT(164) }, "common_2201.png", "common_3219.png", 24, nil, arena.RankHallTabType.RANK_LIST, ColorUtil.PURE_BLACK_NUM, ColorUtil.PURE_WHITE_NUM, { 25, 0, 0, 15, 25, 0, 0, 40 }, { 25, 0, 0, 15, 25, 0, 0, 40 })
    self.tabDataList[2] = TabData:poolGet():setData(178, 70, { arena.getRanHallTabName(arena.RankHallTabType.RANK_AWARD), _TT(166) }, "common_2201.png", "common_3219.png", 24, nil, arena.RankHallTabType.RANK_AWARD, ColorUtil.PURE_BLACK_NUM, ColorUtil.PURE_WHITE_NUM, { 25, 0, 0, 15, 25, 0, 0, 40 }, { 25, 0, 0, 15, 25, 0, 0, 40 })
    return self.tabDataList
end

function getTabClass(self)
    self.tabClassDic[arena.RankHallTabType.RANK_LIST] = dup.DupCodeHopeRankPanel
    self.tabClassDic[arena.RankHallTabType.RANK_AWARD] = dup.DupCodeHopeAwardPanel
    return self.tabClassDic
end

--激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ITIANIUM_TID, MoneyTid.ARENA_COIN_TID })
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
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.aa,self.onClick)
end

function isHorizon(self)
    return false
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
