module('game.equipBuild.view.EquipRemakeUpAgentOptView', Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("equipBuild/EquipRemakeUpAgentOptView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isBlur = 0 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
blurTweenTime = 0 -- 模糊背景的渐变时间（仅2弹窗面板有效，默认不渐变，单位秒）
isScreensave = 0 -- 是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)

-- 初始化数据
function initData(self)
    super.initData(self)

    self.colorItemList = {}
    self.attrItemList = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtAgentInfo = self:getChildGO("mTxtAgentInfo"):GetComponent(ty.Text)
    self.mTxtAgentTarget = self:getChildGO("mTxtAgentTarget"):GetComponent(ty.Text)
    self.mTxtAgentCurrent = self:getChildGO("mTxtAgentCurrent"):GetComponent(ty.Text)
    self.mTxtAgentTodo = self:getChildGO("mTxtAgentTodo"):GetComponent(ty.Text)
    self.mTxtAgentNext = self:getChildGO("mTxtAgentNext"):GetComponent(ty.Text)
    self.mTxtAgentTimer = self:getChildGO("mTxtAgentTimer"):GetComponent(ty.Text)

    --self.mIconTarget = self:getChildGO("mIconTarget"):GetComponent(ty.AutoRefImage)
    self.mIconCurrent = self:getChildGO("mIconCurrent"):GetComponent(ty.AutoRefImage)
    self.mIconTodo = self:getChildGO("mIconTodo"):GetComponent(ty.AutoRefImage)

    --self.mTxtAgentTargetValue = self:getChildGO("mTxtAgentTargetValue"):GetComponent(ty.Text)
    self.mTxtAgentCurrentValue = self:getChildGO("mTxtAgentCurrentValue"):GetComponent(ty.Text)
    self.mTxtAgentTodoValue = self:getChildGO("mTxtAgentTodoValue"):GetComponent(ty.Text)

    self.mImgNextBg = self:getChildGO("mImgNextBg"):GetComponent(ty.RectTransform)
    self.mImgNext = self:getChildGO("mImgNext"):GetComponent(ty.RectTransform)

    self.mBtnCancel = self:getChildGO("mBtnCancel")
    self.mTxtCancel = self:getChildGO("mTxtCancel"):GetComponent(ty.Text)

    self.mTxtTimerChange = self:getChildGO("mTxtTimerChange"):GetComponent(ty.Text)
    self.mBtnTimer = self:getChildGO("mBtnTimer")
    self.mTxtTimer = self:getChildGO("mTxtTimer"):GetComponent(ty.Text)

    self.mHasNext = self:getChildGO("mHasNext")

    self.mEffect = self:getChildGO("mEffect")

    self.mAnimator = self.UIObject:GetComponent(ty.Animator)

    self.mTxtAgentColor = self:getChildGO("mTxtAgentColor"):GetComponent(ty.Text)
    self.mAgentColorContent = self:getChildTrans("mAgentColorContent")
    self.mTargetColorItem = self:getChildGO("mTargetColorItem")

    self.mAgentTargetContent = self:getChildTrans("mAgentTargetContent")
    self.mTargetItem = self:getChildGO("mTargetItem")
end

function initViewText(self)
    self.mTxtAgentInfo.text = _TT(71453)
    self.mTxtAgentNext.text = _TT(71454)
    self.mTxtCancel.text = _TT(71455)
    self.mTxtTimerChange.text = _TT(71456)
    self.mTxtTimer.text = _TT(71457)

    self.mTxtAgentTarget.text = _TT(71458)
    self.mTxtAgentCurrent.text = _TT(71459)
    self.mTxtAgentTodo.text = _TT(71460)

    self.mTxtAgentColor.text = _TT(71473)
end

-- 激活
function active(self, args)
    super.active(self, args)
    GameDispatcher:addEventListener(EventName.UPDATE_EQUIP_REMAKE_UP_AGENT_OPT_VIEW, self.onUpdateOptInfo, self)
    self:showPanel()
end

function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_EQUIP_REMAKE_UP_AGENT_OPT_VIEW, self.onUpdateOptInfo, self)
    LoopManager:removeFrameByIndex(self.mFrameSn)
    self.mFrameSn = nil

    if self.effSn then
        self:clearTimeout(self.effSn)
        self.effSn = self:setTimeout(0.1, function()
            self.mEffect:SetActive(false)
        end)
    end

    self:clearItems()
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnCancel, self.onBtnCancel)
    self:addUIEvent(self.mBtnTimer, self.onBtnTimer)
end

function onBtnTimer(self)
    if self.frameAdd == 1 then
        self.frameAdd = 2
    else
        self.frameAdd = 1
    end
    self.mTxtTimer.text = "x" .. self.frameAdd
end

function onBtnCancel(self)
    equipBuild.EquipRemakeManager:setCurrentIsAgentOpt(false)
    if self.lastRemakeEquipVo and self.lastRemakeOldEquipVo then
        GameDispatcher:dispatchEvent(EventName.OPEN_EQUIP_REMAKESUC_PANEL, {
            oldEquipVo = self.lastRemakeOldEquipVo,
            curEquipVo = self.lastRemakeEquipVo,
            remakePos = self.lastRemakePos
        })
    end
    self.lastRemakeEquipVo = nil
    self.lastRemakeOldEquipVo = nil
    self:close()

end

function clearItems(self)
    for i = 1, #self.colorItemList, 1 do
        self.colorItemList[i]:poolRecover()
    end
    self.colorItemList = {}

    for i = 1, #self.attrItemList, 1 do
        self.attrItemList[i]:poolRecover()
    end
    self.attrItemList = {}
end

function showPanel(self)
    local needEquipVo, needPos, selectAttIdList, selectAttColorList =
        equipBuild.EquipRemakeManager:getNeedRemakeAgentInfo()

    self:clearItems()
    table.sort(selectAttColorList, function(a, b)
        return a > b
    end)
    for i = 1, #selectAttColorList, 1 do
        local item = SimpleInsItem:create(self.mTargetColorItem, self.mAgentColorContent, "mTargetColorItem")
        item:getChildGO("mIconTargetColor"):GetComponent(ty.AutoRefImage):SetImg(
            UrlManager:getPackPath(self:getIconImg(selectAttColorList[i])),false)
        item:getChildGO("mImgLine"):SetActive(i ~= #selectAttColorList)
        table.insert(self.colorItemList, item)
    end

    table.sort(selectAttIdList, function(a, b)
        return a > b
    end)
    for i = 1, #selectAttIdList do
        local item = SimpleInsItem:create(self.mTargetItem, self.mAgentTargetContent, "mTargetItem")
        item:getChildGO("mTxtAgentTargetValue"):GetComponent(ty.Text).text = fight.AttrManager:getAttName(
            selectAttIdList[i])
        item:getChildGO("mImgLine"):SetActive(i ~= #selectAttIdList)
        table.insert(self.attrItemList, item)
    end

    --local remakeVo = equipBuild.EquipRemakeManager:getRemakeAttrDataById(selectAttId)

    local propsList = equipBuild.EquipRemakeManager:getSelectPropsList()

    self.mTxtAgentTimer.text = _TT(71452, 0, #propsList)

    --local showPercent = fight.AttrManager:isPercentAttr(selectAttId)
    --local value = remakeVo.attr[selectAttColor]
    --local colorTxt = self:getColorTxt(selectAttColor)

    -- if showPercent then
    --     self.mTxtAgentTargetValue.text = fight.AttrManager:getAttName(selectAttId) .. "+" ..
    --                                          AttConst.getValueStr(selectAttId, value)
    -- else
    --     self.mTxtAgentTargetValue.text = fight.AttrManager:getAttName(selectAttId) .. "+" .. value
    -- end

    local remakePosAttrList, remakePosAttrDic = needEquipVo:getRemakeAttr()
    local currentId = 0
    local currentValue = 0
    local currentColor = 0
    for k, v in pairs(remakePosAttrDic) do
        if v.remakePos == needPos then
            currentId = v.key
            currentValue = v.value
        end
    end
    local remakeVo = equipBuild.EquipRemakeManager:getRemakeAttrDataById(currentId)
    for i = 1, #remakeVo.attr, 1 do
        if remakeVo.attr[i] == currentValue then
            currentColor = i
        end
    end
    local colorTxt = self:getColorTxt(currentColor)
    local showPercent = fight.AttrManager:isPercentAttr(currentId)
    if showPercent then
        self.mTxtAgentCurrentValue.text = fight.AttrManager:getAttName(currentId) .. "+" ..
                                              AttConst.getValueStr(currentId, currentValue)
    else
        self.mTxtAgentCurrentValue.text = fight.AttrManager:getAttName(currentId) .. "+" .. currentValue
    end

    --self.mTxtAgentTargetValue.color = gs.ColorUtil.GetColor(self:getColorString(selectAttColor))
    self.mTxtAgentCurrentValue.color = gs.ColorUtil.GetColor(self:getColorString(currentColor))

    --self.mIconTarget:SetImg(UrlManager:getPackPath(self:getIconImg(selectAttColor)), false)
    self.mIconCurrent:SetImg(UrlManager:getPackPath(self:getIconImg(currentColor)), false)

    self.mTxtAgentTodo.text = ""
    self.mTxtAgentTodo.gameObject:SetActive(false)
    self.mHasNext:SetActive(false)

    self.curTimer = 1
    self.curFrame = 0
    self.needFrame = 120
    self.frameAdd = 1
    self.canReq = true
    self.mFrameSn = LoopManager:addFrame(1, 0, self, self.onFrameChange)
end

function getIconImg(self, color)
    return "chip/mozu_icon_0" .. (4 + color) .. ".png"
end

function getColorString(self, color)
    local c = "ffffffff"
    if color == 1 then
        c = "45cea2ff"
    elseif color == 2 then
        c = "2e95ffff"
    elseif color == 3 then
        c = "ff72f1ff"
    elseif color == 4 then
        c = "ffb645ff"
    end
    return c
end

function onUpdateOptInfo(self, args)

    self.mAnimator:SetTrigger("show")

    self.lastRemakeEquipVo = args.curEquipVo
    self.lastRemakePos = args.remakePos
    self.lastRemakeOldEquipVo = args.oldEquipVo
    local remakePosAttrList, remakePosAttrDic = args.curEquipVo:getRemakeAttr()
    local attrData = remakePosAttrDic[args.remakePos]

    local key = attrData.key
    local value = attrData.value

    local currentColor = 0

    local remakeVo = equipBuild.EquipRemakeManager:getRemakeAttrDataById(key)
    for i = 1, #remakeVo.attr, 1 do
        if remakeVo.attr[i] == value then
            currentColor = i
        end
    end
    local colorTxt = self:getColorTxt(currentColor)
    local showPercent = fight.AttrManager:isPercentAttr(key)

    if showPercent then
        self.mTxtAgentTodoValue.text = fight.AttrManager:getAttName(key) .. "+" .. AttConst.getValueStr(key, value)
    else
        self.mTxtAgentTodoValue.text = fight.AttrManager:getAttName(key) .. "+" .. value
    end

    self.mTxtAgentTodo.gameObject:SetActive(true)
    self.mHasNext:SetActive(true)

    self.mTxtAgentTodoValue.color = gs.ColorUtil.GetColor(self:getColorString(currentColor))
    self.mIconTodo:SetImg(UrlManager:getPackPath(self:getIconImg(currentColor)), false)

    self.curTimer = self.curTimer + 1
    local propsList = equipBuild.EquipRemakeManager:getSelectPropsList()
    self.mTxtAgentTimer.text = _TT(71452, self.curTimer - 1, #propsList)

    if self:isRemakeUpFinish() then
        equipBuild.EquipRemakeManager:setAgentSuc(true)
        gs.Message.Show(_TT(71461))
        self:onBtnCancel()
        GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_CONFIRM_REMAKE, {})
        return
    end

    if self.curTimer >= #propsList + 1 then
        gs.Message.Show(_TT(71462))
        self:onBtnCancel()
        -- return
    end

    self.curFrame = 0
    self.canReq = true
end

function isRemakeUpFinish(self)
    local remakePosAttrList, remakePosAttrDic = self.lastRemakeEquipVo:getRemakeAttr()
    local attrData = remakePosAttrDic[self.lastRemakePos]
    local needEquipVo, needPos, selectAttId, selectAttColor = equipBuild.EquipRemakeManager:getNeedRemakeAgentInfo()
    local key = attrData.key
    local value = attrData.value

    local currentColor = 0
    local remakeVo = equipBuild.EquipRemakeManager:getRemakeAttrDataById(key)
    for i = 1, #remakeVo.attr, 1 do
        if remakeVo.attr[i] == value then
            currentColor = i
        end
    end

    local hasVale = table.indexof01(selectAttId,key)>0
    local minColor = 5
    for i = 1, #selectAttColor, 1 do
        if selectAttColor[i] < minColor then
            minColor = selectAttColor[i]
        end
    end

    if hasVale and currentColor >= minColor then
        return true
    end
    return false
end

function onFrameChange(self)
    if self.curFrame < self.needFrame then
        self.curFrame = self.curFrame + self.frameAdd
        gs.TransQuick:SizeDelta01(self.mImgNext, self.mImgNextBg.sizeDelta.x * self.curFrame / self.needFrame)
    else
        gs.TransQuick:SizeDelta01(self.mImgNext, self.mImgNextBg.sizeDelta.x * 1)

        if self.canReq == true then
            self:onReqReamkeHander()
        end

        -- self.curFrame = 0
    end
end

function onReqReamkeHander(self)
    self.mEffect:SetActive(true)

    if self.effSn then
        self:clearTimeout(self.effSn)
        self.effSn = nil
    end

    self.effSn = self:setTimeout(0.6, function()
        self.mEffect:SetActive(false)
    end)

    local needEquipVo, needPos, selectAttId, selectAttColor = equipBuild.EquipRemakeManager:getNeedRemakeAgentInfo()
    local propsList = equipBuild.EquipRemakeManager:getSelectPropsList()

    local costVo = propsList[self.curTimer]
    equipBuild.EquipRemakeManager:setCurrentIsAgentOpt(true)
    self.canReq = false
    GameDispatcher:dispatchEvent(EventName.REQ_EQUIP_REMAKE, {
        heroId = needEquipVo.heroId,
        equipId = needEquipVo.id,
        remakePos = needPos,
        costId = costVo.id
    })
end

function getColorTxt(self, id)
    local colorTxt = ""
    if id == 1 then
        colorTxt = "B"
    elseif id == 2 then
        colorTxt = "A"
    elseif id == 3 then
        colorTxt = "S"
    elseif id == 4 then
        colorTxt = "S+"
    end
    return colorTxt
end

return _M
