
--[[ SetActive
-----------------------------------------------------
@filename       : ActivityPromoView5
@Description      二周年超级礼物 拍脸
@Author         : sxt
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('marriage.MarriageUseView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("marriage/MarriageUseView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    self.mPropsItemList = {}
end

function configUI(self)
    super.configUI(self)

    self.mTxtPropsName = self:getChildGO("mTxtPropsName"):GetComponent(ty.Text)
    self.mTxtHasCount = self:getChildGO("mTxtHasCount"):GetComponent(ty.Text)
    self.mTxtUseCount = self:getChildGO("mTxtUseCount"):GetComponent(ty.Text)

    self.mTxtTips1 = self:getChildGO("mTxtTips1"):GetComponent(ty.Text)
    self.mTxtTips2 = self:getChildGO("mTxtTips2"):GetComponent(ty.Text)
    self.mTxtTips3 = self:getChildGO("mTxtTips3"):GetComponent(ty.Text)
    self.mTxtLvCur = self:getChildGO("mTxtLvCur"):GetComponent(ty.Text)
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mBtnReject = self:getChildGO("mBtnReject")
    self.mBtnAgree = self:getChildGO("mBtnAgree")

    self.mPropsContent = self:getChildTrans("mPropsContent")

    self.mBtnCost = self:getChildGO("mBtnCost")
end

function active(self,args)
    super.active(self)
    self.heroId = args.heroId
    self:showPanel()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:closePropsList()
end

function initViewText(self)
    self.mTxtTips1.text = _TT(152012)
    self.mTxtTips2.text = _TT(152013)
    self.mTxtTips3.text = _TT(152014) 

    self.mTxtLvCur.text = sysParam.SysParamManager:getValue(SysParamType.MAX_FAVORABLE_LV)
    self.mTxtLv.text = sysParam.SysParamManager:getValue(SysParamType.MARRIAGE_MAX_LV)

    self:setBtnLabel(self.mBtnReject, 2, "")
    self:setBtnLabel(self.mBtnAgree, 10000115, "")
    --self.mTxtPropsName.text = "誓约奖励"
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnReject,self.close)
    self:addUIEvent(self.mBtnAgree,self.onAgreeClickHandler)
    self:addUIEvent(self.mBtnCost,function ()
        local propsTid = sysParam.SysParamManager:getValue(SysParamType.MARRIAGE_PROPS_TID)
        local propsVo = props.PropsManager:getTypePropsVoByTid(propsTid)
        TipsFactory:propsTips({propsVo = propsVo})
    end)
end

function onAgreeClickHandler(self)
    --hero.HeroManager:get
    --local heroVo = hero.HeroManager:getHeroVo(self.heroId)
    local propsTid = sysParam.SysParamManager:getValue(SysParamType.MARRIAGE_PROPS_TID)
    local hasCount = MoneyUtil.getMoneyCountByTid(propsTid)

    if hasCount > 0 then
       
        GameDispatcher:dispatchEvent(EventName.OPEN_MARRIAGE_INFO_VIEW,{heroId = self.heroId,isFirst = true})
        self:close()
        --GameDispatcher:dispatchEvent(EventName.REQ_MARRIAGE_HERO,{heroId = self.heroId})
    else
        local propsVo = props.PropsManager:getTypePropsVoByTid(propsTid)
        TipsFactory:propsTips({propsVo = propsVo})
        local isEnought, tips =MoneyUtil.judgeNeedMoneyCountByTid(propsTid, 1, true,true)
        gs.Message.Show(tips)
        --GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = LinkCode.ShopLimitSupply })
        --self:close()
    end
end

function showPanel(self)
    local propsTid = sysParam.SysParamManager:getValue(SysParamType.MARRIAGE_PROPS_TID)
    local awardList = sysParam.SysParamManager:getValue(SysParamType.MARRIAGE_AWARD_LIST)

    self.mTxtPropsName.text = props.PropsManager:getPropsConfigVo(propsTid):getName()
    local hasCount = MoneyUtil.getMoneyCountByTid(propsTid)

    self.mTxtHasCount.text = _TT(152020,hasCount)
    self:closePropsList()
    for i = 1, #awardList, 1 do
        local vo = props.PropsManager:getTypePropsVoByTid(awardList[i][1])
        local count = awardList[i][2]

        local propsGrid = PropsGrid:createByData({
            tid = awardList[i][1],
            num = awardList[i][2],
            parent = self.mPropsContent,
            scale = 0.5,
            showUseInTip = true
        })
        table.insert(self.mPropsItemList, propsGrid)
    end

end

function closePropsList(self)
    if #self.mPropsItemList > 0 then
        for _, item in ipairs(self.mPropsItemList) do
            item:poolRecover()
            item = nil
        end
        self.mPropsItemList = {}
    end
end

return _M