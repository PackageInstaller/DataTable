--[[ SetActive
-----------------------------------------------------
@filename       : ActivityCarnivalGift
@Description      狂欢好礼
@date           : 2024-09-10 
@Author         : Shuai
@copyright      : (LY) 2024 雷焰网络
-----------------------------------------------------
]]
module('game.activity.view.ActivityCarnivalGift', Class.impl(TabSubView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("activity/ActivityCarnivalGift.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1-- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.mTime = nil
    self.mNumitemList = {}
    self.mFrame = nil
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mItem = self:getChildGO("mItem")
    self.mBtnShow = self:getChildGO("mBtnShow")
    self.mContent = self:getChildTrans("mContent")
    self.mBtnRecharge = self:getChildGO("mBtnRecharge")
    self.mMoneyNumItem = self:getChildGO("mMoneyNumItem")
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtTitle_2 = self:getChildGO("mTxtTitle_2"):GetComponent(ty.Text)
    self.mTxtTitle_3 = self:getChildGO("mTxtTitle_3"):GetComponent(ty.Text)
    self.mTxtTitle_4 = self:getChildGO("mTxtTitle_4"):GetComponent(ty.Text)
    self.mTxtActivityTime = self:getChildGO("mTxtActivityTime"):GetComponent(ty.Text)
    self.mImgHeroHar = self:getChildGO("mImgHeroHar"):GetComponent(ty.AutoRefImage)
    self.mBtnEveryDayGift = self:getChildGO("mBtnEveryDayGift")
    self.mBtnEveryDayGiftTf = self:getChildTrans("mBtnEveryDayGift")
    self.mImgGotEveryDayGiftMask = self:getChildGO("mImgGotEveryDayGiftMask")

    self.mBtnHis = self:getChildGO("mBtnHis")
end

--激活
function active(self)
    super.active(self)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_CARNIVAL_GIFT_INFO, self.updateView, self)
    GameDispatcher:addEventListener(EventName.UPDATE_ACTIVITY_RED, self.updateView, self)
    self:updateView(true)
    self:uidoTween()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_CARNIVAL_GIFT_INFO, self.updateView, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_ACTIVITY_RED, self.updateView, self)
    self:clearAllItem()
    self:clearFameHanlder()
    RedPointManager:remove(self.mBtnEveryDayGiftTf)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtTitle.text = _TT(138502)
    self.mTxtTitle_2.text = _TT(138503)
    self.mTxtTitle_3.text = _TT(98107) 
    self.mTxtTitle_4.text = _TT(138504)
    self:setBtnLabel(self.mBtnRecharge,138505,"")
    self:setBtnLabel(self.mBtnHis,138508,"")
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnShow,self.onClickShowHandle)
    self:addUIEvent(self.mBtnRecharge,self.onClickHandle)
    self:addUIEvent(self.mBtnEveryDayGift, self.onClickBtnEveryDayGiftHandler)
    self:addUIEvent(self.mBtnHis, self.onClickBtnHisHandler)
end

function onClickBtnHisHandler(self)
    local prefixVersion =
    download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.PrefixVersionKey)

    local isShow = StorageUtil:getBool1(prefixVersion .. "hisFashionHisBuy") == true 
    if not isShow then
        StorageUtil:saveBool1(prefixVersion .. "hisFashionHisBuy", true)
        GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
        --RedPointManager:remove(self.mBtnHis.transform)
    end

    GameDispatcher:dispatchEvent(EventName.OPEN_ACTIVITY_FASHION_HIS_VIEW,{type = activity.FashionHisType.CarnivalGift})
end

-- 更新 View 界面
function updateView(self,isFirst)
   self:clearAllItem()
   self:addTime()
   self.mBtnRecharge:SetActive(not activity.ActitvityExtraManager:getIsCarnivalRecharge()) 
   local list = activity.ActitvityExtraManager:getCarnivalGiftConfigList()
   for i, vo in ipairs(list) do
        local numItem = SimpleInsItem:create(self.mItem, self.mContent, "CarnivalDay"..vo:getId())
        numItem:getChildGO("mCanRec"):SetActive(vo:getIsCanRec())
        numItem:addUIEvent("mCanRec",function ()
            if vo:getIsRecived() then
                return 
            end
            if not activity.ActitvityExtraManager:getIsCarnivalRecharge() then
                gs.Message.Show(_TT(138506))
                return
            end
            GameDispatcher:dispatchEvent(EventName.REQ_REC_CARNIVAL_GIFT_AWARD,vo:getId())
        end)
        numItem:getChildGO("mReceived"):SetActive(vo:getIsRecived())
        numItem:getChildGO("mImgDay"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("activity/Carnival_"..vo:getId()..".png"),true)
        numItem:getChildGO("mIconItem"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPropsIconUrl(vo:getAwardList()[1].tid),true)
        numItem:getChildGO("GridNodeEff"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPropsIconUrl(vo:getAwardList()[1].tid),true)
        numItem:addUIEvent("mIconItem",function ()
            if not vo:getIsCanRec() or vo:getIsRecived() or not activity.ActitvityExtraManager:getIsCarnivalRecharge() then
                TipsFactory:propsTips({ propsVo = props.PropsManager:getPropsConfigVo(vo:getAwardList()[1].tid) }, { rectTransform = nil })
            else
                GameDispatcher:dispatchEvent(EventName.REQ_REC_CARNIVAL_GIFT_AWARD,vo:getId())
            end
        end)
        numItem:getChildGO("mTxtNum"):GetComponent(ty.Text).text = vo:getAwardList()[1].num
        if isFirst then
            numItem:getGo():SetActive(false)
        else
            numItem:getGo():SetActive(true)
        end
        table.insert(self.mNumitemList, numItem)
   end

   --更新每日奖励可领取状态
    local isCanGetEveryDayRewardState = activity.ActitvityExtraManager:getCarnivalIsCanGetEveryDayRewardState()
    self.mImgGotEveryDayGiftMask:SetActive(not isCanGetEveryDayRewardState)
    if isCanGetEveryDayRewardState then
        RedPointManager:add(self.mBtnEveryDayGiftTf, nil, 25, 20)
    else
        RedPointManager:remove(self.mBtnEveryDayGiftTf)
    end

    local isFashionRed = activity.ActitvityExtraManager:getFashionRedInfo()
    if isFashionRed then
        RedPointManager:add(self.mBtnHis.transform, nil, 62.3, 13.6)
    else
        RedPointManager:remove(self.mBtnHis.transform)
    end

    local dic = sysParam.SysParamManager:getValue(SysParamType.ACTIVITY_CARIVAL_GIFT_SHOW_HERO_INFO)
    -- 部分渠道需要特殊处理
    local isHar = (RefMgr:getSpecialConfig() and sdk.SdkManager:getIsChannelHarmonious())
    self.mImgHeroHar.gameObject:SetActive(isHar)
    self:getChildGO("Spine"):SetActive(not isHar)
    local fashionData = fashion.FashionManager:getHeroFashionConfigVo(fashion.Type.CLOTHES, dic[1], dic[2])
    self.mImgHeroHar:SetImg(UrlManager:getBgPath("heroRecord_Har/" .. fashionData:getUrlBody()))
end

function uidoTween(self)
    local curIndex=0
    self:clearFameHanlder()
    self.mFrame = LoopManager:addFrame(1, 9, self, function ()
        curIndex = curIndex+1
        if curIndex>=6 and curIndex<=9 then
            if #self.mNumitemList>0 then
                if curIndex>=6 then
                    local tween = self.mNumitemList[curIndex-5]:getGo():GetComponent(ty.UIDoTween)
                    if not gs.GoUtil.IsCompNull(tween) then
                        self.mNumitemList[curIndex-5]:getGo():SetActive(true)
                        tween:BeginTween()
                    end
                end
                if curIndex>=7 then
                    local tween = self.mNumitemList[curIndex-3]:getGo():GetComponent(ty.UIDoTween)
                    if not gs.GoUtil.IsCompNull(tween) then
                        self.mNumitemList[curIndex-3]:getGo():SetActive(true)
                        tween:BeginTween()
                    end
                end
            end
        end 
    end )
end

function clearFameHanlder(self)
    if self.mFrame then
        LoopManager:removeFrameByIndex(self.mFrame)
        self.mFrame = nil
    end
end

function clearAllItem(self)
    if #self.mNumitemList>0 then
        for i, item in ipairs(self.mNumitemList) do
            item:poolRecover()
        end
        self.mNumitemList={}
    end
    if self.mTime then
        LoopManager:removeTimerByIndex(self.mTime)
        self.mTime=nil
    end
end

function addTime(self)
    self:updateTime()
    self.mTime= LoopManager:addTimer(1,0,self,self.updateTime)
end

function updateTime(self)
    if activity.ActivityManager:getActivityVoById(activity.ActivityId.Activity_Carnival_Gift) then
        local RemainingTime =activity.ActivityManager:getActivityVoById(activity.ActivityId.Activity_Carnival_Gift):getEndTime() - GameManager:getClientTime()
        self.mTxtActivityTime.text=_TT(94557).. HtmlUtil:color(TimeUtil.getFormatTimeBySeconds_9(RemainingTime),"000000ff") 
    end
end

function onClickHandle(self)
    if not activity.ActitvityExtraManager:getIsCarnivalRecharge() then--CARNIVAL_GIFT
        recharge.sendRecharge(recharge.RechargeType.CARNIVAL_GIFT, nil, "1")
    end
end
function onClickShowHandle(self)
    local dic = sysParam.SysParamManager:getValue(SysParamType.ACTIVITY_CARIVAL_GIFT_SHOW_HERO_INFO)
    local tid = dic[1]
    local id = dic[2]
    GameDispatcher:dispatchEvent(EventName.OPEN_SKIN_SHOW_ONE_VIEW, {heroTid = tid, fashionId = id, isShow3D = true})
end

function onClickBtnEveryDayGiftHandler(self)
    --判断已领取
    if not activity.ActitvityExtraManager:getCarnivalIsCanGetEveryDayRewardState() then
        return
    end
    GameDispatcher:dispatchEvent(EventName.REQ_GET_ACTIVITY_DAILY_REWARD, {activity_id = activity.ActivityId.Activity_Carnival_Gift})
end

return _M