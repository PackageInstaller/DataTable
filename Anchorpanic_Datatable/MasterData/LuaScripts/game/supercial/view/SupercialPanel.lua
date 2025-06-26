-- 海底主界面
module("supercial.SupercialPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("supercial/SupercialPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)

    self.mRewardItems = {}
    self.mPropsItems = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mBtnClose = self:getChildGO("mBtnClose")

    self.mTxtTips = self:getChildGO("mTxtTips"):GetComponent(ty.Text)
    self.mTxtPower = self:getChildGO("mTxtPower"):GetComponent(ty.Text)

    self.mTxtRemTime = self:getChildGO("mTxtRemTime"):GetComponent(ty.Text)
    self.mSupercialScroll = self:getChildGO("mSupercialScroll"):GetComponent(ty.ScrollRect)

    self.mRewardItem = self:getChildGO("mRewardItem")
end

-- 激活
function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_SUPERCIAL_PANEL, self.showPanel, self)
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_SUPERCIAL_PANEL, self.showPanel, self)
    self:clearPropsItems()
    self:clearRewardItems()

    if self.updateTimeSn then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
    end
end

function initViewText(self)
    self.mTxtPower.text = _TT(138002)
    self.mTxtTips.text = _TT(138003)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnClose, self.close)
end

function otherIsGeted(self,id)
    local childValue = self:getIdIsChildValue(id)
    local isPass = supercial.SupercialManager:getSupercialIsBuy(childValue)
    return isPass
end

function getIdIsHasChild(self,id)
    for k, v in pairs(self.otherIds) do
        if v.child1Id == id then
            return v.child2Id
        end
    end
    return 0
end

function getIdIsChild(self,id)
    for k, v in pairs(self.otherIds) do
        if v.child2Id == id then
            return v.child1Id
        end
    end
    return 0
end

function getIdIsChildValue(self,id)
    for k, v in pairs(self.otherIds) do
        if v.child2Id == id then
            return v.child1Id
        end
        if v.child1Id == id then
            return v.child2Id
        end
    end
    return 0
end

function getChildVo(self,id)
    local childId = self:getIdIsHasChild(id)
    local allVoList = supercial.SupercialManager:getSupercialData()
    if childId > 0 then
        for i = 1,#allVoList do
            if childId == allVoList[i].id then
                return allVoList[i]
            end
        end
    end
    return nil
end

function getChildCount(self,id)
    local childCount = 0
    for k, v in pairs(self.otherIds) do
        if v.child1Id <= id then
            childCount = childCount + 1
        end
    end
    return childCount
end

function showPanel(self)
    local prefixVersion = download.ResDownLoadManager:getServerVersionValue(gs.AssetSetting.PrefixVersionKey)
    if not StorageUtil:getBool1(prefixVersion .. "supercial") then
        StorageUtil:saveBool1(prefixVersion .. "supercial", true)
        supercial.SupercialManager:updateRed()
    end

    --local voList = supercial.SupercialManager:getSupercialData()
    local allVoList = supercial.SupercialManager:getSupercialData()

    local maxId = supercial.SupercialManager:getCurMaxId()

    self:clearPropsItems()
    self:clearRewardItems()

    local singleGift = {}
    self.otherIds = {}
    for i = 1, #allVoList do
        if #allVoList[i].postId > 1 then
            table.insert(self.otherIds, {
                child1Id = allVoList[i].postId[1],
                child2Id = allVoList[i].postId[2]
            })
        end
    end

    local voList = {}
    for i = 1,#allVoList do
        if self:getIdIsChild(allVoList[i].id) == 0 then
            table.insert(voList, allVoList[i])
        end
    end

    for i = 1, #voList do
        local item = SimpleInsItem:create(self.mRewardItem, self.mSupercialScroll.content, "mSupercialItem")
        local hasChild = self:getIdIsHasChild(voList[i].id)
        item:getChildGO("type1"):SetActive(hasChild == 0)
        item:getChildGO("type2"):SetActive(hasChild ~= 0)
 
        local isLast = voList[i].id == #allVoList
        local type1 = #voList[i].postId == 1 and hasChild == 0
        item:getChildGO("mArrowType1"):SetActive(type1 and isLast == false)
        item:getChildGO("mArrowType2"):SetActive(not type1 and isLast == false)

        if hasChild == 0 then
            item:getChildGO("mTxtRewardTitle"):GetComponent(ty.Text).text = _TT(voList[i].name)-- _TT(138004) .. voList[i].id

           
            item:getChildGO("mIsCur"):SetActive(voList[i].id == maxId)
    
            local isPass = supercial.SupercialManager:getSupercialIsBuy(voList[i].id)
            item:getChildGO("mBtnGeted"):SetActive(isPass)

            --local isOtherGeted = self:otherIsGeted(voList[i].id)
           
    
            local isLock = voList[i].id > maxId
            item:getChildGO("mIsLock"):SetActive(isLock)
    
            local isRmb = voList[i].price > 0
    
            item:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(
                "supercial/supercial_type" .. voList[i].type .. ".png", false))
    
            item:getChildGO("mBtnGet"):GetComponent(ty.AutoRefImage):SetImg(isRmb and
                                                                                UrlManager:getPackPath("supercial/btn_2.png") or
                                                                                UrlManager:getPackPath("supercial/btn_1.png"))
    
            item:getChildGO("mTxtInfo"):GetComponent(ty.Text).color =
                isRmb and gs.ColorUtil.GetColor("FFFFFFFF") or gs.ColorUtil.GetColor("202226ff")
    
            item:getChildGO("mIsLock"):GetComponent(ty.Image).color =
                isRmb and gs.ColorUtil.GetColor("FFFFFFFF") or gs.ColorUtil.GetColor("202226ff")
    
            if isRmb then
                item:getChildGO("mTxtInfo"):GetComponent(ty.Text).text = "¥" .. voList[i].price
            else
                item:getChildGO("mTxtInfo"):GetComponent(ty.Text).text = _TT(151)
            end
    
            local propsList = AwardPackManager:getAwardListById(voList[i].showDropid)
            if #propsList < 2 then
                for k, v in pairs(propsList) do
                    local propsGrid = PropsGrid:createByData({
                        tid = v.tid,
                        num = v.num,
                        parent = item:getChildTrans("mPropContent"),
                        scale = 0.85,
                        showUseInTip = true
                    })
                    table.insert(self.mPropsItems, propsGrid)
                end
            else
                for i = 1, #propsList do
                    local propsGrid = PropsGrid:createByData({
                        tid = propsList[i].tid,
                        num = propsList[i].num,
                        parent = item:getChildTrans("pos" .. i),
                        scale = 0.85,
                        showUseInTip = true
                    })
                    table.insert(self.mPropsItems, propsGrid)
                end
            end
    
            item:addUIEvent("mBtnGet", function()
                if maxId < voList[i].id then
                    gs.Message.Show(_TT(138005))
                    return
                end
 
                if voList[i].price > 0 then
                    recharge.sendRecharge(recharge.RechargeType.SUPERCIAL, nil, voList[i].id)
                else
                    GameDispatcher:dispatchEvent(EventName.REQ_GET_SUPERCIAL_AWARD, {
                        id = voList[i].id
                    })
                end
            end)
    
            local redTran = item:getChildTrans("mBtnGet")
    
            item:getChildGO("mEffGlow"):SetActive(false)
            if supercial.SupercialManager:getIdIsRed(voList[i].id) and maxId == voList[i].id then
                item:getChildGO("mEffGlow"):SetActive(true)
                RedPointManager:add(redTran, nil, 96, 14)
            else
                RedPointManager:remove(redTran, nil, 0, 0)
            end
    
            item:addUIEvent("mBtnGeted", function()
                gs.Message.Show(_TT(411))
            end)
        else
          
            --local child1Vo = 
            item:getChildGO("mTxtRewardTitleChild1"):GetComponent(ty.Text).text = _TT(voList[i].name) --_TT(138004) .. voList[i].id
            item:getChildGO("mIsCurChild1"):SetActive(voList[i].id == maxId - 1)
    
            local isPass = supercial.SupercialManager:getSupercialIsBuy(voList[i].id)
            local isOtherGeted = self:otherIsGeted(voList[i].id)
            item:getChildGO("mBtnGetedChild1"):SetActive(isPass or isOtherGeted )
            
           
            local text = item:getChildGO("mTxtGetedChild1"):GetComponent(ty.Text)
            if isOtherGeted then
                text.text = _TT(138018)
            else
                text.text = _TT(411)
            end

            local isLock = voList[i].id > maxId
            item:getChildGO("mIsLockChild1"):SetActive(isLock)
    
            local isRmb = voList[i].price > 0
    
            item:getChildGO("mImgBgChild1"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(
                "supercial/supercial_type_mini" .. voList[i].type .. ".png", false))
    
            item:getChildGO("mBtnGetChild1"):GetComponent(ty.AutoRefImage):SetImg(isRmb and
                                                                                UrlManager:getPackPath("supercial/btn_min_2.png") or
                                                                                UrlManager:getPackPath("supercial/btn_min_1.png"),false)
    
            item:getChildGO("mTxtInfoChild1"):GetComponent(ty.Text).color =
                isRmb and gs.ColorUtil.GetColor("FFFFFFFF") or gs.ColorUtil.GetColor("202226ff")
    
            item:getChildGO("mIsLockChild1"):GetComponent(ty.Image).color =
                isRmb and gs.ColorUtil.GetColor("FFFFFFFF") or gs.ColorUtil.GetColor("202226ff")
    
            if isRmb then
                item:getChildGO("mTxtInfoChild1"):GetComponent(ty.Text).text = "¥" .. voList[i].price
            else
                item:getChildGO("mTxtInfoChild1"):GetComponent(ty.Text).text = _TT(151)
            end
    
            local propsList = AwardPackManager:getAwardListById(voList[i].showDropid)

                for k, v in pairs(propsList) do
                    local propsGrid = PropsGrid:createByData({
                        tid = v.tid,
                        num = v.num,
                        parent = item:getChildTrans("mPropContentChild1"),
                        scale = 0.4,
                        showUseInTip = true
                    })
                    table.insert(self.mPropsItems, propsGrid)
                end
          
    
            item:addUIEvent("mBtnGetChild1", function()
                if maxId < voList[i].id then
                    gs.Message.Show(_TT(138005))
                    return
                end

                if maxId ~= voList[i].id + 1 then
                    gs.Message.Show(_TT(138019))
                    return
                end
    
    
                if voList[i].price > 0 then
                    recharge.sendRecharge(recharge.RechargeType.SUPERCIAL, nil, voList[i].id)
                else
                    GameDispatcher:dispatchEvent(EventName.REQ_GET_SUPERCIAL_AWARD, {
                        id = voList[i].id
                    })
                end
            end)
    
            local redTran = item:getChildTrans("mBtnGetChild1")
    
            item:getChildGO("mEffGlowChild1"):SetActive(false)
            if supercial.SupercialManager:getIdIsRed(voList[i].id) and maxId -1 == voList[i].id then
                item:getChildGO("mEffGlowChild1"):SetActive(true)
                RedPointManager:add(redTran, nil, 96, 14)
            else
                RedPointManager:remove(redTran, nil, 0, 0)
            end
    
            item:addUIEvent("mBtnGetedChild1", function()
                gs.Message.Show(_TT(411))
            end)

            --child2
            local child2Vo = self:getChildVo(voList[i].id)
            item:getChildGO("mTxtRewardTitleChild2"):GetComponent(ty.Text).text = _TT(child2Vo.name)
            item:getChildGO("mIsCurChild2"):SetActive(child2Vo.id == maxId)
    
            local isPass = supercial.SupercialManager:getSupercialIsBuy(child2Vo.id)
            local isOtherGeted = self:otherIsGeted(child2Vo.id)
            item:getChildGO("mBtnGetedChild2"):SetActive(isPass or isOtherGeted)
    
            
            local text = item:getChildGO("mTxtGetedChild2"):GetComponent(ty.Text)
            if isOtherGeted then
                text.text = _TT(138018)
            else
                text.text = _TT(411)
            end

            local isLock = child2Vo.id > maxId
            item:getChildGO("mIsLockChild2"):SetActive(isLock)
    
            local isRmb = child2Vo.price > 0
    
            item:getChildGO("mImgBgChild2"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath(
                "supercial/supercial_type_mini" .. child2Vo.type .. ".png", false))
    
            item:getChildGO("mBtnGetChild2"):GetComponent(ty.AutoRefImage):SetImg(isRmb and
                                                                                UrlManager:getPackPath("supercial/btn_min_2.png") or
                                                                                UrlManager:getPackPath("supercial/btn_min_1.png"),false)
    
            item:getChildGO("mTxtInfoChild2"):GetComponent(ty.Text).color =
                isRmb and gs.ColorUtil.GetColor("FFFFFFFF") or gs.ColorUtil.GetColor("202226ff")
    
            item:getChildGO("mIsLockChild2"):GetComponent(ty.Image).color =
                isRmb and gs.ColorUtil.GetColor("FFFFFFFF") or gs.ColorUtil.GetColor("202226ff")
    
            if isRmb then
                item:getChildGO("mTxtInfoChild2"):GetComponent(ty.Text).text = "¥" .. child2Vo.price
            else
                item:getChildGO("mTxtInfoChild2"):GetComponent(ty.Text).text = _TT(151)
            end
    
            local propsList = AwardPackManager:getAwardListById(child2Vo.showDropid)

                for k, v in pairs(propsList) do
                    local propsGrid = PropsGrid:createByData({
                        tid = v.tid,
                        num = v.num,
                        parent = item:getChildTrans("mPropContentChild2"),
                        scale = 0.4,
                        showUseInTip = true
                    })
                    table.insert(self.mPropsItems, propsGrid)
                end
          
    
            item:addUIEvent("mBtnGetChild2", function()
                if maxId < child2Vo.id then
                    gs.Message.Show(_TT(138005))
                    return
                end

                if maxId ~= child2Vo.id then
                    gs.Message.Show(_TT(138019))
                    return
                end
    
                if child2Vo.price > 0 then
                    recharge.sendRecharge(recharge.RechargeType.SUPERCIAL, nil, child2Vo.id)
                else
                    GameDispatcher:dispatchEvent(EventName.REQ_GET_SUPERCIAL_AWARD, {
                        id = child2Vo.id
                    })
                end
            end)
    
            local redTran = item:getChildTrans("mBtnGetChild2")
    
            item:getChildGO("mEffGlowChild2"):SetActive(false)
            if supercial.SupercialManager:getIdIsRed(child2Vo.id) and maxId == child2Vo.id then
                item:getChildGO("mEffGlowChild2"):SetActive(true)
                RedPointManager:add(redTran, nil, 96, 14)
            else
                RedPointManager:remove(redTran, nil, 0, 0)
            end
    
            item:addUIEvent("mBtnGetedChild2", function()
                gs.Message.Show(_TT(411))
            end)
        end
       

        -- mTxtInfo
        table.insert(self.mRewardItems, item)
    end

    local childCount = self:getChildCount(maxId)
    gs.TransQuick:UIPosX(self.mSupercialScroll.content, gs.Mathf.Clamp(-308 * (maxId -childCount- 2), -2053, 0))
    if self.updateTimeSn then
        LoopManager:removeTimerByIndex(self.updateTimeSn)
        self.updateTimeSn = nil
    end

    self:updateTime()
    self.updateTimeSn = LoopManager:addTimer(1, 0, self, self.updateTime)
end

function updateTime(self)
    if activity.ActivityManager:getActivityVoById(activity.ActivityId.Supercial) then
        local clientTime = GameManager:getClientTime()
        local remainingTime = activity.ActivityManager:getActivityVoById(activity.ActivityId.Supercial):getEndTime() -
                                  clientTime
        local timeTxt = remainingTime <= 0 and "活动已结束" or _TT(3530) ..
                            HtmlUtil:colorAndSize(TimeUtil.getFormatTimeBySeconds_9(remainingTime), "FFFFFFFF", 22)
        self.mTxtRemTime.text = timeTxt

        if remainingTime <= 0 then
            LoopManager:removeTimerByIndex(self.updateTimeSn)
            self.updateTimeSn = nil
            self:close()
            return
        end
    end
end

function clearPropsItems(self)
    for i = 1, #self.mPropsItems do
        self.mPropsItems[i]:poolRecover()
    end
    self.mPropsItems = {}
end

function clearRewardItems(self)
    for i = 1, #self.mRewardItems do
        self.mRewardItems[i]:poolRecover()
    end
    self.mRewardItems = {}
end

return _M
