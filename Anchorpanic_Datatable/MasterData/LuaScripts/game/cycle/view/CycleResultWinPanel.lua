module("cycle.CycleResultWinPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("cycle/CycleResultWinPanel.prefab")
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isAdapta = 0
isBlur = 0

-- 构造函数
function ctor(self)
    super.ctor(self)
    -- self:setSize(0, 0)
    -- self:setBg("cycle_bg_002.jpg", true, "cycle")
    -- self.setBg("")
end

-- 析构
function dtor(self)
end

function initData(self)

end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mBgHero = self:getChildGO("mBgHero"):GetComponent(ty.AutoRefImage)
    self.mTxtGetReason = self:getChildGO("mTxtGetReason"):GetComponent(ty.Text)
    self.mTxtCurrentExp = self:getChildGO("mTxtCurrentExp"):GetComponent(ty.Text)
    self.mHeroName = self:getChildGO("mTxtHeroName"):GetComponent(ty.Text)
    self.mImgHeroProfe = self:getChildGO("mImgHeroProfe"):GetComponent(ty.Image)
    self.mTxtCurrentReason = self:getChildGO("mTxtCurrentReason"):GetComponent(ty.Text)
    self.mTxtLvValue = self:getChildGO("mTxtLvValue"):GetComponent(ty.Text)
    self.mImgExpSlider = self:getChildGO("mImgExpSlider"):GetComponent(ty.Image)
    self.mTxtExpValue = self:getChildGO("mTxtExpValue"):GetComponent(ty.Text)
    self.mBtnClose = self:getChildGO("mBtnClose")
    self.mTxtCurrentHope = self:getChildGO("mTxtCurrentHope"):GetComponent(ty.Text)
    self.mTxtGetHope = self:getChildGO("mTxtGetHope"):GetComponent(ty.Text)
    self.mTxtAdd = self:getChildGO("mTxtAdd"):GetComponent(ty.Text)

    self.mTexGroup2 = self:getChildGO("mTexGroup2")
    self.mTexGroup3 = self:getChildGO("mTexGroup3")

    self.mPreviewBtn = self:getChildGO("mPreViewBtn")
end

-- 激活
function active(self, args)
    super.active(self, args)
    -- self.base_childGos["mGroupTop"]:SetActive(false)
    self.mBattleInfo = args
    self:showPanel()
end
-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    if self.eventLvSn then
        LoopManager:removeFrameByIndex(self.eventLvSn)
        self.eventLvSn = nil
    end

    if self.reasonSn then
        LoopManager:removeFrameByIndex(self.reasonSn)
        self.reasonSn = nil
    end

    if self.hopeSn then
        LoopManager:removeFrameByIndex(self.hopeSn)
        self.hopeSn = nil
    end
    
    GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER, {
        isWin = true
    })
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self:getChildGO("mTxtTile_3"):GetComponent(ty.Text).text = _TT(77845)
    self:getChildGO("mTxtReason"):GetComponent(ty.Text).text = _TT(77846)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.onBtnCloseClick)
    self:addUIEvent(self.mPreviewBtn, self.onPreviewClick)
end

function onPreviewClick(self)
    GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PREVIEW_SHOW)
end

function onBtnCloseClick(self)
    self:close()
end

function showPanel(self)
    self.mTexGroup2:SetActive(false)
    self.mTexGroup3:SetActive(false)

    local curInfo = cycle.CycleManager:getResourceInfo()
    local oldInfo = cycle.CycleManager:getOldResourceInfo()
    self.mLvVo = cycle.CycleManager:getCycleLevelDataByLv(curInfo.lv)
    self.mTxtCurrentHope.text = oldInfo.hope_point
    local dis = curInfo.hope_point - oldInfo.hope_point


    self.mOldReason = oldInfo.reason_point
    self.mNewReason = curInfo.reason_point

    self.mOldHope = oldInfo.hope_point
    self.mNewHope = curInfo.hope_point

    if dis > 0 then
        self.m_childGos["mTxtGetHope"]:SetActive(true)
        self.m_childGos["mTxt_03"]:SetActive(true)
        self.mTxtGetHope.text = dis
    else
        self.m_childGos["mTxt_03"]:SetActive(false)
        self.m_childGos["mTxtGetHope"]:SetActive(false)
    end
    self.mTxtCurrentReason.text = curInfo.reason_point .. "/" .. curInfo.reason_point_limit

    self.mReasonPointLimit = curInfo.reason_point_limit
    -- local num = curInfo.reason_point - oldInfo.reason_point
    -- if num > 0 then
    --     self.mTxtAdd.text = _TT(77847)
    --     self.mTxtGetReason.text = num
    -- else
    --     self.mTxtAdd.text = _TT(77848)
    --     self.mTxtGetReason.text = math.abs(num)
    -- end

    local lv
    if curInfo.lv < 10 then
        lv = "0" .. curInfo.lv
    else
        lv = curInfo.lv
    end
    self.mTxtLvValue.text = lv
    self.mImgExpSlider.fillAmount = curInfo.exp / self.mLvVo.nextExp
    self.mTxtExpValue.text = curInfo.exp .. "/" .. self.mLvVo.nextExp

    local needExp = 0
    if curInfo.lv == oldInfo.lv then
        needExp = curInfo.exp - oldInfo.exp
        self.mTxtCurrentExp.text = "+" .. needExp
    else
        local allExp = 0
        for i = oldInfo.lv, curInfo.lv - 1, 1 do
            local lvVo = cycle.CycleManager:getCycleLevelDataByLv(i)
            allExp = allExp + lvVo.nextExp
        end
        needExp = (allExp - oldInfo.exp) + curInfo.exp
        self.mTxtCurrentExp.text = "+" .. needExp
    end

    self.mMaxLv = cycle.CycleManager:getCycleLevelMax()

    self:showLv(oldInfo.lv)
    self.mCurrentTime = 0
    self.mLvTime = 1
    self.mCurrentLv = oldInfo.lv
    self.mNeedLv = curInfo.lv

    self.mNeedCount = self.mNeedLv - self.mCurrentLv
    self.singTime = self.mLvTime / (self.mNeedCount + 1)

    self.mCurExp = curInfo.exp
    self.mNeedExp = needExp
    self.eventLvSn = LoopManager:addFrame(0, 0, self, self.onLoopEvent)
end

function showLv(self, lv)
    if lv < 10 and lv > 0 then
        lv = "0" .. lv
    else
        lv = lv
    end
    self.mTxtLvValue.text = lv
end

function onLoopEvent(self)
    self.mCurrentTime = self.mCurrentTime + gs.Time.deltaTime

    if self.mCurrentTime <= self.mLvTime then
        local rem = self.mCurrentTime % self.singTime
        local curCount = math.floor(self.mCurrentTime / self.singTime)

        local curInfo = cycle.CycleManager:getResourceInfo()
        local needExp = cycle.CycleManager:getCycleLevelDataByLv(curInfo.lv).nextExp

        if curCount == self.mNeedCount then
            self:showLv(self.mNeedLv)
            if self.mNeedLv == self.mMaxLv then
                self.mTxtCurrentExp.text = "已满级"
                self.mImgExpSlider.fillAmount = 1
            else
                self.mImgExpSlider.fillAmount = (rem / self.singTime) * (self.mCurExp / needExp)
                --self.mTxtCurrentExp.text = math.floor((self.mLvTime - self.mCurrentTime) / self.mLvTime * self.mNeedExp)
            end
        else
            local curLv = self.mCurrentLv + curCount
            self:showLv(curLv)
            local needExp = cycle.CycleManager:getCycleLevelDataByLv(curLv).nextExp
            self.mImgExpSlider.fillAmount = rem / self.singTime
            --self.mTxtCurrentExp.text = math.floor((self.mLvTime - self.mCurrentTime) / self.mLvTime * self.mNeedExp)
        end
    else -- 结束
        self:lvEndCall()
    end
end

function lvEndCall(self)
    local curInfo = cycle.CycleManager:getResourceInfo()
    --self.mTxtCurrentExp.text = 0
    if self.mNeedLv == self.mMaxLv then
        self.mTxtCurrentExp.text = "已满级"
        self.mImgExpSlider.fillAmount = 1
    else
        self.mImgExpSlider.fillAmount = curInfo.exp / self.mLvVo.nextExp
    end
    if self.eventLvSn then
        LoopManager:removeFrameByIndex(self.eventLvSn)
        self.eventLvSn = nil
    end
    
    self.mTexGroup2:SetActive(true)
    self.mReasonTime = 1
    self.mCurrentReasonTime = 0

    self.mTxtGetReason.text = self.mNewReason - self.mOldReason 
    self.mTxtGetReason.color = self.mNewReason - self.mOldReason  >= 0 and gs.ColorUtil.GetColor("18ec68ff") or gs.ColorUtil.GetColor("fa3a2bff")

    self.reasonSn = LoopManager:addFrame(0, 0, self, self.onLoopReasonEvent)
end

function onLoopReasonEvent(self)
    self.mCurrentReasonTime = self.mCurrentReasonTime + gs.Time.deltaTime
    if self.mCurrentReasonTime <= self.mReasonTime then
        self.mTxtCurrentReason.text = self.mOldReason + math.floor(self.mCurrentReasonTime /self.mReasonTime * (self.mNewReason - self.mOldReason)) .. "/" .. self.mReasonPointLimit
        --self.mTxtGetReason.text = math.floor(self.mCurrentReasonTime / self.mReasonTime *  (self.mNewReason - self.mOldReason))
    else
       self:reasonEndCall()
    end
end

function reasonEndCall(self)
    self.mTxtCurrentReason.text = self.mNewReason .. "/" .. self.mReasonPointLimit
    --self.mTxtGetReason.text = "0"
    --self.m_childGos["mTxt_02"]:SetActive(false)

    if self.reasonSn then
        LoopManager:removeFrameByIndex(self.reasonSn)
        self.reasonSn = nil
    end
  
    self.mHopeTime = 1
    self.mCurrentHopeTime = 0
    self.mTexGroup3:SetActive(true)

    self.mTxtGetHope.text = self.mNewHope - self.mOldHope 
    --self.mTxtGetHope.color = self.mNewHope - self.mOldHope  >= 0 and gs.ColorUtil.GetColor("fa3a2bff") or gs.ColorUtil.GetColor("18ec68ff")

    self.hopeSn = LoopManager:addFrame(0,0,self,self.onLoopHopeEvent)
end

function onLoopHopeEvent(self)
    self.mCurrentHopeTime = self.mCurrentHopeTime + gs.Time.deltaTime
    if self.mCurrentHopeTime <= self.mHopeTime then
        self.mTxtCurrentHope.text = self.mOldHope + math.floor(self.mCurrentHopeTime/self.mHopeTime * (self.mNewHope - self.mOldHope))
       
    else
        --self.m_childGos["mTxt_03"]:SetActive(false)
        self.mTxtCurrentHope.text = self.mNewHope
    
        if self.hopeSn then
            LoopManager:removeFrameByIndex(self.hopeSn)
            self.hopeSn = nil
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
