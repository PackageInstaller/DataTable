--[[ 
-----------------------------------------------------
@filename       : FirstChargePanel
@Description    : 首充面板
@date           : 2023-4-2 
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("firstCharge.FirstChargePanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("firstCharge/FirstChargePanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗 3 不应用遮罩的常驻页面(事影循回)

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setUICode(LinkCode.FirstCharge)
end

function initData(self)
    self.mPropsItemList = {}
    self.mDailyItemList = {}
    self.mCurDaily = 1
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mItemDay = self:getChildGO("mItemDay")
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mBtnLock = self:getChildGO("mBtnLock")
    self.mBtnReceive = self:getChildGO("mBtnReceive")
    self.mImgReceived = self:getChildGO("mImgReceived")
    self.mGroupTrans = self:getChildTrans("mGroupTrans")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtReceived = self:getChildGO("mTxtReceived"):GetComponent(ty.Text)
    self.mTxtTitleDown = self:getChildGO("mTxtTitleDown"):GetComponent(ty.Text)
    -- self.mTxtTitleDes = self:getChildGO("mTxtTitleDes"):GetComponent(ty.Text)
    self.mToggleRemaid = self:getChildGO("mToggleRemaid"):GetComponent(ty.Toggle)
end

--激活
function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_FIRSTCHARGE_PANEL, self.updateView, self)

    if args and args.isShowToggle then
        self.mToggleRemaid.gameObject:SetActive(true)
    else
        self.mToggleRemaid.gameObject:SetActive(false)
    end
    self:updateView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_FIRSTCHARGE_PANEL, self.updateView, self)
    self:closeDailyList()
    self:closePropsList()

    if self.mToggleRemaid.isOn then
        GameDispatcher:dispatchEvent(EventName.REQ_ADD_NOT_REMIND, { moduleId = RemindConst.ACTIVITY_PROMO_SHOW })
    end
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnLock, self.onClickLockHandler)
    self:addUIEvent(self.mBtnClose, self.close)
    self:addUIEvent(self.mBtnReceive, self.onClickReciveHandler)
end

function initViewText(self)
    -- self.mTxtTitle.text = "日连续可领取"
    self.mTxtReceived.text = _TT(411)--已领取
    self.mTxtTitleDown.text = _TT(50069)--shou
end

function updateView(self)
    if firstCharge.FirstChargeManager:getIsReciveOver() then
        self:close()
        return
    end
    self:closeDailyList()
    self:closePropsList()
    for _, firstChargeVo in ipairs(firstCharge.FirstChargeManager:getFirstChargeList()) do
        local item = SimpleInsItem:create(self.mItemDay, self.mGroupTrans, "firstCharge_FirstChargePanel")
        item:getChildGO("mItemDay_01"):SetActive(false)
        item:getChildGO("mTxtCurDay"):GetComponent(ty.Text).text = firstChargeVo.daily
        item:getChildGO("mGet"):SetActive((firstChargeVo:getIsCanRecive()))
        item:setArgs(firstChargeVo)
        item:addUIEvent(nil, function()
            if firstCharge.FirstChargeManager:getIsReCharge() then
                if (firstChargeVo:getIsCanRecive() == true) then
                    GameDispatcher:dispatchEvent(EventName.REQ_RECEIVE_FIRSTCHARGE, firstChargeVo.daily)
                    return
                else
                    if firstChargeVo:getIsRecived() then
                        gs.Message.Show(_TT(411))
                    else
                        gs.Message.Show(_TT(50051))
                    end
                    return
                end
            end
        end)
        for _, propVo in ipairs(firstChargeVo:getItemList()) do
            local propGrid = PropsGrid:createByData({ tid = propVo[1], num = propVo[2], parent = item:getChildTrans("mGroupAward"), scale = 1, showUseInTip = true })
            propGrid:setHasRec(firstChargeVo:getIsRecived())
            propGrid:setIsShowCanRec(firstChargeVo:getIsCanRecive())
            propGrid:setCallBack(self, function()
                if firstChargeVo:getIsCanRecive() then
                    GameDispatcher:dispatchEvent(EventName.REQ_RECEIVE_FIRSTCHARGE, firstChargeVo.daily)
                    return
                end
                if props.PropsManager:getTypePropsVoByTid(propVo[1]).type == PropsType.HERO then
                    self:hideViewAndReshow()
                end
                propGrid:onDefaultClickHandler()
            end)
            propGrid:setCountTextSize(24)
            table.insert(self.mPropsItemList, propGrid)
        end
        table.insert(self.mDailyItemList, item)
    end
    local curIndex = 1
    self:addTimer(0.31, 1, function()
        self.mDailyItemList[curIndex]:getChildGO("mItemDay_01"):SetActive(true)
        self.mSn = LoopManager:addFrame(2, 2, self, function()
            curIndex = curIndex + 1
            self.mDailyItemList[curIndex]:getChildGO("mItemDay_01"):SetActive(true)
        end)
    end)
    self:updateItemList()
end


function updateItemList(self)
    self:setBtnLabel(self.mBtnReceive, -1, "前往充值")
    self.mImgReceived:SetActive(false)
    -- self.mTxtTitleDes.text = "首次充值可获得"
    self.mBtnReceive:SetActive(firstCharge.FirstChargeManager:getIsReCharge() == false)
end

function closePropsList(self)
    if #self.mPropsItemList > 0 then
        for _, item in ipairs(self.mPropsItemList) do
            item:poolRecover()
            item = nil
        end
        self.mPropsItemList = {}
    end
    if self.mSn then
        LoopManager:removeFrameByIndex(self.mSn)
        self.mSn = nil
    end
end

function closeDailyList(self)
    if #self.mDailyItemList > 0 then
        for _, item in ipairs(self.mDailyItemList) do
            item:poolRecover()
            item = nil
        end
        self.mDailyItemList = {}
    end
end

function onClickReciveHandler(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.Purchase })
    self:close()
end
--查看泠详情
function onClickLockHandler(self)
    self:hideViewAndReshow()
    GameDispatcher:dispatchEvent(EventName.OPEN_HERO_RECRUITINFOPANEL, { heroTid = 1004 })
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]