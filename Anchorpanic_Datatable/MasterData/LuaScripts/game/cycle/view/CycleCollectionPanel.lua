--[[ 
-----------------------------------------------------
@filename       : CycleCollectionPanel
@Description    : 事影循回收藏品界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("cycle.CycleCollectionPanel", Class.impl(TabView))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CycleCollectionPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isShow3DBg = 1
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    -- self:setTxtTitle(_TT(52094))
    self:setTxtTitle(_TT(4550))
    self:setBg("")
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

-- 激活
function active(self, args)
    super.active(self, args)
end

function getTabClass(self)
    self.tabClassDic[COLLECTION_TYPE.ALL] = cycle.CycleCollectionTabView
    self.tabClassDic[COLLECTION_TYPE.POSSESS] = cycle.CycleCollectionTabAttack
    self.tabClassDic[COLLECTION_TYPE.LACK] = cycle.CycleCollectionTabDefense
    -- self.tabClassDic[COLLECTION_TYPE.SPECIAL] = cycle.CycleCollectionTabSpecial
    return self.tabClassDic
end

function getTabDatas(self)
    self.tabDataList = {}
    for k, v in pairs(cycle.getCollectionTypeList()) do
        table.insert(self.tabDataList, { type = v.page, content = { v.nomalLan }, nomalIcon = v.nomalIcon, selectIcon = v.selectIcon })
    end
    return self.tabDataList
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

return _M

 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27539):	"陈列室"
	语言包: _TT(18):	"橙"
	语言包: _TT(17):	"紫"
	语言包: _TT(16):	"蓝"
	语言包: _TT(15):	"绿"
]]
