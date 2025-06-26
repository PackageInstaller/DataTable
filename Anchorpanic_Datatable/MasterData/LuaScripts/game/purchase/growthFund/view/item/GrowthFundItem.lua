module("game.purchase.growthFund.view.item.GrowthFundItem", Class.impl("lib.component.BaseItemRender"))
--对应的ui文件
function onInit(self, go)
    super.onInit(self, go)
    self.mAwardList = {}
    self.mBtnAwardL = self:getChildGO("mBtnAwardL")
    self.mBtnAwardR = self:getChildGO("mBtnAwardR")
    self.mAwardGroup = self:getChildTrans("mAwardGroup")
    self.mAwardGroupR = self:getChildTrans("mAwardGroupR")
    self.mImgAwardUnLock = self:getChildGO("mImgAwardUnLock")
    self.mSlider = self:getChildGO("mSlider"):GetComponent(ty.Slider)
    self.mSliderFill = self:getChildGO("Fill"):GetComponent(ty.AutoRefImage)
    self.mTxtProgress = self:getChildGO("mTxtProgress"):GetComponent(ty.Text)
    self.mTxtStageDesc = self:getChildGO("mTxtStageDesc"):GetComponent(ty.Text)
end

function active(self)
    super.active(self)
    GameDispatcher:addEventListener(EventName.UPDATE_GROWTH_FUND_ITEM, self.updateState, self)
    -- role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateState, self)
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_GROWTH_FUND_ITEM, self.updateState, self)
    --role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.updateState, self)
end

function initViewText(self)
    super.initViewText(self)
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnAwardL, self.onClickReciveHandler, nil, false)
    self:addUIEvent(self.mBtnAwardR, self.onClickReciveHandler, nil, true)
end

function setData(self, param)
    super.setData(self, param)
    self.mGrowthFundVo = param
    self:updateState()
end
--1 普通 2 高级
function onClickReciveHandler(self, isSenior)
    if not isSenior then
        if self.mGrowthFundVo:getIsUnLock() then
            if (not self.mGrowthFundVo:getIsReceiveNomalAward()) then
                GameDispatcher:dispatchEvent(EventName.REQ_RECIVE_GROWTH_FUND, { id = self.mGrowthFundVo.sort, type = 1 })
            end
        end
    else
        if self.mGrowthFundVo:getIsUnLock() and self.mGrowthFundVo:getIsBuy() then
            if (not self.mGrowthFundVo:getIsReceiveMoneyAward()) then
                GameDispatcher:dispatchEvent(EventName.REQ_RECIVE_GROWTH_FUND, { id = self.mGrowthFundVo.sort, type = 2 })
            end
        end
    end
end

function updateTime(self)
    self.mTxtTime.text = TimeUtil.getFormatTimeBySeconds_10(self.mSkinVo:getTime())
    if self.mSkinVo:getTime() <= 0 then
        GameDispatcher:dispatchEvent(EventName.UPDATE_SKIN_SHOP, {})
    end
end
--更新滚动状态
function closeAllAward(self)
    if #self.mAwardList > 0 then
        for i, awardItem in ipairs(self.mAwardList) do
            awardItem:poolRecover()
        end
        self.mAwardList = {}
    end
end
--更新状态
function updateState(self)
    self:closeAllAward()
    self.mImgAwardUnLock:SetActive((not purchase.GrowthFundManager:getIsGrowthFundMoney()))
    for _, itemVoL in ipairs(self.mGrowthFundVo:getNomalDropAward()) do
        local propGrid = PropsGrid:create(self.mAwardGroup, { tid = itemVoL.tid, num = itemVoL.num ~= nil and itemVoL.num or 1 }, 1, false)
        propGrid:setCountTextSize(24)
        propGrid:setIsShowCanRec((not self.mGrowthFundVo:getIsReceiveNomalAward() and self.mGrowthFundVo:getIsUnLock()))
        propGrid:setHasRec((self.mGrowthFundVo:getIsReceiveNomalAward() and self.mGrowthFundVo:getIsUnLock()))
        table.insert(self.mAwardList, propGrid)
    end
    for _, itemVoR in ipairs(self.mGrowthFundVo:getMoneyDropAward()) do
        local propGrid = PropsGrid:create(self.mAwardGroupR, { tid = itemVoR.tid, num = itemVoR.num ~= nil and itemVoR.num or 1 }, 1, false)
        self.mImgAwardUnLock:SetActive(not self.mGrowthFundVo:getIsBuy())
        propGrid:setCountTextSize(24)
        propGrid:setIsShowCanRec((not self.mGrowthFundVo:getIsReceiveMoneyAward() and self.mGrowthFundVo:getIsBuy() ))
        propGrid:setHasRec((self.mGrowthFundVo:getIsReceiveMoneyAward() and self.mGrowthFundVo:getIsBuy()))
        table.insert(self.mAwardList, propGrid)
    end
    self.mTxtStageDesc.text = self.mGrowthFundVo:getLvlDsc()
    local curProgess = role.RoleManager:getRoleVo():getPlayerLvl() / self.mGrowthFundVo.lvl
    local curLv = curProgess >= 1 and self.mGrowthFundVo.lvl or role.RoleManager:getRoleVo():getPlayerLvl()
    self.mTxtProgress.text = _TT(45013, curLv, self.mGrowthFundVo.lvl)
    self.mSlider.value = curProgess > 1 and 1 or curProgess
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]