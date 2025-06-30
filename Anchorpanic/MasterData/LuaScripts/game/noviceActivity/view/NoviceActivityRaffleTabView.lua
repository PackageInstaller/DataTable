--[[ 
-----------------------------------------------------
@filename       : NoviceActivityRaffleTabView
@Description    : 抽奖
@Author         : sxt
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]] module("game.noviceActivity.view.tab.NoviceActivityRaffleTabView", Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath("noviceActivity/NoviceActivityRaffleTabView.prefab")

function ctor(self)
    super.ctor(self)
    
    self:setUICode(LinkCode.NoviceRafflePanel)
end

-- 析构
function dtor(self)

end

function initData(self)
    self.mSelectBgDic = {}
    self.mPropsPosDic = {}

    self.mRaffleDic = {}
end

-- 初始化
function configUI(self)

    for i = 1, 6 do
        local selectBg = self:getChildGO("selectBg" .. i)
        self.mSelectBgDic[i] = selectBg
    end

    for i = 1, 6 do
        local propsPos = self:getChildTrans("itemPos" .. i)
        self.mPropsPosDic[i] = {
            pos = propsPos
        }
    end

    self.mPointRectTran = self:getChildGO("mPoint"):GetComponent(ty.RectTransform)
    self.mRaffleItem = self:getChildGO("mRaffleItem")

    self.mInfoContent = self:getChildGO("mInfoContent")
    self.mCurrentStepTxt = self:getChildGO("mCurrentStepTxt"):GetComponent(ty.Text)
    self.mNextTxt = self:getChildGO("mNextTxt"):GetComponent(ty.Text)
    self.mDesTxt = self:getChildGO("mDesTxt"):GetComponent(ty.Text)
    self.mCostTxt = self:getChildGO("mCostTxt"):GetComponent(ty.Text)
    self.mCostIconImg = self:getChildGO("mCostIconImg"):GetComponent(ty.AutoRefImage)
    self.mCostCountTxt = self:getChildGO("mCostCountTxt"):GetComponent(ty.Text)

    self.mRaffleBtn = self:getChildGO("mRaffleBtn")
    self.mRemTime = self:getChildGO("mRemTime")
    self.mRemTimeTxt = self:getChildGO("mRemTimeTxt"):GetComponent(ty.Text)

    self.mEffDef = self:getChildGO("mEffDef")
    self.mEffStart= self:getChildGO("mEffStart")
    self.mCostInfo = self:getChildGO("mCostInfo")

    self.mMask = self:getChildGO("mMask")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mRaffleBtn, self.mRaffleClickHandler)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)

end

-- 激活
function active(self)
    super.active(self)

    MoneyManager:setMoneyTidList({MoneyTid.PAY_ITIANIUM_TID, MoneyTid.ITIANIUM_TID})

    GameDispatcher:addEventListener(EventName.UPDATE_RAFFLE_REWARD, self.onRewardPanel, self)
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:removeEventListener(EventName.UPDATE_RAFFLE_REWARD, self.onRewardPanel, self)
    self:clearRaffleItems()

    noviceActivity.NoviceActivityManager:setNoviceUpdate(true)
    if self.loopSn then
        LoopManager:removeFrameByIndex(self.loopSn)
    end
end

function onRewardPanel(self)
    local changeGear = noviceActivity.NoviceActivityManager:getServerRaffleGear()
    local pos = noviceActivity.NoviceActivityManager:getRafflePos()

    -- math.random(1, #randomeTable)
    self:tweenToRot(pos)
end

function clearRaffleItems(self)
    for _, item in pairs(self.mRaffleDic) do
        item:poolRecover()
    end
    self.mRaffleDic = {}
end

function showPanel(self)
    self.mEffDef:SetActive(true)
    self.mEffStart:SetActive(false)
    self.mMask:SetActive(true)
    -- for id, bg in pairs(self.mSelectBgDic) do
    --     bg:SetActive(false)
    -- end

    self.mDesTxt.text = _TT(90047)
    self.mCostTxt.text = _TT(90048)

    local remTime = noviceActivity.NoviceActivityManager:getRaffleTime()
    local md, hm = TimeUtil.getMDHByTime2(remTime)

    self.mRemTimeTxt.text = _TT(121009,md .. " " .. hm)

    local step = noviceActivity.NoviceActivityManager:getServerRaffleGear()
    local raffleData = noviceActivity.NoviceActivityManager:getNoviceStrollData(step)

    self.mRaffleBtn:SetActive(true)
    if raffleData then
        self.mCurrentStepTxt.text = _TT(90046, step)
        self.mCostIconImg:SetImg(UrlManager:getPropsIconUrl(raffleData.cost[1]), false)
        self.mCostCountTxt.text = "x" .. raffleData.cost[2]
        self:clearRaffleItems()
        for i = 1, 6 do
            local singleRaffleData = raffleData:getStrollDataBypos(i)
            local item = SimpleInsItem:create(self.mRaffleItem, self.mPropsPosDic[i].pos, "raffleItem")
            gs.TransQuick:UIPos(item:getGo():GetComponent(ty.RectTransform), 0, 0)

            -- local bg = item:getGo():GetComponent(ty.AutoRefImage)
            -- bg:SetImg(UrlManager:getPackPath("welfareOpt/raffle_color_" .. singleRaffleData.color .. ".png"), false)
            self.mSelectBgDic[i]:GetComponent(ty.AutoRefImage):SetImg(
                UrlManager:getPackPath("welfareOpt/raffle_color_" .. singleRaffleData.color .. ".png"),false
            )
            self.mSelectBgDic[i].transform:Find("mEff3").gameObject:SetActive(singleRaffleData.color == 3)
            self.mSelectBgDic[i].transform:Find("mEff4").gameObject:SetActive(singleRaffleData.color == 4)

            local icon = item:getChildGO("mRaffleIcon"):GetComponent(ty.AutoRefImage)
            local count = item:getChildGO("mRaffleCountTxt"):GetComponent(ty.Text)
            icon:SetImg(UrlManager:getPropsIconUrl(singleRaffleData.tid),true)
            
            if singleRaffleData.tid == MoneyTid.ITIANIUM_TID then
                icon:GetComponent(ty.RectTransform).localScale = gs.Vector3(0.45, 0.45, 1)
            else
                icon:GetComponent(ty.RectTransform).localScale = gs.Vector3(0.55, 0.55, 1)
            end

            count.text = singleRaffleData.reward[2]

            self.mRaffleDic[i] = item
        end
    else
        self.mMask:SetActive(false)
        self.mCurrentStepTxt.text = _TT(90046, "-")
        self.mCostTxt.text = _TT(90049)
        self.mCostInfo:SetActive(false)
        local maxStep = noviceActivity.NoviceActivityManager:getNoviceStrollMaxId()

        local raffleData = noviceActivity.NoviceActivityManager:getNoviceStrollData(maxStep)
        self:clearRaffleItems()
        for i = 1, 6 do
            local singleRaffleData = raffleData:getStrollDataBypos(i)
            local item = SimpleInsItem:create(self.mRaffleItem, self.mPropsPosDic[i].pos, "raffleItem")
            gs.TransQuick:UIPos(item:getGo():GetComponent(ty.RectTransform), 0, 0)

            -- local bg = item:getGo():GetComponent(ty.AutoRefImage)
            -- bg:SetImg(UrlManager:getPackPath("welfareOpt/raffle_color_" .. singleRaffleData.color .. ".png"), false)

            self.mSelectBgDic[i]:GetComponent(ty.AutoRefImage):SetImg(
                UrlManager:getPackPath("welfareOpt/raffle_color_" .. singleRaffleData.color .. ".png"),false
            )

            self.mSelectBgDic[i].transform:Find("mEff3").gameObject:SetActive(singleRaffleData.color == 3)
            self.mSelectBgDic[i].transform:Find("mEff4").gameObject:SetActive(singleRaffleData.color == 4)

            local icon = item:getChildGO("mRaffleIcon"):GetComponent(ty.AutoRefImage)
            local count = item:getChildGO("mRaffleCountTxt"):GetComponent(ty.Text)

            count.text = singleRaffleData.reward[2]

            self.mRaffleDic[i] = item
        end

        self.mRaffleBtn:GetComponent(ty.Button).interactable = false
        -- self.mRaffleBtn:SetActive(false)
        -- self.mInfoContent:SetActive(false)
    end
end

function mRaffleClickHandler(self)
    local step = noviceActivity.NoviceActivityManager:getServerRaffleGear()

    self.clickStep = step
    local raffleData = noviceActivity.NoviceActivityManager:getNoviceStrollData(step)
    if raffleData and step ~= 0 then
        local moneyName = MoneyUtil.getMoneyNameByTid(raffleData.cost[1])
        local count = raffleData.cost[2]
        local result ,tips = MoneyUtil.judgeNeedMoneyCountByTid(raffleData.cost[1], raffleData.cost[2], false, false)
        if tips == "" and result  == true then
            UIFactory:alertMessge(_TT(90052, moneyName, count), true, function()
                self.mRaffleBtn:SetActive(false)
                noviceActivity.NoviceActivityManager:setNoviceUpdate(false)
                GameDispatcher:dispatchEvent(EventName.CELEBRATION_NOCLICK, true)
                GameDispatcher:dispatchEvent(EventName.REQ_RAFFLE_REWARD)
                -- GameDispatcher:dispatchEvent(EventName.REQ_ABANDON_CYCLE)
            end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, RemindConst.RAFFLE)
        elseif not result then
            if step > 1 then
                UIFactory:alertMessge(tips, true, function()
                    if MoneyUtil.getMoneyCountByType(MoneyTid.PAY_ITIANIUM_TID) > 0 and MoneyUtil.getMoneyCountByType(MoneyTid.PAY_ITIANIUM_TID) >= count then
                        GameDispatcher:dispatchEvent(EventName.OPEN_CONVERT_TITANIUM_VIEW)
                    else
                        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, {linkId = LinkCode.Purchase})
                    end
                    --self:close()
                end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
            else
                gs.Message.Show(tips)
            end
            
        end
    else
        gs.Message.Show(_TT(90049))
    end

    -- local pos = math.random(1, 6)
    -- self:tweenToRot(pos)
end

function tweenToRot(self, pos)
    -- 0 -60 -120 -180 -240 -300 -360
    self.mEffDef:SetActive(false)
    self.mEffStart:SetActive(true)

    self.pos = pos
    self.needAngle = (pos - 1) * -60 - 3600
    self.needTime = 5
    self.currentTime = 0
    self.loopSn = LoopManager:addFrame(0, 0, self, self.updateRot)
end

function updateRot(self)
    self.currentTime = self.currentTime + gs.Time.deltaTime
    if self.currentTime >= self.needTime then
        self.currentAngle = self.needAngle
        gs.TransQuick:SetRotation(self.mPointRectTran, 0, 0, self.currentAngle)
        LoopManager:removeFrameByIndex(self.loopSn)

        local step = self.clickStep
        local raffleData = noviceActivity.NoviceActivityManager:getNoviceStrollData(step)
        local singleRaffleData = raffleData:getStrollDataBypos(self.pos)
        local awardPropsList = {}
        local propsVo = props.PropsManager:getPropsVo({
            tid = singleRaffleData.reward[1],
            num = singleRaffleData.reward[2]
        })
        table.insert(awardPropsList, propsVo)
        ShowAwardPanel:showPropsAwardMsg(awardPropsList, function()
            self:showPanel()
            noviceActivity.NoviceActivityManager:setNoviceUpdate(true)
            GameDispatcher:dispatchEvent(EventName.CELEBRATION_NOCLICK, false)
            role.RoleManager:getRoleVo():dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.PAY_ITIANIUM_TID)
            role.RoleManager:getRoleVo():dispatchEvent(role.RoleVo.CHANGE_PLAYER_MONEY, MoneyTid.ITIANIUM_TID)
        end)

    else
        self.currentAngle = self:easeOutCubic(self.needAngle, self.currentTime / self.needTime) -- self.needAngle * gs.Mathf.Pow(2,-8*(self.currentTime/self.needTime )) -- / self.needTime * self.currentTime
        gs.TransQuick:SetRotation(self.mPointRectTran, 0, 0, self.currentAngle)
    end
    --self:updateSelectBg()
end

function easeOutCubic(self, ePos, value)
    value = value - 1
    return ePos * (value * value * value + 1)
end

function updateSelectBg(self)
    local pos = self:clampAngle(self.currentAngle)
    for id, bg in pairs(self.mSelectBgDic) do
        bg:SetActive(pos == id)
    end
end

function clampAngle(self, angle)
    local p = 6 - math.floor(angle / 60) % 6 + 1
    if p == 7 then
        p = 1
    end
    return p
end

return _M
