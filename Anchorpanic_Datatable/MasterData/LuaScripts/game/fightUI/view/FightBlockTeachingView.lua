-- 格挡训练显示
module('fightUI.FightBlockTeachingView', Class.impl('lib.component.BaseNode'))

function initData(self, rootGo)
    super.initData(self, rootGo)
end

function show(self)
    if fight.FightManager:getBattleType() == PreFightBattleType.BranchPower then
        self:setVisibleByScale(true)
        self:updateBlockTeachingList()
    else
        self:setVisibleByScale(false)
    end
end

-- 设置格挡列表
function updateBlockTeachingList(self)
    self:recoverBlockTeachingItem()
    local dupId = fight.FightManager:getBattleFieldID()
    local vo = branchStory.BranchPowerManager:getPowerVo(tonumber(dupId))
    if not vo then
        logError("当前立场训练副本配置不存在id:" .. fight.FightManager:getBattleFieldID())
        return
    end
    for i = 1, vo.blockNum do
        local item = SimpleInsItem:create(self:getChildGO("GroupBlockCountItem"), self.m_trans, "FightBlockTeachingViewBlockCountItem")
        item:getChildGO("mImgBlockEff"):SetActive(false)
        item:getChildGO("mImgBlockSelect"):SetActive(false)
        table.insert(self.itemList, item)
    end
    self:updateCount()
end

-- 更新次数
function updateCount(self)
    if not self.itemList then
        return
    end
    local count = fight.FightManager:getQteSucCount()
    for i = 1, #self.itemList do
        local item = self.itemList[i]
        item:getChildGO("mImgBlockEff"):SetActive(false)
        item:getChildGO("mImgBlockSelect"):SetActive(false)
        if (i - 1) < count then
            item:getChildGO("mImgBlockSelect"):SetActive(true)
        end
        if (i - 1) == count then
            item:getChildGO("mImgBlockEff"):SetActive(true)
        end
    end
end

-- 回收项
function recoverBlockTeachingItem(self)
    if self.itemList then
        for i, v in pairs(self.itemList) do
            v:poolRecover()
        end
    end
    self.itemList = {}
end

function destroy(self, isAuto)
    self:recoverBlockTeachingItem()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(3048):	"能量不足"
]]
