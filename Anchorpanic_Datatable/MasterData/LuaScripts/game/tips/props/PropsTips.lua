module("tips.PropsTips", Class.impl(tips.BaseTips))

UIRes = UrlManager:getUIPrefabPath("tips/PropsTipsNew.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
destroyTime = -1 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 0 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAdapta = 0 -- 是否开启适配刘海 0 否 1 是
-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1120, 520)
end

-- 析构函数
function dtor(self)
    super.dtor(self)
end

-- 初始化UI
function configUI(self)
    super.configUI(self)
    self.mClose = self:getChildGO("mBtnClose")
    self.mGroupGet = self:getChildGO("mGroupGet")
    self.mGroupUse = self:getChildGO("mGroupUse")
    self.mGroupSuit = self:getChildGO("mGroupSuit")
    self.mSuitTrans = self:getChildTrans("mSuitTrans")
    self.mGroupStamina = self:getChildGO("mGroupStamina")
    self.mTxtTimeOne = self:getChildGO("mTxtTimeOne"):GetComponent(ty.Text)
    self.mTxtTimeAll = self:getChildGO("mTxtTimeAll"):GetComponent(ty.Text)
    self.mTxtSuitTitle = self:getChildGO("mTxtSuitTitle"):GetComponent(ty.Text)
    self.mTxtTimeOneLab = self:getChildGO("mTxtTimeOneLab"):GetComponent(ty.Text)
    self.mTxtTimeAllLab = self:getChildGO("mTxtTimeAllLab"):GetComponent(ty.Text)
    self.mNumberStepper = self:getChildGO("mNumberStepper"):GetComponent(ty.LyNumberStepper)
    self.mNumberStepper:Init(1, 1, 1, -1, self.onStepChange, self)

end

function onStepChange(self, cusCount, cusType)
    if cusType == 1 then
        gs.Message.Show(_TT(4018))
    elseif cusType == 2 then
        gs.Message.Show(_TT(4019))
    end
end

function active(self, args)
    super.active(self, args)
    if (self.base_childGos["gImgBg2"]) then
        self.base_childGos["gImgBg2"]:SetActive(true)
    end
    self.m_propsVo = args.data.propsVo
    self.m_isShowLink = args.data.isShowLink
    self.m_isShowUseBtn = args.data.isShowUseBtn

    local uiCodeList = self.m_propsVo.uiCodeList
    if (#uiCodeList <= 0) then
        self.m_childGos["mBtnGet"]:SetActive(false)
    end

    self:__tempAction(args.clickPos)
    self:__updateView()
end

function deActive(self)
    super.deActive(self)
    self:recoverStaminaTime()
    if self.timeId ~= nil then
        LoopManager:removeTimerByIndex(self.timeId)
    end

    if self.mHeadFrameGrid then
        self.mHeadFrameGrid:poolRecover()
        self.mHeadFrameGrid = nil
    end
    if (self.m_loopSn) then
        LoopManager:removeTimerByIndex(self.m_loopSn)
        self.m_loopSn = nil
    end
end

-- 初始化数据
function initData(self)
    -- 清理链接按钮字典
    self:__recoverBtnPool()
    self.m_isShowLink = true
    self.m_isShowUseBtn = false
    self.m_propsVo = nil
    self.m_instance = nil
    -- Scroller在存在使用按钮时，高度设置为346否则高度设置为435
    self.mScrollerMaxHeight = 465
    self.mScrollerMinHeight = 394
    self.mSuitItemList = {}
end

--[[    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.m_childGos["TextLinkTitle"]:GetComponent(ty.Text).text = _TT(25020) -- "获取途径"
    self.m_childGos["mTxtUseLinkTitle"]:GetComponent(ty.Text).text = _TT(4068) -- "使用途径"
    self.mTxtTimeOneLab.text = _TT(1208) -- "恢复1ml"
    self.mTxtTimeAllLab.text = _TT(1209) -- "恢复全部"
    self.mTxtSuitTitle.text = _TT(1316)--套装属性

    self:setBtnLabel(self.m_childGos["mBtnGet"], 25018, "获取")
    self:setBtnLabel(self.m_childGos["mBtnInfo"], 25027, "详情")
    self:setBtnLabel(self.m_childGos["mBtnInfo"], 25027, "详情")
    self:setBtnLabel(self.m_childGos["mBtnFashionShow"], 50093, "预览")

    if self.m_propsVo.id == nil or self.m_propsVo.id == 0 then
        self:setBtnLabel(self.m_childGos["BtnUse"], 165, "查看")
    else
        self:setBtnLabel(self.m_childGos["BtnUse"], 4029, "使用")
    end
end

function addAllUIEvent(self)
    self:addUIEvent(self.m_childGos["mBtnGet"], self.onGetBtnClick)
    self:addUIEvent(self.m_childGos["mBtnInfo"], self.onInfotBtnClick)
    self:addUIEvent(self.m_childGos["mBtnFashionShow"], self.onFashionShowBtnClick)
    self:addUIEvent(self.mClose, self.onCloseHandler)
end

function onGetBtnClick(self)
    self.mGroupUse:SetActive(false)
    self.mGroupGet:SetActive(true)
end

function onInfotBtnClick(self)
    self.mGroupUse:SetActive(true)
    self.mGroupGet:SetActive(false)
end

function onFashionShowBtnClick(self)
    local heroTid = self.m_propsVo.effectList[1]
    local fashionId = self.m_propsVo.effectList[2]
    self:onCloseHandler()
    GameDispatcher:dispatchEvent(EventName.OPEN_SKIN_SHOW_ONE_VIEW, {
        heroTid = heroTid,
        fashionId = fashionId,
        isShow3D = true
    })
end

function onCloseHandler(self)
    self:close()
end

function __getGoUniqueName(self, goName)
    return self.__cname .. "_" .. goName
end

function __recoverBtnPool(self)
    if (self.m_btnGoList) then
        for _, btnItem in pairs(self.m_btnGoList) do
            btnItem:poolRecover()
        end
    end
    self.m_btnGoList = {}
end

function __updateView(self)
    self:__recoverBtnPool()
    self:__updateTop()

    self.m_childGos["BtnUse"]:SetActive(false)
    self.mNumberStepper.gameObject:SetActive(false)
    local groupLink = self.m_childGos["mGetGroupLink"]
    groupLink:SetActive(false)
    local useGroupLink = self.m_childGos["mUseGroupLink"]
    useGroupLink:SetActive(false)
    self:__updateBottom()
    self:__updateGetInfo()
    self:__updateUseLinkInfo()

    self.mGroupStamina:SetActive(false)
    if self.m_propsVo.tid == MoneyTid.ANTIEPIDEMIC_SERUM_TID then
        self.mGroupStamina:SetActive(true)
        self.refreshTime = stamina.StaminaManager:nextAddTime()
        self.refreshAllTime = stamina.StaminaManager:allAddTime()
        self:updateStaminatime()
        self:recoverStaminaTime()
        self.timeId = LoopManager:addTimer(1, 0, self, self.updateStaminatime)
    end
    if self.mNumberStepper.gameObject.activeSelf == true then
        gs.TransQuick:SizeDelta02(self:getChildTrans("Scroller"), self.mScrollerMinHeight)
    else
        gs.TransQuick:SizeDelta02(self:getChildTrans("Scroller"), self.mScrollerMaxHeight)
    end
    -- if self.m_propsVo.tid == MoneyTid.ROGUELIKE_TID or self.m_propsVo.tid == MoneyTid.ACTIVITY then
    --     self.m_childGos["mImg"]:SetActive(false)
    -- else
    --     self.m_childGos["mImg"]:SetActive(true)
    -- end
    self:updateSuit(self.m_propsVo)
end

-- 更新有效期倒计时
function __updateTickTime(self)
    local cdTime = self.m_propsVo.expiredTime - GameManager:getClientTime()
    if (cdTime <= 0) then
        -- 已过期
        self.mTxtName.text = self.m_propsVo:getName()
        self.m_textTime.text = _TT(4027) -- "已过期"
        if (self.m_loopSn) then
            LoopManager:removeTimerByIndex(self.m_loopSn)
            self.m_loopSn = nil
        end
    else
        -- 未过期
        local timeStr = TimeUtil.getFormatTimeBySeconds_1(cdTime)
        self.mTxtName.text = self.m_propsVo:getName()
        self.m_textTime.text = timeStr .. _TT(121193)
    end
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

    --self.m_childGos["ImgColor"]:GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor(ColorUtil:getPropColor(self.m_propsVo.color))
    self.m_childGos["ImgColorBg"]:GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor(ColorUtil:getPropBgColor(self.m_propsVo.color))
    self.m_childGos["mTxt"]:GetComponent(ty.Text).text = _TT(25019)
    local count = MoneyUtil.getMoneyCountByTid(self.m_propsVo.tid)
    local isShowText = (table.keyof(PROPS_HIDE_TID_LIST, self.m_propsVo.tid) or (self.m_propsVo.type == PropsType.DECORATE) or (self.m_propsVo.type == PropsType.FASHIONPERMIT))
    isShowText = not isShowText
    self.m_childGos["TextCount"]:SetActive(isShowText)
    if count ~= -1 then
        if count == 0 then
            self.m_childGos["TextCount"]:GetComponent(ty.Text).text = count
        else
            self.m_childGos["TextCount"]:GetComponent(ty.Text).text = "x" .. count
        end
    end
    self.m_childTrans["TextDes"]:GetComponent(ty.Text).text = self.m_propsVo:getDes()
end

function __updateBottom(self)
    local isShowUseBtn = false
    local isShowLookBtn = self.m_propsVo.effectType == UseEffectType.ADD_FREE_PROPGIFT or self.m_propsVo.effectType == UseEffectType.ADD_FREE_HEROGIFT
    if isShowLookBtn then
        isShowUseBtn = true
    else
        if self.m_propsVo.id ~= nil and self.m_propsVo.id ~= 0 then
            local maxCount = bag.BagManager:getPropsCountByTid(self.m_propsVo.tid)
            local limCount = sysParam.SysParamManager:getValue(SysParamType.MAX_USE_PROPS_COUNT)
            maxCount = math.min(limCount, maxCount)
            local isHas = maxCount > 0
            local isCanUse = self.m_propsVo.isCanUse
            self.mNumberStepper.gameObject:SetActive(self.m_propsVo.isCanBatchUse ~= 0 and self.m_isShowUseBtn)
            if (isHas and isCanUse and self.m_isShowUseBtn) then
                self.mNumberStepper.CurrCount = 1
                self.mNumberStepper.MaxCount = maxCount
                isShowUseBtn = true
            end
        end
    end

    local btnUse = self.m_childGos["BtnUse"]
    if isShowUseBtn then
        btnUse:SetActive(true)
        self:addUIEvent(btnUse, self.__onOpenUseViewHandler)
    else
        btnUse:SetActive(false)
    end

    self.m_childGos["mBtnFashionShow"]:SetActive(self.m_propsVo.type == PropsType.FASHIONPERMIT and self.m_propsVo.subType == 2) --皮肤
end

function __updateUseLinkInfo(self)
    local groupLink = self.m_childGos["mUseGroupLink"]
    local useUiCodeList = self.m_propsVo.useUiCodeList
    if (#useUiCodeList <= 0) then
        groupLink:SetActive(false)
    else
        local _show = false
        for i = 1, #useUiCodeList do
            local configVo = link.LinkManager:getLinkData(useUiCodeList[i])
            if configVo then
                local propConfigVo = props.PropsManager:getPropsConfigVo(self.m_propsVo.tid)
                local isOpen = funcopen.FuncOpenManager:isOpen(configVo.funcOpenId, false)
                local item = SimpleInsItem:create(self.m_childGos["mLinkItem"], groupLink.transform, self:__getGoUniqueName("mLinkItem"))
                local isMid, isCanTurn, tipsDes = dup.DupPotencyManager:getMaxStageIsOpen(configVo)
                if isMid then
                    item:getChildGO("GroupLinkLock"):SetActive(((not isOpen) or (not isCanTurn)))
                    item:getChildGO("GroupLinkUnLock"):SetActive(isOpen and isCanTurn)
                else
                    item:getChildGO("GroupLinkLock"):SetActive(not isOpen)
                    item:getChildGO("GroupLinkUnLock"):SetActive(isOpen)
                end
                local text = configVo:getLinkName2()
                if (configVo.linkName2 == 2915) then
                    text = _TT(2915, propConfigVo.mainCode[1], propConfigVo.mainCode[2])
                end
                item:getChildGO("TextLinkNameUnLock"):GetComponent(ty.Text).text = text
                item:getChildGO("TextLinkNameLock"):GetComponent(ty.Text).text = text
                item:getChildGO("TextLinkTip"):GetComponent(ty.Text).text = _TT(4062)
                item:getChildGO("Text"):GetComponent(ty.Text).text = _TT(configVo.code)
                local function _clickLinkFun()
                    if fight.FightManager:getIsFighting() or map.MapLoader.m_curMapType == MAP_TYPE.DORMITORY then
                        return
                    end
                    if isMid and (not isCanTurn) then
                        gs.Message.Show(tipsDes)
                        return
                    end
                    if (isOpen) then
                        self:close()
                        if (configVo.uiType == LinkUiType.FULL_SCREEN) then
                            gs.PopPanelManager.CloseAll()
                        end
                        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = configVo.linkId, param = self.m_propsVo.tid })
                    else
                        funcopen.FuncOpenManager:isOpen(configVo.funcOpenId, true)
                    end
                end
                if not fight.FightManager:getIsFighting() and map.MapLoader.m_curMapType == MAP_TYPE.MAIN_CITY then
                    item:getChildGO("mImgGotoBg"):SetActive(true)
                    item:addUIEvent("ImgClick", _clickLinkFun)
                else
                    item:getChildGO("mImgGotoBg"):SetActive(false)
                end
                table.insert(self.m_btnGoList, item)
                _show = true
            end
        end
        groupLink:SetActive(_show)
    end
end

function __updateGetInfo(self)
    local groupLink = self.m_childGos["mGetGroupLink"]
    local uiCodeList = self.m_propsVo.uiCodeList
    if (#uiCodeList <= 0) then
        groupLink:SetActive(false)
    else
        local _show = false
        for i = 1, #uiCodeList do
            local configVo = link.LinkManager:getLinkData(uiCodeList[i])
            if configVo then
                local propConfigVo = props.PropsManager:getPropsConfigVo(self.m_propsVo.tid)
                local isOpen = funcopen.FuncOpenManager:isOpen(configVo.funcOpenId, false)
                local item = SimpleInsItem:create(self.m_childGos["mLinkItem"], groupLink.transform, self:__getGoUniqueName("mLinkItem"))
                local isMid, isCanTurn, tipsDes = dup.DupPotencyManager:getMaxStageIsOpen(configVo)
                if isMid then
                    item:getChildGO("GroupLinkLock"):SetActive(((not isOpen) or (not isCanTurn)))
                    item:getChildGO("GroupLinkUnLock"):SetActive(isOpen and isCanTurn)
                else
                    item:getChildGO("GroupLinkLock"):SetActive(not isOpen)
                    item:getChildGO("GroupLinkUnLock"):SetActive(isOpen)
                end
                local text = configVo:getLinkName2()
                if (configVo.linkName2 == 2915) then
                    text = _TT(2915, propConfigVo.mainCode[1], propConfigVo.mainCode[2])
                end
                item:getChildGO("TextLinkNameUnLock"):GetComponent(ty.Text).text = text
                item:getChildGO("TextLinkNameLock"):GetComponent(ty.Text).text = text
                item:getChildGO("TextLinkTip"):GetComponent(ty.Text).text = _TT(4062)
                item:getChildGO("Text"):GetComponent(ty.Text).text = _TT(configVo.code)
                local function _clickLinkFun()
                    if fight.FightManager:getIsFighting() or map.MapLoader.m_curMapType == MAP_TYPE.DORMITORY then
                        return
                    end
                    if isMid and (not isCanTurn) then
                        gs.Message.Show(tipsDes)
                        return
                    end
                    if (isOpen) then
                        self:close()
                        if (configVo.uiType == LinkUiType.FULL_SCREEN) then
                            gs.PopPanelManager.CloseAll()
                        end
                        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = configVo.linkId, param = self.m_propsVo.tid })
                    else
                        funcopen.FuncOpenManager:isOpen(configVo.funcOpenId, true)
                    end
                end
                if not fight.FightManager:getIsFighting() and map.MapLoader.m_curMapType == MAP_TYPE.MAIN_CITY then
                    item:getChildGO("mImgGotoBg"):SetActive(true)
                    item:addUIEvent("ImgClick", _clickLinkFun)
                else
                    item:getChildGO("mImgGotoBg"):SetActive(false)
                end
                table.insert(self.m_btnGoList, item)
                _show = true
            end
        end
        groupLink:SetActive(_show)
    end
end

function updateStaminatime(self)
    local clientTime = GameManager:getClientTime()
    local time = self.refreshTime - clientTime
    local timeAll = self.refreshAllTime - clientTime
    if time <= 0 then
        self:recoverStaminaTime()
        self.mTxtTimeOne.text = _TT(26327)--"已达上限"
        self.mTxtTimeAll.text = _TT(26327)--"已达上限"
    else
        self.mTxtTimeOne.text = TimeUtil.getHMSByTime(time)
        self.mTxtTimeAll.text = TimeUtil.getHMSByTime(timeAll)
    end
end

--更新套装弹窗信息
function updateSuit(self, propsVo)
    if propsVo == nil then
        return
    end
    self:clearSuitItem()
    -- self.mGroupSuit:SetActive(propsVo.effectType == UseEffectType.ADD_CHIP_GIFT)
    if propsVo.effectType == UseEffectType.ADD_CHIP_GIFT then
        local tid = AwardPackManager:getAwardListById(propsVo.effectList[1])[1].tid
        local equipConfigVo = equip.EquipManager:getEquipConfigVo(tid)
        if equipConfigVo then
            local suitId = equipConfigVo and equipConfigVo.suitId or 0
            local suitConfigVo = equip.EquipSuitManager:getEquipSuitConfigVo(suitId)
            local suitList = {}
            if suitConfigVo then
                if suitConfigVo.suitSkillId_2 > 0 and suitConfigVo.suitSkillId_4 > 0 then
                    suitList[1] = suitConfigVo.suitSkillId_2
                    suitList[2] = suitConfigVo.suitSkillId_4
                elseif suitConfigVo.suitSkillId_4 > 0 then
                    suitList[1] = suitConfigVo.suitSkillId_4
                elseif suitConfigVo.suitSkillId_2 > 0 then
                    suitList[1] = suitConfigVo.suitSkillId_2
                end
                for i, vo in pairs(suitList) do
                    local skillVo = fight.SkillManager:getSkillRo(vo)
                    local introduceItem = SimpleInsItem:create(self:getChildGO("mSuitGroup"), self.mSuitTrans, "PropsTipsSuitGroup")
                    introduceItem:getChildGO("mTxtTitleSuit"):GetComponent(ty.Text).text = _TT(4036 + i)
                    introduceItem:getChildGO("mTxtSuitDes"):GetComponent(ty.Text).text = skillVo:getDesc()
                    table.insert(self.mSuitItemList, introduceItem)
                end
            end
        end
    end
end

function clearSuitItem(self)
    if #self.mSuitItemList > 0 then
        for i, _ in pairs(self.mSuitItemList) do
            self.mSuitItemList[i]:poolRecover()
        end
        self.mSuitItemList = {}
    end
end

-- 打开使用界面
function __onOpenUseViewHandler(self, args)
    if (subPack.SubDownLoadController:checkPropUseDownLoadState()) then
        return
    end
    if (self.m_propsVo.effectType == UseEffectType.ADD_PERMIT_EXPERT or self.m_propsVo.effectType == UseEffectType.ADD_PERMIT) and (not activity.ActivityManager:getActivityVoById(101)) then
        gs.Message.Show(_TT(81014))
        return
    elseif self.m_propsVo.effectType == UseEffectType.ADD_FREE_HEROGIFT then
        -- 针对自选角色的特殊处理方式
        GameDispatcher:dispatchEvent(EventName.OPEN_SELECTEDHEROVIEW, self.m_propsVo)
        self:close()
        return
    elseif self.m_propsVo.effectType == UseEffectType.ADD_FREE_PROPGIFT then
        GameDispatcher:dispatchEvent(EventName.OPEN_SELECTEITEMVIEW, self.m_propsVo)
        self:close()
    elseif self.m_propsVo.effectType == UseEffectType.ADD_PERMIT and permit.PermitManager:getPermitedLv() > 40 then
        if (not permit.PermitManager:getIsBuyPermit(-1)) then
            gs.Message.Show(_TT(81012))
            return
        end
        --使用类型为合约扩充凭证（通行证直升十级道具）并且等级大于40级触发判断 策划说暂时写死
        UIFactory:alertMessge(_TT(81013), true, function()
            GameDispatcher:dispatchEvent(EventName.USE_PROPS_BY_ID, { id = self.m_propsVo.id, count = self.mNumberStepper.CurrCount, targetId = 0, uicode = self.m_propsVo.uiCode, use_args = {} })
            self:close()
        end, _TT(1), nil, true, nil, _TT(2), _TT(5), nil, nil)
    elseif self.m_propsVo.effectType == UseEffectType.USE_GET_HEROEGG then
        GameDispatcher:dispatchEvent(EventName.USE_PROPS_BY_TID, { id = self.m_propsVo.tid, count = self.mNumberStepper.CurrCount, targetId = 0, uicode = self.m_propsVo.uiCode, use_args = {} })
        self:close()
    else
        GameDispatcher:dispatchEvent(EventName.USE_PROPS_BY_ID, { id = self.m_propsVo.id, count = self.mNumberStepper.CurrCount, targetId = 0, uicode = self.m_propsVo.uiCode, use_args = {} })
        self:close()
    end

end

function recoverStaminaTime(self)
    if self.timeId then
        LoopManager:removeTimerByIndex(self.timeId)
        self.timeId = nil
    end
end

-- 在资源销毁前，对需要回收的资源进行回收处理
function recover(self)
    super.recover(self)
    self:initData()
end

return _M

--[[ 替换语言包自动生成，请勿修改！
语言包: _TT(4062):"<未解锁>"
]]