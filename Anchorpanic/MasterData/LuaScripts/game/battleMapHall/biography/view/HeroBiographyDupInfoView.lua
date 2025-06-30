module("battleMap.HeroBiographyDupInfoView", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("battleMapHall/biography/HeroBiographyDupInfoView.prefab")
panelType = -1
isBlur = 0
isAddMask = 0

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构  
function dtor(self)
end

-- 初始化数据
function initData(self)
    self.m_heroTid = nil
    self.m_biographyId = nil
    self.m_stageId = nil
    self.m_dupConfigVo = nil
    self.m_awardList = {}
    self.mMultiTime = 2
    self.fightNeedMultiple = 1
    self.mMultiStorageKey = "HeroBiographyDupMulti"
end

--初始化UI
function configUI(self)
    self.m_txtAwardTitle = self:getChildGO("TextAwardTitle"):GetComponent(ty.Text)
    self.m_txtStageId = self:getChildGO("TextStageId"):GetComponent(ty.Text)
    self.m_txtStageName = self:getChildGO("TextStageName"):GetComponent(ty.Text)
    self.m_txtStageDes = self:getChildGO("TextStageDes"):GetComponent(ty.Text)
    self.m_scrollContent = self:getChildGO("Scroller"):GetComponent(ty.ScrollRect).content
    self.m_btnFight = self:getChildGO("BtnFight")

    self.m_imgCost = self:getChildGO("ImgCost"):GetComponent(ty.AutoRefImage)
    self.m_txtCost = self:getChildGO("TextCost"):GetComponent(ty.Text)

    self.anim = self.UIObject:GetComponent(ty.Animator)
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mMoneyGroups = self:getChildTrans("mMoneyGroups")
    self.mBtnAnemyFormation = self:getChildGO("mBtnAnemyFormation")
    self:addOnClick(self.mBtnAnemyFormation, self.onOpenFormationPanel)

    self.mNumberStepper = self:getChildGO("mNumberMultiple"):GetComponent(ty.LyNumberStepper)
    self.mNumberStepper:Init(self.mMultiTime, 1, 1, -1, self.onStepChange, self)
end

--激活
function active(self)
    super.active(self)
    self:addOnClick(self.m_btnFight, self.__onFightHandler)
    self:addOnClick(self.mBtnClose, function() GameDispatcher:dispatchEvent(EventName.CLOSE_BIOGRAPHY_INFO) end)
    -- if not self.mMoneyBarItem then
    --     self.mMoneyBarItem = MoneyItem:poolGet()
    -- end
    -- self.mMoneyBarItem:setData(self.mMoneyGroups, { tid = MoneyTid.ANTIEPIDEMIC_SERUM_TID, frontType = 2 })
    stamina.StaminaManager:addEventListener(stamina.StaminaManager.EVENT_STAMINA_UPDATE, self.updateCostNum, self)

end

--非激活
function deActive(self)
    super.deActive(self)
    -- if self.mMoneyBarItem then
    --     self.mMoneyBarItem:poolRecover()
    --     self.mMoneyBarItem = nil
    -- end
    stamina.StaminaManager:removeEventListener(stamina.StaminaManager.EVENT_STAMINA_UPDATE, self.updateCostNum, self)
    self:removeOnClick(self.m_btnFight, self.__onFightHandler)
    if self.destoryLoop then
        LoopManager:removeTimerByIndex(self.destoryLoop)
        self.destoryLoop = nil
    end
    self:__removeAwardList()
end

--步进器倍数
function onStepChange(self, cusCount, cusType)
    if cusType == 2 then
        -- '最小值'  
        gs.Message.Show(_TT(4019))
        return
    end
    if not funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_DUP_MULTI, true) then
        self.mNumberStepper.CurrCount = 1
        self.fightNeedMultiple = 1
        return
    end
    if self:getIsFirst() then
        gs.Message.Show(_TT(1395))
        self.mNumberStepper.CurrCount = 1
        self.fightNeedMultiple = 1
        return
    end
    if cusType == 1 then
        -- '最大值'
        gs.Message.Show("已达到今日最高挑战次数")
        return
    end


    if cusCount > self.fightNeedMultiple and not self:checkChangeCurMaxMultiple(cusCount) then
        self.mNumberStepper.CurrCount = self.fightNeedMultiple
        return
    end
    self.fightNeedMultiple = self.mNumberStepper.CurrCount
    StorageUtil:saveString1(self.mMultiStorageKey, self.mNumberStepper.CurrCount)
    self:updateFightCostNum()
end

--更新战斗所需物品消耗倍数
function updateFightCostNum(self)
    self:udapteCurMultiple()
    for i, grid in ipairs(self.m_awardList) do
        if grid:getIsFirstPass() == false and grid.mPropsVo.count > 1 then
            local count = grid.mPropsVo.count;
            count = grid.mPropsVo.count * self.fightNeedMultiple;
            self.m_awardList[i]:setCount(count)
        end
    end
    if self.mLevelData then
        self.mTxtFightNeedNum.text = self:getThreeUnaryValue(MoneyUtil.getMoneyCountByTid(MoneyTid.ANTIEPIDEMIC_SERUM_TID) >= self.fightNeedMultiple * self.mLevelData.needNum, HtmlUtil:color(self.fightNeedMultiple * self.mLevelData.needNum, "202226FF"), HtmlUtil:color(self.fightNeedMultiple * self.mLevelData.needNum, "FF0000"))
    end
    self:updateCostNum()
end

function udapteCurMultiple(self)
    local minChallengeNum = self.mBiographyVo.restTime <= battleMap.BiographyManager:getResTimes() and self.mBiographyVo.restTime or battleMap.BiographyManager:getResTimes()
    local multiNum = StorageUtil:getString1(self.mMultiStorageKey)
    multiNum = multiNum == "" and 1 or multiNum
    multiNum = math.min(minChallengeNum, tonumber(multiNum))
    self.mNumberStepper.MaxCount = minChallengeNum

    self.mNumberStepper.CurrCount = ((multiNum == nil) or (multiNum == "") or self:getIsFirst()) and 1 or multiNum
    self.fightNeedMultiple = self.mNumberStepper.CurrCount
end

function checkChangeCurMaxMultiple(self, cusMulit)
    local playerCurLv = role.RoleManager:getRoleVo():getPlayerLvl()
    for _, curVo in ipairs(sysParam.SysParamManager:getValue(SysParamType.DUP_ASSETS_MULTI)) do
        if cusMulit == curVo[1] and playerCurLv < curVo[2] then
            gs.Message.Show(_TT(53612, curVo[2]))--链尉官等级{0}级解锁
            return false
        end
    end
    return true
end


function onOpenFormationPanel(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_FORMATION_PREVIEW, { dupVo = self.m_dupConfigVo })
end

function show(self, heroTid, biographyId, stageId)
    -- self:setParentTrans(parent)
    self:setData(heroTid, biographyId, stageId)
end

function setData(self, heroTid, biographyId, stageId)
    self.m_heroTid = heroTid
    self.m_biographyId = biographyId
    self.m_stageId = stageId
    self.m_dupConfigVo = battleMap.BiographyManager:getDupConfigVo(self.m_stageId)
    self.m_txtStageId.text = self.m_dupConfigVo:getSort()
    self.m_txtStageName.text = self.m_dupConfigVo:getName()

    self.mBiographyVo = battleMap.BiographyManager:getBiographyVo(self.m_heroTid, self.m_biographyId)

    self:__updateAwardList()
    self.m_txtAwardTitle.text = _TT(116) --"通关奖励"

    self:updateFightCostNum()
end

function updateCostNum(self)
    local costTid = self.m_dupConfigVo:getNeedTid()
    local costCount = self.m_dupConfigVo:getNeedNum()
    costCount = costCount * self.fightNeedMultiple
    self.m_imgCost:SetImg(UrlManager:getPropsIconUrl(costTid), false)
    self.m_txtCost.text = costCount
    self.m_txtCost.color = MoneyUtil.getMoneyCountByTid(costTid) >= costCount and gs.ColorUtil.GetColor("000000FF") or gs.ColorUtil.GetColor("BD2A2AFF")
    self.m_txtCost.gameObject:SetActive(costTid ~= 0 and costCount > 0)
end

function __updateAwardList(self)
    self:__removeAwardList()
    if (self:getIsFirst()) then
        local awardPackIdFirst = self.m_dupConfigVo:getFirstAward()
        local tempList = AwardPackManager:getAwardListById(awardPackIdFirst)
        local awardListFirst = table.copy(tempList)

        gs.TransQuick:SizeDelta01(self.m_scrollContent, (#awardListFirst - 1) * 114 + 55 * 2)
        for i = 1, #awardListFirst do
            local vo = awardListFirst[i]
            local propsGrid = PropsGrid:create(self.m_scrollContent, { vo.tid, (vo.num or vo.count) }, 1, false)
            propsGrid:setPosition(math.Vector3((i - 1) * 114 + 55, 0, 0))
            if vo.state and vo.state == 3 then
                propsGrid:setIsDeadline(true)
            else
                propsGrid:setIsFirstPass(true)
            end
            table.insert(self.m_awardList, propsGrid)
        end
    end
    local awardPackId = self.m_dupConfigVo:getShowDrop()
    local tempList = AwardPackManager:getAwardListById(awardPackId)
    local awardList = table.copy(tempList)


    if dup.DupMainManager:getIsMatchActivityMoney(PreFightBattleType.HeroBiography) then
        local propVo = props.PropsManager:getPropsVo({ tid = sysParam.SysParamManager:getValue(SysParamType.ACTIVE_DEADLINE_PROP), num = self.m_dupConfigVo:getNeedNum() })
        propVo.state = 3
        table.insert(awardList, propVo)
    end

    gs.TransQuick:SizeDelta01(self.m_scrollContent, (#awardList - 1) * 114 + 55 * 2)
    for i = 1, #awardList do
        local vo = awardList[i]
        local propsGrid = PropsGrid:create(self.m_scrollContent, { vo.tid, (vo.num or vo.count) }, 1, false)
        propsGrid:setPosition(math.Vector3((i - 1) * 114 + 55, 0, 0))
        if vo.state and vo.state == 3 then
            propsGrid:setIsDeadline(true)
        end
        table.insert(self.m_awardList, propsGrid)
    end
    gs.TransQuick:UIPosX(self.m_scrollContent, 0)
end

function __removeAwardList(self)
    for i = #self.m_awardList, 1, -1 do
        local item = self.m_awardList[i]
        item:poolRecover()
    end
    self.m_awardList = {}
end

function __onFightHandler(self)
    local stageVo = battleMap.BiographyManager:getDupConfigVo(self.m_stageId)

    -- 是否剧情或CG
    if (stageVo:getType() == battleMap.DupContentType.NORMAL) then
        local biographyVo = battleMap.BiographyManager:getBiographyVo(self.m_heroTid, self.m_biographyId)
        local allChallengeTime = battleMap.BiographyManager:getResTimes()
        local restTime = biographyVo.restTime <= allChallengeTime and biographyVo.restTime or allChallengeTime
        if (restTime > 0) then
            -- if (not table.indexof(biographyVo.passDupList, self.m_stageId)) then
            local costTid = self.m_dupConfigVo:getNeedTid()
            local costCount = self.m_dupConfigVo:getNeedNum() * self.fightNeedMultiple
            if (MoneyUtil.judgeNeedMoneyCountByTid(costTid, costCount, true)) then
                local formatoinCallFun = function(callReason)
                    if (callReason ~= formation.CALL_FUN_REASON.PLAYER_CLOSE) then
                        battleMap.BiographyManager:setLastData(self.m_heroTid, self.m_biographyId)
                    end
                end
                formation.checkFormationFight(PreFightBattleType.HeroBiography, nil, self.m_stageId, nil, nil, nil, formatoinCallFun, self.fightNeedMultiple)
            else
                GameDispatcher:dispatchEvent(EventName.OPEN_ADD_STAMINA_PANEL, { isByProps = true, needCost = 0, callFun = nil, callObj = nil })
                gs.Message.Show(_TT(26318))
            end
            -- else
            --     gs.Message.Show(_TT(49008))
            -- end
        else
            -- gs.Message.Show("挑战次数不足")
            gs.Message.Show(_TT(49006))
        end
    else
        local finishCall = function(isSuccess, storyRo)
            if (isSuccess) then
                if (not storyTalk.StoryTalkManager:isPassStory(storyRo:getRefID())) then
                    GameDispatcher:dispatchEvent(EventName.REQ_DUP_STORY_FINISH, { battleType = PreFightBattleType.HeroBiography, fieldId = self.m_stageId })
                end
            else
                -- gs.Message.Show("无剧情可播放")
                gs.Message.Show(_TT(49007))
            end
        end
        storyTalk.StoryTalkManager:justStoryNoFight(PreFightBattleType.HeroBiography, self.m_stageId, finishCall)
    end
end

function getIsFirst(self)
    local isFirst = true
    local biographyVo = battleMap.BiographyManager:getBiographyVo(self.m_heroTid, self.m_biographyId)
    -- 已开启
    if (biographyVo) then
        if (table.indexof(biographyVo.historyDupList, self.m_stageId)) then      -- 已通关
            isFirst = false
        end
    end
    return isFirst
end

function showChangeAnimator(self)
    self.anim:SetTrigger("exit")
end

function DelayDestroy(self)
    self.anim:SetTrigger("show")
    self.animaState = self.anim:GetCurrentAnimatorStateInfo(0)
    self.destoryLoop = LoopManager:addTimer(0.3, 1, self, self.endLoop)
end

function endLoop(self)
    if self.destoryLoop then
        LoopManager:removeTimerByIndex(self.destoryLoop)
        self.destoryLoop = nil
    end
    self:close()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]