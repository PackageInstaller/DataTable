

module("seabed.SeabedCollectionPanel", Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath("seabed/SeabedCollectionPanel.prefab")

panelType = 1 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0
isShow3DBg = 1

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(111031))
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

    GameDispatcher:addEventListener(EventName.UPDATE_SEABED_COLLECTION_PANEL,self.updateBubble,self)
    MoneyManager:setMoneyTidList({ })
    self:updateBubble()
end

function getTabClass(self)
    self.tabClassDic[seabed.SeabedBattleType.Collage] = seabed.SeabedCollectionTabView
    self.tabClassDic[seabed.SeabedBattleType.Buff] = seabed.SeabedBuffTabView
    return self.tabClassDic
end

function getTabDatas(self)
    self.tabDataList = {}
    for k, v in pairs(seabed.getSeabedCollectionList()) do
        table.insert(self.tabDataList, {type = v.page, content = {v.nomalLan}, nomalIcon = v.nomalIcon, selectIcon = v.selectIcon})
    end
    return self.tabDataList
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SEABED_COLLECTION_PANEL,self.updateBubble,self)
end

function updateBubble(self)
    if seabed.SeabedManager:canGetGain(seabed.SeabedBattleType.Collage) then
        self:addBubble(seabed.SeabedBattleType.Collage)
    else
        self:removeBubble(seabed.SeabedBattleType.Collage)
    end

    if seabed.SeabedManager:canGetGain(seabed.SeabedBattleType.Buff) then
        self:addBubble(seabed.SeabedBattleType.Buff)
    else
        self:removeBubble(seabed.SeabedBattleType.Buff)
    end
end

return _M