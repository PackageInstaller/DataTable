--[[ 
-----------------------------------------------------
@filename       : ArenaHellResultDataPanel
@Description    : 战斗结算统计面板
@Author         : sxt
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module("arenaEntrance.ArenaHellResultDataPanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("arenaEntrance/ArenaHellResultDataPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(3065))
    self:setSize(0, 0)
end
-- 析构  
function dtor(self)
end

function initData(self)
    self.mItemPlayer = {}
    self.mItemEnemy = {}
end

-- 初始化
function configUI(self)
    self.mCurrentShowSelf = true
    self.mBtnClose = self:getChildGO("mBtnClose")

    self.mBtnRound1 = self:getChildGO("mBtnRound1")
    self.mBtnRound2 = self:getChildGO("mBtnRound2")
    self.mBtnRound3 = self:getChildGO("mBtnRound3")
    self.mRoundList = {}
    table.insert(self.mRoundList, self.mBtnRound1)
    table.insert(self.mRoundList, self.mBtnRound2)
    table.insert(self.mRoundList, self.mBtnRound3)

    self.mImgWin1 = self:getChildGO("mImgWin1")
    self.mImgWin2 = self:getChildGO("mImgWin2")
    self.mImgWin3 = self:getChildGO("mImgWin3")
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    self.lastBattleType = fight.FightManager:getLastReqInfoBattleType()

    self.resultData = args

    if self.lastBattleType == PreFightBattleType.GuildWar then
        self.mRoundList[3]:SetActive(false)
    end
   

    self.defIndex = 1


    self:updateClickRound(self.defIndex)
    --self:updatePreviewData()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    for i = 1, #self.mRoundList do
        self.mRoundList[i].transform:Find("mTxtRound"):GetComponent(ty.Text).text = "对局" .. i
        self.mRoundList[i].transform:Find("mIsSelect/mTxtSelectRound"):GetComponent(ty.Text).text = "对局" .. i
    end
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onClickClose)

    self:addUIEvent(self.mBtnRound1, self.onBtnRound1Click)
    self:addUIEvent(self.mBtnRound2, self.onBtnRound2Click)
    self:addUIEvent(self.mBtnRound3, self.onBtnRound3Click)
end

function onBtnRound1Click(self)
    self:updateClickRound(1)
end

function onBtnRound2Click(self)
    self:updateClickRound(2)
end
function onBtnRound3Click(self)
    self:updateClickRound(3)
end

function updateClickRound(self, index)
    self.defIndex = index
    for i = 1, #self.mRoundList do
        self.mRoundList[i].transform:Find("mIsSelect").gameObject:SetActive(i == index)
    end

    --gs.Message.Show("开启这里=== TODO")
    self:updatePreviewData()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID})
    self:recoverAllItem()
    self:recoverEnemy()
end

function updatePreviewData(self)
    -- if self.resultData == nil then
    --     self.resultData = fight.FightManager:getResultData()
    -- end
    self.resultData = {}
    self.resultData = arenaEntrance.ArenaEntranceManager:getArenaHellResultData(self.defIndex)

    if arenaEntrance.ArenaEntranceManager.IsSelfAttack then
        self.mImgWin1:SetActive(self.resultData.result == 1)
        self.mImgWin2:SetActive(self.resultData.result == 2)
        self.mImgWin3:SetActive(self.resultData.result == 3)
    else
        self.mImgWin1:SetActive(self.resultData.result == 2)
        self.mImgWin2:SetActive(self.resultData.result == 1)
        self.mImgWin3:SetActive(self.resultData.result == 3)
    end

    if self.lastBattleType == PreFightBattleType.GuildWar then
        self.mImgWin1:SetActive(self.resultData.result == 1)
        self.mImgWin2:SetActive(self.resultData.result == 2)
        self.mImgWin3:SetActive(self.resultData.result == 3)
    end

    local allData = {}
    local allData_02 = {}

    self.mAllHurt = 0 -- 所有伤害
    self.mAllBearHurt = 0 -- 所有承伤
    self.mAllAddBlood = 0 -- 所有治疗

    self.mAllHurt2 = 0 -- 所有伤害 2
    self.mAllBearHurt2 = 0 -- 所有承伤 2
    self.mAllAddBlood2 = 0 -- 所有治疗  2 

    local side1, side2 = 1, 2
    if arenaEntrance.ArenaEntranceManager.IsSelfAttack then
        side1, side2 = 1, 2
    else
        side1, side2 = 2, 1
    end

    if self.lastBattleType == PreFightBattleType.GuildWar  then
        if guildWar.GuildWarManager:getLookIsSelf() then
            side1, side2 = 1, 2
        else
            side1, side2 = 2, 1
        end
    end


    for i = 1, #self.resultData.statistic do

        -- 阵营筛选
        if self.resultData.statistic[i].side == side1 then

            local singleData = {}
            singleData.hurt = 0 -- 伤害
            singleData.bearHurt = 0 -- 承伤
            singleData.addBlood = 0 -- 治疗
            singleData.hurtScale = 0 -- 伤害比例
            singleData.bearHurtScale = 0 -- 承伤比例
            singleData.addBloodScale = 0 -- 治疗比例
            singleData.side = side1
            -- singleData.kvList = {}
            singleData.heroId = self.resultData.statistic[i].hero_id

            singleData.tid = self.resultData.statistic[i].tid
            singleData.lv = self.resultData.statistic[i].lv
            singleData.evolution = self.resultData.statistic[i].evolution

            -- 数值类型筛选 self.mCurrentShowNum < key < self.mCurrentShowNum+10
            for j = 1, #self.resultData.statistic[i].info do
                -- 1 - 10 为伤害  10-20为承伤  20 自疗  具体 看FightPreviewDataConst
                if self.resultData.statistic[i].info[j].key >= 1 and self.resultData.statistic[i].info[j].key <= 10 then
                    singleData.hurt = singleData.hurt + self.resultData.statistic[i].info[j].value[1]
                elseif self.resultData.statistic[i].info[j].key > 10 and self.resultData.statistic[i].info[j].key < 20 then
                    singleData.bearHurt = singleData.bearHurt + self.resultData.statistic[i].info[j].value[1]
                elseif self.resultData.statistic[i].info[j].key == fightUI.FightPreviewDataConst.STATISTIC_TYPE_CURE then
                    singleData.addBlood = singleData.addBlood + self.resultData.statistic[i].info[j].value[1]
                end
            end

            self.mAllHurt = self.mAllHurt + singleData.hurt
            self.mAllBearHurt = self.mAllBearHurt + singleData.bearHurt
            self.mAllAddBlood = self.mAllAddBlood + singleData.addBlood

            table.insert(allData, singleData)
        else
            local singleData = {}
            singleData.hurt = 0 -- 伤害
            singleData.bearHurt = 0 -- 承伤
            singleData.addBlood = 0 -- 治疗
            singleData.hurtScale = 0 -- 伤害比例
            singleData.bearHurtScale = 0 -- 承伤比例
            singleData.addBloodScale = 0 -- 治疗比例
            singleData.side = side2
            -- singleData.kvList = {}
            singleData.heroId = self.resultData.statistic[i].hero_id
            singleData.tid = self.resultData.statistic[i].tid
            singleData.lv = self.resultData.statistic[i].lv
            singleData.evolution = self.resultData.statistic[i].evolution

            -- 数值类型筛选 self.mCurrentShowNum < key < self.mCurrentShowNum+10
            for j = 1, #self.resultData.statistic[i].info do
                -- 1 - 10 为伤害  10-20为承伤  20 自疗  具体 看FightPreviewDataConst
                if self.resultData.statistic[i].info[j].key >= 1 and self.resultData.statistic[i].info[j].key <= 10 then
                    singleData.hurt = singleData.hurt + self.resultData.statistic[i].info[j].value[1]
                elseif self.resultData.statistic[i].info[j].key > 10 and self.resultData.statistic[i].info[j].key < 20 then
                    singleData.bearHurt = singleData.bearHurt + self.resultData.statistic[i].info[j].value[1]
                elseif self.resultData.statistic[i].info[j].key == fightUI.FightPreviewDataConst.STATISTIC_TYPE_CURE then
                    singleData.addBlood = singleData.addBlood + self.resultData.statistic[i].info[j].value[1]
                end
            end

            self.mAllHurt2 = self.mAllHurt2 + singleData.hurt
            self.mAllBearHurt2 = self.mAllBearHurt2 + singleData.bearHurt
            self.mAllAddBlood2 = self.mAllAddBlood2 + singleData.addBlood

            table.insert(allData_02, singleData)
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

    local minHurtData2 = nil
    local minHurt2 = 999999999
    local hurtScale2 = 0

    local minBearHurtData2 = nil
    local minBearHurt2 = 999999999
    local bearHurtScale2 = 0

    local minAddBloodData2 = nil
    local minAddBlood2 = 999999999
    local addBloodScale2 = 0

    for i = 1, #allData do
        allData[i].hurtScale = allData[i].hurt == 0 and 0 or math.ceil((allData[i].hurt / self.mAllHurt) * 1000)
        allData[i].bearHurtScale = allData[i].bearHurt == 0 and 0 or
        math.ceil((allData[i].bearHurt / self.mAllBearHurt) * 1000)
        allData[i].addBloodScale = allData[i].addBlood == 0 and 0 or
        math.ceil((allData[i].addBlood / self.mAllAddBlood) * 1000)

        -- 拿到最小的那个值
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

    for i = 1, #allData_02 do
        allData_02[i].hurtScale = allData_02[i].hurt == 0 and 0 or
        math.ceil((allData_02[i].hurt / self.mAllHurt2) * 1000)
        allData_02[i].bearHurtScale = allData_02[i].bearHurt == 0 and 0 or
        math.ceil((allData_02[i].bearHurt / self.mAllBearHurt2) * 1000)
        allData_02[i].addBloodScale = allData_02[i].addBlood == 0 and 0 or
        math.ceil((allData_02[i].addBlood / self.mAllAddBlood2) * 1000)

        -- 拿到最小的那个值
        if allData_02[i].hurt > 0 and allData_02[i].hurt < minHurt2 then
            if minHurtData2 then
                hurtScale2 = hurtScale2 + minHurtData2.hurtScale
            end
            minHurtData2 = allData_02[i]
            minHurt2 = allData_02[i].hurt
        else
            hurtScale2 = hurtScale2 + allData_02[i].hurtScale
        end

        if allData_02[i].bearHurt > 0 and allData_02[i].bearHurt < minBearHurt2 then
            if minBearHurtData2 then
                bearHurtScale2 = bearHurtScale2 + minBearHurtData2.bearHurtScale
            end
            minBearHurtData2 = allData_02[i]
            minBearHurt2 = allData_02[i].bearHurt
        else
            bearHurtScale2 = bearHurtScale2 + allData_02[i].bearHurtScale
        end

        if allData_02[i].addBlood > 0 and allData_02[i].addBlood < minAddBlood2 then
            if minAddBloodData2 then
                addBloodScale2 = addBloodScale2 + minAddBloodData2.addBloodScale
            end
            minAddBloodData2 = allData_02[i]
            minAddBlood2 = allData_02[i].addBlood
        else
            addBloodScale2 = addBloodScale2 + allData_02[i].addBloodScale
        end
    end

    -- 将最小的那个值的比例调整，保证所有的比例值加起来 = 100
    if minHurtData and minHurtData.hurtScale ~= 0 then
        minHurtData.hurtScale = 1000 - hurtScale
    end
    if minBearHurtData and minBearHurtData.bearHurtScale ~= 0 then
        minBearHurtData.bearHurtScale = 1000 - bearHurtScale
    end
    if minAddBloodData and minAddBloodData.addBloodScale ~= 0 then
        minAddBloodData.addBloodScale = 1000 - addBloodScale
    end

    -- 将最小的那个值的比例调整，保证所有的比例值加起来 = 100
    if minHurtData2 and minHurtData2.hurtScale ~= 0 then
        minHurtData2.hurtScale = 1000 - hurtScale2
    end
    if minBearHurtData2 and minBearHurtData2.bearHurtScale ~= 0 then
        minBearHurtData2.bearHurtScale = 1000 - bearHurtScale2
    end
    if minAddBloodData2 and minAddBloodData2.addBloodScale ~= 0 then
        minAddBloodData2.addBloodScale = 1000 - addBloodScale2
    end

    table.sort(allData, function(a, b)
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

    table.sort(allData_02, function(a, b)
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

    self:recoverAllItem()
    for i = 1, 5 do
        local item = SimpleInsItem:create(self.m_childGos["mPlayerItem"], self.m_childGos["Content_01"].transform, "ArenaResultDataPanelmPlayerItem")
        local empty = allData[i] == nil
        item:getChildGO("mEmpty"):SetActive(empty)
        item:getChildGO("mActive"):SetActive(not empty)
        if allData[i] then
            local data = allData[i]
            if data.side == side1 then
                local heroVo = hero.HeroManager:getHeroVo(data.heroId)
                item.m_childGos["ImgHead_1"]:GetComponent(ty.AutoRefImage):SetImg(
                UrlManager:getFormationHeadUrl(heroVo:getHeroModel()), false)
                item.m_childGos["mImgHeroElem"]:SetActive(true)
                item.m_childGos["mImgHeroElem"]:GetComponent(ty.AutoRefImage):SetImg(
                UrlManager:getHeroEleTypeIconUrl(heroVo.eleType), false)
                item.m_childGos["mStartBg"]:SetActive(heroVo.evolutionLvl ~= 0)
                item.m_childGos["GroupStar"]:SetActive(heroVo.evolutionLvl ~= 0)
                for i = 1, 6 do
                    item.m_childGos["mStar0" .. i]:SetActive(i <= heroVo.evolutionLvl)

                end
                item.m_childGos["mTextLvl"]:GetComponent(ty.Text).text = data.lv
                item.m_childGos["mTextName"]:GetComponent(ty.Text).text = heroVo.name
            end
            item.m_childGos["mOutputScore"]:GetComponent(ty.Text).text = data.hurt
            item.m_childGos["mInjuredScore"]:GetComponent(ty.Text).text = data.bearHurt
            item.m_childGos["mTreatScore"]:GetComponent(ty.Text).text = data.addBlood
            item.m_childGos["mOutputBar"]:GetComponent(ty.Image).fillAmount = data.hurtScale / 1000
            item.m_childGos["mOutputPercent"]:GetComponent(ty.Text).text = string.format("%s%%", data.hurtScale / 10)

            item.m_childGos["mInjuredBar"]:GetComponent(ty.Image).fillAmount = data.bearHurtScale / 1000
            item.m_childGos["mInjuredPercent"]:GetComponent(ty.Text).text = string.format("%s%%",
            data.bearHurtScale / 10)

            item.m_childGos["mTreatBar"]:GetComponent(ty.Image).fillAmount = data.addBloodScale / 1000
            item.m_childGos["mTreatPercent"]:GetComponent(ty.Text).text = string.format("%s%%", data.addBloodScale / 10)

        end
        self.mItemPlayer[i] = item
    end
    self:recoverEnemy()
    for i = 1, 5 do
        local item = SimpleInsItem:create(self.m_childGos["mEnemyItem"], self.m_childGos["Content_02"].transform, "ArenaResultDataPanelmEnemyItem")
        local empty = allData_02[i] == nil
        item:getChildGO("mEmpty"):SetActive(empty)
        item:getChildGO("mActive"):SetActive(not empty)
        if allData_02[i] then
            local data = allData_02[i]
            if data.side == side2 then
                local monsterVo = monster.MonsterManager:getMonsterVo01(data.tid)
                if monsterVo then
                    for i = 1, 6 do
                        item.m_childGos["mStar0" .. i]:SetActive(i <= data.evolution)
                    end
                    item.m_childGos["mTextLvl"]:GetComponent(ty.Text).text = data.lv
                    item.m_childGos["mTextName"]:GetComponent(ty.Text).text = monsterVo.name
                    item.m_childGos["mImgHeroElem"]:SetActive(true)

                    item.m_childGos["mImgHeroElem"]:GetComponent(ty.AutoRefImage):SetImg(
                    UrlManager:getHeroEleTypeIconUrl(monsterVo.eleType), false)
                    if monsterVo.type == 3 then
                        item.m_childGos["ImgHead_1"]:GetComponent(ty.AutoRefImage):SetImg(
                        UrlManager:getFormationHeadUrl(monsterVo.model), false)
                    else
                        item.m_childGos["ImgHead_1"]:GetComponent(ty.AutoRefImage):SetImg(
                        UrlManager:getFormationHeadUrl(monsterVo:getShowModelld()), true)
                    end

                end
                item.m_childGos["mStartBg"]:SetActive(data.evolution ~= 0)
                item.m_childGos["GroupStar"]:SetActive(data.evolution ~= 0)
            end
            item.m_childGos["mOutputScore"]:GetComponent(ty.Text).text = data.hurt
            item.m_childGos["mInjuredScore"]:GetComponent(ty.Text).text = data.bearHurt
            item.m_childGos["mTreatScore"]:GetComponent(ty.Text).text = data.addBlood
            item.m_childGos["mOutputBar"]:GetComponent(ty.Image).fillAmount = data.hurtScale / 1000
            item.m_childGos["mOutputPercent"]:GetComponent(ty.Text).text = string.format("%s%%", data.hurtScale / 10)
            item.m_childGos["mInjuredBar"]:GetComponent(ty.Image).fillAmount = data.bearHurtScale / 1000
            item.m_childGos["mInjuredPercent"]:GetComponent(ty.Text).text = string.format("%s%%",
            data.bearHurtScale / 10)
            item.m_childGos["mTreatBar"]:GetComponent(ty.Image).fillAmount = data.addBloodScale / 1000
            item.m_childGos["mTreatPercent"]:GetComponent(ty.Text).text = string.format("%s%%", data.addBloodScale / 10)
        end
        self.mItemEnemy[i] = item
    end

end

function recoverAllItem(self)
    if next(self.mItemPlayer) then
        for _, item in pairs(self.mItemPlayer) do
            item:poolRecover()
        end
        self.mItemPlayer = {}
    end

end

function recoverEnemy(self)
    if next(self.mItemEnemy) then
        for _, item in pairs(self.mItemEnemy) do
            item:poolRecover()
        end
        self.mItemEnemy = {}
    end
end
return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(3065):	"<size=24>战</size>斗统计"
	语言包: _TT(3005):	"敌方"
	语言包: _TT(3004):	"我方"
]]