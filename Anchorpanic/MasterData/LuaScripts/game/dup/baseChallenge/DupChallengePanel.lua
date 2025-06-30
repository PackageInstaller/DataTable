module('dup.DupChallengePanel', Class.impl(TabSubView))
UIRes = UrlManager:getUIPrefabPath('dupChallenge/DupChallenge.prefab')

--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setSize(750, 600)
    -- self:setBg("dup_challenge_bg_1.png", false, "dup")
    self:setUICode(LinkCode.Challenge)
end

function initData(self)
    self.mDupItemList = {}
end

function configUI(self)
    self.mScrollContent = self:getChildTrans("Content")
end

function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})
    self:showDupList()
    --self:getChildGO("Scroll View"):GetComponent(ty.ScrollRect).horizontalNormalizedPosition = 0
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    self:clearItemList()
    self:clearTimeouts()
end


function showDupList(self)
    self:clearItemList()
    local dupList = dup.DupChallengeManager:getNewList()

    self.tweenIds = {}
    self:clearTimeouts()

    if guide.GuideManager:getCurHasGuide() == true then
        local needList = {}
        local otherList = {}
        for i = 1, #dupList do
            if dupList[i].type == guide.GuideManager:getNextStepData().next_need_id then
                table.insert(needList, dupList[i])
            else
                table.insert(otherList, dupList[i])
            end
        end

        for i = 1, #otherList do
            table.insert(needList, otherList[i])
        end
        dupList = needList
    end

    for i = 1, #dupList do
        local dupChallengeEnterVo = dupList[i]
        local item = dup.DupChallengeEnterItem:create(self.mScrollContent, dupChallengeEnterVo, 1, false)
        item.mCanvasGroup.gameObject:SetActive(false)

        if self.isReshow then
            item:resShow()
        else
            item:__tweenStart(i * 0.03)
        end

        table.insert(self.mDupItemList, item)
        self:setGuideTrans("guide_DupChallengeEnterItem_" .. dupChallengeEnterVo.type, item.m_childGos["mBtnGroup"].transform)
        --end 

        --local createId = LoopManager:setTimeout(i* 0.03,self,create)
        --table.insert(self.tweenIds,createId)

        -- if dupChallengeEnterVo.type == DupType.Cycle then
        --     self:updateRed(item)
        -- end
    end
end

-- function updateRed(self,item)
--     if  mainui.MainUIManager:getRedFuncIdDicFlag(funcopen.FuncOpenConst.FUNC_ID_ADVENTURE, funcopen.FuncOpenConst.FUNC_ID_CYCLE) then
--         RedPointManager:add(item.mCanvasGroup.transform, nil, -154, 209)
--     else
--         RedPointManager:remove(item.mCanvasGroup.transform)
--     end
-- end

function clearTimeouts(self)
    for i = 1, #self.tweenIds do
        LoopManager:clearTimeout(self.tweenIds[i])
    end
    self.tweenIds = {}
end

function clearItemList(self)
    for i = 1, #self.mDupItemList do
        local item = self.mDupItemList[i]
        item:poolRecover()
    end
    self.mDupItemList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]