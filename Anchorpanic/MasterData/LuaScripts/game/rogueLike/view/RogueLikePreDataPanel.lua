--[[ 
-----------------------------------------------------
@filename       : RogueLikePreDataPanel
@Description    : 肉鸽结算界面
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module("rogueLike.RogueLikePreDataPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikePreDataPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mHeroHeads = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mContent = self:getChildTrans("mContent")

    self.mTxtEnd = self:getChildGO("mTxtEnd"):GetComponent(ty.Text)
    self.mTxtPassTitle = self:getChildGO("mTxtPassTitle"):GetComponent(ty.Text)
    self.mTxtBuff = self:getChildGO("mTxtBuff"):GetComponent(ty.Text)
    self.mTxtDebuff = self:getChildGO("mTxtDebuff"):GetComponent(ty.Text)
    self.mTxtCoin = self:getChildGO("mTxtCoin"):GetComponent(ty.Text)
    self.mTxtPower = self:getChildGO("mTxtPower"):GetComponent(ty.Text)
    self.mTxtHPUp = self:getChildGO("mTxtHPUp"):GetComponent(ty.Text)

    self.mTxtMVP = self:getChildGO("mTxtMVP"):GetComponent(ty.Text)
    self.mTxtDef = self:getChildGO("mTxtDef"):GetComponent(ty.Text)
    self.mTxtAttack = self:getChildGO("mTxtAttack"):GetComponent(ty.Text)

    self.mNextBtn = self:getChildGO("mNextBtn")
    self.mInfoBtn = self:getChildGO("mInfoBtn")

    self.mBuffBtn = self:getChildGO("mBuffBtn")
    self.mDebuffBtn = self:getChildGO("mDebuffBtn")

    self.mMVPContent = self:getChildTrans("mMVPContent")
    self.mDefContent = self:getChildTrans("mDefContent")
    self.mAttackContent = self:getChildTrans("mAttackContent")
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtMVP.text = _TT(56051)
    self.mTxtDef.text = _TT(56052)
    self.mTxtAttack.text = _TT(56053)
end

-- 激活
function active(self, args)
    super.active(self)
    self.data = rogueLike.RogueLikeManager:getRogueLikePreData()
    self.mStats = self.data.stats
    self.mStatistic = self.data.battleStatistic
    self:showView()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)

    self:clearHeroItems()
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mNextBtn, self.onClickClose)
    self:addUIEvent(self.mInfoBtn, self.onInfoClick)
    self:addUIEvent(self.mBuffBtn, self.onBuffClick)
    self:addUIEvent(self.mDebuffBtn, self.onDebuffClick)
end

function showView(self)

    local data = rogueLike.RogueLikeManager:getSingleDifficulty(self.data.difficulty)
   
    self.mTxtPassTitle.text = string.substitute(_TT(56067), self.data.id, _TT(data.name))
    self.mTxtBuff.text = _TT(56061).. #self:getStatsDataValue(rogueLike.LayerDataConst.LAYER_BUFF)
    self.mTxtDebuff.text = _TT(56062) .. #self:getStatsDataValue(rogueLike.LayerDataConst.LAYER_DEBUGG)
    self.mTxtDebuff.gameObject:SetActive(false)

    self.mTxtCoin.text = _TT(56063).. self:getStatsDataValue(rogueLike.LayerDataConst.LAYER_FUNCTION_COIN)[1]
    self.mTxtPower.text = _TT(56064) .. self:getStatsDataValue(rogueLike.LayerDataConst.LAYER_IMPROVE_POWER)[1]

    self.mTxtHPUp.text = rogueLike.RogueLikeManager:getSpEffString()

    self:clearHeroItems()
    local mvpHeroId = self:getMVP(rogueLike.MVPType.MVP)
    if mvpHeroId ~= -1 then
        local mvpItem = HeroHeadGrid:poolGet()
        local vo = hero.HeroManager:getHeroVo(mvpHeroId)

        mvpItem:setData(vo)
        mvpItem:setParent(self.mMVPContent, false)
        -- local mvpItem = fightUI.FightDataPreviewHeroItem:poolGet()
        -- mvpItem:setData(self.mMVPContent, {side = 1, heroId = mvpHeroId})
        table.insert(self.mHeroHeads, mvpItem)
    end

    local defHeroId = self:getMVP(rogueLike.MVPType.DEF)
    if defHeroId ~= -1 then
        local defItem = HeroHeadGrid:poolGet()
        local vo = hero.HeroManager:getHeroVo(defHeroId)

        defItem:setData(vo)
        defItem:setParent(self.mDefContent, false)

        -- local defItem = fightUI.FightDataPreviewHeroItem:poolGet()
        -- defItem:setData(self.mDefContent, {side = 1, heroId = defHeroId})
        table.insert(self.mHeroHeads, defItem)
    end

    local attackHeroId = self:getMVP(rogueLike.MVPType.ATTACK)
    if attackHeroId ~= -1 then

        local attackItem = HeroHeadGrid:poolGet()
        local vo = hero.HeroManager:getHeroVo(attackHeroId)

        attackItem:setData(vo)
        attackItem:setParent(self.mAttackContent)
        table.insert(self.mHeroHeads, attackItem)
    end

    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mContent)
end

function clearHeroItems(self)
    for i = 1, #self.mHeroHeads do
        self.mHeroHeads[i]:poolRecover()
    end
    self.mHeroHeads = {}
end

function getStatsDataValue(self, key)
    for i = 1, #self.mStats do
        if self.mStats[i].id == key then
            return self.mStats[i].param
        end
    end

    local list = {}

    if key == rogueLike.LayerDataConst.LAYER_BUFF then
        return list
    elseif key == rogueLike.LayerDataConst.LAYER_DEBUGG then
        return list
    else
        list = {0}
        return list
    end
end

function getData(self)
    local mNeedSide = 1

    -- self.clampMin = 0
    -- self.clampMax = 30
    -- self.mCurrentShowNum = 100
    self.allData = {}
    local maxValue = 0

    for i = 1, #self.mStatistic do
        if self.mStatistic[i].side == mNeedSide then
            local singleData = {}
            singleData.kvAllValue = 0
            singleData.kvList = {}
            singleData.side = mNeedSide
            singleData.heroId = self.mStatistic[i].hero_id

            -- 数值类型筛选 self.mCurrentShowNum < key < self.mCurrentShowNum+10
            for j = 1, #self.mStatistic[i].info do
                if self.mStatistic[i].info[j].key >= self.clampMin and self.mStatistic[i].info[j].key < self.clampMax then
                    if maxValue < self.mStatistic[i].info[j].value[1] then
                        maxValue = self.mStatistic[i].info[j].value[1]
                    end
                    local kv = {}
                    kv.key = self.mStatistic[i].info[j].key

                    singleData.kvAllValue = singleData.kvAllValue + self.mStatistic[i].info[j].value[1]
                    -- 针对buff的特殊处理
                    if kv.key == 30 or kv.key == 31 then
                        kv.value = self.mStatistic[i].info[j].value
                    else
                        kv.value = self.mStatistic[i].info[j].value[1]
                    end

                    table.insert(singleData.kvList, kv)
                end
            end

            table.sort(singleData.kvList, self.__byId)
            table.insert(self.allData, singleData)
        end
    end

    table.sort(self.allData, self.__byAllValue)
end

function __byId(kv1, kv2)
    if kv1.key > kv2.key then
        return false
    else
        return true
    end

end

function __byAllValue(kvs1, kvs2)
    local v1 = 0
    local v2 = 0
    for i = 1, #kvs1.kvList do
        v1 = kvs1.kvList[i].value + v1
    end

    for i = 1, #kvs2.kvList do
        v2 = kvs2.kvList[i].value + v2
    end

    if v1 > v2 then
        return true
    else
        return false
    end
end

function getMVP(self, mvpType)
    if mvpType == rogueLike.MVPType.MVP then
        self.clampMin = 0
        self.clampMax = 30
    elseif mvpType == rogueLike.MVPType.ATTACK then
        self.clampMin = 0
        self.clampMax = 10
    elseif mvpType == rogueLike.MVPType.DEF then
        self.clampMin = 10
        self.clampMax = 20
    end

    self:getData()

    if #self.allData <= 0 then
        return -1
    end
    return self.allData[1].heroId
end

function onInfoClick(self)
    GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PREVIEW_SHOW, {statistic = rogueLike.RogueLikeManager:getRogueLikePreData().battleStatistic})
end

function onBuffClick(self)
    local buff = self:getStatsDataValue(rogueLike.LayerDataConst.LAYER_BUFF)
    if #buff == 0 then
        gs.Message.Show("没有buff")
        return
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_PRE_BUFF_PANEL, {isShowBuff = true, list = buff})
end

function onDebuffClick(self)
    local debuff = self:getStatsDataValue(rogueLike.LayerDataConst.LAYER_DEBUGG)
    if #debuff == 0 then
        gs.Message.Show("没有debuff")
        return
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_ROGUELIKE_PRE_BUFF_PANEL, {isShowBuff = false, list = debuff})
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
