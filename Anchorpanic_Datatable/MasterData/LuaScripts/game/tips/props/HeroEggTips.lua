module("tips.HeroEggTips", Class.impl(tips.PropsTips))

UIRes = UrlManager:getUIPrefabPath("tips/HeroEggTips.prefab")

-- 初始化UI
function configUI(self)
    super.configUI(self)
    self.mTxtHeroEggGet = self:getChildGO("mTxtHeroEggGet"):GetComponent(ty.Text)

    self.mBtnHeroEggPro = self:getChildGO("mBtnHeroEggPro")
    self.mTxtHeroEggPro = self:getChildGO("mTxtHeroEggPro"):GetComponent(ty.Text)
    self.mProScroll = self:getChildGO("mProScroll"):GetComponent(ty.ScrollRect)
    self.mEggScroll = self:getChildGO("mEggScroll"):GetComponent(ty.ScrollRect)
end

function initViewText(self)
    super.initViewText(self)
    self.mTxtHeroEggGet.text = _TT(149923)
    self.mTxtHeroEggPro.text = _TT(149924)
end
function addAllUIEvent(self)
    super.addAllUIEvent(self)   
    self:addUIEvent(self.m_childGos["mBtnGet"], self.onGetBtnClick)
    self:addUIEvent(self.m_childGos["mBtnInfo"], self.onInfotBtnClick)
    self:addUIEvent(self.mBtnHeroEggPro, self.onOpenHeroEggProClick)
end

function onOpenHeroEggProClick(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_USE_HEROEGG_PRO_VIEW,{tid = self.m_propsVo.tid})
end

function __updateTop(self)
    self.mTxtName = self.m_childGos["TextName"]:GetComponent(ty.Text)
    self.m_textTime = self.m_childGos["TextTime"]:GetComponent(ty.Text)
    -- 非限时道具
    if (not self.m_propsVo.expiredTime or self.m_propsVo.expiredTime <= 0) then
        self.mTxtName.text = self.m_propsVo:getName()
        self.m_textTime.gameObject:SetActive(false)
    else
        self.m_textTime.gameObject:SetActive(true)
        self:__updateTickTime()
        self.m_loopSn = LoopManager:addTimer(1, 0, self, self.__updateTickTime)

        local _recover = self.recover
        self.recover = function()
            _recover(self)
            if (self.m_loopSn) then
                LoopManager:removeTimerByIndex(self.m_loopSn)
                self.m_loopSn = nil
            end
        end
    end

    local imgIcon = self.m_childGos["ImgIcon"]:GetComponent(ty.AutoRefImage)
    if self.m_propsVo.type == 4 and self.m_propsVo.subType == 3 then
        imgIcon.enabled = false
        -- 头像框
        if not self.mHeadFrameGrid then
            self.mHeadFrameGrid = PlayerHeadFrameGrid:poolGet()
        end
        self.mHeadFrameGrid:setData(self.m_propsVo.tid, self.m_childTrans["ImgIcon"])
        self.mHeadFrameGrid:showEnterAnim()
    else
        imgIcon.enabled = true
        -- local imgIconMiniNode = self.m_childGos["ImgIconMiniNode"]
        -- local imgIconMini = self.m_childGos["ImgIconMini"]:GetComponent(ty.AutoRefImage)
        -- if (self.m_propsVo.type == 1 and self.m_propsVo.subType == 2) then        --战员时装类型 (不知道是啥东西，影响到使用，屏蔽了先)
        --     imgIconMini:SetImg(UrlManager:getPropsIconUrl(self.m_propsVo.tid), false)
        --     imgIconMiniNode.gameObject:SetActive(true)
        --     imgIcon.gameObject:SetActive(false)
        -- else
        imgIcon:SetImg(UrlManager:getPropsIconUrl(self.m_propsVo.tid), false)
        -- imgIcon.gameObject:SetActive(true)
        -- imgIconMiniNode.gameObject:SetActive(false)
        -- end
    end

   
    self.m_childGos["ImgColorBg"]:GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor(ColorUtil:getPropBgColor(self.m_propsVo.color))
    self.m_childGos["mTxt"]:GetComponent(ty.Text).text = _TT(1207)
    local count = MoneyUtil.getMoneyCountByTid(self.m_propsVo.tid)
    local isShowText = (table.keyof(PROPS_HIDE_TID_LIST, self.m_propsVo.tid) or (self.m_propsVo.type == PropsType.DECORATE) or (self.m_propsVo.type == PropsType.FASHIONPERMIT))
    isShowText = not isShowText
    self.m_childGos["TextCount"]:SetActive(isShowText)
    -- if count ~= -1 then
    --     if count == 0 then
    --         self.m_childGos["TextCount"]:GetComponent(ty.Text).text = count.."/"..self.m_propsVo.effectList[1]
    --     else
    --         self.m_childGos["TextCount"]:GetComponent(ty.Text).text = count .. "/"..self.m_propsVo.effectList[1] * self.mNumberStepper.CurrCount
    --     end
    -- end
    
    self.m_childTrans["TextDes"]:GetComponent(ty.Text).text = self.m_propsVo:getDes()
    self:updateUseCount()
    --self.mNumberStepper:Init(1, 1, self.m_propsVo.effectList[1], -1, self.onStepChange, self)
end

function updateUseCount(self)
    local count = MoneyUtil.getMoneyCountByTid(self.m_propsVo.tid)
    self.m_childGos["TextCount"]:GetComponent(ty.Text).text =  count.. "/" .. self.m_propsVo.effectList[1] * self.mNumberStepper.CurrCount
end

function __updateBottom(self)
    local isShowUseBtn = false
    local isShowLookBtn = self.m_propsVo.effectType == UseEffectType.ADD_FREE_PROPGIFT or self.m_propsVo.effectType == UseEffectType.ADD_FREE_HEROGIFT
    local maxCount = bag.BagManager:getPropsCountByTid(self.m_propsVo.tid)
    local needCount = self.m_propsVo.effectList[1] 
    self.mNumberStepper.CurrCount = 1
    if isShowLookBtn then
        isShowUseBtn = true
    else
        if self.m_propsVo.id ~= nil and self.m_propsVo.id ~= 0 then
            
            local isHas = maxCount > 0
            local isCanUse = self.m_propsVo.isCanUse
          

            self.mNumberStepper.gameObject:SetActive(self.m_propsVo.isCanBatchUse ~= 0 and self.m_isShowUseBtn and maxCount>=needCount)
            if (isHas and isCanUse and self.m_isShowUseBtn) then
                self.mNumberStepper.CurrCount = 1
                self.mNumberStepper.MaxCount = maxCount
                isShowUseBtn = true
            end
        end
    end

    self:updateUseCount()
    local btnUse = self.m_childGos["BtnUse"]
    if isShowUseBtn then
        btnUse:SetActive(true)
        self:addUIEvent(btnUse, self.__onOpenUseViewHandler)
    else
        btnUse:SetActive(false)
    end
end

-- 打开使用界面
function __onOpenUseViewHandler(self, args)
    if (subPack.SubDownLoadController:checkPropUseDownLoadState()) then
        return
    end
    if self.m_propsVo.effectType == UseEffectType.USE_GET_HEROEGG then
        local maxCount = bag.BagManager:getPropsCountByTid(self.m_propsVo.tid)
        local needCount = self.m_propsVo.effectList[1] 
        if maxCount >= needCount then
            GameDispatcher:dispatchEvent(EventName.USE_PROPS_BY_TID, {tid = self.m_propsVo.tid, count = self.mNumberStepper.CurrCount *needCount , targetId = 0, uicode = self.m_propsVo.uiCode, use_args = {}})
            bag.BagManager:setIsOpenEggProps(true)
            self:close()
        else
            gs.Message.Show("至少需要"..self.m_propsVo.effectList[1].."个道具才能开启")
        end
      
    end
end

function onStepChange(self, cusCount, cusType)
    local maxCount = bag.BagManager:getPropsCountByTid(self.m_propsVo.tid)
    if cusCount < 1 then
        gs.Message.Show(_TT(4019))
        self.mNumberStepper.CurrCount = 1
        cusCount = 1
    else
        if cusCount > maxCount / self.m_propsVo.effectList[1]  then
            gs.Message.Show(_TT(4018))
            cusCount = maxCount / self.m_propsVo.effectList[1]
            self.mNumberStepper.CurrCount = maxCount / self.m_propsVo.effectList[1]
        end
    end
    self:updateUseCount()
end

function __updateView(self)
    super.__updateView(self)
    --self.mPropsItems = {}
    self:updateHeroEggInfo()
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.mPropsItems = {}
end

function updateHeroEggInfo(self)
    self:clearItemList()
    local ruleVo = props.PropsManager:getItemRuleDataByTid(self.m_propsVo.tid)
    local allItem = {}
    for k, vo in pairs(ruleVo.ruleDic) do
        for i = 1, #vo.itemList do
            table.insert(allItem, vo.itemList[i])
        end
    end

    --目前界面只有dna蛋用到 后续有其他用途再做优化
        -- for i = 1,#allItem do
        --     local eggCfgVo = dna.DnaManager:getSingleEggDataCfgVoByItemId(allItem[i])
        --     if eggCfgVo then
        --         local item = dna.DnaEggGridItem:create(self.mEggScroll.content, eggCfgVo, 1, false)
        --         table.insert(self.mPropsItems, item)
        --     end
        -- end
    --又说改回去用道具的
        for i = 1,#allItem do
            local propsGrid = PropsGrid:createByData({
                tid = allItem[i],
                num = 1,
                parent = self.mProScroll.content,
                scale = 0.7,
                showUseInTip = true
            })
            table.insert(self.mPropsItems, propsGrid)
        end
end

function clearItemList(self)
    for i = 1, #self.mPropsItems, 1 do
        self.mPropsItems[i]:poolRecover()
    end
    self.mPropsItems = {}
end

function deActive(self)
    super.deActive(self)
    self:clearItemList()
end

return _M