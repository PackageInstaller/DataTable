--[[ 
-----------------------------------------------------
@filename       : FightDataPreView
@Description    : 战斗结算统计面板
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("game.fightUI.view.FightDataPreView",Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("figthtResult/FightDataPreView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)

    self:setSize(1120, 519)
    self:setTxtTitle(_TT(3065))
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mLyScroll = self:getChildGO("mLyScroller"):GetComponent(ty.LyScroller)
    self.mTeammateTabItem = self:getChildGO("mTeammateTabItem")
    self.mEnemyTabItem = self:getChildGO("mEnemyTabItem")

    self.mTeammateNomal = self:getChildGO("mTeammateNomal")
    self.mTeammateSelect = self:getChildGO("mTeammateSelect")
    self.mEnemyNomal = self:getChildGO("mEnemyNomal")
    self.mEnemySelect = self:getChildGO("mEnemySelect")


    self.mCurrentShowSelf = true
    -- self.mCurrentShowNum = 1
    self.mLyScroll:SetItemRender(fightUI.FightDataPreViewSingleItem)
end

--激活
function active(self, args)
    super.active(self, args)
    self.resultData = args

    self:teammateTabClick(true)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end


-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mTeammateTabItem,self.onTeammateTabClick)
    self:addUIEvent(self.mEnemyTabItem,self.onEnemyTabClick)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

function teammateTabClick(self,isInit)
    self.mTeammateSelect:SetActive(true)
    self.mEnemySelect:SetActive(false)

    self.mCurrentShowSelf = true
    self:updatePreviewData(isInit)
end

function onTeammateTabClick(self)
    self:teammateTabClick(false)
end

function onEnemyTabClick(self)
    self.mTeammateSelect:SetActive(false)
    self.mEnemySelect:SetActive(true)

    self.mCurrentShowSelf = false
    self:updatePreviewData(false)
end

function updatePreviewData(self,isInit)
    if self.resultData == nil then 
        self.resultData = fight.FightManager:getResultData()
    end

    local allData = {}
    local mNeedSide = self.mCurrentShowSelf and 1 or 2

    local maxValue = 0

    self.mAllHurt = 0 --所有伤害
    self.mAllBearHurt = 0 --所有承伤
    self.mAllAddBlood = 0 --所有治疗
    for i = 1, #self.resultData.statistic do
        --阵营筛选
        if self.resultData.statistic[i].side == mNeedSide then
            local singleData ={}
            singleData.hurt = 0 --伤害
            singleData.bearHurt = 0 --承伤
            singleData.addBlood = 0 --治疗
            singleData.hurtScale = 0 --伤害比例
            singleData.bearHurtScale = 0 --承伤比例
            singleData.addBloodScale = 0 --治疗比例

            -- singleData.kvList = {}
            singleData.side = mNeedSide
            singleData.heroId = self.resultData.statistic[i].hero_id
            singleData.side = self.resultData.statistic[i].side
            singleData.tid = self.resultData.statistic[i].tid
            singleData.lv = self.resultData.statistic[i].lv
            singleData.evolution = self.resultData.statistic[i].evolution
            
            --数值类型筛选 self.mCurrentShowNum < key < self.mCurrentShowNum+10
            for j = 1, #self.resultData.statistic[i].info do 
                --1 - 10 为伤害  10-20为承伤  20 自疗  具体 看FightPreviewDataConst
                if self.resultData.statistic[i].info[j].key >= 1 and self.resultData.statistic[i].info[j].key <= 10 then
                    singleData.hurt =  singleData.hurt + self.resultData.statistic[i].info[j].value[1] 
                elseif self.resultData.statistic[i].info[j].key > 10 and self.resultData.statistic[i].info[j].key < 20 then
                    singleData.bearHurt = singleData.bearHurt + self.resultData.statistic[i].info[j].value[1] 
                elseif self.resultData.statistic[i].info[j].key == fightUI.FightPreviewDataConst.STATISTIC_TYPE_CURE then
                    singleData.addBlood = singleData.addBlood + self.resultData.statistic[i].info[j].value[1]
                end
            end

            self.mAllHurt = self.mAllHurt + singleData.hurt
            self.mAllBearHurt = self.mAllBearHurt + singleData.bearHurt
            self.mAllAddBlood = self.mAllAddBlood + singleData.addBlood

            table.insert(allData,singleData)
        end
    end

    local minHurtData = nil
    local minHurt = 999999999
    local hurtScale = 0

    local minBearHurtData = nil
    local minBearHurt = 999999999
    local bearHurtScale = 0


    local minAddBloodData = nil
    local minAddBlood = 999999999
    local addBloodScale = 0

    for i=1,#allData do
        allData[i].hurtScale = allData[i].hurt == 0 and 0 or math.ceil((allData[i].hurt / self.mAllHurt) * 1000)
        allData[i].bearHurtScale = allData[i].bearHurt == 0 and 0 or math.ceil((allData[i].bearHurt / self.mAllBearHurt) * 1000)
        allData[i].addBloodScale = allData[i].addBlood == 0 and 0 or math.ceil((allData[i].addBlood / self.mAllAddBlood) * 1000)

        --拿到最小的那个值
        if allData[i].hurt > 0 and allData[i].hurt < minHurt then
            if minHurtData then
                hurtScale = hurtScale + minHurtData.hurtScale
            end
            minHurtData = allData[i]
            minHurt = allData[i].hurt
        else
            hurtScale = hurtScale + allData[i].hurtScale
        end

        if allData[i].bearHurt > 0 and allData[i].bearHurt < minBearHurt then
            if minBearHurtData then
                bearHurtScale = bearHurtScale + minBearHurtData.bearHurtScale
            end
            minBearHurtData = allData[i]
            minBearHurt = allData[i].bearHurt
        else
            bearHurtScale = bearHurtScale + allData[i].bearHurtScale
        end

        if allData[i].addBlood > 0 and allData[i].addBlood < minAddBlood then
            if minAddBloodData then
                addBloodScale = addBloodScale + minAddBloodData.addBloodScale
            end
            minAddBloodData = allData[i]
            minAddBlood = allData[i].addBlood
        else
            addBloodScale = addBloodScale + allData[i].addBloodScale
        end
    end

    --将最小的那个值的比例调整，保证所有的比例值加起来 = 100
    if minHurtData and minHurtData.hurtScale ~= 0 then
        minHurtData.hurtScale = 1000 - hurtScale
    end
    if minBearHurtData and minBearHurtData.bearHurtScale ~= 0 then
        minBearHurtData.bearHurtScale = 1000 - bearHurtScale
    end
    if minAddBloodData and minAddBloodData.addBloodScale ~= 0 then
        minAddBloodData.addBloodScale = 1000 - addBloodScale
    end

    table.sort( allData, function (a,b)
        if a.hurt == b.hurt then 
            if a.bearHurt == b.bearHurt then 
                return a.addBlood > b.addBlood
            else
                return a.bearHurt > b.bearHurt
            end
        else
            return a.hurt > b.hurt
        end
    end)
    
    if isInit then
        self.mLyScroll.DataProvider = allData
    else
        self.mLyScroll:ReplaceAllDataProvider(allData)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(3065):	"<size=24>战</size>斗统计"
	语言包: _TT(3005):	"敌方"
	语言包: _TT(3004):	"我方"
]]
